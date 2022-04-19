Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB14507232
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354071AbiDSPyu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354069AbiDSPyt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 11:54:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7DB1DA7C
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 08:52:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r189so12069829ybr.6
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svoxI3P1MTFKEFyUdpPrcgYOwcptyW2jfm7B97EDACE=;
        b=hqY0Brlnj/vptEt82cDudZbgfl/3pzyr/UiAK/HR09LT2qyTDendN2hCQPDULF4qRw
         DMD2WZXHCb7MJ6aZApQPmIIYGkgKyW069+FnJ/ZD6dZVthsZUDW9dcmzZ492aVLwGFEJ
         6l2c0JYNOrFB8mg2mlynr3gwmUfaXR24R65wX0B4FRGrmXixvPYrki9bKMc/kqhY/9H3
         QgRcRDULdmTq/hsEt1UZDfjxOwX/1ydc8yeOfCJRu6Mkx5iP4BBjSFIrY++zZ1nJ9dS2
         MossmJ9Bg137dn4v5St1p4jFCv/YC9o/Y71hNCY1vP+aiUG5nm1GIzZxytpjf2PIvl0g
         8ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svoxI3P1MTFKEFyUdpPrcgYOwcptyW2jfm7B97EDACE=;
        b=d8XCUmgytbQ4NjWULKUodQCT1zxC8FXOxOHkdEkwwzCuCA4HnKM42+ZYM9nSPaYFN7
         TUW7Q4SwNf4RGFBbW6SAHqIrir0ISDT3WmJErvR08RmmOJpx1DxJPVazEaAEarYHMX57
         se1hZtLQQMXNpsDjDiB481e/hWbpW7K26HsLLL374S8NxP9B1Ma7XafpXcFhoofT/nS4
         3Zplbu1H/ddMGUMqR/nmk/AIgj6OM1NM+nqw5EJNB+s9y5QJpUDKi5yPCA8NpZKv1lgX
         7Jg1J+j3oD2A2f8AkBOHFerNFxjZGrdbtmOfe/pnazMJ2ZPtaVIHZTzBzsxtc4Rn3iU1
         poog==
X-Gm-Message-State: AOAM5321Q1dvU1TkZecsIElTRtGIp6P7IlomZtD5yzZR/moA5R3LEQxZ
        Jv4upLd0xZzOTM+BLAhOd+Li6yKgVbKtNjtLicdhI/hxGmiFNw==
X-Google-Smtp-Source: ABdhPJwN4AvAD8+aKlKRmatVjthj6YnAmVf6tJQjltNxIYx9SRXrW98T2rAdS6RIq8B0rMsZFiegW5J8TJY2hfW4B0I=
X-Received: by 2002:a25:ea48:0:b0:644:e2e5:309 with SMTP id
 o8-20020a25ea48000000b00644e2e50309mr11576663ybe.407.1650383525468; Tue, 19
 Apr 2022 08:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de>
In-Reply-To: <20220415133356.179706384@linutronix.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 19 Apr 2022 08:51:54 -0700
Message-ID: <CANn89iL+CHRi1HJ6Mp4u=ECnfAXV2qxXZj_BsQuv+uwheAfDDw@mail.gmail.com>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 15, 2022 at 12:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> APERF/MPERF is utilized in two ways:
>
>   1) Ad hoc readout of CPU frequency which requires IPIs
>
>   2) Frequency scale calculation for frequency invariant scheduling which
>      reads APERF/MPERF on every tick.
>
> These are completely independent code parts. Eric observed long latencies
> when reading /proc/cpuinfo which reads out CPU frequency via #1 and
> proposed to replace the per CPU single IPI with a broadcast IPI.
>
> While this makes the latency smaller, it is not necessary at all because #2
> samples APERF/MPERF periodically, except on idle or isolated NOHZ full CPUs
> which are excluded from IPI already.
>
> It could be argued that not all APERF/MPERF capable systems have the
> required BIOS information to enable frequency invariance support, but in
> practice most of them do. So the APERF/MPERF sampling can be made
> unconditional and just the frequency scale calculation for the scheduler
> excluded.
>
> The following series consolidates that.
>

Thanks a lot for working on that Thomas.

I am not sure I will be able to backport this to a Google prodkernel,
as I guess there will be many merge conflicts.

Do you have by any chance this work available in a git branch ?

Thanks.



> Thanks,
>
>         tglx
> ---
>  arch/x86/include/asm/cpu.h       |    2
>  arch/x86/include/asm/topology.h  |   17 -
>  arch/x86/kernel/acpi/cppc.c      |   28 --
>  arch/x86/kernel/cpu/aperfmperf.c |  474 +++++++++++++++++++++++++++++++--------
>  arch/x86/kernel/cpu/proc.c       |    2
>  arch/x86/kernel/smpboot.c        |  358 -----------------------------
>  fs/proc/cpuinfo.c                |    6
>  include/linux/cpufreq.h          |    1
>  8 files changed, 405 insertions(+), 483 deletions(-)
>
>
