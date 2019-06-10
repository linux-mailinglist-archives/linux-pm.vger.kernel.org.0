Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53573B8B3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403984AbfFJPzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 11:55:16 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34417 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391358AbfFJPzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 11:55:16 -0400
Received: by mail-vs1-f65.google.com with SMTP id q64so5691643vsd.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJ960EUK4M88NTDJHb1rKy4PnhRaQvW8Nj+C4ov1eV0=;
        b=vCBfA3KmfrlpdkfwvUkrPRXgpjj0KDLsG7IqaJiYABwd5Pcyt+37mq5KWs4wPSGqMb
         8ZgO+v9HFp5+yUBCsWM3EzZH87jxKU3TpzYbeFbOOK7m8bhdQ1VpJzZg2LQ3MfAea/mO
         eIND2griYlCH1pm58X4Ot68AJrGmrqHsHx/39nYjlnDkDZjrdt6+jVL/CSvvh9a4M0lm
         RTE6Tl9praUVHc0Tmaeiz3dcU4blbB0iDAGmXz+xY0nJeRKi3vN6nhssHg1abNM+4se2
         nc4Ba32motZk89uankg8NcXb2RU99K3kViAN47xvTlR682A9KwMEfT3SmCv+tcveqfdQ
         +O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJ960EUK4M88NTDJHb1rKy4PnhRaQvW8Nj+C4ov1eV0=;
        b=pq1JHxd6+Zqh6JgQw/NMa8/P+1gPTaKNlpdAxZ1mOsYyAOcgZphGk99wVLJrf4DZHb
         UVGxIiDrgOCiEMS6jg7zp0o+daItYUngBrlmpv7pvcyiDMezeelLBW2FCb9RqLc110CE
         2uwi1PAdsy9pQEdD83c9bEmk9IvYmegZd+4PttKNovs5gLEJyi7yA6Q7gJCY69xSKZ7w
         m4S6hr6avttU1Ui4u6wmQHJ4HGBHybaP9KRMWHbIGrtc4noTIFMJSbV4N/23Cq1h/36Y
         oa3cLZoKD5HeUyxC/LAFBCsyz+Sgbmi5gq79wxuroID1jGrebDVOCSXp8x946ki8K6Je
         mTQA==
X-Gm-Message-State: APjAAAXzodnJQWGRL5NZi77MYEnhmBsl2DZmFVqkOQvmOxWSFXCNZWUG
        zIBf0UUOZzrt0p+Lc7Gb6sUIauOiiWLN5kxF+GfNRA==
X-Google-Smtp-Source: APXvYqyKa1UWfLl1PSfzv6wP9x21u1pRGC0+qtdGCuyShRG80yR2Bgm8tFZ6P+m7SezHV6nB/wuI1N1s+r9iik+R06c=
X-Received: by 2002:a67:706:: with SMTP id 6mr20519578vsh.200.1560182115587;
 Mon, 10 Jun 2019 08:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
 <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
 <20190607154210.GJ15577@e107155-lin> <20190607193407.GB24059@builder> <20190610103225.GA26602@e107155-lin>
In-Reply-To: <20190610103225.GA26602@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 17:54:39 +0200
Message-ID: <CAPDyKFr31SwmHHAREbR3dWMQ55LzzUyTc4M5FZvNsqWfX7SE8Q@mail.gmail.com>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement for PSCI
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 Jun 2019 at 12:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jun 07, 2019 at 12:34:07PM -0700, Bjorn Andersson wrote:
> > On Fri 07 Jun 08:42 PDT 2019, Sudeep Holla wrote:
> >
> > > On Tue, May 14, 2019 at 10:58:04AM +0200, Ulf Hansson wrote:
> > > > On Tue, 14 May 2019 at 10:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Mon, May 13, 2019 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > This series enables support for hierarchical CPU arrangement, managed by PSCI
> > > > > > for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> > > > > > recently was extended to manage devices belonging to CPUs.
> > > > >
> > > > > ACK for the patches touching cpuidle in this series (from the
> > > > > framework perspective), but I'm assuming it to be taken care of by
> > > > > ARM/ARM64 maintainers.
> > > >
> > > > Thanks for the ack! Yes, this is for PSCI/ARM maintainers.
> > > >
> > > > BTW, apologize for sending this in the merge window, but wanted to
> > > > take the opportunity for people to have a look before OSPM Pisa next
> > > > week.
> > > >
> > >
> > > I will start looking at this series. But I would request PSCI/other
> > > maintainers to wait until we see some comparison data before we merge.
> >
> > What comparison are you asking for here? Do you want to see the
> > improvement this series gives or are you hoping to compare it with some
> > other mechanism?
> >
>
> OK, I have mentioned this many times already, let me repeat it again.
> This series adds an alternative to the existing PC mode of CPU idle
> management. And it's clear that the main reason for the same is the
> improvement OSI mode offers vs the PC mode. I am asking the comparison
> for the same. And yes we need to compare apples with apples and not
> oranges here.

In the cover letter you see the two main reasons behind this series.
Yeah, OSI support is a part of the series, but OSI or PC mode is
orthogonal to the overall changes this series implements.

When it comes to comparing OSI mode vs PC mode, let's try to avoid
that tiring discussion again, please. :-)

My summary from the earlier ones, is that because the PSCI spec
includes support for OSI, we should also support it in the kernel (and
ATF). In a discussion offlist, Lorenzo agreed that it's okay to add,
without an apple to apple comparison. Maybe Lorenzo can fill in and
state this publicly, to save us all some time?

My final point in regards to the OSI mode support, it's a minor part
of the series. I don't see how that should hurt from a maintenance
point of view, or perhaps I am wrong? In any case, I offer my help
with review/maintenance in any form as you may see need/fit.

[...]

Kind regards
Uffe
