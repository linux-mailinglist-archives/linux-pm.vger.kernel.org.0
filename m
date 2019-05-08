Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53982175DA
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEHKTT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 06:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHKTT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 06:19:19 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F2D216C4;
        Wed,  8 May 2019 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557310758;
        bh=KgiLwHa8c628XCTksNuq14BZQuGqDsnA4pu3qRgYcxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2wft5YmM3CM2rKVQmpR6hOXN83mEVRAGkfTMAnH44HifrmzxdXs+02+K45kkV3yXn
         SvHDi2skTrO4pZqoo9fwE+uG5WIJDdk33/r0LrAJsE606iivCAE2HAmf2kBc4cwQEU
         7Zu6tEOESBQf/upZesMJd6wJb1Pb3iqzL6f13vfE=
Received: by mail-lj1-f176.google.com with SMTP id y10so10458062lji.9;
        Wed, 08 May 2019 03:19:17 -0700 (PDT)
X-Gm-Message-State: APjAAAXgi3EkamGkdwSyIYhaXl/j71xt21dN/Bnzc6qsQ/4L/R2NwiJv
        GtiYwcES88ib3iU1KwpsJYoqxB/mJ+aFwv1b45I=
X-Google-Smtp-Source: APXvYqwYkt5J0rET0wyrGnqJH8poPsUWaDooXeIeenTxmEqd6U1lzC8GOwJ2ZxmNmgblZZPq0m1QyUUqoG45zpuRE0s=
X-Received: by 2002:a2e:82cb:: with SMTP id n11mr20509505ljh.183.1557310756058;
 Wed, 08 May 2019 03:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
 <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
 <20190507170422.GA25179@bogus> <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
 <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
In-Reply-To: <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 8 May 2019 12:19:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc2Swoi+xc_=QTMdY8p2DTtf5SprpfMFC6B9QCNUtxm-w@mail.gmail.com>
Message-ID: <CAJKOXPc2Swoi+xc_=QTMdY8p2DTtf5SprpfMFC6B9QCNUtxm-w@mail.gmail.com>
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 8 May 2019 at 11:45, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
>
> On 5/8/19 9:19 AM, Krzysztof Kozlowski wrote:
> > On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
> >>> +- devfreq-events : phandles of the PPMU events used by the controller.
> >>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
> >>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
> >>
> >> Looks like a hack. Can't you get this from the clocks property? What is
> >> this for?
> >
> > Hi Rob,
> >
> > Lukasz uses these two syscon regmaps to read certain registers. For
> > chipid he reads it to check the size of attached memory (only 2 GB
> > version is supported). This indeed looks like a hack. However the
> > second regmap (clk) is needed to get the timing data from registers
> > from DMC clock driver address space. These are registers with memory
> > timing so their data is not exposed anyway in common clk framework.
> >
> > Best regards,
> > Krzysztof
>
> Thank you Krzysztof for a fast response. I have also responded to Rob.
> I wouldn't call accessing chipid registers as a hack, though. The DMC
> registers do not contain information about the memory chip since it is
> in phase of production the board not the chip. Thus, chipid regs (which
> loads from e-fuses) are best place to put information about memory
> type/size.

By hack I meant that you have to read chipid instead of DTS... but as
you pointed, the DTS could not match the real fused values so actually
it makes sense to read them.

Best regards,
Krzysztof
