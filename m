Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02097A68
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfHUNLI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 09:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfHUNLI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Aug 2019 09:11:08 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E321233A1;
        Wed, 21 Aug 2019 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566393066;
        bh=kuKd4LaZeJI6UGgTswgE+Gt02Df19t8oQt48CusPTXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LZFoEmTZLW5/11AEGlzftmogTOLB8RKrREafKC4J4TPMec/ltqnY6dYL47sKyzaTV
         BDDe2ejhf4HF6SyRH2VGUPgr+1B9W6Mo9sLVcvQ/eUWq1YnwzXSrCvx9Iyg+iqkOaN
         ap4gxStwa04LH392BnFNBZzl7QWh6o4noa3gC7+A=
Received: by mail-lj1-f180.google.com with SMTP id u15so2095675ljl.3;
        Wed, 21 Aug 2019 06:11:06 -0700 (PDT)
X-Gm-Message-State: APjAAAUVQcJ3wZkpnRK53+r5BydQXdmRjFNUpD5kWwIXnBjHjHmeY4UL
        XV4/oDhc4xtEBiA0W8gtFzFw6xLUcNArV3uP9YU=
X-Google-Smtp-Source: APXvYqzNzg748L/o/0qZKaYe00jb2xN8DKKsSLoVgu+VFsvbF9k9puSj21ekEvwwAX73N4YmYdngdgwk12tAWSFHzKA=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr2602513ljc.210.1566393064499;
 Wed, 21 Aug 2019 06:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c@eucas1p2.samsung.com>
 <20190813150827.31972-3-s.nawrocki@samsung.com> <b5359603-b337-dcd8-b025-ca7dff5f4a06@nvidia.com>
 <CAJKOXPf597CMx=M2JmSTWe2GzBfcHFefgzSJbJ+njZGp-WfR1A@mail.gmail.com>
 <1e428c8e-f4b5-0810-77f9-2c899c040fc7@kernel.org> <72eea1ea-2433-2f76-6265-5851554e845d@samsung.com>
 <CAJKOXPdh9eHrAuCxHkQBvJMqEnUCeU2xwkK=9yyiJ6BuTLJ+_A@mail.gmail.com> <537999b7-b0e8-33a7-4bdc-c6952a0a5d06@samsung.com>
In-Reply-To: <537999b7-b0e8-33a7-4bdc-c6952a0a5d06@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 21 Aug 2019 15:10:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdbPg-O6zh6LXrvSRSMG8psxW6_eREe+UEH=UZNhAT=rQ@mail.gmail.com>
Message-ID: <CAJKOXPdbPg-O6zh6LXrvSRSMG8psxW6_eREe+UEH=UZNhAT=rQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, robh+dt@kernel.org,
        vireshk@kernel.org, devicetree@vger.kernel.org, kgene@kernel.org,
        pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Aug 2019 at 14:41, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 8/21/19 14:16, Krzysztof Kozlowski wrote:
> >>> I'm also inclined to have it converted to a regular driver.  We already
> >>> have "exynos-asv" driver matching on the chipid node (patch 3/9).
> >>> The ASV patches will not be merged soon anyway, all this needs some more
> >>> thought. Krzysztof, can we abandon the chipid patches for now? Your
> >>
> >> chipid driver is good and useful on its own. The preferred solution
> >> IMHO would be to just revert "soc: samsung: Convert exynos-chipid
> >> driver to use the regmap API" commit.
> >
> > I queued the chipid as a dependency for ASV but ASV requires the
> > regmap. What would be left after reverting the regmap part? Simple
> > unused printk driver? No need for such. If reverting, then let's drop
> > entire driver and rework it offline.
>
> In fact there is now no dependency between the chipid and the ASV
> driver (patch 3/9), the regmap is provided by the syscon driver/API.
> I should have added "depends on REGMAP && MFD_SYSCON" to Kconfig.
> Both drivers (chipid, ASV) share the registers region so the regmap
> API seemed appropriate here.

Indeed, ASV needs only the header + DT change... Then actually we do
not need chipid driver at all. Just to print the SoC and provide sysfs
entry? If this is the only purpose, then it should be a driver.

> Converting the chipid code to platform driver wouldn't make sense as
> it wouldn't be useful early in arch/arm/mach-exynos and we can't have
> two drivers for same device (the ASV driver matches on the chipid
> compatible now).

There is no use case for arm/mach-exynos. This code was not
resubmitted and I doubt it will be (unless now someone wants to prove
I am wrong and sends it again :) ). The two-device case is indeed a
problem but it is possible. Clocks are doing it with PMU driver. See
CLK_OF_DECLARE_DRIVER(), although I do not remember whether it is
maybe obsolete pattern (discouraged).

Best regards,
Krzysztof
