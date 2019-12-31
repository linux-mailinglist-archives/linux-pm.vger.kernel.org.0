Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A515512D804
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLaKiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 05:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfLaKiR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Dec 2019 05:38:17 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6053420718;
        Tue, 31 Dec 2019 10:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577788695;
        bh=m7kqKRaz9I7n5UoZ+mA+Vd26mdg3UIRo076jMwTZUKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q3XoN1vz6LEKRxchVQUr7q5oeq2tsBMYmGeUf4u/OvhOMxaAKr4vG/QYUDqaVVHwX
         QGqDAcHdwH5Mob7lbwJF9zVBS0hCj69c3rl/IKR5Ux6RX3MBMMNew0m75CxF8EULHk
         mjKvIEbQ3et3gumhM7Po42lSgQbrtY8SxP2QHFpg=
Received: by mail-lj1-f172.google.com with SMTP id m26so33528288ljc.13;
        Tue, 31 Dec 2019 02:38:15 -0800 (PST)
X-Gm-Message-State: APjAAAUOUl6/P/jSjsWAuucDcpTpSwbtphSSWFdg5ac4AtyCzxp0WGTe
        Ww1UOnCCxR1zwOJkyhlN7eLrpoH54RhMZN6ND5M=
X-Google-Smtp-Source: APXvYqzMKfKZfiRH2jKjUg/iq48Ir3TkHa0dR/6uA47j3MXuIg/2O24VXSsRqlCLUUsAC2Ywf0ObYtS3A/s2A3dYGAc=
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr37049562ljn.85.1577788693398;
 Tue, 31 Dec 2019 02:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20191220115653.6487-1-a.swigon@samsung.com> <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
 <20191220115653.6487-5-a.swigon@samsung.com> <20191230154405.GC4918@pi3>
 <2922135223b01126277ef92a53e6b294bc17bb5c.camel@samsung.com>
 <20191231092254.GA6939@pi3> <99427c18b1fcca3bc21e69609500abdbbef59167.camel@samsung.com>
 <20191231100234.GA7024@pi3> <29ed54c7700e35fb95fff4f4f5580eba24ffbb35.camel@samsung.com>
In-Reply-To: <29ed54c7700e35fb95fff4f4f5580eba24ffbb35.camel@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Dec 2019 11:38:02 +0100
X-Gmail-Original-Message-ID: <CAJKOXPezRMb0OnpcRWrRheKbBjyzqNXG3TDX-MQkjAm2sTSr1w@mail.gmail.com>
Message-ID: <CAJKOXPezRMb0OnpcRWrRheKbBjyzqNXG3TDX-MQkjAm2sTSr1w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>
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
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 31 Dec 2019 at 11:23, Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>=
 wrote:
> >
> > The order of patches should reflect first of all real dependency.
> > Whether it compiles, works at all and does not break anything.  Logical
> > dependency of "when the feature will start working" is
> > irrelevant to DTS because DTS goes in separate way and driver is
> > independent of it.
>
> The order of patches does indeed reflect real dependency. I can also reor=
der
> them (preserving the dependencies) so that DTS patches go first in the se=
ries
> if this is the more preferred way.

It looks wrong then. Driver should not depend on DTS. I cannot find
the patch changing bindings (should be first in patchset) which could
also point to this problem.

It seems you added requirement for interconnect properties while it
should be rather optional.

> > > I still think the order of these patches is the most logical one for =
someone
> > > reading this RFC as a whole.
> >
> > I am sorry but it brings only confusion. DTS is orthogonal of the
> > driver code. You could even post the patchset without DTS (although the=
n
> > it would raise questions where is the user of it, but still, you
> > could).
> >
> > Further, DTS describes also hardware so you could send certain DTS
> > patches without driver implementation to describe the hardware.
> >
> > Driver code and DTS are kind of different worlds so mixing them up for
> > logical review does not really make any sense.
> >
> > Not mentioning it is different than most of other patches on mailing
> > lists.
> >
> > BTW, it is the same as bindings which should (almost) always go first a=
s
> > separate patches.
>
> Thanks for elaborating on this, I appreciate it.
> Regarding your original concern, patches 04 & 06 are separate for several
> reasons, one of which is that they are related to two different drivers
> (exynos-bus vs. exynos-mixer).

It's okay then (for them to be split).

>
> > >
> > > > In certain cases dependency on DTS changes is ok:
> > > > 1. Cleaning up deprecated properties,
> > > > 2. Ignoring the backward compatibility for e.g. new platforms.
> > > >
> > > > None of these are applicable here.
> > > >
> > > > You need to rework it, put DTS changes at the end. This clearly sho=
ws
> > > > that there is no wrong dependency.
> > > >
> > > > >
> > > > > > Adjust the title to match the contents - you are not adding bin=
dings but
> > > > > > properties to bus nodes. Also the prefix is ARM: (look at recen=
t
> > > > > > commits).
> > > > >
> > > > > OK.
> > > > >
> > > > > > >
> > > > > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi =
b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > > index 4ce3d77a6704..d9d70eacfcaf 100644
> > > > > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > > > @@ -90,6 +90,7 @@
> > > > > > >  &bus_dmc {
> > > > > > >     exynos,ppmu-device =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> > > > > > >     vdd-supply =3D <&buck1_reg>;
> > > > > > > +   #interconnect-cells =3D <0>;
> > > > > >
> > > > > > This does not look like property of Odroid but Exynos4412 or Ex=
ynos4.
> > > > >
> > > > > Strangely enough, this file is where the 'exynos,parent-bus' (aka=
. 'devfreq')
> > > > > properties are located (and everything in this RFC concerns devfr=
eq).
> > > >
> > > > I cannot find exynos,parent-bus in exynos4412-odroid-common.dtsi. C=
an
> > > > you elaborate?
> > >
> > > Currently a name change is being made: 'devfreq' -> 'exynos,parent-bu=
s'
> > > https://patchwork.kernel.org/patch/11304549/
> > > (a dependency of this RFC; also available in devfreq-testing branch)
> >
> > I see. That property also does not look like board (Odroid) specific so
> > it should be moved to Exynos4412 DTSI.
>
> Makes sense to me. Just from looking at the patch I referenced above, the=
re is
> a significant level of code duplication between
> * arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> * arch/arm/boot/dts/exynos4412-midas.dtsi
> * arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> with relation to the devfreq*/exynos,* properties.

If you have in mind all the nodes with "status=3Dokay", it's fine to
duplicate them.

Best regards,
Krzysztof
