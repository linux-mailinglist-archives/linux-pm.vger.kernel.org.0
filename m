Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84E271A4B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfGWO1M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfGWO1M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 10:27:12 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C1C227C2;
        Tue, 23 Jul 2019 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563892031;
        bh=N+Ue7x6CR5Jb4q9/FJUaj8bwy6sXpTBfgYk9DGdpaTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O1tSrR6mLbZR2SFl5YStt8tI1T83OBm70Z8ESu4jcAzFa76wk+ollTJfV90NuHKPx
         xeJRnVTTCeDOA5854nbQ/Irg5lO5cqWRHIUSmuzsmVc3dnP6/LcYuSBKXeO4et/siu
         InSv1WptHw8epZnmkfzgcuUtAzp1VubwZCYLYtDs=
Received: by mail-qt1-f175.google.com with SMTP id x22so37187292qtp.12;
        Tue, 23 Jul 2019 07:27:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUw3F81CU0FCn9XvIaIwEggNIst5q4NehvDJ8R3Vf131HnF+fsy
        NRJAPGAzOnFySJ6PyHgNlIAwf3qw63Cw+QJdlw==
X-Google-Smtp-Source: APXvYqzYpyWF+jLJrs6e1TZWlyLbEwUvquqzpcgaB5p3hKJ4WN2M09TU5Mw7X6X1t5LhM8wDdbeIHPeJsHsMaGrnJvw=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr8582738qtb.224.1563892030231;
 Tue, 23 Jul 2019 07:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org> <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
 <20190722233501.GA19594@bogus> <CAGETcx9GzQj0ZHNF+uR2cGHUkQ5sOPYEwyXKK1dJ2sJbHVSVyw@mail.gmail.com>
In-Reply-To: <CAGETcx9GzQj0ZHNF+uR2cGHUkQ5sOPYEwyXKK1dJ2sJbHVSVyw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 23 Jul 2019 08:26:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJeGK2m6hVEqvFxW6dEhi22LXaRKgb5JmnJfmCp+J6XuA@mail.gmail.com>
Message-ID: <CAL_JsqJeGK2m6hVEqvFxW6dEhi22LXaRKgb5JmnJfmCp+J6XuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 5:41 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Jul 22, 2019 at 4:35 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jul 16, 2019 at 11:58:08AM -0700, Saravana Kannan wrote:
> > > On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> > > >
> > > > Hey Saravana,
> > > >
> > > > https://patchwork.kernel.org/patch/10850815/
> > > > There was already a discussion ^^ on how bandwidth bindings were to be
> > > > named.
> > >
> > > Yes, I'm aware of that series. That series is trying to define a BW
> > > mapping for an existing frequency OPP table. This patch is NOT about
> > > adding a mapping to an existing table. This patch is about adding the
> > > notion of BW OPP tables where BW is the "key" instead of "frequency".
> > >
> > > So let's not mixed up these two series.
> >
> > Maybe different reasons, but in the end we'd end up with 2 bandwidth
> > properties. We need to sort out how they'd overlap/coexist.
>
> Oh, I totally agree! My point is that the other mapping isn't the
> right approach because it doesn't handle a whole swath of use cases.
> The one I'm proposing can act as a super set of the other (as in, can
> handle that use case too).
>
> > The same comment in that series about defining a standard unit suffix
> > also applies to this one.
>
> I thought I read that whole series and I don't remember reading about
> the unit suffix. But I'll take a closer look. I've chosen to keep the
> DT units at least as "high of a resolution" as what the APIs accept
> today. The APIs take KB/s. So I make sure DT can capture KB/s
> differences. If we all agree that KB/s is "too accurate" then I think
> we should change everything to MB/s.

Either one is fine with me, but trying to align to what the OS picked
doesn't work. What does BSD use for example? More important is
aligning across DT properties so we don't have folks picking whatever
random unit they like. We generally try to go with the smallest units
that will have enough (32-bit) range for everyone, so that's probably
KB/s here.

Rob
