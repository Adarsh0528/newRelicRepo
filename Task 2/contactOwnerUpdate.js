import { LightningElement, api, wire, track } from 'lwc';
import getContactsList from '@salesforce/apex/contactOwnerUpdateHelper.getContactsList';
import updateContacts from '@salesforce/apex/contactOwnerUpdateHelper.updateContacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactOwnerUpdate extends LightningElement {

    @track columns = [

        {
            label: 'Name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        }, {
            label: 'Mailing Country',
            fieldName: 'MailingCountry',
            type: 'text',
            sortable: true
        },
        {
            label: 'Owner',
            fieldName: 'ContactOwner',
            type: 'text',
            sortable: true
        }
    ];

    @track error;
    @track contactsList;
    isLoaded = false;
    accountDetails;
    selectedRows;
    @api recordId;
    @track contactIds = [];
    isLoading = false;
    @wire(getContactsList, { accountId: '$recordId' })
    getContactsList({
        error,
        data
    }) {
        if (data) {
            let currentData = [];
            data.forEach((row) => {
                let rowData = {};
                rowData.Name = row.Name;
                if (row.Owner) {
                    rowData.ContactOwner = row.Owner.Name;
                }
                rowData.Id = row.Id;
                rowData.MailingCountry = row.MailingCountry;
                currentData.push(rowData);
            });

            this.contactsList = currentData;
            console.log('ContactsList' + JSON.stringify(this.contactsList));
        } else if (error) {
            this.error = error;
        }
    }
    handleRowSelection = event => {

        this.selectedRows = event.detail.selectedRows;
    }
    handleOwnerUpdate(event) {
        this.isLoading = true;
        updateContacts({ selectedContacts: JSON.stringify(this.selectedRows) })
            .then(result => {
                    this.isLoading = false;
                    const evt = new ShowToastEvent({
                        title: 'Success!!',
                        message: 'Contacts Updated Successfully',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                this.selectedRows = null;
                
            })
            .catch(error => {
                this.error = error;

            });
    }


}