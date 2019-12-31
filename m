Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41012D6CB
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 08:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLaHSH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 02:18:07 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45788 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLaHSH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 02:18:07 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191231071805euoutp0201743b60f9d9a3bd94a50156d1902ce7~lY4kf55eF1291212912euoutp02Y
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2019 07:18:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191231071805euoutp0201743b60f9d9a3bd94a50156d1902ce7~lY4kf55eF1291212912euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577776685;
        bh=mxgW3OjCblyLWNF7NbGsSeLkWkVFDm7ORlqp6ibSZIo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LSgRsQZJyvAH6wRuvs0J7oByWWrJAjeRLGCjkZse14yA0BUIOJUWf5GCj8tqoghV2
         YJ3TIadk6nI/U0AMOq4L65lpcHe8cEuignGUbaVNEftIKMJXlms6rD/sHjBxbPum9W
         U8ADf6FxAJLPKoQA8UIWi54sCywtlyRrnVpKE7no=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191231071804eucas1p2ed176f4b629c2512ef25751c808b001b~lY4kJodxc1217212172eucas1p2B;
        Tue, 31 Dec 2019 07:18:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 67.4F.61286.C26FA0E5; Tue, 31
        Dec 2019 07:18:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191231071803eucas1p1f40c18c6a3fe31647f77f96b9b8aff3d~lY4i_Szi01248012480eucas1p1b;
        Tue, 31 Dec 2019 07:18:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191231071803eusmtrp15bcc547f61e3c63b562bb6ebe9d437c0~lY4i9g7hY0485704857eusmtrp1Y;
        Tue, 31 Dec 2019 07:18:03 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-9f-5e0af62c9e6e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.A9.08375.B26FA0E5; Tue, 31
        Dec 2019 07:18:03 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20191231071802eusmtip282c6a233e34aa05f9bff3892bef303ea~lY4iNOMhH2926629266eusmtip20;
        Tue, 31 Dec 2019 07:18:02 +0000 (GMT)
Message-ID: <2922135223b01126277ef92a53e6b294bc17bb5c.camel@samsung.com>
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Date:   Tue, 31 Dec 2019 08:18:01 +0100
In-Reply-To: <20191230154405.GC4918@pi3>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3Zfdh1Or1vgwUJpYmWYZondMNKiDxf6Yl/6EGqtvPi+ateX
        DEJTMnUqplE6A8Wkhk6m86VNM0OmCzWnFS5S0V5MDHSopRZYbV7Fvv3O/znn/P8HHgqTDRE+
        VJIqnVOrlKkKUoJ3DvyyHQ5alcQdsb9SMK1VBoKx/5gjmFrLCMG8/+kgmUc9RpKpmC7HGZut
        RczoppYIxvhlnGDedT0mmZVSC2KqbC9FTLNlSsxM3NGRTFXlPBnlyRobi0h2cvwFyU5rrCK2
        rSGHbV00idiy9kbErhh9o8UXJSfjudSkTE4dcuqyJLG/Kw+/3im/WVndLcpFM57FyI0COgys
        +flYMZJQMlqHYNa0JBKKHwhsmhpSKFYQLOrK8e2R4naNyMUy+hmCJotK4G8I7DPnXSylWRh9
        fhe5WE7HgHZ9Wuxiko6ENxOrm7O76UCwb6wRLgOMfoDBqGZ0swmnA0DfY9s0c6MPQlVeNykY
        B8HCYJlTp5wGXrBhkrtkjPaD/I4aTGhZEsNwYaLAZ+GvtWwrsxy+W9vFAu+FocqSLZ2HWfP0
        ZgagcxEYn1q2FkXA5Mhv0uWFOYMaukIE+TR0rLlup5zsAR8WvIQIHlDR+QgTZCkUFsgEVEBX
        tYcwCJDXNL61m4WxhiKiHO3T7pyi/e8U7Y5rHcIakTeXwaclcHyoissK5pVpfIYqIfjqtTQj
        cn6xoT/WZRP6+fZKH6IppHCXFu6SxMkIZSafndaHgMIUu6VhMW5xMmm8MvsWp752SZ2RyvF9
        aA+FK7ylx+rnY2V0gjKdS+G465x6+1VEufnkouZMtqHu9SI8iUgZzCxTG2g28n6HMvpE+DBd
        vEzK/f18a1Zr5/bnmNqmRMfP6Nxbey/0Hph9KDu3PmPW36u3fy6s/jQ8UfI10pwSU5pMmtu7
        +fqAhx/1UQZcv4w71h2c1tFb4H8jucXQG3iUl1TE5mkGmhIc4f1mz3dZY7cVOJ+oDD2EqXnl
        P37/AKBeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7ra37jiDLY3i1psnLGe1eL6l+es
        FvOPnGO1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2ixV3P7JabHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3Hxnc7mDz6tqxi9Pi8SS6A
        PUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+iu
        JpaCbcIVk2fuZmpgfMDfxcjJISFgItG1pZupi5GLQ0hgKaPEsnXXmSESEhIf199ghbCFJf5c
        62KDKHrCKHFq6TNGkASvgIfEhe2tYLawQIzErB/32UFsNgF7ibO3vzGB2CICmhLX/34HG8Qs
        MJVZYvesABCbRUBVYs3e8ywgNqeAhsSMpt1sILaQwE1Gicn3VCHqNSVat/9mhzhCR+LtqT6g
        eg6gvYISf3cIQ5TISzRvnc08gVFwFpKOWQhVs5BULWBkXsUoklpanJueW2yoV5yYW1yal66X
        nJ+7iREYo9uO/dy8g/HSxuBDjAIcjEo8vA+YuOKEWBPLiitzDzFKcDArifCaxHDGCfGmJFZW
        pRblxxeV5qQWH2I0BXpnIrOUaHI+MH3klcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpgzP66/f6HJf9rs78fuTelYOGmW8W6bmnVAoYyO8Pj+vfE/MhawzPB76nw
        nC27AlPOH7e9WdcV8vi6S0TA6h4zbz7tSy/+b7DLWnLnz4mJwbpzZNQbGbZpXHvWcvdI15HV
        M7kS9STkFd7MfbWxIc5NVVTiXZnuynXPv4m8vrZI+fN002MGx4VOBimxFGckGmoxFxUnAgAs
        FhlB5wIAAA==
X-CMS-MailID: 20191231071803eucas1p1f40c18c6a3fe31647f77f96b9b8aff3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
        <20191220115653.6487-5-a.swigon@samsung.com> <20191230154405.GC4918@pi3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, 2019-12-30 at 16:44 +0100, Krzysztof Kozlowski wrote:
> On Fri, Dec 20, 2019 at 12:56:50PM +0100, Artur Świgoń wrote:
> > This patch adds the following properties to the Exynos4412 DT:
> >   - exynos,interconnect-parent-node: to declare connections between
> >     nodes in order to guarantee PM QoS requirements between nodes;
> >   - #interconnect-cells: required by the interconnect framework.
> > 
> > Note that #interconnect-cells is always zero and node IDs are not
> > hardcoded anywhere.
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> The order of patches is confusing. Patches 4 and 6 are split - do the
> depend on 5? I doubt but...

Let me elaborate:

The order of the patches in this series is such that every subsequent
patch adds some functionality (and, of course, applying patches one-by-one
yields a working kernel at every step). Specifically for patches 04--07:

 -- patch 04 adds interconnect _provider_ properties for Exynos4412;
 -- patch 05 implements interconnect provider logic (depends on patch 04);
 -- patch 06 adds interconnect _consumer_ properties for Exynos4412 mixer;
 -- patch 07 implements interconnect consumer logic (depends on patches
    05 & 06);

My reasoning is that this order allows to e.g., merge the interconnect
provider for exynos-bus and leave the consumers for later (not limited to
the mixer). I hope this makes sense.

> Adjust the title to match the contents - you are not adding bindings but
> properties to bus nodes. Also the prefix is ARM: (look at recent
> commits).

OK.

> > 
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > index 4ce3d77a6704..d9d70eacfcaf 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -90,6 +90,7 @@
> >  &bus_dmc {
> >  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> >  	vdd-supply = <&buck1_reg>;
> > +	#interconnect-cells = <0>;
> 
> This does not look like property of Odroid but Exynos4412 or Exynos4.

Strangely enough, this file is where the 'exynos,parent-bus' (aka. 'devfreq')
properties are located (and everything in this RFC concerns devfreq).

Regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


