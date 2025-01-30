Return-Path: <linux-pm+bounces-21163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1954A237FE
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 00:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639011887E95
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC081F193D;
	Thu, 30 Jan 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2KR7MBN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0B1537C6;
	Thu, 30 Jan 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280503; cv=none; b=CPKqK9ERm9HIjq1LOEkrYstUz+8B9pBBmdH+ukdnC/ibENpwFqwT0L4zx4CqKcMLNes80tlfKaCYQpOdJ/8fUazGC5GIl0vkhszkqmTpKqreVAd1lwppFeOOo3yU8eaYMJ0EUhcvZhtMtt/Drzt417e3/OmkDk5VyOyeFsvhV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280503; c=relaxed/simple;
	bh=DZnH1OSKYAieF5ajIrEhZsFh+kHI8uiA/TPKhL3dw6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smjvfQBnJz8Vgg/VJEq49tDJefn18tI1XnNF/72kYLMdo+zrqSeW3VwoI8GknHZnC5xmPrGtb+tv50778U2GmaIJIZU5xqnYLfzXgAralKUq6cXnbB9aZQCZ+a2UMg0fXvUKA/Jr/ENWpIpvzbFEhtJJioQWYZBsfVtBzPgDsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2KR7MBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ED8C4CED2;
	Thu, 30 Jan 2025 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738280502;
	bh=DZnH1OSKYAieF5ajIrEhZsFh+kHI8uiA/TPKhL3dw6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2KR7MBNQ4Tja4tmqdEkZ5iykHJ4wCpJOEvqyeIHvOgBCLF7/UoybAVbtfKhGjY7Z
	 gbWdeF78SBMSgoQ7xnFKODerJdP0Keg849c1MP9wDJVztXas3HtuGCU1k8US6JIZuP
	 2sG4aUR//On7A71s5W4A7CAqIWQoUHFsNEVTqDQGwKrIKQbnsZJ8fg+O0NniDyGDmI
	 KOChyx/PamnoM0xzQL4wiI1C8/9qgqCph8Gtnc04t54bJPK/5m0qWCB7xYa/T7ZyLB
	 LpRgJftE2rFgFUSE99QPR8D5Kf/9CNFaJcGteFSlgxjX93c0lXv3CNyNIEIogiUHYy
	 Hstal6Id2r56Q==
Date: Thu, 30 Jan 2025 17:41:41 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.beznea@tuxon.dev, sre@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 05/16] dt-bindings: reset: atmel,at91sam9260-reset: add
 microchip,sama7d65-rstc
Message-ID: <20250130234141.GA1872305-robh@kernel.org>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
 <2350540fd22b181875d3cce272fba87fff924670.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2350540fd22b181875d3cce272fba87fff924670.1738257860.git.Ryan.Wanner@microchip.com>

On Thu, Jan 30, 2025 at 10:33:45AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RSTC compatible to DT bindings documentation. The
> sama7g54-rstc is compatible with the sama7g5-rstc.

sama7d65-rstc?

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
>        - items:
>            - const: atmel,sama5d3-rstc
>            - const: atmel,at91sam9g45-rstc
> -- 
> 2.43.0
> 

