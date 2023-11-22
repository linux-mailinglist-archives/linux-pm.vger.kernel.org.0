Return-Path: <linux-pm+bounces-75-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD07F4554
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 13:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C61F21ACB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4E4AF61;
	Wed, 22 Nov 2023 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZftmQJou"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F791;
	Wed, 22 Nov 2023 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700654636; x=1732190636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m040tgcegxw5h4wMsOHvsYLUwbk5maPB4/Q2K6ePJs0=;
  b=ZftmQJouaUR2JgpkYlZ0Kan0Q4bYpYqHHXngiBA9V2H178JT4icrVyNt
   Q1gKK+JzF7rF3O9L3riVSJOdzOUDUPAn/TgY/J+24kWHC21jjfF+YXiCO
   Ahojdatia8wJ8IjDLdKDVWJtNGXSJgbzh19MWGVrgxcQDA7lYPz9fZbtX
   gO/RVU/Ir82xH67Nenl6zKMLkBADo93nCDWgLshoduZH8POZ0Iewc3ktw
   MDazyqwSzeRb9bSnVuxQdutNKB3IXYNvcsBQiKPiFYjEFpfeq/rh2g20/
   67JAmrn9nrTsbMfH+zE7NXb5SvdoL1fK19EVA/Rj5ye8A0X9wo/uhTWM4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372218021"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="372218021"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014210364"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1014210364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:03:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1r5lnj-0000000G516-3Yml;
	Wed, 22 Nov 2023 13:53:51 +0200
Date: Wed, 22 Nov 2023 13:53:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 05/39] power: reset: Add a driver for the ep93xx reset
Message-ID: <ZV3rz8-AGGEGGi1g@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-5-d59a76d5df29@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-5-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 22, 2023 at 11:59:43AM +0300, Nikita Shubin wrote:
> Implement the reset behaviour of the various EP93xx SoCS in drivers/power/reset.
> 
> It used to be located in arch/arm/mach-ep93xx.

...

> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/notifier.h>

> +#include <linux/of.h>

I believe I already had commented in one of the previous rounds that this cargo
cult of adding of.h (esp. if it's used as a proxy) is not a good idea. Please,
revisit _ALL_ (and I mean it) your patches for this kind of issues.

...

> +#include <linux/reboot.h>
> +
> +#include <linux/soc/cirrus/ep93xx.h>

You see, here is a blank line, so I suggest keep it in all your patches for
consistency's sake.

-- 
With Best Regards,
Andy Shevchenko



