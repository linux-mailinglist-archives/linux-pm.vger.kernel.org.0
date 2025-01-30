Return-Path: <linux-pm+bounces-21159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B92ADA237E4
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD0E188698F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255971F1305;
	Thu, 30 Jan 2025 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPe1eyds"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F812C499;
	Thu, 30 Jan 2025 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280036; cv=none; b=MovhCYL91ziquiIKvXmZRwmYY+BocxjdOnkyRgjGH5jZgN/pO2/Td5Z7EnkicakPT11uG7S62b00KwWl1hkreHVJQWSylj5hkXAhrRt/EG6smXWhppAEr6n2NxXUM04rf0hQLFV19paE+epnYWJq6g4v2oH7aPETi9AD4Vq98Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280036; c=relaxed/simple;
	bh=SNxpLIyh55YaYu/hoLrvuDAiZPa2g61UsphjBmtgs1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8hEWfBkBL8ppcMpAKsA1SyNeuw4HQVkIUnfNy1ApuYFxdYNg1Iwk8d60u1VMFV+wKy4MvQL4dwCH8WxBfCEouPO1au55o6yg4CHIrF9SZmFqrmwwwUfLXmdEFS9eBrw+Oa+qXxTLknrRWjN/oc3A3sxjQMKkFMFK4QNPp7OzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPe1eyds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA02C4CED2;
	Thu, 30 Jan 2025 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738280035;
	bh=SNxpLIyh55YaYu/hoLrvuDAiZPa2g61UsphjBmtgs1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPe1eydsdeX665hA6YFhLHITqz8YY5YGlgJWlDLrQIiJTVB8i+0ojHS7KYwpmiBDg
	 9WFsWP8BaUEVqTGb3ffbDU9WnYjPgqyM9WkUkxohjdROJeoqIMc71OTChSeGQzknZT
	 NgtjgwilGvEFrZNEXLDqqzrdhxaiAMHcIuZqdi38yisYV9njItwZPMCFpLnlc9NUuz
	 ACruYmH/yVSCaf+h0Koya20nO3+hU9Yc0UekLX0WjXsMaPHtsIWj/PwFbC/Ysktg2+
	 4dIlx/ObXD1T9F5LQ1HW8fUMKCIilRYUrNU2DmLr/H9QMG5V+824bFSDwjbeTYqyY3
	 MJh2vZS04bnbw==
Date: Thu, 30 Jan 2025 17:33:54 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.beznea@tuxon.dev, sre@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 01/16] dt-bindings: mfd: syscon: add
 microchip,sama7d65-ddr3phy
Message-ID: <20250130233354.GA1868322-robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <01181325b16c78ac50b8bab3f178b14e8f417892.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01181325b16c78ac50b8bab3f178b14e8f417892.1738257860.git.Ryan.Wanner@microchip.com>

On Thu, Jan 30, 2025 at 10:33:41AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 DDR3phy compatible to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index b414de4fa779b..54a6d5957e13a 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -188,6 +188,7 @@ properties:
>            - microchip,lan966x-cpu-syscon
>            - microchip,mpfs-sysreg-scb
>            - microchip,sam9x60-sfr
> +          - microchip,sama7d65-ddr3phy
>            - microchip,sama7g5-ddr3phy
>            - mscc,ocelot-cpu-syscon
>            - mstar,msc313-pmsleep

Actually, this needs to be in both lists of compatibles.

> -- 
> 2.43.0
> 

