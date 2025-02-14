Return-Path: <linux-pm+bounces-22067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B7A358D6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21D03A7A4B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 08:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59E227BA0;
	Fri, 14 Feb 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9pPn/G6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA53227B96;
	Fri, 14 Feb 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521653; cv=none; b=fQM6M6xT77J2iN5iIJJhikpnB8F6CLmzvE2RitWXKzhRMHQsHWsCLZ/CmCjNctFeQ3XMSJScOzCkzzhtH0mBKfuTJxeTeFUHtjPPkHqfcR1ysCkZ5w+O2/Du2U8LayrJejLTDT/h/Hoah1H0+/sYfPBIVww465B+6Bm0pgzGj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521653; c=relaxed/simple;
	bh=umGs2f8JsxE41Yq3/TX60DBVwiLiOcTZOkxMPH65zVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4N9EWNy/3oC/VT/vL77SmnVutqHFQAtbdczgErWDy2CE8yQYM3zL9/ohmZGdnYqhDo/0crRVESHtewqVcamf9R8hV1jKmKbFjgPa5mHMsakBTLl83mwsZdVEtmjemP35wfbGq/iNMCr+Y79Yi9raji1noiC2o1jzHI+9yQmtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9pPn/G6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C2C4CEDF;
	Fri, 14 Feb 2025 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521653;
	bh=umGs2f8JsxE41Yq3/TX60DBVwiLiOcTZOkxMPH65zVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9pPn/G6xAXrX7koevvifKhjd8InbQfDSr4R4fneKtezV5CGNSKnrio1ZhBmBl0rm
	 7TSZzklUVz/5t95PoK64ywDLnVLCaaJzEGW3PkLtXfILnBs3k7Pl+sY6h4wlluc2ai
	 tL7OEWByg4+W/k1THY54Yo6sS8ODkCcmZ8hhl/PYmhggJo93c9B2oEZ3p1Md5+TGkr
	 oJ8Q/Lclwp0rABoNHUcxxj0Jo0x6Z3ODMYSE8wvblVpR5jLykG7L+BRaKeW5OJEP89
	 vzNK25RWx+z6c4X5AfQrIIlpXGpQCygZMIlzr1F3dKmOe1enDzve0sx59xyNec+QtK
	 C15godChkxIkg==
Date: Fri, 14 Feb 2025 09:27:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, p.zabel@pengutronix.de, 
	linux@armlinux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 05/15] dt-bindings: reset: atmel,at91sam9260-reset:
 add microchip,sama7d65-rstc
Message-ID: <20250214-flashy-myna-of-opportunity-dce05a@krzk-bin>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <b78ea6d7b306bca7012cff604b67b65b89b41093.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b78ea6d7b306bca7012cff604b67b65b89b41093.1739221064.git.Ryan.Wanner@microchip.com>

On Mon, Feb 10, 2025 at 02:13:05PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RSTC compatible to DT bindings documentation. The
> sama7d65-rstc is compatible with the sama7g5-rstc.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/reset/atmel,at91sam9260-reset.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
> index 98465d26949ee..a1c21c3880f9d 100644
> --- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
> @@ -23,6 +23,11 @@ properties:
>                - atmel,sama5d3-rstc
>                - microchip,sam9x60-rstc
>                - microchip,sama7g5-rstc
> +
> +      - items:
> +          - const: microchip,sama7d65-rstc
> +          - const: microchip,sama7g5-rstc
> +

No need for blank lines around. It's making it unnecessary long.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


