Return-Path: <linux-pm+bounces-22944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7525A45056
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 23:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF045423FD5
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53175219304;
	Tue, 25 Feb 2025 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KAnwKFuR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K8nCdg74"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8C2185A0;
	Tue, 25 Feb 2025 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523033; cv=none; b=Gg21dzUl4rXbFQ7pmWNm1t7t8eRRekBf3Gy3aIryr8wZhSllSdV5O2EFq0gLp5/AQmqZG4islQ1E/TjuI+bf1Kn/Up2ymGeBlNXW9AiNoOum2fML57H+bnDURKaagLkqGxHF0HCmknnUK3VDkCf9itSlwuHEx3DpwME5I/M4jlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523033; c=relaxed/simple;
	bh=Pj3a2z1PvzTcUQikW8KAlFYcVrX4Wz7uqVop5UjhV8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KU8/avOI4ml2zU1HZuEld6fV5M31s9Mx6zePUQgUCVm+vMtTFnnmMv0rV1Y4ZPePYuWBawumezzGTYCmDak752msCI0f8WimB68C5/uQ+ixmdbtZ1GVjrns0ou4EPE51tZBnOJfYQYftAbmv8oQAPc5Q97AhjBHvdZISHfC+78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KAnwKFuR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K8nCdg74; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740523029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cuq2tRPGbCXYvJB8QxVc6NVMLZdSbr0Mx9ebhZ8Lo5E=;
	b=KAnwKFuRTFXhHC1lktU4qsqjsFnV/1Z6P1GIo94fWfz21EklovM1c9mr9leaTxsksWIPw/
	ENakV2w+r6dUWcb0UtIZddpMTkwq2gNKjKpiC+5NgMgTrpBeTdoF55m4yp9PxQzeu3x88c
	RTmVGwPG9epryMW6AUj6X/5AJr9C4vIPuhKTXfK6rzm9lK8fV65r6MxcH+Cu91w402XQsm
	lHTvw1vGuel+fkTYHwGW+0Sp+UaMkK/PrHEqXU6Ll1JELhQeqZvd8O2iTQao7/7qXgPQ7J
	Cy1hKRGBxsW8Ixm4sVD/yryJkHWaoVQrk7WuabNrRaay0TkqHHLp0zZH4jlBtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740523029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cuq2tRPGbCXYvJB8QxVc6NVMLZdSbr0Mx9ebhZ8Lo5E=;
	b=K8nCdg74Pu71vs9/LXSjAvNVEm3LIJt2iW0oR/4KnzOpiiaqZLhwNDkFP1d0vrKwR2G3MT
	c5tqz8kktftLYlDg==
To: Fab Stz <fabstz-it@yahoo.fr>, John Stultz <jstultz@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: [PATCH] intel_idle: Handle older CPUs, which stop the TSC in deeper
 C states, correctly
In-Reply-To: <87eczlg6ls.ffs@tglx>
References: <10cf96aa-1276-4bd4-8966-c890377030c3.ref@yahoo.fr>
 <10cf96aa-1276-4bd4-8966-c890377030c3@yahoo.fr>
 <22539099.EfDdHjke4D@debian>
 <CANDhNCqdpbi=r81NyXVWBbB5POj5nmrc7qo3r2bi1yYqYBgiAg@mail.gmail.com>
 <CANDhNCqFi1adk_MdejQC1bod5STHPDjaSB9imSGpRtJt3TbW1Q@mail.gmail.com>
 <c1d1b79c-bb2e-4a69-888d-a3301bcbfeb2@yahoo.fr>
 <CANDhNCreiCQUKccmW1wBtvVzQrfB=xC0GFRO65SHG-+Wfu1wtA@mail.gmail.com>
 <b9b58a9e-eb56-4acd-b854-0b5ccb8e6759@yahoo.fr> <87plkoau8w.ffs@tglx>
 <15f4f44d-6f73-4031-a7dc-d2105672bc81@yahoo.fr> <874j0jhiag.ffs@tglx>
 <5114de6a-e6ef-4459-9570-6dd2245fabd5@yahoo.fr> <87eczlg6ls.ffs@tglx>
Date: Tue, 25 Feb 2025 23:37:08 +0100
Message-ID: <87bjupfy7f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The Intel idle driver is preferred over the ACPI processor idle driver,
but fails to implement the work around for Core2 generation CPUs, where
the TSC stops in C2 and deeper C-states. This causes stalls and boot
delays, when the clocksource watchdog does not catch the unstable TSC
before the CPU goes deep idle for the first time.

The ACPI driver marks the TSC unstable when it detects that the CPU
supports C2 or deeper and the CPU does not have a non-stop TSC.

Add the equivivalent work around to the Intel idle driver to cure that.

Fixes: 18734958e9bf ("intel_idle: Use ACPI _CST for processor models without C-state tables")
Reported-by: Fab Stz <fabstz-it@yahoo.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/10cf96aa-1276-4bd4-8966-c890377030c3@yahoo.fr
---
 drivers/idle/intel_idle.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
+#include <asm/tsc.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -1799,6 +1800,9 @@ static void __init intel_idle_init_cstat
 		if (intel_idle_state_needs_timer_stop(state))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
+		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle");
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}

