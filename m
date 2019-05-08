Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03C17278
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEHHTz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 03:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfEHHTz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 03:19:55 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B94216F4;
        Wed,  8 May 2019 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557299994;
        bh=5s82mRz37GOU+IcMp3MyKMCbLiU1C7ZcUVGcNhpH5lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E11ak32VdWO0HCXiaIpYYhSLkUOVSzGtt7C+duhsSnuQq1m6wnKsF9DbzeBfbNc9m
         c+eps5T9ZXj80o34QZ7K1C60+YBFBvOXxp+1tp7n1xRdGWiKGvRd2dToNEktE2wC/i
         kYMiUUwgXOFEreKWIcgOHyJNFdB9STkqkxCRVvKk=
Received: by mail-lf1-f48.google.com with SMTP id v18so11544612lfi.1;
        Wed, 08 May 2019 00:19:54 -0700 (PDT)
X-Gm-Message-State: APjAAAV6cVVNY1Yeg2NHtq16WfIZ7SLNvj/DVONY3mXPRaILrcALKAQT
        EQfbE8ylEGBlIs0A/nFaGKPeIAXJbUWlLT+JHsU=
X-Google-Smtp-Source: APXvYqxm+Lr3l+5U6IVN0zf0/Twn2AyJPJlVa0Rj0Toj+MXrDw6aAd3yhwZPrHty/HCsByMpxG66NOdyy87bKEpyvC4=
X-Received: by 2002:ac2:4992:: with SMTP id f18mr5172113lfl.154.1557299992587;
 Wed, 08 May 2019 00:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
 <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com> <20190507170422.GA25179@bogus>
In-Reply-To: <20190507170422.GA25179@bogus>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 8 May 2019 09:19:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
Message-ID: <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
To:     Rob Herring <robh@kernel.org>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
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

On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
> > +- devfreq-events : phandles of the PPMU events used by the controller.
> > +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
> > +- samsung,syscon-clk : phandle of the clock register set used by the controller.
>
> Looks like a hack. Can't you get this from the clocks property? What is
> this for?

Hi Rob,

Lukasz uses these two syscon regmaps to read certain registers. For
chipid he reads it to check the size of attached memory (only 2 GB
version is supported). This indeed looks like a hack. However the
second regmap (clk) is needed to get the timing data from registers
from DMC clock driver address space. These are registers with memory
timing so their data is not exposed anyway in common clk framework.

Best regards,
Krzysztof
