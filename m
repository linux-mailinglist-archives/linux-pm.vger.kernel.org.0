Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFF44320ED
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhJRO7b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhJRO7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 10:59:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314CC061765;
        Mon, 18 Oct 2021 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=q3tqu0X1DeuLrXkMZoYuQE+PQsnVWsjiw6yYOnZvWyI=; b=uCTtcUSga9l1BkLhecMIHfcMBO
        roGCM5IXQkWo1b4YrY6KlUrc4Y0gEXtijl4lhqK72+0VZZwnPq8WadnSo9jC/fxTmZHthYm2NvG1D
        2J4W8lMdvR5JVSftB3tv8gM/DK9a6vE0BNcy6TjSx6TuXQ0V1bYr7sOGdM9bh51Ee8H3knfBV8hQc
        MhMpEQPZNkO150SiyR4G2lH632lMT3t+3Uz8MMnQEFN7dYYwRrV6Tk5FIs+r1p3OE9vt4DrcIgjgA
        54TZMoxAlOiLtFz48JiyaB8L4tgiBNw13fljKCg56KiCFIgbnmTIE9gLJdYVVBin13OczvVsJoXMY
        aJ2hMkXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcTzn-00B2Hj-C8; Mon, 18 Oct 2021 14:52:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36260300242;
        Mon, 18 Oct 2021 16:52:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 224C92C21989B; Mon, 18 Oct 2021 16:52:10 +0200 (CEST)
Date:   Mon, 18 Oct 2021 16:52:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        sfr@canb.auug.org.au, gor@linux.ibm.com
Subject: Re: next-20211015: suspend to ram on x86-32 broken
Message-ID: <YW2KGrvvv/vSA+97@hirez.programming.kicks-ass.net>
References: <20211017093905.GA3069@amd>
 <20211017102547.GA3818@amd>
 <20211018071349.GA16631@duo.ucw.cz>
 <20211018081300.GA18193@duo.ucw.cz>
 <YW07O8ZPLVnbGLR7@hirez.programming.kicks-ass.net>
 <20211018114429.GA13693@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211018114429.GA13693@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 18, 2021 at 01:44:29PM +0200, Pavel Machek wrote:

> Reverting smp.c hunk is enough to get suspend/resume to work.

Thanks! Queued the below.

---
Subject: sched: Partial revert: "sched: Simplify wake_up_*idle*()"
=46rom: Peter Zijlstra <peterz@infradead.org>
Date: Mon Oct 18 16:41:05 CEST 2021

As reported by syzbot and experienced by Pavel, using cpus_read_lock()
in wake_up_all_idle_cpus() generates lock inversion (against mmap_sem
and possibly others).

Therefore, undo this change and put in a comment :/

Fixes: 8850cb663b5c ("sched: Simplify wake_up_*idle*()")
Reported-by: syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/smp.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1170,14 +1170,23 @@ void wake_up_all_idle_cpus(void)
 {
 	int cpu;
=20
-	cpus_read_lock();
+	/*
+	 * This really should be cpus_read_lock(), because disabling preemption
+	 * over iterating all CPUs is really bad when you have large numbers of
+	 * CPUs, giving rise to large latencies.
+	 *
+	 * Sadly this cannot be, since (ironically) this function is used from
+	 * the cpu_latency_qos stuff which in turn is used under all sorts of
+	 * locks yielding a hotplug lock inversion :/
+	 */
+	preempt_disable();
 	for_each_online_cpu(cpu) {
-		if (cpu =3D=3D raw_smp_processor_id())
+		if (cpu =3D=3D smp_processor_id())
 			continue;
=20
 		wake_up_if_idle(cpu);
 	}
-	cpus_read_unlock();
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
=20
