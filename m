Return-Path: <linux-pm+bounces-6171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA789EF58
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 12:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF20C2826E5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563DE156C61;
	Wed, 10 Apr 2024 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdK7i2z4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287528BE8;
	Wed, 10 Apr 2024 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743199; cv=none; b=l3Eo8My6HR7fW4O72fq9uDvjkzDvU1IPPtUkCMlm9i+RoQKxxfMFR4R6gkFbdD5eDn58gpavyvmwN6bfLsHoYiAx1ZcOYYskDCZVgZVIE6N6VQ5XdKyBdDruct93t8FWhyI+Av1VjZcD6/X6cfGSITnFs0JQwGbFtCUhd1cDoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743199; c=relaxed/simple;
	bh=HIEprZwW3uNJfjxRejUb9wp5IoV3615xoL6q7pONnZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkEwM22Etc7F4itiEh562hT0XQcw9sJ5a8C5+FhtlApnzfwAEuO71w+4OrJEYZbfns2g3INeY0W6EOcJ4TTcN40+W+A8UWWdS8RSW9vH1BL2tvj2Bf43MCSKGvBUubic56C6kuK8/MK7QUeZjp3v8ZTnT1DWOZTWznOQDtq6FyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdK7i2z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FF6C433C7;
	Wed, 10 Apr 2024 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712743199;
	bh=HIEprZwW3uNJfjxRejUb9wp5IoV3615xoL6q7pONnZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdK7i2z4xkqbpJTz+jo/ZQxiEMeEDlrVmS1TU0A8Cfr7K84sSoTE3lBVFGaafzcKQ
	 WWZreqjxD18LDdXgAifBvZrBlfe5TBz1OtQga7/xted3WDm9oB18i+VtroHFteMDUN
	 BQw1tqsNkS825AM1BjyFgdY/MXMXtR8onp428Jx1PuaxCDe7IvyFm3w9X/g2hmE20A
	 cphTw5fZXSbzeAJS+K+X6BFnOWlH8Vx+87I4l+BK+DC38lW8w4tBwcQMUrJkmcNLsb
	 MqQFHDXIqlr+J2D3Iq14KH8zL7/atev/b7Um+qwdgjSzhdszz3GNSmrtBf334BJdV6
	 w6ZFNxGTMfHhQ==
Date: Wed, 10 Apr 2024 10:59:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>,
	WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH 3/4] dt-bindings: thermal: loongson,ls2k-thermal: Fix
 incorrect compatible definition
Message-ID: <20240410-wrecker-procreate-11e0915f7bbd@spud>
References: <cover.1712733065.git.zhoubinbin@loongson.cn>
 <217ce2745a8787c504bbda1d085daba7e9cb2f70.1712733065.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0hJFhA/h1Zb6GzGw"
Content-Disposition: inline
In-Reply-To: <217ce2745a8787c504bbda1d085daba7e9cb2f70.1712733065.git.zhoubinbin@loongson.cn>


--0hJFhA/h1Zb6GzGw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 05:49:02PM +0800, Binbin Zhou wrote:
> The temperature output register of the Loongson-2K2000 is defined in the
> chip configuration domain, which is different from the Loongson-2K1000,
> so it can't be fallbacked.
>=20
> We need to use two groups of registers to describe it: the first group
> is the high and low temperature threshold setting register; the second
> group is the temperature output register.
>=20
> It is true that this fix will cause ABI corruption, but it is necessary
> otherwise the Loongson-2K2000 temperature sensor will not work properly.
>=20
> Fixes: 72684d99a854 ("thermal: dt-bindings: add loongson-2 thermal")
> Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../thermal/loongson,ls2k-thermal.yaml        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.=
yaml
> index 9748a479dcd4..a25b42702788 100644
> --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> @@ -18,14 +18,15 @@ properties:
>      oneOf:
>        - enum:
>            - loongson,ls2k1000-thermal
> +          - loongson,ls2k2000-thermal
>        - items:
>            - enum:
>                - loongson,ls2k0500-thermal
> -              - loongson,ls2k2000-thermal
>            - const: loongson,ls2k1000-thermal
> =20
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> =20
>    interrupts:
>      maxItems: 1
> @@ -41,6 +42,23 @@ required:
> =20
>  unevaluatedProperties: false
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - loongson,ls2k2000-thermal
> +
> +then:
> +  properties:
> +    reg:
> +      maxItems: 2

You need a minItems: 2 here also, so that providing only the original
reg is not allowed anymore.

Cheers,
Conor.

> +
> +else:
> +  properties:
> +    reg:
> +      maxItems: 1
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> --=20
> 2.43.0
>=20

--0hJFhA/h1Zb6GzGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhZjGQAKCRB4tDGHoIJi
0kfpAQDVyTE1sy+ArjjVSZps6stwpjF99KhH+aEb9dFZH+NncAD+NF55jrDXrpyT
yVDMqwejFh+JDdXBvj/kzmMKvaT8nwQ=
=y/aq
-----END PGP SIGNATURE-----

--0hJFhA/h1Zb6GzGw--

