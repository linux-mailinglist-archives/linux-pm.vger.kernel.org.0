Return-Path: <linux-pm+bounces-19226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657719F1964
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 23:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D854163C56
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23281AE01E;
	Fri, 13 Dec 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R7pXsx41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9691974EA;
	Fri, 13 Dec 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130220; cv=none; b=RxAdozQDzdfPvcxYAG3COdrxVF/3Yu62wGwkBvNXEb6bpjvteSP6FYulD0YlRK2EBxXXJYxn5Djulr4ocewLxCrHKrBNn6CV8ABWQ36NmayoX4JUm1lypApNT8TDDdqz9G+rbpk4XEDnfK+8e5wPYwgip6Yu3hnSYEL8JTQVmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130220; c=relaxed/simple;
	bh=stDvdyJpTdwM6KMs78BjOWWTgfqjzPMBJ6xCyDqw23E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljGIV5hGNmQZL1cWGGUYrgsUvcc4YAAQ4n1TGpy+PORfeCabNtMtWz0w9xVLhwPK3VnZq/Npwgl4vQf6BmYe2g7OsxCG72Kr6P0M77ZhNP/ubbhlKwMOtXXRF/z2mKx+CkVtrWh1oWclrRSMLFOwkOZoCAeWrtaWrb7n0rvefUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R7pXsx41; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734130208; x=1734735008; i=w_armin@gmx.de;
	bh=gOxvWaYg79d/c8H2Y/c1P2FNgpo+xgmw90p9TEm5yh0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R7pXsx41O3fLGmXg05nBl7q0aOTN6Xp4KVxI0rekSmrAL5mj6sJ8ZuSbfx5iG/CW
	 bMCp1DXNYj0wA1pqOWVSoAXNaoZLu7/P0FG+trxmR3TbjnUHtwLz/dPG5f/gU89y8
	 17Jre9oTZ9shLqlMnB14stphoJswWsX7n1Hij6dvi6hEmpKYCgSqaggDqVQRcInyS
	 8B3Jl1Rm3pYgdYaxcS3E+o14aFQVdQWqCvypvSZv6q6C3hekZwewSML5KVhMY4jg0
	 tpagUzDEE17Hk97CjwHqWeYoQrEIsIOcVJo7560KZTeeQpIEDj7EUKPD4drLh4VEm
	 R4XLt6Vbx42WRyUZ+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1tCN882VrY-00KlyB; Fri, 13
 Dec 2024 23:50:08 +0100
Message-ID: <83acba1b-2974-4d84-99ec-8ddbd0529d73@gmx.de>
Date: Fri, 13 Dec 2024 23:50:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-pm@vger.kernel.org
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lZgXc6EfBoUh0NZF6Z6HQ3Cx+vA1+IUPV+k4uFWl6qZ/hGDz6Dg
 4gbHd84xrpBAuSRe+1wFBGeYh6TgcoHmnDErMd+1V81T3dDaUdpuueklhhebiJh64mu5ncu
 B8GUqFhsv//qYwk2dIDuzct5A1WMnlydLhpBFZwjKJFPiOcQ1uWiagI+jWDQnsEeBUvRVDp
 gwRLuX/o4tMbkHjRHhB6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kfHjMDkLSNs=;enTNd0wfuMz+hQSJjzcDxLnydgK
 4Q9UcNMGWJuiMl0ysGvxWwNj/TYYdmOlnKTewcGxBdqP0+kcSBCMJ0xodSkZfJmk5xZPb/wze
 lRRg8zr8QecPNQHGE1zzF22CWNr72lHqEskR3WuNb5ulXeNC6tOUCgyF5E5lI5nuhusnUxhbT
 jS2K8xan4rfs8LXQYYzrfikFvl9C6zB/oFvHfK4TQpEFxQz8gepWJV84qFW1ysrNV4zfrBtxC
 LeXerP8xrtvsOji64dfRn3Us+bRTD+cFAusWP1AeCSlNSPwYfuOywAAFl1TLm+bmip92WcSQa
 4T3rmWDp6J2rGydOTYtMNavXhfYh37NwzRJ13mm3RpLYGUSG1Icyu/7J+jCPr3Qwph6731XRT
 uOd3KS23e5XcrirFCDo8nqV26tGJyQG5Z+WXS5YOxNIUMt3FoAfwgfE6JAPNQunZQ9xWhLEu7
 QViWoa0y0L8oORDt/Z00yOW6Pu7bioezZ5DDqozBBq2jZOdhnHn+3hrWqywkVf5p4KzVmhHF4
 XzbeENAsBnObjjn8TP/Y6WWA7tzrM8wBRF6nd/C9d0APvfW3qxH+fjFAzJrIeGaLhAUx9PJaA
 UvYDvQ3QH1IocDASPZtadyi1DA7IMg7kxO9qeL83ZDu9KFbOGxR7MeFQObfc24X4wjrtpdPwD
 6xD8K4E3NCTpepQlTmR1hvw6A1s2v1JZZxx1ZpAXtbZaJY0FBaxld+I0Ljgx3WS4bJV71ck/Q
 DZNFAQXtdpL0K9XxLB1NBxfVtg0eDoDjllh8uYuP4GqIGerBXkzpywxs0sNC7KuYUL3LvISRx
 HLGWaBd+0Ab5rWYEOMTlmjBmRKrJcrpb/hB6SxRkfOCXCYaSkuUaHKnRMYSahpzXlq8MUg2Tk
 fdoiVy0VDy8Bh4Nkpqm9eyKNtELys8pFRYTib/jReWXRx/f/1zfPwcx+ThdIWuUuAjRD1lYzE
 y4qVB7hTynPDpP6uUb1awS/XkITr/JfnDC1ir913Qyv60I06bipoDG5rkaJ7whAOECEw4hbHV
 stuWYnclt+tyhyVyT9E6+GfUDHEQo8Dfi4TQ+eJ0FnbPkwNwPIkUIBVxpI8Hxk3qLhBJWPo5W
 v4WtGpsyj+kBF6HQk4GDkx4sG4Wxwf

Am 11.12.24 um 20:57 schrieb Thomas Wei=C3=9Fschuh:

> Userspace wants to now about the used power supply extensions,
> for example to handle a device extended by a certain extension
> differently or to discover information about the extending device.
>
> Add a sysfs directory to the power supply device.
> This directory contains links which are named after the used extension
> and point to the device implementing that extension.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>   Documentation/ABI/testing/sysfs-class-power |  9 +++++++++
>   drivers/power/supply/cros_charge-control.c  |  5 ++++-
>   drivers/power/supply/power_supply.h         |  2 ++
>   drivers/power/supply/power_supply_core.c    | 19 +++++++++++++++++--
>   drivers/power/supply/power_supply_sysfs.c   | 10 ++++++++++
>   drivers/power/supply/test_power.c           |  4 +++-
>   include/linux/power_supply.h                |  2 ++
>   7 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation=
/ABI/testing/sysfs-class-power
> index 45180b62d42686c8999eda54f38435cb6c74a879..31e8b33d849cbe99dc93a4ba=
3723a43440ac3103 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -793,3 +793,12 @@ Description:
>
>   		Access: Read
>   		Valid values: 1-31
> +
> +What:		/sys/class/power_supply/<supply_name>/extensions/<extension_name=
>
> +Date:		March 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the extensions registered to the power supply.
> +		Each entry is a link to the device which registered the extension.
> +
> +		Access: Read
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/=
supply/cros_charge-control.c
> index fb4af232721dec1d4f0090f6616922848812b2a2..02d5bdbe2e8d45108dd8f2d3=
ab6a927b94864b9e 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -31,6 +31,7 @@
>    */
>
>   struct cros_chctl_priv {
> +	struct device *dev;
>   	struct cros_ec_device *cros_ec;
>   	struct acpi_battery_hook battery_hook;
>   	struct power_supply *hooked_battery;
> @@ -202,6 +203,7 @@ static int cros_chctl_psy_prop_is_writeable(struct p=
ower_supply *psy,
>   	};									\
>   										\
>   	static const struct power_supply_ext _name =3D {				\
> +		.name			=3D "cros-charge-control",		\
>   		.properties		=3D _name ## _props,			\
>   		.num_properties		=3D ARRAY_SIZE(_name ## _props),		\
>   		.charge_behaviours	=3D EC_CHARGE_CONTROL_BEHAVIOURS,		\
> @@ -233,7 +235,7 @@ static int cros_chctl_add_battery(struct power_suppl=
y *battery, struct acpi_batt
>   		return 0;
>
>   	priv->hooked_battery =3D battery;
> -	return power_supply_register_extension(battery, priv->psy_ext, priv);
> +	return power_supply_register_extension(battery, priv->psy_ext, priv->d=
ev, priv);
>   }
>
>   static int cros_chctl_remove_battery(struct power_supply *battery, str=
uct acpi_battery_hook *hook)
> @@ -299,6 +301,7 @@ static int cros_chctl_probe(struct platform_device *=
pdev)
>
>   	dev_dbg(dev, "Command version: %u\n", (unsigned int)priv->cmd_version=
);
>
> +	priv->dev =3D dev;
>   	priv->cros_ec =3D cros_ec;
>
>   	if (priv->cmd_version =3D=3D 1)
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/=
power_supply.h
> index 531785516d2ac31f9a7f73a58e15e64cb81820ed..9ed749cd09369f0f13017847=
687509736b30aae8 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -25,6 +25,7 @@ extern bool power_supply_ext_has_property(const struct=
 power_supply_ext *ext,
>   struct power_supply_ext_registration {
>   	struct list_head list_head;
>   	const struct power_supply_ext *ext;
> +	struct device *dev;
>   	void *data;
>   };
>
> @@ -39,6 +40,7 @@ struct power_supply_ext_registration {
>
>   extern void __init power_supply_init_attrs(void);
>   extern int power_supply_uevent(const struct device *dev, struct kobj_u=
event_env *env);
> +extern const struct attribute_group power_supply_extension_group;
>   extern const struct attribute_group *power_supply_attr_groups[];
>
>   #else
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/su=
pply/power_supply_core.c
> index bc22edbd0e6a02c27500132075f5c98d814a7330..5142fbd580ee3d629a2aae7d=
0b9bcd5709162129 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1346,17 +1346,21 @@ static int power_supply_update_sysfs_and_hwmon(s=
truct power_supply *psy)
>   }
>
>   int power_supply_register_extension(struct power_supply *psy, const st=
ruct power_supply_ext *ext,
> -				    void *data)
> +				    struct device *dev, void *data)
>   {
>   	struct power_supply_ext_registration *reg;
>   	size_t i;
>   	int ret;
>
> -	if (!psy || !ext || !ext->properties || !ext->num_properties)
> +	if (!psy || !dev || !ext || !ext->name || !ext->properties || !ext->nu=
m_properties)
>   		return -EINVAL;
>
>   	guard(rwsem_write)(&psy->extensions_sem);
>
> +	power_supply_for_each_extension(reg, psy)
> +		if (strcmp(ext->name, reg->ext->name) =3D=3D 0)
> +			return -EEXIST;
> +
>   	for (i =3D 0; i < ext->num_properties; i++)
>   		if (power_supply_has_property(psy, ext->properties[i]))
>   			return -EEXIST;
> @@ -1366,9 +1370,15 @@ int power_supply_register_extension(struct power_=
supply *psy, const struct power
>   		return -ENOMEM;
>
>   	reg->ext =3D ext;
> +	reg->dev =3D dev;
>   	reg->data =3D data;
>   	list_add(&reg->list_head, &psy->extensions);
>
> +	ret =3D sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension=
_group.name,
> +				      &dev->kobj, ext->name);
> +	if (ret)
> +		goto sysfs_link_failed;
> +
>   	ret =3D power_supply_update_sysfs_and_hwmon(psy);
>   	if (ret)
>   		goto sysfs_hwmon_failed;
> @@ -1376,6 +1386,8 @@ int power_supply_register_extension(struct power_s=
upply *psy, const struct power
>   	return 0;
>
>   sysfs_hwmon_failed:
> +	sysfs_remove_link_from_group(&psy->dev.kobj, power_supply_extension_gr=
oup.name, ext->name);
> +sysfs_link_failed:
>   	list_del(&reg->list_head);
>   	kfree(reg);
>   	return ret;
> @@ -1392,6 +1404,9 @@ void power_supply_unregister_extension(struct powe=
r_supply *psy, const struct po
>   		if (reg->ext =3D=3D ext) {
>   			list_del(&reg->list_head);
>   			kfree(reg);
> +			sysfs_remove_link_from_group(&psy->dev.kobj,
> +						     power_supply_extension_group.name,
> +						     reg->ext->name);
>   			power_supply_update_sysfs_and_hwmon(psy);
>   			return;
>   		}
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/s=
upply/power_supply_sysfs.c
> index 927ddb9d83bb7259809ba695cb9398d1ad654b46..aadc41ca741d8acd27a83f6b=
d01d578d7877e7c2 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -421,8 +421,18 @@ static const struct attribute_group power_supply_at=
tr_group =3D {
>   	.is_visible =3D power_supply_attr_is_visible,
>   };
>
> +static struct attribute *power_supply_extension_attrs[] =3D {
> +	NULL
> +};
> +
> +const struct attribute_group power_supply_extension_group =3D {
> +	.name =3D "extensions",
> +	.attrs =3D power_supply_extension_attrs,
> +};
> +
>   const struct attribute_group *power_supply_attr_groups[] =3D {
>   	&power_supply_attr_group,
> +	&power_supply_extension_group,
>   	NULL
>   };
>
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/te=
st_power.c
> index 66f9ef52e0f3e6e6e6bebcfd438c2acd421284ec..2a975a110f4859a77f768936=
9675f2008816d704 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -293,6 +293,7 @@ static int test_power_battery_extproperty_is_writeab=
le(struct power_supply *psy,
>   }
>
>   static const struct power_supply_ext test_power_battery_ext =3D {
> +	.name			=3D "test_power",
>   	.properties		=3D test_power_battery_extprops,
>   	.num_properties		=3D ARRAY_SIZE(test_power_battery_extprops),
>   	.get_property		=3D test_power_battery_extget_property,
> @@ -307,7 +308,8 @@ static void test_power_configure_battery_extension(b=
ool enable)
>   	psy =3D test_power_supplies[TEST_BATTERY];
>
>   	if (enable) {
> -		if (power_supply_register_extension(psy, &test_power_battery_ext, NUL=
L)) {
> +		if (power_supply_register_extension(psy, &test_power_battery_ext, &ps=
y->dev,
> +						    NULL)) {
>   			pr_err("registering battery extension failed\n");
>   			return;
>   		}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index e434516086f032cdb4698005bb1a99eda303a307..88a7bd34c8a74d694013aaae=
bd30269b30509e8b 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -284,6 +284,7 @@ struct power_supply_desc {
>   };
>
>   struct power_supply_ext {
> +	const char *const name;
>   	u8 charge_behaviours;
>   	const enum power_supply_property *properties;
>   	size_t num_properties;
> @@ -907,6 +908,7 @@ extern int power_supply_powers(struct power_supply *=
psy, struct device *dev);
>   extern int __must_check
>   power_supply_register_extension(struct power_supply *psy,
>   				const struct power_supply_ext *ext,
> +				struct device *dev,
>   				void *data);
>   extern void power_supply_unregister_extension(struct power_supply *psy=
,
>   					      const struct power_supply_ext *ext);
>

