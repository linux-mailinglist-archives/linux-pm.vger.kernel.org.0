Return-Path: <linux-pm+bounces-14253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7268978FAA
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AADB2129F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4871CDFD0;
	Sat, 14 Sep 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CIfXDoM4"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8912E5D;
	Sat, 14 Sep 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307765; cv=none; b=WAXDTgY09JjZVjpE+vDmxl/xbCQRUSbu16KC8SmI+hE7Ix+gesP49F2Tk38YcQ9J0i/6CNle9/ypDIEmFlPZoaSZr0vVG4XI7U/1uJM79WfGvo+RpPdFLSdOJFib7j66BoDDZQocgt6YFyhkfahKows/3L+Glnl6D1THiPQu73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307765; c=relaxed/simple;
	bh=znyJK4DVxNCOTiJgip1sATbUHiE/5IPzUPQycdeV/GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIMlwtlRSm7QT9PhYutnl6kCB8a7gyhkawzw6geNzacc4C7C+/cmQVAHWxgOophHr7fj4v3CyRIWTO3dE9FEGvb7thpszv86SfDRcesO/IqC59eDzsV0m+ty1SgO/oOHLHOmpKZzu4cIoXYeCRG/BJdKa+CL9mJVGm4bm3S+rMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CIfXDoM4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1726307758;
	bh=znyJK4DVxNCOTiJgip1sATbUHiE/5IPzUPQycdeV/GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIfXDoM41BsIDAdiCrnCSe2qjZPP5+sH4c4CAkvOsRUINIQhx5+L8zogn22ovizpE
	 lfIh0osh/52stoVrPmUOoKJzgRxR2Y5dEnaY1CWYEYkT8Q//PGDK3ue9GjQwUvuDkT
	 7jqz46uZ7zJGdwdPjtBUbu7vv/qUDHOjeHpRU+6M=
Date: Sat, 14 Sep 2024 11:55:58 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/9] power: supply: core: register thermal zone
 for battery
Message-ID: <def2fa94-61b0-40b3-a89d-0451bff0c872@t-8ch.de>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-2-62efeb93f8ec@weissschuh.net>
 <ibihc343f3fcuk5c6gtz7kwhtf6e7pbtwkbx4wxu2wbmk4amfy@qorjk4mrbq44>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ibihc343f3fcuk5c6gtz7kwhtf6e7pbtwkbx4wxu2wbmk4amfy@qorjk4mrbq44>

Hi,

On 2024-09-14 11:29:04+0000, Sebastian Reichel wrote:
> On Wed, Sep 04, 2024 at 09:25:35PM GMT, Thomas Weißschuh wrote:
> > power_supply_read_team() can also read the temperature from the battery.
> power_supply_read_temp()
> 
> > But currently when registering the thermal zone, the battery is
> > not checked for POWER_SUPPLY_PROP_TEMP. Introduce a helper which
> > can check both the desc and the battery info for property
> > existence and use that. Export the helper to the rest of the psy
> > core because it will also be used by different subcomponents.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> 
> power_supply_battery_info contains constant battery information like
> design capacity or maximum voltage, which is e.g. supplied by the
> firmware and needed by fuel-gauges or chargers. The temperature is
> not constant and cannot be part of power_supply_battery_info, so
> this does not really make sense.

Good point. Also this code will run before the extensions will be
registered, so it doesn't make sense for that either.
I'll change the patch to only introduce power_supply_has_property().

> 
> Greetings,
> 
> -- Sebastian
> 
> >  drivers/power/supply/power_supply.h      |  3 +++
> >  drivers/power/supply/power_supply_core.c | 14 +++++++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> > index 3cbafc58bdad..b01faeaf7827 100644
> > --- a/drivers/power/supply/power_supply.h
> > +++ b/drivers/power/supply/power_supply.h
> > @@ -13,6 +13,9 @@ struct device;
> >  struct device_type;
> >  struct power_supply;
> >  
> > +extern bool power_supply_has_property(struct power_supply *psy,
> > +				      enum power_supply_property psp);
> > +
> >  #ifdef CONFIG_SYSFS
> >  
> >  extern void power_supply_init_attrs(void);
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > index cff68c4fd63c..dcb7e4853030 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1199,6 +1199,18 @@ static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
> >  	return found;
> >  }
> >  
> > +bool power_supply_has_property(struct power_supply *psy,
> > +			       enum power_supply_property psp)
> > +{
> > +	if (psy_desc_has_property(psy->desc, psp))
> > +		return true;
> > +
> > +	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  int power_supply_get_property(struct power_supply *psy,
> >  			    enum power_supply_property psp,
> >  			    union power_supply_propval *val)
> > @@ -1308,7 +1320,7 @@ static int psy_register_thermal(struct power_supply *psy)
> >  		return 0;
> >  
> >  	/* Register battery zone device psy reports temperature */
> > -	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> > +	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
> >  		/* Prefer our hwmon device and avoid duplicates */
> >  		struct thermal_zone_params tzp = {
> >  			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> > 
> > -- 
> > 2.46.0

