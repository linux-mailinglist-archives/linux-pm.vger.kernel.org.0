Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16E22EF000
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbhAHJrN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 04:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbhAHJrN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 04:47:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B8EC0612F4;
        Fri,  8 Jan 2021 01:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8WRLX2kaDsJY+o4udhvnvDiaBWbsajO7q4tF5t+56rk=; b=L6kSSVMfUTe4pRRSNNbDQu/BrS
        xq5ASwy+tiPty8UnOXdQb/+mDldNvz2vwG9Sc3/CMgx52OoDKkEVy8mdaMiONou6sd635qV7Zc2I+
        HS/GLykwK2YmgMTGvlkDjDgg47YWVuLKNCWmPuzmuN7xeLeaBQcQ47LXP42tc0hm7Fr+Cuk8/MYuY
        dRr05Mp9CJVU+Otn4yJlVRhE0XMOR0nXSu4cLIU5uBRwgNcyCG2Ncwf+hOX/NscQjPm9kA5f6BBK3
        +QaexPbza7q427YzqvP9rfdjdV7XBEBRL5Rjigquuvld0gtg//WUdhPL8bGK7hKUqrUYNR5Rkpof9
        2GvprmoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxoLc-0008QV-Hr; Fri, 08 Jan 2021 09:46:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A73F83013E5;
        Fri,  8 Jan 2021 10:46:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 947EA2BC2B366; Fri,  8 Jan 2021 10:46:17 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:46:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: Move therm_throt there from x86/mce
Message-ID: <X/gp6YRRwmjkDWa0@hirez.programming.kicks-ass.net>
References: <20210108085430.13449-1-bp@alien8.de>
 <20210108085430.13449-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108085430.13449-3-bp@alien8.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 08, 2021 at 09:54:30AM +0100, Borislav Petkov wrote:
> +#ifdef CONFIG_X86_THERMAL_VECTOR
> +static void unexpected_thermal_interrupt(void)
> +{
> +	pr_err("CPU%d: Unexpected LVT thermal interrupt!\n",
> +		smp_processor_id());
> +}
> +
> +static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
> +
> +void thermal_set_handler(void (*handler)(void))
> +{
> +	if (handler) {
		WARN_ON(smp_thermal_vector != unexpected_thermal_interrupt);
> +		smp_thermal_vector = handler;
> +	} else
> +		smp_thermal_vector = unexpected_thermal_interrupt;
> +}
> +EXPORT_SYMBOL_GPL(thermal_set_handler);

You really don't want multiple modules to touch that at the same time.

> +DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> +{
> +	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
> +	inc_irq_stat(irq_thermal_count);
> +	smp_thermal_vector();
> +	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
> +	ack_APIC_irq();
> +}
> +#endif
