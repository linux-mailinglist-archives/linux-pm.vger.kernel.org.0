Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7242E2CCD69
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 04:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLCDmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 22:42:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:57474 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgLCDmg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 22:42:36 -0500
IronPort-SDR: GBEn5/3SQW/WqAXIStfaeVQeoxITny9CmblOW+CQp7vBpxOOslVFBHX8OqWYxX12gxE9pm4CZ0
 gXZpeTZCXO4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="191353387"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="191353387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 19:41:56 -0800
IronPort-SDR: W79kZWISrCH+wcSWKMBeXeCvrM8VO6Ip9erwsxvSoxWbvPMzMkwbI+y5OYzZL6uzPuuTubpAB5
 y1JUfxs9S/rg==
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="481807881"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 19:41:55 -0800
Date:   Thu, 3 Dec 2020 11:44:43 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2][v2] e1000e: Assign DPM_FLAG_SMART_SUSPEND and
 DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
Message-ID: <20201203034443.GA4385@chenyu-office.sh.intel.com>
References: <cover.1606370334.git.yu.c.chen@intel.com>
 <ce83589757381a790153bd5947ea1f9346415102.1606370334.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce83589757381a790153bd5947ea1f9346415102.1606370334.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 02:14:40PM +0800, Chen Yu wrote:
> The NIC is put in runtime suspend status when there is no cable connected.
> As a result, it is safe to keep non-wakeup NIC in runtime suspended during
> s2ram because the system does not rely on the NIC plug event nor WoL to wake
> up the system. Besides that, unlike the s2idle, s2ram does not need to
> manipulate S0ix settings during suspend.
> 
> This patch assigns DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
> to the e1000e driver so that the s2ram could skip the .suspend_late(),
> .suspend_noirq() and .resume_noirq() .resume_early() when possible.
> Also skip .suspend() and .resume() if dev_pm_skip_suspend() and
> dev_pm_skip_resume() return true, so as to speed up the suspend and
> resume during s2ram.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Added test data and some commit log revise(Paul Menzel)
>     Only skip the suspend/resume if the NIC is not a wake up device specified
>     by the user(Kai-Heng Feng)
>
Deprecated and replaced by v3.

thanks,
Chenyu
