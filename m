Return-Path: <linux-pm+bounces-22069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC14A358E0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 09:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00F93A76BF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8222223330;
	Fri, 14 Feb 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhNhiMYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7366205AB8;
	Fri, 14 Feb 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521722; cv=none; b=No1AwPiIt6vlDp3aHD+gNhTrXto4N2VMqup0egvNwm/AcpRlb6aHhduxTELykAp3ULH3kL7JVnvE8ZeENMCWXyIMP2FJWc8rSTrVZFMAPNO8ZC0OgYveJKzZ98YANszEW8Vnd0qx3fZEvx1wiP/6cZpMRzzqaXqu1/3xHY2V/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521722; c=relaxed/simple;
	bh=KO+4oZsMAUFcx91vxIuqec0dnxFJQO0eihmeoC5Sj+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE7xKmcK9CqoyQFbrOuVlWZnG+BEDWfg+zdT3upGTgNtM0H0jlnz1/b6MTLQbrvFQSSlXDVKtx2voSdNV/SdqHrBvZ8DEj46xDhngH/rUvfHXUe5rhfsqOuBHwSrShuOPOJsk06IkIAukvL/q0yL7yvUKYF4SRUw+OXlYzc2ShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhNhiMYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72D8C4CED1;
	Fri, 14 Feb 2025 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521721;
	bh=KO+4oZsMAUFcx91vxIuqec0dnxFJQO0eihmeoC5Sj+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhNhiMYjLtTSSkKiSa4nhwRRYrn+y3P1wEKQwnh0HC8J5BzL4Sb7t3DTsTvsoqg4K
	 evX/K1/pDmhNbzY5Wq2rk55M/3BU3U4nutfxSmljEe7CcvXbCpe5sE8DPeTQ68F07L
	 tN/GST8oeKidnjTIRU6gSQ54g5Ywsij3NUQB8WaoRS0u3+NVxdGGpI07IzRCRDlbDx
	 kBUaf8ZJlTHFLmWiI0JtcbCHkdm+aMWUWPkP/iUoir2LaJe58/M2o8SSihSH9VP2DU
	 8Z35Ek3cwBOaZAFcFDgrFO7ibpKEmOMq2JyNz/mh55fKdjoQnSHJBTxRki83hHNaIU
	 CNet6dc/8XU1g==
Date: Fri, 14 Feb 2025 09:28:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, p.zabel@pengutronix.de, 
	linux@armlinux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 07/15] dt-bindings: at91rm9260-rtt: add
 microchip,sama7d65-rtt
Message-ID: <20250214-wondrous-strong-shellfish-77f07f@krzk-bin>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <b437898b518910a2f94f7d827608db35e82c5828.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b437898b518910a2f94f7d827608db35e82c5828.1739221064.git.Ryan.Wanner@microchip.com>

On Mon, Feb 10, 2025 at 02:13:07PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTT compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> index a7f6c1d1a08ab..48a2e013a6b24 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> @@ -23,6 +23,9 @@ properties:
>                - microchip,sam9x60-rtt
>                - microchip,sam9x7-rtt
>            - const: atmel,at91sam9260-rtt
> +      - items:
> +          - const: microchip,sama7d65-rtt

I don't think you tried to even read this binding before extending :/.
Look earlier - there is an entry with enum for this.

Best regards,
Krzysztof


