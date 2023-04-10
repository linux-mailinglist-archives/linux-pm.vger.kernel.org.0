Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BD6DC9F6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDJRYm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDJRYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 13:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D822116
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 10:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E50A6138B
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 17:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638E5C433D2;
        Mon, 10 Apr 2023 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681147477;
        bh=6bA4p38iGvDKyXZHM6yEsLgcnnk8f85/v6nKgR1L39c=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=pVWosYZ4aDIwWXVGNZ6GnVGNaeSV3mqlU76dHtfpu9Fjrf+Jv81fECa8kY7mBtDZW
         ozl9OR5cXJyy19s34CdCiI1yvQFJO810pVu7FSlzekUXNQi7mzPeWFhk/iEAhsnE9D
         LVRFG+brYZFePB/txZ8jCoL4tatYeclpg+AlnR9itamyGaZT1M4ANEEdDs4f0Pjk3M
         QviQSGhCB2tLxcBT8hSYLedrONghfh8pXeltMKlk9+hT/EyDIXNDTePGQjd68a9NV5
         saxblCAEsmYaZpT6UOSgc0zbgLpPCKt0jf2mw86cO/dY436LzoX6VNHmS04zP77wTa
         EeXPSXKEOg+rw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4773327C0054;
        Mon, 10 Apr 2023 13:24:36 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 10 Apr 2023 13:24:36 -0400
X-ME-Sender: <xms:U0Y0ZG_3xqKfFt7N4pN7TCzj-tqsZCLsD65OZ5saPOTKieWICi8sCQ>
    <xme:U0Y0ZGswT7WVyi1kdTDihOxxLdvkpy2thelU9VDV_lbc1JTEQ07Gc8GYfnQeq5Cdd
    cRb-BtGLj5Bh4I3Txc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekvddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeevfffgvefhieetudeuteegvedvveduveetfeevffduieevfedu
    tdeliedtledugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:U0Y0ZMAXPLxDF4XxN4dTj0PJFk434CkVZyGoraiNHi5DoOQEGfrIwg>
    <xmx:U0Y0ZOcI0MzbMKXY6RfZIBThCbhb_j1_gBm7EBz_Y8xqh0PWD46Zhw>
    <xmx:U0Y0ZLMYy9-okU7KNj56wtfcQ_zpXnsUVtGMWIs2MVRMFYLatdVT8g>
    <xmx:VEY0ZEZpL3mXEeQNII7uRfQJiuWcg_Azob2SY0z55Zshq8Q74sfoew>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C13B331A0065; Mon, 10 Apr 2023 13:24:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <9642d2c0-777c-4425-b6f8-60b6284b8ae6@app.fastmail.com>
In-Reply-To: <f68572c70fe023692954b35c14a69355bea42189.camel@gmail.com>
References: <20230310122110.895093-1-dedekind1@gmail.com>
 <20230310122110.895093-4-dedekind1@gmail.com>
 <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
 <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
 <f68572c70fe023692954b35c14a69355bea42189.camel@gmail.com>
Date:   Mon, 10 Apr 2023 10:24:15 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Artem Bityutskiy" <dedekind1@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux PM Mailing List" <linux-pm@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>
Subject: Re: [PATCH v2 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Wed, Mar 29, 2023, at 12:32 AM, Artem Bityutskiy wrote:
> There is a lot of feedback. Let me summarize a bit.
>
> 1. C0.x time limit is controlled by MSR 0xE1 - IA32_UMWAIT_CONTROL[31:2]. This
> limit applies to both CPL0 and CPL3. Your feedback is that this MSR should be
> ignored in CPL0, or there should be a different MSR for CPL3.
>
> Interesting point. I am discussing this with HW folks internally now and trying
> to figure it out.
>
>
> 2. Peter Zijlstra said earlier: why C0.x states are not available via 'mwait'.
>
> Also good point. Similarly, I am now discussing this with HW engineers and
> trying to figure it out.
>
>
> 3. What happens if you do not increase the global limit in
> IA32_UMWAIT_CONTROL[31:2]? May be just drop that patch.
>
> I am taking this approach now. Measuring and benchmarking the system now.
>
>
> 4. Test this in virtual environment.
>
> Will do.
>
>
> 5. Then there were several references to virualization, and this is the part of
> your feedback I did not understand. I admit I do not know much about
> virtualization.
>
> Below are few questions. I apologize in advance because if they are naive,
> please, bear with me.
>
>
> Question #1.
>
> Userspace applications can do many strange things. For example, just busy-loop
> on a variable waiting for it to change.
>
> Not social behavior. May be good idea for special apps, having dedicated CPU, as
> you pointed. E.g., DPDK or other latency-sensitive apps. Bad idea for a general
> app.
>
> However, we can't control apps, in general. If they want to busy-loop they will.
> If someone buys a VM, they may decide that they payed for it and do whatever
> they want.
>
> Now take this sort of anti-social app. Replace the busy-loop with umwait or
> tpause. You get the same result, but it saves energy. So it is an optimization,
> good thing.
>
> What am I missing?

You're not missing anything extremely critical, but there are some less critical issues.

Dredging up an old email:

https://lore.kernel.org/all/CALCETrVJsCAWYSnUE+Ju_VmZfZBUBwUq-uFjV9=Vy+wddtJVCw@mail.gmail.com/

First, UMWAIT doesn't have a wakeup mechanism that can notify a supervisor (or hypervisor) of wakeups.  So if a task is UMWAITing and gets interrupted, the scheduler cannot tell when it should schedule it back in.  UIPI can do this (poorly), but UMWAIT doesn't even try.

So, with that caveat, UMWAIT is, as you are noting, a busy-loop that happens to be somewhat more power efficient than a plain loop or a bunch of REP NOPs.  And this is just fine for the top of the stack of supervisor things -- a kernel on bare metal, a hypervisor that is not itself nested, etc.  It's *also* fine for a well-designed assisted polling loop, paravirt style -- if a thread knows that the thread (vCPU, etc) that will wake it is running, then polling briefly may be a very good idea.  But it should be brief, and it should coordinate with a real wait/wake mechanism.

On top of all this, UMWAIT has the somewhat unfortunate effect that it sets CF according to whether the MSR deadline elapsed.  So if I do:

UMONITOR
UMWAIT (deadline  = far future)

and the MSR is set to a large value, I can do this many, many times (possibly infinite) without ever seeing CF=1.  But if the MSR is set to a low value, I'll get CF=1 fairly often.

So setting the MSR to a low value prevents anyone from deluding themselves that UMWAIT is anything other than a busy-wait that can be interrupted based on a TSC timeout or an interrupt or whatever on a very regular basis.

--Andy
