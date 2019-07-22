Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1132070D81
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 01:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGVXlb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 19:41:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44694 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731102AbfGVXlb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 19:41:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so30827449oib.11
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67APUiaG7UxLheSEbISe3Tn27sJMteMTbqoURFT1XoA=;
        b=I6+P34LY0f5vyF9B+uy9PslT5WKLMItEvyXbe9YYr7nQoBjnek11aXKjq7SPMA8aRd
         hyG8LG4WpMge8Tx0dLJfxmylKxyG+PshphEzX4/SNFn+UiPfLCmbbTzSfnaLKmEK3X6o
         nLDC1oobEibs7sSL7paxJNGewRGuYDZMnnE6xUdPhoL/vrYc+vJu2xEdQBm18Nkx29Fm
         ht0hSU6pkxIrySCddzxSXCWY0BIRx3hV0pf2pxFVj1MIorBQidxVRfXS/UlhCbpv2EL2
         hb4orOES+rjszSEk4H3kqsZb2RWkSk/lOJNRKIOtvJAiA5hHKAjCHGyjKDlgZbVLq7g2
         ZS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67APUiaG7UxLheSEbISe3Tn27sJMteMTbqoURFT1XoA=;
        b=Ytr+QG2NjBe4gIZcrnWookpjRa8R77MPKNIsMRgKbYNTcaP2zV3lsl5ad4CD5NPJ2c
         ryRCGQlIEBsWrhz/AOXisknMYfVnc/NlonUw/0te47ok1lR3KdIwOOTGtXM4Y9PXAaYm
         41i8R+zvam/frdmKOZlbfEGZxIUQ9+rqylG4l3k9sbXyyiBS6XvFDjJeBBphTw7ypCyS
         9qcZdaGnz4wEUx//ZEzD4G2J5BIxu7UcuEOVhcZbPKQpR6kSVOTTA3WTwfnST9+KSWRu
         PpHRqhJBqIKr3zDdBKpIkXN8SRyOcIix1NY2dpl4+UarZ1BqmzU+m8ot3vRd0avSjonC
         1LzQ==
X-Gm-Message-State: APjAAAU+C02spNDJGFIH6l9j41xW7nLoiAAieezeG/SlSPHMXEVKX1jj
        w8jVOiiBKqUvREVRRWWlpK5SyAb7Iqlm70I1mkD4vQ==
X-Google-Smtp-Source: APXvYqweTW5Fc5Q2uLGP2UuxiXAJzAEvzTAMLQvVQSyfXU+IfRr+1wvAwdupCvUaVh9HkQ+orIyi2efK9LWcbPQ3KJw=
X-Received: by 2002:a05:6808:90a:: with SMTP id w10mr34680176oih.43.1563838889831;
 Mon, 22 Jul 2019 16:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org> <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
 <20190722233501.GA19594@bogus>
In-Reply-To: <20190722233501.GA19594@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 22 Jul 2019 16:40:53 -0700
Message-ID: <CAGETcx9GzQj0ZHNF+uR2cGHUkQ5sOPYEwyXKK1dJ2sJbHVSVyw@mail.gmail.com>
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

On Mon, Jul 22, 2019 at 4:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 16, 2019 at 11:58:08AM -0700, Saravana Kannan wrote:
> > On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> > >
> > > Hey Saravana,
> > >
> > > https://patchwork.kernel.org/patch/10850815/
> > > There was already a discussion ^^ on how bandwidth bindings were to be
> > > named.
> >
> > Yes, I'm aware of that series. That series is trying to define a BW
> > mapping for an existing frequency OPP table. This patch is NOT about
> > adding a mapping to an existing table. This patch is about adding the
> > notion of BW OPP tables where BW is the "key" instead of "frequency".
> >
> > So let's not mixed up these two series.
>
> Maybe different reasons, but in the end we'd end up with 2 bandwidth
> properties. We need to sort out how they'd overlap/coexist.

Oh, I totally agree! My point is that the other mapping isn't the
right approach because it doesn't handle a whole swath of use cases.
The one I'm proposing can act as a super set of the other (as in, can
handle that use case too).

> The same comment in that series about defining a standard unit suffix
> also applies to this one.

I thought I read that whole series and I don't remember reading about
the unit suffix. But I'll take a closer look. I've chosen to keep the
DT units at least as "high of a resolution" as what the APIs accept
today. The APIs take KB/s. So I make sure DT can capture KB/s
differences. If we all agree that KB/s is "too accurate" then I think
we should change everything to MB/s.

-Saravana
