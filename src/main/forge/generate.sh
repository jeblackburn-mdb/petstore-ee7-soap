#  ##############  #
#  Install Addons  #
#  ##############  #
#  If the following plugins are not installed
#  addon-install-from-git --url https://github.com/forge/addon-arquillian.git --coordinate org.arquillian.forge:arquillian-addon



#  #####################  #
#  Creates a new project  #
#  #####################  #

project-new --named agoncal-application-petstore-ee7 --topLevelPackage com.mongodb.modfac.petstore --type war --finalName applicationPetstore --version 7.0 ;


#  Setup the deployment descriptors to Java EE 7
#  ############
jpa-setup --persistenceUnitName applicationPetstorePU --jpaVersion 2.1 ;
cdi-setup --cdiVersion 1.1 ;
ejb-setup --ejbVersion 3.2 ;
faces-setup --facesVersion 2.2 ;
servlet-setup --servletVersion 3.1 ;
rest-setup --jaxrsVersion 2.0 ;

#  Setup Arquillian
#  ############
arquillian-setup --arquillianVersion 1.1.8.Final --testFramework junit --testFrameworkVersion 4.12 --containerAdapter wildfly-remote --containerAdapterVersion 8.2.0.Final ;



#  ###################  #
#  Creates constraints  #
#  ###################  #

constraint-new-annotation --named Email ;
constraint-new-annotation --named Login ;
constraint-new-annotation --named NotEmpty ;
constraint-new-annotation --named Price ;



#  ########################  #
#  Creates the domain model  #
#  ########################  #

#  TODO Command java-new-package-info to create a new package-info.java class [FORGE-2071]
#  Package Vetoed
#  ############
java-new-package --named com.mongodb.modfac.petstore.model --createPackageInfo ;
# java-add-annotation --annotation javax.enterprie.inject.Vetoed --targetClass com.mongodb.modfac.petstore.model.package-info ;


#  User role enumeration
#  ############
java-new-enum --named UserRole --targetPackage ~.model ;
java-new-enum-const USER ;
java-new-enum-const ADMIN ;


#  Country entity
#  ############
jpa-new-entity --named Country ;
jpa-new-field --named isoCode --length 2 --columnName iso_code --not-nullable ;
jpa-new-field --named name --length 80 --not-nullable ;
jpa-new-field --named printableName --length 80 --columnName printable_name --not-nullable ;
jpa-new-field --named iso3 --length 3 ;
jpa-new-field --named numcode --length 3 ;
# Constraints
constraint-add --onProperty isoCode --constraint NotNull ;
constraint-add --onProperty isoCode --constraint Size --min 2 --max 2 ;
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 2 --max 80 ;
constraint-add --onProperty printableName --constraint NotNull ;
constraint-add --onProperty printableName --constraint Size --min 2 --max 80 ;
constraint-add --onProperty iso3 --constraint NotNull ;
constraint-add --onProperty iso3 --constraint Size --min 3 --max 3 ;
constraint-add --onProperty numcode --constraint NotNull ;
constraint-add --onProperty numcode --constraint Size --min 3 --max 3 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Address embeddable
#  ############
jpa-new-embeddable --named Address ;
jpa-new-field --named street1 --length 50 --not-nullable ;
jpa-new-field --named street2 ;
jpa-new-field --named city  --length 50 --not-nullable ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --columnName zip_code --length 10 --not-nullable ;
# Relationships
jpa-new-field --named country --type com.mongodb.modfac.petstore.model.Country --relationshipType Many-to-One --cascadeType PERSIST ;
# Constraints
constraint-add --onProperty street1 --constraint Size --min 5 --max 50 ;
constraint-add --onProperty street1 --constraint NotNull ;
constraint-add --onProperty city --constraint Size --min 2 --max 50 ;
constraint-add --onProperty city --constraint NotNull ;
constraint-add --onProperty zipcode --constraint Size --min 1 --max 10 ;
constraint-add --onProperty zipcode --constraint NotNull ;


#  Customer entity
#  ############
jpa-new-entity --named Customer ;
jpa-new-field --named firstName --length 50 --columnName first_name --not-nullable ;
jpa-new-field --named lastName --length 50 --columnName last_name --not-nullable ;
jpa-new-field --named telephone ;
jpa-new-field --named email ;
jpa-new-field --named login --length 10 --not-nullable ;
jpa-new-field --named password --length 256 --not-nullable ;
jpa-new-field --named uuid --length 256 ;
jpa-new-field --named UserRole --type ~.model.UserRole --columnName user_role ;
jpa-new-field --named dateOfBirth --type java.util.Date --temporalType DATE --columnName date_of_birth ;
jpa-new-field --named age --type java.lang.Integer --transient ;
# Address embeddable
jpa-new-field --named street1 --length 50 ;
jpa-new-field --named street2 ;
jpa-new-field --named city --length 50 ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --columnName zip_code --length 10 ;
# Relationships
jpa-new-field --named country --type com.mongodb.modfac.petstore.model.Country --relationshipType Many-to-One ;
# Constraints
# TODO constraint-add --onProperty login --constraint Login ;
constraint-add --onProperty password --constraint NotNull ;
constraint-add --onProperty password --constraint Size --min 1 --max 256 ;
constraint-add --onProperty firstName --constraint NotNull ;
constraint-add --onProperty firstName --constraint Size --min 2 --max 50 ;
constraint-add --onProperty lastName --constraint NotNull ;
constraint-add --onProperty lastName --constraint Size --min 2 --max 50 ;
constraint-add --onProperty dateOfBirth --constraint Past ;


#  Category entity
#  ############
jpa-new-entity  --named Category ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
# Constraints
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 1 --max 30 ;
constraint-add --onProperty description --constraint NotNull ;
constraint-add --onProperty description --constraint Size --max 3000 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Product entity
#  ############
jpa-new-entity --named Product ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
# Relationships
jpa-new-field --named category --type com.mongodb.modfac.petstore.model.Category --relationshipType Many-to-One --cascadeType PERSIST ;
# Constraints
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 1 --max 30 ;
constraint-add --onProperty description --constraint NotNull ;
constraint-add --onProperty description --constraint Size --max 3000 ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  Item entity
#  ############
jpa-new-entity --named Item ;
jpa-new-field --named name --length 30 --not-nullable ;
jpa-new-field --named description --length 3000 --not-nullable ;
jpa-new-field --named imagePath --columnName image_path ;
jpa-new-field --named unitCost --type java.lang.Float --columnName unit_cost --not-nullable ;
# Relationships
jpa-new-field --named product --type com.mongodb.modfac.petstore.model.Product --relationshipType Many-to-One --cascadeType PERSIST ;
# Constraints
constraint-add --onProperty name --constraint NotNull ;
constraint-add --onProperty name --constraint Size --min 1 --max 30 ;
constraint-add --onProperty description --constraint NotNull ;
constraint-add --onProperty description --constraint Size --max 3000 ;
constraint-add --onProperty unitCost --constraint NotNull ;
# TODO constraint-add --onProperty unitCost --constraint Price ;
# TODO constraint-add --onProperty imagePath --constraint NotEmpty ;
# Cache
java-add-annotation --annotation javax.persistence.Cacheable ;


#  CreditCardType enumeration
#  ############
java-new-enum --named CreditCardType --targetPackage com.mongodb.modfac.petstore.model ;
java-new-enum-const VISA ;
java-new-enum-const MASTER_CARD ;
java-new-enum-const AMERICAN_EXPRESS ;

java-new-class --named CreditCardConverter --targetPackage com.mongodb.modfac.petstore.model ;


# CreditCard embeddable
# ############
jpa-new-embeddable --named CreditCard ;
jpa-new-field --named creditCardNumber --columnName credit_card_number --length 30 --not-nullable ;
jpa-new-field --named creditCardType --type com.mongodb.modfac.petstore.model.CreditCardType --columnName credit_card_type ;
jpa-new-field --named creditCardExpDate --columnName credit_card_expiry_date --length 5 --not-nullable ;
# Constraints
constraint-add --onProperty creditCardNumber --constraint NotNull ;
constraint-add --onProperty creditCardNumber --constraint Size --min 1 --max 30 ;
constraint-add --onProperty creditCardType --constraint NotNull ;
constraint-add --onProperty creditCardExpDate --constraint NotNull ;
constraint-add --onProperty creditCardExpDate --constraint Size --min 1 --max 5 ;


#  OrderLine entity
#  ############
jpa-new-entity --named OrderLine --tableName order_line ;
jpa-new-field --named quantity --type java.lang.Integer --not-nullable;
# Relationships
jpa-new-field --named item --type com.mongodb.modfac.petstore.model.Item --relationshipType Many-to-One --cascadeType PERSIST ;
# Constraints
constraint-add --onProperty quantity --constraint Min --value 1 ;


#  PurchaseOrder entity
#  ############
jpa-new-entity --named PurchaseOrder --tableName purchase_order ;
jpa-new-field --named orderDate --type java.util.Date --temporalType DATE --columnName order_date --not-updatable ;
jpa-new-field --named totalWithoutVat --type java.lang.Float ;
jpa-new-field --named vatRate --type java.lang.Float --columnName vat_rate ;
jpa-new-field --named vat --type java.lang.Float ;
jpa-new-field --named totalWithVat --type java.lang.Float ;
jpa-new-field --named discountRate --type java.lang.Float --columnName discount_rate ;
jpa-new-field --named discount --type java.lang.Float ;
jpa-new-field --named total --type java.lang.Float ;
# Address embeddable
jpa-new-field --named street1 --length 50 ;
jpa-new-field --named street2 ;
jpa-new-field --named city --length 50 ;
jpa-new-field --named state ;
jpa-new-field --named zipcode --columnName zip_code --length 10 ;
# Relationships
jpa-new-field --named country --type com.mongodb.modfac.petstore.model.Country --relationshipType Many-to-One ;
# Credit card embeddable
jpa-new-field --named creditCardNumber --columnName credit_card_number ;
jpa-new-field --named creditCardType --type com.mongodb.modfac.petstore.model.CreditCardType --columnName credit_card_type ;
jpa-new-field --named creditCardExpDate --columnName credit_card_expiry_date  ;
# Relationships
jpa-new-field --named customer --type com.mongodb.modfac.petstore.model.Customer --relationshipType Many-to-One ;
jpa-new-field --named orderLines --type com.mongodb.modfac.petstore.model.OrderLine --relationshipType One-to-Many ;
# Constraints
constraint-add --constraint NotNull --onProperty street1 ;
constraint-add --constraint Size --min 5 --max 50 --onProperty street1 ;
constraint-add --constraint NotNull --onProperty city ;
constraint-add --constraint Size --min 5 --max 50 --onProperty city ;
constraint-add --constraint NotNull --onProperty zipcode ;
constraint-add --constraint Size --min 1 --max 10 --onProperty zipcode ;
constraint-add --constraint NotNull --onProperty creditCardNumber ;
constraint-add --constraint Size --min 1 --max 30 --onProperty creditCardNumber ;
constraint-add --constraint NotNull --onProperty creditCardType ;
constraint-add --constraint NotNull --onProperty creditCardExpDate ;
constraint-add --constraint Size --min 5 --max 5 --onProperty creditCardExpDate ;



#  #######################  #
#  Creates utility classes  #
#  #######################  #

java-new-exception --named ValidationException --targetPackage com.mongodb.modfac.petstore.exceptions ;
java-new-class --named LoginContextProducer --targetPackage com.mongodb.modfac.petstore.security ;
java-new-class --named SimpleCallbackHandler --targetPackage com.mongodb.modfac.petstore.security ;
java-new-class --named SimpleLoginModule --targetPackage com.mongodb.modfac.petstore.security ;

#  Config producer
#  ############
cdi-new-qualifier --named ConfigProperty --targetPackage com.mongodb.modfac.petstore.util ;
java-new-class --named ConfigPropertyProducer --targetPackage com.mongodb.modfac.petstore.util ;

#  DatabaseProducer
#  ############
java-new-class --named DatabaseProducer --targetPackage com.mongodb.modfac.petstore.util ;
java-new-field --named em --type javax.persistence.EntityManager --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty em ;
java-add-annotation --annotation javax.persistence.PersistenceContext --onProperty em ;

#  Logging Interceptor
#  ############
cdi-new-interceptor-binding --named Loggable --targetPackage com.mongodb.modfac.petstore.util ;
cdi-new-interceptor --named LoggingInterceptor --interceptorBinding com.mongodb.modfac.petstore.util.Loggable --targetPackage com.mongodb.modfac.petstore.util ;
java-new-field --named logger --type org.apache.logging.log4j.Logger --generateGetter=false --generateSetter=false --updateToString=false --updateToString=false ;
java-add-annotation --annotation javax.inject.Inject --onProperty logger ;

#  Logging Producer
#  ############
java-new-class --named LoggingProducer --targetPackage com.mongodb.modfac.petstore.util ;

#  Number producer
#  ############
cdi-new-qualifier --named Vat --targetPackage com.mongodb.modfac.petstore.util ;
cdi-new-qualifier --named Discount --targetPackage com.mongodb.modfac.petstore.util ;
java-new-class --named NumberProducer --targetPackage com.mongodb.modfac.petstore.util ;

java-new-field --named vatRate --type java.lang.Float --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty vatRate ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Vat --onProperty vatRate ;
java-add-annotation --annotation javax.inject.Named --onProperty vatRate ;

java-new-field --named discountRate --type java.lang.Float --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty discountRate ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Discount --onProperty discountRate ;
java-add-annotation --annotation javax.inject.Named --onProperty discountRate ;



#  #####################  #
#  Adding a Service Tier  #
#  #####################  #

java-new-class --named AbstractService --targetPackage com.mongodb.modfac.petstore.service ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
ejb-new-bean --named CountryService ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
ejb-new-bean --named CustomerService ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
ejb-new-bean --named CategoryService ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
ejb-new-bean --named ProductService ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
ejb-new-bean --named ItemService ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
ejb-new-bean --named PurchaseOrderService ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
ejb-new-bean --named OrderLineService ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
java-new-class --named InventoryService --targetPackage com.mongodb.modfac.petstore.service ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
java-new-class --named ShippingService --targetPackage com.mongodb.modfac.petstore.service ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
java-new-class --named StatisticService --targetPackage com.mongodb.modfac.petstore.service ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable ;
java-new-interface --named ComputablePurchaseOrder --targetPackage com.mongodb.modfac.petstore.service ;
cdi-new-decorator --named PurchaseOrderDecorator --delegate com.mongodb.modfac.petstore.service.ComputablePurchaseOrder --targetPackage com.mongodb.modfac.petstore.service ;



#  #############################  #
#  Generates JSF beans and pages  #
#  #############################  #

scaffold-generate --webRoot /admin --targets com.mongodb.modfac.petstore.model.Category ;
scaffold-generate --webRoot /admin --targets com.mongodb.modfac.petstore.model.Country ;
scaffold-generate --webRoot /admin --targets com.mongodb.modfac.petstore.model.Customer ;
scaffold-generate --webRoot /admin --targets com.mongodb.modfac.petstore.model.Item ;
scaffold-generate --webRoot /admin --targets com.mongodb.modfac.petstore.model.OrderLine ;
scaffold-generate --webRoot /admin --targets com.mongodb.modfac.petstore.model.Product ;
scaffold-generate --webRoot /admin --targets com.mongodb.modfac.petstore.model.PurchaseOrder ;

java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.CategoryBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.CountryBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.CustomerBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.ItemBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.OrderLineBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.ProductBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.PurchaseOrderBean ;

java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.CategoryBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.CountryBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.CustomerBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.ItemBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.OrderLineBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.ProductBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.PurchaseOrderBean ;

#  AbstractBean
#  ############
faces-new-bean --named AbstractBean --targetPackage com.mongodb.modfac.petstore.view ;

#  Utility beans
#  ############
faces-new-bean --named DebugBean --targetPackage com.mongodb.modfac.petstore.view.util ;
faces-new-bean --named LocalBean --targetPackage com.mongodb.modfac.petstore.view.util ;

#  Credentials
#  ############
cdi-new-interceptor-binding --named LoggedIn --targetPackage com.mongodb.modfac.petstore.view.credentials ;

faces-new-bean --named AccountBean --targetPackage com.mongodb.modfac.petstore.view.credentials ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.AccountBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.AccountBean ;

faces-new-bean --named CredentialsBean --targetPackage com.mongodb.modfac.petstore.view.credentials ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.CredentialsBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.CredentialsBean ;

#  ShoppingCartBean
#  ############
faces-new-bean --named ShoppingCartBean --targetPackage com.mongodb.modfac.petstore.view.shopping ;
java-add-annotation --annotation javax.enterprise.context.SessionScoped --targetPackage com.mongodb.modfac.petstore.view.shopping ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.view.ShoppingCartBean ;
java-add-annotation --annotation com.mongodb.modfac.petstore.view.CatchException --targetClass com.mongodb.modfac.petstore.view.ShoppingCartBean ;

java-new-class --named ShoppingCartItem --targetPackage com.mongodb.modfac.petstore.view.shopping ;
java-new-field --named item --type com.mongodb.modfac.petstore.model.Item ;
java-new-field --named quantity --type java.lang.Integer ;
# Constraints
constraint-add --constraint NotNull --onProperty item ;
constraint-add --constraint NotNull --onProperty quantity ;
constraint-add --constraint Min --onProperty quantity --value 1 ;



#  ############################  #
#  Creates view utility classes  #
#  ############################  #

#  FacesContext producer
#  ############
java-new-class --named FacesProducer --targetPackage com.mongodb.modfac.petstore.view.util ;
java-new-field --named facesContext --type javax.faces.context.FacesContext --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.enterprise.inject.Produces --onProperty facesContext ;

#  Exception
#  ############
cdi-new-interceptor-binding --named CatchException --targetPackage com.mongodb.modfac.petstore.view.util ;
cdi-new-interceptor --named ExceptionInterceptor --interceptorBinding com.mongodb.modfac.petstore.view.util.CatchException  --targetPackage com.mongodb.modfac.petstore.view.util ;
java-new-field --named logger --type org.apache.logging.log4j.Logger --generateGetter=false --generateSetter=false --updateToString=false ;
java-add-annotation --annotation javax.inject.Inject --onProperty logger ;



#  ########################  #
#  Generates REST endpoints  #
#  ########################  #

rest-generate-endpoints-from-entities --targets com.mongodb.modfac.petstore.model.Category --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets com.mongodb.modfac.petstore.model.Country --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets com.mongodb.modfac.petstore.model.Customer --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets com.mongodb.modfac.petstore.model.Item --contentType application/xml application/json ;
rest-generate-endpoints-from-entities --targets com.mongodb.modfac.petstore.model.Product --contentType application/xml application/json ;

java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.rest.CategoryEndpoint ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.rest.CountryEndpoint ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.rest.CustomerEndpoint ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.rest.ItemEndpoint ;
java-add-annotation --annotation com.mongodb.modfac.petstore.util.Loggable --targetClass com.mongodb.modfac.petstore.rest.ProductEndpoint ;



#  #########################  #
#  Generate Arquillian tests
#  #########################  #

# JSF Beacking Beans
# ##################
arquillian-create-test --targets com.mongodb.modfac.petstore.view.CountryBean --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.view.CustomerBean --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.view.CategoryBean --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.view.ProductBean --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.view.ItemBean --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.view.OrderLineBean --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.view.PurchaseOrderBean --enableJPA ;

# REST Endpoints
# ##############
arquillian-create-test --targets com.mongodb.modfac.petstore.rest.CountryEndpoint --enableJPA --archiveType WAR ;
arquillian-create-test --targets com.mongodb.modfac.petstore.rest.CustomerEndpoint --enableJPA --archiveType WAR ;
arquillian-create-test --targets com.mongodb.modfac.petstore.rest.CategoryEndpoint --enableJPA --archiveType WAR ;
arquillian-create-test --targets com.mongodb.modfac.petstore.rest.ProductEndpoint --enableJPA --archiveType WAR ;
arquillian-create-test --targets com.mongodb.modfac.petstore.rest.ItemEndpoint --enableJPA --archiveType WAR ;

# Services
# ##############
arquillian-create-test --targets com.mongodb.modfac.petstore.service.CountryService --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.service.CustomerService --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.service.CategoryService --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.service.ProductService --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.service.ItemService --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.service.PurchaseOrderService --enableJPA ;
arquillian-create-test --targets com.mongodb.modfac.petstore.service.OrderLineService --enableJPA ;


#  ##################  #
#  Cleans the pom.xml  #
#  ##################  #

project-remove-dependencies org.hibernate.javax.persistence:hibernate-jpa-2.1-api:jar:: ;
project-remove-dependencies javax.enterprise:cdi-api:jar:: ;
project-remove-dependencies javax.ejb:javax.ejb-api:jar:: ;
project-remove-dependencies javax.faces:javax.faces-api:jar:: ;
project-remove-dependencies javax.servlet:javax.servlet-api:jar:: ;
project-remove-dependencies org.jboss.spec.javax.servlet:jboss-servlet-api_3.0_spec:jar:: ;
project-remove-dependencies javax.ws.rs:javax.ws.rs-api:jar:: ;
project-remove-dependencies javax.validation:validation-api:jar:: ;

project-remove-managed-dependencies org.hibernate.javax.persistence:hibernate-jpa-2.1-api:jar::1.0.0.Draft-16 ;
project-remove-managed-dependencies javax.enterprise:cdi-api:jar::1.1 ;
project-remove-managed-dependencies javax.ejb:javax.ejb-api:jar::3.2 ;
project-remove-managed-dependencies javax.faces:javax.faces-api:jar::2.2 ;
project-remove-managed-dependencies javax.servlet:javax.servlet-api:jar::3.1.0 ;
project-remove-managed-dependencies javax.ws.rs:javax.ws.rs-api:jar::2.0
project-remove-managed-dependencies org.jboss.spec:jboss-javaee-6.0:pom::3.0.2.Final ;

#  Adding Java EE and Web Jars dependencies
#  ############################
project-add-dependencies org.apache.logging.log4j:log4j-core:2.0.2 ;
project-add-dependencies org.webjars:bootstrap:3.3.0 ;
project-add-dependencies org.primefaces:primefaces:5.1 ;
project-add-dependencies org.primefaces.themes:all-themes:1.0.10 ;
project-add-dependencies org.jboss.spec:jboss-javaee-7.0:1.0.1.Final:provided:pom ;

#  Adding External repositories
#  ############################
project-add-repository --named primefaces --url http://repository.primefaces.org/