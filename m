Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0E12D827
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLaLDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 06:03:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46547 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfLaLDq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 06:03:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191231110343euoutp021c63494d1ab749c83c29827834462827~lb9lgnA2w1799717997euoutp02_
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2019 11:03:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191231110343euoutp021c63494d1ab749c83c29827834462827~lb9lgnA2w1799717997euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577790223;
        bh=7+Bzmj/1YS4mP/XOTfqoL6jacDPrLgYgX5Dda/QTWHw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BVropltxRsZN3ZbwTq+m3PNfg0dIYlPSJKB2mWulBCfR5C2+31+pbpZcTq/vKj3MH
         yyXGRJ8hg4eZu+RrnSSX5eW7z3Uqdpl6eX5udG+hq0kNfHPCK2unMMI+RqKtZiwfNb
         cb7f0NlVodvQSDaXsjB/Dpxf1w8Mw5wjHtjME3hE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191231110343eucas1p126de462c8e6ced3397b47d8ddbaa09a7~lb9lI1MqD2384623846eucas1p1i;
        Tue, 31 Dec 2019 11:03:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.DF.61286.F0B2B0E5; Tue, 31
        Dec 2019 11:03:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191231110343eucas1p2211c47c3442b4397e051836cc39e11a1~lb9ky991Q3033530335eucas1p2v;
        Tue, 31 Dec 2019 11:03:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191231110343eusmtrp10fc8459914b75e6b325bb7c10db35ecc~lb9kyPA_02466224662eusmtrp1Y;
        Tue, 31 Dec 2019 11:03:43 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-d3-5e0b2b0f11d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.38.08375.E0B2B0E5; Tue, 31
        Dec 2019 11:03:42 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191231110342eusmtip1b4cd2129514c914c87bc8fd50997103a~lb9j-nB6N1319413194eusmtip13;
        Tue, 31 Dec 2019 11:03:42 +0000 (GMT)
Message-ID: <e364f979ad6b07a53f19fd25883e4d39e28c37be.camel@samsung.com>
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        Inki Dae <inki.dae@samsung.com>,
        Seung Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Date:   Tue, 31 Dec 2019 12:03:41 +0100
In-Reply-To: <CAJKOXPezRMb0OnpcRWrRheKbBjyzqNXG3TDX-MQkjAm2sTSr1w@mail.gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3cuO66mp2ntyYXVpA9qm0kKB4q06HKiPiQUQZi26mCRW7HT
        KoNoFYmXMknDNTXTaol5yZPaWpcPQzQqXVcNNhsVXYym5Swrs9o8k/r2f//P83v+zwMvhSke
        EtHULsM+zmjQ5ahJGd7e+cOliUiYmrmwpULJtFiaCaZv5D3BVHf0EMyzr0MkU35HIJkz3hKc
        cbmuSZm6/i8EI7zpJZinjkqS8Z/qQIzFdVfCNHb0Sxn30TqSsZQOkGkRrFBfQLKe3tsk6y3q
        krDXLx1hWwbtEra4tR6xfiFmvXSzbMkOLmfXfs6YuHSrbKfl1Fm0t0xzcMT7ATejothCFEYB
        nQxCTZskqBV0HYJ3no2FSBbQIwg+d55A4sOPoEZwSyeJqqHzhEhcQTDgiRGb3iFwNjRiwYKc
        ZuGKuwIP6kg6A6zfvRMwSadCt/vbRFwUHQd946NEEMboVzjc6B+bKOD0fOh+JMJhdDq4i/Nw
        MXkB+O4XBzQVCJgO4/bIoI3Rc+B4WwUWnAO0TwovBipD/Svges8vTNSR8LGrNXTBbHhQejLU
        w8Pbm15ChM0IBFtHCFgMnp6fZDAMC2za7EgU7WXQNlokCdpAh8ML33Rxh3A4016OibYc8vMU
        olSD41y4CAIcu9obms3C40sFRAmaZ/13i/W/W6z/Ui8grB4pOROvz+b4JAN3QMvr9LzJkK3d
        vkcvoMAfe/C7a9iOvj7Z5kQ0hdTT5PlTZJkKQrefz9U7EVCYOkqenBGWqZDv0OUe4ox7soym
        HI53IhWFq5XyRbUDWxR0tm4ft5vj9nLGyaqECos2o4vVSVWJw4P6mQlc2qfiWkLbvUZj86ui
        +j1HNK0J5xsMQw2XRwujVx+tYh3tbtk9p9retI7QLlsVIR3esjLlNWFJtfhOq2rHmojnt8yb
        Kmek5M8ZvE2V2ZbH3jW/LHiu+rK2e4Yt3VVSMFcbrryzYciflRtvWjDrcHxa5+uMuD9qnN+p
        S4rHjLzuL9TdYeVfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7p82txxBt2HbCw2zljPanH9y3NW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMaN3
        KmPBFN2KL/dfsDQwdit3MXJySAiYSMx9P4+1i5GLQ0hgKaPEqQe3WSESEhIf19+AsoUl/lzr
        YoMoesIo8XnRdUaQBK+Ah8Ty27NZQGxhgRiJWT/us4PYbAL2Emdvf2MCsUUENCWu//0OtoFZ
        4BGLxNvOy2ANLAKqEmcvQDRzCgRK3O5rY4HYMJ9FYs/My2CrmYG6W7f/Zoc4Q0fi7ak+oCIO
        oM2CEn93CEOUyEs0b53NPIFRcBaSjlkIVbOQVC1gZF7FKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGKfbjv3cvIPx0sbgQ4wCHIxKPLwPmLjihFgTy4orcw8xSnAwK4nwmsRwxgnxpiRWVqUW
        5ccXleakFh9iNAX6ZyKzlGhyPjCF5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0t
        SC2C6WPi4JRqYNSwfhPJ8lCg7dQ2l3upE3uNfosUL2Tq1bu+MYa78q4506X7XaEXLYrUolee
        3yvzxPke16YSx+IzTwIlp78QePxWZN3eomM9gu+2Ct3UDlR/m/43YOLNtGkh6y6ILpx9+0zh
        h7feh1lmVR0uFjN9KqCbHaGsm9Cjda/71yrO4Ox/bQFvbosHxSuxFGckGmoxFxUnAgDEb1vn
        6QIAAA==
X-CMS-MailID: 20191231110343eucas1p2211c47c3442b4397e051836cc39e11a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
        <20191220115653.6487-5-a.swigon@samsung.com> <20191230154405.GC4918@pi3>
        <2922135223b01126277ef92a53e6b294bc17bb5c.camel@samsung.com>
        <20191231092254.GA6939@pi3>
        <99427c18b1fcca3bc21e69609500abdbbef59167.camel@samsung.com>
        <20191231100234.GA7024@pi3>
        <29ed54c7700e35fb95fff4f4f5580eba24ffbb35.camel@samsung.com>
        <CAJKOXPezRMb0OnpcRWrRheKbBjyzqNXG3TDX-MQkjAm2sTSr1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-12-31 at 11:38 +0100, Krzysztof Kozlowski wrote:
> On Tue, 31 Dec 2019 at 11:23, Artur Świgoń <a.swigon@samsung.com> wrote:
> > > 
> > > The order of patches should reflect first of all real dependency.
> > > Whether it compiles, works at all and does not break anything.  Logical
> > > dependency of "when the feature will start working" is
> > > irrelevant to DTS because DTS goes in separate way and driver is
> > > independent of it.
> > 
> > The order of patches does indeed reflect real dependency. I can also reorder
> > them (preserving the dependencies) so that DTS patches go first in the series
> > if this is the more preferred way.
> 
> It looks wrong then. Driver should not depend on DTS. I cannot find
> the patch changing bindings (should be first in patchset) which could
> also point to this problem.
> 
> It seems you added requirement for interconnect properties while it
> should be rather optional.

No, there is no requirement for interconnect properties (other than that it
simply does not make any sense to use the interconnect driver code and not the
DTS properties for it in the long run).

In case of the exynos-bus driver (code: patch 05, DTS: patch 04) if the DTS
properties ('exynos,interconnect-parent-node') are missing, the new code handles
it gracefully returning NULL from exynos_bus_icc_get_parent() (it is not an
error condition).

In case of the exynos-mixer driver (code: patch 07, DTS: patch 06) if the DTS
property ('interconnects') is missing, of_icc_get() returns NULL and the code does
not try to set any contraints for a NULL path. Same thing happens if
CONFIG_INTERCONNECT is 'n'.

The only case when something breaks is when you try to use the interconnect
consumer (implemented in patches 06 & 07) when there is no interconnect provider
(patches 04 & 05), in which case of_icc_get() returns an error (since it cannot
find a path). From what I understand, it probably makes sense to merge any
interconnect consumers one cycle later than the provider.

> > > > I still think the order of these patches is the most logical one for someone
> > > > reading this RFC as a whole.
> > > 
> > > I am sorry but it brings only confusion. DTS is orthogonal of the
> > > driver code. You could even post the patchset without DTS (although then
> > > it would raise questions where is the user of it, but still, you
> > > could).
> > > 
> > > Further, DTS describes also hardware so you could send certain DTS
> > > patches without driver implementation to describe the hardware.
> > > 
> > > Driver code and DTS are kind of different worlds so mixing them up for
> > > logical review does not really make any sense.
> > > 
> > > Not mentioning it is different than most of other patches on mailing
> > > lists.
> > > 
> > > BTW, it is the same as bindings which should (almost) always go first as
> > > separate patches.
> > 
> > Thanks for elaborating on this, I appreciate it.
> > Regarding your original concern, patches 04 & 06 are separate for several
> > reasons, one of which is that they are related to two different drivers
> > (exynos-bus vs. exynos-mixer).
> 
> It's okay then (for them to be split).
> 
> > 
> > > > 
> > > > > In certain cases dependency on DTS changes is ok:
> > > > > 1. Cleaning up deprecated properties,
> > > > > 2. Ignoring the backward compatibility for e.g. new platforms.
> > > > > 
> > > > > None of these are applicable here.
> > > > > 
> > > > > You need to rework it, put DTS changes at the end. This clearly shows
> > > > > that there is no wrong dependency.
> > > > > 
> > > > > > 
> > > > > > > Adjust the title to match the contents - you are not adding bindings but
> > > > > > > properties to bus nodes. Also the prefix is ARM: (look at recent
> > > > > > > commits).
> > > > > > 
> > > > > > OK.
> > > > > > 
> > > > > > > > 
> > > > > > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > > > index 4ce3d77a6704..d9d70eacfcaf 100644
> > > > > > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > > > @@ -90,6 +90,7 @@
> > > > > > > >  &bus_dmc {
> > > > > > > >     exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> > > > > > > >     vdd-supply = <&buck1_reg>;
> > > > > > > > +   #interconnect-cells = <0>;
> > > > > > > 
> > > > > > > This does not look like property of Odroid but Exynos4412 or Exynos4.
> > > > > > 
> > > > > > Strangely enough, this file is where the 'exynos,parent-bus' (aka. 'devfreq')
> > > > > > properties are located (and everything in this RFC concerns devfreq).
> > > > > 
> > > > > I cannot find exynos,parent-bus in exynos4412-odroid-common.dtsi. Can
> > > > > you elaborate?
> > > > 
> > > > Currently a name change is being made: 'devfreq' -> 'exynos,parent-bus'
> > > > https://patchwork.kernel.org/patch/11304549/
> > > > (a dependency of this RFC; also available in devfreq-testing branch)
> > > 
> > > I see. That property also does not look like board (Odroid) specific so
> > > it should be moved to Exynos4412 DTSI.
> > 
> > Makes sense to me. Just from looking at the patch I referenced above, there is
> > a significant level of code duplication between
> > * arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> > * arch/arm/boot/dts/exynos4412-midas.dtsi
> > * arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > with relation to the devfreq*/exynos,* properties.
> 
> If you have in mind all the nodes with "status=okay", it's fine to
> duplicate them.
OK.

Regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


