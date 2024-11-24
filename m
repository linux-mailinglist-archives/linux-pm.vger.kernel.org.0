Return-Path: <linux-pm+bounces-18004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811889D76F7
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37277282B0C
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0B127E18;
	Sun, 24 Nov 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i7FXtHdC"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97A84A35;
	Sun, 24 Nov 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470941; cv=none; b=ffTwA3cDGMJsSVVjg01yTfXtSFFhII4y8RkB0vEG2ZZIaMhs0p3URjtEQYw+SZqG2YV9qkRLQB06G5QUub5bE8NfxBQGh162ZsHLA6ReV0k5fCTFyFLu73Y7HZRMCvWdHXzrMRfGJ0G6nKVd0rpMgQjokKEA/MUL82qFrKYcvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470941; c=relaxed/simple;
	bh=xFc9+4L35+p+GavOTvv9s+cybt29J7fOJi1sqTjDoxU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rfc3jDNamCE3i/CVAzPDtQvIKgS3Cl/lJ0MsqlG16CNSYkAMpo+2d0NbOXMGMhZCkhVJ/K7Z4s1Kpwvs2qlV7cNn6wh3edQFmJnOU76X2KBAxmj6kao110lCeAPvF9pyH1+slIRAAyO0jqEncTO4SkFxMUXmvT9LEeQcTJfwJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i7FXtHdC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732470936;
	bh=xFc9+4L35+p+GavOTvv9s+cybt29J7fOJi1sqTjDoxU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=i7FXtHdClXRozUN40vsQmnNBBbYQOh2Ape6BU1QhhF+s8kcAXV66IbQayd0FT0aY7
	 uLLCZsH0vxc/rzeg0KSCtXVzK7TJtXaoJZd2e35kEXzgsS0iJrg0Zk9Asu6mV6u0c6
	 nhdbfm+1+MMh9I1O9nlLMA6NcrmaWepprziU+t34=
Date: Sun, 24 Nov 2024 18:55:31 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Message-ID: <e46c1453-6d47-489d-a5d1-1750d96139ad@weissschuh.net>
In-Reply-To: <d1e297c9-4abf-4df9-9112-3085175e1227@gmx.de>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net> <20241111-power-supply-extensions-v4-1-7240144daa8e@weissschuh.net> <d1e297c9-4abf-4df9-9112-3085175e1227@gmx.de>
Subject: Re: [PATCH v4 1/9] power: supply: sysfs: print single value in
 uevent for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e46c1453-6d47-489d-a5d1-1750d96139ad@weissschuh.net>

Nov 24, 2024 18:47:39 Armin Wolf <W_Armin@gmx.de>:

> Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:
>
>> Currently an uevent contains the same string representation of a
>> property as sysfs. However for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR this
>> is specially formatted to indicate all possible values.
>> This doesn't make sense for uevents and complicates parsing.
>> Instead only include the currently active value in uevents.
>>
>> As currently no in-tree driver uses POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
>> this change is not a problem.
>> Soon the property will actually be used so fix the formatting before
>> that happens.
>
> AFAIK the cros-charge-behaviour driver does use POWER_SUPPLY_PROP_CHARGE_=
BEHAVIOUR,
> so we have to make sure that no userspace application uses this uevent in=
formation.

It only does so after this series.
Currently it uses the ad-hoc sysfs attributes which don't show up in uevent=
.
(I'm the maintainer)

>
> Other than that:
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thanks!

>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>> =C2=A0 drivers/power/supply/power_supply_sysfs.c | 20 ++++++++++++++++--=
--
>> =C2=A0 1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/s=
upply/power_supply_sysfs.c
>> index 571de43fcca9827cf0fe3023e453defbf1eaec7d..a7351b9c8fe34a464a4e69b1=
a1a4a4179c1a4b4f 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -268,9 +268,11 @@ static ssize_t power_supply_show_enum_with_availabl=
e(
>> =C2=A0=C2=A0=C2=A0 return count;
>> =C2=A0 }
>>
>> -static ssize_t power_supply_show_property(struct device *dev,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute=
 *attr,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf) {
>> +static ssize_t power_supply_format_property(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool uevent=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct devi=
ce_attribute *attr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>> +{
>> =C2=A0=C2=A0=C2=A0 ssize_t ret;
>> =C2=A0=C2=A0=C2=A0 struct power_supply *psy =3D dev_get_drvdata(dev);
>> =C2=A0=C2=A0=C2=A0 const struct power_supply_attr *ps_attr =3D to_ps_att=
r(attr);
>> @@ -303,6 +305,8 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 psy->desc->usb_types, value.intval, buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0 case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (uevent) /* no possible values =
in uevents */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto defau=
lt_format;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D power_supply_charge_b=
ehaviour_show(dev, psy->desc->charge_behaviours,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 value.intval, buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> @@ -310,6 +314,7 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_emit(buf, "%s\n=
", value.strval);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0 default:
>> +default_format:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ps_attr->text_values_len =
> 0 &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 value.intval < ps_attr->text_values_len && value.intval =
>=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
>> @@ -321,6 +326,13 @@ static ssize_t power_supply_show_property(struct de=
vice *dev,
>> =C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>>
>> +static ssize_t power_supply_show_property(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute=
 *attr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>> +{
>> +=C2=A0=C2=A0 return power_supply_format_property(dev, false, attr, buf)=
;
>> +}
>> +
>> =C2=A0 static ssize_t power_supply_store_property(struct device *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_=
attribute *attr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bu=
f, size_t count) {
>> @@ -437,7 +449,7 @@ static int add_prop_uevent(const struct device *dev,=
 struct kobj_uevent_env *env
>> =C2=A0=C2=A0=C2=A0 pwr_attr =3D &power_supply_attrs[prop];
>> =C2=A0=C2=A0=C2=A0 dev_attr =3D &pwr_attr->dev_attr;
>>
>> -=C2=A0=C2=A0 ret =3D power_supply_show_property((struct device *)dev, d=
ev_attr, prop_buf);
>> +=C2=A0=C2=A0 ret =3D power_supply_format_property((struct device *)dev,=
 true, dev_attr, prop_buf);
>> =C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When a battery is abs=
ent, we expect -ENODEV. Don't abort;
>>


