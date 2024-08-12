Return-Path: <linux-pm+bounces-12107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B10494F392
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6FF1C212A4
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491CF186E47;
	Mon, 12 Aug 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqoD5h5U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16413183CA6;
	Mon, 12 Aug 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479558; cv=none; b=cS/y2mDn30jSA0IDAMGS8xGpRM7X3Mg3ixxer4XXBSv60ylQrCTka5LWsXL/Xrtqny7eJs0Xx9tspq9eKya8dT5Sr4Oq9kUljqITJQqDekMy53A3cdPwSHqEMwedLRiVOQwlSJ/woWKFza7Sck6xkMD9Jf+iHfrw0TCCpRVn3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479558; c=relaxed/simple;
	bh=0cIRAbufntnolHqEAujPdSo+VoDlKLijRvfp2CG8oqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcZwy0rwvYeuRtAybUDfpYBdGoccHSYhezrf4hPv/VpiQe9IOAscTHmYldqu0+ZRvBBnppeVQliPpLGhhd1qcVGP5uMXZsM5bZeuTcxMYx+73F3gW6BR/C1bWcWFW+VgwTPHerD4xivb2xcVXaGIgtT+ZFBBVxdgJQKCW3ILEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqoD5h5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3070C32782;
	Mon, 12 Aug 2024 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723479557;
	bh=0cIRAbufntnolHqEAujPdSo+VoDlKLijRvfp2CG8oqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqoD5h5UoNvSpdbb0+su/KzEUvDfCmS2vJrIwk7CH9PEXXt5mAZ/Ak+wDwwN07PDs
	 /m+wH6RIFNGYZJFejnf7suqsP/TXvHJ3XYyG0czvF1MmvEvNMBMz0oqWmYhWoZWBot
	 OV9B9JN7Lp6KYzQ2/bTjrBFEBdXR9p6SytY5HepwwpSXEPKcGpfDi/0S1LisEvUc92
	 Ap4fY8X7VdntqWgnosSgY/N/z1Uco1tb5e/u7Vad+JDvLXYsYSzTETzH8W7GHiow8d
	 69W25BWiwcd3voYdILPEfp+q/I5ajn73qyjvPnq1yxGOkfW1VLkC3T9s4pJLm76s/Z
	 0PyBtpK77W1Jw==
Date: Mon, 12 Aug 2024 17:19:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jagan Teki <jagan@edgeble.ai>, Arnd Bergmann <arnd@arndb.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add support for RK3576 SoC
Message-ID: <20240812-hamster-wreath-034eb3c2b940@spud>
References: <20240808163451.80750-1-detlev.casanova@collabora.com>
 <20240808163451.80750-2-detlev.casanova@collabora.com>
 <20240809-constant-oxidize-8aed145179c7@spud>
 <2276665.iZASKD2KPV@trenzalore>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YE+MBf+ZCZjz2Ojq"
Content-Disposition: inline
In-Reply-To: <2276665.iZASKD2KPV@trenzalore>


--YE+MBf+ZCZjz2Ojq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 01:27:18PM -0400, Detlev Casanova wrote:
> On Friday, 9 August 2024 10:59:58 EDT Conor Dooley wrote:
> > On Thu, Aug 08, 2024 at 12:31:04PM -0400, Detlev Casanova wrote:
> > > From: Finley Xiao <finley.xiao@rock-chips.com>
> > >=20
> > > Define power domain IDs as described in the TRM and add compatible for
> > > rockchip,rk3576-power-controller
> > >=20
> > > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> > > [reword, add yaml]
> >=20
> > To be honest, both here and in your other patch, you should remove this
> > [] section and add a co-develop-ed-by instead.
>=20
> That seems to be used quite often though, I like how it gives an idea of =
what=20
> has been adapted from downstream patches.

Right, but if you modified it, then why not be a co-author? IMO the []
is only suitable for when patches are modified between submission and
application by a maintainer and that anything else should be noted under
the --- line. If you feel like the difference to the vendor kernel is
worth having in the git history, it should be described in the commit
message itself and the reason should be meaningful (like the numbers
changed incompatibly) rather than that you did the minimum required for
a patch to be acceptable.

Cheers,
Conor.

>=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > ---
> > >=20
> > >  .../power/rockchip,power-controller.yaml      |  1 +
> > >  .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++++++=
++
> > >  2 files changed, 31 insertions(+)
> > >  create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> > > b/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> > > index 0d5e999a58f1b..650dc0aae6f51 100644
> > > ---
> > > a/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> > > +++
> > > b/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml>=20
> > > @@ -41,6 +41,7 @@ properties:
> > >        - rockchip,rk3368-power-controller
> > >        - rockchip,rk3399-power-controller
> > >        - rockchip,rk3568-power-controller
> > >=20
> > > +      - rockchip,rk3576-power-controller
> > >=20
> > >        - rockchip,rk3588-power-controller
> > >        - rockchip,rv1126-power-controller
> > >=20
> > > diff --git a/include/dt-bindings/power/rockchip,rk3576-power.h
> > > b/include/dt-bindings/power/rockchip,rk3576-power.h new file mode 100=
644
> > > index 0000000000000..324a056aa8512
> > > --- /dev/null
> > > +++ b/include/dt-bindings/power/rockchip,rk3576-power.h
> > > @@ -0,0 +1,30 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > +#ifndef __DT_BINDINGS_POWER_RK3576_POWER_H__
> > > +#define __DT_BINDINGS_POWER_RK3576_POWER_H__
> > > +
> > > +/* VD_NPU */
> > > +#define RK3576_PD_NPU		0
> > > +#define RK3576_PD_NPUTOP	1
> > > +#define RK3576_PD_NPU0		2
> > > +#define RK3576_PD_NPU1		3
> > > +
> > > +/* VD_GPU */
> > > +#define RK3576_PD_GPU		4
> > > +
> > > +/* VD_LOGIC */
> > > +#define RK3576_PD_NVM		5
> > > +#define RK3576_PD_SDGMAC	6
> > > +#define RK3576_PD_USB		7
> > > +#define RK3576_PD_PHP		8
> > > +#define RK3576_PD_SUBPHP	9
> > > +#define RK3576_PD_AUDIO		10
> > > +#define RK3576_PD_VEPU0		11
> > > +#define RK3576_PD_VEPU1		12
> > > +#define RK3576_PD_VPU		13
> > > +#define RK3576_PD_VDEC		14
> > > +#define RK3576_PD_VI		15
> > > +#define RK3576_PD_VO0		16
> > > +#define RK3576_PD_VO1		17
> > > +#define RK3576_PD_VOP		18
> > > +
> > > +#endif
>=20
>=20
>=20
>=20

--YE+MBf+ZCZjz2Ojq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZro2AAAKCRB4tDGHoIJi
0kHtAQDWMoel5fDSeotGlNf2O62pidhVGX6hhvxxTZnhdJi5kwEAvxrqJXlo0Vwb
nHvd1tyqOlNL3xiA+5C/MRsH/fYU7w8=
=xF8J
-----END PGP SIGNATURE-----

--YE+MBf+ZCZjz2Ojq--

