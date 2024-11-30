Return-Path: <linux-pm+bounces-18263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F79DF016
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 12:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E736F2828A6
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771615C15C;
	Sat, 30 Nov 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W48d//8c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbX1k1Ss"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02013C695;
	Sat, 30 Nov 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732965700; cv=none; b=Jgvi1gLV4C0273Gruh76hHbLXV5WpfMvR2Di23sxLYRWz06y3B2fhBGUnIFLQ/i6cMqVtjBMJ1suvUrGJsaWDjOM3jyTPyCL8UqcZ3Ylmm9tQ2puV40ff2Rb3FpVjVjCz+F0gBNtj6o4UDQY4FnOgajZowdklv3hF8RNYGbqfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732965700; c=relaxed/simple;
	bh=PjvKJ5710Gb3kD1DxMQEDFnwvzKL0Gs8ep+I/j/XA2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3zmjgVcmwezSCqN9rjC17ClmOfD1Cz/4cfF4cS6oQEhgoSWQTKw3UR80ojN7E2gdpjVmn6rijoxiRtQtFH6j+kCL7wFv9rNkI3UCk7QQbZP7HS/t5tcWRc2koHbdxaqCqCrhEC76OWY/wCQWkJTaanKoEZi43gJxVo6Inj/n4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W48d//8c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbX1k1Ss; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732965696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubFNGhee8AQUbXc00EUNlkCO7zOglb0GOC2LTLf32dU=;
	b=W48d//8cIlhAa6OiPAIXxmxxMZE8revJhPcVAUUrq46RM09DaueM53qSSh5AhBDO51bXVF
	etSR6nisR+3aDpv8seJQrMn+js3sXKdFtozghtloZfn5g7s4RFjlayUZ7S1MPf7nx0nHvZ
	DPrV9P2qA2Cki63aaRjyZmYHHnFYsRZnlKbsaH7cr/7KuD9ltTHCY8KuLoTMHHg6BJqTcB
	OC5HDL4DTMQabpHB7RKeye9mWbCdHLAHCnMDUFIqSPJ/eSC0LHc1i4so6acCeUt6gI8tfs
	GI2RZWbi2CnRRN3r6a1UZpufNEBUuBDwr435rN20+RSCwrE3vO5WUkkVhl4V3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732965696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubFNGhee8AQUbXc00EUNlkCO7zOglb0GOC2LTLf32dU=;
	b=ZbX1k1Ssa0vaggcUHWpCFltoMtEmCzl16pofzSLNIvaoGmGgQI7+j8HX2HIdmtyk7A/TYj
	OQ9+wzvZQgUGl+CA==
To: 20241015061522.25288-1-rui.zhang@intel.com, Zhang Rui <rui.zhang@intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
 yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
 srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org,
 linux-pm@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: bisected: [PATCH V4] x86/apic: Always explicitly disarm
 TSC-deadline timer
In-Reply-To: <20241128111844.GE10431@google.com>
References: <20241128111844.GE10431@google.com>
Date: Sat, 30 Nov 2024 12:21:36 +0100
Message-ID: <87o71xvuf3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 28 2024 at 20:18, Sergey Senozhatsky wrote:
>> Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
>> MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
>> to the initial-count register (APIC_TMICT) which is ignored in
>> TSC-deadline mode.
>
> So this commit hit stable and we now see section mismatch errors:
>
> // stripped
>
> WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> The relocation at __ex_table+0x447c references
> section ".irqentry.text" which is not in the list of
> authorized sections.
>
> WARNING: vmlinux.o(__ex_table+0x4480): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> The relocation at __ex_table+0x4480 references
> section ".irqentry.text" which is not in the list of
> authorized sections.
>
> FATAL: modpost: Section mismatches detected.
>
> Specifically because of wrmsrl.
>
> I'm aware of the section mismatch errors on linux-5.4 (I know), not
> aware of any other stable versions (but I haven't checked).  Is this
> something specific to linux-5.4?

So it seems the compiler inlines the inner guts of
sysvec_apic_timer_interrupt() and local_apic_timer_interrupt().

Can you try the patch below?

Thanks,

        tglx
---
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1007,7 +1007,7 @@ void setup_secondary_APIC_clock(void)
 /*
  * The guts of the apic timer interrupt
  */
-static void local_apic_timer_interrupt(void)
+static noinline void local_apic_timer_interrupt(void)
 {
 	struct clock_event_device *evt = this_cpu_ptr(&lapic_events);
 



