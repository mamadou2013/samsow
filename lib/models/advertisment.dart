
class Advertisement {
  final String advertId;
  final String advertName;
  final String advertDescription;
  final bool status;
  final String advertImage;
  final int period;

  Advertisement(this.advertId, this.advertName, this.advertDescription, this.status, this.advertImage, this.period);

  Advertisement.fromCloud(Map<String, dynamic> advertJson)
      :advertId = advertJson['advertId'],
      advertName = advertJson['advertName'],
      advertDescription = advertJson['advertDescription'],
      status = advertJson['advertStatus'],
      advertImage = advertJson['advertImage'],
      period = advertJson['advertPeriod'];

}