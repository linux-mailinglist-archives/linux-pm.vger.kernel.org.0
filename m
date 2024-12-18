Return-Path: <linux-pm+bounces-19460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576CA9F6EEB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 21:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051D0189111A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34651FC10E;
	Wed, 18 Dec 2024 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JsgTj/WP"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CD158536;
	Wed, 18 Dec 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553786; cv=none; b=KzfmSnphOA0WTIZZnO4Ti7YiHhstp67AIQ/rBsKWJCgxI+L2RLfDGsZ90nH0ZBQggPdqZOEnhH+4Fv4US6NlCvhp85NUgRY2Gzl51q6CqK3+a1r+YbNqfmo0oH8pFBBQn/R4/PecDjH6NoqdtVm9AfjDT3rTzlf+d3+HQNkuuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553786; c=relaxed/simple;
	bh=diqa9nZqF9nbPA0bjVREC0L9pUZfJbkw72Y0TjZKvZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri9P/0V90e3KuGu7/CN8x5nlzCP4Hwhe0e/oAXhjfuNfXvujKRyaE3f58Wx0WlL7tzhqkWbURthOGGZG9NvPH2kcVIILSo2loQI4hQ99oMCwx7xJw8MCJug3JyqIvGlF5ek0iIvY11mVVHpf6vy3tGlewCvJrcW3WGbLZpJdYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JsgTj/WP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734553772;
	bh=diqa9nZqF9nbPA0bjVREC0L9pUZfJbkw72Y0TjZKvZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsgTj/WPPgh+Mh2dc0fyV9GruKo2ESgMd+IEjZEgoS9RViruUS0hQHPkD0YHzn4Lk
	 qFSg1OYKtlUmgQslmVYLpwRtrNlv5Kc5GJsIH17QRfbrWsI2wLUga12TwsC22wxZTV
	 kHax0da50KSB9CRTZUbGAXOt1prDQMTNzsxKwa64=
Date: Wed, 18 Dec 2024 21:29:31 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
Message-ID: <eb265cb2-b079-4bca-bc35-17a9f4d0ec3e@t-8ch.de>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
 <20241218195229.GA2796534@ax162>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218195229.GA2796534@ax162>

Hi Nathan,

On 2024-12-18 12:52:29-0700, Nathan Chancellor wrote:
> On Wed, Dec 11, 2024 at 08:57:58PM +0100, Thomas Weißschuh wrote:
> > Userspace wants to now about the used power supply extensions,
> > for example to handle a device extended by a certain extension
> > differently or to discover information about the extending device.
> > 
> > Add a sysfs directory to the power supply device.
> > This directory contains links which are named after the used extension
> > and point to the device implementing that extension.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power |  9 +++++++++
> >  drivers/power/supply/cros_charge-control.c  |  5 ++++-
> >  drivers/power/supply/power_supply.h         |  2 ++
> >  drivers/power/supply/power_supply_core.c    | 19 +++++++++++++++++--
> >  drivers/power/supply/power_supply_sysfs.c   | 10 ++++++++++
> >  drivers/power/supply/test_power.c           |  4 +++-
> >  include/linux/power_supply.h                |  2 ++
> >  7 files changed, 47 insertions(+), 4 deletions(-)
> ...
> > diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> > index 531785516d2ac31f9a7f73a58e15e64cb81820ed..9ed749cd09369f0f13017847687509736b30aae8 100644
> > --- a/drivers/power/supply/power_supply.h
> > +++ b/drivers/power/supply/power_supply.h
> > @@ -39,6 +40,7 @@ struct power_supply_ext_registration {
> >  
> >  extern void __init power_supply_init_attrs(void);
> >  extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
> > +extern const struct attribute_group power_supply_extension_group;
> >  extern const struct attribute_group *power_supply_attr_groups[];
> >  
> >  #else
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > index bc22edbd0e6a02c27500132075f5c98d814a7330..5142fbd580ee3d629a2aae7d0b9bcd5709162129 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1346,17 +1346,21 @@ static int power_supply_update_sysfs_and_hwmon(struct power_supply *psy)
> >  }
> >  
> >  int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext,
> > -				    void *data)
> > +				    struct device *dev, void *data)
> >  {
> >  	struct power_supply_ext_registration *reg;
> >  	size_t i;
> >  	int ret;
> >  
> > -	if (!psy || !ext || !ext->properties || !ext->num_properties)
> > +	if (!psy || !dev || !ext || !ext->name || !ext->properties || !ext->num_properties)
> >  		return -EINVAL;
> >  
> >  	guard(rwsem_write)(&psy->extensions_sem);
> >  
> > +	power_supply_for_each_extension(reg, psy)
> > +		if (strcmp(ext->name, reg->ext->name) == 0)
> > +			return -EEXIST;
> > +
> >  	for (i = 0; i < ext->num_properties; i++)
> >  		if (power_supply_has_property(psy, ext->properties[i]))
> >  			return -EEXIST;
> > @@ -1366,9 +1370,15 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
> >  		return -ENOMEM;
> >  
> >  	reg->ext = ext;
> > +	reg->dev = dev;
> >  	reg->data = data;
> >  	list_add(&reg->list_head, &psy->extensions);
> >  
> > +	ret = sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
> > +				      &dev->kobj, ext->name);
> > +	if (ret)
> > +		goto sysfs_link_failed;
> > +
> >  	ret = power_supply_update_sysfs_and_hwmon(psy);
> >  	if (ret)
> >  		goto sysfs_hwmon_failed;
> > @@ -1376,6 +1386,8 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
> >  	return 0;
> >  
> >  sysfs_hwmon_failed:
> > +	sysfs_remove_link_from_group(&psy->dev.kobj, power_supply_extension_group.name, ext->name);
> > +sysfs_link_failed:
> >  	list_del(&reg->list_head);
> >  	kfree(reg);
> >  	return ret;
> > @@ -1392,6 +1404,9 @@ void power_supply_unregister_extension(struct power_supply *psy, const struct po
> >  		if (reg->ext == ext) {
> >  			list_del(&reg->list_head);
> >  			kfree(reg);
> > +			sysfs_remove_link_from_group(&psy->dev.kobj,
> > +						     power_supply_extension_group.name,
> > +						     reg->ext->name);
> >  			power_supply_update_sysfs_and_hwmon(psy);
> >  			return;
> >  		}
> 
> I am seeing a build failure in certain configurations because
> power_supply_extension_group is only declared under a CONFIG_SYSFS ifdef
> but this code can be built without CONFIG_SYSFS.

Thanks for the report.

>   $ echo 'CONFIG_EXPERT=y
>   CONFIG_SYSFS=n' >allno.config
> 
>   $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- KCONFIG_ALLCONFIG=1 mrproper allnoconfig drivers/power/supply/power_supply_core.o
>   drivers/power/supply/power_supply_core.c: In function 'power_supply_register_extension':
>   drivers/power/supply/power_supply_core.c:1389:55: error: 'power_supply_extension_group' undeclared (first use in this function); did you mean 'power_supply_attr_groups'?
>    1389 |         ret = sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
>         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                                       power_supply_attr_groups
>   drivers/power/supply/power_supply_core.c:1389:55: note: each undeclared identifier is reported only once for each function it appears in
>   drivers/power/supply/power_supply_core.c: In function 'power_supply_unregister_extension':
>   drivers/power/supply/power_supply_core.c:1419:54: error: 'power_supply_extension_group' undeclared (first use in this function); did you mean 'power_supply_attr_groups'?
>    1419 |                                                      power_supply_extension_group.name,
>         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                                      power_supply_attr_groups

The reproducer doesn't actually enable CONFIG_POWER_SUPPLY, when I use it
I get a whole array of errors.

> Should the declaration be moved out from the ifdef or is there some
> other solution I am not seeing?

This, inline constants or a #define.

Sebastian, do you want me to send a patch?

> Cheers,
> Nathan
> 
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> index 9ed749cd0936..6fc9939145fc 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -40,7 +40,6 @@ struct power_supply_ext_registration {
>  
>  extern void __init power_supply_init_attrs(void);
>  extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
> -extern const struct attribute_group power_supply_extension_group;
>  extern const struct attribute_group *power_supply_attr_groups[];
>  
>  #else
> @@ -51,6 +50,8 @@ static inline void power_supply_init_attrs(void) {}
>  
>  #endif /* CONFIG_SYSFS */
>  
> +extern const struct attribute_group power_supply_extension_group;
> +
>  #ifdef CONFIG_LEDS_TRIGGERS
>  
>  extern void power_supply_update_leds(struct power_supply *psy);

