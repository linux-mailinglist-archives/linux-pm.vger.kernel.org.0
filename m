Return-Path: <linux-pm+bounces-24553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90952A72B27
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 09:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A41E3BA7A2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8D01FFC49;
	Thu, 27 Mar 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQitGDUy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD501FF7D6;
	Thu, 27 Mar 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063080; cv=none; b=m/hfVA037TNCuNEq+ui5W9yYe6cub4uoC3DKpp0/pySTzCVGSG6HDOL3HB3sH2f4piKDsKDogNifjIO6zllRfHl5b4vDcTlNSmGmhK1oiRNFRq+yT+WrLXWPDFS7vOR4gX9oOv8V5WC/DGS3M8mKR6Jm9rcafTMI8M+6AMidEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063080; c=relaxed/simple;
	bh=bmXqFqU22qluSfxAA/IxXQn2uRD9aGuQ4sNUF6q33mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oumew7bhuevTBS6Hux7N6to1tifSx0ZLrtQ17xgZygvfisCtf/XNus9jok5rFyXufDNmHKkx0hnvAIcClUBuSdsgkV+QdqOdOiYzCrlOpoEnYoGw7SuHdZt8nbEvZWqO6dfxUEbwvW4mFPRt+GTNrXuu3drmtGX8WQET80qwS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQitGDUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE544C4CEDD;
	Thu, 27 Mar 2025 08:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743063079;
	bh=bmXqFqU22qluSfxAA/IxXQn2uRD9aGuQ4sNUF6q33mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQitGDUyAlG1CIo/auYlxpRBRrN95Gymr8nzmSj2Bn7K8PkVAvTCgSFJDhY/nVWs1
	 yWlVnM9QbuxeYrNtbL+kLC0j9R1bhISfo1VVxfGZtmOO4U3UqG+lEODshvmvzc3xGi
	 GWBjUxVZwdeG59X+9ZY9FU7w3j0NZBlzXlPD3UikmIHyc1uyBC/6k4NQRoE6/HtoCl
	 ONEpliDvX6/jIddCO2AUdsR1E+lZTOLoWwii+++23Ceezs8IGTdvazTujhORk6Yh7f
	 ZprQka3sxc4n1k/olZnuIBeD6LTx6lfwUpJFi97h8wl/DLsX3Cup/reseKhJHIsrlL
	 cn57K0VDwuogA==
Date: Thu, 27 Mar 2025 09:11:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	lee@kernel.org, sre@kernel.org, p.zabel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 08/11] dt-bindings: mfd: syscon: add
 microchip,sama7d65-secumod
Message-ID: <20250327-nocturnal-fulmar-of-holiness-6b6ac5@krzk-bin>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
 <7248bb9d4ed491b178072b09830d6d68fde7b872.1742936082.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7248bb9d4ed491b178072b09830d6d68fde7b872.1742936082.git.Ryan.Wanner@microchip.com>

On Wed, Mar 26, 2025 at 08:35:41AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 SECUMOD compatible string to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


