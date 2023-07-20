Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D475B6E7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jul 2023 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjGTSfn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 20 Jul 2023 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGTSfj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2023 14:35:39 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD72D67
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 11:35:23 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5216cf475e9so320367a12.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 11:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689878121; x=1690482921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIK4YLjTZYz7QiSVIEy9ZulB9actAROVdP7ZEiiwIwU=;
        b=d/ckcl4MZ2s3PKVSAsuJMPj2OjEwWenRd4Bllf0XWd5UO7EL5udpRO0NDlCMTxp/A5
         yd8I22s4rJsfw71SWKtHCVBFPg3uxZ5D3fFgwrkRRdMFldtUdBB0EoHiC9aa1fdR/FW6
         PUu0+GOSSvhDiSN65W9rJCFY4r/Akh6ucWvN1NDlbzZf74J/5QPPmi7wFKxa6aPRYyDL
         5J3ysL6FZGNHzdz5hewwTszu4XmE+KqQW+7GQqQLJ9OcyM3Gmnmws/o/P20YOn0JGWhK
         OGsvQC96iC2pECbn4BeTLgombd35LvSWd+aa/3N5+VmPzSpjtv91lIK6GyIXgKrkSkfF
         +9AA==
X-Gm-Message-State: ABy/qLaqTkRyb6uaaU0Trc1k7CFWmrye2pU/cv9u3t3ETWlbX0RjqNQI
        AhMltmbXJvoXz4PIVcrkte5HrvwB4MeWcYxPPtc=
X-Google-Smtp-Source: APBJJlGOdv+7DvR3FfE2+Pk3UUV4vbLGlH7J+sq2PMmfe1McbHDFmoeSsAVs1JUJKz3WXsRnLr+4L/HbJClIzmc4eyg=
X-Received: by 2002:a17:906:10da:b0:994:539d:f98b with SMTP id
 v26-20020a17090610da00b00994539df98bmr2955475ejv.6.1689878121440; Thu, 20 Jul
 2023 11:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230710093100.918337-1-dedekind1@gmail.com>
In-Reply-To: <20230710093100.918337-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 20:35:10 +0200
Message-ID: <CAJZ5v0iLWvAwuma4P3hf_3i10qB9NNtZh9aMWw9M3VayRURpEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
To:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 10, 2023 at 11:31 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Background
> ----------
>
> Idle states reduce power consumption when a CPU has no work to do. The most
> shallow CPU idle state is "POLL". It has lowest wake up latency, but saves
> little power. The next idle state on Intel platforms is "C1". It has has higher
> latency, but saves more power than "POLL".
>
> Sapphire Rapids Xeons add new C0.1 and C0.2 (later C0.x) idle states which
> conceptually sit between "POLL" and "C1". These provide a very attractive
> midpoint: near-POLL wake-up latency and power consumption halfway between
> "POLL" and "C1".
>
> In other words, the expectation is that most latency-sensitive users will
> prefer C0.x over POLL.
>
> Enable C0.2 idle state support on Sapphire Rapids Xeon (later - SPR) by adding
> it between POLL and C1.
>
> Base commit
> -----------
>
> Based on the "linux-next" branch of "linux-pm" git tree.
>
> base-commit: bd9bb08847da3b1eba2ea8cebf514d9287e7f4fb
>
> Changelog
> ---------
>
> * v4:
>   - Address issues pointed out by Thomas Gleixner.
>     . mwait.h: use 'IS_ENABLED()' instead of '#ifdef'.
>     . mwait.h: use '__always_inline'.
>     . mwait.h: use inline stub instead for macro for "!CONFIG_X86_64" case.
>     . mwait.h: use proper commentaries for '#endif' and '#else'.
>     . mwait.h: tested with llvm/clang.
>     . Use imperative form (removed "this patch").
>   - intel_idle: rename 'intel_idle_hlt_irq_on()' for consistency.

I'm wondering if the v4 looks better than the previous versions to the
x86 folks (and Thomas in particular).

Note that patch [3/4] will not be needed any more as it refines a
commit that is going to be reverted.

> * v3
>   - Dropped patch 'x86/umwait: Increase tpause and umwait quanta' after, as
>     suggested by Andy Lutomirski.
>   - Followed Peter Zijlstra's suggestion and removed explicit 'umwait'
>     deadline. Rely on the global implicit deadline instead.
>   - Rebased on top of Arjan's patches.
>   - C0.2 was tested in a VM by Arjan van de Ven.
>   - Re-measured on 2S and 4S Sapphire Rapids Xeon.
> * v2
>   - Do not mix 'raw_local_irq_enable()' and 'local_irq_disable()'. I failed to
>     directly verify it, but I believe it'll address the '.noinstr.text' warning.
>   - Minor kerneldoc commentary fix.
>
> C0.2 vs POLL latency and power
> ------------------------------
>
> I compared POLL to C0.2 using 'wult' tool (https://github.com/intel/wult),
> which measures idle states latency.
>
> * In "POLL" experiments, all C-states except for POLL were disabled.
> * In "C0.2" experiments, all C-states except for POLL and C0.2 were disabled.
>
> Here are the measurement results. The numbers are percent change from POLL to
> C0.2.
>
> -----------|-----------|----------|-----------
>  Median IR | 99th % IR | AC Power | RAPL power
> -----------|-----------|----------|-----------
>  24%       | 12%       | -13%     | -18%
> -----------------------|----------|-----------
>
> * IR stands for interrupt latency. The table provides the median and 99th
>   percentile. Wult measures it as the delay between the moment a timer
>   interrupt fires to the moment the CPU reaches the interrupt handler.
> * AC Power is the wall socket AC power.
> * RAPL power is the CPU package power, measured using the 'turbostat' tool.
>
> Hackbench measurements
> ----------------------
>
> I ran the 'hackbench' benchmark using the following commands:
>
> # 4 groups, 200 threads
> hackbench -s 128 -l 100000000 -g4 -f 25 -P
> # 8 groups, 400 threads.
> hackbench -s 128 -l 100000000 -g8 -f 25 -P
>
> My SPR system has 224 CPUs, so the first command did not use all CPUs, the
> second command used all of them. However, in both cases CPU power reached TDP.
>
> I ran hackbench 5 times for every configuration and compared hackbench "score"
> averages.
>
> In case of 4 groups, C0.2 improved the score by about 4%, and in case of 8
> groups by about 0.6%.
>
> Q&A
> ---
>
> 1. Can C0.2 be disabled?
>
> C0.2 can be disabled via sysfs and with the following kernel boot option:
>
>   intel_idle.states_off=2
>
> 2. Why C0.2, not C0.1?
>
> I measured both C0.1 and C0.2, but did not notice a clear C0.1 advantage in
> terms of latency, but did notice that C0.2 saves more power.
>
> But if users want to try using C0.1 instead of C0.2, they can do this:
>
> echo 0 > /sys/devices/system/cpu/umwait_control/enable_c02
>
> This will make sure that C0.2 requests from 'intel_idle' are automatically
> converted to C0.1 requests.
>
> 3. How did you verify that system enters C0.2?
>
> I used 'perf' to read the corresponding PMU counters:
>
> perf stat -e CPU_CLK_UNHALTED.C01,CPU_CLK_UNHALTED.C02,cycles -a sleep 1
>
> 4. Ho to change the global explicit 'umwait' deadline?
>
> Via '/sys/devices/system/cpu/umwait_control/max_time'
>
> Artem Bityutskiy (4):
>   x86/umwait: use 'IS_ENABLED()'
>   x86/mwait: Add support for idle via umwait
>   intel_idle: rename 'intel_idle_hlt_irq_on()'
>   intel_idle: add C0.2 state for Sapphire Rapids Xeon
>
>  arch/x86/include/asm/mwait.h | 85 ++++++++++++++++++++++++++++++++----
>  drivers/idle/intel_idle.c    | 52 +++++++++++++++++++---
>  2 files changed, 123 insertions(+), 14 deletions(-)
>
> --
> 2.40.1
>
