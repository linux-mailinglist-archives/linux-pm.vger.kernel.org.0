Return-Path: <linux-pm+bounces-22778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C0CA416FC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAD3A6909
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD5241669;
	Mon, 24 Feb 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qdqBAv1J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UA7WOsMm"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4020AF7D;
	Mon, 24 Feb 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384813; cv=none; b=e9AtqlRJLLmMF5plXWyGq2i+ny4hL9h1/5QCWX0pO7NydlYqCP2CzB0VZ3aW1CPUV/r9WqhbFXpi5dSEHshTo2BwpANjh1P3zXdINGrBbaOTZmFRpnXIa2E+VlAUXFT4Q9OokJzhkDy8HpWmGsZKUzqQrnlytwUG1F9JNKmCN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384813; c=relaxed/simple;
	bh=DD2l+TmiryMvzQvMg8kHMPCRkLCW4HsgtVYbDqkbxjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HBgN2MFpucnX+Op9Gp2gFtgrg4L1pLJJZl5qZmbAHFch05qjBywBu3YgkEg0R4vN6BuUlsJ3vNZxWMxaK4chplCYhyvNiCPHvAyj5Ii1CaZGLnrkusBSyuKinoAxk9+/mGjKT1I04EenaXUKQWAxNifFt6R9YuPbNZOPVoHqzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qdqBAv1J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UA7WOsMm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740384809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOGFGue45DKblkveu4ONTX0L3iMOg1AAtjoILGRLvds=;
	b=qdqBAv1J4vMsAVqR3SbZdQIjFkHb25NlbyK9g+QBP/jO9Y2/4IjBRYrh6IXfO6yJIyjYn8
	zkGB7fze7PM0YfPS1y945VSTFLXnRrj0VSpLcaGKa5JIT5PUWN2n1XO2LYoZIywUmdEuN+
	bVId/P5ZCGk6q9IFmlOxdGbt4ayWAKmeP3+/RdFnAUAdQATZfkE44D3kcMNrRDED9v9leT
	fk3aSPGkkOXm91JdX6lBynMqN7Pqe1JAR5gjYliwbUeKHTDq/e9B2JpSg+STLYE2RKAlnL
	EE5JeM0ikqaZrurFX1ItuhT9Avb2g9oUP7HzG1oCiS0lNnI6AyQYJg/dFY1rPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740384809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOGFGue45DKblkveu4ONTX0L3iMOg1AAtjoILGRLvds=;
	b=UA7WOsMmQzXmuzL9tNYILYDM7rt7JMKLh/G+0zX52Ps2K5r1zBagpsI8xY595CGXGi3Lcj
	B3MAi+KO41JGpnCA==
To: Fab Stz <fabstz-it@yahoo.fr>, John Stultz <jstultz@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION] ? system is stuck in clocksource, >60s delay at
 boot time without tsc=unstable
In-Reply-To: <15f4f44d-6f73-4031-a7dc-d2105672bc81@yahoo.fr>
References: <10cf96aa-1276-4bd4-8966-c890377030c3.ref@yahoo.fr>
 <10cf96aa-1276-4bd4-8966-c890377030c3@yahoo.fr>
 <22539099.EfDdHjke4D@debian>
 <CANDhNCqdpbi=r81NyXVWBbB5POj5nmrc7qo3r2bi1yYqYBgiAg@mail.gmail.com>
 <CANDhNCqFi1adk_MdejQC1bod5STHPDjaSB9imSGpRtJt3TbW1Q@mail.gmail.com>
 <c1d1b79c-bb2e-4a69-888d-a3301bcbfeb2@yahoo.fr>
 <CANDhNCreiCQUKccmW1wBtvVzQrfB=xC0GFRO65SHG-+Wfu1wtA@mail.gmail.com>
 <b9b58a9e-eb56-4acd-b854-0b5ccb8e6759@yahoo.fr> <87plkoau8w.ffs@tglx>
 <15f4f44d-6f73-4031-a7dc-d2105672bc81@yahoo.fr>
Date: Mon, 24 Feb 2025 09:13:27 +0100
Message-ID: <874j0jhiag.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fab!

On Sun, Feb 23 2025 at 18:01, Fab Stz wrote:
> Le 15/01/2025 =C3=A0 17:59, Thomas Gleixner a =C3=A9crit=C2=A0:
>> AFAICT, that iMac 9.1 is Core 2 Duo based and that generation of
>> processors definitely had issues with the TSC in deeper idle states.
>
> Indeed, cpuinfo reports:
>
> model name      : Intel(R) Core(TM)2 Duo CPU     E8135  @ 2.66GHz

Ok.

>>> BTW, I tried the "processor.max_cstate=3D1" you mentioned but it didn't
>>> change anything on the delay and/or warning.
>>=20
>> That's weird, but we have no idea what kind of magic the BIOS implements
>> there for power management behind the kernels back. I assume that it
>> does because this generation of CPUs uses the ACPI processor idle driver
>> and that disables TSC when it detects that the system supports
>> C-states > 1.
>
> Output of these commands can be found in attached file cpuidle.txt

> + cat /sys/devices/system/cpu/cpuidle/current_driver
> intel_idle

So according to that the intel_idle driver is in use, which does not
have the magic TSC workarounds like the acpi processor driver has, but
it seems to be loaded preferred.

Sigh. Why is the intel_idle driver so agressive in taking over despite
the fact that it does not handle the old CPUs, which are known to
require the TSC workaround? It handles the APIC stops in C2, but not the
TSC oddity while the original ACPI processor_idle driver does the right
thing for more than two decades....

> Can the kernel be patched so that the proper config is used=20
> automatically (ie. without the user having to set any parameter)? I'm=20
> not sure my question actually makes sense.

Yes, we can. Untested patch below. It just brings the intel idle driver
on par with the original ACPI processor idle driver to deal with that
problem.

Thanks,

        tglx
---
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d37c22..0fdb1d1316c4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
+#include <asm/tsc.h>
 #include <asm/fpu/api.h>
=20
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -1799,6 +1800,9 @@ static void __init intel_idle_init_cstates_acpi(struc=
t cpuidle_driver *drv)
 		if (intel_idle_state_needs_timer_stop(state))
 			state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
=20
+		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle");
+
 		state->enter =3D intel_idle;
 		state->enter_s2idle =3D intel_idle_s2idle;
 	}

