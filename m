Return-Path: <linux-pm+bounces-18000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79B9D76DC
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682B5162E44
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92CA7346D;
	Sun, 24 Nov 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WhNErdos"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D002500C7;
	Sun, 24 Nov 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470467; cv=none; b=kaK1Udkv56w8g5laa5R8E+tpNvqpmR+5pxzaf9oACqC4R8leDHZRKawMO/aqvD1vkDVHxFdmjm8ZqIY0/EOhcoQBjNTF/a9FgdeARRGZ+wWvqKHvEtI1w/CcLaVYGhYKR4GS7C253QL8GSfXtnelF3MMm42d3s4L5sDqs2v7y3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470467; c=relaxed/simple;
	bh=y6H922OiUBgFhZZ1wdmam9xe0bBWQN6Bu8yq4QfHCC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQmtEBaScqyCc9+hvDXzsUcINZZ07DrO0a0pHfk3RUijaA/ZRmA4Xjb6/F06Fz5M0MI8/pdkvaK5ZIiqpkqNsRrqviz0FIKQUHFw+BU5Ts4c0i4h+ATwGcahvVdT/IwsCZQfgOitoaGby5UOy1vhtpK5cM9NGi0xU7X1ECo0R9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WhNErdos; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732470455; x=1733075255; i=w_armin@gmx.de;
	bh=a6ptw3kLT/YG1WOGc6hG7vEjWaaKVbr4fCDEVugvC1I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WhNErdosERcY7ACAcyYlUxRZw7JRWlG6dRTzuSLk9OVt3RD9GR/4iVrt60T+ccCN
	 Hcj/iCmB6PD2tKwbrt70DDIlmnb7+hSYAvoargIjef0MFtlkWD7PGv7M6wlMgovZw
	 ESUYDODG12RWa4VNL7XLkasWHCgKeqaRdrCdYzaMKodRj5YHaNgDP2dlWndB/zgEA
	 /gx0wHLp5iaz+iBM62ZRUVr9mOOs0YdQ5MhEW6KV6haLJ5yPgSvOTUReegPVo38Jd
	 7TFhf2a60PSlUIU0JpzlzUjlCFs+wr8uii6CG/Vc8noH6vG4RoEbvxgPJrXzQgw2A
	 axuHQ52UQTc0iNG0jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY6Cb-1tDoTK0x2L-00MheQ; Sun, 24
 Nov 2024 18:47:35 +0100
Message-ID: <d1e297c9-4abf-4df9-9112-3085175e1227@gmx.de>
Date: Sun, 24 Nov 2024 18:47:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] power: supply: sysfs: print single value in uevent
 for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-1-7240144daa8e@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241111-power-supply-extensions-v4-1-7240144daa8e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vvN+va5kzvBZ6QVOBsUajGS5ShjoYPRXO1hKUD4IRKwcp34NGtl
 E0yjTIMP5W+bavzUuZpAzeUgfMljJNwGAyWM1Qnta80g8vGnJRVGhHQMsDVmARugXWkvw8Y
 6HrY1ZNUvWGQ6lnjniAY+7UiFgX82ZN/KmMf1mmMoXe4PB/aPKLYbe5aYPdZUH5DA5V/bCt
 /413HuV6p5pbbwaC82jeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FL87kodppyw=;fONTwv/ui61ltLtcWt0XaTqzLfB
 aALp8gATTpknLZxxPBCOJYAWMslDiEyorFtEmQjgs7pfoClxZB9y4PxITpDnRpQftEywUvZ0a
 ViH/oJELjEMwrOkWGRVTMn7KbecZmqcKRQ+yLujNLywdzZ61YDq1IRAC2YmvVOt9eQbYNtNwq
 W5kL8aOImRWvEha8VfCfqQ4xZsxZfsMXLETAicG7+Z2m6moaGAsOFers2fz+/OVSyLFAb63Cu
 lDsS9L7iQoJeJVayQJ/tCi3NJklfwcw/lg8QdkplgzqCzhod02KZXE0SnmQxxVjsczrlGx8dj
 s+yIyhKIHESEvtbrng4v+zyMiKB7l8QmBDSAJWueCWRJ/5mCKETZ66BNI1MXcbDaUKQZwjSB0
 aw2/3B+/585QGSlPWlzyfk33brn6xypegXpLC2zgpmw1vqhcGcbv4WtNx41TraSorfOcmRhOK
 bt50zmBuz0EUoUwxEO9duW9UaBwPZtIgmzBjYmQNUb7Ftvw9tiZT/Qxaxseib0w9CDlLHuLWZ
 2twgyjuaPEMwyuzmKoB7aJhi0ukj7Zy2WtNCDnuxWu7IRwW8jIOtFLZwGIQzyolDAifIHCs8j
 6cew5Iv4s5GK2Ehq+Lg7HH3QeWsw6Pcxbfy3v8y1/SrgHn3qG/JKR2MbhUUORLbUNIkK8DR83
 9OtqR1cGAAghs+LRvLZKsqo3+pTtOX25CXDJf+HOlBydn0XIFwU1ogz9DKI4i+ssdSjPVBjlB
 FpFNgmJtQ0H1vQnnlfaOUKmUTydEVEUfxrrmQO/V2rvsRZW7OaeP8d3oMePh6mM8fmB9j8N4I
 5D4oJ6BVV3DUCpKb4LY+4FVvZWWUHN9AkRtmjAvwf/Pf0T7CtxtZDfMHvydweFsDo7EKRt82j
 1C2LiU2r8wcyfLKrYRzAyR8adzzQuQGYpNoJN9kdIf/s7AxNtNc9nvXz5

Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:

> Currently an uevent contains the same string representation of a
> property as sysfs. However for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR this
> is specially formatted to indicate all possible values.
> This doesn't make sense for uevents and complicates parsing.
> Instead only include the currently active value in uevents.
>
> As currently no in-tree driver uses POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
> this change is not a problem.
> Soon the property will actually be used so fix the formatting before
> that happens.

AFAIK the cros-charge-behaviour driver does use POWER_SUPPLY_PROP_CHARGE_B=
EHAVIOUR,
so we have to make sure that no userspace application uses this uevent inf=
ormation.

Other than that:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>   drivers/power/supply/power_supply_sysfs.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/s=
upply/power_supply_sysfs.c
> index 571de43fcca9827cf0fe3023e453defbf1eaec7d..a7351b9c8fe34a464a4e69b1=
a1a4a4179c1a4b4f 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -268,9 +268,11 @@ static ssize_t power_supply_show_enum_with_availabl=
e(
>   	return count;
>   }
>
> -static ssize_t power_supply_show_property(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf) {
> +static ssize_t power_supply_format_property(struct device *dev,
> +					    bool uevent,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
>   	ssize_t ret;
>   	struct power_supply *psy =3D dev_get_drvdata(dev);
>   	const struct power_supply_attr *ps_attr =3D to_ps_attr(attr);
> @@ -303,6 +305,8 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>   				psy->desc->usb_types, value.intval, buf);
>   		break;
>   	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		if (uevent) /* no possible values in uevents */
> +			goto default_format;
>   		ret =3D power_supply_charge_behaviour_show(dev, psy->desc->charge_be=
haviours,
>   							 value.intval, buf);
>   		break;
> @@ -310,6 +314,7 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>   		ret =3D sysfs_emit(buf, "%s\n", value.strval);
>   		break;
>   	default:
> +default_format:
>   		if (ps_attr->text_values_len > 0 &&
>   				value.intval < ps_attr->text_values_len && value.intval >=3D 0) {
>   			ret =3D sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval])=
;
> @@ -321,6 +326,13 @@ static ssize_t power_supply_show_property(struct de=
vice *dev,
>   	return ret;
>   }
>
> +static ssize_t power_supply_show_property(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return power_supply_format_property(dev, false, attr, buf);
> +}
> +
>   static ssize_t power_supply_store_property(struct device *dev,
>   					   struct device_attribute *attr,
>   					   const char *buf, size_t count) {
> @@ -437,7 +449,7 @@ static int add_prop_uevent(const struct device *dev,=
 struct kobj_uevent_env *env
>   	pwr_attr =3D &power_supply_attrs[prop];
>   	dev_attr =3D &pwr_attr->dev_attr;
>
> -	ret =3D power_supply_show_property((struct device *)dev, dev_attr, pro=
p_buf);
> +	ret =3D power_supply_format_property((struct device *)dev, true, dev_a=
ttr, prop_buf);
>   	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
>   		/*
>   		 * When a battery is absent, we expect -ENODEV. Don't abort;
>

