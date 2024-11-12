Return-Path: <linux-pm+bounces-17361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6559C4AB4
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 01:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551F81F231B9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A001CF7B8;
	Tue, 12 Nov 2024 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="so89ehvv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkWHtz4f"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B9481B6;
	Tue, 12 Nov 2024 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371257; cv=none; b=m0hcFVv51SDbpllFnwl9lw+8tVDVPNvfaVvhGK/2qTm/MlYZjkpNW78wx29JY/G53P8uXz1Hn6eUEvcgVzj0YEyjEzNMp+Trn7eGgoi7ehjbSQn6q6qZk8KOKj14L4IZ5k1JX2TPKDuX63Rnc3B0rQ+oRWA5Cbgesmw2VYxgYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371257; c=relaxed/simple;
	bh=a7/TgUjMn6ho1gjy0uGqBCS6T/+OApJpN/TXKYjdtzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sjt9zmhisCNJEMHVIE+JVe2UuM6yC7aJ+yXRZKp3Z/3JcrLRBoZQgtEcCG19ZfUimfIMBYagR9OOO2JOtcb1BHD/lwjCDnf1I/VW9rgLhPoMoWsJf5dAPqAzEAwdLIwv9/0bvsf2rhULcie1z05pRltmJp8PUJbDW4Jo+OceXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=so89ehvv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JkWHtz4f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731371253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/0EJRWuUesVbgPQELwMXBSRdd+j7HBi2B68aTjNQ9c=;
	b=so89ehvvA7R75zntRGjF5hL0pJ83el6oavrDsxd+ai3WNSrONU9u16lQXPlFUoKMLuBII2
	pXS7vdUNlq4ZAygg/vviwNTGJ3seryQRbMap5g6vXS1XPLg1ZQPQLlAX4+emQGcBKanS0I
	9aHNy/JDIad3LaZOkASphAmUOxC8pmaUL4ieykA64rB/Pu6SxHAuxma0tGATSkFJpuF6SW
	CAK9UAkK7+aGHnbBx4J5T7TW+P1Wbq4UyZGpy7EkxU0z5FjELbKjbQxVWOlEKEujE5MHDY
	2sS//6qgJvLhZxFDbYI3qWi4uWO6e0WHxPeqMtySzJIT+Sih35v9VQZ3J45npw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731371253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/0EJRWuUesVbgPQELwMXBSRdd+j7HBi2B68aTjNQ9c=;
	b=JkWHtz4fiuaeDZLc6VD3fQS0SqHrs0Ba/1rvgg5JrwNWxgsPY0QjECPIMzWaNhbJ3i2Z8X
	43zlv97uIsYkFiCA==
To: Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
In-Reply-To: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
References: <20241108135206.435793-1-lenb@kernel.org>
 <20241108135206.435793-3-lenb@kernel.org>
 <20241111162316.GH22801@noisy.programming.kicks-ass.net>
Date: Tue, 12 Nov 2024 01:27:06 +0100
Message-ID: <87jzd9nvol.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024 at 17:23, Peter Zijlstra wrote:
> On Fri, Nov 08, 2024 at 08:49:31AM -0500, Len Brown wrote:
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 766f092dab80..910cb2d72c13 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1377,6 +1377,9 @@ void smp_kick_mwait_play_dead(void)
>>  		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
>>  			/* Bring it out of mwait */
>>  			WRITE_ONCE(md->control, newstate);
>> +			/* If MONITOR unreliable, send IPI */
>> +			if (boot_cpu_has_bug(X86_BUG_MONITOR))
>> +				__apic_send_IPI(cpu, RESCHEDULE_VECTOR);
>>  			udelay(5);
>>  		}
>
> Going over that code again, mwait_play_dead() is doing __mwait(.exc=0)
> with IRQs disabled.

And the APIC is shut down. So it won't react on the IPI either.

> So that IPI you're trying to send there won't do no nothing :-/
>
> Now that comment there says MCE/NMI/SMI are still open (non-maskable
> etc.) so perhaps prod it on the NMI vector?
>
> This does seem to suggest the above code path wasn't actually tested.

I'm not sure whether that's just a suggestion :)

> Perhaps mark your local machine with BUG_MONITOR, remove the md->control
> WRITE_ONCE() and try kexec to test it?
>
> Thomas, any other thoughts?

NMI should work. See exc_nmi():

	if (arch_cpu_is_offline(smp_processor_id())) {
		if (microcode_nmi_handler_enabled())
			microcode_offline_nmi_handler();
		return;
	}

Thanks,

        tglx

