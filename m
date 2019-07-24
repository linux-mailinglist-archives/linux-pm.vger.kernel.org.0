Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A637235C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 02:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfGXATN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 20:19:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42191 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfGXATI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 20:19:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so45990129otn.9
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEWjLSp+3ZYUNuS4KEhJxXUV1NrMjDNJTyQjAT98l0c=;
        b=KyTmnzEVvpYk+8Vlka2lOIuadkdcTW/Tz8dySg662PkCDcfqcEtDIWJHSQjNaXMk0C
         haii7dxiHOazpNAsR3Z5uOs1P7uV2Vqw/MLZ02bTVjbLF8knC5hZGHCDpTU4NMPLpWuL
         Xhx3HY2Hw65F9lEzCn6KA48uIWF57MLOLQvoohWT9KUUMS/pA7OUMytCzoKMUioppvFj
         vWSTNw9ple229Kqqzr/vF/e++yp0Xaojca4wB+WeVU9cDFpKWtVztOMrEWXFACXsEgpL
         FOKqSw6cChnRDA39sXL1mdr0XGu4PW1KThKsddz652YlAEIG+ce02Vei72xDob9tgh9J
         HffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEWjLSp+3ZYUNuS4KEhJxXUV1NrMjDNJTyQjAT98l0c=;
        b=g+l+JaaHJzOZuyuG68jP/T8+AYSbWcwKF2HLUjBdWp/vHpnnSL2jKj71G9MWMxkl8K
         0ko9am+XzbAJsrYVnTpq/a8CpIaXyfLWm9+6YpWvyla9WVYC6V1RgEiO6pQ5biIXmlyY
         bneiKdPB4AOzpyuL06FWFN5NqUcdiK/Kffch0GnlaAF6cAg/nEBH2+MviRzmawJhhyw3
         VgiG395nI0TPRf8qxOFDNuCEKm8POKxJqTYK5mrRmPRqnyhoGlEhv01wteSIcr+OApE1
         ESd1CtngfTeUbKBxhe+3KY1bt+lFEM/3IfZOYzbBAdV6crzSm9NT/RX14rBUswDudxVc
         nqLA==
X-Gm-Message-State: APjAAAXsztxwzQe/AfXwI8cbIbhUvvS2zIc/FTBEtmHVLZfk4A6iNEWH
        3dzINAwSypdNylUCdeLgVgCF3sNNKRnDLD+E8KJZRw==
X-Google-Smtp-Source: APXvYqzquNMPlzmL6KiNv9dmgPAQ6VX+Yc1CbsySXKc3HGl9ASNz/27eBQrBEGbA7tg6Cvx7smNnbzqfSRN1LoHdaAs=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr2293485otr.231.1563927547521;
 Tue, 23 Jul 2019 17:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org> <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
 <20190722233501.GA19594@bogus> <CAGETcx9GzQj0ZHNF+uR2cGHUkQ5sOPYEwyXKK1dJ2sJbHVSVyw@mail.gmail.com>
 <CAL_JsqJeGK2m6hVEqvFxW6dEhi22LXaRKgb5JmnJfmCp+J6XuA@mail.gmail.com>
In-Reply-To: <CAL_JsqJeGK2m6hVEqvFxW6dEhi22LXaRKgb5JmnJfmCp+J6XuA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Jul 2019 17:18:31 -0700
Message-ID: <CAGETcx9GkwDJHBuFBRheMqR80=JWnXa4xtPqQ+2xHcfvSd55+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Rob Herring <robh@kernel.org>
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

On Tue, Jul 23, 2019 at 7:27 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 5:41 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 4:35 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Jul 16, 2019 at 11:58:08AM -0700, Saravana Kannan wrote:
> > > > On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> > > > >
> > > > > Hey Saravana,
> > > > >
> > > > > https://patchwork.kernel.org/patch/10850815/
> > > > > There was already a discussion ^^ on how bandwidth bindings were to be
> > > > > named.
> > > >
> > > > Yes, I'm aware of that series. That series is trying to define a BW
> > > > mapping for an existing frequency OPP table. This patch is NOT about
> > > > adding a mapping to an existing table. This patch is about adding the
> > > > notion of BW OPP tables where BW is the "key" instead of "frequency".
> > > >
> > > > So let's not mixed up these two series.
> > >
> > > Maybe different reasons, but in the end we'd end up with 2 bandwidth
> > > properties. We need to sort out how they'd overlap/coexist.
> >
> > Oh, I totally agree! My point is that the other mapping isn't the
> > right approach because it doesn't handle a whole swath of use cases.
> > The one I'm proposing can act as a super set of the other (as in, can
> > handle that use case too).
> >
> > > The same comment in that series about defining a standard unit suffix
> > > also applies to this one.
> >
> > I thought I read that whole series and I don't remember reading about
> > the unit suffix. But I'll take a closer look. I've chosen to keep the
> > DT units at least as "high of a resolution" as what the APIs accept
> > today. The APIs take KB/s. So I make sure DT can capture KB/s
> > differences. If we all agree that KB/s is "too accurate" then I think
> > we should change everything to MB/s.
>
> Either one is fine with me, but trying to align to what the OS picked
> doesn't work. What does BSD use for example? More important is
> aligning across DT properties so we don't have folks picking whatever
> random unit they like. We generally try to go with the smallest units
> that will have enough (32-bit) range for everyone, so that's probably
> KB/s here.

Yeah, that makes sense.

-Saravana
