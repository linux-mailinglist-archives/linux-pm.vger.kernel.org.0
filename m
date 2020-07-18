Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17C222491C
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jul 2020 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgGRFyD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Jul 2020 01:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGRFyD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jul 2020 01:54:03 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F371EC0619D2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 22:54:02 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so5189232qvj.12
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 22:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2k6UGv1LDKKpRhcTlEeKxXx4KzYCC+1w+JKMjKrFRu0=;
        b=SXDFIQGtPOO1FREUNIOxP6MWzaMjlwxoRi/POKmRyva84olDCacJCnT6XzOl2CHd0e
         lhy7pO0N82TpMOaZeLnvII1AvtSwGFJaoUa+nM9xa5PtLR9S7S0tkkUdtr8LaNLKMUZS
         E2ShrxF09uRjcuw01zNvHLn2t3Y1eA6X/ACLJ0K6QwKhNmbmb7ZIDCpvwWHXTQHkMv5T
         YkiBGvie7c9VBGwQxISEcIstBcy1tQhcn0KV+3gHMhFuBr4UviapSSRWR0v5aX2X3tYd
         3/NgYnHSAE2sD11wM7qOhkwof34OZm1jg43Gn3378JgC9YD7WtJGFiP+99yY4ANvOk17
         7P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2k6UGv1LDKKpRhcTlEeKxXx4KzYCC+1w+JKMjKrFRu0=;
        b=fHpeYbwzTePoIdntjlcKdHHWAxXwTlj4w18svN/LCqm3ofAqq5S3t+p3NziG+v3bVW
         yLsYXcMm7Wg3PW89V0Gmhn4Ve2qMZW7MlOKWIcO8r4lfWjX/Zbf9bKl3K7yGqyJKRDtg
         MqOA388JAdnfhOmVqvFtkNkb613j7AFPzabvRUw2Qs3dwMNSXuYGum+GLFdMem3qbEd/
         F1vv06ASDWClC89rTesMjqg3Gx9R370pI3Bx52de3bs9bRTJ3j5sdoIJG3FqcvgJtEOQ
         3u/iM1HkxOXGLPYZkujNyL5CpaOhSk8D0erBCzTduGEB3D/gZykPgsT0LmU4WfeW4//0
         aACQ==
X-Gm-Message-State: AOAM532MSDxKEVvSyOBA0ct0cEQd05T7lEVThoV3+JAgG0B+8QlAKPFF
        Mxf7goKr0ED55rR/UunDzu8E/LdLM+uM4VvzgyfelGwXYO3HZg==
X-Google-Smtp-Source: ABdhPJzLY74RMzYmgbkHsJNzGi49eeFA+weL5NWdPNyO+SUJBca0pFWb987AKAtIyclrDdJOZrLpaaNe82NgIZanLZY=
X-Received: by 2002:a05:6214:14f4:: with SMTP id k20mr12441481qvw.231.1595051641884;
 Fri, 17 Jul 2020 22:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200718021331.940659-1-joshdon@google.com> <CALCETrXHEhwBS72_Fiv9LbPjsBGp_rMmU16oYMTZJFa=wTki8A@mail.gmail.com>
In-Reply-To: <CALCETrXHEhwBS72_Fiv9LbPjsBGp_rMmU16oYMTZJFa=wTki8A@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 17 Jul 2020 22:53:50 -0700
Message-ID: <CABk29NsN_3kH4xyY1v0FixMDuGb_rG_iUYDFtwd3U5n10LsjaA@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: optimization to avoid CAL+RES IPIs
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Andy, thanks for taking a look.

On Fri, Jul 17, 2020 at 8:14 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> PeterZ and I fixed a whole series of bugs a few years ago, and remote
> wakeups *should* already do this. Did we miss something?  Did it
> regress?  Even the call_function_single path ought to go through this:
>
> void send_call_function_single_ipi(int cpu)
> {
>         struct rq *rq = cpu_rq(cpu);
>
>         if (!set_nr_if_polling(rq->idle))
>                 arch_send_call_function_single_ipi(cpu);
>         else
>                 trace_sched_wake_idle_without_ipi(cpu);
> }
>

Yep, I was sitting on this for a bit and raced with b2a02fc43a there.
90b5363ac also got rid of the last smp_send_reschedule() that was
triggering the ipiless handling.

One of the nice parts of the patch was that it could blanket apply to
all of the smp_call/reschedule.  However, with the above patches that
isn't a concern; it makes more sense to keep the existing
TIF_POLLING_NRFLAG logic.
