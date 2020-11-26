Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E722C5743
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 15:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390052AbgKZOmz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 09:42:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:31376 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389991AbgKZOmz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 09:42:55 -0500
IronPort-SDR: bsByHOJ4PlaGcG3BAzyjIX04kEOmTaPYaMO+tJGMtrWd3y5ImOkPAcmIMm8wnYGos5hmZOVYbK
 CU0lTbOrKQTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="236422310"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="236422310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 06:42:54 -0800
IronPort-SDR: IpvuAOan0gOjeGeK1nz7PkafYroutIPYpgzNH1m0RxWf2UrtEi6aAEhIOiQvJ0u/xmdA3m5x7D
 GFelO//WciyA==
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="547739896"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 06:42:51 -0800
Date:   Thu, 26 Nov 2020 22:45:37 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sasha Neftin <sasha.neftin@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND and
 DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
Message-ID: <20201126144536.GA19171@chenyu-office.sh.intel.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
 <20201125103612.GA17700@chenyu-office.sh.intel.com>
 <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
 <20201126111053.GA15841@chenyu-office.sh.intel.com>
 <43247451-BA44-4958-A921-2BD0FF5FA5BA@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43247451-BA44-4958-A921-2BD0FF5FA5BA@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 08:05:02PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On Nov 26, 2020, at 19:10, Chen Yu <yu.c.chen@intel.com> wrote:
> > 
> > On Thu, Nov 26, 2020 at 02:36:42PM +0800, Kai-Heng Feng wrote:
> >>>> 
> >>>> What about plugging ethernet cable and using WoL after system is suspended?
> >>>> Commit "e1000e: Exclude device from suspend direct complete optimization" was to address that scenario.
> > [cut]
> >> 
> >> I don't think this is right.
> >> Isn't E1000_WUFC_LNKC already set for runtime suspend?
> >> What if WoL doesn't have it set?
> >> 
> > After re-taking a look at your description, please let me elaborate more about the scenario.
> > With this patch applied, and with sysfs wake up disabled, the expected behavior is:
> > 
> > 1. If NIC is not runtime suspended:
> > 1.1 s2ram suspend -> wufc will be set to 0(no WoL settings), suspend(), suspend_late(), suspend_noirq()
> > 1.2 s2ram resume  -> NIC resumes normaly
> > 
> > 2. If NIC is runtime suspended:
> > 2.1 s2ram suspend -> wufc set to E1000_WUFC_LNKC, skip the subsequent suspend callbacks.
> 
> Is it safe to keep E1000_WUFC_LNKC enabled here?
> 
> From commit 6bf6be1127f7 ("e1000e: Do not wake up the system via WOL if device wakeup is disabled"):
> 
>        /* Runtime suspend should only enable wakeup for link changes */
>        if (runtime)
>                wufc = E1000_WUFC_LNKC;
>        else if (device_may_wakeup(&pdev->dev))
>                wufc = adapter->wol;
>        else
>                wufc = 0;
> 
> So it has different wakeup settings for runtime suspend and system suspend, either device_may_wakeup() true or false.
Right.
> Or maybe e1000e devs can confirm E1000_WUFC_LNKC is a safe for system suspend?
>
Does 'safe' here mean waking up the system?
For s2ram, whether the NIC can wake up the system from S3 via cable plug is platform
(BIOS) specific. So the wufc settings here is not directly related to system wake up
via plug event.
thanks,
Chenyu
