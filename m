Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2627D2EF4AE
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbhAHPRk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 10:17:40 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:48943 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbhAHPRj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 10:17:39 -0500
Date:   Fri, 08 Jan 2021 15:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1610119016;
        bh=nTvFORzb1bf2GhxFAnJcMjuDAmjBfj16QbcnGKmQQN8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=I3etT1bVJJGG6EmNOlOKiyuMd9VujUvYRzGxE60kGx0AXi0dA8XeUIIGWXYLxRAfJ
         DvU62wDrGEyiH8DuYssDVuJ4t5139c5U3Gbz1gfMg+Jy+qYrh7t4cNju86CvimuKbO
         59pR8dRcakP+eFG72Q3elh57SfTrSYFBbiBdvoQ8=
To:     Mark Brown <broonie@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic nodes
Message-ID: <20210108161635.1b9303c8.timon.baetz@protonmail.com>
In-Reply-To: <20210106145931.GE4752@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com> <20201230205139.1812366-2-timon.baetz@protonmail.com> <20210104135156.GB5645@sirena.org.uk> <20210104181825.GB27043@kozik-lap> <20210104182734.GH5645@sirena.org.uk> <20210104183821.GA29033@kozik-lap> <20210104212449.GJ5645@sirena.org.uk> <20210105165529.GB20401@kozik-lap> <20210106145931.GE4752@sirena.org.uk>
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

On Wed, 6 Jan 2021 14:59:31 +0000, Mark Brown wrote:
> On Tue, Jan 05, 2021 at 05:55:29PM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Jan 04, 2021 at 09:24:49PM +0000, Mark Brown wrote: =20
>=20
> > > I'm not sure I follow, sorry?  Either the core driver can parse the
> > > bindings enough to know what children it has or (probably better) it =
can
> > > instantiate the children unconditionally and then the function driver=
s
> > > can figure out if they need to do anything. =20
>=20
> > Currently the MFD parent/core driver will instantiate children
> > unconditionally.  It would have to be adapted. With proposed bindings -
> > nothing to change.  MFD core already does the thing. =20
>=20
> We're not talking massive amounts of code here, but we are talking ABI
> for a DT update.
>=20
> > The point is that function drivers should not be even bound, should not
> > start to probe. Otherwise if they probe and fail, they will pollute the
> > dmesg/probe log with failure. With the failure coming from looking for
> > missing of_node or any other condition from parent/core driver. =20
>=20
> There will only be an error message if one is printed, if we can do a
> definitive -ENODEV there should be no need to print an error.
>=20
> > > > Another point, is that this reflects the real hardware. The same as=
 we
> > > > model entire SoC as multiple children of soc node (with their own
> > > > properties), here we represent smaller chip which also has
> > > > sub-components. =20
>=20
> > > Components we're calling things like "extcon"... =20
>=20
> > I am rather thinking about charger, but yes, extcon as well. Either you
> > have USB socket (and want to use associated logic) or not. =20
>=20
> Right, I'm just saying we don't need to add new device nodes reflecting
> implementation details into the DT to do that.

I'm not sure I can contribute that much to this discussion (this is my
first proper kernel patch, also I don't really understand the argument).
FWIW I looked at other MFD devices while implementing this like max77836,=
=20
max77693, max77650, max77843 (just to name a few).=20
Assigning of_node to sub-devices using sub-nodes with compatible strings=20
seemed to be a common pattern for MFD devices.
Muic needs a node to be used with extcon_get_edev_by_phandle().
Charger needs a node to reference a regulator.

