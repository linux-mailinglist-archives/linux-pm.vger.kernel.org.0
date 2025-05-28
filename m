Return-Path: <linux-pm+bounces-27740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15EAC6B20
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 15:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592FF9E08D9
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67344288527;
	Wed, 28 May 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qYmj06y/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D220B81D;
	Wed, 28 May 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440791; cv=none; b=RvCx9Sxn0FuxKe4sHf3BbFJEbT/gOOTL+OAVuPO9+t7MFvUdh7SovhX3Z258KrgDEdcVrExf41OXf0LPFVmGJxMSNKpiT8+frtODffUVChUhC8fmnTrxxiBuQkdedTAQL/X1nsWMf2F4vH/2Hyq3pFte2ukZg8PuM6nRFRU7HP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440791; c=relaxed/simple;
	bh=GidpZsTdS1mvFVZhMXx5AjlxUimuu/0oP04bsW6NDt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhJNEsdq6cpUXXqLdqx/J/+WTaMh6l/k3dWRyB6O7dk/CCAKY0hx0THVKFaYBOoEihRtlN+ajYAtG+M3HSR3036ISOQU1DcMRVL4xGPYfxoBTwUfuHA5kVyW8XTjZHNfsxNvz7zeTXKUI+BQzKzAdG4uds6oYFd4RHUk2jOSjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qYmj06y/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9073266808C;
	Wed, 28 May 2025 14:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748436903;
	bh=GidpZsTdS1mvFVZhMXx5AjlxUimuu/0oP04bsW6NDt0=;
	h=From:Subject:Date;
	b=qYmj06y/nV3RBN8Fv+zAmh9NV3LKKLHOdDrbzBcaDhQk9MDi3ifDcpMHQf2gsJgek
	 va06FTPQm6czxhfAXhJ6WxME+BD34MwmG8DevcNaiMgfRZa/ezDUWxFCwGJTI/HOnj
	 kf0+6YiXxdlZvGeiiH7CrwKyE/O0xkEIlP1SOEf4MBI2gZjRWPmVxrbyyW9C+c9+bj
	 aIFguT8ukNOiietqjHyMz026EP+tod/MoqpJ5uk3eC+5LRELvPlu0hkd7xa2HWTRi2
	 ezbpKTmMfUk13XcC1fy4rc8f6m220KAG2RRJVZKdwDsWgyuTRg/BoxkcyaWLYkEizQ
	 ntoe97QkZcv0w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Todd Brandt <todd.e.brandt@linux.intel.com>
Subject:
 [PATCH v1 1/2] Revert "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"
Date: Wed, 28 May 2025 14:53:50 +0200
Message-ID: <7811828.EvYhyI6sBW@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFxkQHn3iCFbbSyiDpq8O8fxHSz0xYZKn6328KRsDmyVOaUGJ5g9Pr88Mn+X1Ui8c/1Qb79P6Egeac0Wd4sy6JCX3KJ8P1U64eCx1OWa9IyZBsPPK141xkOOqyv/1Zw1QatQDlGB1yvkLOMXmCIAxkp70zSNBD+o+hqAg2qBFKsovAAPZZDWVM7txTozblkZF1eJ0XJ7pt6v7XqlFsO0rolzhHpavgnhWYGpyOXvsRTfKUvYlv9wsRDHePo6aQnJXczz+S8EYGfHpo5I4rhmR4dky+Ke+Gndp63BdmPoFR5Kj/OTkj1EaUzRCA+oOB4QoAjMMFv2OYrjxrYTUWJw73TCS0jrhzgA/flO6Xqujmn+vAEAQ+axfmVYpRJVSlP9ZXYBnFqcAdW8TsUL9ksWIhX3xI5Qyei3oWArXep7LaNMMAaiGAQsNPcOjP87pwjeZVreH9GvRVVadL1FlFGq6QbPh5OoIYwyxTOoqMUFY+GsM/USIXxn+9CsKxYs/gVczqEqmhP5FyHJMkFfdcLM1VL7rK394QhEbKO9gw5wZKwrU6KIoegU5gO0xWuDd2WrRAi0gyib3a+NPnePFw1e+mu9WLf+3uErb/F8slWWzvCdxw6R+SvdixosfwcrVPBnpeBo8pWaRJxOF5qNnjUerbLR+2lv7rHfBROzcD4hA0MtA
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
because it introduced a significant power regression on systems that start
with "nosmt" in the kernel command line.

Namely, on such systems, SMT siblings permanently go offline early,
when cpuidle has not been initialized yet, so after the above commit,
hlt_play_dead() is called for them.  Later on, when the processor
attempts to enter a deep package C-state, including PC10 which is
requisite for reaching minimum power in suspend-to-idle, it is not
able to do that because of the SMT siblings staying in C1 (which
they have been put into by HLT).

Fixes: 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: 6.15+ <stable@vger.kernel.org> # 6.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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




