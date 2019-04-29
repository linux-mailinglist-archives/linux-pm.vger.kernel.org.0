Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4787DE7F7
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfD2Qny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 12:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfD2Qny (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Apr 2019 12:43:54 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACBE216F4;
        Mon, 29 Apr 2019 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556556230;
        bh=FTkncIZbvmo+q4fzVAyRGdQAopbIMIOz0iSDBCOQ89k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HGhohh5inSlyBklzyp/DveWB/sMf95ISDdNnu83TfGnaRqTQxMFq64xwEEYzUtKp/
         pAfk1XO+OIhlMrBS3cqFZqo89HnrVjRmZHuk8OwKqtRCB9kD0MdLgfQDIwDg05exCN
         IqIoEBUEknO8co16OeNZ5XWgmCJcEeiCAciSXIag=
Received: by mail-qt1-f174.google.com with SMTP id p20so12667595qtc.9;
        Mon, 29 Apr 2019 09:43:50 -0700 (PDT)
X-Gm-Message-State: APjAAAX+tr/hEdkGF6xc1rbhkCkTsEJqC75g8u0mCYxN0Y+KaaPEFpYe
        enFj8Z5YlPamG9GuiUemlqC30LenV3ggWODcoA==
X-Google-Smtp-Source: APXvYqzxGpqPUApkLr4tQOYZ40b33qqDT7vQFegDDDM/wN2fR4nE3DrASAaTlh9eyLchuOxZXj9xKQh4FvsDV4q+jYI=
X-Received: by 2002:a0c:9066:: with SMTP id o93mr10205357qvo.246.1556556229764;
 Mon, 29 Apr 2019 09:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
 <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
 <20190425195750.GA26031@bogus> <e4613d6e-0893-8163-32ef-8137c40d2b24@partner.samsung.com>
In-Reply-To: <e4613d6e-0893-8163-32ef-8137c40d2b24@partner.samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Apr 2019 11:43:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+bJtjO8xbpnCRHmcyCB=b8DMr73GWKEz+xMXVZag0FrQ@mail.gmail.com>
Message-ID: <CAL_Jsq+bJtjO8xbpnCRHmcyCB=b8DMr73GWKEz+xMXVZag0FrQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 7:14 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Rob,
>
> On 4/25/19 9:57 PM, Rob Herring wrote:
> > On Fri, Apr 19, 2019 at 04:19:24PM +0200, Lukasz Luba wrote:
> >> The patch adds description for DT binding for a new Exynos5422 Dynamic
> >> Memory Controller device.
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
> >>   1 file changed, 73 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> >> new file mode 100644
> >> index 0000000..133b3cc
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> >> @@ -0,0 +1,73 @@
> >> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
> >> +
> >> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
> >> +memory chips are connected. The driver is to monitor the controller in runtime
> >> +and switch frequency and voltage. To monitor the usage of the controller in
> >> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
> >> +is able to measure the current load of the memory.
> >> +When 'userspace' governor is used for the driver, an application is able to
> >> +switch the DMC and memory frequency.
> >> +
> >> +Required properties for DMC device for Exynos5422:
> >> +- compatible: Should be "samsung,exynos5422-bus".
> >> +- clock-names : the name of clock used by the bus, "bus".
> >> +- clocks : phandles for clock specified in "clock-names" property.
> >> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> >> +- vdd-supply : phandle for voltage regulator which is connected.
> >> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
> >> +- operating-points-v2 : phandle for OPPs described in v2 definition.
> >> +- device-handle : phandle of the connected DRAM memory device. For more
> >> +    information please refer to Documentation
> >
> > The memory node(s) should be a child of the memory controller IMO.
> I have followed the TI code for LPDDR2. They use 'device-handle'
> probably because the memory controller can be moved into the common
> .dtsi and taken by reference in .dts in a proper board file.

You'd still have to have the ctrlr node in the board file to add the
'device-handle' property.

> The board .dts files might specify different DRAM chips and timings.
> In Exynos case we will also have such situation: one memory controller
> and a few different DRAM chips.

You mean as in the case where there are multiple options and one chip
gets populated on the board? So 'device-handle' is selecting which
chip to use.

You can actually do both here. Keep 'device-handle' to select which
DRAM chip and have the chips as child nodes. But if you really don't
want to have them as child nodes, that's fine.

Rob
