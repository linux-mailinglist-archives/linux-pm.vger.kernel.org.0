Return-Path: <linux-pm+bounces-21787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45B8A30567
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645F93A73C0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2881EEA43;
	Tue, 11 Feb 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBS1Edqg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DC1EE7D9;
	Tue, 11 Feb 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261649; cv=none; b=lY6naeRamHZihRRZyM9IcWAzFms2wMPz4fiTIHDzG6dIA1ED2CcU2I9/bddJvopzcEXSf3B5z6TGKtcbv8LefutLlZyApfM7uAoGIFnduOs+L5naAHFiM97WsJG6nHvRNcEhDg4RSjIyzAHTJfbnCEZvV8jwQt9wDavlTFjuNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261649; c=relaxed/simple;
	bh=unoYhASJ+/qHhx7k6LpCsLJmOJOp+s9rLvwQK25VuZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUo3FDtMDFal6hH3IxnzFhSsbpiiYJ5fO/YtLwqIzatj6ewDKxx+V6iR8GMU2bi/XQ3maof2FEbPRcYYEWnx/aqusgPXp2lRh+BiGUAKbZxSgtyIUaPxee15e2QiHm98q/ZU7Is7nreSqelIjObYpjvVGR1fNoEwSgRCBs9THHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBS1Edqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5658FC4CEDD;
	Tue, 11 Feb 2025 08:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739261649;
	bh=unoYhASJ+/qHhx7k6LpCsLJmOJOp+s9rLvwQK25VuZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBS1EdqgQRE1dQVxHta3hdmqDl9duJOx1SHlKeePRtGFaKTmSYVl2oqe6xJA7ipEV
	 Rtdxfn7Y3choQRAgPG6sqXtRlytZLMgwsIHk77CgmlWfzdZJ+qovOYTfipYs+h1Ixm
	 Ggx7V+XAl9SeN2snHQzdPwAMvDXVjOyAyONKszdbnZtah3ZGhpk8FyCBCxrW6/wogA
	 5ljF7Lr4Aoido7bHTHXNx1l1kQQyzDLvsaMb81koA9WrVMgqHw8UaNkiLC58gzduoS
	 lVqVybf+vcva03QcyDKgL6ZhgAqDxdfIyW7wlLqXDWOZJAsijUZGXGIqdKUWnTccsz
	 pQgG986/b9YsQ==
Date: Tue, 11 Feb 2025 09:14:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, p.zabel@pengutronix.de, 
	linux@armlinux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 02/15] dt-bindings: mfd: syscon: add
 microchip,sama7d65-sfrbu
Message-ID: <20250211-therapeutic-futuristic-parakeet-204cae@krzk-bin>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <4cac19e32295c708d72b9fc6ba342b5c961fb6c3.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cac19e32295c708d72b9fc6ba342b5c961fb6c3.1739221064.git.Ryan.Wanner@microchip.com>

On Mon, Feb 10, 2025 at 02:13:02PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 SFRBU compatible string to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 51d896c88dafa..727292ffe092e 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -91,6 +91,7 @@ select:
>            - microchip,mpfs-sysreg-scb
>            - microchip,sam9x60-sfr
>            - microchip,sama7d65-ddr3phy
> +          - microchip,sama7d65-sfrbu

You got comment on #1 of your v1, so if you make exactly the same
mistake in other patches then fix it there as well.

Apply v1 Rob's comments to all your patches.

Best regards,
Krzysztof


