Return-Path: <linux-pm+bounces-21851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BCCA313E7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 19:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAF27A421B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79ED1E5B62;
	Tue, 11 Feb 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO7tv1K6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D01E282D;
	Tue, 11 Feb 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297909; cv=none; b=bWSBsBvZSENQ+5IZYYSvUVdDYN04S4UTLzQwAFYYmpRl38DKny3ZtE+FNvRGquVf3qXbDbE0E0le3HqE+atDVfQ1I7YI63ASTY5E54NP4wGg4m+DkeTlWnYk7Cq2REf0Mq+4Oa7B0DCXnmfFkWItBmWTKA3f1zfw4Y206zdNLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297909; c=relaxed/simple;
	bh=cE4jcsAX2FB7uvZhLWO9AMcWcOaQ1ZV8xgeqqsLhxAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeegjYS5KBfUtUnD9+BCY8LNNau5h1iRzefGo42GAToWWEFjC+C+E5KZNkQrzpShy5bEN7ueXmcXos+gI5scdNXh1XxkyOzLzuBjIWSQ2hHiG4Lbc9r+W9pMZRpnPawofIo/g2ZcTpmCp00fv99Xc8cmYbGlYWufEmE+IHXdCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO7tv1K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DA8C4CEDD;
	Tue, 11 Feb 2025 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297909;
	bh=cE4jcsAX2FB7uvZhLWO9AMcWcOaQ1ZV8xgeqqsLhxAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FO7tv1K6drxWVq7uoFgvOKH9m4xyJAD00rlHVuiIu/apLLCjiLCU2t0Z2ggEOEPCu
	 rM2PBdCJsX7wTz/49XKW4//7sk6YXeF8JEwDlbxd5FK0O1tGGvxgY+DVa5IRRGlHnJ
	 NKzJwKgcw1Hx2lyhPdbclbmVPpWcY7aNWDIJ8BaNlcPKPnXN7lRQ4EETZgevJWCCpG
	 fABcr+pxuuSY9JyiaRnwivJ5x3MVGihPBLldfdLIzZKvL9hypU5VLNPnAbhIhGX6ZB
	 KXh0m/92ptmm8D6NwXPnWEVt+p0WxBnF80K3Mad6OUVg3CCsANQJMBsQyhk3ztFSoL
	 M29vTBxJN7ySA==
Date: Tue, 11 Feb 2025 18:18:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: soc@lists.linux.dev, Jisheng Zhang <jszhang@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: soc: sophgo: Move SoCs/boards from
 riscv into soc, add SG2000
Message-ID: <20250211-squishy-blip-8ac4cf64d462@spud>
References: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
 <20250210220951.1248533-3-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3/BNf11h93vTDDr6"
Content-Disposition: inline
In-Reply-To: <20250210220951.1248533-3-alexander.sverdlin@gmail.com>


--3/BNf11h93vTDDr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:09:42PM +0100, Alexander Sverdlin wrote:
> Move sophgo.yaml from riscv into soc/sophgo so that it can be shared for
> all SoCs containing ARM cores as well. This already applies to SG2002.
>=20
> Add SG2000 SoC, Milk-V Duo Module 01 and Milk-V Module 01 EVB.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../devicetree/bindings/{riscv =3D> soc/sophgo}/sophgo.yaml  | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{riscv =3D> soc/sophgo}/sophgo.=
yaml (80%)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Docume=
ntation/devicetree/bindings/soc/sophgo/sophgo.yaml
> similarity index 80%
> rename from Documentation/devicetree/bindings/riscv/sophgo.yaml
> rename to Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
> index a14cb10ff3f0..5d73d0ccc547 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Sophgo SoC-based boards
> @@ -26,6 +26,11 @@ properties:
>            - enum:
>                - sophgo,huashan-pi
>            - const: sophgo,cv1812h
> +      - items:
> +          - enum:
> +              - milkv,duo-module-01-evb
> +          - const: milkv,duo-module-01
> +          - const: sophgo,sg2000
>        - items:
>            - enum:
>                - sipeed,licheerv-nano-b
> --=20
> 2.48.1
>=20

--3/BNf11h93vTDDr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6uUbwAKCRB4tDGHoIJi
0iP8AP9Mc/wlam2GgeEuieW+XaQ1w6dG0Bj4kXG2xUCIG5ayXgD/UBsEkKFcu+7I
ozzxFKHl9x4z4ZZ2vx1qTuKO/mt7JA4=
=SHXJ
-----END PGP SIGNATURE-----

--3/BNf11h93vTDDr6--

