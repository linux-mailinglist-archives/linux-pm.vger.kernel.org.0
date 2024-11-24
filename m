Return-Path: <linux-pm+bounces-18007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61329D778D
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 19:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1910CB245CD
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424C136658;
	Sun, 24 Nov 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VV4srSAb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619C51016;
	Sun, 24 Nov 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471319; cv=none; b=Z1mpuXLzhKl++iEM95ehkgYLieGbDcyc31KtR/lZe5PMgljb9vrNkzP56wDGatAbX64HB3O5z7C7SCr1wNNoGnzggraMBfDVC6CMaHt75FDFMoxKBuD4U+wJ3bng4FKWAn41Rs5sa+Ufm+/OXjJPzSP/lv9MHgK1Lr+k9Def1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471319; c=relaxed/simple;
	bh=vc3R8kRJQW7A4YEaVRziVwBxkn5o4JjTit4eCRHgX2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcjR6l04nV64tEDIWfbXTu5FeIneC5/c4QjBFE3OZBSUWofV9h29SfgeNVAKctvz3W2PlOMqcJXbS+PnB/kC1PQygNPxH/UIzPDyFCrAGnT1tbIGjOzwKrfwXH/Dq+v1pSKYc1C/fnpPglNcpRJp+2eSPDhk4OeyzTi4PRDMo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VV4srSAb; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732471307; x=1733076107; i=w_armin@gmx.de;
	bh=XxIkZBnY9JeXYnhznOI7p85d8jwaE5xFQwqpBOvyAMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VV4srSAb+LVnwhXuLFT00RHY6UyMyauoC7a2/i9I4zUX97Osbpc9klAd1s8VV1O7
	 IJIkHGq+KVe4RbXzta/SvpA71/WQt002k4fc/2iQ0eCGnMYjFxPkw1MZdU9d4a0HX
	 OMJeHJNHfzMyfusBuxjYhV71ibwf4hjNv8QP0ofWqDg3pfJiKtAuedSAt0oGQxC99
	 k3TQJneH7CssruoRHy/9HZeTIg7GSSDZF+l4fwspn+MBN28xlJLDuuVZ206phjjxL
	 SHzMdVmC0jcq9+4Q6d2LCczT7epsvQsJO2HoTUSU1HezPsAabRq+XpyIjdZDmUoSm
	 Dp79josM+30LTAQx1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1tvlgb206w-00gnZ4; Sun, 24
 Nov 2024 19:01:47 +0100
Message-ID: <d3b4d121-950a-4c08-bf21-edb1ceb30d7d@gmx.de>
Date: Sun, 24 Nov 2024 19:01:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] power: supply: sysfs: print single value in uevent
 for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-1-7240144daa8e@weissschuh.net>
 <d1e297c9-4abf-4df9-9112-3085175e1227@gmx.de>
 <e46c1453-6d47-489d-a5d1-1750d96139ad@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e46c1453-6d47-489d-a5d1-1750d96139ad@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:isD7wnDMJX/Xhgf2OlMwV+HeoEcVjft3oDMhQ7CgziqJOQg74Kx
 OfUAWgcSa8BEZhxnC0URiTn3A9P4pgTIaCCV5pZZkV8fAH8Hh8UtwdjeEDaOWwvAkrAJB8v
 r6RoT8d3C8m7DEFOIV7e2knipJKUTlWMc8TJAW/q58uBAXLRIMKLhyk1tnWr8aFn9a/Jebg
 DZkgTEd+DE0DKX+E2ab4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/foD/bitf3Y=;aydQpnhtOA83CwTFEyFxHmNzFNa
 XFqKiQWWQHzfXHk/fVM1D74cpOMkPiYtGVeV33RwYAq/AWdZITOLlXY/xW9HY3MjsTtumiG3U
 9eobHlks81QRJi/LnpWa3QTbRYw4bP0krEJkKxcwTZ1nkL7ianoKw3zN0uLPaHfhKKSU2AOiy
 gUf/hbHUrWZFpfxlsF3i5zyHfWblhZj894h9AbE4mO3Uy9A/p+IFr0NnNjZj7pKSLZyhNvcWb
 kxhgX2TO3UJY/ejr3vLEf0ljI9Ui0PLRpMkT/pnXnZcQEOu5+jZeOQd3Lpy+vrtgYDDrTOn9+
 hoqO22RXPkWnXFH3mBlYsZFTHPZldISjxqOmdYafA4vxquXT853/ITsZUck2nK28lSi9FjpxA
 r6wcef5vWqQFIZt3az2+ow30Yxp5mhFdNYUZMlZO+NKoBBWWAcrZ8asMnVdYmJIjTQ7ZIrtRX
 l8FdIBl5zlx0bgmAY7scuAQmWG1Qv8ySI4yctVkF1os9n/8ggi2SP02+CUXqf7+or3PiAvwMb
 0y4UyBLUG6lPOByXkLvbFxzaMYj5nx70JhHIeUZ8PCM/0TibeuLLLVG0ls9auZGGyaqyDUTTJ
 HjrdZD0QkZJ/PbFAQRlRDY3NPZP86GPWuAjBj0Ayt8YGhsgEybNKVJP1NmvypoYJG38XWtVz/
 ajBqijU5jdyd35xBpHlAkw4gfGWEmZ6Qd8Tcun2wMElEHdSijiQJXruefKhKwVx8oiWz9tS+c
 yxKMCaJJliOnna0EThMn4ZxJq5fF5xu5totUJsdwKrcQI1MwiNHvARl5lyo/ONEjD92NHL7C8
 nS5/tcNnrtsIgJB9FZL/DdIbqgxeWtkIyNehEtaQcxl+eUA4hFwIsifwOBlDEwKJmMRY6tWSX
 Vt++TNxJkrwIVno5WYjFO6sa7CITrNHDiIzPiQq3sjeO2MRqu7KHI11PgsvrSBFLt6o9qWEpO
 9ymsq5gHrnF99jpWP6EdxtToUL0iKKkgD1Qat1m37auIx08hFrntXC4GUNv+s7X32Djz58H56
 0hMFhXQjPwIZB6F3QTlmuttPdYGSGLbmkBSyNKo/XaDye8ME+qPT1yTnlF8TiiBALavOeQJaH
 m6hd49V9Hj4/eZhpJVPhO+nae8+/tp

Am 24.11.24 um 18:55 schrieb Thomas Wei=C3=9Fschuh:

> Nov 24, 2024 18:47:39 Armin Wolf <W_Armin@gmx.de>:
>
>> Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:
>>
>>> Currently an uevent contains the same string representation of a
>>> property as sysfs. However for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR this
>>> is specially formatted to indicate all possible values.
>>> This doesn't make sense for uevents and complicates parsing.
>>> Instead only include the currently active value in uevents.
>>>
>>> As currently no in-tree driver uses POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
>>> this change is not a problem.
>>> Soon the property will actually be used so fix the formatting before
>>> that happens.
>> AFAIK the cros-charge-behaviour driver does use POWER_SUPPLY_PROP_CHARG=
E_BEHAVIOUR,
>> so we have to make sure that no userspace application uses this uevent =
information.
> It only does so after this series.
> Currently it uses the ad-hoc sysfs attributes which don't show up in uev=
ent.
> (I'm the maintainer)

I see, in this case you can ignore my comment.

Thank,
Armin Wolf

>> Other than that:
>>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Thanks!
>
>>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>> ---
>>>  =C2=A0 drivers/power/supply/power_supply_sysfs.c | 20 +++++++++++++++=
+----
>>>  =C2=A0 1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power=
/supply/power_supply_sysfs.c
>>> index 571de43fcca9827cf0fe3023e453defbf1eaec7d..a7351b9c8fe34a464a4e69=
b1a1a4a4179c1a4b4f 100644
>>> --- a/drivers/power/supply/power_supply_sysfs.c
>>> +++ b/drivers/power/supply/power_supply_sysfs.c
>>> @@ -268,9 +268,11 @@ static ssize_t power_supply_show_enum_with_availa=
ble(
>>>  =C2=A0=C2=A0=C2=A0 return count;
>>>  =C2=A0 }
>>>
>>> -static ssize_t power_supply_show_property(struct device *dev,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribut=
e *attr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf) {
>>> +static ssize_t power_supply_format_property(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ueven=
t,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dev=
ice_attribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> +{
>>>  =C2=A0=C2=A0=C2=A0 ssize_t ret;
>>>  =C2=A0=C2=A0=C2=A0 struct power_supply *psy =3D dev_get_drvdata(dev);
>>>  =C2=A0=C2=A0=C2=A0 const struct power_supply_attr *ps_attr =3D to_ps_=
attr(attr);
>>> @@ -303,6 +305,8 @@ static ssize_t power_supply_show_property(struct d=
evice *dev,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 psy->desc->usb_types, value.intval, buf);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0 case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (uevent) /* no possible value=
s in uevents */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto def=
ault_format;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D power_supply_charg=
e_behaviour_show(dev, psy->desc->charge_behaviours,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 value.intval, buf);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> @@ -310,6 +314,7 @@ static ssize_t power_supply_show_property(struct d=
evice *dev,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_emit(buf, "%=
s\n", value.strval);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0 default:
>>> +default_format:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ps_attr->text_values_l=
en > 0 &&
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 value.intval < ps_attr->text_values_len && value.int=
val >=3D 0) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
>>> @@ -321,6 +326,13 @@ static ssize_t power_supply_show_property(struct =
device *dev,
>>>  =C2=A0=C2=A0=C2=A0 return ret;
>>>  =C2=A0 }
>>>
>>> +static ssize_t power_supply_show_property(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribut=
e *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> +{
>>> +=C2=A0=C2=A0 return power_supply_format_property(dev, false, attr, bu=
f);
>>> +}
>>> +
>>>  =C2=A0 static ssize_t power_supply_store_property(struct device *dev,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dev=
ice_attribute *attr,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char=
 *buf, size_t count) {
>>> @@ -437,7 +449,7 @@ static int add_prop_uevent(const struct device *de=
v, struct kobj_uevent_env *env
>>>  =C2=A0=C2=A0=C2=A0 pwr_attr =3D &power_supply_attrs[prop];
>>>  =C2=A0=C2=A0=C2=A0 dev_attr =3D &pwr_attr->dev_attr;
>>>
>>> -=C2=A0=C2=A0 ret =3D power_supply_show_property((struct device *)dev,=
 dev_attr, prop_buf);
>>> +=C2=A0=C2=A0 ret =3D power_supply_format_property((struct device *)de=
v, true, dev_attr, prop_buf);
>>>  =C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When a battery is =
absent, we expect -ENODEV. Don't abort;
>>>

