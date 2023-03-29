Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FDB6CD359
	for <lists+linux-pm@lfdr.de>; Wed, 29 Mar 2023 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjC2HgL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 29 Mar 2023 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjC2Hfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2023 03:35:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B85272
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 00:33:24 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403426348"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403426348"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714532714"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="714532714"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 00:32:33 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id C30C4580BA2;
        Wed, 29 Mar 2023 00:32:31 -0700 (PDT)
Message-ID: <f68572c70fe023692954b35c14a69355bea42189.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] intel_idle: add C0.2 state for Sapphire Rapids
 Xeon
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>
Date:   Wed, 29 Mar 2023 10:32:30 +0300
In-Reply-To: <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
References: <20230310122110.895093-1-dedekind1@gmail.com>
         <20230310122110.895093-4-dedekind1@gmail.com>
         <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
         <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a lot of feedback. Let me summarize a bit.

1. C0.x time limit is controlled by MSR 0xE1 - IA32_UMWAIT_CONTROL[31:2]. This
limit applies to both CPL0 and CPL3. Your feedback is that this MSR should be
ignored in CPL0, or there should be a different MSR for CPL3.

Interesting point. I am discussing this with HW folks internally now and trying
to figure it out.


2. Peter Zijlstra said earlier: why C0.x states are not available via 'mwait'.

Also good point. Similarly, I am now discussing this with HW engineers and
trying to figure it out.


3. What happens if you do not increase the global limit in
IA32_UMWAIT_CONTROL[31:2]? May be just drop that patch.

I am taking this approach now. Measuring and benchmarking the system now.


4. Test this in virtual environment.

Will do.


5. Then there were several references to virualization, and this is the part of
your feedback I did not understand. I admit I do not know much about
virtualization.

Below are few questions. I apologize in advance because if they are naive,
please, bear with me.


Question #1.

Userspace applications can do many strange things. For example, just busy-loop
on a variable waiting for it to change.

Not social behavior. May be good idea for special apps, having dedicated CPU, as
you pointed. E.g., DPDK or other latency-sensitive apps. Bad idea for a general
app.

However, we can't control apps, in general. If they want to busy-loop they will.
If someone buys a VM, they may decide that they payed for it and do whatever
they want.

Now take this sort of anti-social app. Replace the busy-loop with umwait or
tpause. You get the same result, but it saves energy. So it is an optimization,
good thing.

What am I missing?

May be you implied that umwait should be designed in a way that hypervisor could
take over the core when the app or guest kernel uses it. Then the hyperwisor
could do something else meanwhile.

But think it would increase C0.x latency observed by umwait users. That would
make umwait not useful for those few apps that do have a good reason for using
umwait (like DPDK).


Question #2.

Why can't we just set this global A32_UMWAIT_CONTROL[31:2] limit to 0, which
means "forever", "no limit"?

Any user of tpause or umwait must have a loop checking for the "end of wait"
condition. Inside this loop, there is a umwait or tpause (as optimization for
busy-looping).

Both tpause and umwait break out on interrupts. Scheduler will preempt the user
task when its time-slice is over or there is something more important to run.
Then when the task starts again, it will continue waiting in its loop, doing
tpause of umwait inside the loop.

What is the problem I am missing?

Question #3:

You wrote :

> Also, this series needs to be tested on virt.  Because UMWAIT, if it works at
> all on virt, is going to have all manner of odd concequences due to the fact
> that the hypervisor hasn't the faintest clue what's going on because there's
> no feedback.

What feed-back would hypervisor need? And what would it do with it?

Is your expectation that huperviser will do something else on the CPU, like run
another VM, while original VM is umwait'ing? If so, the umwait latency will be
way longer than sub-1us...

Thanks in advance!


