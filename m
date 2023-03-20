Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B278B6C22A7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 21:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCTUaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCTUaD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 16:30:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADB01983
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 13:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61D2AB810C0
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 20:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE76FC4339E;
        Mon, 20 Mar 2023 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679344165;
        bh=RxaRPSVR0/wk+rb67QlQwIfT8fycj517/2FGI1bAVPg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=b4g5PqDaVLiwZXw+YfpLcEVCyuU3kZyMbLY2Dny25LnJxK/YnP+evifPc6O8HoNEO
         ksh2If6rGmLTgMy0fu6L1pkdl+4n1ROAwDGpf5D61wT4dmzG2h+PKncp3tW2laaLWC
         ckWHD1lSX3fNXY81a6JFJoP5/4sDo4dILHWZVlgFaSsTbHB4gZOqdN3YypUCAHUjAv
         raVQNxUjuOn5Xxcnd4qJN/NMYI5OtmbB34aAsgJr1Vma5vkOxJEm1mAfeMjv90MMGH
         8pctMyntG7bwhIlEM2UrDUV7y6y6MVOnjSFRUvBn0TlkY82Y7/DPvnAix3U2/cvzrM
         zCfxdGHlCPAhw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id AA81E27C005B;
        Mon, 20 Mar 2023 16:29:23 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 20 Mar 2023 16:29:23 -0400
X-ME-Sender: <xms:I8IYZHwegxRfph_2BJ2T-6w7J0oTRZ9H_CIDInEVztbz-_AwuaU2ZA>
    <xme:I8IYZPR-fXO61jkV8gaJuQbv_zU1MmcWhlxexSNQKwfSf0RzG2R2gHdNMbmwPcLX5
    R7DEJAwGpgqxt6e7mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:I8IYZBWezoTMx_EItg85bBE1ctxrJZyl9Mz98F2lUY2RQp7gqwtDVg>
    <xmx:I8IYZBiZP2R1V13aS9Vy3MzH7u1NC74uAcWWRqnp8s8NYcQfyKKiDg>
    <xmx:I8IYZJCDAwHWqe8IS6FctwCuMTxizJLF_UHW8zLk6IaEYE0Fi4lqng>
    <xmx:I8IYZMNyxYA9dbiqKrj_emjzZafLNn7OOq15ZE9k_Z-3KgnzJWTe4A>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4956531A0063; Mon, 20 Mar 2023 16:29:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <1d878603-09bc-4161-8043-a1d7101c3bbd@app.fastmail.com>
In-Reply-To: <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
References: <20230310122110.895093-1-dedekind1@gmail.com>
 <20230310122110.895093-4-dedekind1@gmail.com>
 <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
 <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
Date:   Mon, 20 Mar 2023 13:29:02 -0700
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



On Mon, Mar 20, 2023, at 11:27 AM, Andy Lutomirski wrote:
> On Mon, Mar 20, 2023, at 7:50 AM, Peter Zijlstra wrote:
>> On Fri, Mar 10, 2023 at 02:21:10PM +0200, Artem Bityutskiy wrote:
>>> +/**
>>> + * umwait_limit_init - initialize time limit value for 'umwait'.
>>> + *
>>> + * C0.1 and C0.2 (later C0.x) idle states are requested via the 'umwait'
>>> + * instruction. The 'umwait' instruction requires the "deadline" - the TSC
>>> + * counter value to break out of C0.x (unless it broke out because of an
>>> + * interrupt or some other event).
>>> + *
>>> + * The deadline is specified as an absolute TSC value, and it is calculated as
>>> + * current TSC value + 'umwait_limit'. This function initializes the
>>> + * 'umwait_limit' variable to count of cycles per tick. The motivation is:
>>> + *   * the tick is not disabled for shallow states like C0.x so, so idle will
>>> + *     not last longer than a tick anyway
>>> + *   * limit idle time to give cpuidle a chance to re-evaluate its C-state
>>> + *     selection decision and possibly select a deeper C-state.
>>> + */
>>> +static void __init umwait_limit_init(void)
>>> +{
>>> +	umwait_limit = (u64)TICK_NSEC * tsc_khz;
>>> +	do_div(umwait_limit, MICRO);
>>> +}
>>
>> Would it not make sense to put this limit in the MSR instead? By
>> randomly increasing the MSR limit you also change userspace behaviour vs
>> NOHZ_FULL.
>>
>> That was part of the reason why Andy insisted on having the MSR low.
>
> This is all busted.
>
> UMWAIT has a U for *user mode*.  We have the MSR set to a small value 
> because USER waits are a big can of worms, and long user waits don't 
> actually behave in any particularly intelligent manner unless that core 
> is dedicated to just one user task, and no virt is involved, and the 
> user code involved is extremely careful.
>
> But now UMWAIT got extended in a way to make it useful for the kernel, 
> but it's controlled by the same MSR.  And this is busted.  What we want 
> is for CPL0 UMWAIT to ignore the MSR or use a different MSR (for virt, 
> sigh, except that this whole mechanism is presuambly still useless on 
> virt).  Or for a different instruction to be used from the kernel, 
> maybe spelled MWAIT.
>
> Can we please get some hardware folks to stop randomly adding features 
> and start thinking about the fact that real users involve a kernel, in 
> virt and bare metal, and user code, generally running in a preemptive 
> kernel, sometimes under virt, and to FIGURE OUT WHAT THESE FEATURES 
> SHOULD DO IN THESE CONTEXTS!
>
> In the mean time, I assume that this stuff is baked into a CPU coming 
> soon to real users, and there is no correct way to program it.  But we 
> could set a small limit and eat a small power penalty if C0.2 
> transitions are really that fast.
>
> Also, this series needs to be tested on virt.  Because UMWAIT, if it 
> works at all on virt, is going to have all manner of odd concequences 
> due to the fact that the hypervisor hasn't the faintest clue what's 
> going on because there's no feedback.  For all that UiPI is nasty and 
> half-baked, at least it tries to notify the next privilege level up as 
> to what's going on.  Explicit wakeups virtualize much better than 
> cacheline monitors.

At the very least, we need to know whether increasing the UMWAIT limit has a real benefit.  Because UMWAIT is really just a fancy busy wait, and it will still work with the low limit.  What happens if we just drop that part of this patch?
