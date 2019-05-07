Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1C16859
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEGQuu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 12:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfEGQuu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 May 2019 12:50:50 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE30A20B7C;
        Tue,  7 May 2019 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557247848;
        bh=4tZewm4W45u/iRbwmWuTzyVbl39+IFYmFh6qEBuo2/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uqn/JtYS4kPRY76N+lJ+ylfSX3jhhKt8bpMbsPUAbhIPq7WbPOkwI7B+bzrRF+mtW
         rr9fHN54+6u6esuv8V9WbtBn2fLQCuyF7SDLs4bATzuba3qo3XUrWi5tyIGjUg7cWf
         ohL4+iQdMasZDjhJ/NdA27RT3khpi3Ok67A7e0sg=
Received: by mail-qk1-f182.google.com with SMTP id c15so1403744qkl.2;
        Tue, 07 May 2019 09:50:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWU/YvdochfhPJ65wvV2J/RL4XUBsq8SVnpfwMUF95E7Rekw30F
        Fq7nxqolBxCAObeOF1tB7yWqEeSclDpRbk/xRw==
X-Google-Smtp-Source: APXvYqwy91gBuwgIgFwBIlr7H7WziKK1/q+qve5xTg6xIcAxeG7XLdX/VKJhShfFBkFEzLxxQLOwWb8GHqYD7EgmNlA=
X-Received: by 2002:a37:5c81:: with SMTP id q123mr23947855qkb.29.1557247848038;
 Tue, 07 May 2019 09:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
 <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
 <20190430223629.GA22317@bogus> <1fd44623-4a59-f014-1ae9-a7cc605ad30f@partner.samsung.com>
 <CAL_JsqJcm9Z6vYFHGyAZ+h3-kmSv6e=3NtO-fjJn3-QT0JoX+w@mail.gmail.com>
 <97277857-666d-7720-9d85-19120c977682@partner.samsung.com> <3d221027-292b-7d0d-2510-f230a81f4b52@partner.samsung.com>
In-Reply-To: <3d221027-292b-7d0d-2510-f230a81f4b52@partner.samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 May 2019 11:50:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+K-bdhTBnW5R4M0nDoikfFRdz-BeZf9Rf-hSmACj4B2w@mail.gmail.com>
Message-ID: <CAL_Jsq+K-bdhTBnW5R4M0nDoikfFRdz-BeZf9Rf-hSmACj4B2w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 7, 2019 at 4:05 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Rob,
>
> On 5/6/19 12:29 PM, Lukasz Luba wrote:
> > Hi Rob,
> >
> > On 5/2/19 10:24 PM, Rob Herring wrote:
> >> On Thu, May 2, 2019 at 3:52 AM Lukasz Luba
> >> <l.luba@partner.samsung.com> wrote:
> >>>
> >>> Hi Rob,
> >>>
> >>> On 5/1/19 12:36 AM, Rob Herring wrote:
> >>>> On Fri, Apr 19, 2019 at 03:48:07PM +0200, Lukasz Luba wrote:
> >>>>> Extend the documenation by events description with new
> >>>>> 'event-data-type'
> >>>>> field. Add example how the event might be defined in DT.
> >>>>
> >>>> Why do we need event types in DT? We don't do this for other h/w
> >>>> such as
> >>>> ARM PMU.
> >>> In ARM PMU all the events are hard-coded into the driver code i.e. in v7
> >>> arch/arm/kernel/perf_event_v7.c
> >>> and are seen from perf. They are different type and for different
> >>> purpose. The Ecynos PPMU events are not seen in perf, they are
> >>> for internal monitoring and must not be reset by other actors like perf.
> >>> They are used by the 'bus drivers' to made some heuristics and tune the
> >>> internal settings, like frequency.
> >>>
> >>> Chanwoo has written PPMU driver which relies on DT definition.
> >>> The DT events are used by other DT devices by phandle.
> >>
> >> How is that done? I don't see anything in the binding for that.
> > Here are the DT devices and how they are pinned together:
> > - declared devfreq events:
> > https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
> >
> > - devfreq events pinned to the bus device:
> > https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/exynos4412-odroid-common.dtsi#L107
> >
> > - the bus device itself:
> > https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/exynos4412.dtsi#L457
> >
> >
> > Regards,
> > Lukasz
> >
> >>
> >> Rob
> >>
> >>
> Can I send the next version of the patch set, which has Chanwoo's
> suggestions, or do you have some objections to this PPMU entries?

I think the existing binding which this is based on needs some
changes, so it's pointless really for me to comment on additions.

Rob
