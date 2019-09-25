Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C3ABD859
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411902AbfIYGhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 02:37:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34956 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411899AbfIYGhQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 02:37:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190925063713euoutp0132ca59f2f0bf4f17094842426ddd5833~HmwNeM7MO1107411074euoutp01p
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 06:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190925063713euoutp0132ca59f2f0bf4f17094842426ddd5833~HmwNeM7MO1107411074euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569393433;
        bh=PTpIyUHIXTqz2c8IaDFpxmCXnxMUnHqIRiezGA01XFo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KsiR5q7bZYXZfnIEx6QD3+MbIR9A1IcHObdt5Iu7sN/JxEmlT3BhwkePrM0Npq5Js
         0Xf4icDVroST3RNE84ezy0e/itKDsssmU9ENr/8mNLdkLIxJrCw7aneqAblJC5c9Ab
         Wwjhse5Ya9Gk/8ki1MypfAxJA+aHhDdE2Lg1tUUI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190925063713eucas1p23cbed2b2805d4f73fee77092c55da655~HmwM1RwYs0327503275eucas1p2r;
        Wed, 25 Sep 2019 06:37:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 95.14.04374.91B0B8D5; Wed, 25
        Sep 2019 07:37:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925063712eucas1p2ff9604b97cacc1dbe1d24cbd610fe3f6~HmwMb-_P20418704187eucas1p2c;
        Wed, 25 Sep 2019 06:37:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925063712eusmtrp1c5a77334479134d990a5cdbc969d8dec~HmwMaoLYn1275412754eusmtrp1d;
        Wed, 25 Sep 2019 06:37:12 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-75-5d8b0b196250
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.B8.04117.81B0B8D5; Wed, 25
        Sep 2019 07:37:12 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190925063711eusmtip106b3032f7da3c3cb22b42522162f369d~HmwLmlcBK2459024590eusmtip1x;
        Wed, 25 Sep 2019 06:37:11 +0000 (GMT)
Message-ID: <f7387513d3c11cea7a7d35652457c1e7d7fed009.camel@samsung.com>
Subject: Re: [RFC PATCH v2 00/11] Simple QoS for exynos-bus driver using
 interconnect
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        krzk@kernel.org, "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>,
        k.konieczny@samsung.com
Date:   Wed, 25 Sep 2019 08:37:11 +0200
In-Reply-To: <0cceb46a-fca1-62ae-c2cc-fb0f9b9bd132@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Z2zo7LyXEavlZ0GQkVXsr64wMjTQpOEFEgGKXV0pOKl2RH
        LTPLLpraBVNLXZmal3SxdNO8rDKYKytJCdMkFSWzUcOVqYl0oc0zsf+e93nf3/e8L3w0IR8m
        l9MxCUmcKkEZp6Ck4uYXc90+nkuvhG/KHqDxyN1MhHXF9ST+YtyA30+bSVxm6ibxu5lvFC56
        qqdw/kieGJf/KCZxT0+DBNcOT5JYP9ZP4l7DHQpPXTMhXNzTLsJa07AED56vpXBxwRcqSM7q
        NTkUO9T/hGJHrnSK2Maqc6zO2ipirzdpEDulX7VPclC6LZKLi0nhVH7bj0qjKx6PEYmVAafy
        GmtQBirxzUVONDBb4WP1X1EuktJyphaBsV8tFoppBNO9bxzFFAKLOV+0gNQ/qJcIjfsI7mjN
        Dv4zgjz1LbF9SsawcM+aM0+4MaFQahkl7ZpiAuHN4M95wJ2xIvj07DthLwimRgQvKyoo+5SY
        8YK5V6OEXTvZiJtDhZSQ7Q0Tr6/bEmhbgiv8aXWz2wSzGi4+uj3/DjDnaei9OuvYdSeUFvY5
        WDf42tkkEfRK6Cq4KhY0D+NtI6QAZyDQ15gIoREAHZ1vSXsYwWyAeoOfYMsgQ/fL8c4O0FoM
        8yPAuMDAhKuwjwvkNxcRgi2D7Cy5IBVgKHERQIALD/qJPKRQL96i/u8W9WJqOSI0yINL5uOj
        OH5LAnfSl1fG88kJUb4RJ+L1yPbpuv52zrSi9t/HjIihkcJZFkTmhstJZQqfGm9EQBMKd5l6
        pc2SRSpTT3OqE0dUyXEcb0QraLHCQ5a2ZPSQnIlSJnGxHJfIqRa6ItppeQbS3l52NkA9sDEk
        a1dhW2iYf0jfmUkNXl/g6ep/tPyAoSW/uvK4NO1auvWCPNiaHje799xc5No6Rhv2PDSkoMpU
        eniiKHhUt+aSl08ge8McEVQb7dSVXhbrMbGnZrbSqsjR1Xnu7NB+eDi+27L98mRVS+b+Bj/f
        hmbndV3ek2B2WaoQ89HKzRsJFa/8B7RNDNpwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7oS3N2xBkde61rcn9fKaLFxxnpW
        i5eHNC2uf3nOajH/yDlWiytf37NZTN+7ic1i0v0JLBYLPs1gtTh/fgO7xYq7H1ktNj2+xmpx
        edccNovPvUcYLWac38dksfbIXXaL240r2CxmTH7J5iDksWlVJ5vHnWt72Dzudx9n8ti8pN5j
        47sdTB59W1YxenzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXsXD3Y+aCxdYVEzYvY2xgnKnXxcjJISFgIrF+9Xr2LkYuDiGBpYwSy3ad
        ZoJISEh8XH+DFcIWlvhzrYsNougJo8Tic8/YQRK8Ah4Si951gjUIC4RLzH39AKyBTcBe4uzt
        b0wgDSIC7xklPmx/B7aCWWAVk8SBroeMIFUsAqoSP08+YAaxOYE6pt6ZArXiE5PEpesnwUYx
        C2hKtG7/zQ5xh47E21N9LF2MHECrBSX+7hCGKJGXaN46m3kCo+AsJB2zEKpmIalawMi8ilEk
        tbQ4Nz232EivODG3uDQvXS85P3cTIzCKtx37uWUHY9e74EOMAhyMSjy8DqxdsUKsiWXFlbmH
        GCU4mJVEeGfJAIV4UxIrq1KL8uOLSnNSiw8xmgL9M5FZSjQ5H5hg8kriDU0NzS0sDc2NzY3N
        LJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MLosePnDtdbJf9eB5Oyc4ham1VN33TeIKFOs
        Z/503S1EZI7aikv7LQ/5nIi7sem/mF2KRf9j/rle5XtOtmfkHXrFOalEpe5187y+1/Kfuc8c
        UHy4QD6rvYVlgqererhR0QIlZ60Hm8IOnfD7ean43K5bh6OPnbrrqbtvo+EV3oJskzqzjqkB
        k5RYijMSDbWYi4oTAV93TW74AgAA
X-CMS-MailID: 20190925063712eucas1p2ff9604b97cacc1dbe1d24cbd610fe3f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-RootMTR: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
References: <CGME20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec@eucas1p1.samsung.com>
        <20190919142236.4071-1-a.swigon@samsung.com>
        <fe6d026d-71b5-438d-6932-6a2234fc72c2@samsung.com>
        <d8550f93-d4cf-f215-c083-8ecad267d430@samsung.com>
        <c06ca89f2b40e0282f19727b95da5e5b0158d7e3.camel@samsung.com>
        <0cceb46a-fca1-62ae-c2cc-fb0f9b9bd132@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-09-25 at 15:12 +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 9. 25. 오후 2:47, Artur Świgoń wrote:
> > Hi,
> > 
> > On Fri, 2019-09-20 at 11:14 +0900, Chanwoo Choi wrote:
> > > Hi Artur,
> > > 
> > > I tried to just build this patch on mainline kernel or linux-next.
> > > But, when I applied them, merge conflict happens. You didn't develop
> > > them on latest version. Please rebase them based on latest mainline kernel.
> > 
> > I developed on top of next-20190918 on which I applied
> > https://patchwork.kernel.org/cover/11149497/ as I mentioned in the cover
> > letter. The dev_pm_qos patches and my RFC have just cleanly rebased together on
> > top of next-20190920. Could you check if you have the dev_pm_qos patches (v5,
> > the version number is missing in this one; link above) and if so, where does the
> > conflict appear?
> 
> I faced on the merge conflict of drivers/devfreq/exynos-bus.c.
> I think that It is not related to to dev_pm_qos patch.

I think that it is actually related to the specific version of dev_pm_qos (v5) that
I used because patch 08/08 of dev_pm_qos series modifies exynos_bus_probe() in
drivers/devfreq/exynos-bus.c (https://patchwork.kernel.org/patch/11149507/).

I will rebase the next RFC (v3) on latest dev_pm_qos patches from Leonard and the
latest Linux-next kernel.

> Maybe, Kamil's patches[1] changed the many things of exynos-bus.c
> If your test branch doesn't contain following patches, 
> you need to rebase your patches based on latest mainline kernel 
> from Linus Torvald.
> [1] https://patchwork.kernel.org/cover/11083663/
> - [RESEND PATCH v5 0/4] add coupled regulators for Exynos5422/5800

Yes, requiring Kamil's patches is one of the changes in this RFC (v2), since they
are already merged.

> Today, I tried to apply these patch again based on latest mainline kernel.
> The merge conflict happen still.
> 
> - merge conflict log
> Applying: devfreq: exynos-bus: Extract exynos_bus_profile_init()
> error: patch failed: drivers/devfreq/exynos-bus.c:334
> error: drivers/devfreq/exynos-bus.c: patch does not apply
> Patch failed at 0001 devfreq: exynos-bus: Extract exynos_bus_profile_init()
> 
> 
> > 
> > > On 19. 9. 20. 오전 10:07, Chanwoo Choi wrote:
> > > > Hi Artur,
> > > > 
> > > > On v1, I mentioned that we need to discuss how to change
> > > > the v2 for this. But, I have not received any reply from you on v1.
> > > > And, without your reply from v1, you just send v2.
> > > > 
> > > > I think that it is not proper development sequence.
> > > > I have spent many times to review your patches
> > > > and also I'll review your patches. You have to take care
> > > > the reply of reviewer and and keep the basic rule
> > > > of mailing contribution for discussion.
> > > > 
> > > > On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> > > > > The following patchset adds interconnect[1][2] framework support to the
> > > > > exynos-bus devfreq driver. Extending the devfreq driver with interconnect
> > > > > capabilities started as a response to the issue referenced in [3]. The
> > > > > patches can be subdivided into four logical groups:
> > > > > 
> > > > > (a) Refactoring the existing devfreq driver in order to improve readability
> > > > > and accommodate for adding new code (patches 01--04/11).
> > > > > 
> > > > > (b) Tweaking the interconnect framework to support the exynos-bus use case
> > > > > (patches 05--07/11). Exporting of_icc_get_from_provider() allows us to
> > > > > avoid hardcoding every single graph edge in the DT or driver source, and
> > > > > relaxing the requirement contained in that function removes the need to
> > > > > provide dummy node IDs in the DT. Adjusting the logic in
> > > > > apply_constraints() (drivers/interconnect/core.c) accounts for the fact
> > > > > that every bus is a separate entity and therefore a separate interconnect
> > > > > provider, albeit constituting a part of a larger hierarchy.
> > > > > 
> > > > > (c) Implementing interconnect providers in the exynos-bus devfreq driver
> > > > > and adding required DT properties for one selected platform, namely
> > > > > Exynos4412 (patches 08--09/11). Due to the fact that this aims to be a
> > > > > generic driver for various Exynos SoCs, node IDs are generated dynamically
> > > > > rather than hardcoded. This has been determined to be a simpler approach,
> > > > > but depends on changes described in (b).
> > > > > 
> > > > > (d) Implementing a sample interconnect consumer for exynos-mixer targeted
> > > > > at the issue referenced in [3], again with DT info only for Exynos4412
> > > > > (patches 10--11/11).
> > > > > 
> > > > > Integration of devfreq and interconnect functionalities is achieved by
> > > > > using dev_pm_qos_*() API[5]. All new code works equally well when
> > > > > CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
> > > > > interconnect API functions are no-ops.
> > > > > 
> > > > > This patchset depends on [5].
> > > > > 
> > > > > --- Changes since v1 [6]:
> > > > > * Rebase on [4] (coupled regulators).
> > > > > * Rebase on [5] (dev_pm_qos for devfreq).
> > > > > * Use dev_pm_qos_*() API[5] instead of overriding frequency in
> > > > >   exynos_bus_target().
> > > > > * Use IDR for node ID allocation.
> > > > > * Avoid goto in functions extracted in patches 01 & 02 (cf. patch 04).
> > > > > * Reverse order of multiplication and division in
> > > > >   mixer_set_memory_bandwidth() (patch 11) to avoid integer overflow.
> > > > > 
> > > > > ---
> > > > > Artur Świgoń
> > > > > Samsung R&D Institute Poland
> > > > > Samsung Electronics
> > > > > 
> > > > > ---
> > > > > References:
> > > > > [1] Documentation/interconnect/interconnect.rst
> > > > > [2] Documentation/devicetree/bindings/interconnect/interconnect.txt
> > > > > [3] https://patchwork.kernel.org/patch/10861757/ (original issue)
> > > > > [4] https://patchwork.kernel.org/cover/11083663/ (coupled regulators; merged)
> > > > > [5] https://patchwork.kernel.org/cover/11149497/ (dev_pm_qos for devfreq)
> > > > > [6] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
> > > > > 
> > > > > Artur Świgoń (10):
> > > > >   devfreq: exynos-bus: Extract exynos_bus_profile_init()
> > > > >   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
> > > > >   devfreq: exynos-bus: Change goto-based logic to if-else logic
> > > > >   devfreq: exynos-bus: Clean up code
> > > > >   interconnect: Export of_icc_get_from_provider()
> > > > >   interconnect: Relax requirement in of_icc_get_from_provider()
> > > > >   interconnect: Relax condition in apply_constraints()
> > > > >   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
> > > > >   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
> > > > >   arm: dts: exynos: Add interconnects to Exynos4412 mixer
> > > > > 
> > > > > Marek Szyprowski (1):
> > > > >   drm: exynos: mixer: Add interconnect support
> > > > > 
> > > > >  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
> > > > >  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
> > > > >  drivers/devfreq/exynos-bus.c                  | 319 +++++++++++++-----
> > > > >  drivers/gpu/drm/exynos/exynos_mixer.c         |  71 +++-
> > > > >  drivers/interconnect/core.c                   |  12 +-
> > > > >  include/linux/interconnect-provider.h         |   6 +
> > > > >  6 files changed, 327 insertions(+), 92 deletions(-)
> > > > > 


