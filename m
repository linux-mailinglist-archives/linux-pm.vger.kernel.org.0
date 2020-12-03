Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5A52CCEC8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 06:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgLCFqw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 00:46:52 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:25023 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgLCFqw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 00:46:52 -0500
Date:   Thu, 03 Dec 2020 05:46:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606974369;
        bh=TGhD9D270psDdoXJ2XkA/M3rk2f0vppeLABuncCXu/E=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=N7WuEgaN/Yv5rTEAyVzl1y547Y8ennIuP7rS7K16+i7c/9yrZvDfOEXBgMpXHqpdz
         Lu01nEMP878GO2jMOW0f9/fgnhJ4mwMq3Qg+IuEUrkuDvDnCqjLqxtFd9QupOYLwqt
         JI8Qf3zualaz/p9HkFEp5K4wrlyfaUv7uTAphNF4=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   =?utf-8?Q?Timon_B=C3=A4tz?= <timon.baetz@protonmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>
Reply-To: =?utf-8?Q?Timon_B=C3=A4tz?= <timon.baetz@protonmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: exynos: Fix charging regulator voltage and current for i9100
Message-ID: <dDjo3R2SJ6CBCjg0YhsCPdh5JfEGhA--DHNNDqbWjVtTjZC5v7g7_523vqAzu_Ybf1Q-xfKeK47H483YQoVtpO3DI83OaR6c6mbvtC9S1Us=@protonmail.com>
In-Reply-To: <20201202220430.GB135888@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com> <20201202203516.43053-3-timon.baetz@protonmail.com> <20201202220430.GB135888@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, December 2, 2020 11:04 PM, Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:

> On Wed, Dec 02, 2020 at 09:07:28PM +0000, Timon Baetz wrote:
>
> > Set CHARGER current and CHARGER_CV voltage according to Galaxy S2 kerne=
l
> > fork.
> >
> > Signed-off-by: Timon Baetz timon.baetz@protonmail.com
> >
> > ------------------------------------------------------
> >
> > arch/arm/boot/dts/exynos4210-i9100.dts | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts=
/exynos4210-i9100.dts
> > index 9f8d927e0d21..2700d53ea01b 100644
> > --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> > +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> > @@ -558,14 +558,14 @@ safe2_sreg: ESAFEOUT2 {
> >
> >       =09charger_reg: CHARGER {
> >       =09=09regulator-name =3D "CHARGER";
> >
> >
> > -       =09=09regulator-min-microamp =3D <60000>;
> >
> >
> > -       =09=09regulator-max-microamp =3D <2580000>;
> >
> >
> >
> > -       =09=09regulator-min-microamp =3D <200000>;
> >
> >
> > -       =09=09regulator-max-microamp =3D <950000>;
> >         =09};
> >
> >         =09chargercv_reg: CHARGER_CV {
> >         =09=09regulator-name =3D "CHARGER_CV";
> >
> >
> >
> > -       =09=09regulator-min-microvolt =3D <3800000>;
> >
> >
> > -       =09=09regulator-max-microvolt =3D <4100000>;
> >
> >
> >
> > -       =09=09regulator-min-microvolt =3D <4200000>;
> >
> >
> > -       =09=09regulator-max-microvolt =3D <4200000>;
> >
> >
>
> I am looking at my sources of Android 3.0 for GT-I9100 but I cannot find
> charger voltages for it. Where did you find it?
>
> Best regards,
> Krzysztof

Thanks all the feedback Krzysztof,

Voltage is set in the charger probe function of the downstream kernel fork:=
 https://github.com/LineageOS/android_kernel_samsung_smdk4412/blob/lineage-=
17.0/drivers/power/max8997_charger_u1.c#L390-L391

Mainline uses the regulator: https://github.com/torvalds/linux/blob/master/=
drivers/regulator/max8997-regulator.c#L418-L419

