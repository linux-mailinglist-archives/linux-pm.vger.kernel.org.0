Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF86160C07
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 08:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBQH7j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 02:59:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:16751 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgBQH7i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Feb 2020 02:59:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 23:59:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; 
   d="scan'208";a="229120141"
Received: from zhouy1-mobl1.ccr.corp.intel.com ([10.249.169.88])
  by fmsmga008.fm.intel.com with ESMTP; 16 Feb 2020 23:59:35 -0800
Message-ID: <19d5aad060442ca4917046286b82e723199d4088.camel@intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: Don't report an error for AMD
 CPUs
From:   Zhang Rui <rui.zhang@intel.com>
To:     Alexander Koskovich <zvnexus@gmail.com>, arjan@linux.intel.com,
        jacob.jun.pan@linux.intel.com
Cc:     Alexander Koskovich <zvnexus@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Feb 2020 15:59:34 +0800
In-Reply-To: <20200215160938.1025-1-zvnexus@outlook.com>
References: <20200215160938.1025-1-zvnexus@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2020-02-15 at 11:09 -0500, Alexander Koskovich wrote:
> Resolves dmesg error "intel_powerclamp: CPU does not support MWAIT".
> 
> The error that is outputted in dmesg prior to this patch
> is innacurate, AMD Ryzen CPUs do support MWAIT. We could
> also add the AMD vendor to the MWAIT check, but even though
> AMD CPUs do support MWAIT, they fail the C-state package
> check so it's better just to bail out in the beginning.
> 
> Signed-off-by: Alexander Koskovich <zvnexus@outlook.com>

I think you're resending the same patch.

As intel_powerclamp_ids already checks for Intel CPUs, so we don't need
the check for AMD CPU, but instead, just remove the following line

"pr_err("CPU does not support MWAIT\n");"

when intel_powerclamp driver fails to probe.

thanks,
rui

> ---
>  drivers/thermal/intel/intel_powerclamp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/thermal/intel/intel_powerclamp.c
> b/drivers/thermal/intel/intel_powerclamp.c
> index 53216dcbe173..3c5b25bfa596 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -650,6 +650,11 @@ static struct thermal_cooling_device_ops
> powerclamp_cooling_ops = {
>  	.set_cur_state = powerclamp_set_cur_state,
>  };
>  
> +static const struct x86_cpu_id amd_cpu[] = {
> +	{ X86_VENDOR_AMD },
> +	{},
> +};
> +
>  static const struct x86_cpu_id __initconst intel_powerclamp_ids[] =
> {
>  	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY,
> X86_FEATURE_MWAIT },
>  	{}
> @@ -659,6 +664,11 @@ MODULE_DEVICE_TABLE(x86cpu,
> intel_powerclamp_ids);
>  static int __init powerclamp_probe(void)
>  {
>  
> +	if (x86_match_cpu(amd_cpu)) {
> +		pr_info("Intel PowerClamp does not support AMD
> CPUs\n");
> +		return -ENODEV;
> +	}
> +
>  	if (!x86_match_cpu(intel_powerclamp_ids)) {
>  		pr_err("CPU does not support MWAIT\n");
>  		return -ENODEV;

