Return-Path: <linux-pm+bounces-34915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73CB81A93
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 21:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1676487FDD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245A3002B6;
	Wed, 17 Sep 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFbRYeMG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A22FDC47;
	Wed, 17 Sep 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137914; cv=none; b=KObQ724JlV82++g/8VymxotZcVfrQExxdz45HNh0/SOU541A9f2JNqqeGoxeXeHJw3aH1TrGmvGK3Ub9pGxxg2srket6NABZi89Dl4571JirrJq/YpZYJI9FgfBuRl0ot+pGM8roNuDxYH829xLEwYF39M0QQ9ohYzpzqifv4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137914; c=relaxed/simple;
	bh=I2AI4BKkKagGVUrVHimGZofS8/2mTShePgfHGGxipNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqsCB2woXKMcSsB61vgvRaq6OX7aK0Yvlr+P5DJHnF7ZG9aVjZWZ6H+vZVFsmGQ8/fnhobv7Jg2Xium3KOhQliiEW3Ekmlnarm5UZH2331t63I0b8p6BbH0JH9D1mQDx5PMME+wXu8225mh140wM2gRMlsyof7Lkuuno/BwMTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFbRYeMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4B6C4CEE7;
	Wed, 17 Sep 2025 19:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137913;
	bh=I2AI4BKkKagGVUrVHimGZofS8/2mTShePgfHGGxipNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFbRYeMGR/o/BJukbFrXOw9dXANO1Q319+ChFzDZz1efuhl2AvFA4ZkUpf9Ja5Byj
	 kAs2X3gD0hX3u+p+r5xqeicUbv6YWx4CRoURTLTM31KVA8xnO1fKX2kbOZT3k/pzzx
	 SJFUNlBfWm0cugPN5PMsh8WVgZSWouoWOyEQ/3S1Wn5WB10C/e8sAABoEeynKJIWxJ
	 MpDSc/I2Kr86NiO58vERp3J9nVueHTa0VzHluvRKyRywO5PXfA8DVz1rdCTpOQ9nYS
	 WNveoFVE18QI60NNTM3cs4H/LXBZgPzL7nSVQ9RCqgzhEcBz01dE5xTJw77myyQozJ
	 vtcHLQtlQnumA==
Date: Wed, 17 Sep 2025 20:38:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: claudiu.beznea@tuxon.dev, sre@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	linux@armlinux.org.uk, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 add lpm binding
Message-ID: <20250917-zeppelin-stoppage-0d0f876df93e@spud>
References: <cover.1758051358.git.Ryan.Wanner@microchip.com>
 <d8fc40a97008cb0b4001684b3c9e1cc4bf3fb706.1758051358.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b4L9u9zjttjH2OaC"
Content-Disposition: inline
In-Reply-To: <d8fc40a97008cb0b4001684b3c9e1cc4bf3fb706.1758051358.git.Ryan.Wanner@microchip.com>


--b4L9u9zjttjH2OaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:50:30PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Varshini Rajendran <varshini.rajendran@microchip.com>
>=20
> Add microchip,lpm-connection binding which allows to specify the devices
> the SHDWC's Low Power Mode pin is connected to.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> [ryan.wanner@microchip.com: Add sam9x7-shdwc SoC to properties check]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../power/reset/atmel,sama5d2-shdwc.yaml      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-=
shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-sh=
dwc.yaml
> index 9c34249b2d6d..668b541eb44c 100644
> --- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.y=
aml
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.y=
aml
> @@ -56,6 +56,13 @@ properties:
>      description: enable real-time timer wake-up
>      type: boolean
> =20
> +  microchip,lpm-connection:
> +    description:
> +      List of phandles to devices which are connected to SHDWC's Low Pow=
er Mode Pin.
> +      The LPM pin is used to idicate to an external power supply or devi=
ce to enter
> +      or exit a special powering state.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

This sounds like you're some kind of power-domain provider. Why doesn't
that generic kind of thing work for you?

> +
>  patternProperties:
>    "^input@[0-15]$":
>      description:
> @@ -96,6 +103,18 @@ allOf:
>        properties:
>          atmel,wakeup-rtt-timer: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,sama5d2-shdwc
> +              - microchip,sam9x60-shdwc
> +              - microchip,sam9x7-shdwc
> +    then:
> +      properties:
> +        microchip,lpm-connection: false
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.43.0
>=20

--b4L9u9zjttjH2OaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsONAAKCRB4tDGHoIJi
0khOAP4w+nqJZTDRdwIeHuDir6MUFS8oTf5bETZiaLu4/AUpSgD/X3WcFvUR5xsN
MyuU9dCTT8Z0XR1E5SE8px0sU/PsJgs=
=OrR5
-----END PGP SIGNATURE-----

--b4L9u9zjttjH2OaC--

