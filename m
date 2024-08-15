Return-Path: <linux-pm+bounces-12272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D195361E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F44E282DDC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F741A01D4;
	Thu, 15 Aug 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U06hF8jR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1819F482;
	Thu, 15 Aug 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733183; cv=none; b=pWG6pjEsR4r6pGyl6GIonkf8ywKRyF9owrrpcZohFk1vSFAL48TUriqWCxqBFINhqFcGUwqSCQ5YZfnZebThhDCTv2zhUaNgKBMGe8xSPzrJNjdiqvHSLSrmoDjF+RpWMQZgHBZB9TlWRQIBLuk7OqHQ8gk6n/TAlCFQmLvJ2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733183; c=relaxed/simple;
	bh=2NZIG91t9aXuEVWvgGYOj0BanBuBMyaM2N2fVFFn770=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCtFS7CbZKbckbiMhtMcoyzHM21fIdRNIhVfeSFV6kKPi7KDthdPHMOz37rCXD8PV8kLTEHt/tMKSrcSz8bbHrhr77MBhE2EzX/H0BNp4/SXCXqsVm547JDw2HDGxFl55KndweBuwXqvtqZvWaXrTTpbXebDRZp5qkVh39D9KqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U06hF8jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93458C32786;
	Thu, 15 Aug 2024 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723733182;
	bh=2NZIG91t9aXuEVWvgGYOj0BanBuBMyaM2N2fVFFn770=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U06hF8jRuWvZCT2moe8XTqEiNQrQDESBl3uzjurmXWBpuB3BEAFvKJMmN/ivFEYvw
	 +ATLQAqQ5Ym1Vfo5h2ac07HIMjRCHiZ+/c6krSVPAzWIj1rJZlBAjjRGFk5+HWMAch
	 czSTGi8PVyKZ8nHoIzV1zZrB/K8sNRi/9vBrD57WWnrAlkdSHG8DITmUNWLqjMdZ7I
	 YHcfZ/xPtEbnLmPElAKfcuMpjHN8f6tdlryVUkM4j5Ody+XBBxlbeCgxrB10qdWPmw
	 YU4Vf1iZEIi7WNkpVruslFLtu3HiQcQlQPyR+BwNgQL0WsL/FXzAZsy8vhIfzcdSj5
	 yOBn38wTZphJg==
Date: Thu, 15 Aug 2024 15:46:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: sc27xx-fg: add low voltage
 alarm IRQ
Message-ID: <20240815-winnings-waving-1ec5561f90e7@spud>
References: <Zr3SAHlq5A78QvrW@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m3HcwEUYmHiNNTm2"
Content-Disposition: inline
In-Reply-To: <Zr3SAHlq5A78QvrW@standask-GA-A55M-S2HP>


--m3HcwEUYmHiNNTm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:01:36PM +0200, Stanislav Jakubek wrote:
> The SC27XX fuel gauge supports a low voltage alarm IRQ, which is used
> for more accurate battery capacity measurements with lower voltages.
>=20
> This was unfortunately never documented in bindings, do so now.
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Initial Linux driver submission adding this feature:
> https://lore.kernel.org/lkml/ee1dd39f126bd03fb88381de9663d32df994d341.154=
2185618.git.baolin.wang@linaro.org/
>=20
> The only in-tree user (sc2731.dtsi) has had interrupts specified since its
> initial fuel-gauge submission:
> https://lore.kernel.org/lkml/4f66af3b47ba241380f8092e08879aca6d7c35b3.154=
8052878.git.baolin.wang@linaro.org/

This context could go into the commit message I think, as justification
for making the interrupt required.

Also, this binding is odd in that it has several compatibles in an enum,
but the driver (added at the same time) only has one compatible in it.
Are you using the sc2731 in your device?

>=20
>  .../devicetree/bindings/power/supply/sc27xx-fg.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yam=
l b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
> index de43e45a43b7..9108a2841caf 100644
> --- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
> @@ -27,6 +27,9 @@ properties:
>    battery-detect-gpios:
>      maxItems: 1
> =20
> +  interrupts:
> +    maxItems: 1
> +
>    io-channels:
>      items:
>        - description: Battery Temperature ADC
> @@ -53,6 +56,7 @@ required:
>    - compatible
>    - reg
>    - battery-detect-gpios
> +  - interrupts
>    - io-channels
>    - io-channel-names
>    - nvmem-cells
> @@ -88,6 +92,8 @@ examples:
>          compatible =3D "sprd,sc2731-fgu";
>          reg =3D <0xa00>;
>          battery-detect-gpios =3D <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> +        interrupt-parent =3D <&sc2731_pmic>;
> +        interrupts =3D <4>;
>          io-channels =3D <&pmic_adc 5>, <&pmic_adc 14>;
>          io-channel-names =3D "bat-temp", "charge-vol";
>          nvmem-cells =3D <&fgu_calib>;
> --=20
> 2.34.1
>=20

--m3HcwEUYmHiNNTm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4UugAKCRB4tDGHoIJi
0iAeAQCsTRBZC3K9ZGJTgdmaDkgPIwDFvF/uhLqmz2WTOOIp7gEA62K7ZIdtskiw
Gv4q+Qvsp6ItT6782VNoK85NaCGA/Ac=
=Joit
-----END PGP SIGNATURE-----

--m3HcwEUYmHiNNTm2--

