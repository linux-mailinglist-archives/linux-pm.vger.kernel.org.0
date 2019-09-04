Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E13A8032
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfIDKRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 06:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbfIDKRG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 06:17:06 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758B023404;
        Wed,  4 Sep 2019 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567592224;
        bh=2ey6sZwUX3qIGq8j1u1XlvD+weBFrsvta/y2/SgRYO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ExpbtXwSbOkrsScqxyE87tz7tqmgZLb2I90CCXpW7DgMs9twdX+SkUOWtBesX7NOR
         K0QMCVtyQ4MEDsxy3zdAoDWl100jhhg4EfEAnlOVaGmVW2w7j2c63lQDLfvXUULcXo
         tTNEhkGa6Bg2QuDejirO+Ver4giFQmYlU2cflQ3E=
Received: by mail-lf1-f52.google.com with SMTP id c12so15442251lfh.5;
        Wed, 04 Sep 2019 03:17:04 -0700 (PDT)
X-Gm-Message-State: APjAAAV7dg8YGnf35dE0X68d8hJBffbAJiaKOXV/JELe2fStdb0lDwcY
        UGRp7A9pQHnBLAWoAV8yQX6mPLEPKRayD2BKLao=
X-Google-Smtp-Source: APXvYqw/hwDzA5Mu4tWRBQjAR/A6Fp0eSBoYcr/oqkFnq3lt9L037MV1NoD9n2ZI6fGV9aSMAJqoKj9sszzXPIbkXyw=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr16737669lfy.69.1567592222558;
 Wed, 04 Sep 2019 03:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8@eucas1p2.samsung.com>
 <20190821104303.32079-1-l.luba@partner.samsung.com>
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Sep 2019 12:16:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPehHNDasNQDgTC+WtVpb_h-s0iTxXiDQY1WT=+zEdB18A@mail.gmail.com>
Message-ID: <CAJKOXPehHNDasNQDgTC+WtVpb_h-s0iTxXiDQY1WT=+zEdB18A@mail.gmail.com>
Subject: Re: [PATCH v13 0/8] Exynos5 Dynamic Memory Controller driver
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Aug 2019 at 12:43, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi all,
>
> This is v13 which makes cosmetic changes. It is based on current mainline
> (v5.3-rc5) with with devfreq/for-next where there is a PPMU patch [1].
>
> The patch set adds support of Dynamic Memory Controller for Exynos5422 SoC.
> The driver supports Dynamic Voltage and Frequency Scaling
> for the DMC and DRAM. It also provides needed timings for different
> speed operations of the DRAM memory.
> There is also new generic code in of_memory and headers which allows to parse
> LPDDR3 memories defined in device-tree.
>
> Here are the last changes suggested by Krzysztof during his review.
> For the previous changes in older revisions please refer to [2], there is
> more detailed change log.
>
> changes:
> v13:
> - skipped patch with chipID changes in DT, since it is not used anymore,
> - removed license comment in of_memory.c since SPDX has been merged,
> - aligned comment to the current fields in the structure,
> - changed printed warning when timings are not found,
>
> Regards,
> Lukasz Luba
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b617376df8f01c975dee66802f4da16291f92079
> [2] https://lkml.org/lkml/2019/7/22/251
>

Hi Lukasz,

Thanks for the effort and work on this patchset. The text-based
bindings are slowly converted to JSON-schema but your patches were
developed some time ago and have Rob's review. It would be nice if you
or someone converted it to JSON schema later.
Anyway, I'll pick up everything today evening either for this merge
window or eventually postponed till next one. It is quite late in the
cycle and I want the patches to sit in linux-next for some time.

Best regards,
Krzysztof
