Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55962306C94
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 06:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhA1FGN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 00:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhA1FGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 00:06:10 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E4CC061573
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 21:05:29 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u8so4316175ior.13
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 21:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KD4tLcNiy4HDrNzSGD8idjPG6xTsOou7ZvcPQ2ez8CM=;
        b=TifuJpGfQ7QtFN4bFHbdHHfGowQ6U7GIMHEry/x3fvhgeZbLFRYf4vrRfQqHOaTtrZ
         eCszRiZhu3+nL8/ZfDIdEL+r0fApbE/n143eaR/RCh0w7j7GRD398mwMGjWDLSFk0zGM
         Z6cJOQ8JW1OfTub+T2OPb1n02EjOYBw/eQwuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KD4tLcNiy4HDrNzSGD8idjPG6xTsOou7ZvcPQ2ez8CM=;
        b=UBu6HL1nkrFv6I5IZcTc2QpwHEOq4UJAZuayVUNN2CZ3BBK7mMXlwXIHIq6VS72iuk
         qdh0ZLly1yPD3RybAw3Nghk7riChEAXsCXKVgLc9cVDXYcf4J2kjSDLTxfgJLO7uOk6T
         Wa7xo5HhHkQqM/QGXJ7jtZP5WocHKNqmhySHq/p8dBtQhZv6noacMAKd7y0bHPUqqOsv
         8wdNYN3jlGUEjPYnO0E4iy2/ex/P3ZGWJnQhGm0tvddj+EWZiSioYiVMbFaeEHICs9EE
         3Kfbsg3TPIcp/RsNko9T+RzDpjv6q1wt3yUg6uNL9O2bFtSXUaWit2jMhvvkMS2j/zPw
         gJNA==
X-Gm-Message-State: AOAM530jQNXG2cORzpk2V3s9Z64KeAF3oS55mnTw5cCmrUk5IrwWS4YQ
        E6San1/AwxjukiuPXQiAnFkWtjHT1EpTvGS7kunRaA==
X-Google-Smtp-Source: ABdhPJwuSTPahAgGAw+cKvGKb8TBfZr01yuh3jcOCIdO5QCznjylSsK5+v58VVUIpuRX3/ECyMmBFiBuxCZc4RRVrr0=
X-Received: by 2002:a6b:2d4:: with SMTP id 203mr9812074ioc.0.1611810328608;
 Wed, 27 Jan 2021 21:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20190717222340.137578-4-saravanak@google.com> <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20200127061118.5bxei6nghowlmf53@vireshk-i7> <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
 <20200130042126.ahkik6ffb5vnzdim@vireshk-i7> <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com>
 <20210118073430.a6lr3ynkd2duv34l@vireshk-i7> <CAJMQK-j6EYjU1z_SUY4MFEJO6qTtOH7mQ_QWj2iUMewBKAghng@mail.gmail.com>
 <20210127115415.7zjpf6uaybwswno3@vireshk-i7> <CAJMQK-hgeOv9XDasmmWGguxyC62SCsSoX5_enEb46whE8_Emew@mail.gmail.com>
 <20210128041342.owkjl4voodw4dcmf@vireshk-i7>
In-Reply-To: <20210128041342.owkjl4voodw4dcmf@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 28 Jan 2021 13:05:02 +0800
Message-ID: <CAJMQK-ihjnTWXVuKZXE=cX2TpVaFMTreZ7fdieWm7PRbB8byxg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 28, 2021 at 12:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-01-21, 22:40, Hsin-Yi Wang wrote:
> > Hi Viresh,
> >
> > I tested this patch with devfreq passive governor[1] and mt8183
> > cci[2]. It's also working as expected.
>
> I hope I can add your Tested-by for the patch then, right ?
>
Yes, thanks!

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

> > [1] https://patchwork.kernel.org/project/linux-pm/cover/20190724014222.110767-1-saravanak@google.com/
> > (patch 2,4,5)
> > [2] https://patchwork.kernel.org/project/linux-mediatek/cover/1594348284-14199-1-git-send-email-andrew-sh.cheng@mediatek.com/
> >
> > In my testing case, required_opp_table is not genpd case (mt8183 cci
> > is not genpd), so I remove the following constraint. Does that make
> > sense to you?
> >
> > @@ -377,13 +377,6 @@ static void lazy_link_required_opp_table(struct
> > opp_table *new_table)
> >         struct dev_pm_opp *opp;
> >         int i, ret;
> >
> > -       /*
> > -        * We only support genpd's OPPs in the "required-opps" for now,
> > -        * as we don't know much about other cases.
> > -        */
> > -       if (!new_table->is_genpd)
> > -               return;
> > -
> >         mutex_lock(&opp_table_lock);
>
> We will perhaps need more changes than that, but those should be done
> separately when you try to add a user for the same.
>

Ack.

> --
> viresh
