Return-Path: <linux-pm+bounces-1112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB41D811BA1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 18:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104F81C20DFB
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338C59B48;
	Wed, 13 Dec 2023 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yw8kHCfc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E47B189;
	Wed, 13 Dec 2023 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702490104; x=1734026104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8QixjnXhfq2bW5wYTLk2wSq1en7KmWzd9EcTLD6Wix8=;
  b=Yw8kHCfclVZB0LllEhIMZvnbnmQhdwOEyZYz2Mhm7sErQniqg3rlLuiq
   uP+BT7UmgaqbhuFpzTXm2xbAcngK3U3iRYj1hfShguEUpF0bcKzfnMRK8
   WD+ovXR4Hidp44FGYTRc36k/OODLAkOyVL3xRf46KEfWFb9iCN6oOYRUI
   eiumTSJIU8sbB4ygmcEj2S414kdwlXPrCcJFjibwPrXXQALeuvuA21uUQ
   JfLqt1azBgT15fBR3S4a7pb6jdQkpgUtVWkdkfBgEPEOkmW7J8MxdMUgE
   +/wUS9wHZ0cVal7UK0ZArrArqwO2dHEqGM2TQ8IH543XcSquYHXb3vZ6E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394756123"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="394756123"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105389019"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1105389019"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:55:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rDTRj-00000005bGL-23mt;
	Wed, 13 Dec 2023 19:54:59 +0200
Date: Wed, 13 Dec 2023 19:54:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 06/40] power: reset: Add a driver for the ep93xx reset
Message-ID: <ZXnv8zwHYHS7co2G@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-6-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-6-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 12, 2023 at 11:20:23AM +0300, Nikita Shubin wrote:
> Implement the reset behaviour of the various EP93xx SoCS
> in drivers/power/reset.
> 
> It used to be located in arch/arm/mach-ep93xx.

...

> +#include <linux/bits.h>

+ container_of.h

> +#include <linux/delay.h>

+ errno.h

> +#include <linux/mfd/syscon.h>
> +#include <linux/notifier.h>

> +#include <linux/platform_device.h>

Should this be the auxiliary one?

> +#include <linux/reboot.h>

+ device.h or slab.h where devm_kzalloc() is defined.
Depends on above dev_printk.h (it's guaranteed by device.h).

> +static const struct auxiliary_device_id ep93xx_reboot_ids[] = {
> +	{
> +		.name = "soc_ep93xx.reset-ep93xx",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, ep93xx_reboot_ids);

module.h
mod_devicetable.h

...

> +static struct auxiliary_driver ep93xx_reboot_driver = {
> +	.probe		= ep93xx_reboot_probe,
> +	.id_table	= ep93xx_reboot_ids,
> +};
> +module_auxiliary_driver(ep93xx_reboot_driver);

Not seeing the platform_device.h use...

-- 
With Best Regards,
Andy Shevchenko



