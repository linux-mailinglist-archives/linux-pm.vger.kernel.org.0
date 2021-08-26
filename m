Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA803F90D5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 01:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhHZXFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbhHZXE7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 19:04:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6580C061757;
        Thu, 26 Aug 2021 16:04:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630019050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0gpa157GpPFxJE+YbjP2jHsHV1CvXem+6WSmprBT1tw=;
        b=YxuFW6u9c7YdvOjkgChqcmtRAJAr7EMNHixFt8BU7bH/N/bJpilFUitWU7BQe6+goVcIF4
        12uZrYGgC8boZk4MWlLLJxY8H2tpjAzRQbapFL5Rc7vvF8xbk3NqSjbKQM3eqXg1vDSuEA
        BIfgdtW0yvFwOCFfOYsTi+0LNr1YVgE6bJBbQLTVtE9thbNVMdXRz6wnju0DcBvrenIu5m
        yzWmQQrM8T8t3hTYMwqrI67yaNsYktynuNTHYwfRiqYBG2by2qKe/Xik14ZczawCx+48/y
        nmYvktUcqCBQjvnn79YRsu3wRnmZuUCeAEIHMwjEMWCNalkxAAscdswg48Tr0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630019050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0gpa157GpPFxJE+YbjP2jHsHV1CvXem+6WSmprBT1tw=;
        b=jRiv7cHT0qRBBthC9QARpOWd/yIlzDu/QkuOQnu4r9m22gstqOmiA28e2i8F/cr95Q8oaV
        OcopMFhMSJsEgZBA==
To:     Deepak Sharma <deepak.sharma@amd.com>, deepak.sharma@amd.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
In-Reply-To: <20210819004305.20203-1-deepak.sharma@amd.com>
References: <20210819004305.20203-1-deepak.sharma@amd.com>
Date:   Fri, 27 Aug 2021 01:04:09 +0200
Message-ID: <8735qv3j12.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 18 2021 at 17:43, Deepak Sharma wrote:

> AMD CPU which support C3 shares cache. Its not necessary to flush the
> caches in software before entering C3. This will cause performance drop
> for the cores which share some caches. ARB_DIS is not used with current
> AMD C state implementation. So set related flags correctly.
>
> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> ---
>  arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 7de599eba7f0..62a5986d625a 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>  		 */
>  		flags->bm_control = 0;
>  	}
> +	if (c->x86_vendor == X86_VENDOR_AMD) {
> +		/*
> +		 * For all AMD CPUs that support C3, caches should not be
> +		 * flushed by software while entering C3 type state. Set
> +		 * bm->check to 1 so that kernel doesn't need to execute
> +		 * cache flush operation.
> +		 */
> +		flags->bm_check = 1;
> +		/*
> +		 * In current AMD C state implementation ARB_DIS is no longer

Fine for current implementations, but what about older implementations?

Thanks,

        tglx
