Return-Path: <linux-pm+bounces-32053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DCCB1E3AD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF5188E630
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA323F291;
	Fri,  8 Aug 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZy8Mme7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DD1D54C2;
	Fri,  8 Aug 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638547; cv=none; b=NUmtGmRGE1mP6ltM/6Wg4Ng8FjB9ws0cZdq6Wjh7yvUaGNxx6A/hYlWNi2If01hKfc9RZmK/fbVjHamKJsrKoT24g0CqyNQJIovXmDhYC1VptxdUCHdZ6F8CgXCHeI9ngWE5689fDci0+sX+jalEFQBi51aRdmUF1c94v3Z9Vys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638547; c=relaxed/simple;
	bh=fSFQ4BFpgAzz0JTLtrpfPT919diDmGwK+Dw9OkWmuBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb6joYMHuEw3olicibi3l5pzwT0bbmTFalmi8NJ6XUe1AHJrr2zgv30v7IVIvI2a+6aboMcT3Mm7kBzBZuZxVCDvgoBmI8MFFbNn1zFXuqr5f9icvvIUiKxBhqIhWRvxSGTUEyEpXpIhO7WHGLHq3BppUUOwL5983UxmWHB6vrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZy8Mme7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E7C4CEED;
	Fri,  8 Aug 2025 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754638546;
	bh=fSFQ4BFpgAzz0JTLtrpfPT919diDmGwK+Dw9OkWmuBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZy8Mme7TpW+NGxATpczCzeRM6bqUT5ztLWouhxQrAQQ29h9gpy4Efhg9SvkfZ86Y
	 Jk/Y60NKWGoRpxKrKAn/gYvH9JDy+jqeUQdckwhWK/+NoJVphBCR+FxAqCCfUoyj6i
	 meBtj4HyISCka6PY43NN1jLZiqLazDBiihwTP8gZRWFA3Sc5oqVHnFp1DMpYUNXOBc
	 hsKvtpVvdhFG++wPnQ5GLIjl5oeZHn36yw8Gq/+ehwBCsL3zxXW6W3CaUpOQNag2Kg
	 BCzpIBrdztWJbwAVvFRVxun9GjgHOg/+bCVwefGxcZ/L67C0yT9A2gweRTeiC9lAm8
	 P22Evj6X/7TPQ==
Date: Fri, 8 Aug 2025 09:35:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, David Wronek <david@mainlining.org>, 
	Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC 1/5] dt-bindings: clock: marvell,pxa1908: Add
 simple-mfd, syscon compatible to apmu
Message-ID: <20250808-amusing-ladybug-of-joviality-3fb371@kuoka>
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
 <20250806-pxa1908-genpd-v1-1-16409309fc72@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250806-pxa1908-genpd-v1-1-16409309fc72@dujemihanovic.xyz>

On Wed, Aug 06, 2025 at 07:33:20PM +0200, Duje Mihanovi=C4=87 wrote:
> Add required syscon and simple-mfd compatibles to the APMU controller.
> This is required for the SoC's power domain controller as the registers
> are shared. The simple-mfd compatible allows devices whose registers are
> completely contained in the APMU range (such as the power domain
> controller and potentially more) to be children of the clock controller
> node.
>=20
> Also add an optional power-controller child node to the APMU controller
> to accommodate the new power domain driver.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
>  .../devicetree/bindings/clock/marvell,pxa1908.yaml | 36 ++++++++++++++++=
++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml=
 b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> index 4e78933232b6b925811425f853bedf6e9f01a27d..5e924ebd97e6457191ac021ad=
dafd22caba48964 100644
> --- a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> +++ b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> @@ -19,11 +19,15 @@ description: |
> =20
>  properties:
>    compatible:
> -    enum:
> -      - marvell,pxa1908-apbc
> -      - marvell,pxa1908-apbcp
> -      - marvell,pxa1908-mpmu
> -      - marvell,pxa1908-apmu
> +    oneOf:
> +      - enum:
> +          - marvell,pxa1908-apbc
> +          - marvell,pxa1908-apbcp
> +          - marvell,pxa1908-mpmu
> +      - items:
> +          - const: marvell,pxa1908-apmu
> +          - const: simple-mfd
> +          - const: syscon
> =20
>    reg:
>      maxItems: 1
> @@ -31,18 +35,38 @@ properties:
>    '#clock-cells':
>      const: 1
> =20
> +  power-controller:
> +    description: |
> +      Optional power domain controller node.
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: marvell,pxa1908-power-controller

I commented on next patch, so oly to re-iterate here: no, don't create
nodes just to instantiate drivers. You do not have any resources here.

Best regards,
Krzysztof


