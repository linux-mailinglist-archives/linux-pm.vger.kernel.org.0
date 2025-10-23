Return-Path: <linux-pm+bounces-36754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C78C02EF8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 20:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F8C3AFCA1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0799B34C9AA;
	Thu, 23 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d44D9cIt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBFD23F40D;
	Thu, 23 Oct 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244089; cv=none; b=apmGDwmZazhVXaPe+G55IMAcTbAYui5vCdznRhKMD1bCk8hAwOZzjKcA7sCVK+tOSNYMvYwf5GuFOQW3t38LuMxQVbN1vxkKcE6mQjqwwS8wEEuzT7zINfN5Am2qYGv7lpdkVSKszkxWo4MuUUgo4SkDSKZDjrJx6G433l3bPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244089; c=relaxed/simple;
	bh=cGxtT7v2QVMLn1P8NSEXbxLIEFsg1vLsHaVWtilPBJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTbBoEDBTJjNEMOKvhqqDCF6A6A94lZCc6yxThiIp1/xxXesyGhDHNpNvGX+SJfcP3v6IlNzoHT/U4JxWb8AuasvbEV2jBpcWiGomZ5qNGVmG5AoTkSubMpgSdGAtNy76zdUQSqmngoHRyU20Kk0oGOq648e40hTrOsEzoeocP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d44D9cIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E70C4CEFF;
	Thu, 23 Oct 2025 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761244087;
	bh=cGxtT7v2QVMLn1P8NSEXbxLIEFsg1vLsHaVWtilPBJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d44D9cItbQrcUg9iAmRA0Vs/DVqR+y0ypS8CepbttdCZ0quavmx1O5RuHNLBQ+VVS
	 Hk9CB2f0ii7zfWJET2k2ktByN18QFNj7RuwS+E60fNAqsfB+U+jd75LxA0v+MsfKCG
	 pROr3dfPhBazSFR4t1gzPXCBkKTBQ5yhB34OJqc1E09BdynZid7mDKMO2A9Ja1qsOo
	 bQvjMiOr/sxY8PzMSvTtbmu1SfAaVa/3KsuA7jMuAnty9u9OpZm6TBYZq5yZTrI8JM
	 1IieU8qkXXu/XkyFWrxtvd+N2LpnC5OA5SGucqrFNsfiRa6K8cdQsny/O6a5Xf4qR9
	 3MOIOFlebcXhg==
Date: Thu, 23 Oct 2025 19:28:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: thermal: r9a09g047-tsu: document
 RZ/T2H and RZ/N2H
Message-ID: <20251023-provider-obsession-a03de6982b72@spud>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251023081925.2412325-6-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztccTYdyCrUtiwjn"
Content-Disposition: inline
In-Reply-To: <20251023081925.2412325-6-cosmin-gabriel.tanislav.xa@renesas.com>


--ztccTYdyCrUtiwjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:19:19AM +0300, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include a
> Temperature Sensor Unit (TSU). The device provides real-time temperature
> measurements for thermal management, utilizing a single dedicated
> channel for temperature sensing.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  .../thermal/renesas,r9a09g047-tsu.yaml        | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-=
tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.=
yaml
> index 8d3f3c24f0f2..3cb66b51831d 100644
> --- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> +++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> @@ -16,7 +16,14 @@ description:
> =20
>  properties:
>    compatible:
> -    const: renesas,r9a09g047-tsu
> +    oneOf:

> +      - items:
> +          - const: renesas,r9a09g047-tsu # RZ/G3E
> +      - items:
> +          - const: renesas,r9a09g077-tsu # RZ/T2H

These two should just go together in an enum, no need to overcomplicate
things with items like this. Items is only needed when you have more
than one.
pw-bot: changes-requested

Cheers,
Conor.

> +      - items:
> +          - const: renesas,r9a09g087-tsu # RZ/N2H
> +          - const: renesas,r9a09g077-tsu # RZ/T2H
> =20
>    reg:
>      maxItems: 1
> @@ -59,12 +66,21 @@ required:
>    - compatible
>    - reg
>    - clocks
> -  - resets
>    - power-domains
>    - interrupts
>    - interrupt-names
>    - "#thermal-sensor-cells"
> -  - renesas,tsu-trim
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-tsu
> +    then:
> +      required:
> +        - resets
> +        - renesas,tsu-trim
> =20
>  additionalProperties: false
> =20
> --=20
> 2.51.1.dirty
>=20

--ztccTYdyCrUtiwjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPpzsQAKCRB4tDGHoIJi
0jLUAP9gk1QFec0eyq7sJ7ydWHY9nm23V1ez/A8cZ5mitKk57wEA1gTFHul1tHzp
Ho7K/mCR0kYFT4WNKfTrmnJZ5qruYAk=
=ufQ1
-----END PGP SIGNATURE-----

--ztccTYdyCrUtiwjn--

