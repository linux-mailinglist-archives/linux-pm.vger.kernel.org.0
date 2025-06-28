Return-Path: <linux-pm+bounces-29787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C27EAECA63
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 23:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FD13B5FBC
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9E21CFF6;
	Sat, 28 Jun 2025 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BlmPC5lM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF71F872D;
	Sat, 28 Jun 2025 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751146481; cv=none; b=t9Q+O/myRUsxbZ7w04mcOQjMrfrQrKw1xt1IgDUkiQ6iEpYP6+L878Z5EgriF61R4Id/eHreYW8tVc+9Z1QQwxeK0mYKz/0l7uIW/Jg94E4zpgvGoOFCzTLXeeGY0Irer9p1r7hgWXP+4mJgTK5cjeW+xDSInRDgSbcmlHgZSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751146481; c=relaxed/simple;
	bh=jVvtXlbC2ZlGcZNiEc2KeLWoVdo6RCJFgOivujX3peE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLPqVyxPnsI2yGwuBAj+7PlxmQ1qa/y+UKDjwbjx/XoxIlVCe4ooS0QEUl5DcNne58JieOgsmec13d6JE8pywEkB1wM6TkbpC13gteEOM3ntDGEQehr07HEGj8gQkc3BwZXCwblnD6xbcNsYqkTvmUQpxEb5r82LHt/rByT4GWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BlmPC5lM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751146474; x=1751751274; i=w_armin@gmx.de;
	bh=LnRkb5hf4pqtcOpKjv5AcWU7Px18+ExBGnIOoFeiyMM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BlmPC5lM30H0I2g1lXEgsblePIItWl2kmna9ubYRqkBOZqNQ2oqNiXMN3WFkggTs
	 CY8FqMT+lAP107vCUjIfZ8b28/cF8ES8u54rfRyFACTj4A0l2VA4LJKJVah7mwJeV
	 LnsroYPge4hQhSA7Y4hvzlYPoIWvOXqRYwaJvc3IFxAo6YyoHh6b2NOooluU9S+ec
	 E3NvgV/si9ImYAovRW1cU183fcG+ArzhX7CXL0cWMUtGXSagc8BDyQZtnrT8PdbFV
	 IJJPpf8Bd6J05DixoxI7dBwtvfLzqcI2U/AdBIkxjvTc31R2HxJA8gjcH9yX+sEnw
	 sy0YpJAQqRGf4lXHFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1uAP0b0p2h-00OTVW; Sat, 28
 Jun 2025 23:34:34 +0200
Message-ID: <4e28458b-baba-456a-bae6-08c2818aedf8@gmx.de>
Date: Sat, 28 Jun 2025 23:34:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
To: Hans de Goede <hansg@kernel.org>, sre@kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250627205124.250433-1-W_Armin@gmx.de>
 <b4e077d9-a5f5-47ec-abc7-9e957c32cd5b@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b4e077d9-a5f5-47ec-abc7-9e957c32cd5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8SqBnx49cMGI5fE3T4pmIEWEMVgfctI2gNe7E5VVnyJPnq9qZ0o
 LZpUKRwADkQqeSoLJyeaFQK87PaHqGvY3DSN0ICeKh6FxuE542k+fYOohheGQSY7icnGqh4
 j7X1AlfjHA+i0AifixsoWL+DOfaglnQ3NzC+Fafkf/hKc4NHshv32vEPfgYnawONBq4NUwl
 cYPPLFfwgbc3GqCl4ffTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FwZcTQpmIoA=;lR8eBML7evwJBW5M05f95136RwR
 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
 ClDW/N6Vr2oDw+/wAlo72rw=

Am 28.06.25 um 11:25 schrieb Hans de Goede:

> Hi Armin,
>
> On 27-Jun-25 10:51 PM, Armin Wolf wrote:
>> Power supply extensions might want to interact with the underlying
>> power supply to retrieve data like serial numbers, charging status
>> and more. However doing so causes psy->extensions_sem to be locked
>> twice, possibly causing a deadlock.
>>
>> Provide special variants of power_supply_get/set_property() that
>> ignore any power supply extensions and thus do not touch the
>> associated psy->extensions_sem lock.
>>
>> Suggested-by: Hans de Goede <hansg@kernel.org>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Thank you for your work on this.
>
> The entire series looks good to me:
>
> Reviewed-by: Hans de Goede <hansg@kernel.org>
>
> for the series.
>
> There is the question of how to merge this. I think it might
> be best for the entire series to go through the power-supply
> tree.
>
> Ilpo would that work for you and if yes can we have your ack ?
>
> Sebastian, IMHO this should be merged as fixed not as for-next
> material.
>
> Regards,
>
> Hans

Personally i would prefer to merge this through the pdx86 tree as the
uniwill-laptop driver currently under review will also require this functi=
onality.

Thanks,
Armin Wolf

>> ---
>>   drivers/power/supply/power_supply_core.c | 82 ++++++++++++++++++++---=
-
>>   include/linux/power_supply.h             |  8 +++
>>   2 files changed, 78 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
>> index aedb20c1d276..e70ffedf1a80 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -1241,9 +1241,8 @@ bool power_supply_has_property(struct power_suppl=
y *psy,
>>   	return false;
>>   }
>>  =20
>> -int power_supply_get_property(struct power_supply *psy,
>> -			    enum power_supply_property psp,
>> -			    union power_supply_propval *val)
>> +static int __power_supply_get_property(struct power_supply *psy, enum =
power_supply_property psp,
>> +				       union power_supply_propval *val, bool use_extensions)
>>   {
>>   	struct power_supply_ext_registration *reg;
>>  =20
>> @@ -1253,10 +1252,14 @@ int power_supply_get_property(struct power_supp=
ly *psy,
>>   		return -ENODEV;
>>   	}
>>  =20
>> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
>> -		power_supply_for_each_extension(reg, psy) {
>> -			if (power_supply_ext_has_property(reg->ext, psp))
>> +	if (use_extensions) {
>> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
>> +			power_supply_for_each_extension(reg, psy) {
>> +				if (!power_supply_ext_has_property(reg->ext, psp))
>> +					continue;
>> +
>>   				return reg->ext->get_property(psy, reg->ext, reg->data, psp, val)=
;
>> +			}
>>   		}
>>   	}
>>  =20
>> @@ -1267,20 +1270,49 @@ int power_supply_get_property(struct power_supp=
ly *psy,
>>   	else
>>   		return -EINVAL;
>>   }
>> +
>> +int power_supply_get_property(struct power_supply *psy, enum power_sup=
ply_property psp,
>> +			      union power_supply_propval *val)
>> +{
>> +	return __power_supply_get_property(psy, psp, val, true);
>> +}
>>   EXPORT_SYMBOL_GPL(power_supply_get_property);
>>  =20
>> -int power_supply_set_property(struct power_supply *psy,
>> -			    enum power_supply_property psp,
>> -			    const union power_supply_propval *val)
>> +/**
>> + * power_supply_get_property_direct - Read a power supply property wit=
hout checking for extensions
>> + * @psy: The power supply
>> + * @psp: The power supply property to read
>> + * @val: The resulting value of the power supply property
>> + *
>> + * Read a power supply property without taking into account any power =
supply extensions registered
>> + * on the given power supply. This is mostly useful for power supply e=
xtensions that want to access
>> + * their own power supply as using power_supply_get_property() directl=
y will result in a potential
>> + * deadlock.
>> + *
>> + * Return: 0 on success or negative error code on failure.
>> + */
>> +int power_supply_get_property_direct(struct power_supply *psy, enum po=
wer_supply_property psp,
>> +				     union power_supply_propval *val)
>> +{
>> +        return __power_supply_get_property(psy, psp, val, false);
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
>> +
>> +
>> +static int __power_supply_set_property(struct power_supply *psy, enum =
power_supply_property psp,
>> +				       const union power_supply_propval *val, bool use_extensions)
>>   {
>>   	struct power_supply_ext_registration *reg;
>>  =20
>>   	if (atomic_read(&psy->use_cnt) <=3D 0)
>>   		return -ENODEV;
>>  =20
>> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
>> -		power_supply_for_each_extension(reg, psy) {
>> -			if (power_supply_ext_has_property(reg->ext, psp)) {
>> +	if (use_extensions) {
>> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
>> +			power_supply_for_each_extension(reg, psy) {
>> +				if (!power_supply_ext_has_property(reg->ext, psp))
>> +					continue;
>> +
>>   				if (reg->ext->set_property)
>>   					return reg->ext->set_property(psy, reg->ext, reg->data,
>>   								      psp, val);
>> @@ -1295,8 +1327,34 @@ int power_supply_set_property(struct power_suppl=
y *psy,
>>  =20
>>   	return psy->desc->set_property(psy, psp, val);
>>   }
>> +
>> +int power_supply_set_property(struct power_supply *psy, enum power_sup=
ply_property psp,
>> +			      const union power_supply_propval *val)
>> +{
>> +	return __power_supply_set_property(psy, psp, val, true);
>> +}
>>   EXPORT_SYMBOL_GPL(power_supply_set_property);
>>  =20
>> +/**
>> + * power_supply_set_property_direct - Write a power supply property wi=
thout checking for extensions
>> + * @psy: The power supply
>> + * @psp: The power supply property to write
>> + * @val: The value to write to the power supply property
>> + *
>> + * Write a power supply property without taking into account any power=
 supply extensions registered
>> + * on the given power supply. This is mostly useful for power supply e=
xtensions that want to access
>> + * their own power supply as using power_supply_set_property() directl=
y will result in a potential
>> + * deadlock.
>> + *
>> + * Return: 0 on success or negative error code on failure.
>> + */
>> +int power_supply_set_property_direct(struct power_supply *psy, enum po=
wer_supply_property psp,
>> +				     const union power_supply_propval *val)
>> +{
>> +	return __power_supply_set_property(psy, psp, val, false);
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_set_property_direct);
>> +
>>   int power_supply_property_is_writeable(struct power_supply *psy,
>>   					enum power_supply_property psp)
>>   {
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
>> index 45468959dd98..f21f806bfb38 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -878,15 +878,23 @@ static inline int power_supply_is_system_supplied=
(void) { return -ENOSYS; }
>>   extern int power_supply_get_property(struct power_supply *psy,
>>   			    enum power_supply_property psp,
>>   			    union power_supply_propval *val);
>> +int power_supply_get_property_direct(struct power_supply *psy, enum po=
wer_supply_property psp,
>> +				     union power_supply_propval *val);
>>   #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>>   extern int power_supply_set_property(struct power_supply *psy,
>>   			    enum power_supply_property psp,
>>   			    const union power_supply_propval *val);
>> +int power_supply_set_property_direct(struct power_supply *psy, enum po=
wer_supply_property psp,
>> +				     const union power_supply_propval *val);
>>   #else
>>   static inline int power_supply_set_property(struct power_supply *psy,
>>   			    enum power_supply_property psp,
>>   			    const union power_supply_propval *val)
>>   { return 0; }
>> +static inline int power_supply_set_property_direct(struct power_supply=
 *psy,
>> +						   enum power_supply_property psp,
>> +						   const union power_supply_propval *val)
>> +{ return 0; }
>>   #endif
>>   extern void power_supply_external_power_changed(struct power_supply *=
psy);
>>  =20
>

