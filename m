Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315A753B67E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 12:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiFBKB1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jun 2022 06:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiFBKB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2022 06:01:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5B41F86
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GQwykF64CpqQlNkVrOuH9CP3eHg2aFRZymcR77Rn/rc=; b=nGgpfdU5vTIaKrXGaBAhg/69yH
        IN16iuG5AlefvrREwRI5v50wEMRSJYYxdxLt9KqGKVM6shvGOO4jCUrhextS/08A9tW4wg9tMtiAH
        lcLZbUdrE/7+x979z8/9wlIHx/tBehnHypqZaqB3iTfvj3BIGAJnj7qo5Xty4HH3QQkdMIhjpBrrH
        OKuN/9XBun8SifKsHGhWN6jHsCUMqJgKBXTnedo4VgcMYOYdHT3WjO5FTcDazygb6jkET8RBdfkyN
        4T3EG8ep8JFjfcFDcgzdgkDo1y8l5hKofdfNW5WSeKsphkw6YjEOLyHSC524gHqc1N+TI6UGWZal2
        b25m/yPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwhdW-0044NJ-6A; Thu, 02 Jun 2022 10:01:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5EC503002CD;
        Thu,  2 Jun 2022 12:00:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E7CC20C30721; Thu,  2 Jun 2022 12:00:58 +0200 (CEST)
Date:   Thu, 2 Jun 2022 12:00:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [cpuidle]  f01f07f0a5:
 WARNING:at_drivers/cpuidle/cpuidle.c:#cpuidle_enter_state
Message-ID: <YpiKWcbyoNnvUU6W@hirez.programming.kicks-ass.net>
References: <20220602092019.GE27190@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602092019.GE27190@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 02, 2022 at 05:20:19PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: f01f07f0a50134a775f8e60fdaa559d2f5d63663 ("cpuidle: Move IRQ state validation")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/idle
> 
> in testcase: netperf
> version: netperf-x86_64-2.7-0_20220601
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 1
> 	cluster: cs-localhost
> 	send_size: 10K
> 	test: SCTP_STREAM_MANY
> 	cpufreq_governor: performance
> 	ucode: 0xd000331
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
> 
> 
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory

I know this is a bit of an ask, but would it at all be possible to
translate that into a code name; specifically, that "Platinum 8358"
thing is "Ice Lake".

Our dear marketing department has made it absolutely impossible (without
just plain googling it) to know what is what :/

> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Please, start the quote at the "------------[ cut here ]------------"
marker, that's what it's for. Then you don't miss the actual warning:

[    4.147181][    T0] ------------[ cut here ]------------
[    4.147182][    T0] intel_idle leaked IRQ state
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^ is the useful bit that went missing.

> [ 4.147200][ T0] WARNING: CPU: 1 PID: 0 at drivers/cpuidle/cpuidle.c:239 cpuidle_enter_state (drivers/cpuidle/cpuidle.c:239 (discriminator 3)) 
> [    4.147205][    T0] Modules linked in:
> [    4.147207][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.18.0-11271-gf01f07f0a501 #1

That's commit c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
breaking things. Fix below I suppose.

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -129,21 +129,36 @@ static unsigned int mwait_substates __in
  *
  * Must be called under local_irq_disable().
  */
-static __cpuidle int intel_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int index)
+static __always_inline int __intel_idle(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
 
-	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
-		local_irq_enable();
-
 	mwait_idle_with_hints(eax, ecx);
 
 	return index;
 }
 
+static __cpuidle int intel_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	return __intel_idle(dev, drv, index);
+}
+
+static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv, int index)
+{
+	int ret;
+
+	raw_local_irq_enable();
+	ret = __intel_idle(dev, drv, index);
+	raw_local_irq_disable();
+
+	return ret;
+}
+
 /**
  * intel_idle_s2idle - Ask the processor to enter the given idle state.
  * @dev: cpuidle device of the target CPU.
@@ -1801,6 +1816,9 @@ static void __init intel_idle_init_cstat
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
+		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
+			drv->states[drv->state_count].enter = intel_idle_irq;
+
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
 		     intel_idle_off_by_default(mwait_hint) &&
