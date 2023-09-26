Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF8F7AEB58
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjIZLUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 07:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLUV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 07:20:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEFAE5
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 04:20:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5948BC433C7;
        Tue, 26 Sep 2023 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695727214;
        bh=KLnmaGQ/nGnn5HVd4+w/PzRxL9sDX4hl2a5HTd5I3eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLKRjFFdc4gD7lH8b9vTMi19G1IqU3n9tcox/lHYwpcliiCjFjwN2dXbNeWNSJ6b3
         UoMQIV60ngQFyV6+g9fsWDb8xvxu/tmCGgwHPKocmc46P3QY2iyBEA/omHnWS6oiZE
         GjTXHeOYh2KbwjevtCyR30Kkkuv0MLtbGi1jZMpCA1ZPKlUydTnI0h761iZilXYNlN
         hSsJRLkyJNyMp9UHwaoc1xVD6MVteeXUuYZrdfqaZ6bAa+ZRl/DjT0yrhOvo12Y5M5
         Lh5IxP1VblszExht7dU/U9mxfPsxuy8Mkq8xRmtryLYhgVj4oFdWjFlS6Lkz6sK2l4
         12gUKcCpFSkYw==
Date:   Tue, 26 Sep 2023 12:20:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     changhuang.liang@starfivetech.com, ulf.hansson@linaro.org,
        Conor Dooley <conor.dooley@microchip.com>, arnd@arndb.de,
        jiajie.ho@starfivetech.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh@kernel.org,
        walker.chen@starfivetech.com
Subject: Re: [GIT PULL 2/5] dt-bindings: power: Add power-domain header for
 JH7110
Message-ID: <20230926-trio-sweat-9b878df53209@spud>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
 <20230913-grumbly-rewrite-34c85539f2ed@spud>
 <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v+vIMjR+OVM3y5cd"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--v+vIMjR+OVM3y5cd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 12:55:01PM +0200, Geert Uytterhoeven wrote:
> Hi Conor, Changhuang,
>=20
> On Wed, Sep 13, 2023 at 3:58=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > From: Changhuang Liang <changhuang.liang@starfivetech.com>
> >
> > Add power-domain header for JH7110 SoC, it can use to operate dphy
> > power.
> >
> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks for your patch, which is now commit 41b66b54a72bd796
> ("dt-bindings: power: Add power-domain header for JH7110")
> in pmdomain/next.
>=20
> Conor: looks like you forgot to update the patch description, as promised=
 in
> https://lore.kernel.org/all/20230519-irk-dwelled-6a499c482e62@spud?

*sigh*, that's what happens when you apply the patches several months
after they were sent I guess. I'll try to make sure that that doesn't
happen again.

> > --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
> > +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >  /*
> > - * Copyright (C) 2022 StarFive Technology Co., Ltd.
> > + * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
> >   * Author: Walker Chen <walker.chen@starfivetech.com>
> >   */
> >  #ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
> > @@ -14,4 +14,7 @@
> >  #define JH7110_PD_ISP          5
> >  #define JH7110_PD_VENC         6
> >
> > +#define JH7110_PD_DPHY_TX      0
> > +#define JH7110_PD_DPHY_RX      1
>=20
> These values are conflicting with similarly-named values above:
>=20
>     #define JH7110_PD_SYSTOP        0
>     #define JH7110_PD_CPU           1
>=20
> Upon closer look, and diving into the driver, this header file contains
> definitions for two separate number spaces: the first set is meant
> to be used in PM Domain specifiers referring to a node compatible
> with "starfive,jh7110-pmu", while the second set is meant to be
> used in PM Domain specifiers referring to a node compatible with
> "starfive,jh7110-aon-syscon".

Yeah, apologies for the confusion there. I maybe should have
requested an additional file, since the relevant compatibles
are different.

> I think it would be nice to have this reflected in the names of
> the defines (e.g. JH7110_PD_AON_DPHY_TX), and/or to add comments
> clearly delimiting the two separate number spaces, and explaining
> where they apply to.

Since this is 6.7 material, there's still plenty of time remaining to
make either of these changes. Changhuang Liang, do you think you would
be able to send a patch implementing either of the suggestions made by
Geert?

Thanks,
Conor.


--v+vIMjR+OVM3y5cd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRK+aQAKCRB4tDGHoIJi
0qdRAQCgkg2gvIyCQlhu9Kgi4WoUf3foxwC7G5VBz36iX0smcAEA+weWLhamLKuF
n2hwivXCDX0fFopjfXLuKFF81bzVpwg=
=5+xG
-----END PGP SIGNATURE-----

--v+vIMjR+OVM3y5cd--
