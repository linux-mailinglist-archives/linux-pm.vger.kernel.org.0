Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F393515A5E8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgBLKOW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:14:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:11547 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgBLKOV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:14:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 02:14:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="222244543"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 12 Feb 2020 02:14:18 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1p2C-000ui5-K7; Wed, 12 Feb 2020 12:14:20 +0200
Date:   Wed, 12 Feb 2020 12:14:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        David Box <david.e.box@linux.intel.com>,
        x86 Maintainers <x86@kernel.org>
Subject: Re: [PATCH 15/28] x86: platform: iosf_mbi: Call cpu_latency_qos_*()
 instead of pm_qos_*()
Message-ID: <20200212101420.GQ10400@smile.fi.intel.com>
References: <1654227.8mz0SueHsU@kreacher>
 <2577606.BoWb2c14C5@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2577606.BoWb2c14C5@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 12:10:00AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/platform/intel/iosf_mbi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
> index 9e2444500428..526f70f27c1c 100644
> --- a/arch/x86/platform/intel/iosf_mbi.c
> +++ b/arch/x86/platform/intel/iosf_mbi.c
> @@ -265,7 +265,7 @@ static void iosf_mbi_reset_semaphore(void)
>  			    iosf_mbi_sem_address, 0, PUNIT_SEMAPHORE_BIT))
>  		dev_err(&mbi_pdev->dev, "Error P-Unit semaphore reset failed\n");
>  
> -	pm_qos_update_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
> +	cpu_latency_qos_update_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
>  
>  	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
>  				     MBI_PMIC_BUS_ACCESS_END, NULL);
> @@ -301,8 +301,8 @@ static void iosf_mbi_reset_semaphore(void)
>   * 4) When CPU cores enter C6 or C7 the P-Unit needs to talk to the PMIC
>   *    if this happens while the kernel itself is accessing the PMIC I2C bus
>   *    the SoC hangs.
> - *    As the third step we call pm_qos_update_request() to disallow the CPU
> - *    to enter C6 or C7.
> + *    As the third step we call cpu_latency_qos_update_request() to disallow the
> + *    CPU to enter C6 or C7.
>   *
>   * 5) The P-Unit has a PMIC bus semaphore which we can request to stop
>   *    autonomous P-Unit tasks from accessing the PMIC I2C bus while we hold it.
> @@ -338,7 +338,7 @@ int iosf_mbi_block_punit_i2c_access(void)
>  	 * requires the P-Unit to talk to the PMIC and if this happens while
>  	 * we're holding the semaphore, the SoC hangs.
>  	 */
> -	pm_qos_update_request(&iosf_mbi_pm_qos, 0);
> +	cpu_latency_qos_update_request(&iosf_mbi_pm_qos, 0);
>  
>  	/* host driver writes to side band semaphore register */
>  	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> @@ -547,8 +547,7 @@ static int __init iosf_mbi_init(void)
>  {
>  	iosf_debugfs_init();
>  
> -	pm_qos_add_request(&iosf_mbi_pm_qos, PM_QOS_CPU_DMA_LATENCY,
> -			   PM_QOS_DEFAULT_VALUE);
> +	cpu_latency_qos_add_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
>  
>  	return pci_register_driver(&iosf_mbi_pci_driver);
>  }
> @@ -561,7 +560,7 @@ static void __exit iosf_mbi_exit(void)
>  	pci_dev_put(mbi_pdev);
>  	mbi_pdev = NULL;
>  
> -	pm_qos_remove_request(&iosf_mbi_pm_qos);
> +	cpu_latency_qos_remove_request(&iosf_mbi_pm_qos);
>  }
>  
>  module_init(iosf_mbi_init);
> -- 
> 2.16.4
> 
> 
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


