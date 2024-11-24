Return-Path: <linux-pm+bounces-18008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20909D7733
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 19:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1647282978
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED63F9D2;
	Sun, 24 Nov 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mbfWYdOl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AB2500AF;
	Sun, 24 Nov 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472161; cv=none; b=HcVTWVwrkdr+4ZCPaOW9FV8DJ0mmidlc8/R3ZkT0RI1nU+YnGgBjcV7zwVVw6Z1YCn0XHSA+wiLbp3IAUOqVeN8EWvnXodEDNJULR6iVWOanXAW1Q4vL0/R9pUM/194SfL5T5MSnw7Et4l2Q2sFaXL5Kg/YDYMxZFbKovggmw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472161; c=relaxed/simple;
	bh=VT6OEDno3ADIaU4wCzIpE1gSLqK6rvW4nFrS+N9J1W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQXpQQfJ8LpVF/Et7Pai4rDQVJcCdlmDYuip/PxEscKIEhhQve2L6+nTu+GZPeJEaddN2WwkIdYnuJEH6Gc/+h71n9h+RM32Y+RUMKbfXx3Ppg1289mzv6wTPuf0wTh4N5jAqjQaE/i0qYqpuk045Cdy3KmJ3JnmbF7a5/4lpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mbfWYdOl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732472147; x=1733076947; i=w_armin@gmx.de;
	bh=5HhAmy5sW1bJaXAa0VtwBDTTGbcW0yIg+LgI+SYtm24=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mbfWYdOlBZOXIncapHKWR6fr1aKpN4wqQNbmjITv0RDH1M9VR3XfgEva1hlfavKM
	 td7m2fnbo0Ly0obYVA2idUGm5sqCJEboPbS7Q2LqD5hs9p9Zgncojxc+7TxMuqsdK
	 XxJLOieZeILSIcCnSPLFenmeXcRh1iyO1XGUYxglLCTM9ejwhBXSM7q+Ej11to3cR
	 pwbm4UdsESozUJVbFo7cRDE0/XxCYb2WtxL3cRQUqWGFtUQz21qb2/uyGONP8bUSj
	 uXifMj4m3Wlp9qLFkE2Xi+c59qcSaG8wQKBQhTj5XHpk2PEiN/2+7SdGqcWCsO7jA
	 rIFQ+skjTkmLEwtYeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1tobxr0iJs-00altk; Sun, 24
 Nov 2024 19:15:47 +0100
Message-ID: <13eb4319-b323-463a-99af-db3fa9e5508b@gmx.de>
Date: Sun, 24 Nov 2024 19:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] power: supply: core: implement extension API
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-7-7240144daa8e@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241111-power-supply-extensions-v4-7-7240144daa8e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fa7jtuFGVE6u4S7I7P2TEWtyVFWH0/REETXcyNZ7TtfVRncIOiB
 nk3YNvuikwQ+aCdAe1LdLikEc4y88HX5XLAnx6XkdNlgvSGKG7e6QoKr9L86xcVDnq3lGHG
 GYgwZzuICujaNJIyHrUm+cA+Gm+BLvXoB9346kCevj5Oy0kOQR9wPsiBHpSNSslwQzCE6FV
 Rh9BvdMuZaUUXuTD33KEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fW7L0aL3kdU=;9V8JAHhlV/Wq+HOHAlkcjjvBhzC
 4BZ9RsDKJrrPPx4aj60NxLHDrByqgiT6BFhL/vSjOGeDUK8g10G8imdYfu3MB7vCVPMCoEpMO
 kNlOZxxcuGsYLm49w/+m5hW58Bf52nUPUAMkgkqLHQ2rublc4VtzYFksl2+Qx7CniK9mwTwux
 OhVJ4q1BaJdA3To0A/AUJBbYmBSOF6OeFNjX1XIioGMcFHAj6MKM6222b1TXlS2IH8yMua2QJ
 PTi2dcBUnO+s0ecHF/J63ylc1RrvFO3jNLg1obNe9ox0rDy3508q5ptsip2B0667T7tDjDO/W
 wZl8zEb9nW1Atxd7ZeUJGIZ7fIrlWGjBSYLsoqaTqYi+7tPytUEdEkaAy26kZZ5o0TAHg1chF
 t5JJIkz9HbuTGg5uLPO3RaeDOxVtBE5ESl3BQVBW9pSa5UDL4TjzhTtGnlDEIqL4VElzWKkZQ
 T7f8R71hV/aDuyzOV/iUrxVH2O48empM3vcpfOLdg6hUyPjNAPo+IKcqWD4sU3Z1BJLbWzSod
 P/LEw+GTQYHacZ+37VfQXeE5cKyDA09YkXsxREO26gcRMiGJWHyfEDbTxydrBqU+maxVtiP/B
 yMCUwHGIYOz9lK/sXPhtk1p0jP14476C+4/nbco9mn0pSLbkjhXcW6JUVzfIFAVDifa8DkdVS
 7g5wV2GWzz0q6Ah+RwgiIYbCyRI4aAjzJRRcGj/9Gm7SyWqT46+KC7Bo3WrC7XzvBVg0zr5fL
 exF9pWM+nI0Edw8mYGS8E/wgMoZNsHNMugvBQ/IGje6vgEPIEpnCsALRdTzmHhRWfsqkf8LnW
 ZtAWrOzEmeuFgz2IySMkfs0Xg0MvVAkr92/7So3AZZRgltiIDAWqFOlUVgtMLSPe4RLgGVF7C
 MgWBMj3NioRo7XSeSIh1t0Be1tdloweYiFdmKGT8XYWjSWRrKN2kZIcqWKxaOFSNBukqggjYX
 yWGfxMOkNwVIoyGJQe0ims9Fcjeox/2X3am3qMnLPLpMsLmDcHfZVaxuUAZ36r2ta77zyjj92
 KqkXHXEDwvnbu0cpmTVxBa4fzew9r+J+6EKEwUeXe+0ftZ9XB/sMtREjavXrDmvuCvAB4rJZq
 2/i0UFFVw8+MgoRwmp6BcS7ZAoXHkF

Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:

> Various drivers, mostly in platform/x86 extend the ACPI battery driver
> with additional sysfs attributes to implement more UAPIs than are
> exposed through ACPI by using various side-channels, like WMI,
> nonstandard ACPI or EC communication.
>
> While the created sysfs attributes look similar to the attributes
> provided by the powersupply core, there are various deficiencies:
>
> * They don't show up in uevent payload.
> * They can't be queried with the standard in-kernel APIs.
> * They don't work with triggers.
> * The extending driver has to reimplement all of the parsing,
> formatting and sysfs display logic.
> * Writing a extension driver is completely different from writing a
> normal power supply driver.
>
> This extension API avoids all of these issues.
> An extension is just a "struct power_supply_ext" with the same kind of
> callbacks as in a normal "struct power_supply_desc".
>
> The API is meant to be used via battery_hook_register(), the same way as
> the current extensions.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>   drivers/power/supply/power_supply.h       |  14 +++
>   drivers/power/supply/power_supply_core.c  | 155 ++++++++++++++++++++++=
++++++--
>   drivers/power/supply/power_supply_sysfs.c |  22 ++++-
>   include/linux/power_supply.h              |  32 ++++++
>   4 files changed, 213 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/=
power_supply.h
> index 5dabbd895538003096b62d03fdd0201b82b090e6..4c3e602c416cec556173a8eb=
1a3114c13ded71b7 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -9,6 +9,8 @@
>    *  Modified: 2004, Oct     Szabolcs Gyurko
>    */
>
> +#include <linux/lockdep.h>
> +
>   struct device;
>   struct device_type;
>   struct power_supply;
> @@ -17,6 +19,18 @@ extern int power_supply_property_is_writeable(struct =
power_supply *psy,
>   					      enum power_supply_property psp);
>   extern bool power_supply_has_property(struct power_supply *psy,
>   				      enum power_supply_property psp);
> +extern bool power_supply_ext_has_property(const struct power_supply_ext=
 *ext,
> +					  enum power_supply_property psp);
> +
> +struct power_supply_ext_registration {
> +	struct list_head list_head;
> +	const struct power_supply_ext *ext;
> +	void *data;
> +};
> +
> +#define power_supply_for_each_extension(pos, psy) \
> +	lockdep_assert_held(&(psy)->extensions_sem); \
> +	list_for_each_entry(pos, &(psy)->extensions, list_head)
>
>   #ifdef CONFIG_SYSFS
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/su=
pply/power_supply_core.c
> index 502b07468b93dfb7f5a6c2092588d931a7d015f2..bf3054ed034e091adefcdbf9=
8873a108b4c90fde 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -81,6 +81,7 @@ static int __power_supply_changed_work(struct device *=
dev, void *data)
>
>   static void power_supply_changed_work(struct work_struct *work)
>   {
> +	int ret;
>   	unsigned long flags;
>   	struct power_supply *psy =3D container_of(work, struct power_supply,
>   						changed_work);
> @@ -88,6 +89,16 @@ static void power_supply_changed_work(struct work_str=
uct *work)
>   	dev_dbg(&psy->dev, "%s\n", __func__);
>
>   	spin_lock_irqsave(&psy->changed_lock, flags);
> +
> +	if (unlikely(psy->update_groups)) {
> +		psy->update_groups =3D false;
> +		spin_unlock_irqrestore(&psy->changed_lock, flags);
> +		ret =3D sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.gro=
ups);
> +		if (ret)
> +			dev_warn(&psy->dev, "failed to update sysfs groups: %pe\n", ERR_PTR(=
ret));
> +		spin_lock_irqsave(&psy->changed_lock, flags);
> +	}
> +
>   	/*
>   	 * Check 'changed' here to avoid issues due to race between
>   	 * power_supply_changed() and this routine. In worst case
> @@ -1196,15 +1207,37 @@ static bool psy_desc_has_property(const struct p=
ower_supply_desc *psy_desc,
>   	return found;
>   }
>
> +bool power_supply_ext_has_property(const struct power_supply_ext *psy_e=
xt,
> +				   enum power_supply_property psp)
> +{
> +	bool found =3D false;
> +	int i;
> +
> +	for (i =3D 0; i < psy_ext->num_properties; i++) {
> +		if (psy_ext->properties[i] =3D=3D psp) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	return found;

Can we just return false here and directly return true when the property i=
s found?

> +}
> +
>   bool power_supply_has_property(struct power_supply *psy,
>   			       enum power_supply_property psp)
>   {
> +	struct power_supply_ext_registration *reg;
> +
>   	if (psy_desc_has_property(psy->desc, psp))
>   		return true;
>
>   	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>   		return true;
>
> +	power_supply_for_each_extension(reg, psy)
> +		if (power_supply_ext_has_property(reg->ext, psp))
> +			return true;
> +
>   	return false;
>   }
>
> @@ -1212,12 +1245,21 @@ int power_supply_get_property(struct power_suppl=
y *psy,
>   			    enum power_supply_property psp,
>   			    union power_supply_propval *val)
>   {
> +	struct power_supply_ext_registration *reg;
> +
>   	if (atomic_read(&psy->use_cnt) <=3D 0) {
>   		if (!psy->initialized)
>   			return -EAGAIN;
>   		return -ENODEV;
>   	}
>
> +	guard(rwsem_read)(&psy->extensions_sem);
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp))
> +			return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> +	}

Maybe we can use scoped_guard() here?

> +
>   	if (psy_desc_has_property(psy->desc, psp))
>   		return psy->desc->get_property(psy, psp, val);
>   	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> @@ -1231,7 +1273,23 @@ int power_supply_set_property(struct power_supply=
 *psy,
>   			    enum power_supply_property psp,
>   			    const union power_supply_propval *val)
>   {
> -	if (atomic_read(&psy->use_cnt) <=3D 0 || !psy->desc->set_property)
> +	struct power_supply_ext_registration *reg;
> +
> +	if (atomic_read(&psy->use_cnt) <=3D 0)
> +		return -ENODEV;
> +
> +	guard(rwsem_read)(&psy->extensions_sem);
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->set_property)
> +				return reg->ext->set_property(psy, reg->ext, reg->data, psp, val);
> +			else
> +				return -ENODEV;
> +		}
> +	}

Same as above.

> +
> +	if (!psy->desc->set_property)
>   		return -ENODEV;
>
>   	return psy->desc->set_property(psy, psp, val);
> @@ -1241,7 +1299,22 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
>   int power_supply_property_is_writeable(struct power_supply *psy,
>   					enum power_supply_property psp)
>   {
> -	return psy->desc->property_is_writeable && psy->desc->property_is_writ=
eable(psy, psp);
> +	struct power_supply_ext_registration *reg;
> +
> +	power_supply_for_each_extension(reg, psy) {

Missing guard here.

> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->property_is_writeable)
> +				return reg->ext->property_is_writeable(psy, reg->ext,
> +								       reg->data, psp);
> +			else
> +				return -ENODEV;
> +		}
> +	}
> +
> +	if (!psy->desc->property_is_writeable)
> +		return -ENODEV;
> +
> +	return psy->desc->property_is_writeable(psy, psp);
>   }
>
>   void power_supply_external_power_changed(struct power_supply *psy)
> @@ -1260,6 +1333,67 @@ int power_supply_powers(struct power_supply *psy,=
 struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(power_supply_powers);
>
> +static int power_supply_update_sysfs_and_hwmon(struct power_supply *psy=
)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&psy->changed_lock, flags);
> +	psy->update_groups =3D true;
> +	spin_unlock_irqrestore(&psy->changed_lock, flags);
> +
> +	power_supply_changed(psy);
> +
> +	power_supply_remove_hwmon_sysfs(psy);
> +	return power_supply_add_hwmon_sysfs(psy);

Do we need some locking here or is this ok?

> +}
> +
> +int power_supply_register_extension(struct power_supply *psy, const str=
uct power_supply_ext *ext,
> +				    void *data)
> +{
> +	struct power_supply_ext_registration *reg;
> +	size_t i;
> +
> +	guard(rwsem_write)(&psy->extensions_sem);
> +
> +	power_supply_for_each_extension(reg, psy)
> +		if (reg->ext =3D=3D ext)
> +			return -EEXIST;
> +
> +	for (i =3D 0; i < ext->num_properties; i++)
> +		if (power_supply_has_property(psy, ext->properties[i]))
> +			return -EEXIST;
> +
> +	reg =3D kmalloc(sizeof(*reg), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	reg->ext =3D ext;
> +	reg->data =3D data;
> +	list_add(&reg->list_head, &psy->extensions);
> +
> +	return power_supply_update_sysfs_and_hwmon(psy);

We need to clean up *reg here should power_supply_update_sysfs_and_hwmon()=
 fail.

> +}
> +EXPORT_SYMBOL_GPL(power_supply_register_extension);
> +
> +void power_supply_unregister_extension(struct power_supply *psy, const =
struct power_supply_ext *ext)
> +{
> +	struct power_supply_ext_registration *reg;
> +
> +	guard(rwsem_write)(&psy->extensions_sem);
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (reg->ext =3D=3D ext) {
> +			list_del(&reg->list_head);
> +			kfree(reg);
> +			power_supply_update_sysfs_and_hwmon(psy);
> +			return;
> +		}
> +	}
> +
> +	dev_warn(&psy->dev, "Trying to unregister invalid extension");
> +}
> +EXPORT_SYMBOL_GPL(power_supply_unregister_extension);
> +
>   static void power_supply_dev_release(struct device *dev)
>   {
>   	struct power_supply *psy =3D to_power_supply(dev);
> @@ -1414,6 +1548,9 @@ __power_supply_register(struct device *parent,
>   	}
>
>   	spin_lock_init(&psy->changed_lock);
> +	init_rwsem(&psy->extensions_sem);
> +	INIT_LIST_HEAD(&psy->extensions);
> +
>   	rc =3D device_add(dev);
>   	if (rc)
>   		goto device_add_failed;
> @@ -1426,13 +1563,15 @@ __power_supply_register(struct device *parent,
>   	if (rc)
>   		goto register_thermal_failed;
>
> -	rc =3D power_supply_create_triggers(psy);
> -	if (rc)
> -		goto create_triggers_failed;
> +	scoped_guard(rwsem_read, &psy->extensions_sem) {
> +		rc =3D power_supply_create_triggers(psy);
> +		if (rc)
> +			goto create_triggers_failed;
>
> -	rc =3D power_supply_add_hwmon_sysfs(psy);
> -	if (rc)
> -		goto add_hwmon_sysfs_failed;
> +		rc =3D power_supply_add_hwmon_sysfs(psy);
> +		if (rc)
> +			goto add_hwmon_sysfs_failed;
> +	}
>
>   	/*
>   	 * Update use_cnt after any uevents (most notably from device_add()).
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/s=
upply/power_supply_sysfs.c
> index 99bfe1f03eb8326d38c4e2831c9670313b42e425..2cf25bacd7a1bb66e5a72629=
bffaa6d16bfbf3be 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -268,6 +268,23 @@ static ssize_t power_supply_show_enum_with_availabl=
e(
>   	return count;
>   }
>
> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> +						  struct power_supply *psy,
> +						  union power_supply_propval *value,
> +						  char *buf)
> +{
> +	struct power_supply_ext_registration *reg;
> +

Missing guard here.

Thanks,
Armin Wolf

> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, POWER_SUPPLY_PROP_CHARGE_=
BEHAVIOUR))
> +			return power_supply_charge_behaviour_show(dev, reg->ext->charge_beha=
viours,
> +								  value->intval, buf);
> +	}
> +
> +	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behav=
iours,
> +						  value->intval, buf);
> +}
> +
>   static ssize_t power_supply_format_property(struct device *dev,
>   					    bool uevent,
>   					    struct device_attribute *attr,
> @@ -307,8 +324,7 @@ static ssize_t power_supply_format_property(struct d=
evice *dev,
>   	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
>   		if (uevent) /* no possible values in uevents */
>   			goto default_format;
> -		ret =3D power_supply_charge_behaviour_show(dev, psy->desc->charge_beh=
aviours,
> -							 value.intval, buf);
> +		ret =3D power_supply_show_charge_behaviour(dev, psy, &value, buf);
>   		break;
>   	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER=
:
>   		ret =3D sysfs_emit(buf, "%s\n", value.strval);
> @@ -385,6 +401,8 @@ static umode_t power_supply_attr_is_visible(struct k=
object *kobj,
>   	if (attrno =3D=3D POWER_SUPPLY_PROP_TYPE)
>   		return mode;
>
> +	guard(rwsem_read)(&psy->extensions_sem);
> +
>   	if (power_supply_has_property(psy, attrno)) {
>   		if (power_supply_property_is_writeable(psy, attrno) > 0)
>   			mode |=3D S_IWUSR;
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index b98106e1a90f34bce5129317a099f363248342b9..016e44cb3eb5eb7ace01a032=
661f65a5d81a522f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -15,6 +15,8 @@
>   #include <linux/device.h>
>   #include <linux/workqueue.h>
>   #include <linux/leds.h>
> +#include <linux/rwsem.h>
> +#include <linux/list.h>
>   #include <linux/spinlock.h>
>   #include <linux/notifier.h>
>
> @@ -281,6 +283,27 @@ struct power_supply_desc {
>   	int use_for_apm;
>   };
>
> +struct power_supply_ext {
> +	u8 charge_behaviours;
> +	const enum power_supply_property *properties;
> +	size_t num_properties;
> +
> +	int (*get_property)(struct power_supply *psy,
> +			    const struct power_supply_ext *ext,
> +			    void *data,
> +			    enum power_supply_property psp,
> +			    union power_supply_propval *val);
> +	int (*set_property)(struct power_supply *psy,
> +			    const struct power_supply_ext *ext,
> +			    void *data,
> +			    enum power_supply_property psp,
> +			    const union power_supply_propval *val);
> +	int (*property_is_writeable)(struct power_supply *psy,
> +				     const struct power_supply_ext *ext,
> +				     void *data,
> +				     enum power_supply_property psp);
> +};
> +
>   struct power_supply {
>   	const struct power_supply_desc *desc;
>
> @@ -300,10 +323,13 @@ struct power_supply {
>   	struct delayed_work deferred_register_work;
>   	spinlock_t changed_lock;
>   	bool changed;
> +	bool update_groups;
>   	bool initialized;
>   	bool removing;
>   	atomic_t use_cnt;
>   	struct power_supply_battery_info *battery_info;
> +	struct rw_semaphore extensions_sem; /* protects "extensions" */
> +	struct list_head extensions;
>   #ifdef CONFIG_THERMAL
>   	struct thermal_zone_device *tzd;
>   	struct thermal_cooling_device *tcd;
> @@ -878,6 +904,12 @@ devm_power_supply_register(struct device *parent,
>   extern void power_supply_unregister(struct power_supply *psy);
>   extern int power_supply_powers(struct power_supply *psy, struct device=
 *dev);
>
> +extern int power_supply_register_extension(struct power_supply *psy,
> +					   const struct power_supply_ext *ext,
> +					   void *data);
> +extern void power_supply_unregister_extension(struct power_supply *psy,
> +					      const struct power_supply_ext *ext);
> +
>   #define to_power_supply(device) container_of(device, struct power_supp=
ly, dev)
>
>   extern void *power_supply_get_drvdata(struct power_supply *psy);
>

