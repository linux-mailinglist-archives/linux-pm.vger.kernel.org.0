Return-Path: <linux-pm+bounces-7732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 668308C2AEB
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 22:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00120B21272
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6B4CB4E;
	Fri, 10 May 2024 20:07:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EB4D11D;
	Fri, 10 May 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371657; cv=none; b=Ymq5IcRbE7qrP/OB0XhwP3mBmyWd5v2V7gHhf1HyoFKdwtqkOmsXbG758VaUMsSz+2VUIBKV8aZNkuN0suOH4j4l8cYsdikXdlJfpG1sTaooRVeszngPFcNI27j2TF9GQLP8HHVGKFWLKOWRrMHFZN3MF/xC2PFZVt0WCyY8ybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371657; c=relaxed/simple;
	bh=Rk/HvaTBebmhW/AiGag4xZjy2iQsa7LDzfhzqpjdBdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMHxMmeJBSiYdth4A4I95qR057NcFUUCBDDWKv3uQXcJqftWpGhsd1Wfmta9tEAQQSnp2joZMG8GLgpdh/Dme2G3i9JfOkeqQ5vWc82E0bysMxH403aGUDhkE609k0RGQrvkHKerI09cSwpYQiA5O4Fas2WboA5FP4eLQzUWs9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: reBnMwG6Qe2Uan7FYsODmg==
X-CSE-MsgGUID: pKcvvLUeRsCkKPPbXsUktA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="15203811"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15203811"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:07:36 -0700
X-CSE-ConnectionGUID: 7euUPUwFRdmIxd0vLD9Z7Q==
X-CSE-MsgGUID: /gc48RfbQVKuWDtSp4puaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34251041"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:07:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s5WWg-00000006FeJ-2lk9;
	Fri, 10 May 2024 23:07:30 +0300
Date: Fri, 10 May 2024 23:07:30 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: power-supply-leds: Add activate()
 callback to triggers
Message-ID: <Zj5-gmaS4-IglyW4@smile.fi.intel.com>
References: <20240510194012.138192-1-hdegoede@redhat.com>
 <20240510194012.138192-4-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510194012.138192-4-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 09:40:12PM +0200, Hans de Goede wrote:
> Add an activate() callback to the power-supply LED triggers so that
> the LED being activated will properly reflect the current power-supply
> state for power-supply devices which are already fully registered
> when the trigger gets activated.
> 
> This fixes e.g. wrong LED state (1) when the LED gets registered
> after the power-supply device.
> 
> 1) Until the psy driver has a reason to call power_supply_changed()
>    which may take quite a while

...

> +static int power_supply_led_trigger_activate(struct led_classdev *led_cdev)
> +{
> +	struct power_supply_led_trigger *psy_trig =
> +		container_of(led_cdev->trigger, struct power_supply_led_trigger, trig);

Second time same container_of(), perhaps a helper [macro]?

> +	/* Sync current power-supply state to LED being activated */
> +	power_supply_update_leds(psy_trig->psy);
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



