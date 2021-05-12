Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2534937B7BA
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhELIV0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 04:21:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:50322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhELIV0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 May 2021 04:21:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620807617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vza9DD+KUbiRtLfI0mIL3ImF5EprHsvwKgA+ti787LI=;
        b=SEUCFz0zu0Zp1BQ9xz1mNFPtDYhbTNwQhQo77/WPTDUSYSs9YYUUH3rHkmMfCEgx7RVIJp
        dwIeahyOWnteniGqdd3VuYtW/CarKwLYLktS4+AtvvPlDD3WewhKIPFriqz5n56j3P2hbq
        S4D13UGTFc3ksE8v03AOtcpvvI1r4nc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28C1BAF2C;
        Wed, 12 May 2021 08:20:17 +0000 (UTC)
Date:   Wed, 12 May 2021 10:20:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 02/10] reboot: Add hardware protection power-off
Message-ID: <YJuPwAZroVZ/w633@alley>
References: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
 <97260f8e150abb898a262fade25860609b460912.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97260f8e150abb898a262fade25860609b460912.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 2021-05-10 14:28:30, Matti Vaittinen wrote:
> There can be few cases when we need to shut-down the system in order to
> protect the hardware. Currently this is done at east by the thermal core
> when temperature raises over certain limit.
> 
> Some PMICs can also generate interrupts for example for over-current or
> over-voltage, voltage drops, short-circuit, ... etc. On some systems
> these are a sign of hardware failure and only thing to do is try to
> protect the rest of the hardware by shutting down the system.
> 
> Add shut-down logic which can be used by all subsystems instead of
> implementing the shutdown in each subsystem. The logic is stolen from
> thermal_core with difference of using atomic_t instead of a mutex in
> order to allow calls directly from IRQ context.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index a6ad5eb2fa73..5da8c80a2647 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -518,6 +519,85 @@ void orderly_reboot(void)
>  }
>  EXPORT_SYMBOL_GPL(orderly_reboot);
>  
> +/**
> + * hw_failure_emergency_poweroff_func - emergency poweroff work after a known delay
> + * @work: work_struct associated with the emergency poweroff function
> + *
> + * This function is called in very critical situations to force
> + * a kernel poweroff after a configurable timeout value.
> + */
> +static void hw_failure_emergency_poweroff_func(struct work_struct *work)
> +{
> +	/*
> +	 * We have reached here after the emergency shutdown waiting period has
> +	 * expired. This means orderly_poweroff has not been able to shut off
> +	 * the system for some reason.
> +	 *
> +	 * Try to shut down the system immediately using kernel_power_off
> +	 * if populated
> +	 */
> +	WARN(1, "Hardware protection timed-out. Trying forced poweroff\n");
> +	kernel_power_off();

WARN() look like an overkill here. It prints many lines that are not
much useful in this case. The function is called from well-known
context (workqueue worker).

Also be aware that "panic_on_warn" commandline option will trigger
panic() here.


> +	/*
> +	 * Worst of the worst case trigger emergency restart
> +	 */
> +	WARN(1,
> +	     "Hardware protection shutdown failed. Trying emergency restart\n");
> +	emergency_restart();

Two consecutive WARN() calls are even less useful. They are eye
catching but it is hard to find the only useful line with
the custom message.

Best Regards,
Petr
