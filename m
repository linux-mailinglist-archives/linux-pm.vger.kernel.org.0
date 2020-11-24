Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D256A2C2E49
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbgKXRRj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 24 Nov 2020 12:17:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33463 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390745AbgKXRRg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 12:17:36 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1khbwc-00011m-02
        for linux-pm@vger.kernel.org; Tue, 24 Nov 2020 17:17:34 +0000
Received: by mail-pg1-f199.google.com with SMTP id 22so15457577pge.7
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 09:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VRMiJUNLgr9M7h46m/eHssvcueu9oqfWJ7ck5ke8IpY=;
        b=tFK+wXyqEaDDnbPy0W26Yddy86gidMrOSic5r10ocBwpZfMccwSflDASKp2sx6Lvpf
         ipXPNVd3SMXMASzQ+G3xrXQI1ExY/Zk3dga1/p0wx8afqlk35GgZjbcI4KsvHQPeox/c
         EqP4JVA26vNUanUc9lQdaPgZj6xvzCYflQNW+Z2DLBhviANd8ECtaDSAewZiJq0v5lCf
         3QyBkoVvGbB390DbKtSWb2aIIkrFLYEvyOoU15iHlClUTMoFeSiKBiue8pDDNVM4ykLc
         uUQRFGu9FpS6dZRY60eLGK1NGUTKsbDm1sbjr2aH3UkKKrWwv499S9qOeL0FUPb74eaS
         MNOA==
X-Gm-Message-State: AOAM531dE1Lcs/QZWnRTB3rOqpG3lhLKmSDni3UpLcO1sUBE3F54CxPz
        xB34b8kyDR6bTzYe1TnaOYkbq6pKLgWVGXogzKr90XaD+xj0T/XKPwoJuHW69D8gj6zz7Cz7LXt
        4+MV03Xr02YXuPkGbMJlrqipYGTB0riAYItUE
X-Received: by 2002:a05:6a00:794:b029:197:e418:ac4d with SMTP id g20-20020a056a000794b0290197e418ac4dmr4887482pfu.47.1606238252494;
        Tue, 24 Nov 2020 09:17:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIVyAqIJC5/bha05OEWX9Zk7sJdoBbnLioL22z3QEJ5PX0MShrmdxI3UM/mbFBfxGHgiS6Hg==
X-Received: by 2002:a05:6a00:794:b029:197:e418:ac4d with SMTP id g20-20020a056a000794b0290197e418ac4dmr4887455pfu.47.1606238252111;
        Tue, 24 Nov 2020 09:17:32 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id o132sm14969443pfg.100.2020.11.24.09.17.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 09:17:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND and
 DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201124153221.11265-1-yu.c.chen@intel.com>
Date:   Wed, 25 Nov 2020 01:17:28 +0800
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
Content-Transfer-Encoding: 8BIT
Message-Id: <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yu,

> On Nov 24, 2020, at 23:32, Chen Yu <yu.c.chen@intel.com> wrote:
> 
> The NIC is put in runtime suspend status when there is no wire connected.
> As a result, it is safe to keep this NIC in runtime suspended during s2ram
> because the system does not rely on the NIC plug event nor WOL to wake up
> the system. Unlike the s2idle, s2ram does not need to manipulate S0ix settings
> during suspend.

Please see below for the reason why I explicitly disable direct-complete in the driver.

> 
> This patch assigns DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
> to the e1000e driver so that the s2ram could skip the .suspend_late(),
> .suspend_noirq() and .resume_noirq() .resume_early() when possible.
> Also skip .suspend() and .resume() if dev_pm_skip_suspend() and
> dev_pm_skip_resume() return true, so as to speed up the s2ram.

If we really want direct-complete here, maybe always set current WoL setting in runtime suspend routine?

> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> drivers/base/power/main.c                  |  2 ++
> drivers/net/ethernet/intel/e1000e/netdev.c | 14 +++++++++++++-
> 2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c7ac49042cee..9cd8abba8612 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -580,6 +580,7 @@ bool dev_pm_skip_resume(struct device *dev)
> 
> 	return !dev->power.must_resume;
> }
> +EXPORT_SYMBOL_GPL(dev_pm_skip_resume);

I don't think it's a good idea to use this predicate out side of PM core, must_resume may change during suspend process.

> 
> /**
>  * device_resume_noirq - Execute a "noirq resume" callback for given device.
> @@ -2010,3 +2011,4 @@ bool dev_pm_skip_suspend(struct device *dev)
> 	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> 		pm_runtime_status_suspended(dev);
> }
> +EXPORT_SYMBOL_GPL(dev_pm_skip_suspend);
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b30f00891c03..d79fddabc553 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6965,6 +6965,14 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
> 	struct e1000_hw *hw = &adapter->hw;
> 	int rc;
> 
> +	/* Runtime suspended means that there is no wired connection
> +	 * and it has nothing to do with WOL that, we don't need to
> +	 * adjust the WOL settings. So it is safe to put NIC in
> +	 * runtime suspend while doing system suspend.
> +	 */

What about plugging ethernet cable and using WoL after system is suspended?
Commit "e1000e: Exclude device from suspend direct complete optimization" was to address that scenario.

> +	if (dev_pm_skip_suspend(dev))
> +		return 0;
> +
> 	e1000e_flush_lpic(pdev);
> 
> 	e1000e_pm_freeze(dev);
> @@ -6989,6 +6997,9 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
> 	struct e1000_hw *hw = &adapter->hw;
> 	int rc;
> 
> +	if (dev_pm_skip_resume(dev))
> +		return 0;
> +
> 	/* Introduce S0ix implementation */
> 	if (hw->mac.type >= e1000_pch_cnp &&
> 	    !e1000e_check_me(hw->adapter->pdev->device))
> @@ -7665,7 +7676,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
> 	e1000_print_device_info(adapter);
> 
> -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
> +				DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME);
> 
> 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
> 		pm_runtime_put_noidle(&pdev->dev);

Also, most e1000e device on modern platforms doesn't runtime suspend at all after commit "e1000e: Disable runtime PM on CNP+".

Kai-Heng

> -- 
> 2.25.1
> 

