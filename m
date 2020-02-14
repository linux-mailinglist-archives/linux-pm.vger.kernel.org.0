Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2829A15CF19
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 01:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgBNAgJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 19:36:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53556 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBNAgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 19:36:09 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2Oxa-0005sT-OQ; Fri, 14 Feb 2020 01:35:58 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 39163101115; Fri, 14 Feb 2020 01:35:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, rjw@rjwysocki.net,
        ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate arch_timer_rate
In-Reply-To: <20200211184542.29585-8-ionela.voinescu@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com> <20200211184542.29585-8-ionela.voinescu@arm.com>
Date:   Fri, 14 Feb 2020 01:35:58 +0100
Message-ID: <87mu9mgg41.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ionela Voinescu <ionela.voinescu@arm.com> writes:

> From: Valentin Schneider <valentin.schneider@arm.com>
>
> Using an arch timer with a frequency of less than 1MHz can result in an
> incorrect functionality of the system which assumes a reasonable rate.
>
> One example is the use of activity monitors for frequency invariance
> which uses the rate of the arch timer as the known rate of the constant
> cycle counter in computing its ratio compared to the maximum frequency
> of a CPU. For arch timer frequencies less than 1MHz this ratio could
> end up being 0 which is an invalid value for its use.
>
> Therefore, warn if the arch timer rate is below 1MHz which contravenes
> the recommended architecture interval of 1 to 50MHz.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>

So this patch is from Valentin. Where is his Signed-off-by?

>  
> +static int validate_timer_rate(void)
> +{
> +	if (!arch_timer_rate)
> +		return -EINVAL;
> +
> +	/* Arch timer frequency < 1MHz can cause trouble */
> +	WARN_ON(arch_timer_rate < 1000000);

This does not make sense to me. If the rate is out of bounds then why
warn an just continue instead of making it fail?

Thanks,

        tglx
