Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92B76C2007
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjCTSgz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjCTSgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 14:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911823A873
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 11:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A805C6178E
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 18:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D726EC433D2;
        Mon, 20 Mar 2023 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679336896;
        bh=2m91rv7bbdCnW8c5Yc2YT5Mp1IPO4+Nixo9+v4IGUdo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=WrqitW1lJblXEd0MR8cULBUDNPiFYWQmDxagCJ3cha0YwwBpX6J5IhkbsRYlnbx5A
         dPEBIkP0skzoCGCjgjJ/xahEeKPinMpvDBOIIhK0He/azhIGbwIs19D6HOp1UbHhUw
         8IC66SW6RSxR9q/2xuU7Cwpvyrzg7DocqFq4y2+kxRzBCBAmD4Jpebne9O63/PF8y5
         ViQ5jT95ckH3a0Uayra+4X8QFnmOguK+QVnrVKz2Ne5xva749QqHMhlcUt2GC8TXOt
         biKEkda7hzzcMWSQOBqq0AGfo+Czy8BMWPIbklyTSYIExDyuK0lqugnGGu7IbMuVUY
         vvhd7Cva+vw0A==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C0D1F27C005C;
        Mon, 20 Mar 2023 14:28:14 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 20 Mar 2023 14:28:14 -0400
X-ME-Sender: <xms:vqUYZOz8Dhk1aO3MHeBnIxysI9tIVpRGsWCCJKgvhCEJSAcxaXDugg>
    <xme:vqUYZKTUIzzpNvA0bMrSz63_S-PJfG_RHWONwzsNfrn_UTR8ts-J6rDzt6wlfe0Er
    AnhB7Xv2LCWqONe-fs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:vqUYZAU63QI98WsOTcJSDUsyGAyWynfY6yrBu8Epecq2vbRbdPAIsQ>
    <xmx:vqUYZEie0RH3RTto53KSrsEcNwBH69r2I4-HckPz2D1CtxLD8yge3Q>
    <xmx:vqUYZADZGIHgPQ9fpcM7N_EFq-vXxG6r9HD6_irmowV9idrus6piUg>
    <xmx:vqUYZDMGxizXlp8pSQA0HJ_j4v7zm5_nmxI7DLd1Maq0NHHbiNmi0w>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 71FF531A0063; Mon, 20 Mar 2023 14:28:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
In-Reply-To: <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
References: <20230310122110.895093-1-dedekind1@gmail.com>
 <20230310122110.895093-4-dedekind1@gmail.com>
 <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
Date:   Mon, 20 Mar 2023 11:27:54 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Artem Bityutskiy" <dedekind1@gmail.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux PM Mailing List" <linux-pm@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>
Subject: Re: [PATCH v2 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 20, 2023, at 7:50 AM, Peter Zijlstra wrote:
> On Fri, Mar 10, 2023 at 02:21:10PM +0200, Artem Bityutskiy wrote:
>> +/**
>> + * umwait_limit_init - initialize time limit value for 'umwait'.
>> + *
>> + * C0.1 and C0.2 (later C0.x) idle states are requested via the 'umwait'
>> + * instruction. The 'umwait' instruction requires the "deadline" - the TSC
>> + * counter value to break out of C0.x (unless it broke out because of an
>> + * interrupt or some other event).
>> + *
>> + * The deadline is specified as an absolute TSC value, and it is calculated as
>> + * current TSC value + 'umwait_limit'. This function initializes the
>> + * 'umwait_limit' variable to count of cycles per tick. The motivation is:
>> + *   * the tick is not disabled for shallow states like C0.x so, so idle will
>> + *     not last longer than a tick anyway
>> + *   * limit idle time to give cpuidle a chance to re-evaluate its C-state
>> + *     selection decision and possibly select a deeper C-state.
>> + */
>> +static void __init umwait_limit_init(void)
>> +{
>> +	umwait_limit = (u64)TICK_NSEC * tsc_khz;
>> +	do_div(umwait_limit, MICRO);
>> +}
>
> Would it not make sense to put this limit in the MSR instead? By
> randomly increasing the MSR limit you also change userspace behaviour vs
> NOHZ_FULL.
>
> That was part of the reason why Andy insisted on having the MSR low.

This is all busted.

UMWAIT has a U for *user mode*.  We have the MSR set to a small value because USER waits are a big can of worms, and long user waits don't actually behave in any particularly intelligent manner unless that core is dedicated to just one user task, and no virt is involved, and the user code involved is extremely careful.

But now UMWAIT got extended in a way to make it useful for the kernel, but it's controlled by the same MSR.  And this is busted.  What we want is for CPL0 UMWAIT to ignore the MSR or use a different MSR (for virt, sigh, except that this whole mechanism is presuambly still useless on virt).  Or for a different instruction to be used from the kernel, maybe spelled MWAIT.

Can we please get some hardware folks to stop randomly adding features and start thinking about the fact that real users involve a kernel, in virt and bare metal, and user code, generally running in a preemptive kernel, sometimes under virt, and to FIGURE OUT WHAT THESE FEATURES SHOULD DO IN THESE CONTEXTS!

In the mean time, I assume that this stuff is baked into a CPU coming soon to real users, and there is no correct way to program it.  But we could set a small limit and eat a small power penalty if C0.2 transitions are really that fast.

Also, this series needs to be tested on virt.  Because UMWAIT, if it works at all on virt, is going to have all manner of odd concequences due to the fact that the hypervisor hasn't the faintest clue what's going on because there's no feedback.  For all that UiPI is nasty and half-baked, at least it tries to notify the next privilege level up as to what's going on.  Explicit wakeups virtualize much better than cacheline monitors.
