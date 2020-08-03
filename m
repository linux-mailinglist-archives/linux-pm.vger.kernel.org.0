Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A066223A14E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgHCIxx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 04:53:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:62352 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHCIxw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 04:53:52 -0400
IronPort-SDR: novjd+V0YOHjXUHckk5+BfKgkVLGITwd0aUtORRo7Kf+3fXmGEBe7mFzJ22FDk2cacLleTn+EX
 KWn7fOsIpTLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="213601102"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="213601102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 01:53:51 -0700
IronPort-SDR: z0exZezV/kfhY5z1C32Qp1TzeRoohCdwc43nzu0n3hDFu/JiPS7X8oOugCM5Zby8LSNKuDKRlp
 Gl4a2U/shLjQ==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="291977024"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 01:53:50 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id E6B0D206D6; Mon,  3 Aug 2020 11:53:47 +0300 (EEST)
Date:   Mon, 3 Aug 2020 11:53:47 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
Message-ID: <20200803085347.GV13316@paasikivi.fi.intel.com>
References: <2672940.cHDmkauF2A@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2672940.cHDmkauF2A@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for the patch.

On Fri, Jul 31, 2020 at 07:03:26PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add kerneldoc comments to multiple PM-runtime helper functions
> defined as static inline wrappers around lower-level routines to
> provide quick reference decumentation of their behavior.
> 
> Some of them are similar to each other with subtle differences only
> and the behavior of some of them may appear as counter-intuitive, so
> clarify all that to avoid confusion.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm_runtime.h |  246 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 246 insertions(+)
> 
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -60,58 +60,151 @@ extern void pm_runtime_put_suppliers(str
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device *dev);
>  
> +/**
> + * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> + * @dev: Target device.
> + *
> + * Increment the runtime PM usage counter of @dev if its runtime PM status is
> + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.

The implementation of the non-runtime PM variants (used when CONFIG_PM is
disabled) isn't here but I think it'd be nice if their behaviour was also
documented here. pm_runtime_get_if_in_use() returns -EINVAL if CONFIG_PM is
disabled, for instance.

pm_runtime_disable() is defined here but the documentation in corresponding
pm_runtime_enable() in drivers/base/power/runtime.c is rather terse. It'd
be nice to improve that now (or separately).

-- 
Kind regards,

Sakari Ailus
