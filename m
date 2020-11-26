Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC35E2C5344
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 12:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgKZLuN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 06:50:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:6064 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732480AbgKZLuM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 06:50:12 -0500
IronPort-SDR: n5N4lAokt0iYjkBmxaIixSLObneZzOwnvjAqYv/iT1idcFwpRW6a9gCcJ1QmZfINLbXspeRAqE
 rhvHeYgKZVrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="160044513"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="160044513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:08:10 -0800
IronPort-SDR: /otGytfWFdq11RlkqghqeGVZ5TK8O2oVv3LITrALkdBxK95l6C9CFbg2bATVVs3oY3X+CXJeez
 +5Nka8IWZHmw==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="479318878"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:08:08 -0800
Date:   Thu, 26 Nov 2020 19:10:54 +0800
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
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND and
 DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
Message-ID: <20201126111053.GA15841@chenyu-office.sh.intel.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
 <20201125103612.GA17700@chenyu-office.sh.intel.com>
 <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 02:36:42PM +0800, Kai-Heng Feng wrote:
> >> 
> >> What about plugging ethernet cable and using WoL after system is suspended?
> >> Commit "e1000e: Exclude device from suspend direct complete optimization" was to address that scenario.
[cut]
> 
> I don't think this is right.
> Isn't E1000_WUFC_LNKC already set for runtime suspend?
> What if WoL doesn't have it set?
>
After re-taking a look at your description, please let me elaborate more about the scenario.
With this patch applied, and with sysfs wake up disabled, the expected behavior is:

1. If NIC is not runtime suspended:
 1.1 s2ram suspend -> wufc will be set to 0(no WoL settings), suspend(), suspend_late(), suspend_noirq()
 1.2 s2ram resume  -> NIC resumes normaly

2. If NIC is runtime suspended:
 2.1 s2ram suspend -> wufc set to E1000_WUFC_LNKC, skip the subsequent suspend callbacks.
 2.2 s2ram resume -> skip the subsequent resume callbacks.

If between 2.1 and 2.2, the cable is plugged, the user is unable to use WoL to wake up
the system.

But if the sysfs wake up is enabled, the code logic falls into the old path, and
the user can wake up the system via WoL by plugging the cable, and send packages to the
system. Or do I miss something?

thanks,
Chenyu


