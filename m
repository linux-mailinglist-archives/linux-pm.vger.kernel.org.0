Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7152C2BB8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbgKXPrf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 10:47:35 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43397 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389383AbgKXPrf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 10:47:35 -0500
Received: from [192.168.0.3] (ip5f5af1dc.dynamic.kabel-deutschland.de [95.90.241.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A77420646221;
        Tue, 24 Nov 2020 16:47:31 +0100 (CET)
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
To:     Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        intel-wired-lan@lists.osuosl.org
References: <20201124153221.11265-1-yu.c.chen@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a8058c17-141d-986e-903d-462dc72999f1@molgen.mpg.de>
Date:   Tue, 24 Nov 2020 16:47:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124153221.11265-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Chen,


Thank you for the patch.

Am 24.11.20 um 16:32 schrieb Chen Yu:
> The NIC is put in runtime suspend status when there is no wire connected.
> As a result, it is safe to keep this NIC in runtime suspended during s2ram
> because the system does not rely on the NIC plug event nor WOL to wake up
> the system. Unlike the s2idle, s2ram does not need to manipulate S0ix settings
> during suspend.

what happens, when I plug in a cable, when the suspend is in ACPI S3 
state? I guess it’s ignored?

> This patch assigns DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
> to the e1000e driver so that the s2ram could skip the .suspend_late(),
> .suspend_noirq() and .resume_noirq() .resume_early() when possible.
> Also skip .suspend() and .resume() if dev_pm_skip_suspend() and
> dev_pm_skip_resume() return true, so as to speed up the s2ram.

What is sped up? Suspend or resume?

Please also document, what system you tested this on, and what the 
numbers before and after are.

If there is a bug report, please note it too.

> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>   drivers/base/power/main.c                  |  2 ++
>   drivers/net/ethernet/intel/e1000e/netdev.c | 14 +++++++++++++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c7ac49042cee..9cd8abba8612 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -580,6 +580,7 @@ bool dev_pm_skip_resume(struct device *dev)
>   
>   	return !dev->power.must_resume;
>   }
> +EXPORT_SYMBOL_GPL(dev_pm_skip_resume);
>   
>   /**
>    * device_resume_noirq - Execute a "noirq resume" callback for given device.
> @@ -2010,3 +2011,4 @@ bool dev_pm_skip_suspend(struct device *dev)
>   	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
>   		pm_runtime_status_suspended(dev);
>   }
> +EXPORT_SYMBOL_GPL(dev_pm_skip_suspend);
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b30f00891c03..d79fddabc553 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6965,6 +6965,14 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
>   	struct e1000_hw *hw = &adapter->hw;
>   	int rc;
>   
> +	/* Runtime suspended means that there is no wired connection

Maybe explicitly use *cable* in here to avoid confusion?

> +	 * and it has nothing to do with WOL that, we don't need to

Move the comma before *that*?

> +	 * adjust the WOL settings. So it is safe to put NIC in
> +	 * runtime suspend while doing system suspend.

I understood, that the NIC is already in runtime suspend? Could you 
please clarify the comment?

> +	 */
> +	if (dev_pm_skip_suspend(dev))
> +		return 0;
> +
>   	e1000e_flush_lpic(pdev);
>   
>   	e1000e_pm_freeze(dev);
> @@ -6989,6 +6997,9 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>   	struct e1000_hw *hw = &adapter->hw;
>   	int rc;
>   
> +	if (dev_pm_skip_resume(dev))
> +		return 0;
> +
>   	/* Introduce S0ix implementation */
>   	if (hw->mac.type >= e1000_pch_cnp &&
>   	    !e1000e_check_me(hw->adapter->pdev->device))
> @@ -7665,7 +7676,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   	e1000_print_device_info(adapter);
>   
> -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
> +				DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME);
>   
>   	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
>   		pm_runtime_put_noidle(&pdev->dev);


Kind regards,

Paul
