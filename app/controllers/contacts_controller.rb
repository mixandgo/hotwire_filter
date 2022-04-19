class ContactsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_contact, only: %i[ show edit update destroy ]

  def index
    @contacts = Contact.where("name LIKE ?", "%#{params[:filter]}%").all
  end

  def show; end

  def new
    @contact = Contact.new
  end

  def edit; end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash.now[:notice] = "Contact was successfully created."
      render turbo_stream: [
        turbo_stream.prepend("contacts", @contact),
        turbo_stream.replace(
          "form_contact",
          partial: "form",
          locals: { contact: Contact.new }
        ),
        turbo_stream.replace("notice", partial: "layouts/flash")
      ]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      flash.now[:notice] = "Contact was successfully updated."
      render turbo_stream: [
        turbo_stream.replace(@contact, @contact),
        turbo_stream.replace("notice", partial: "layouts/flash")
      ]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    flash.now[:notice] = "Contact was successfully destroyed."
    render turbo_stream: [
      turbo_stream.remove(@contact),
      turbo_stream.replace("notice", partial: "layouts/flash")
    ]
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :age, :dob, :notes)
    end
end
