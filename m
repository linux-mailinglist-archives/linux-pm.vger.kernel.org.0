Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA41244DB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLRKl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:41:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47277 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfLRKl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 05:41:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191218104157euoutp027dd452baa7e0f8547bd8bfbc10e5b155~hcR3P5eNk2274822748euoutp02v
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2019 10:41:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191218104157euoutp027dd452baa7e0f8547bd8bfbc10e5b155~hcR3P5eNk2274822748euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576665717;
        bh=Sxav5XdUuDNJs7Nh+FfUteZxECChMUkMQvjWcB/cqHs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CtAT4jvVcJ7/Y4kliXgiQnt6LIQS/eDQJi94vlwvmb1nHvliXw25KtuvhB++xp6TH
         z+o3T9pA8U2j0mx+sM7VwnHjrn7gDKk/v0+iw8NJnlEBVN2xOq98fXxqylEBXkY576
         gk9+YWqX6z8xFbTnuAFkG30QT0FQYbGlMq/4vRBo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191218104157eucas1p277d37f84989ba383582145d3251b377b~hcR2487XC2587625876eucas1p2l;
        Wed, 18 Dec 2019 10:41:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.C8.60679.4720AFD5; Wed, 18
        Dec 2019 10:41:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191218104156eucas1p263ec61eeadbfcde28c2a1943bd056cc2~hcR2RfokS2651926519eucas1p2B;
        Wed, 18 Dec 2019 10:41:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191218104156eusmtrp24d855852c19e6a2c772002de7ca53893~hcR2Ql8Q50735107351eusmtrp2J;
        Wed, 18 Dec 2019 10:41:56 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ab-5dfa027459d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.5F.08375.4720AFD5; Wed, 18
        Dec 2019 10:41:56 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191218104155eusmtip11ec6b8e60f79079b8e0777fe9af237bb~hcR1noTQ62671826718eusmtip1T;
        Wed, 18 Dec 2019 10:41:55 +0000 (GMT)
Message-ID: <803d0920cf24eb9b4c87bb1d5e894cc3c9c88e72.camel@samsung.com>
Subject: Re: [RFC PATCH v2 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Dec 2019 11:41:55 +0100
In-Reply-To: <CAGTfZH1=gk1jm4wmX+xMZfkrPR_UDumaDEfmddrpbig4VnN8FQ@mail.gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTte9s8p548R8mLhtFImm1jJfSiRYt+vPBPRRIIZmM91HKpeWoZ
        kSuihqbTDycLjai0sVwmFTVtmdShtAYZHQszCbHSNB03MFxyfBP279xzz7nnXrg0rugiPejo
        uARBE6eOUVJyor59zrwjAfsT5m/7uY+r0VWRXOGnboLrnf5BcqWtH0mue2ac4opaDBSnHSgg
        OLO5WsaV99tIzjBoJTlL0z2Km8prRZzO/BLjnrX2y7i+tHKK090epoJY3qDPofgv1maKH7hp
        wvjnD1P4mt8NGJ9fq0f8lMHruCxUfuC8EBOdJGhUh87Kox5pB7FLaUFXv1lLsFRUuS0XOdHA
        BkCn0YJykZxWsOUI3mXUkFIxjWBqaByTiikEL8tsxD9LfWapw1KGoL2tmpCK7wh0aVZkVzEs
        DxU9oyvYlY2E3pxJzI4pNhA+9M2uYDd2M1RPtq/k4WwhCeX1i8sGmiaWG5aW9XaNE3sCDG/e
        YlLydhh7n0/YJQzrAgsNrnYaZzdCRt1dXJLMyMBS6C3ho/D6lkkmYVcYMdU68AZYaix1jBRh
        qHFgZQVgUxEYHrc6Bu2Ht6Yu0p6Fs35Q1aSS6MOQ9bRIZqeBdYZPYy7SCs6grS/CJZqB7CyF
        BJXQdMdZMgKkV1gds3mYyenECtCm4tVTiv87pXg19T7C9chdSBRjIwVxd5xwZaeojhUT4yJ3
        nouPNaDlR+tYNE03oKb5CCNiaaRcx/ivmQtTkOokMTnWiIDGlW5MX/YyxZxXJ18TNPHhmsQY
        QTQiT5pQujN7HgyHKdhIdYJwURAuCZp/XYx28khFwZ3aAOfs7Ccm98ALQsdkpv/riYnwR3Vz
        TDx6VeJu9Wm2+aavqbjenaE/ol+7cCoorznUJ3x2S1txoidWd/mzuWTpa8+2+YQzqsqTvDzT
        +ONcnapZGDzWorOpXliCvTxa9o6OhEQ8qNXy35NTQoqGfU+HLI7MMd5+xK/ogzc065WEGKXe
        tRXXiOq/6KutBWQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7olTL9iDe5/FbbYOGM9q8XEG1dY
        LK5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3WHH3I6vFpsfXWC0u75rDZvG59wij
        xYzz+5gs1h65y25xu3EFm8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1HtsfLeDyaNvyypG
        j8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQylk56zFTQ6FDx8No8pgbGddpdjJwcEgImEtta5jN2MXJxCAksZZQ4/gHEAUlISHxcf4MV
        whaW+HOtiw2i6AmjxKW+sywgCV4BD4nVV9+ANQgLpEtc7/zEBGKzCdhLnL39DcwWEVCV2PDp
        GCtIM7PARFaJw/sfAU3i4GABSlzeKwZSwykQKLHp4GEmiAUbmSW6Xm1kBkkwC2hKtG7/zQ5x
        hY7E21N9LCC9vAKCEn93CEOUyEs0b53NPIFRcBaSjlkIVbOQVC1gZF7FKJJaWpybnltsqFec
        mFtcmpeul5yfu4kRGK/bjv3cvIPx0sbgQ4wCHIxKPLwGDD9jhVgTy4orcw8xSnAwK4nw3u4A
        CvGmJFZWpRblxxeV5qQWH2I0BXpnIrOUaHI+MJXklcQbmhqaW1gamhubG5tZKInzdggcjBES
        SE8sSc1OTS1ILYLpY+LglGpg1NOrkA4wOzzpvECl9eFWnnamc60Vp6OCrY9ZTLO58CLg/unM
        T2qT/4s6pdccSrtaHWen0XpT4KiOZ0509FmFVt65bWc9/l/4t8lJ6eiVZb3f8qac3dj97CSH
        QdXiTVvZzTtWr3msKb3jZvOpZqkGlUfL8tUTNZPbl/WLBF+4Vv/II6g8Km+hEktxRqKhFnNR
        cSIAJXEZIu0CAAA=
X-CMS-MailID: 20191218104156eucas1p263ec61eeadbfcde28c2a1943bd056cc2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p299762f99dd55a5d625633ceec84219f9@eucas1p2.samsung.com>
        <20190919142236.4071-9-a.swigon@samsung.com>
        <693e250d-9656-df67-9685-188020b43542@samsung.com>
        <eecc5d38-f6ab-b1ea-1a08-0afb2dcddbef@samsung.com>
        <2008dca684ccb1dd740e6e6b88e56727d0d1c435.camel@samsung.com>
        <CAGTfZH1=gk1jm4wmX+xMZfkrPR_UDumaDEfmddrpbig4VnN8FQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-18 at 19:29 +0900, Chanwoo Choi wrote:
> Hi
> 
> 2019년 12월 18일 (수) 오후 7:18, Artur Świgoń <a.swigon@samsung.com>님이 작성:
> > 
> > Hi,
> > 
> > On Mon, 2019-12-16 at 11:59 +0900, Chanwoo Choi wrote:
> > > Hi,
> > > 
> > > On 12/16/19 9:51 AM, Chanwoo Choi wrote:
> > > > On 9/19/19 11:22 PM, Artur Świgoń wrote:
> > > > > From: Artur Świgoń <a.swigon@partner.samsung.com>
> > > > > 
> > > > > This patch adds two fields to the Exynos4412 DTS:
> > > > >   - parent: to declare connections between nodes that are not in a
> > > > >     parent-child relation in devfreq;
> > > > >   - #interconnect-cells: required by the interconnect framework.
> > > > > 
> > > > > Please note that #interconnect-cells is always zero and node IDs are not
> > > > > hardcoded anywhere. The above-mentioned parent-child relation in devfreq
> > > > > means that there is a shared power line ('devfreq' property). The 'parent'
> > > > > property only signifies an interconnect connection.
> > > > > 
> > > > > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
> > > > >  arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
> > > > >  2 files changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > index ea55f377d17c..bdd61ae86103 100644
> > > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > @@ -106,6 +106,7 @@
> > > > >  &bus_leftbus {
> > > > >   devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> > > > >   vdd-supply = <&buck3_reg>;
> > > > > + parent = <&bus_dmc>;
> > > > 
> > > > As I mentioned on other reply,
> > > > I'm not sure to use the specific 'parent' property to make
> > > > the connection between buses. If possible, you better to
> > > > use the standard way like OF graph. Except for making
> > > > the connection between buses by 'parent' property,
> > > > looks good to me.
> > > 
> > > I tried to think it continuously. I withdraw the my opinion
> > > using OF graph. If you make the property name like the following
> > > example, it is possible for exynos.
> > > - exynos,interconnect-parent-node = <&bus_dmc>; or other proper name.
> > > 
> > > Regardless of existing 'devfreq' property, I think you better to
> > > make the connection between buses for only interconnect as following
> > > example: This make it possible user can draw the correct tree by tracking
> > > the 'exynos,interconnect-parent-node' value.
> > 
> > OK, for v3 I will add 'exynos,interconnect-parent-node' to bus_dmc,
> > bus_leftbus and bus_display as you suggested below and change the code
> > so that the 'devfreq' (or the upcoming 'exynos,parent-bus') property is
> > not taken into account.
> 
> I'd like you to make the v3 based on my patches[1]
> [1]  https://protect2.fireeye.com/url?k=3fbd62a4-6276e59a-3fbce9eb-0cc47a31309a-5329151b98fc2653&u=https://lkml.org/lkml/2019/12/17/21
> - [PATCH 0/9] PM / devfreq: Remove deprecated 'devfreq' and
> 'devfreq-events' properties
> 
> I uploaded the patches to devfreq-testing branch[2]
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

OK.

> 
> > 
> > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > index ea55f377d17c..53f87f46e161 100644
> > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > @@ -90,6 +90,7 @@
> > >  &bus_dmc {
> > >         devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> > >         vdd-supply = <&buck1_reg>;
> > > +       #interconnect-cells = <0>;
> > >         status = "okay";
> > >  };
> > > 
> > > @@ -106,6 +107,8 @@
> > >  &bus_leftbus {
> > >         devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> > >         vdd-supply = <&buck3_reg>;
> > > +       exynos,interconnect-parent-node = <&bus_dmc>;
> > > +       #interconnect-cells = <0>;
> > >         status = "okay";
> > >  };
> > > 
> > > @@ -116,6 +119,8 @@
> > > 
> > >  &bus_display {
> > >         devfreq = <&bus_leftbus>;
> > > +       exynos,interconnect-parent-node = <&bus_leftbus>;
> > > +       #interconnect-cells = <0>;
> > >         status = "okay";
> > >  };
> > > 
> > > 
> > > > 
> > > > 
> > > > >   status = "okay";
> > > > >  };
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> > > > > index d20db2dfe8e2..a70a671acacd 100644
> > > > > --- a/arch/arm/boot/dts/exynos4412.dtsi
> > > > > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > > > > @@ -390,6 +390,7 @@
> > > > >                   clocks = <&clock CLK_DIV_DMC>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_dmc_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -398,6 +399,7 @@
> > > > >                   clocks = <&clock CLK_DIV_ACP>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_acp_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -406,6 +408,7 @@
> > > > >                   clocks = <&clock CLK_DIV_C2C>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_dmc_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -459,6 +462,7 @@
> > > > >                   clocks = <&clock CLK_DIV_GDL>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_leftbus_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -467,6 +471,7 @@
> > > > >                   clocks = <&clock CLK_DIV_GDR>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_leftbus_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -475,6 +480,7 @@
> > > > >                   clocks = <&clock CLK_ACLK160>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_display_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -483,6 +489,7 @@
> > > > >                   clocks = <&clock CLK_ACLK133>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_fsys_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -491,6 +498,7 @@
> > > > >                   clocks = <&clock CLK_ACLK100>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_peri_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > @@ -499,6 +507,7 @@
> > > > >                   clocks = <&clock CLK_SCLK_MFC>;
> > > > >                   clock-names = "bus";
> > > > >                   operating-points-v2 = <&bus_leftbus_opp_table>;
> > > > > +                 #interconnect-cells = <0>;
> > > > >                   status = "disabled";
> > > > >           };
> > > > > 
> > > > > 

-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


