Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E001403D4
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 07:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgAQGKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 01:10:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59481 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAQGKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 01:10:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200117061044euoutp028046dc51088b504518a3035392945c2d~ql7noAKVF0353603536euoutp02f
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 06:10:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200117061044euoutp028046dc51088b504518a3035392945c2d~ql7noAKVF0353603536euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579241444;
        bh=Z9fFgcC2NnU134JInpRdOeaMJ6lEBQzGoW5uJcvMW/U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lZ41PadGlYGqApUjwlgpAoL85dsAVu8cZqohL2AMAJuoIj01UqafdsiJ/oPfAL3VV
         rDGVKZ8dZvLurv6vJUJgR7Up22+6Rg77cDwMY0QkM7GqbQHDBXA+byYjRBes1QbIEz
         6xcULKJoX618oxUmb0iCkR0SbYwB9HQD1eFqvVus=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200117061043eucas1p2c09d4396ff10f6dbc79c96f34208c712~ql7nORAld0919209192eucas1p2M;
        Fri, 17 Jan 2020 06:10:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A0.00.60679.3EF412E5; Fri, 17
        Jan 2020 06:10:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200117061043eucas1p1783321b0e0c1447350bed76aa13e06db~ql7mr71v80895908959eucas1p1k;
        Fri, 17 Jan 2020 06:10:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200117061043eusmtrp2e53fd1060d6415ffaf5ffed2443b11fc~ql7mrVnCk3019830198eusmtrp2V;
        Fri, 17 Jan 2020 06:10:43 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-31-5e214fe37512
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.9D.07950.2EF412E5; Fri, 17
        Jan 2020 06:10:42 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200117061042eusmtip15f3a7df5ef6055c40f4eb694d69c48d4~ql7mRvz8q3055330553eusmtip1Q;
        Fri, 17 Jan 2020 06:10:42 +0000 (GMT)
Message-ID: <7037771c6aaa7b72a41e33c621d4e0c6db7758ca.camel@samsung.com>
Subject: Re: [PATCH v4 0/3] interconnect: Support Samsung Exynos use-case
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     georgi.djakov@linaro.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, krzk@kernel.org
Date:   Fri, 17 Jan 2020 07:10:41 +0100
In-Reply-To: <95ac808c-aacf-8ca8-94a7-98bbdb37b39d@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7qP/RXjDB4tVbbYOGM9q8X1L89Z
        Labv3cRmcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5nHn2h42j74tqxg9Pm+S
        C2CJ4rJJSc3JLEst0rdL4Mro/7KJteC0RMWh3ZeZGhj3C3cxcnJICJhInD/2iqmLkYtDSGAF
        o0TT2jPMEM4XRokP99ZAOZ8ZJc7/XsUO03LkVhM7RGI5o8SR089YQRJCAs8YJfpviIDYvAIe
        Ejt/L2MEsYUFPCW+/7vABmKzCdhLnL39DWyfiEAro0TvqydgU5kFkiW2zr3IAmKzCKhKdK77
        DxbnBGp4vOw4I8RmHYm3p/qAajiAFghK/N0hDNEqL9G8dTbYpRICy9glJt85AnWpi8SDf4+Y
        IGxhiVfHt0DFZST+75wPFS+WeLrzPitEcwOjxKZlR5ghEtYSd879YgNZxiygKbF+lz6IKSHg
        KLF9XRCEySdx460gxAl8EpO2TWeGCPNKdLQJQZhKErtm8kGMk5BoWn0NarSHxJ4bi1kmMCrO
        QnhlFpJXZiEsXcDIvIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwyZz+d/zLDsZdf5IO
        MQpwMCrx8M4IUogTYk0sK67MPcQowcGsJMJ7coZsnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
        40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MmyNnFJtfPR1QJjZVwOig/PHVM4qCdz8/3j7vQWjR
        9IAF4ooP7r1hXZr5zPjXxOa4Hjmro3u7pDZ75DDaWp9fcUk8wyZslarsZpnTK7sP87q8t0vZ
        qh1t2beW9dty3udPz04IuLLiXPaR19Khh5tf9U6a8iTyZk286HzeY9o3Z+s/X39061Y5DyWW
        4oxEQy3mouJEACh8WeQuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7qP/BXjDE48tLHYOGM9q8X1L89Z
        Labv3cRmcf78BnaLy7vmsFl87j3CaDHj/D4mi7VH7rI7cHhsWtXJ5nHn2h42j74tqxg9Pm+S
        C2CJ0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mvo
        /7KJteC0RMWh3ZeZGhj3C3cxcnJICJhIHLnVxN7FyMUhJLCUUaL7zCFGiISExMf1N1ghbGGJ
        P9e62CCKnjBKPJw4HSzBK+AhsfP3MrAGYQFPie//LrCB2GwC9hJnb39jArFFBNoYJU5u0gKx
        mQVSJO72zGIGsVkEVCU61/1nB7E5geofLzvOCLHgOKPEop1XmCAaNCVat/9mh7hCR+LtqT6W
        LkYOoMWCEn93CEOUyEs0b53NPIFRcBaSjlkIVbOQVC1gZF7FKJJaWpybnltspFecmFtcmpeu
        l5yfu4kRGEPbjv3csoOx613wIUYBDkYlHt4ZQQpxQqyJZcWVuYcYJTiYlUR4T86QjRPiTUms
        rEotyo8vKs1JLT7EaAr0z0RmKdHkfGB855XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnN
        Tk0tSC2C6WPi4JRqYDzxc4f6N05hdZ9sbeWtB88/Oma5+Nnlq+orJ9xc+qb3Zaiv65yknB9p
        7g+C5r2wClNq0k+WFTUQOrfh7G9G1/8GCmznPneclbwc3nRHbuLdNba7RVYen71MeVZhTt3p
        89P6N6XJ1d83ZRM782+/yG69oP3y1pczrzs/nfGIQ2aCQC1Lzmuec7xKLMUZiYZazEXFiQBB
        xFQltwIAAA==
X-CMS-MailID: 20200117061043eucas1p1783321b0e0c1447350bed76aa13e06db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff
References: <CGME20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff@eucas1p2.samsung.com>
        <20200116144202.12116-1-a.swigon@samsung.com>
        <95ac808c-aacf-8ca8-94a7-98bbdb37b39d@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On Fri, 2020-01-17 at 14:31 +0900, Chanwoo Choi wrote:
> Hi Artur,
> 
> I'm concerned about that make it the separate series
> without use-case like exynos-bus, exynos-drm.
> If this series is applied to v5.6, it doesn't make
> the problem and the patches for exynos-bus/exynos-drm
> will be reviewed and then merged on later kernel version.
> 
> But, if not, the interconnect, exynos-bus and exynos-drm
> patches should be merged into the same kernel version,
> it must require the immutable branch among interconnect,
> devfreq and exynos-drm. I think that you need to consider
> it between different subsystems.

Thanks for the feedback. Due to the fact that the RFC depends
on the proposed changes to the interconnect framework, I need
to ensure that these three patches come first.

If there is any disagreement over any of these three patches,
the rest of the RFC might need to be modified. In such case,
I will update the RFC and send the rest of v4 patches (for
exynos-bus, exynos-mixer, and probably also exynos5-dmc).

> On 1/16/20 11:41 PM, Artur Świgoń wrote:
> > Previously posted as a part of a larger RFC: [1].
> > 
> > The Exynos SoC family relies on the devfreq driver for frequency
> > scaling. However, a way to programmatically enforce QoS contraints
> > (i.e., minimum frequency) is desired. A solution which uses the
> > interconnect framework to ensure QoS is currently being developed[1].
> > 
> > The exynos-bus hierarchy is composed of multiple buses which are probed
> > separately. Sometimes the DMC is even handled by a different driver.
> > Since the exynos-bus driver is generic and supports multiple differing
> > bus hierarchies, IDs for nodes (i.e. buses) are assigned dynamically. Due
> > to the unspecified relative probing order, every bus registers its own
> > interconnect provider.
> > 
> > Rationale for each patch in this series:
> > * Patch 01 (exporting of_icc_get_from_provider()) makes it easy to
> >   retrieve the parent node from the DT (cf. patch 05 in [1]).
> > * Patch 02 (allowing #interconnect-cells = <0>) allows to remove dummy
> >   node IDs from the DT.
> > * Patch 03 (allowing inter-provider node pairs) is necessary to make
> >   such multi-provider hierarchy work. A new approach implemented in v3
> >   ensures not to break any existing drivers.
> > 
> > ---
> > Changes since v3 (to patches in this series):
> > * Improve commit messages.
> > 
> > ---
> > Artur Świgoń
> > Samsung R&D Institute Poland
> > Samsung Electronics
> > 
> > ---
> > References:
> > [1] https://patchwork.kernel.org/patch/11305287/
> > 
> > Artur Świgoń (3):
> >   interconnect: Export of_icc_get_from_provider()
> >   interconnect: Relax requirement in of_icc_get_from_provider()
> >   interconnect: Allow inter-provider pairs to be configured
> > 
> >  drivers/interconnect/core.c           | 16 ++++++++--------
> >  include/linux/interconnect-provider.h |  8 ++++++++
> >  2 files changed, 16 insertions(+), 8 deletions(-)
> > 
> 
> 
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


