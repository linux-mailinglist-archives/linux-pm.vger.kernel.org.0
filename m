Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FE12D7DC
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 11:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLaKXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 05:23:09 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41911 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLaKXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 05:23:05 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191231102303euoutp015446313020baf8037bbd7f2eaebfd6d7~lbaESEwkf0869108691euoutp01c
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2019 10:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191231102303euoutp015446313020baf8037bbd7f2eaebfd6d7~lbaESEwkf0869108691euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577787783;
        bh=wa+0vRXyiLRDiIsWEtqTDc/k5dC7lQT5/Cwx2rCbUiI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=giYViXcaoPVPVCpxw8v19M6NmMC1ZApIcJjBrOpt+sJoG6r4AXMHuoqh9omvOsP04
         5pDCTtANXlGKFDtiYw7XcCZKqPylDpoGjpyDzarkbu1DZLssGynrd92hoZqrVojbid
         xH5ucsEBDn63WIP7Q6eIt4CY0JXeUg7AhcjPTPpM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191231102302eucas1p13c0c38b38ed8a783376d5b6761e4ad13~lbaDxV7n81797217972eucas1p1v;
        Tue, 31 Dec 2019 10:23:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7C.0D.61286.6812B0E5; Tue, 31
        Dec 2019 10:23:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191231102302eucas1p2c93ec388a3a90051d519d7e169ff5776~lbaDep-KS0686506865eucas1p2i;
        Tue, 31 Dec 2019 10:23:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191231102302eusmtrp13f90c349956757c9b790a964abc004d4~lbaDd4kgE3047930479eusmtrp1F;
        Tue, 31 Dec 2019 10:23:02 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ae-5e0b218668f0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.B4.07950.6812B0E5; Tue, 31
        Dec 2019 10:23:02 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191231102301eusmtip14455cbb4a8108dcc7e987927d6e23d1b~lbaCsyqQU2440824408eusmtip1u;
        Tue, 31 Dec 2019 10:23:01 +0000 (GMT)
Message-ID: <29ed54c7700e35fb95fff4f4f5580eba24ffbb35.camel@samsung.com>
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
Date:   Tue, 31 Dec 2019 11:23:00 +0100
In-Reply-To: <20191231100234.GA7024@pi3>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj227nsbG12nIovJoaL7hcrRU/YnYhT/elHEZRZKw8qbUt21NI/
        zS6iLkVKcK1Cky5rUuqqYXYxZWkZTs02C5WhXUTLpGZphtWOx6h/z/c87/M87wsfhanaiHAq
        TZ/BGfQarZqU447mH67leVGzklZ2lc1has3VBNM9Nkgw5U4Xwbz6NkoyZY/sJHPOW4Iz7e01
        Usba94Vg7G89BNNVf4lkfEVOxJjbH0uYW84+KdOTayUZ8/khcuNs1m4rINlez0OS9ZpaJOyd
        qyfY2s91Erb4rg2xPnvkTule+dpkTpuWxRmi1x+Up054LuDpX1Yfn3zuwozIvbAQySigY6Hp
        yjgqRHJKRVsRuM9U4uJjDEHpswqp+PAhMJc/RX8to9UDElG4gaDV2YILgor+gGDkSbyAlTQL
        vtMFUgEH04lgmfBOY5LeAG093yUCDqEXQ/fUOCEEYXQpBh2mjukhnJ4PD1+PTYfK6EUw5SiS
        iM3LYKS12M9T/oIgmKoLFmiMngun7l3EhBygR6TQ2FojFee3wKipYcYbDMMtd2f4CHhx/iwu
        Yh7e3/cSotmIwH7diYlCAvS6JkmhDPNvWl0fLdKb4N64SSLQQAfC65EgcYdAOOcow0RaCfl5
        KhGqof5CoGgEOFnlmclmofNqAVGCoiz/brH8d4vlX2sFwmwojMvkdSkcv0rPHVvBa3R8pj5l
        xeGjOjvyf7IXv1q+1qFvLw81IZpCaoUyP0CepCI0WXy2rgkBhalDlLGJsiSVMlmTncMZjh4w
        ZGo5vgnNoXB1mDKmcmi/ik7RZHBHOC6dM/xVJZQs3IjKt7kduxTZebsXhMUE9/uaT51+EHCt
        8KYiZ2ln6M22rWTEybTLcZYq2mr2zt+8/tPvoIyDF432n+pQIqJUd7iApw6t666NXyPr6c9K
        2D6vKG6AlHl2JOSU7vm4Lmhf6q43tbbBlMiinMTNivyhs7c7u14qht3vOhoMuS7t82FjdqMa
        51M1q5ZgBl7zB3LkodVgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7ptitxxBn8vMFtsnLGe1eL6l+es
        FvOPnGO1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2ixV3P7JabHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3Hxnc7mDz6tqxi9Pi8SS6A
        PUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48e1
        mSwFH40qfp08x9zAeFW9i5GTQ0LAROL9+kdMXYxcHEICSxkl1n09yAaRkJD4uP4GK4QtLPHn
        WhcbRNETRon/n7cygyR4BTwkPrd0soPYwgIxErN+3Aez2QTsJc7e/sYEYosIaEpc//sdbBCz
        wFRmid2zAkBsFgFViT03vrCA2JwCGhJ/t/VCXTGdWeJEyxl2iAZNidbtv9khrtCReHuqD6iB
        A2ixoMTfHcIQJfISzVtnM09gFJyFpGMWQtUsJFULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn
        525iBEbptmM/t+xg7HoXfIhRgINRiYe3g4ErTog1say4MvcQowQHs5IIr0kMZ5wQb0piZVVq
        UX58UWlOavEhRlOgfyYyS4km5wMTSF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTU
        gtQimD4mDk6pBsZrH9kuT3djStThnvwylFtwwoW/UoLq7xRVL/L2qddWqvxq3t/x4/Els6Ia
        1bm2u16sdY9V1NFe/9l04qF03wWXRFqvqv/aPXftuZVJ+67d+Vktoh2R+iWM86tb2dY9HTIf
        EnjmcsktKRZ+xT/bxsLsueKk2tLEs+4Pfb6JCny+YWsYH7gsr1iJpTgj0VCLuag4EQDXG5sf
        6AIAAA==
X-CMS-MailID: 20191231102302eucas1p2c93ec388a3a90051d519d7e169ff5776
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-12-31 at 11:02 +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 31, 2019 at 10:41:47AM +0100, Artur Świgoń wrote:
> > On Tue, 2019-12-31 at 10:22 +0100, Krzysztof Kozlowski wrote:
> > > On Tue, Dec 31, 2019 at 08:18:01AM +0100, Artur Świgoń wrote:
> > > > Hi,
> > > > 
> > > > On Mon, 2019-12-30 at 16:44 +0100, Krzysztof Kozlowski wrote:
> > > > > On Fri, Dec 20, 2019 at 12:56:50PM +0100, Artur Świgoń wrote:
> > > > > > This patch adds the following properties to the Exynos4412 DT:
> > > > > >   - exynos,interconnect-parent-node: to declare connections between
> > > > > >     nodes in order to guarantee PM QoS requirements between nodes;
> > > > > >   - #interconnect-cells: required by the interconnect framework.
> > > > > > 
> > > > > > Note that #interconnect-cells is always zero and node IDs are not
> > > > > > hardcoded anywhere.
> > > > > > 
> > > > > > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > The order of patches is confusing. Patches 4 and 6 are split - do the
> > > > > depend on 5? I doubt but...
> > > > 
> > > > Let me elaborate:
> > > > 
> > > > The order of the patches in this series is such that every subsequent
> > > > patch adds some functionality (and, of course, applying patches one-by-one
> > > > yields a working kernel at every step). Specifically for patches 04--07:
> > > > 
> > > >  -- patch 04 adds interconnect _provider_ properties for Exynos4412;
> > > >  -- patch 05 implements interconnect provider logic (depends on patch 04);
> > > >  -- patch 06 adds interconnect _consumer_ properties for Exynos4412 mixer;
> > > >  -- patch 07 implements interconnect consumer logic (depends on patches
> > > >     05 & 06);
> > > > 
> > > > My reasoning is that this order allows to e.g., merge the interconnect
> > > > provider for exynos-bus and leave the consumers for later (not limited to
> > > > the mixer). I hope this makes sense.
> > > 
> > > It is wrong. The driver should not depend on DTS changes because:
> > > 1. DTS always go through separate branch and tree, so last patch
> > >    will have to wait up to 3 cycles (!!!),
> > > 2. You break backward compatibility.
> > 
> > It is up to the definition of "depends". The driver is _not_ broken without
> > the DTS patches, but the interconnect functionality will not be available.
> > 
> > The only requirement is that if we want to have a working interconnect
> > consumer, there needs to be a working interconnet provider (and I used
> > the word "depends" to specify what needs what in order to work as intended).
> > 
> 
> The order of patches should reflect first of all real dependency.
> Whether it compiles, works at all and does not break anything.  Logical
> dependency of "when the feature will start working" is
> irrelevant to DTS because DTS goes in separate way and driver is
> independent of it.

The order of patches does indeed reflect real dependency. I can also reorder
them (preserving the dependencies) so that DTS patches go first in the series
if this is the more preferred way.

> > I still think the order of these patches is the most logical one for someone
> > reading this RFC as a whole.
> 
> I am sorry but it brings only confusion. DTS is orthogonal of the
> driver code. You could even post the patchset without DTS (although then
> it would raise questions where is the user of it, but still, you
> could).
> 
> Further, DTS describes also hardware so you could send certain DTS
> patches without driver implementation to describe the hardware.
> 
> Driver code and DTS are kind of different worlds so mixing them up for
> logical review does not really make any sense.
> 
> Not mentioning it is different than most of other patches on mailing
> lists.
> 
> BTW, it is the same as bindings which should (almost) always go first as
> separate patches.

Thanks for elaborating on this, I appreciate it.
Regarding your original concern, patches 04 & 06 are separate for several
reasons, one of which is that they are related to two different drivers
(exynos-bus vs. exynos-mixer).

> > 
> > > In certain cases dependency on DTS changes is ok:
> > > 1. Cleaning up deprecated properties,
> > > 2. Ignoring the backward compatibility for e.g. new platforms.
> > > 
> > > None of these are applicable here.
> > > 
> > > You need to rework it, put DTS changes at the end. This clearly shows
> > > that there is no wrong dependency.
> > > 
> > > > 
> > > > > Adjust the title to match the contents - you are not adding bindings but
> > > > > properties to bus nodes. Also the prefix is ARM: (look at recent
> > > > > commits).
> > > > 
> > > > OK.
> > > > 
> > > > > > 
> > > > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > index 4ce3d77a6704..d9d70eacfcaf 100644
> > > > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > @@ -90,6 +90,7 @@
> > > > > >  &bus_dmc {
> > > > > >  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> > > > > >  	vdd-supply = <&buck1_reg>;
> > > > > > +	#interconnect-cells = <0>;
> > > > > 
> > > > > This does not look like property of Odroid but Exynos4412 or Exynos4.
> > > > 
> > > > Strangely enough, this file is where the 'exynos,parent-bus' (aka. 'devfreq')
> > > > properties are located (and everything in this RFC concerns devfreq).
> > > 
> > > I cannot find exynos,parent-bus in exynos4412-odroid-common.dtsi. Can
> > > you elaborate?
> > 
> > Currently a name change is being made: 'devfreq' -> 'exynos,parent-bus'
> > https://patchwork.kernel.org/patch/11304549/
> > (a dependency of this RFC; also available in devfreq-testing branch)
> 
> I see. That property also does not look like board (Odroid) specific so
> it should be moved to Exynos4412 DTSI.

Makes sense to me. Just from looking at the patch I referenced above, there is
a significant level of code duplication between
* arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
* arch/arm/boot/dts/exynos4412-midas.dtsi
* arch/arm/boot/dts/exynos4412-odroid-common.dtsi
with relation to the devfreq*/exynos,* properties.

-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


