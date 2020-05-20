Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B9C1DB25E
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgETLx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 07:53:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:6511 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETLx5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 07:53:57 -0400
IronPort-SDR: 2Q6KF0zM7oCQ7Cuhk4bea9hAkvWF8x6gijcn3jHbD0dUMJ1VSmQtw+WKuN2/UWroNhlMzFKNIs
 tCCM6OQjrLOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 04:53:56 -0700
IronPort-SDR: Ha5zD3laV6o6XFZYhWw8ndkMbWYYlNTcIchXsfMJrlnFuYqUX5+saQTwOkdfN8iFGdmQb0YEzw
 KArFU+r+Krjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="282661455"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2020 04:53:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jbNIM-007par-CV; Wed, 20 May 2020 14:53:58 +0300
Date:   Wed, 20 May 2020 14:53:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] powercap: remove unused local MSR define
Message-ID: <20200520115358.GR1634618@smile.fi.intel.com>
References: <1589974578-26791-1-git-send-email-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589974578-26791-1-git-send-email-sumeet.r.pawnikar@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 05:06:18PM +0530, Sumeet Pawnikar wrote:
> From: "Pawnikar, Sumeet" <sumeet.r.pawnikar@intel.com>
> 
> Remove unused PLATFORM_POWER_LIMIT MSR local definition from file
> intel_rapl_common.c. This was missed while splitting old RAPL code
> intel_rapl.c file into two new files intel_rapl_msr.c and
> intel_rapl_common.c as per the commit 3382388d7148
> ("intel_rapl: abstract RAPL common code"). Currently, this #define
> entry is being used only in intel_rapl_msr.c file and local definition
> present in this file.

> Signed-off-by: Pawnikar, Sumeet <sumeet.r.pawnikar@intel.com>

Reorganize this to avoid comma (this also should make From: gone in the top of
this message). After addressing,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> ---
>  drivers/powercap/intel_rapl_common.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index eb328655bc01..5527a7c76309 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -26,9 +26,6 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  
> -/* Local defines */
> -#define MSR_PLATFORM_POWER_LIMIT	0x0000065C
> -
>  /* bitmasks for RAPL MSRs, used by primitive access functions */
>  #define ENERGY_STATUS_MASK      0xffffffff
>  
> -- 
> 1.7.9.5
> 

-- 
With Best Regards,
Andy Shevchenko


