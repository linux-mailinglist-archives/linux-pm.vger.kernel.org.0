Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4D2E2B58
	for <lists+linux-pm@lfdr.de>; Fri, 25 Dec 2020 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgLYLeK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Dec 2020 06:34:10 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:13480 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgLYLeK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Dec 2020 06:34:10 -0500
Date:   Fri, 25 Dec 2020 11:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608896006;
        bh=AZddA3E2efwA1g+qUEHAnTmghSFKPKy2RpOAJ63m37w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=CulIJ8pTiO+N29SlJ4WYYiLNR/jgDe/D8X0fj6eDY0Mpd9ZD8w5goQnRBthx7a56E
         bMRJe30Fi6oZbhZ+23cwDQBLeS/2vM//Ys2koHBXTWoC3O4c+ExG7nPJhGbXIEm2gz
         eietdbr2GeFARhMuxFDn4X9V5v029lPKckzKNGGc=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Marek Szyprowski <m.szyprowski@samsung.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v4 4/7] power: supply: max8997_charger: Set CHARGER current limit
Message-ID: <20201225123300.07c84dd8.timon.baetz@protonmail.com>
In-Reply-To: <20201224140038.GA48009@kozik-lap>
References: <20201223134221.804943-1-timon.baetz@protonmail.com> <20201223134221.804943-4-timon.baetz@protonmail.com> <20201224095559.GB10937@kozik-lap> <20201224141246.7ad0ffc4.timon.baetz@protonmail.com> <20201224133706.GA22856@kozik-lap> <20201224140038.GA48009@kozik-lap>
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

On Thu, 24 Dec 2020 15:00:38 +0100, Krzysztof Kozlowski wrote:
> On Thu, Dec 24, 2020 at 02:37:06PM +0100, Krzysztof Kozlowski wrote:
> > On Thu, Dec 24, 2020 at 01:13:02PM +0000, Timon Baetz wrote: =20
> > > On Thu, 24 Dec 2020 10:55:59 +0100, Krzysztof Kozlowski wrote: =20
> > > > > @@ -170,6 +237,28 @@ static int max8997_battery_probe(struct plat=
form_device *pdev)
> > > > >  =09=09return PTR_ERR(charger->battery);
> > > > >  =09}
> > > > >
> > > > > +=09charger->reg =3D devm_regulator_get(&pdev->dev, "charger"); =
=20
> > > >
> > > > Since you do not use get_optional, you will always get a dummy
> > > > regulator. In case of error, you should either print it or entirely=
 fail
> > > > the probe. Silently continuing makes it difficult to spot errors.
> > > >
> > > > Since the driver could operate in case of extcon/regulator error, j=
ust
> > > > dev_err() so failure will be spotted with dmesg. =20
> > >
> > > I will switch to devm_regulator_get_optional() and print an error on
> > > failure, thanks.
> > > =20
> > > > It will complain on older DTBs because you are introducing incompat=
ible
> > > > change, but that's expected. Just correct all other in-tree DTS. =
=20
> > >
> > > The other 2 in-tree DTS don't have CHARGER regulators. Not sure
> > > how to correct those. Should I add muic and charger nodes without a
> > > charger-supply? It will still complain in that case. =20
> >
> > +Cc Marek,
> >
> > This is why leaving the code as is - devm_regulator_get(), not optional
> > - makes sense. Core would provide dummy regulator, so you only have to
> > provide MUIC node.
> >
> > If you change the code to devm_regulator_get_optional(), you need to ad=
d
> > everything: the charger regulator, the charger node and MUIC node.
> >
> > For Trats, the configuration should be similar as i9100, although I
> > don't know the exact values of chargign voltage.
> >
> > For Origen, there is no battery, so the power supply should not bind.
> > Maybe this could be achieved with "status disabled" for charger node? I=
t
> > depends whether MFD will respect such field... If it disables the
> > charger, you're done. =20
>=20
> I just looked at the MFD code and tested it - it nicely skips disabled
> devices. Therefore, for Origen I propose to add disabled nodes for
> charger and MUIC because these pins are not connected. No need to add
> regulators in such case.

With a dummy regulator regulator_set_current_limit() fails with -EINVAL.
Isn't it better to just skip charging control (and dev_info()) when there=
=20
is no extcon or regulator? The charger driver would still probe
without those 2 properties and work as before.

Adding disabled nodes for Origen would probably still makes sense.

I also noticed that adding nodes for those MFD cells prints "DMA mask
not set" which seems to be related to https://lkml.org/lkml/2020/4/23/873.
Any suggestions on how to handle that?

Thanks,
Timon

