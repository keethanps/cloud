export number="${number:-"491740451517"}"
export email="${email:-"aiosamy16@gmail.com"}"
export pass="${pass:-"Keethan12"}"
export picname="${picname:-"Buddha8.jpeg"}"
for file in features/templates/*.tpl
do
	basename=$(basename "$file")
	name="${basename%.*}"
	sed 's/<number>/'"$number"'/g
	 s/<email>/'"$email"'/g
	 s/<pass>/'"$pass"'/g
	 s/<picname>/'"$picname"'/g' $file >features/$name.feature
done
