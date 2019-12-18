Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658CF124489
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfLRK35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRK35 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 05:29:57 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D7A4227BF;
        Wed, 18 Dec 2019 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576664996;
        bh=LGcb8cnFWGkw86lBWLB3UZi0UBqoubV9Pp+oAqiza8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uM/Yti6AWOGb7bH82Q7InZdS5UQXLTgs+SWPeY0rRsqktnvvi7NWSDacAduH5qJFt
         lL15KK2/Sjr6+qg9nXPdrPOBQ0vmfn+csBa5j4pE9273djANnmjB4ztD1O+122tOgM
         4s/J+BKq74NgGWhYDYu05SfokdHYtCOYITO+F/cg=
Received: by mail-lf1-f53.google.com with SMTP id l18so1322166lfc.1;
        Wed, 18 Dec 2019 02:29:55 -0800 (PST)
X-Gm-Message-State: APjAAAWsDGqnQ8gBJ7WtHLStOUQWfUzyQBcoGH6MeTsRyCyDyaG752E9
        Td822xWpOioJ+AXYvCH9rgYoGQGm2uHaE3NKzmg=
X-Google-Smtp-Source: APXvYqzBJ09TMimebaMqjq1w4hCCNfntpaiQy0BZALfmTdvtx5+3C6M5ho+6KpUaiWhClthOlZdTol2BvRgQbWKG4S4=
X-Received: by 2002:ac2:531b:: with SMTP id c27mr1233746lfh.91.1576664993732;
 Wed, 18 Dec 2019 02:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20190919142236.4071-1-a.swigon@samsung.com> <CGME20190919142329eucas1p299762f99dd55a5d625633ceec84219f9@eucas1p2.samsung.com>
 <20190919142236.4071-9-a.swigon@samsung.com> <693e250d-9656-df67-9685-188020b43542@samsung.com>
 <eecc5d38-f6ab-b1ea-1a08-0afb2dcddbef@samsung.com> <2008dca684ccb1dd740e6e6b88e56727d0d1c435.camel@samsung.com>
In-Reply-To: <2008dca684ccb1dd740e6e6b88e56727d0d1c435.camel@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Wed, 18 Dec 2019 19:29:16 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1=gk1jm4wmX+xMZfkrPR_UDumaDEfmddrpbig4VnN8FQ@mail.gmail.com>
Message-ID: <CAGTfZH1=gk1jm4wmX+xMZfkrPR_UDumaDEfmddrpbig4VnN8FQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

2019=EB=85=84 12=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:18, =
Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> Hi,
>
> On Mon, 2019-12-16 at 11:59 +0900, Chanwoo Choi wrote:
> > Hi,
> >
> > On 12/16/19 9:51 AM, Chanwoo Choi wrote:
> > > On 9/19/19 11:22 PM, Artur =C5=9Awigo=C5=84 wrote:
> > > > From: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> > > >
> > > > This patch adds two fields to the Exynos4412 DTS:
> > > >   - parent: to declare connections between nodes that are not in a
> > > >     parent-child relation in devfreq;
> > > >   - #interconnect-cells: required by the interconnect framework.
> > > >
> > > > Please note that #interconnect-cells is always zero and node IDs ar=
e not
> > > > hardcoded anywhere. The above-mentioned parent-child relation in de=
vfreq
> > > > means that there is a shared power line ('devfreq' property). The '=
parent'
> > > > property only signifies an interconnect connection.
> > > >
> > > > Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com=
>
> > > > ---
> > > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
> > > >  arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
> > > >  2 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch=
/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > index ea55f377d17c..bdd61ae86103 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > @@ -106,6 +106,7 @@
> > > >  &bus_leftbus {
> > > >   devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> > > >   vdd-supply =3D <&buck3_reg>;
> > > > + parent =3D <&bus_dmc>;
> > >
> > > As I mentioned on other reply,
> > > I'm not sure to use the specific 'parent' property to make
> > > the connection between buses. If possible, you better to
> > > use the standard way like OF graph. Except for making
> > > the connection between buses by 'parent' property,
> > > looks good to me.
> >
> > I tried to think it continuously. I withdraw the my opinion
> > using OF graph. If you make the property name like the following
> > example, it is possible for exynos.
> > - exynos,interconnect-parent-node =3D <&bus_dmc>; or other proper name.
> >
> > Regardless of existing 'devfreq' property, I think you better to
> > make the connection between buses for only interconnect as following
> > example: This make it possible user can draw the correct tree by tracki=
ng
> > the 'exynos,interconnect-parent-node' value.
>
> OK, for v3 I will add 'exynos,interconnect-parent-node' to bus_dmc,
> bus_leftbus and bus_display as you suggested below and change the code
> so that the 'devfreq' (or the upcoming 'exynos,parent-bus') property is
> not taken into account.

I'd like you to make the v3 based on my patches[1]
[1]  https://lkml.org/lkml/2019/12/17/21
- [PATCH 0/9] PM / devfreq: Remove deprecated 'devfreq' and
'devfreq-events' properties

I uploaded the patches to devfreq-testing branch[2]
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?=
h=3Ddevfreq-testing


>
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm=
/boot/dts/exynos4412-odroid-common.dtsi
> > index ea55f377d17c..53f87f46e161 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -90,6 +90,7 @@
> >  &bus_dmc {
> >         devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> >         vdd-supply =3D <&buck1_reg>;
> > +       #interconnect-cells =3D <0>;
> >         status =3D "okay";
> >  };
> >
> > @@ -106,6 +107,8 @@
> >  &bus_leftbus {
> >         devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> >         vdd-supply =3D <&buck3_reg>;
> > +       exynos,interconnect-parent-node =3D <&bus_dmc>;
> > +       #interconnect-cells =3D <0>;
> >         status =3D "okay";
> >  };
> >
> > @@ -116,6 +119,8 @@
> >
> >  &bus_display {
> >         devfreq =3D <&bus_leftbus>;
> > +       exynos,interconnect-parent-node =3D <&bus_leftbus>;
> > +       #interconnect-cells =3D <0>;
> >         status =3D "okay";
> >  };
> >
> >
> > >
> > >
> > > >   status =3D "okay";
> > > >  };
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/=
exynos4412.dtsi
> > > > index d20db2dfe8e2..a70a671acacd 100644
> > > > --- a/arch/arm/boot/dts/exynos4412.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > > > @@ -390,6 +390,7 @@
> > > >                   clocks =3D <&clock CLK_DIV_DMC>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_dmc_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -398,6 +399,7 @@
> > > >                   clocks =3D <&clock CLK_DIV_ACP>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_acp_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -406,6 +408,7 @@
> > > >                   clocks =3D <&clock CLK_DIV_C2C>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_dmc_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -459,6 +462,7 @@
> > > >                   clocks =3D <&clock CLK_DIV_GDL>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_leftbus_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -467,6 +471,7 @@
> > > >                   clocks =3D <&clock CLK_DIV_GDR>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_leftbus_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -475,6 +480,7 @@
> > > >                   clocks =3D <&clock CLK_ACLK160>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_display_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -483,6 +489,7 @@
> > > >                   clocks =3D <&clock CLK_ACLK133>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_fsys_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -491,6 +498,7 @@
> > > >                   clocks =3D <&clock CLK_ACLK100>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_peri_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > > @@ -499,6 +507,7 @@
> > > >                   clocks =3D <&clock CLK_SCLK_MFC>;
> > > >                   clock-names =3D "bus";
> > > >                   operating-points-v2 =3D <&bus_leftbus_opp_table>;
> > > > +                 #interconnect-cells =3D <0>;
> > > >                   status =3D "disabled";
> > > >           };
> > > >
> > > >
> > >
> > >
> >
>
> Best regards,
> --
> Artur =C5=9Awigo=C5=84
> Samsung R&D Institute Poland
> Samsung Electronics
>
>


--
Best Regards,
Chanwoo Choi
