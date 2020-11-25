Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27002C3D78
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 11:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgKYKND (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 05:13:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:2621 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgKYKNC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Nov 2020 05:13:02 -0500
IronPort-SDR: /2JYM1SHZUm9qH7KQMd2NZ/mKEOOEDOfwyVtDV7TEENJWZP8JPOhY/uq9PmtJzz2oQ6dB1bRyz
 IE+DUT9PSh6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="236240193"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="236240193"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 02:13:01 -0800
IronPort-SDR: xZn2TKBeYx4B0eFw7r1mDWU87WQsNebzT6iwf0nY6fQw94McAIJpMLR5BqHIVTskeaM7QxION9
 MKiifc8AJzPA==
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="478866270"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 02:12:59 -0800
Date:   Wed, 25 Nov 2020 18:15:36 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Assign DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_MAY_SKIP_RESUME to speed up s2ram
Message-ID: <20201125101534.GA17181@chenyu-office.sh.intel.com>
References: <20201124153221.11265-1-yu.c.chen@intel.com>
 <a8058c17-141d-986e-903d-462dc72999f1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8058c17-141d-986e-903d-462dc72999f1@molgen.mpg.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Paul,
On Tue, Nov 24, 2020 at 04:47:30PM +0100, Paul Menzel wrote:
> Dear Chen,
> 
> 
> Thank you for the patch.
> 
Thanks for reviewing this change.
> Am 24.11.20 um 16:32 schrieb Chen Yu:
> > The NIC is put in runtime suspend status when there is no wire connected.
> > As a result, it is safe to keep this NIC in runtime suspended during s2ram
> > because the system does not rely on the NIC plug event nor WOL to wake up
> > the system. Unlike the s2idle, s2ram does not need to manipulate S0ix settings
> > during suspend.
> 
> what happens, when I plug in a cable, when the suspend is in ACPI S3 state?
> I guess it’s ignored?
> 
I think it depends on the platform(or BIOS implementation).
On my platform it is ignored. When the system is running,
the plug event would generate a SCI, but if it is in S3,
whether to generate wake up event or not depends on the BIOS and
the sysfs whether the device is device_may_wakeup().
In summary, whether the NIC is in runtime_suspend() or system_suspended
does not impact the wake up from S3 by plug event.
> > This patch assigns DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
> > to the e1000e driver so that the s2ram could skip the .suspend_late(),
> > .suspend_noirq() and .resume_noirq() .resume_early() when possible.
> > Also skip .suspend() and .resume() if dev_pm_skip_suspend() and
> > dev_pm_skip_resume() return true, so as to speed up the s2ram.
> 
> What is sped up? Suspend or resume?
>
Both suspend and resume.
> Please also document, what system you tested this on, and what the numbers
> before and after are.
The platform I'm testing on a laptop with i5-8300H CPU and I219-LM NIC.

Before this change:
[  203.391465] e1000e 0000:00:1f.6: pci_pm_suspend+0x0/0x170 returned 0 after 323186 usecs
[  203.598307] e1000e 0000:00:1f.6: pci_pm_suspend_late+0x0/0x40 returned 0 after 4 usecs
[  203.654026] e1000e 0000:00:1f.6: pci_pm_suspend_noirq+0x0/0x290 returned 0 after 20915 usecs
[  203.714464] e1000e 0000:00:1f.6: pci_pm_resume_noirq+0x0/0x120 returned 0 after 19952 usecs
[  203.716208] e1000e 0000:00:1f.6: pci_pm_resume_early+0x0/0x30 returned 0 after 0 usecs
[  203.934399] e1000e 0000:00:1f.6: pci_pm_resume+0x0/0x90 returned 0 after 211437 usecs

After this change:
[  150.455612] e1000e 0000:00:1f.6: pci_pm_suspend+0x0/0x170 returned 0 after 14 usecs
[  150.987627] e1000e 0000:00:1f.6: pci_pm_suspend_late+0x0/0x40 returned 0 after 3 usecs
[  151.021659] e1000e 0000:00:1f.6: pci_pm_suspend_noirq+0x0/0x290 returned 0 after 1 usecs
[  151.087303] e1000e 0000:00:1f.6: pci_pm_resume_noirq+0x0/0x120 returned 0 after 0 usecs
[  151.112056] e1000e 0000:00:1f.6: pci_pm_resume_early+0x0/0x30 returned 0 after 0 usecs
[  151.136508] e1000e 0000:00:1f.6: pci_pm_resume+0x0/0x90 returned 0 after 3030 usecs
> 
> If there is a bug report, please note it too.
> 
This is an optimization for scenario when cable is unpluged, so there's
no dedicated bug report on this.
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >   drivers/base/power/main.c                  |  2 ++
> >   drivers/net/ethernet/intel/e1000e/netdev.c | 14 +++++++++++++-
> >   2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index c7ac49042cee..9cd8abba8612 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -580,6 +580,7 @@ bool dev_pm_skip_resume(struct device *dev)
> >   	return !dev->power.must_resume;
> >   }
> > +EXPORT_SYMBOL_GPL(dev_pm_skip_resume);
> >   /**
> >    * device_resume_noirq - Execute a "noirq resume" callback for given device.
> > @@ -2010,3 +2011,4 @@ bool dev_pm_skip_suspend(struct device *dev)
> >   	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> >   		pm_runtime_status_suspended(dev);
> >   }
> > +EXPORT_SYMBOL_GPL(dev_pm_skip_suspend);
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index b30f00891c03..d79fddabc553 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -6965,6 +6965,14 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
> >   	struct e1000_hw *hw = &adapter->hw;
> >   	int rc;
> > +	/* Runtime suspended means that there is no wired connection
> 
> Maybe explicitly use *cable* in here to avoid confusion?
> 
Okay.
> > +	 * and it has nothing to do with WOL that, we don't need to
> 
> Move the comma before *that*?
> 
Okay.
> > +	 * adjust the WOL settings. So it is safe to put NIC in
> > +	 * runtime suspend while doing system suspend.
> 
> I understood, that the NIC is already in runtime suspend? Could you please
> clarify the comment?
> 
Yes, it is already runtime suspended, I'll revise the comment.

Thanks,
Chenyu
> > +	 */
> > +	if (dev_pm_skip_suspend(dev))
> > +		return 0;
> > +
> >   	e1000e_flush_lpic(pdev);
> >   	e1000e_pm_freeze(dev);
> > @@ -6989,6 +6997,9 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
> >   	struct e1000_hw *hw = &adapter->hw;
> >   	int rc;
> > +	if (dev_pm_skip_resume(dev))
> > +		return 0;
> > +
> >   	/* Introduce S0ix implementation */
> >   	if (hw->mac.type >= e1000_pch_cnp &&
> >   	    !e1000e_check_me(hw->adapter->pdev->device))
> > @@ -7665,7 +7676,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >   	e1000_print_device_info(adapter);
> > -	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> > +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
> > +				DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME);
> >   	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
> >   		pm_runtime_put_noidle(&pdev->dev);
> 
> 
> Kind regards,
> 
> Paul
