Return-Path: <linux-pm+bounces-27810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A0AC7EF9
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67665020F3
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C42226863;
	Thu, 29 May 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JHYx4pEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB3225403;
	Thu, 29 May 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526054; cv=none; b=RXkwJdQ1MIq4VQBbEWb2y34380OXtfI2ZmI/Gd8+ISI32rG1AAtBKzGeNwQbHSwmNJqvcAEs9U2Yhk1ytPLVLiYg5qxID1Wl6NX5b6Jy/topbM1DcBLTHEXRD7qMHJRMHPeAlolveW2/FllMGNzl+I3fYHNCKcWOfir5feGDyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526054; c=relaxed/simple;
	bh=zi9CAd0UHwTnmwGtSb/HavByLsmoluZyCSlkqqj3zmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjcaZuKzL6pFPKqLTzeQS2Vv0zWJKPcaxC+5wfxkiIrfI+OyucX3VAjV9Kq+pbyaFykIpRMUj4Hh0ayRFwQyEo8wisPR+2V0thEN+oxrLGwNzEOamGjBCq9Lodl3pZy/Lo45DDPzIgG/jEK1mxPojfZNmJLqijjqBxGkAkQFkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JHYx4pEF; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 72A98669948;
	Thu, 29 May 2025 15:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748526044;
	bh=zi9CAd0UHwTnmwGtSb/HavByLsmoluZyCSlkqqj3zmc=;
	h=From:Subject:Date;
	b=JHYx4pEFCJrbFuI4gpcbab1Y8MNML5AyxgNj3RivHQPq27wMssK0uQeoxyOEyp8Yd
	 hVm/pTd3aXf4LimM4ncYp8MkS88neALw9ZCmoFiRBjrxD9y+k5SY8qE+qUGgpl4L1w
	 6ovTQWxRz25tsCdT+0wVaFWiEY8zu3Wdz/N67hY8OOPiIbeFAeIztyWyOafPh+U97q
	 Q1JB/Y2H9hAzxw5JnIT1Qu1f0uJY3cjxe3p9x3tccSglXyJeFzPD/w+pSWT2tQCc7n
	 bWX/BD0ApZ6cmZ6GXYQ4tc1c5M2IEl9v4weiokaq2OwE3UMYW2FvHET7YsSdOl4KI3
	 u+B0z/v8hfZdA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v2] Revert "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"
Date: Thu, 29 May 2025 15:40:43 +0200
Message-ID: <12674167.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <2006806.PYKUYFuaPT@rjwysocki.net>
References: <2006806.PYKUYFuaPT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTFl0QnGpgeAjMEeSCFFZ+8HOWDB8vO95E+K52OCRkJysfFChtAuE6Oz9BdFCckBv2tQAvoFVlQ7bOsM1b2AFojVaIxc7c9AEc96CpmBH77jOe1uN5xyeGpOcnz/zOUTWYhqueZVgjNWse+VaoaY/rAeTu/tNbaVOyBJKZGMdPNq1Eu1ymd7zhCufFS8zL/pYQahjIPI6+shKknpdSEBW9wAHHFyMVe2zw4v4sCyrWSV698C+r81nG5gskyYEAxb3uQb/umZunxUvmP92o1zffhJZH66fsdEXaVOZr3CtISfg8UCFTdMV47/CEIQFm4ES7EPXxQXlDPff5gPiOsGhAtnf9qhKJHJ3ir1BAlO/zllvBD9l8UvK2TAMrvT/vEHn8Y63XT1DL8u44Q9cGOULjt6C81zUQRk/N+TA7KlmFwjABrLgBt1aspEjPXf36WISyZ+BODYOTdXVHuHD0WZKY3ehp+hI7jJY8RA8de1W0SoSFexYMukzEZrATn0jiSkMjdEoGU6VD1D19kAgDEGw8vINei2/XM1DMgezBL1oSNJdIJNtLrBmzSZ1fFUBAbanNeXppMRJKzheu2lWz/T21b13w0jvjm2lB3xNJGxtWc6fOScfLAmsWBr+NxDoEIp44iBsbjb5IqCHdIbN85JWsNZ/T7ing7VozFfi+ci7E/RnA
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
because it introduced a significant power regression on systems that
start with "nosmt" in the kernel command line.

Namely, on such systems, SMT siblings permanently go offline early,
when cpuidle has not been initialized yet, so after the above commit,
hlt_play_dead() is called for them.  Later on, when the processor
attempts to enter a deep package C-state, including PC10 which is
requisite for reaching minimum power in suspend-to-idle, it is not
able to do that because of the SMT siblings staying in C1 (which
they have been put into by HLT).

As a result, the idle power (including power in suspend-to-idle)
rises quite dramatically on those systems with all of the possible
consequences, which (needless to say) may not be expected by their
users.

This issue is hard to debug and potentially dangerous, so it needs to
be addressed as soon as possible in a way that will work for 6.15.y,
hence the revert.

Of course, after this revert, the issue that commit 96040f7273e2
attempted to address will be back and it will need to be fixed again
later.

Fixes: 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: 6.15+ <stable@vger.kernel.org> # 6.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This supersedes https://lore.kernel.org/linux-pm/7811828.EvYhyI6sBW@rjwysocki.net/

v1 -> v2:
   * Send as a standalone patch.
   * Extend the changelog.

I honestly don't think that there is any reasonable alternative to this
revert that would be suitable for 6.15.y (y > 0), so I'm going to apply
it and include it in a PR during the remaining part of this merge window
unless somebody beats me to this.

Thanks!

---
 arch/x86/kernel/smpboot.c |   54 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1238,10 +1238,6 @@
 	local_irq_disable();
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1288,6 +1284,50 @@
 }
 
 /*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
+static inline void mwait_play_dead_cpuid_hint(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned int highest_cstate = 0;
+	unsigned int highest_subcstate = 0;
+	int i;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return;
+	if (!this_cpu_has(X86_FEATURE_MWAIT))
+		return;
+	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
+		return;
+
+	eax = CPUID_LEAF_MWAIT;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	/*
+	 * eax will be 0 if EDX enumeration is not valid.
+	 * Initialized below to cstate, sub_cstate value when EDX is valid.
+	 */
+	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
+		eax = 0;
+	} else {
+		edx >>= MWAIT_SUBSTATE_SIZE;
+		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
+			if (edx & MWAIT_SUBSTATE_MASK) {
+				highest_cstate = i;
+				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
+			}
+		}
+		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
+			(highest_subcstate - 1);
+	}
+
+	mwait_play_dead(eax);
+}
+
+/*
  * Kick all "offline" CPUs out of mwait on kexec(). See comment in
  * mwait_play_dead().
  */
@@ -1337,9 +1377,9 @@
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	/* Below returns only on error. */
-	cpuidle_play_dead();
-	hlt_play_dead();
+	mwait_play_dead_cpuid_hint();
+	if (cpuidle_play_dead())
+		hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */




