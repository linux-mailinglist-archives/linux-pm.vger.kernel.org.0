Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4B15FE46
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 12:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgBOL6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Feb 2020 06:58:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57140 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgBOL6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Feb 2020 06:58:34 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2w5T-0007Jk-Vv; Sat, 15 Feb 2020 12:58:20 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 61C33101161; Sat, 15 Feb 2020 12:58:19 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexander Koskovich <zvnexus@gmail.com>, arjan@linux.intel.com,
        jacob.jun.pan@linux.intel.com
Cc:     zvnexus@gmail.com, Alexander Koskovich <zvnexus@outlook.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/intel_powerclamp: Don't report an error for AMD CPUs
In-Reply-To: <20200215160938.1025-1-zvnexus@outlook.com>
References: <20200215160938.1025-1-zvnexus@outlook.com>
Date:   Sat, 15 Feb 2020 12:58:19 +0100
Message-ID: <87wo8orrj8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Alexander Koskovich <zvnexus@gmail.com> writes:

> Resolves dmesg error "intel_powerclamp: CPU does not support MWAIT".
>
> The error that is outputted in dmesg prior to this patch
> is innacurate, AMD Ryzen CPUs do support MWAIT. We could
> also add the AMD vendor to the MWAIT check, but even though
> AMD CPUs do support MWAIT, they fail the C-state package
> check so it's better just to bail out in the beginning.
>
> Signed-off-by: Alexander Koskovich <zvnexus@outlook.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 53216dcbe173..3c5b25bfa596 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -650,6 +650,11 @@ static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
>  	.set_cur_state = powerclamp_set_cur_state,
>  };
>  
> +static const struct x86_cpu_id amd_cpu[] = {
> +	{ X86_VENDOR_AMD },
> +	{},
> +};
> +
>  static const struct x86_cpu_id __initconst intel_powerclamp_ids[] = {
>  	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_MWAIT },
>  	{}
> @@ -659,6 +664,11 @@ MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
>  static int __init powerclamp_probe(void)
>  {
>  
> +	if (x86_match_cpu(amd_cpu)) {
> +		pr_info("Intel PowerClamp does not support AMD CPUs\n");
> +		return -ENODEV;

This is still running into the same problem on all other non Intel
vendors, e.g. HYGON, VIA ....

> +	}
> +
>  	if (!x86_match_cpu(intel_powerclamp_ids)) {
>  		pr_err("CPU does not support MWAIT\n");
>  		return -ENODEV;

The right thing to do is to remove this silly pr_err(). It's not an
error when a CPU does not support MWAIT. It's a fact and even older
Intel CPUs do not have MWAIT.

We do not print "Machine does not have $FEATURE" in device drivers and
whatever code which depends on runtime detection either. dmesg would be
full of this.

Thanks,

        tglx
