Return-Path: <linux-pm+bounces-20415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC8A10984
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A8D168BA6
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D79146D6E;
	Tue, 14 Jan 2025 14:34:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84A232437;
	Tue, 14 Jan 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865299; cv=none; b=o2dfyi8LArUhSN4D+/nRqkKRovp0VLSRfHToiq+0cHQE/uYSbJ14BYXx9HkRFqktlYKBjo5rfj2CCLWqbwjbD91QBhHkA9AXS/A18sDqSzW4066nXZArvmQRO+WUlRz7eDWwj7GXePJucorJfJMLSD18l3NkFyborPbbFx2Ma9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865299; c=relaxed/simple;
	bh=gJxcnXgfnjLUUWBAxBYT80drQQIN7wWM74Duz262sMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDeLq6JDl40JKbDPaz0Xc4dNFYKHRufmw9xIwjswdJvPQdf+apKA3vyFy7pls+ozzNCgs0uS8DnXG8cndJp6ujT1VULvkY6Z1YflS4KE4dxD44jutWbERK4sLZ/hNweVfqwSxw9cXMCCwmB6v7QJ/ml/mW+ovU1LlbNKZS7jSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B86F11FB;
	Tue, 14 Jan 2025 06:35:25 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32A3A3F673;
	Tue, 14 Jan 2025 06:34:55 -0800 (PST)
Date: Tue, 14 Jan 2025 14:34:52 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/6] cpuidle: Introduce CPUIDLE_FLAG_MWAIT
Message-ID: <Z4Z2DHENCad2hEFC@bogus>
References: <20250102150201.21639-1-frederic@kernel.org>
 <20250102150201.21639-3-frederic@kernel.org>
 <CAJZ5v0gEhGJCkfMn6jhF2D_4BYKJZev_Eyq5AhkTeT02_cHcXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gEhGJCkfMn6jhF2D_4BYKJZev_Eyq5AhkTeT02_cHcXQ@mail.gmail.com>

On Tue, Jan 14, 2025 at 03:01:26PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 2, 2025 at 4:02 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Provide a way to tell the cpuidle core about states monitoring
> > TIF_NEED_RESCHED on the hardware level, monitor/mwait users being the
> > only examples in use.
> >
> > This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
> > kinds of TIF_NEED_RESCHED watching states while keeping a necessary
> > distinction for the governors between software loops polling on
> > TIF_NEED_RESCHED and hardware monitored writes to thread flags.
> >
> > [fweisbec: _ Initialize flag from acpi_processor_setup_cstates() instead
> >              of acpi_processor_setup_lpi_states(), as the latter seem to
> >              be about arm64...
> >            _ Rename CPUIDLE_FLAG_NO_IPI to CPUIDLE_FLAG_MWAIT]
> >
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  drivers/acpi/processor_idle.c | 3 +++
> >  drivers/idle/intel_idle.c     | 5 ++++-
> >  include/linux/cpuidle.h       | 1 +
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > index 698897b29de2..66cb5536d91e 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -806,6 +806,9 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
> >                 if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
> >                         drv->safe_state_index = count;
> >
> > +               if (cx->entry_method == ACPI_CSTATE_FFH)
> > +                       state->flags |= CPUIDLE_FLAG_MWAIT;
> 
> FFH need not mean MWAIT in principle.
> 
> FFH in _CST means MWAIT in practice because _CST is used on x86 which
> implements FFH through MWAIT, but it would be good at least to put a
> comment here to explain that this code is only expected to run on x86.
> 
> Or better still, add something like acpi_arch_idle_state_flags(u8
> entry_method) that will return CPUIDLE_FLAG_MWAIT for ACPI_CSTATE_FFH
> and 0 otherwise and then do
> 
>     state->flags |= acpi_arch_idle_state_flags(cx->entry_method);
>

+1, was about to suggest the same. Though I am not aware of any Arm platforms
using C-States(LPI was added to suit Arm requirements), it is better to keep
the FFH definition arch specific.


-- 
Regards,
Sudeep

