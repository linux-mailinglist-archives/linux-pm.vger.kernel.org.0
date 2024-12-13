Return-Path: <linux-pm+bounces-19225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888DA9F1957
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 23:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CA21885A6B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D341AC892;
	Fri, 13 Dec 2024 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YC6E2v5L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739D1990CE;
	Fri, 13 Dec 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130118; cv=none; b=OeEpPZNbC8ld+db1nUh+zuxoZqrro1XpXFKohbZUgcM6QttC4rjHhCnOxNcZEeqxCeFf19opK9l/a+R5aJVdaKkq7K+knwnBYPvR4yitWC6Vhkg2rw+i7gh1ywICKw7TUi4G4zdi+3RC+gsoQyHi9SpIZM5HrPEoQ74/8sfq5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130118; c=relaxed/simple;
	bh=NVqn34lQz0qxBCcRweDqlz3pBkV8s6n9cmqHeLBwoj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBz80vesgIpP5yHUg5KpXgfIWUBK+LUvVCNenhe26CDvmizbkZe+bdSZuTOfOq4J2dTwKaujGtqv44UR/kCSm8vewNuCWEwekgs7b85KvPYWJuK6bAPHW2Behw9utTDffeeYVebMkOkXK7HRWV1sZQgyKmr6hlr2CTQ8eq8I7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YC6E2v5L; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734130101; x=1734734901; i=w_armin@gmx.de;
	bh=kR8McQF8jCB3lidjJPAkJDdipxs3GUEb5dHMZbFgMFs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YC6E2v5Lwbo329WjSaQsaA4r24n1SntIBK7kOpogMLN/hTe91i9/m9nH2vGqxv9R
	 TBC1Jh3Cd1Q+pFIjFQ4m5jNusMwMsLAMuppdQKJ1ykGkKSyD4MIPhIiW8fEpB83bO
	 mdps21IL8y2Z58iWYpklXUEKxWAGglgCjYatTId8yQ//POxNHNTK67U14Fz781JL5
	 X2QVjT3rlotkEpNagsgRO3FVUJwWTV1+Cz5IlcCs8wBl9NS4a7FTAFY3cnHERUVfr
	 pMoljYOq5qwCkSjKymGMOZqdl1b73QMCNT/SV4I48EzNT7bct6p76Nug6AQPxFSjr
	 7eR+V9VxsDZch4BEXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1tPU6D0JvQ-00DULu; Fri, 13
 Dec 2024 23:48:21 +0100
Message-ID: <bcf68c62-22d9-4b32-abe1-7a0fb13afdd5@gmx.de>
Date: Fri, 13 Dec 2024 23:48:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] power: supply: core: implement extension API
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-pm@vger.kernel.org
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-1-9d9dc3f3d387@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241211-power-supply-extensions-v6-1-9d9dc3f3d387@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iq9mnyqCyiKaOgHORb4vOjwM1GC8xYHr0zvMtfrVHtvYXEeSR3F
 S8BVJ0UeL0Sz1xKwKbQvGBsKteRrwLzn8aARWHqypUNQpXCqJDXbByrHqB2D6ETwF/X9Lir
 u5tCB33cFlfzajq3+5ql3tAQyveqfLcKjOMy/1FvKwm/9hxnNBULz5YHACSuqx98wlxceju
 BnDvkwSOBt2hJbJ8luIIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rcWRFsqaaIo=;CgXdJj2WJL+6DZjgrXPk62neBVM
 nxWxAm53C4PqldZSyQIH5SzU4zQTS37DX9k2xmiN10SeExUnhfimLTlAL7k0G/Voq4nMrezz9
 IB3t01/Syj9Y3eEVHQ9ZhOTnLiulszx7FKAdB7DA7RPaRlZilDQt2l/zyqTl8PL88+VTH++88
 nnvGh7xDY8Az3TJbjGmVjduo9RU1Qfxtjt2GlQJjrpPItNXmenLKWmv3q5+Zq7MWYpjp1PQVV
 3LqD7QuLWNXdYTtp1d045kL7dZsDTV6U1IwGOfuC/Eeb1WkIbdwJHl7KeajggSa2D7Q3oyRil
 SUrqxUtepMGAnqlGBLYi6KGF8QfwbbfCRqbX0qLbvHqcfbYSZic7O6iKOH9rfmnro7OSaheXQ
 K/u/rGocB7sMwy9xWNNkLi+aep+OdhW/E/T5rPqX6RRP8UcA9530G+dgRS3Nwrmz+1B7WcNPk
 5KyVRB179ax6yxbmSEBmixjS6ZG7ZIsmWIuu0U1ViBIB/0YOf9hfH8pImJYEwnIN5A4wEPQRG
 Q5VG6pkjZ4FflEK4ncA8Py9WVQ5r2P2ehpoFkGkiuOWiyR38/rvkfK0adNQ9W0qdjvi9YR9+2
 cu43HYr+/6zFLgaYs/fRCFsuArvtifQsdkNJjiLkPgxJPoR+46dI/FjrFZyumv/jXvYS4Ndlv
 l7GjfgKKLUqegMGvVKMr4Tlwi0KXUnhFq19lgqJW8dkFxzez18rwFgMh3IKMRBbUGHA3Fbw3G
 fCiAxwdAd12oQEg+43rEj2cJ48mU84BSncmZlUIutbmSFMoUX8Qr9UtyrCKasIPFUXabVkVSC
 VF9A8hViuyx7Tpno8bXQ0ceSv3t6K9B0GzOl4Dharddbmzu78MUFfKjVWb7zdibQDnEE34UY+
 Aschsl0G39NXWtqwH2JnPMngg3LUkBga9pX4I7WzsVNuWm7vOLxH49uMVlHrZvcSqlWl47+eK
 SbmmB/kgN9oxhsfJEaJhk2aUqckjHQqMSgTuiRj/pl1jLVj8EiVtUBfCyymS+sALQOrASBcYf
 WbgJK9dRyJiu15sjMqKjzUv/4FgDJDRjL8Fou6rWcGrbT71l8pF8B3MHbw8KKZcWOD57yMKAU
 Kd1Sjm/D38pBmjten1KlpYj/shYCZR

Am 11.12.24 um 20:57 schrieb Thomas Wei=C3=9Fschuh:

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

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>   drivers/power/supply/power_supply.h       |  17 ++++
>   drivers/power/supply/power_supply_core.c  | 162 ++++++++++++++++++++++=
++++++--
>   drivers/power/supply/power_supply_sysfs.c |  26 ++++-
>   include/linux/power_supply.h              |  33 ++++++
>   4 files changed, 228 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/=
power_supply.h
> index 5dabbd895538003096b62d03fdd0201b82b090e6..531785516d2ac31f9a7f73a5=
8e15e64cb81820ed 100644
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
> @@ -17,6 +19,21 @@ extern int power_supply_property_is_writeable(struct =
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
> +/* Make sure that the macro is a single expression */
> +#define power_supply_for_each_extension(pos, psy)			\
> +	if ( ({ lockdep_assert_held(&(psy)->extensions_sem); 0; }) )	\
> +		;							\
> +	else								\
> +		list_for_each_entry(pos, &(psy)->extensions, list_head)	\
>
>   #ifdef CONFIG_SYSFS
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/su=
pply/power_supply_core.c
> index 502b07468b93dfb7f5a6c2092588d931a7d015f2..bc22edbd0e6a02c275001320=
75f5c98d814a7330 100644
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
> @@ -1196,15 +1207,34 @@ static bool psy_desc_has_property(const struct p=
ower_supply_desc *psy_desc,
>   	return found;
>   }
>
> +bool power_supply_ext_has_property(const struct power_supply_ext *psy_e=
xt,
> +				   enum power_supply_property psp)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < psy_ext->num_properties; i++)
> +		if (psy_ext->properties[i] =3D=3D psp)
> +			return true;
> +
> +	return false;
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
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp))
> +			return true;
> +	}
> +
>   	return false;
>   }
>
> @@ -1212,12 +1242,21 @@ int power_supply_get_property(struct power_suppl=
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
> +	scoped_guard(rwsem_read, &psy->extensions_sem) {
> +		power_supply_for_each_extension(reg, psy) {
> +			if (power_supply_ext_has_property(reg->ext, psp))
> +				return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> +		}
> +	}
> +
>   	if (psy_desc_has_property(psy->desc, psp))
>   		return psy->desc->get_property(psy, psp, val);
>   	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> @@ -1231,7 +1270,24 @@ int power_supply_set_property(struct power_supply=
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
> +	scoped_guard(rwsem_read, &psy->extensions_sem) {
> +		power_supply_for_each_extension(reg, psy) {
> +			if (power_supply_ext_has_property(reg->ext, psp)) {
> +				if (reg->ext->set_property)
> +					return reg->ext->set_property(psy, reg->ext, reg->data,
> +								      psp, val);
> +				else
> +					return -ENODEV;
> +			}
> +		}
> +	}
> +
> +	if (!psy->desc->set_property)
>   		return -ENODEV;
>
>   	return psy->desc->set_property(psy, psp, val);
> @@ -1241,7 +1297,22 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
>   int power_supply_property_is_writeable(struct power_supply *psy,
>   					enum power_supply_property psp)
>   {
> -	return psy->desc->property_is_writeable && psy->desc->property_is_writ=
eable(psy, psp);
> +	struct power_supply_ext_registration *reg;
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->property_is_writeable)
> +				return reg->ext->property_is_writeable(psy, reg->ext,
> +								       reg->data, psp);
> +			else
> +				return 0;
> +		}
> +	}
> +
> +	if (!psy->desc->property_is_writeable)
> +		return 0;
> +
> +	return psy->desc->property_is_writeable(psy, psp);
>   }
>
>   void power_supply_external_power_changed(struct power_supply *psy)
> @@ -1260,6 +1331,76 @@ int power_supply_powers(struct power_supply *psy,=
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
> +}
> +
> +int power_supply_register_extension(struct power_supply *psy, const str=
uct power_supply_ext *ext,
> +				    void *data)
> +{
> +	struct power_supply_ext_registration *reg;
> +	size_t i;
> +	int ret;
> +
> +	if (!psy || !ext || !ext->properties || !ext->num_properties)
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&psy->extensions_sem);
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
> +	ret =3D power_supply_update_sysfs_and_hwmon(psy);
> +	if (ret)
> +		goto sysfs_hwmon_failed;
> +
> +	return 0;
> +
> +sysfs_hwmon_failed:
> +	list_del(&reg->list_head);
> +	kfree(reg);
> +	return ret;
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
> @@ -1414,6 +1555,9 @@ __power_supply_register(struct device *parent,
>   	}
>
>   	spin_lock_init(&psy->changed_lock);
> +	init_rwsem(&psy->extensions_sem);
> +	INIT_LIST_HEAD(&psy->extensions);
> +
>   	rc =3D device_add(dev);
>   	if (rc)
>   		goto device_add_failed;
> @@ -1426,13 +1570,15 @@ __power_supply_register(struct device *parent,
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
> index 99bfe1f03eb8326d38c4e2831c9670313b42e425..927ddb9d83bb7259809ba695=
cb9398d1ad654b46 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -268,6 +268,27 @@ static ssize_t power_supply_show_enum_with_availabl=
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
> +	scoped_guard(rwsem_read, &psy->extensions_sem) {
> +		power_supply_for_each_extension(reg, psy) {
> +			if (power_supply_ext_has_property(reg->ext,
> +							  POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR))
> +				return power_supply_charge_behaviour_show(dev,
> +						reg->ext->charge_behaviours,
> +						value->intval, buf);
> +		}
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
> @@ -307,8 +328,7 @@ static ssize_t power_supply_format_property(struct d=
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
> @@ -385,6 +405,8 @@ static umode_t power_supply_attr_is_visible(struct k=
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
> index b98106e1a90f34bce5129317a099f363248342b9..e434516086f032cdb4698005=
bb1a99eda303a307 100644
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
> @@ -878,6 +904,13 @@ devm_power_supply_register(struct device *parent,
>   extern void power_supply_unregister(struct power_supply *psy);
>   extern int power_supply_powers(struct power_supply *psy, struct device=
 *dev);
>
> +extern int __must_check
> +power_supply_register_extension(struct power_supply *psy,
> +				const struct power_supply_ext *ext,
> +				void *data);
> +extern void power_supply_unregister_extension(struct power_supply *psy,
> +					      const struct power_supply_ext *ext);
> +
>   #define to_power_supply(device) container_of(device, struct power_supp=
ly, dev)
>
>   extern void *power_supply_get_drvdata(struct power_supply *psy);
>

