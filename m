Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB86338FD6B
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhEYJHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhEYJHx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 05:07:53 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFEAC06138A
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 02:06:23 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id z14so9168249uan.7
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W24PiGNXNex8TSJmeSkCuTzb+uJdL2zsMiFv8BFcFvc=;
        b=HZDJYKmF2kWGMUczQAf7ma7GkNX/N8HRLLGvXuz1bsSNCRPtdZu3EXxCcOyOSf85rR
         2+5IzEiRw6mSBNaqUZQSZILbj5l8TepV7yh1yRteMeIOSXAzSTACleiyI1U2/x4IML4b
         V/QFV3bz2ohxOh+9AwcpCiBBsuUFkdep4LpOSoQO/8V/LfiePEue6hTluOoNohrc/o+K
         M0bv/FoGoua8irhKUYw9RKSiMdnfD+3vBZc0XR9puX90dGNHGKPvlHS0KAKqxirRMCag
         IwvIx7aYUGf3kzlwZkjCgQexSo6Dp1Zr/Ost8X8MKIDrse+AI3BK24S8nhz1dgQL9fRH
         9Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W24PiGNXNex8TSJmeSkCuTzb+uJdL2zsMiFv8BFcFvc=;
        b=DWZuCP0BW1i+xmDxRcKYcY+Derelov4YZO8XwjcYdgoyClqMu+MoENmuI/Z6Lcm4uj
         1PtHk1blDepLIwNH/6+29KbXiK/M3vnoZ12+w0xjyRgP7c2t1mNY4C53W9jBg6ndM5Bv
         a7YFAiVjQdhNWJZ0Ftq2u2Z7I9+NEKdMWEANSHY5ihy0327JlBEmUGzK9h5bNdHDuKCw
         G5HW7/1IyuNXfp4S3wpJNSsJAtLx5TaCGZdDkfQuJQNitDCdxf484mr/1m0vKW4svyhX
         tKn4G04J8pQWIOW6v6kXsUY5MCV3ygja3GjhJ6A+DtltIg3u3jmDpPT+JiGTzHeFxMud
         NVeA==
X-Gm-Message-State: AOAM532wYpImYtc3VlQ3kW8rWyA6daX0myWLc1TJZsouS5ctD5t5gO10
        y8j+h8omb8FF0MnU3XwF0w3cNQpBb39pcPTSqpfrzA==
X-Google-Smtp-Source: ABdhPJxND4NykTeUoiZAJAAT0/jKOMNPPZs/Q6+XppZjXFFy+td+8fD27dD6EmHK4M+SeG97qhaTRwwMIQ17La85RMo=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr26031839uak.19.1621933582381;
 Tue, 25 May 2021 02:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210517130823.796963-1-anup.patel@wdc.com> <20210517130823.796963-6-anup.patel@wdc.com>
 <CAPDyKFpxx-jBbL4o_iJCcivFL2ei5a7PcWVfUaBmLu-q89Mkjg@mail.gmail.com> <CAAhSdy1quHePY_HM875LHQgXGKrjm24SzeD5yFJUnqunpcHd8g@mail.gmail.com>
In-Reply-To: <CAAhSdy1quHePY_HM875LHQgXGKrjm24SzeD5yFJUnqunpcHd8g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 May 2021 11:05:45 +0200
Message-ID: <CAPDyKFo9ZjiMBKFwe+F9-s_sReCneO42z8ppsBdkf3=jnarJ5A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/8] cpuidle: Factor-out power domain related code
 from PSCI domain driver
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 25 May 2021 at 07:39, Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, May 24, 2021 at 11:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 17 May 2021 at 15:10, Anup Patel <anup.patel@wdc.com> wrote:
> > >
> > > The generic power domain related code in PSCI domain driver is largely
> > > independent of PSCI and can be shared with RISC-V SBI domain driver
> > > hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.
> > >
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >
> > This is clearly a big step in the right direction. Just a couple minor
> > things, see more below.
> >
> > Note that, I have a couple of patches in the pipe for the
> > cpuidle-psci-domain driver (not ready to be posted). I need a couple
> > of more days to confirm this restructuring still makes sense beyond
> > these potential new changes. I will let you know as soon as I can with
> > the outcome.
>
> Sure, I will wait for more comments from you. I was thinking of sending
> next revision of patches sometime next week with the renaming of
> function names which you suggested.

Sounds good, that allows me a few more days this week.

>
> >
> > [...]
> >
> > > diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
> >
> > I think it would be a good idea to add a new section for this to the
> > MAINTAINERS file. Perhaps a "DT IDLE DOMAIN" section? Or perhaps you
> > have another idea?
> >
> > In any case, I am happy to continue with maintenance of this code,
> > even in the new restructured form.
>
> Yes, a separate "DT IDLE DOMAIN" section in MAINTAINERS file
> sounds good to me.
>
> Anyway the dt_idle_genpd is factored-out code from cpuidle-psci-domain.c
> so I suggest you to maintain dt_idle_genpd as well.
>
> Do you want me to add a "DT IDLE DOMAIN" section in the
> MAINTAINERS file as part of this patch ??

Yeah, that works for me. Perhaps extend it to .. PM DOMAIN though.

[...]

Kind regards
Uffe
