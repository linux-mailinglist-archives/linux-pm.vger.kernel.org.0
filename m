Return-Path: <linux-pm+bounces-27888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06992AC92DC
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC421C21267
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F43235057;
	Fri, 30 May 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikYMHjij"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272F198845;
	Fri, 30 May 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620646; cv=none; b=ZCvGh2/83NbRcj+d6pf30V9rw0nX5TSUFSHo3JhfxBO26WQHLYmWaLKRWkI9Yi1HRdjJ/Mik4aEQ19oCWsMLwTKnCUQ1rmVDgDCSPD/XcBEGtMRF7mbApYDKnIWlKg11lg2W6cET/e9lobdSYtITKNp5RLIW9AX/oEL4xdBp/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620646; c=relaxed/simple;
	bh=hZHDiYBG1Y1HUlzoNGnJPAo5du46tcOG49Tcr3RVSvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSwRS4ylihILqe8ZCcQauOb2QR3wLzi1z3tPLYULTtgb1ZSt59HvQy9WHjfwouUv4475kzGAJdomYS/IfU/PnwrdSGFboiXgeshmk6bQhu3dBsq+mJhCQv0E3k/2JMSv5zE1/pFvHvCvuIL5XFlVePLg71QNk48V7h4shydppqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikYMHjij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68C2C4CEE9;
	Fri, 30 May 2025 15:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748620646;
	bh=hZHDiYBG1Y1HUlzoNGnJPAo5du46tcOG49Tcr3RVSvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikYMHjijfZBls/jp41L/O8ESIo1EqOSIcMUkBhMMZhMaTgtLyMxFsYbWZvZiMNEmu
	 JbOD2pJjpPqAf073kbNKifC+WKIo5S6VmgBtRWQwqBogxxgGcDFLSU7u8JJnY0EX1Z
	 Peg3Yv0Emf9ZRv6+9E+2PL4oruJyA6hrMC8oRThFV6vDPxwfU6W0UimBh4Pbv2nUlp
	 tJyD2k2f7fOEdi6ITdKPuBg1DawIRVFLSQ8X0hhnB5uoh/j9KSbf/98u6irEU/VRSU
	 WQpmtxsGsJTKWsThr8t2If8v76mHvPxx+TqXSgs0Wu3pohUc3o1I5ckwNtOCq+TlV6
	 IxUgYKde4CwRw==
Date: Fri, 30 May 2025 16:57:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC v1] dt-bindings: interconnect: add mt7988-cci compatible
Message-ID: <20250530-naturist-swept-973a1f8f4b08@spud>
References: <20250528135251.6492-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wlJGDMBTc856vNFG"
Content-Disposition: inline
In-Reply-To: <20250528135251.6492-1-linux@fw-web.de>


--wlJGDMBTc856vNFG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 03:52:49PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Add compatible for Mediatek MT7988 SoC with mediatek,mt8183-cci fallback
> which is taken by driver.

What's RFC about the patch?

>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../bindings/interconnect/mediatek,cci.yaml          | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.=
yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> index 58611ba2a0f4..2c6785c588e9 100644
> --- a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> @@ -17,9 +17,15 @@ description: |
> =20
>  properties:
>    compatible:
> -    enum:
> -      - mediatek,mt8183-cci
> -      - mediatek,mt8186-cci
> +    oneOf:
> +      - items:

This "- items:" is redundant.

> +          - enum:
> +              - mediatek,mt8183-cci
> +              - mediatek,mt8186-cci
> +      - items:
> +          - enum:
> +              - mediatek,mt7988-cci
> +          - const: mediatek,mt8183-cci
> =20
>    clocks:
>      items:
> --=20
> 2.43.0
>=20

--wlJGDMBTc856vNFG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDnVYAAKCRB4tDGHoIJi
0i+UAQCTTLJpyhXbrf/dTa8U43yhnq5ItBZMUPXZ1/O5ePbQigEAq4UB18R67FR0
qNKjVg68sWCN+sXou9O3+mRNTSkosgU=
=FvmH
-----END PGP SIGNATURE-----

--wlJGDMBTc856vNFG--

