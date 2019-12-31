Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A966A12D79F
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 10:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbfLaJlv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 04:41:51 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59955 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfLaJlv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 04:41:51 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191231094149euoutp01dd2d8b0f6c0ee9d7091e5c20cec65e9e~la2E80FGS1037210372euoutp01C
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2019 09:41:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191231094149euoutp01dd2d8b0f6c0ee9d7091e5c20cec65e9e~la2E80FGS1037210372euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577785309;
        bh=y65p+WJMtVpCaPejrbzx6k+tRLYVdapbmhiSddBe7YM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NSDtS1XpJ9KnPY2o2wQFSIiNTgHneHwskbHrSj3tYtuxnmJlcUZRrpuNojZUnv7c1
         myBXlqcRG4LxesO43+8L60VqaYZOJ02MG0F6iudP1OSN1tduXb5keHx7GoAj+32JFJ
         DINcSS90aHeMi9tiWOwTmC6Qt/s7trKcEcK3geAM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191231094149eucas1p21efabd86a864ac81a10d8ca4f9cfe0fa~la2EbylWW0078700787eucas1p2l;
        Tue, 31 Dec 2019 09:41:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FB.B4.60679.DD71B0E5; Tue, 31
        Dec 2019 09:41:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191231094148eucas1p1da266eb4f837c44e5f476185deb1bccd~la2DwdEJV2443224432eucas1p10;
        Tue, 31 Dec 2019 09:41:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191231094148eusmtrp170ef1487803b8558cd23296b0d6144db~la2DvmekT0338403384eusmtrp1H;
        Tue, 31 Dec 2019 09:41:48 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-1b-5e0b17dddf4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.E2.08375.CD71B0E5; Tue, 31
        Dec 2019 09:41:48 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191231094147eusmtip1de0581736a501cec168a3604c8533ae1~la2DGSVFi0034300343eusmtip19;
        Tue, 31 Dec 2019 09:41:47 +0000 (GMT)
Message-ID: <99427c18b1fcca3bc21e69609500abdbbef59167.camel@samsung.com>
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
Date:   Tue, 31 Dec 2019 10:41:47 +0100
In-Reply-To: <20191231092254.GA6939@pi3>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTcRjH+d3tbudyds7KpxdmLgqT0l4sDhpaEXQIRUQQRJmrjlltS3Zq
        KZSWJr6lsgJtFlZYDSXKNU1FjcZooLQV6Wqlrhe1jMxiSy1T2nZK/fd5Xr6/7/eBH4XLnhFL
        qOO6DE6vU2kUpETU/PSXY21/5LyUdTWGUKax+j7BvPJ9Ipham4Ngen6OkUxVh5lkDJ5KEeN0
        PhAzpv4fBGP+6CKYl23XSMZ7yYaYamcnxtyz9YuZt+dNJFN9eYTcOp811xeTbJ+rnWQ9pXaM
        fViXyzZ+a8HYcks9Yr1m+R7xAYnyGKc5nsXp4xNTJWllfcNkumP5mcnbA2QeGl5cgkIooBPA
        dnFaFGAZbULw3phTgiR+9iHocozhQuFFcN34Gc0p3AX22cFdBB9qCpBQDCMYG3fjgS0pzUKR
        +504wBH0QTBOeoJM0knw7O04FuAF9Gp4NT1BBMQ4fQWH56XPg0sieiXkTVQGHwqhY8BkGCYF
        6zUw2lXuD0v5DcJhuiUi0MbpKMhvqgkmAnpUDK1uFybs74Di3se4wBHwxW4RC7wMui+XiQTm
        YajVQwjiPATmO7ZZwRboc/wmA2a4P+n9tnihvQ2aJkqxQBvoMHg9Gi5kCANDcxUutKVQVCgT
        UAFtV8MEIcCFBtfs2yy8qCsmKlG08d8txv9uMf5zvYHwehTJZfJaNcdv0HGn43iVls/UqeOO
        ntKakf+Tdc/YfS2o7c8RK6IppAiVvsMkKTJClcVna60IKFyxQJpwMCRFJj2mys7h9KcO6zM1
        HG9FSymRIlK68dbIIRmtVmVwJzkundPPTTEqZEkeah1aaD07+CQqW33Os78i942zlLhHXDsR
        3jSkrHV0nl3dvyJefrN5y/tqecWDnp+7O6IyNZsLp5LvLr5dcMJiT120zzfyPTxxQPNVeWuq
        e+cVLil0b2evUhyLr9neM5hTMmmJ2ZXvbSDVmjJnCcbl4qntDfKbFauSZzZRhjRJ9COFiE9T
        rY/F9bzqL900QkRgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7p3xLnjDL5uk7HYOGM9q8X1L89Z
        LeYfOcdqceXrezaL6Xs3sVlMuj+BxeL8+Q3sFivufmS12PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPje92MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRs+d
        Z2wF5xQqfiy9x9bA+Eyyi5GTQ0LAROJmy3HmLkYuDiGBpYwSn/6fZYNISEh8XH+DFcIWlvhz
        rQssLiTwhFFi1Wd5EJtXwEOi4+YDdhBbWCBGYtaP+2A2m4C9xNnb35hAbBEBTYnrf7+DzWEW
        mMossXtWAIjNIqAq0fB9AjOIzSmgIbFi0jOo+TuYJCa3OEHUa0q0bv/NDnGDjsTbU30sXYwc
        QHsFJf7uEIYokZdo3jqbeQKj4CwkHbMQqmYhqVrAyLyKUSS1tDg3PbfYUK84Mbe4NC9dLzk/
        dxMjMEK3Hfu5eQfjpY3BhxgFOBiVeHgfMHHFCbEmlhVX5h5ilOBgVhLhNYnhjBPiTUmsrEot
        yo8vKs1JLT7EaAr0zkRmKdHkfGDyyCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpa
        kFoE08fEwSnVwDjX7aG8A4fJlg32ce8WaS1bkvTaXvPyrY/XPQo2OcW0LHZbfU7Fttmw7bFO
        kNHX8Pm9JRf+8fSXa1qcVmKJqLHduUHwqC5rttbed3u/+i9fO+k44/n59+4mmzcmF070ZK9Y
        Gv+7oPz25aRk3uXLn1+e/3c2v/hFq8dOqp8+/E4zf1NhLCCuN1eJpTgj0VCLuag4EQAR2lqn
        5gIAAA==
X-CMS-MailID: 20191231094148eucas1p1da266eb4f837c44e5f476185deb1bccd
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-12-31 at 10:22 +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 31, 2019 at 08:18:01AM +0100, Artur Świgoń wrote:
> > Hi,
> > 
> > On Mon, 2019-12-30 at 16:44 +0100, Krzysztof Kozlowski wrote:
> > > On Fri, Dec 20, 2019 at 12:56:50PM +0100, Artur Świgoń wrote:
> > > > This patch adds the following properties to the Exynos4412 DT:
> > > >   - exynos,interconnect-parent-node: to declare connections between
> > > >     nodes in order to guarantee PM QoS requirements between nodes;
> > > >   - #interconnect-cells: required by the interconnect framework.
> > > > 
> > > > Note that #interconnect-cells is always zero and node IDs are not
> > > > hardcoded anywhere.
> > > > 
> > > > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > > > ---
> > > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > 
> > > The order of patches is confusing. Patches 4 and 6 are split - do the
> > > depend on 5? I doubt but...
> > 
> > Let me elaborate:
> > 
> > The order of the patches in this series is such that every subsequent
> > patch adds some functionality (and, of course, applying patches one-by-one
> > yields a working kernel at every step). Specifically for patches 04--07:
> > 
> >  -- patch 04 adds interconnect _provider_ properties for Exynos4412;
> >  -- patch 05 implements interconnect provider logic (depends on patch 04);
> >  -- patch 06 adds interconnect _consumer_ properties for Exynos4412 mixer;
> >  -- patch 07 implements interconnect consumer logic (depends on patches
> >     05 & 06);
> > 
> > My reasoning is that this order allows to e.g., merge the interconnect
> > provider for exynos-bus and leave the consumers for later (not limited to
> > the mixer). I hope this makes sense.
> 
> It is wrong. The driver should not depend on DTS changes because:
> 1. DTS always go through separate branch and tree, so last patch
>    will have to wait up to 3 cycles (!!!),
> 2. You break backward compatibility.

It is up to the definition of "depends". The driver is _not_ broken without
the DTS patches, but the interconnect functionality will not be available.

The only requirement is that if we want to have a working interconnect
consumer, there needs to be a working interconnet provider (and I used
the word "depends" to specify what needs what in order to work as intended).

I still think the order of these patches is the most logical one for someone
reading this RFC as a whole.

> In certain cases dependency on DTS changes is ok:
> 1. Cleaning up deprecated properties,
> 2. Ignoring the backward compatibility for e.g. new platforms.
> 
> None of these are applicable here.
> 
> You need to rework it, put DTS changes at the end. This clearly shows
> that there is no wrong dependency.
> 
> > 
> > > Adjust the title to match the contents - you are not adding bindings but
> > > properties to bus nodes. Also the prefix is ARM: (look at recent
> > > commits).
> > 
> > OK.
> > 
> > > > 
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > index 4ce3d77a6704..d9d70eacfcaf 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > @@ -90,6 +90,7 @@
> > > >  &bus_dmc {
> > > >  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> > > >  	vdd-supply = <&buck1_reg>;
> > > > +	#interconnect-cells = <0>;
> > > 
> > > This does not look like property of Odroid but Exynos4412 or Exynos4.
> > 
> > Strangely enough, this file is where the 'exynos,parent-bus' (aka. 'devfreq')
> > properties are located (and everything in this RFC concerns devfreq).
> 
> I cannot find exynos,parent-bus in exynos4412-odroid-common.dtsi. Can
> you elaborate?

Currently a name change is being made: 'devfreq' -> 'exynos,parent-bus'
https://patchwork.kernel.org/patch/11304549/
(a dependency of this RFC; also available in devfreq-testing branch)

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


