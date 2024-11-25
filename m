Return-Path: <linux-pm+bounces-18043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB89D821E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 10:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0406528197D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261118FDDF;
	Mon, 25 Nov 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KoCd3168"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48118FDC2;
	Mon, 25 Nov 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526545; cv=none; b=ue+hwAoYOidvikyE+CDkrO5RldbLL70Y9yFeaWVcJ2QauMoHzs+e5OBbLdzyCvHj+fyPFbWeXvgInjjbVvrJDWHtOacxCxJMLEiKTom044+CRwbyNuaCJE8/qv6eFHeBOP1bhhpM72ZgvRLR3nH2Ol88JpcBgYCGvRpUQLB9jAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526545; c=relaxed/simple;
	bh=0Sj+DV/BULHktvA9y4SynVHaj6n5NWrH7960UWW6q78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unfJb+63pk3C2CH0Bd5J/8+zd+ibBhO/YWGKuCdJpWBYcmOTrbBGfHxCRr2NjEmIbBL8YVW2wTAwXrUkRHXKZkUVSaRNELM+BRHEU7mTpQ/9nLMG9VGtpdYr0WYp8VRBWitHA0CMB2N84FGLExi0g7DZmguQDASc5EWspEa6GVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KoCd3168; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732526540;
	bh=0Sj+DV/BULHktvA9y4SynVHaj6n5NWrH7960UWW6q78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KoCd3168d0oYcemcyFX1jsvGqycXBTzMm+/R3wxCnzQ1mlCi4IZ66Mx8fT2crJLFZ
	 Hqm4eBm1mNcON+9vz5NOJF03IVgz4vkSNOflE1eOtRdNX3ANnIkWS29GyahzmvJKSC
	 LR01I+F5IhJ7eghM0VO/C2PxcwTjcib4t7BRyg0Q=
Date: Mon, 25 Nov 2024 10:22:19 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 7/9] power: supply: core: implement extension API
Message-ID: <ee92cbbd-a4f1-40d4-bf90-a6cee2f3ebe5@t-8ch.de>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-7-7240144daa8e@weissschuh.net>
 <13eb4319-b323-463a-99af-db3fa9e5508b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13eb4319-b323-463a-99af-db3fa9e5508b@gmx.de>

On 2024-11-24 19:15:45+0100, Armin Wolf wrote:
> Am 11.11.24 um 22:40 schrieb Thomas Weißschuh:
> 
> > Various drivers, mostly in platform/x86 extend the ACPI battery driver
> > with additional sysfs attributes to implement more UAPIs than are
> > exposed through ACPI by using various side-channels, like WMI,
> > nonstandard ACPI or EC communication.
> > 
> > While the created sysfs attributes look similar to the attributes
> > provided by the powersupply core, there are various deficiencies:
> > 
> > * They don't show up in uevent payload.
> > * They can't be queried with the standard in-kernel APIs.
> > * They don't work with triggers.
> > * The extending driver has to reimplement all of the parsing,
> > formatting and sysfs display logic.
> > * Writing a extension driver is completely different from writing a
> > normal power supply driver.
> > 
> > This extension API avoids all of these issues.
> > An extension is just a "struct power_supply_ext" with the same kind of
> > callbacks as in a normal "struct power_supply_desc".
> > 
> > The API is meant to be used via battery_hook_register(), the same way as
> > the current extensions.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   drivers/power/supply/power_supply.h       |  14 +++
> >   drivers/power/supply/power_supply_core.c  | 155 ++++++++++++++++++++++++++++--
> >   drivers/power/supply/power_supply_sysfs.c |  22 ++++-
> >   include/linux/power_supply.h              |  32 ++++++
> >   4 files changed, 213 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> > index 5dabbd895538003096b62d03fdd0201b82b090e6..4c3e602c416cec556173a8eb1a3114c13ded71b7 100644
> > --- a/drivers/power/supply/power_supply.h
> > +++ b/drivers/power/supply/power_supply.h
> > @@ -9,6 +9,8 @@
> >    *  Modified: 2004, Oct     Szabolcs Gyurko
> >    */
> > 
> > +#include <linux/lockdep.h>
> > +
> >   struct device;
> >   struct device_type;
> >   struct power_supply;
> > @@ -17,6 +19,18 @@ extern int power_supply_property_is_writeable(struct power_supply *psy,
> >   					      enum power_supply_property psp);
> >   extern bool power_supply_has_property(struct power_supply *psy,
> >   				      enum power_supply_property psp);
> > +extern bool power_supply_ext_has_property(const struct power_supply_ext *ext,
> > +					  enum power_supply_property psp);
> > +
> > +struct power_supply_ext_registration {
> > +	struct list_head list_head;
> > +	const struct power_supply_ext *ext;
> > +	void *data;
> > +};
> > +
> > +#define power_supply_for_each_extension(pos, psy) \
> > +	lockdep_assert_held(&(psy)->extensions_sem); \
> > +	list_for_each_entry(pos, &(psy)->extensions, list_head)
> > 
> >   #ifdef CONFIG_SYSFS
> > 
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > index 502b07468b93dfb7f5a6c2092588d931a7d015f2..bf3054ed034e091adefcdbf98873a108b4c90fde 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -81,6 +81,7 @@ static int __power_supply_changed_work(struct device *dev, void *data)
> > 
> >   static void power_supply_changed_work(struct work_struct *work)
> >   {
> > +	int ret;
> >   	unsigned long flags;
> >   	struct power_supply *psy = container_of(work, struct power_supply,
> >   						changed_work);
> > @@ -88,6 +89,16 @@ static void power_supply_changed_work(struct work_struct *work)
> >   	dev_dbg(&psy->dev, "%s\n", __func__);
> > 
> >   	spin_lock_irqsave(&psy->changed_lock, flags);
> > +
> > +	if (unlikely(psy->update_groups)) {
> > +		psy->update_groups = false;
> > +		spin_unlock_irqrestore(&psy->changed_lock, flags);
> > +		ret = sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.groups);
> > +		if (ret)
> > +			dev_warn(&psy->dev, "failed to update sysfs groups: %pe\n", ERR_PTR(ret));
> > +		spin_lock_irqsave(&psy->changed_lock, flags);
> > +	}
> > +
> >   	/*
> >   	 * Check 'changed' here to avoid issues due to race between
> >   	 * power_supply_changed() and this routine. In worst case
> > @@ -1196,15 +1207,37 @@ static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
> >   	return found;
> >   }
> > 
> > +bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
> > +				   enum power_supply_property psp)
> > +{
> > +	bool found = false;
> > +	int i;
> > +
> > +	for (i = 0; i < psy_ext->num_properties; i++) {
> > +		if (psy_ext->properties[i] == psp) {
> > +			found = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return found;
> 
> Can we just return false here and directly return true when the property is found?

Yes, this was just the existing logic from psy_has_propery().
But I don't care either way.

> > +}
> > +
> >   bool power_supply_has_property(struct power_supply *psy,
> >   			       enum power_supply_property psp)
> >   {
> > +	struct power_supply_ext_registration *reg;
> > +
> >   	if (psy_desc_has_property(psy->desc, psp))
> >   		return true;
> > 
> >   	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> >   		return true;
> > 
> > +	power_supply_for_each_extension(reg, psy)
> > +		if (power_supply_ext_has_property(reg->ext, psp))
> > +			return true;
> > +
> >   	return false;
> >   }
> > 
> > @@ -1212,12 +1245,21 @@ int power_supply_get_property(struct power_supply *psy,
> >   			    enum power_supply_property psp,
> >   			    union power_supply_propval *val)
> >   {
> > +	struct power_supply_ext_registration *reg;
> > +
> >   	if (atomic_read(&psy->use_cnt) <= 0) {
> >   		if (!psy->initialized)
> >   			return -EAGAIN;
> >   		return -ENODEV;
> >   	}
> > 
> > +	guard(rwsem_read)(&psy->extensions_sem);
> > +
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (power_supply_ext_has_property(reg->ext, psp))
> > +			return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> > +	}
> 
> Maybe we can use scoped_guard() here?

Ack. 

> 
> > +
> >   	if (psy_desc_has_property(psy->desc, psp))
> >   		return psy->desc->get_property(psy, psp, val);
> >   	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> > @@ -1231,7 +1273,23 @@ int power_supply_set_property(struct power_supply *psy,
> >   			    enum power_supply_property psp,
> >   			    const union power_supply_propval *val)
> >   {
> > -	if (atomic_read(&psy->use_cnt) <= 0 || !psy->desc->set_property)
> > +	struct power_supply_ext_registration *reg;
> > +
> > +	if (atomic_read(&psy->use_cnt) <= 0)
> > +		return -ENODEV;
> > +
> > +	guard(rwsem_read)(&psy->extensions_sem);
> > +
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (power_supply_ext_has_property(reg->ext, psp)) {
> > +			if (reg->ext->set_property)
> > +				return reg->ext->set_property(psy, reg->ext, reg->data, psp, val);
> > +			else
> > +				return -ENODEV;
> > +		}
> > +	}
> 
> Same as above.

Ack.
> > +
> > +	if (!psy->desc->set_property)
> >   		return -ENODEV;
> > 
> >   	return psy->desc->set_property(psy, psp, val);
> > @@ -1241,7 +1299,22 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
> >   int power_supply_property_is_writeable(struct power_supply *psy,
> >   					enum power_supply_property psp)
> >   {
> > -	return psy->desc->property_is_writeable && psy->desc->property_is_writeable(psy, psp);
> > +	struct power_supply_ext_registration *reg;
> > +
> > +	power_supply_for_each_extension(reg, psy) {
> 
> Missing guard here.

The sysfs caller already has the lock, so it can't be taken inside.
But the hwmon caller doesn't, so there needs to be locking there.

I'll add some explicit lockdep assertions to make it easier to see.

> > +		if (power_supply_ext_has_property(reg->ext, psp)) {
> > +			if (reg->ext->property_is_writeable)
> > +				return reg->ext->property_is_writeable(psy, reg->ext,
> > +								       reg->data, psp);
> > +			else
> > +				return -ENODEV;
> > +		}
> > +	}
> > +
> > +	if (!psy->desc->property_is_writeable)
> > +		return -ENODEV;
> > +
> > +	return psy->desc->property_is_writeable(psy, psp);
> >   }
> > 
> >   void power_supply_external_power_changed(struct power_supply *psy)
> > @@ -1260,6 +1333,67 @@ int power_supply_powers(struct power_supply *psy, struct device *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(power_supply_powers);
> > 
> > +static int power_supply_update_sysfs_and_hwmon(struct power_supply *psy)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&psy->changed_lock, flags);
> > +	psy->update_groups = true;
> > +	spin_unlock_irqrestore(&psy->changed_lock, flags);
> > +
> > +	power_supply_changed(psy);
> > +
> > +	power_supply_remove_hwmon_sysfs(psy);
> > +	return power_supply_add_hwmon_sysfs(psy);
> 
> Do we need some locking here or is this ok?

This should be fine. All callers hold the lock.
As above, I'll fix the name and add explicit lockdep assertions.
 
> > +}
> > +
> > +int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext,
> > +				    void *data)
> > +{
> > +	struct power_supply_ext_registration *reg;
> > +	size_t i;
> > +
> > +	guard(rwsem_write)(&psy->extensions_sem);
> > +
> > +	power_supply_for_each_extension(reg, psy)
> > +		if (reg->ext == ext)
> > +			return -EEXIST;
> > +
> > +	for (i = 0; i < ext->num_properties; i++)
> > +		if (power_supply_has_property(psy, ext->properties[i]))
> > +			return -EEXIST;
> > +
> > +	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
> > +	if (!reg)
> > +		return -ENOMEM;
> > +
> > +	reg->ext = ext;
> > +	reg->data = data;
> > +	list_add(&reg->list_head, &psy->extensions);
> > +
> > +	return power_supply_update_sysfs_and_hwmon(psy);
> 
> We need to clean up *reg here should power_supply_update_sysfs_and_hwmon() fail.

Ack.

> > +}
> > +EXPORT_SYMBOL_GPL(power_supply_register_extension);
> > +
> > +void power_supply_unregister_extension(struct power_supply *psy, const struct power_supply_ext *ext)
> > +{
> > +	struct power_supply_ext_registration *reg;
> > +
> > +	guard(rwsem_write)(&psy->extensions_sem);
> > +
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (reg->ext == ext) {
> > +			list_del(&reg->list_head);
> > +			kfree(reg);
> > +			power_supply_update_sysfs_and_hwmon(psy);
> > +			return;
> > +		}
> > +	}
> > +
> > +	dev_warn(&psy->dev, "Trying to unregister invalid extension");
> > +}
> > +EXPORT_SYMBOL_GPL(power_supply_unregister_extension);
> > +
> >   static void power_supply_dev_release(struct device *dev)
> >   {
> >   	struct power_supply *psy = to_power_supply(dev);
> > @@ -1414,6 +1548,9 @@ __power_supply_register(struct device *parent,
> >   	}
> > 
> >   	spin_lock_init(&psy->changed_lock);
> > +	init_rwsem(&psy->extensions_sem);
> > +	INIT_LIST_HEAD(&psy->extensions);
> > +
> >   	rc = device_add(dev);
> >   	if (rc)
> >   		goto device_add_failed;
> > @@ -1426,13 +1563,15 @@ __power_supply_register(struct device *parent,
> >   	if (rc)
> >   		goto register_thermal_failed;
> > 
> > -	rc = power_supply_create_triggers(psy);
> > -	if (rc)
> > -		goto create_triggers_failed;
> > +	scoped_guard(rwsem_read, &psy->extensions_sem) {
> > +		rc = power_supply_create_triggers(psy);
> > +		if (rc)
> > +			goto create_triggers_failed;
> > 
> > -	rc = power_supply_add_hwmon_sysfs(psy);
> > -	if (rc)
> > -		goto add_hwmon_sysfs_failed;
> > +		rc = power_supply_add_hwmon_sysfs(psy);
> > +		if (rc)
> > +			goto add_hwmon_sysfs_failed;
> > +	}
> > 
> >   	/*
> >   	 * Update use_cnt after any uevents (most notably from device_add()).
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index 99bfe1f03eb8326d38c4e2831c9670313b42e425..2cf25bacd7a1bb66e5a72629bffaa6d16bfbf3be 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -268,6 +268,23 @@ static ssize_t power_supply_show_enum_with_available(
> >   	return count;
> >   }
> > 
> > +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> > +						  struct power_supply *psy,
> > +						  union power_supply_propval *value,
> > +						  char *buf)
> > +{
> > +	struct power_supply_ext_registration *reg;
> > +
> 
> Missing guard here.

It looks like it. Lockdep should have complained about it due to the
implicit assertion in power_supply_for_each_extension().
Or maybe I didn't test this part... will investigate.

> Thanks,
> Armin Wolf
> 
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (power_supply_ext_has_property(reg->ext, POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR))
> > +			return power_supply_charge_behaviour_show(dev, reg->ext->charge_behaviours,
> > +								  value->intval, buf);
> > +	}
> > +
> > +	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> > +						  value->intval, buf);
> > +}
> > +
> >   static ssize_t power_supply_format_property(struct device *dev,
> >   					    bool uevent,
> >   					    struct device_attribute *attr,
> > @@ -307,8 +324,7 @@ static ssize_t power_supply_format_property(struct device *dev,
> >   	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> >   		if (uevent) /* no possible values in uevents */
> >   			goto default_format;
> > -		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> > -							 value.intval, buf);
> > +		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
> >   		break;
> >   	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
> >   		ret = sysfs_emit(buf, "%s\n", value.strval);
> > @@ -385,6 +401,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
> >   	if (attrno == POWER_SUPPLY_PROP_TYPE)
> >   		return mode;
> > 
> > +	guard(rwsem_read)(&psy->extensions_sem);
> > +
> >   	if (power_supply_has_property(psy, attrno)) {
> >   		if (power_supply_property_is_writeable(psy, attrno) > 0)
> >   			mode |= S_IWUSR;
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index b98106e1a90f34bce5129317a099f363248342b9..016e44cb3eb5eb7ace01a032661f65a5d81a522f 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -15,6 +15,8 @@
> >   #include <linux/device.h>
> >   #include <linux/workqueue.h>
> >   #include <linux/leds.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/list.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/notifier.h>
> > 
> > @@ -281,6 +283,27 @@ struct power_supply_desc {
> >   	int use_for_apm;
> >   };
> > 
> > +struct power_supply_ext {
> > +	u8 charge_behaviours;
> > +	const enum power_supply_property *properties;
> > +	size_t num_properties;
> > +
> > +	int (*get_property)(struct power_supply *psy,
> > +			    const struct power_supply_ext *ext,
> > +			    void *data,
> > +			    enum power_supply_property psp,
> > +			    union power_supply_propval *val);
> > +	int (*set_property)(struct power_supply *psy,
> > +			    const struct power_supply_ext *ext,
> > +			    void *data,
> > +			    enum power_supply_property psp,
> > +			    const union power_supply_propval *val);
> > +	int (*property_is_writeable)(struct power_supply *psy,
> > +				     const struct power_supply_ext *ext,
> > +				     void *data,
> > +				     enum power_supply_property psp);
> > +};
> > +
> >   struct power_supply {
> >   	const struct power_supply_desc *desc;
> > 
> > @@ -300,10 +323,13 @@ struct power_supply {
> >   	struct delayed_work deferred_register_work;
> >   	spinlock_t changed_lock;
> >   	bool changed;
> > +	bool update_groups;
> >   	bool initialized;
> >   	bool removing;
> >   	atomic_t use_cnt;
> >   	struct power_supply_battery_info *battery_info;
> > +	struct rw_semaphore extensions_sem; /* protects "extensions" */
> > +	struct list_head extensions;
> >   #ifdef CONFIG_THERMAL
> >   	struct thermal_zone_device *tzd;
> >   	struct thermal_cooling_device *tcd;
> > @@ -878,6 +904,12 @@ devm_power_supply_register(struct device *parent,
> >   extern void power_supply_unregister(struct power_supply *psy);
> >   extern int power_supply_powers(struct power_supply *psy, struct device *dev);
> > 
> > +extern int power_supply_register_extension(struct power_supply *psy,
> > +					   const struct power_supply_ext *ext,
> > +					   void *data);
> > +extern void power_supply_unregister_extension(struct power_supply *psy,
> > +					      const struct power_supply_ext *ext);
> > +
> >   #define to_power_supply(device) container_of(device, struct power_supply, dev)
> > 
> >   extern void *power_supply_get_drvdata(struct power_supply *psy);
> > 

