Return-Path: <linux-pm+bounces-29822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D40AED804
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C43D3B4A8C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44F242D70;
	Mon, 30 Jun 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6FRYybJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEF24167B;
	Mon, 30 Jun 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273929; cv=none; b=fm5PbMo5BN5xs7scLKHeOpHg4mldJtqkOmCtzelkpqZ//J7W/dNYxqVSmwh0YJBcZAYh3P1L8OIEvzOBGwzbTTGl5E9XMaW/g0X5AcSUsONI4Rg7kAZ6TZ2IHCsTEG+UXa486kGYVMfyXI0Y3zeo/h5HkAdv2fCpNOO6d5sYsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273929; c=relaxed/simple;
	bh=9nNqEeOcQnMdBtSCPx5y7oe5Ki0CaDoub2u4nwRRO/w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yr9C+IfLNE7Te+DHdNzTu8BIXR2yMydNeUJmyJZQJ4TLQEmN7xMoenRMq4RHv1bJ4jHVXhLm0Q13ftlV9TtvmAzVYyL7UhEqguypXXZjw5KfPma6GsQ/wQSlwdf9vFB9+XrpCKnms16qNOy7R5dPWCpCH+rhNpEgWjJSzV7YQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6FRYybJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751273927; x=1782809927;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9nNqEeOcQnMdBtSCPx5y7oe5Ki0CaDoub2u4nwRRO/w=;
  b=a6FRYybJZVsLyrQDssgEDxMwh4AwTYXozbijqeTGW1QH4cpxkrOCmTtT
   hKaDtOznRu1coUklj6BTPd6KuiDa7Lv5/XWn2DzcnQ75FgkJuTcxKaXhe
   PN41swlz+1DZWH5jOku40zuPJNVscPEUMEzMZNzDpFjFXqBMDEOIngg/u
   rcclLa8EdlaVjsZMQLx8e4z9GRcoGeyJx0QFr9Jq3PcVyPY/34A1KRtGI
   nf6R2ByOQHV33CrEsxol+N4qZvTLHII6uT+WTsXr92SPJvgEXQMRuU/mt
   FyX++URnRntQflr3T+nOnXXC4FIaU2JToKHh6yPpBcbiyBaohAtserzCc
   w==;
X-CSE-ConnectionGUID: 2XeMF4Z4TDOhS1bMVdtbbA==
X-CSE-MsgGUID: N0eqKIX4S9GgjIlHlO5vZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64187445"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64187445"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 01:58:46 -0700
X-CSE-ConnectionGUID: 5bTswX5cSj2araqCDkCVJw==
X-CSE-MsgGUID: FdUxFW9GR5KL+QjjsRM8bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153873451"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 01:58:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Jun 2025 11:58:39 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>, sre@kernel.org
cc: Hans de Goede <hansg@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
    linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
In-Reply-To: <4e28458b-baba-456a-bae6-08c2818aedf8@gmx.de>
Message-ID: <66dbff89-131b-4bc5-1059-c97342b2efca@linux.intel.com>
References: <20250627205124.250433-1-W_Armin@gmx.de> <b4e077d9-a5f5-47ec-abc7-9e957c32cd5b@kernel.org> <4e28458b-baba-456a-bae6-08c2818aedf8@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 28 Jun 2025, Armin Wolf wrote:

> Am 28.06.25 um 11:25 schrieb Hans de Goede:
> 
> > Hi Armin,
> > 
> > On 27-Jun-25 10:51 PM, Armin Wolf wrote:
> > > Power supply extensions might want to interact with the underlying
> > > power supply to retrieve data like serial numbers, charging status
> > > and more. However doing so causes psy->extensions_sem to be locked
> > > twice, possibly causing a deadlock.
> > > 
> > > Provide special variants of power_supply_get/set_property() that
> > > ignore any power supply extensions and thus do not touch the
> > > associated psy->extensions_sem lock.
> > > 
> > > Suggested-by: Hans de Goede <hansg@kernel.org>
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > Thank you for your work on this.
> > 
> > The entire series looks good to me:
> > 
> > Reviewed-by: Hans de Goede <hansg@kernel.org>
> > 
> > for the series.
> > 
> > There is the question of how to merge this. I think it might
> > be best for the entire series to go through the power-supply
> > tree.
> > 
> > Ilpo would that work for you and if yes can we have your ack ?
> > 
> > Sebastian, IMHO this should be merged as fixed not as for-next
> > material.
> > 
> > Regards,
> > 
> > Hans
> 
> Personally i would prefer to merge this through the pdx86 tree as the
> uniwill-laptop driver currently under review will also require this
> functionality.

Sebastian, are you okay if I take this through pdx86 fixes branch as 
requested by Armin? If yes, can I have your ack please.


-- 
 i.

> > > ---
> > >   drivers/power/supply/power_supply_core.c | 82 ++++++++++++++++++++----
> > >   include/linux/power_supply.h             |  8 +++
> > >   2 files changed, 78 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/power/supply/power_supply_core.c
> > > b/drivers/power/supply/power_supply_core.c
> > > index aedb20c1d276..e70ffedf1a80 100644
> > > --- a/drivers/power/supply/power_supply_core.c
> > > +++ b/drivers/power/supply/power_supply_core.c
> > > @@ -1241,9 +1241,8 @@ bool power_supply_has_property(struct power_supply
> > > *psy,
> > >   	return false;
> > >   }
> > >   -int power_supply_get_property(struct power_supply *psy,
> > > -			    enum power_supply_property psp,
> > > -			    union power_supply_propval *val)
> > > +static int __power_supply_get_property(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +				       union power_supply_propval *val, bool
> > > use_extensions)
> > >   {
> > >   	struct power_supply_ext_registration *reg;
> > >   @@ -1253,10 +1252,14 @@ int power_supply_get_property(struct
> > > power_supply *psy,
> > >   		return -ENODEV;
> > >   	}
> > >   -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> > > -		power_supply_for_each_extension(reg, psy) {
> > > -			if (power_supply_ext_has_property(reg->ext, psp))
> > > +	if (use_extensions) {
> > > +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> > > +			power_supply_for_each_extension(reg, psy) {
> > > +				if (!power_supply_ext_has_property(reg->ext,
> > > psp))
> > > +					continue;
> > > +
> > >   				return reg->ext->get_property(psy, reg->ext,
> > > reg->data, psp, val);
> > > +			}
> > >   		}
> > >   	}
> > >   @@ -1267,20 +1270,49 @@ int power_supply_get_property(struct
> > > power_supply *psy,
> > >   	else
> > >   		return -EINVAL;
> > >   }
> > > +
> > > +int power_supply_get_property(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +			      union power_supply_propval *val)
> > > +{
> > > +	return __power_supply_get_property(psy, psp, val, true);
> > > +}
> > >   EXPORT_SYMBOL_GPL(power_supply_get_property);
> > >   -int power_supply_set_property(struct power_supply *psy,
> > > -			    enum power_supply_property psp,
> > > -			    const union power_supply_propval *val)
> > > +/**
> > > + * power_supply_get_property_direct - Read a power supply property
> > > without checking for extensions
> > > + * @psy: The power supply
> > > + * @psp: The power supply property to read
> > > + * @val: The resulting value of the power supply property
> > > + *
> > > + * Read a power supply property without taking into account any power
> > > supply extensions registered
> > > + * on the given power supply. This is mostly useful for power supply
> > > extensions that want to access
> > > + * their own power supply as using power_supply_get_property() directly
> > > will result in a potential
> > > + * deadlock.
> > > + *
> > > + * Return: 0 on success or negative error code on failure.
> > > + */
> > > +int power_supply_get_property_direct(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +				     union power_supply_propval *val)
> > > +{
> > > +        return __power_supply_get_property(psy, psp, val, false);
> > > +}
> > > +EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
> > > +
> > > +
> > > +static int __power_supply_set_property(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +				       const union power_supply_propval *val,
> > > bool use_extensions)
> > >   {
> > >   	struct power_supply_ext_registration *reg;
> > >     	if (atomic_read(&psy->use_cnt) <= 0)
> > >   		return -ENODEV;
> > >   -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> > > -		power_supply_for_each_extension(reg, psy) {
> > > -			if (power_supply_ext_has_property(reg->ext, psp)) {
> > > +	if (use_extensions) {
> > > +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> > > +			power_supply_for_each_extension(reg, psy) {
> > > +				if (!power_supply_ext_has_property(reg->ext,
> > > psp))
> > > +					continue;
> > > +
> > >   				if (reg->ext->set_property)
> > >   					return reg->ext->set_property(psy,
> > > reg->ext, reg->data,
> > >   								      psp,
> > > val);
> > > @@ -1295,8 +1327,34 @@ int power_supply_set_property(struct power_supply
> > > *psy,
> > >     	return psy->desc->set_property(psy, psp, val);
> > >   }
> > > +
> > > +int power_supply_set_property(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +			      const union power_supply_propval *val)
> > > +{
> > > +	return __power_supply_set_property(psy, psp, val, true);
> > > +}
> > >   EXPORT_SYMBOL_GPL(power_supply_set_property);
> > >   +/**
> > > + * power_supply_set_property_direct - Write a power supply property
> > > without checking for extensions
> > > + * @psy: The power supply
> > > + * @psp: The power supply property to write
> > > + * @val: The value to write to the power supply property
> > > + *
> > > + * Write a power supply property without taking into account any power
> > > supply extensions registered
> > > + * on the given power supply. This is mostly useful for power supply
> > > extensions that want to access
> > > + * their own power supply as using power_supply_set_property() directly
> > > will result in a potential
> > > + * deadlock.
> > > + *
> > > + * Return: 0 on success or negative error code on failure.
> > > + */
> > > +int power_supply_set_property_direct(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +				     const union power_supply_propval *val)
> > > +{
> > > +	return __power_supply_set_property(psy, psp, val, false);
> > > +}
> > > +EXPORT_SYMBOL_GPL(power_supply_set_property_direct);
> > > +
> > >   int power_supply_property_is_writeable(struct power_supply *psy,
> > >   					enum power_supply_property psp)
> > >   {
> > > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > > index 45468959dd98..f21f806bfb38 100644
> > > --- a/include/linux/power_supply.h
> > > +++ b/include/linux/power_supply.h
> > > @@ -878,15 +878,23 @@ static inline int
> > > power_supply_is_system_supplied(void) { return -ENOSYS; }
> > >   extern int power_supply_get_property(struct power_supply *psy,
> > >   			    enum power_supply_property psp,
> > >   			    union power_supply_propval *val);
> > > +int power_supply_get_property_direct(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +				     union power_supply_propval *val);
> > >   #if IS_ENABLED(CONFIG_POWER_SUPPLY)
> > >   extern int power_supply_set_property(struct power_supply *psy,
> > >   			    enum power_supply_property psp,
> > >   			    const union power_supply_propval *val);
> > > +int power_supply_set_property_direct(struct power_supply *psy, enum
> > > power_supply_property psp,
> > > +				     const union power_supply_propval *val);
> > >   #else
> > >   static inline int power_supply_set_property(struct power_supply *psy,
> > >   			    enum power_supply_property psp,
> > >   			    const union power_supply_propval *val)
> > >   { return 0; }
> > > +static inline int power_supply_set_property_direct(struct power_supply
> > > *psy,
> > > +						   enum power_supply_property
> > > psp,
> > > +						   const union
> > > power_supply_propval *val)
> > > +{ return 0; }
> > >   #endif
> > >   extern void power_supply_external_power_changed(struct power_supply
> > > *psy);
> > >   
> > 
> 

