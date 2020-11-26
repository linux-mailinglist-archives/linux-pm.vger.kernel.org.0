Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C42C4EDE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 07:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgKZGgw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 26 Nov 2020 01:36:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34459 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388216AbgKZGgv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 01:36:51 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kiAtc-0008IA-QQ
        for linux-pm@vger.kernel.org; Thu, 26 Nov 2020 06:36:49 +0000
Received: by mail-pl1-f199.google.com with SMTP id c12so906483pll.12
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 22:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0TNrpxhz885n0vlqKPeUigEPpxte5fdCFowpmElQUl0=;
        b=HhB3ikpKlTrbvFF0ewUPqnDboPSDtGuUPuQrskyZDUjfT4p6k6noEckqjZ2lBCrXmK
         zKWKb4X5FYqh40nZADONwoesR9oPbgMlj5VsAKgAZXEhSuM09VzLmBRmHV15UGeQrN5u
         OuZu7flKDGwX3q4s0qGSg5wCftBy/y6XSHOga9aFL5R0oTlp661GP+s7vM9HzMiIfDdP
         uh1xCAgD92RHZAAl9LTRLTZs9i8UM5LjABE8jVvT1lc21+585HSqppyKHisLgpw0OELH
         39fJzDIK1eqJJGUAymBlwwWlOIyvy6t/XsRumllYfbVu1DlrJ2ml6aznUKcZMTAs6cvB
         3CoA==
X-Gm-Message-State: AOAM532kXCNHWmHXB5lQTrJV7Kbx99Q+tY5gcxL38O11rXvUPqc9gL+h
        EcvObmwiWbLPpEzwCpefjv+La9Nz9k+nvGVtLCyEFTAA8rUFlrm+f/JT3DHROPUAQuQPqBGXSla
        gckX6fFGHG8CKM3jMFzYx7hrl5pS2CJcJKWys
X-Received: by 2002:a62:8c08:0:b029:197:491c:bab1 with SMTP id m8-20020a628c080000b0290197491cbab1mr1482967pfd.49.1606372607401;
        Wed, 25 Nov 2020 22:36:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5aqydmL90QC4PsdiNqThIMoi9m7NqLLN82M9MfA3u/ezH1NWjaVv0powgCOONeZDTNtAFNg==
X-Received: by 2002:a62:8c08:0:b029:197:491c:bab1 with SMTP id m8-20020a628c080000b0290197491cbab1mr1482941pfd.49.1606372607020;
        Wed, 25 Nov 2020 22:36:47 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w131sm3575352pfd.14.2020.11.25.22.36.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2020 22:36:46 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND and
 DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201125103612.GA17700@chenyu-office.sh.intel.com>
Date:   Thu, 26 Nov 2020 14:36:42 +0800
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
Message-Id: <B66CCBD9-5828-4514-AD08-C6FDF026646D@canonical.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <8BA4D1E1-DACF-4E84-A5B8-75A7CEA65F98@canonical.com>
 <20201125103612.GA17700@chenyu-office.sh.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Nov 25, 2020, at 18:36, Chen Yu <yu.c.chen@intel.com> wrote:
> 
> Hi Kai-Heng,
> On Wed, Nov 25, 2020 at 01:17:28AM +0800, Kai-Heng Feng wrote:
>> Hi Yu,
>> 
>>> On Nov 24, 2020, at 23:32, Chen Yu <yu.c.chen@intel.com> wrote:
>>> 
>>> The NIC is put in runtime suspend status when there is no wire connected.
>>> As a result, it is safe to keep this NIC in runtime suspended during s2ram
>>> because the system does not rely on the NIC plug event nor WOL to wake up
>>> the system. Unlike the s2idle, s2ram does not need to manipulate S0ix settings
>>> during suspend.
>> 
>> Please see below for the reason why I explicitly disable direct-complete in the driver.
>> 
> Okay.
>>> 
>>> This patch assigns DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
>>> to the e1000e driver so that the s2ram could skip the .suspend_late(),
>>> .suspend_noirq() and .resume_noirq() .resume_early() when possible.
>>> Also skip .suspend() and .resume() if dev_pm_skip_suspend() and
>>> dev_pm_skip_resume() return true, so as to speed up the s2ram.
>> 
>> If we really want direct-complete here, maybe always set current WoL setting in runtime suspend routine?
>> 
> Indeed, that would be a choice.
>>> 
>>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>> ---
>>> drivers/base/power/main.c                  |  2 ++
>>> drivers/net/ethernet/intel/e1000e/netdev.c | 14 +++++++++++++-
>>> 2 files changed, 15 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index c7ac49042cee..9cd8abba8612 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -580,6 +580,7 @@ bool dev_pm_skip_resume(struct device *dev)
>>> 
>>> 	return !dev->power.must_resume;
>>> }
>>> +EXPORT_SYMBOL_GPL(dev_pm_skip_resume);
>> 
>> I don't think it's a good idea to use this predicate out side of PM core, must_resume may change during suspend process.
>> 
> The dev_pm_skip_resume() is used during system resume, not during suspend, so
> there would be no race condition I suppose?

I think it's better to let PM core to decide.

>>> 
>>> /**
>>> * device_resume_noirq - Execute a "noirq resume" callback for given device.
>>> @@ -2010,3 +2011,4 @@ bool dev_pm_skip_suspend(struct device *dev)
>>> 	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
>>> 		pm_runtime_status_suspended(dev);
>>> }
>>> +EXPORT_SYMBOL_GPL(dev_pm_skip_suspend);
>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> index b30f00891c03..d79fddabc553 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> @@ -6965,6 +6965,14 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
>>> 	struct e1000_hw *hw = &adapter->hw;
>>> 	int rc;
>>> 
>>> +	/* Runtime suspended means that there is no wired connection
>>> +	 * and it has nothing to do with WOL that, we don't need to
>>> +	 * adjust the WOL settings. So it is safe to put NIC in
>>> +	 * runtime suspend while doing system suspend.
>>> +	 */
>> 
>> What about plugging ethernet cable and using WoL after system is suspended?
>> Commit "e1000e: Exclude device from suspend direct complete optimization" was to address that scenario.
>> 
> Yes, this is what I concerned previously. So in order to support this case,
> let's adjust this by checking
> 	if (device_may_wakeup() && dev_pm_skip_suspend())
> 
> so that if the user has disabled WOL via sysfs then we do not fall
> into this optimization
> commit 6bf6be1127f7 ("e1000e: Do not wake up the system via WOL if
> device wakeup is disabled")

I don't think this is right.
Isn't E1000_WUFC_LNKC already set for runtime suspend?
What if WoL doesn't have it set?

>>> +	if (dev_pm_skip_suspend(dev))
>>> +		return 0;
>>> +
>>> 	e1000e_flush_lpic(pdev);
>>> 
>>> 	e1000e_pm_freeze(dev);
>>> @@ -6989,6 +6997,9 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>>> 	struct e1000_hw *hw = &adapter->hw;
>>> 	int rc;
>>> 
>>> +	if (dev_pm_skip_resume(dev))
>>> +		return 0;
>>> +
>>> 	/* Introduce S0ix implementation */
>>> 	if (hw->mac.type >= e1000_pch_cnp &&
>>> 	    !e1000e_check_me(hw->adapter->pdev->device))
>>> @@ -7665,7 +7676,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>> 
>>> 	e1000_print_device_info(adapter);
>>> 
>>> -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>>> +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
>>> +				DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME);
>>> 
>>> 	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
>>> 		pm_runtime_put_noidle(&pdev->dev);
>> 
>> Also, most e1000e device on modern platforms doesn't runtime suspend at all after commit "e1000e: Disable runtime PM on CNP+".
>> 
> Yes, I did some hack on this to make runtime suspend work.
> As we do have more newer NICs to come, how about removing the
> restriction of runtime suspend and let the user determine whether
> to enable the runtime suspend via echo 'on' or 'auto' via
> sysfs's control.

There's a discussion on enable runtime PM by default for all PCI devices.
So removing this workaround will expose the bug for users.

Let me get the system with the bug (Latitude 5500) and see if latest ACPI code can fix the GPE bug.

Kai-Heng

> 
> thanks,
> Chenyu
>> Kai-Heng
>> 
>>> -- 
>>> 2.25.1

