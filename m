Return-Path: <linux-pm+bounces-12049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57E94D2D3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B19C1C209D9
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD2198A0F;
	Fri,  9 Aug 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/GAU1Kz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3D197512;
	Fri,  9 Aug 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215604; cv=none; b=H2JfgoeDAC7A3RWQhT2/7p0peLolvPRrL2YcXSW4monYEkIyGdSmCMTmJ0fhJH/UBWrz165j0e4Ay16PXNanwwAV3ze+Dz7x5Alr26vv3NB9wwzJ8UCodfLU07R1LL8fDydZQRYjNRC1RQVVOOJBHtA+vw1QxKye+fw054ONAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215604; c=relaxed/simple;
	bh=yhbalDZ4n+KXBlHEaICRjuhrGYBlgbXbkFlbN8T+NME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPU+ANx5pCMan9x6zyTBFXn5Ailudq7oBFA3+u6+X7qLDLE3G4+/CJm3WJt1xJc4Ga9IsCcHpbvz0esAoM1AyfocBCFkBvuSKZ343J35a2GsYegs28WpFEqPgpbM7NmYFMNJscrL5CZDT7/T9TaaTIm4mZ8LltcCYHDnNV2Jvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/GAU1Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430ADC32782;
	Fri,  9 Aug 2024 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723215603;
	bh=yhbalDZ4n+KXBlHEaICRjuhrGYBlgbXbkFlbN8T+NME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/GAU1KzMAacdiUBmE1dxn6Jy7KKiIRrEDuWVrMaQ1RM9ouvlOTP/kqh/IgXd+5oS
	 rgiJyjktTWrxRqUY0gDEGTak3cdei1x9Sm+JqJSWETn3dR3Zn91b3lVNSENafy+z5y
	 loRH3clod5GDAT0/YTSjSsBeBYUPrb62U20vwO1dovDPaQ9L1OSfZ+0YbX2s7tcw3p
	 nuRNPzcUBjUs5lovUAuq2RFZdDgql0zd/PyQZPd+Ts831K4b9XX/yLc1G5QUwTusGQ
	 J4WX8c+X+9mqAJni7GlnYUmfBMhD9ctmDmCY7hiPZSr8wMMdDhEkatGUdwsilK7M4U
	 RIa5rs3b0IaHg==
Date: Fri, 9 Aug 2024 15:59:58 +0100
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
Message-ID: <20240809-constant-oxidize-8aed145179c7@spud>
References: <20240808163451.80750-1-detlev.casanova@collabora.com>
 <20240808163451.80750-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+eX86es6cMT9cLlU"
Content-Disposition: inline
In-Reply-To: <20240808163451.80750-2-detlev.casanova@collabora.com>


--+eX86es6cMT9cLlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 12:31:04PM -0400, Detlev Casanova wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>=20
> Define power domain IDs as described in the TRM and add compatible for
> rockchip,rk3576-power-controller
>=20
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> [reword, add yaml]

To be honest, both here and in your other patch, you should remove this
[] section and add a co-develop-ed-by instead.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../power/rockchip,power-controller.yaml      |  1 +
>  .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h
>=20
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-contr=
oller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-control=
ler.yaml
> index 0d5e999a58f1b..650dc0aae6f51 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> @@ -41,6 +41,7 @@ properties:
>        - rockchip,rk3368-power-controller
>        - rockchip,rk3399-power-controller
>        - rockchip,rk3568-power-controller
> +      - rockchip,rk3576-power-controller
>        - rockchip,rk3588-power-controller
>        - rockchip,rv1126-power-controller
> =20
> diff --git a/include/dt-bindings/power/rockchip,rk3576-power.h b/include/=
dt-bindings/power/rockchip,rk3576-power.h
> new file mode 100644
> index 0000000000000..324a056aa8512
> --- /dev/null
> +++ b/include/dt-bindings/power/rockchip,rk3576-power.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +#ifndef __DT_BINDINGS_POWER_RK3576_POWER_H__
> +#define __DT_BINDINGS_POWER_RK3576_POWER_H__
> +
> +/* VD_NPU */
> +#define RK3576_PD_NPU		0
> +#define RK3576_PD_NPUTOP	1
> +#define RK3576_PD_NPU0		2
> +#define RK3576_PD_NPU1		3
> +
> +/* VD_GPU */
> +#define RK3576_PD_GPU		4
> +
> +/* VD_LOGIC */
> +#define RK3576_PD_NVM		5
> +#define RK3576_PD_SDGMAC	6
> +#define RK3576_PD_USB		7
> +#define RK3576_PD_PHP		8
> +#define RK3576_PD_SUBPHP	9
> +#define RK3576_PD_AUDIO		10
> +#define RK3576_PD_VEPU0		11
> +#define RK3576_PD_VEPU1		12
> +#define RK3576_PD_VPU		13
> +#define RK3576_PD_VDEC		14
> +#define RK3576_PD_VI		15
> +#define RK3576_PD_VO0		16
> +#define RK3576_PD_VO1		17
> +#define RK3576_PD_VOP		18
> +
> +#endif
> --=20
> 2.46.0
>=20

--+eX86es6cMT9cLlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYu7gAKCRB4tDGHoIJi
0s5UAP4vbdzxFL2Sgz8Fv4uo4X1C/GLB38OueD06clnzoinFwAD/YJlXEhpLtmS6
dr1+zxPIPJNrVC00le0J90ylsJjcLwc=
=SrCh
-----END PGP SIGNATURE-----

--+eX86es6cMT9cLlU--

