Return-Path: <linux-pm+bounces-7731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8608C2AE5
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 22:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B290F1F2542C
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A74D58A;
	Fri, 10 May 2024 20:04:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1A45BF9;
	Fri, 10 May 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371478; cv=none; b=ODDrQ4syfq6jHoHF+Wu3NqaO4MoUPBNB7RjLfivXJSAqgEElxa4GzOwNQZ/LH4T1oFGWKpehH3QsIQyE9K30NUlHA5Sr5RWO6jUcl8ZA1KK6SSms5wpzt8aXR1LuQ8M1wi04Z7PusRC+O4R4Ph45+61O8p9tYLx9fvSRE7vipH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371478; c=relaxed/simple;
	bh=6464WgQDaTYQ8HBRHKN/hyUPVZQYuPwn8wKJJWdud6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVnaWwVIwb1+a7eTi7FKCjaM+F590InEqslHdpbA4KnrIL2VuMXBoAd4WSvzMR/b2ixxZhdQaoBTpqYlaYwlaW6sRPQY185/znvXPSA/Vy1z4nPEt4uj7nQ6/9V/t7/7qKsiCH6XBDnIU4ebaL+zAFcXCFj2YwWkQLeB7zZD5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: xHqjc4b1Ss2DtTvDgMi+0w==
X-CSE-MsgGUID: ek76jh6CTPa5pcNIx5tryQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11234479"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11234479"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:04:36 -0700
X-CSE-ConnectionGUID: 4WOTDymVQCe2VlGJ63vxgw==
X-CSE-MsgGUID: 13M/O4pYRhyc+HYqChnQFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29828496"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:04:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s5WTm-00000006Faf-2RBz;
	Fri, 10 May 2024 23:04:30 +0300
Date: Fri, 10 May 2024 23:04:30 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: power-supply-leds: Add
 power_supply_[un]register_led_trigger()
Message-ID: <Zj59zito2FILn9qD@smile.fi.intel.com>
References: <20240510194012.138192-1-hdegoede@redhat.com>
 <20240510194012.138192-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510194012.138192-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 09:40:10PM +0200, Hans de Goede wrote:
> Add power_supply_[un]register_led_trigger() helper functions.
> 
> The primary goal of this is as a preparation patch for adding an activate
> callback to the power-supply LED triggers to ensure that power-supply
> LEDs get the correct initial value when the LED gets registered after
> the power_supply has been registered (this will use the psy back pointer).
> 
> There also is quite a lot of code duplication in the existing LED trigger
> registration in the form of the kasprintf() for the name-template for each
> trigger + related error handling. This duplication is removed by these
> new helpers.

...

> +	err = led_trigger_register(&psy_trig->trig);
> +	if (err)
> +		goto err_free_name;


> +err_free_name:
> +	kfree(psy_trig->trig.name);
> +err_free_trigger:
> +	kfree(psy_trig);
> +	return -ENOMEM;

Why not ret?

...

> +static int power_supply_create_bat_triggers(struct power_supply *psy)
> +{
> +	int err = 0;
> +
> +	err |= power_supply_register_led_trigger(psy, "%s-charging-or-full",
> +						 &psy->charging_full_trig);
> +	err |= power_supply_register_led_trigger(psy, "%s-charging",
> +						 &psy->charging_trig);
> +	err |= power_supply_register_led_trigger(psy, "%s-full",
> +						 &psy->full_trig);
> +	err |= power_supply_register_led_trigger(psy, "%s-charging-blink-full-solid",
> +						 &psy->charging_blink_full_solid_trig);
> +	err |= power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
> +						 &psy->charging_orange_full_green_trig);

Why not using the similar approach as you have done in v4l2 CCI?

> +	if (err) {
> +		power_supply_remove_bat_triggers(psy);
> +		/*
> +		 * led_trigger_register() may also return -EEXIST but that should
> +		 * never happen with the dynamically generated psy trigger names.
> +		 */

Maybe this comment should be above and here just return err; (but see above remark).

> +		return -ENOMEM;
> +	}
> +
> +	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko



