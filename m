Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B317E4393B9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhJYKcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJYKcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:32:41 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE88C061745;
        Mon, 25 Oct 2021 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=zaVg4jBc9F4rk3WaC2BbIGzIvbQck+4g8h3ofbOG7k0=; b=ZbPo
        LvulK7ILdjJM7xAIoJFe/wEuFTRA/Z/DLCyf3Sgu8avt1fA3+Vr/PuDRBSlUOyp4U1eLAKXpkr3lG
        +nS9h235f/vegS0mVCH6SnPgykf1731fOdCrc3O9HN8WjlxHZS3S5bTx2hiU+Xx5MQ3gk0E7/UeYz
        9R3ThRzTLLsMIMYFOOOsioPE+TuH05PgCcqROAqLap5vOtW6KDNp7/MTxaZaoy+nckDiCP3kSgVOk
        mjdiQ00N/DttyPkVpi1AUZwAmt+3ws2xOu/R7bqCaF3Ib6Dy5F4rb+xSZZkhMv94phQF6/dRk1R3c
        M9+f3SpQolzKaOcME5T94uZBSeq7Hw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mexF6-0002VB-Gf; Mon, 25 Oct 2021 11:30:12 +0100
Date:   Mon, 25 Oct 2021 11:30:07 +0100
From:   John Keeping <john@metanate.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH RT] PM: runtime: avoid retry loops on RT
Message-ID: <20211025113007.6d09bfed.john@metanate.com>
In-Reply-To: <CAJZ5v0hD61=MsVWmoGNJ50a6raGrsME_=7ha=E-Y3AgmuvQsjw@mail.gmail.com>
References: <20211005155427.1591196-1-john@metanate.com>
 <CAJZ5v0gPwUQzGBa2VDeC3xAF9zJVm486BC0eue10-urJ8Xz+iw@mail.gmail.com>
 <20211005181706.66102578.john@metanate.com>
 <CAJZ5v0iFKYvM+rn68VaAbM4=ZLAQBR_UPzvAuKqVLQuP=ZJPew@mail.gmail.com>
 <20211006191813.0e097b9f.john@metanate.com>
 <CAJZ5v0hD61=MsVWmoGNJ50a6raGrsME_=7ha=E-Y3AgmuvQsjw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Oct 2021 12:37:05 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> The initial motivation for adding irq_safe was to allow interrupt
> handlers of some devices to use PM-runtime, but in RT kernels that's
> possible regardless IIUC, so I don't see a reason for having irq_safe
> at all in that case.

I coded up the "no irq_safe" version but lockdep complains loudly about
it:

	BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1111
	in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 237, name: pm-runtime-prio
	preempt_count: 0, expected: 0
	RCU nest depth: 2, expected: 0
	INFO: lockdep is turned off.
	CPU: 3 PID: 237 Comm: pm-runtime-prio Tainted: G        W         5.15.0-rc6-rt13 #1
	Hardware name: Rockchip (Device Tree)
	[<c010f9d0>] (unwind_backtrace) from [<c010afc8>] (show_stack+0x10/0x14)
	[<c010afc8>] (show_stack) from [<c090ec30>] (dump_stack_lvl+0x58/0x70)
	[<c090ec30>] (dump_stack_lvl) from [<c014bee0>] (__might_resched+0x1dc/0x270)
	[<c014bee0>] (__might_resched) from [<c059a1a0>] (__pm_runtime_resume+0x2c/0x6c)
	[<c059a1a0>] (__pm_runtime_resume) from [<c04b8a44>] (pl330_issue_pending+0x60/0x84)
	[<c04b8a44>] (pl330_issue_pending) from [<c07306b8>] (snd_dmaengine_pcm_trigger+0xec/0x14c)
	[<c07306b8>] (snd_dmaengine_pcm_trigger) from [<c0767528>] (soc_component_trigger+0x20/0x38)
	[<c0767528>] (soc_component_trigger) from [<c0768440>] (snd_soc_pcm_component_trigger+0xd8/0xf4)
	[<c0768440>] (snd_soc_pcm_component_trigger) from [<c0768e34>] (soc_pcm_trigger+0x48/0x154)
	[<c0768e34>] (soc_pcm_trigger) from [<c0725f74>] (snd_pcm_action_single+0x38/0x64)
	[<c0725f74>] (snd_pcm_action_single) from [<c0727f28>] (snd_pcm_action+0x5c/0x60)
	[<c0727f28>] (snd_pcm_action) from [<c0727f68>] (snd_pcm_action_lock_irq+0x28/0x3c)
	[<c0727f68>] (snd_pcm_action_lock_irq) from [<c027f474>] (vfs_ioctl+0x20/0x38)
	[<c027f474>] (vfs_ioctl) from [<c027fe54>] (sys_ioctl+0xc0/0x96c)
	[<c027fe54>] (sys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x1c)

Now that I have a reliable reproducer, it turns out the original patch
in this thread also has problems and causes a WARN from RCU.  The
version I have now that seems to work and doesn't cause any dmesg
complaints is below, but I'm really not sure if this is considered an
acceptable use of schedule_rtlock() (I suspect this also fails to
compile without CONFIG_PREEMPT_RT since schedule_rtlock() isn't declared
in that case).


-- >8 --
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ec94049442b9..79cf9997f71b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -596,7 +596,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
                        goto out;
                }
 
-               if (dev->power.irq_safe) {
+               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
                        spin_unlock(&dev->power.lock);
 
                        cpu_relax();
@@ -614,7 +614,10 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
                        spin_unlock_irq(&dev->power.lock);
 
-                       schedule();
+                       if (dev->power.irq_safe)
+                               schedule_rtlock();
+                       else
+                               schedule();
 
                        spin_lock_irq(&dev->power.lock);
                }
@@ -777,7 +780,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
                        goto out;
                }
 
-               if (dev->power.irq_safe) {
+               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
                        spin_unlock(&dev->power.lock);
 
                        cpu_relax();
@@ -796,7 +799,10 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
                        spin_unlock_irq(&dev->power.lock);
 
-                       schedule();
+                       if (dev->power.irq_safe)
+                               schedule_rtlock();
+                       else
+                               schedule();
 
                        spin_lock_irq(&dev->power.lock);
                }
