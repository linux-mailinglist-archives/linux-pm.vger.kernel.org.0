Return-Path: <linux-pm+bounces-18006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10619D777C
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 19:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99B9B2380D
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4CA6F2F3;
	Sun, 24 Nov 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rXGNiwEa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A393201;
	Sun, 24 Nov 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471239; cv=none; b=ADpMD7RN/ry6SdZmYI/8nlDPLOWJbPohBVY+gv7FwMbL0ioTagYAcl4zRIiObbfmldeIe/0C2x6fb8t80yZdpTOld5A6a+jrMeQAX2FB/DEVQ/BxBfgKGoBNu52arLR98MYgwRn7wBXnW/prIAXIDhiUEc9FFRgOMOowro3vSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471239; c=relaxed/simple;
	bh=dXKeRvurEvVjP/aZZB7M5UO/kuK+Hf9wQVrySI9ooKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfyB8EoSELH0EZm/ncI0UL/oaFf7tokTERlsncsHrZxZKkc4Vxk52YBJc4Gq8VvLMUNvNwLwtkEYXEFFOVJDMdTfNriOrCBc15lAkT0NL+umkwb3FG3RHxZNkz68pEw4nhOF3bVfy31Rvyw6PpuIKdegDvrEUdbiJ4g740rluig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rXGNiwEa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732471228; x=1733076028; i=w_armin@gmx.de;
	bh=xl8Hc5N1SA5turTposxHgj28a4Xuekka5+LXkYUpoBM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rXGNiwEa3qpnEfEHH+LnyTwyZMnbrO6HO6y40RIbelHl0i5npRFynwry3BfmdlIY
	 L62UIGGlVg8GeCvHKpYxA+gMdDUrlrL6uklxqOSXOa4Y9hAZbscf2Tf4DFdjQfZBo
	 cUA7Htw1mmdcWUwEga9XF3Yi5CivAmHkoelZ2pueffBTe8PqRkxtRlTmSoOc+mr7x
	 cCE/pqGQvBx1RI4Xk6TOoC95IxnkmYtlZls+iTjgIk2up4viT7CKPX24IVTs1CFrO
	 gIPG03HwJmTbFzzxuQZtUmxMyIP7tezojNmQP/Qo+cetnWneUFH7ICrIXSpk6lFVD
	 R2WcFkgvOsO31znJ2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1ttqqf0Cl3-00dmhx; Sun, 24
 Nov 2024 19:00:28 +0100
Message-ID: <e644ffa6-4c09-4f13-8469-da792b2f105c@gmx.de>
Date: Sun, 24 Nov 2024 19:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] power: supply: sysfs: rework uevent property loop
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-6-7240144daa8e@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241111-power-supply-extensions-v4-6-7240144daa8e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kULPhGHsXET6bNM6CYyylJeAQipRjs85DuFpFXtrZVpWe5t9NkK
 ksOh1zkchLhjGuT8IFIXgZtF7VXV9fWrHkcmCsJZdTfSd+0XWobVyASiLhBP4Xu8u95T+sK
 BRUaV2CMpDo0R8n9Aaa2Sy4kwAuOMOw0g4LosZVCD4iVhzuZEy4MZbNJqr5z0RdROt3794Z
 z7l718Q06T4XcsIIAsWTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BOD8MEsNeqo=;uZ5G56+Y+ZcdxK7/oApsgM9zNIT
 8XvUbvo9XhAXunDCoIEPxJLEv7Okf+MEtlo2IBvD4TjVb4RhI6IS8XH8Md4tG9XycpX/RF0gy
 J46dUr5e4UAtZ/xD7vnDRwjhUVTsH1SfhJGlP3tEA4068K4zBZ8IZGTqRBufn3SqnfbH9gQoz
 KaiI8M0uq06E+E6hR8SUsYs7Vp4FdpZagCz6X8boZ2EpdXE+c2dvplID8vymMrWpSyNB5cgQr
 Flwz/JUQ0fJiiPVUcphJwo0CxNKUjI/JNdcGEcqCGgdZDD8HS3txgQ0o4DWOy7czot0MEtlW+
 1oRgScoRVZ1Rnpw4OYcDSOo97S0LxIsx4Zxj7jMfBbXrdkx4+yDmtOmwj8mFFgQDLBjW+HZGE
 iTpt5pSHQG+FixG7xokoV2nuoazKqc1vWdafGxj0CdtBOsoVuVUmPjfzmzTviXlYvv9zQCYA3
 Ib0D+TmwPwhWflv3kdkObBPt+fOlCGZIVSWxU0X5eLkaO/EbEQnpX5+1vIS2L74KezFAtiNps
 wXHH0s8dIiMRK517H2YR961I3tHLOg96QHsT3VMQkppbFYr+z/q9AoV/PA/zspifsYSXggsjh
 pQYSPdEcsXXREKohpbJ0GJeyeQkKmAzvLqv6LDI8qZyTTAZBNISnaPQH8NzEPkDGceYJ59fh7
 qnL07blcnqvmm0qNBOSOk/3eB7gnDJaOAh5KA/cIcq1tRb781SFyaSeMc+zSxb9Iyg7YLewpK
 ImZB9cSuauAOI94FZchEzzW3meozDjoT3yleHvZkEv5lVCCstZ0u/98vO3QT0pdXdWrnhOoDn
 2FXVQ39AVWjcqdYk1hIvKbMICDZ8Y7Tw1gwNopOKpQGN0lV+zL63HRiC5tP/KYuEBwDtpwAWw
 A2gTaJgZhb1b97WQmzA6Ii0jpr78xJo6roUqpReHmeqg9o0Xrd/PpQiX+

Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:

> Instead of looping through all properties known to be supported by the
> psy, loop over all known properties and decide based on the return value
> of power_supply_get_property() whether the property existed.
>
> This makes the code shorter now and even more so when power supply
> extensions are added.
> It also simplifies the locking, as it can all happen inside
> power_supply_get_property().

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/power/supply/power_supply_sysfs.c | 28 +++++------------------=
-----
>   1 file changed, 5 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/s=
upply/power_supply_sysfs.c
> index bfe48fe01a8d03828c2e539e1e6e5e9fc5c60167..99bfe1f03eb8326d38c4e283=
1c9670313b42e425 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -289,7 +289,7 @@ static ssize_t power_supply_format_property(struct d=
evice *dev,
>   				dev_dbg_ratelimited(dev,
>   					"driver has no data for `%s' property\n",
>   					attr->attr.name);
> -			else if (ret !=3D -ENODEV && ret !=3D -EAGAIN)
> +			else if (ret !=3D -ENODEV && ret !=3D -EAGAIN && ret !=3D -EINVAL)
>   				dev_err_ratelimited(dev,
>   					"driver failed to report `%s' property: %zd\n",
>   					attr->attr.name, ret);
> @@ -441,7 +441,7 @@ static int add_prop_uevent(const struct device *dev,=
 struct kobj_uevent_env *env
>   	dev_attr =3D &pwr_attr->dev_attr;
>
>   	ret =3D power_supply_format_property((struct device *)dev, true, dev_=
attr, prop_buf);
> -	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
> +	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA || ret =3D=3D -EINVAL) {
>   		/*
>   		 * When a battery is absent, we expect -ENODEV. Don't abort;
>   		 * send the uevent with at least the PRESENT=3D0 property
> @@ -462,11 +462,7 @@ static int add_prop_uevent(const struct device *dev=
, struct kobj_uevent_env *env
>
>   int power_supply_uevent(const struct device *dev, struct kobj_uevent_e=
nv *env)
>   {
> -	const struct power_supply *psy =3D dev_get_drvdata(dev);
> -	const enum power_supply_property *battery_props =3D
> -		power_supply_battery_info_properties;
> -	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
> -					 sizeof(unsigned long) + 1] =3D {0};
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
>   	int ret =3D 0, j;
>   	char *prop_buf;
>
> @@ -494,22 +490,8 @@ int power_supply_uevent(const struct device *dev, s=
truct kobj_uevent_env *env)
>   	if (ret)
>   		goto out;
>
> -	for (j =3D 0; j < psy->desc->num_properties; j++) {
> -		set_bit(psy->desc->properties[j], psy_drv_properties);
> -		ret =3D add_prop_uevent(dev, env, psy->desc->properties[j],
> -				      prop_buf);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	for (j =3D 0; j < power_supply_battery_info_properties_size; j++) {
> -		if (test_bit(battery_props[j], psy_drv_properties))
> -			continue;
> -		if (!power_supply_battery_info_has_prop(psy->battery_info,
> -				battery_props[j]))
> -			continue;
> -		ret =3D add_prop_uevent(dev, env, battery_props[j],
> -			      prop_buf);
> +	for (j =3D 0; j < POWER_SUPPLY_ATTR_CNT; j++) {
> +		ret =3D add_prop_uevent(dev, env, j, prop_buf);
>   		if (ret)
>   			goto out;
>   	}
>

