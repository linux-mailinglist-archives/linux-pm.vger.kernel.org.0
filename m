Return-Path: <linux-pm+bounces-14285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F9397915D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6E2284C45
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004391CF5CA;
	Sat, 14 Sep 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sVVI0OuO"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE01DFFB;
	Sat, 14 Sep 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323932; cv=none; b=G1TnDVEhhbr8l29YFjQSKRVHMD4xFeEGmnYfro63Gcqx2HpaTdlvxetBQnX1rWUEEkIYaHz/GxJLxizFOonLxA2u9Btoy3btMwj6fikz5at9JwdWE7zQxU6IhL6e8ccqZ4iVd+zj5wORPnWrgMvCR5I9+LWIbdUQMYJ0irwJVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323932; c=relaxed/simple;
	bh=8/BNLKl+6eFWpqBHWhiVdG8BdDVCJP5rgyhGYH3G5f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxzljEfmVZ2b8o0DfImAUB/xHCGBz/1BJLogFEmAKsIJg7rR/XuDDHcWL8buA60xytC0aFyWnRryUfAq2CVHwjz+tyZFSwh6/vfUNSQOWqo9gjAa6Fg1es2mPNWE3b/aX1/0EDcPwXoZwoKAnNznGGDCJJW9jtTfNZkI/gC3gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sVVI0OuO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1726323926;
	bh=8/BNLKl+6eFWpqBHWhiVdG8BdDVCJP5rgyhGYH3G5f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVVI0OuOGwwy2yHbUYi0o4nMqj9sbHq3Vqd1FCkNiTl+MlgGNDugjHLD/sGWgc2XU
	 rGKDnzWVukPgWfwF+84F2wIEkON/TU678iT6fJi1DnKRisAnPcGICf3dlYbPzDp0OL
	 zvUg2w0y6Lx+V5HQjBp0p4LHeRU0hmnBdJ6BwedA=
Date: Sat, 14 Sep 2024 16:25:25 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 6/9] power: supply: core: implement extension API
Message-ID: <64b5235f-cdcf-4793-9bef-472c638dcd2f@t-8ch.de>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-6-62efeb93f8ec@weissschuh.net>
 <vq7r2udbmqfp5v7o2occtnoziwrnpidht2wgkofvfyfic2o67m@3wtnxxvtdgye>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vq7r2udbmqfp5v7o2occtnoziwrnpidht2wgkofvfyfic2o67m@3wtnxxvtdgye>

On 2024-09-14 12:50:57+0000, Sebastian Reichel wrote:
> On Wed, Sep 04, 2024 at 09:25:39PM GMT, Thomas Weißschuh wrote:
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> 
> missing long description :)

I'll paste the cover letter here for the next one :-)

> In general I like the concept. It looks like a good candidate to
> clean up the mess with the custom registration of properties done
> by the x86 platform code.
> 
> Apart from ACPI with custom battery extensions mess, there is
> something similar in the embedded world: Many charger chips have
> rudimentary fuel-gauge support. Some drivers register a charger/usb
> and a battery device. That results in two battery devices when the
> machine also has a proper fuel gauge. Having two battery devices
> exposed is bad, since that means the machine has two batteries
> (like some Thinkpads). Not exposing the battery from the charger
> device is possibly loosing information (depending on fuel gauge
> features).
> 
> I think it should be possible to register the charger's rudimentary
> battery device as a power_supply_ext, if it detects a proper fuel
> gauge being available (e.g. via the DT "power-supplies" property).
> But then the charger's properties are the preferred ones. I think
> they should be fallback properties instead. A machine only gets its
> own fuel-gauge, when that provides better values than the data
> available from the charger :)
> 
> So the question is which property getter/setter should be used
> when the same property is exposed multiple times. Your examples
> only add new properties and does not run into this. The intuitive
> thing would be for properties from extensions to be preferred,
> but do we actually have a use case for that?

Currently duplicate properties are straight up rejected.
With multiple extensions any order-based resolution of duplicates seems
to be prone for confusion in case the registration order changes.

The x86 platform and embedded usecases seem quite disjunct to me.
If we can keep them separate that would be easier to implement.

x86:

Don't allow any overriding, like the code currently does.

embedded:

Add different extension priorities. When registering a new one,
unregister all lower priority ones; do nothing if a higher priority is
already registered.
This makes the result predictable even if the order changes.
A fallback extension would need quite some bespoke logic I think.

Note:
I noticed that the locking for power_supply_set_property() is currently
broken. In case you are wondering about that.


Thomas

> Greetings,
> 
> -- Sebastian
> 
> >  drivers/power/supply/power_supply.h       |  12 ++++
> >  drivers/power/supply/power_supply_core.c  | 114 +++++++++++++++++++++++++++++-
> >  drivers/power/supply/power_supply_sysfs.c |  20 +++++-
> >  include/linux/power_supply.h              |  30 ++++++++
> >  4 files changed, 171 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> > index b01faeaf7827..fb45f0717bd1 100644
> > --- a/drivers/power/supply/power_supply.h
> > +++ b/drivers/power/supply/power_supply.h
> > @@ -15,6 +15,18 @@ struct power_supply;
> >  
> >  extern bool power_supply_has_property(struct power_supply *psy,
> >  				      enum power_supply_property psp);
> > +extern bool power_supply_ext_has_property(const struct power_supply_ext *ext,
> > +				          enum power_supply_property psp);
> > +
> > +struct power_supply_ext_registration {
> > +	struct list_head list_head;
> > +	const struct power_supply_ext *ext;
> > +	void *data;
> > +};
> > +
> > +#define power_supply_for_each_extension(pos, psy) \
> > +	list_for_each_entry(pos, &(psy)->extensions, list_head)
> > +
> >  
> >  #ifdef CONFIG_SYSFS
> >  
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > index dcb7e4853030..db5e7af57e67 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1199,15 +1199,40 @@ static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
> >  	return found;
> >  }
> >  
> > +bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
> > +				   enum power_supply_property psp)
> > +{
> > +	bool found = false;
> > +	int i;
> > +
> > +	if (!psy_ext)
> > +		return false;
> > +
> > +	for (i = 0; i < psy_ext->num_properties; i++) {
> > +		if (psy_ext->properties[i] == psp) {
> > +			found = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return found;
> > +}
> > +
> >  bool power_supply_has_property(struct power_supply *psy,
> >  			       enum power_supply_property psp)
> >  {
> > +	struct power_supply_ext_registration *reg;
> > +
> >  	if (psy_desc_has_property(psy->desc, psp))
> >  		return true;
> >  
> >  	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> >  		return true;
> >  
> > +	power_supply_for_each_extension(reg, psy)
> > +		if (power_supply_ext_has_property(reg->ext, psp))
> > +			return true;
> > +
> >  	return false;
> >  }
> >  
> > @@ -1215,12 +1240,19 @@ int power_supply_get_property(struct power_supply *psy,
> >  			    enum power_supply_property psp,
> >  			    union power_supply_propval *val)
> >  {
> > +	struct power_supply_ext_registration *reg;
> > +
> >  	if (atomic_read(&psy->use_cnt) <= 0) {
> >  		if (!psy->initialized)
> >  			return -EAGAIN;
> >  		return -ENODEV;
> >  	}
> >  
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (power_supply_ext_has_property(reg->ext, psp))
> > +			return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> > +	}
> > +
> >  	if (psy_desc_has_property(psy->desc, psp))
> >  		return psy->desc->get_property(psy, psp, val);
> >  	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> > @@ -1234,7 +1266,21 @@ int power_supply_set_property(struct power_supply *psy,
> >  			    enum power_supply_property psp,
> >  			    const union power_supply_propval *val)
> >  {
> > -	if (atomic_read(&psy->use_cnt) <= 0 || !psy->desc->set_property)
> > +	struct power_supply_ext_registration *reg;
> > +
> > +	if (atomic_read(&psy->use_cnt) <= 0)
> > +		return -ENODEV;
> > +
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (power_supply_ext_has_property(reg->ext, psp)) {
> > +			if (reg->ext->set_property)
> > +				return reg->ext->set_property(psy, reg->ext, reg->data, psp, val);
> > +			else
> > +				return -ENODEV;
> > +		}
> > +	}
> > +
> > +	if (!psy->desc->set_property)
> >  		return -ENODEV;
> >  
> >  	return psy->desc->set_property(psy, psp, val);
> > @@ -1244,8 +1290,21 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
> >  int power_supply_property_is_writeable(struct power_supply *psy,
> >  					enum power_supply_property psp)
> >  {
> > -	if (atomic_read(&psy->use_cnt) <= 0 ||
> > -			!psy->desc->property_is_writeable)
> > +	struct power_supply_ext_registration *reg;
> > +
> > +	if (atomic_read(&psy->use_cnt) <= 0)
> > +		return -ENODEV;
> > +
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (power_supply_ext_has_property(reg->ext, psp)) {
> > +			if (reg->ext->property_is_writeable)
> > +				return reg->ext->property_is_writeable(psy, reg->ext, reg->data, psp);
> > +			else
> > +				return -ENODEV;
> > +		}
> > +	}
> > +
> > +	if (!psy->desc->property_is_writeable)
> >  		return -ENODEV;
> >  
> >  	return psy->desc->property_is_writeable(psy, psp);
> > @@ -1268,6 +1327,54 @@ int power_supply_powers(struct power_supply *psy, struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(power_supply_powers);
> >  
> > +static int power_supply_update_groups(struct power_supply *psy)
> > +{
> > +	int ret;
> > +
> > +	ret = sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.groups);
> > +	power_supply_changed(psy);
> > +	return ret;
> > +}
> > +
> > +int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext,
> > +				    void *ext_data)
> > +{
> > +	struct power_supply_ext_registration *reg;
> > +	size_t i;
> > +
> > +	for (i = 0; i < ext->num_properties; i++) {
> > +		if (power_supply_has_property(psy, ext->properties[i]))
> > +			return -EEXIST;
> > +	}
> > +
> > +	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
> > +	if (!reg)
> > +		return -ENOMEM;
> > +
> > +	reg->ext = ext;
> > +	list_add(&reg->list_head, &psy->extensions);
> > +
> > +	return power_supply_update_groups(psy);
> > +}
> > +EXPORT_SYMBOL_GPL(power_supply_register_extension);
> > +
> > +void power_supply_unregister_extension(struct power_supply *psy, const struct power_supply_ext *ext)
> > +{
> > +	struct power_supply_ext_registration *reg;
> > +
> > +	power_supply_for_each_extension(reg, psy) {
> > +		if (reg->ext == ext) {
> > +			list_del(&reg->list_head);
> > +			kfree(reg);
> > +			power_supply_update_groups(psy);
> > +			return;
> > +		}
> > +	}
> > +
> > +	dev_warn(&psy->dev, "Trying to unregister invalid extension");
> > +}
> > +EXPORT_SYMBOL_GPL(power_supply_unregister_extension);
> > +
> >  static void power_supply_dev_release(struct device *dev)
> >  {
> >  	struct power_supply *psy = to_power_supply(dev);
> > @@ -1427,6 +1534,7 @@ __power_supply_register(struct device *parent,
> >  	}
> >  
> >  	spin_lock_init(&psy->changed_lock);
> > +	INIT_LIST_HEAD(&psy->extensions);
> >  	rc = device_add(dev);
> >  	if (rc)
> >  		goto device_add_failed;
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index 915a4ba62258..e7c306afd846 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
> >  	return count;
> >  }
> >  
> > +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> > +						  struct power_supply *psy,
> > +						  union power_supply_propval *value,
> > +						  char *buf)
> > +{
> > +	struct power_supply_ext_registration *reg;
> > +
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
> >  static ssize_t power_supply_show_property(struct device *dev,
> >  					  struct device_attribute *attr,
> >  					  char *buf) {
> > @@ -306,8 +323,7 @@ static ssize_t power_supply_show_property(struct device *dev,
> >  						&value, buf);
> >  		break;
> >  	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > -		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> > -							 value.intval, buf);
> > +		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
> >  		break;
> >  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
> >  		ret = sysfs_emit(buf, "%s\n", value.strval);
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 72dc7e45c90c..51788faf1d66 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -15,6 +15,7 @@
> >  #include <linux/device.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/leds.h>
> > +#include <linux/list.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/notifier.h>
> >  
> > @@ -280,6 +281,28 @@ struct power_supply_desc {
> >  	int use_for_apm;
> >  };
> >  
> > +struct power_supply_ext {
> > +	u8 charge_behaviours;
> > +	const enum power_supply_property *properties;
> > +	size_t num_properties;
> > +
> > +	int (*get_property)(struct power_supply *psy,
> > +			    const struct power_supply_ext *ext,
> > +			    void *ext_data,
> > +			    enum power_supply_property psp,
> > +			    union power_supply_propval *val);
> > +	int (*set_property)(struct power_supply *psy,
> > +			    const struct power_supply_ext *ext,
> > +			    void *ext_data,
> > +			    enum power_supply_property psp,
> > +			    const union power_supply_propval *val);
> > +
> > +	int (*property_is_writeable)(struct power_supply *psy,
> > +				     const struct power_supply_ext *ext,
> > +				     void *ext_data,
> > +				     enum power_supply_property psp);
> > +};
> > +
> >  struct power_supply {
> >  	const struct power_supply_desc *desc;
> >  
> > @@ -303,6 +326,7 @@ struct power_supply {
> >  	bool removing;
> >  	atomic_t use_cnt;
> >  	struct power_supply_battery_info *battery_info;
> > +	struct list_head extensions;
> >  #ifdef CONFIG_THERMAL
> >  	struct thermal_zone_device *tzd;
> >  	struct thermal_cooling_device *tcd;
> > @@ -887,6 +911,12 @@ devm_power_supply_register_no_ws(struct device *parent,
> >  extern void power_supply_unregister(struct power_supply *psy);
> >  extern int power_supply_powers(struct power_supply *psy, struct device *dev);
> >  
> > +extern int power_supply_register_extension(struct power_supply *psy,
> > +					   const struct power_supply_ext *ext,
> > +					   void *ext_data);
> > +extern void power_supply_unregister_extension(struct power_supply *psy,
> > +					      const struct power_supply_ext *ext);
> > +
> >  #define to_power_supply(device) container_of(device, struct power_supply, dev)
> >  
> >  extern void *power_supply_get_drvdata(struct power_supply *psy);
> > 
> > -- 
> > 2.46.0
> > 
> > 



