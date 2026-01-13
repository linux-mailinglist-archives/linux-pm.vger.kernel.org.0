Return-Path: <linux-pm+bounces-40764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A3D1B69B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 22:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDB323006E2E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E9322C70;
	Tue, 13 Jan 2026 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S44/Skx2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05A31A7EA;
	Tue, 13 Jan 2026 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340061; cv=none; b=Cp0rqTftg1BkaxZRXW0RRHSIqZisxarsy81GhYsv01BfD+vXRi8iyy4cX1l3AEZ+IY0YBi6xVOE1iS877CaHQfKvXCSxxsfWkPxkWGt88/NlO1I4lhhNsANnBCh/HoecDof1TgW57E73qofUGh8cn/wJUlKJdAqEgSzygqlH5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340061; c=relaxed/simple;
	bh=C8GY8cY1NPh06GheL3PI5yKEb9iGVDbttIMOqkOAQy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn1ezBi/m5o+JsWRqA0YCyyAlZsiyANVYaH+EvX67n3sPO1RxTX1eapwdWC3HVShechHtLUgctwpDsI+E02mrnexW4GWqHeiJkw1/sGb2KKtgq/RfX/FTGany/bUGf9MhwsesOXEZFho7RmEzmnadLlylsfPYlCGhw1TMFWuGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S44/Skx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0665BC116C6;
	Tue, 13 Jan 2026 21:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340061;
	bh=C8GY8cY1NPh06GheL3PI5yKEb9iGVDbttIMOqkOAQy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S44/Skx2XyfAHnQodwMvo1uWbXWROjumbv+wTGkLh1Bc9mAeNJ62XvVmWlSQAZtFC
	 j4C7rCGG1G+SUOSz42VAxv3RYkBtPqdeK7nMF8H3vcoLyN0lOViTK6aF5E6OH2/nQS
	 RYa3Uva8x00NMfLXCIyJ9xINF9LeC0loeTq9kduVSoCce7clL9I4BIgPW733+ZpktU
	 SzvUJQI+2nBDjkWZdJ87xHxfxPtJeEbmiPbbtIzT3IoNoIORcANvcjROZxJWt/pAce
	 rDhM3TlrUoNFiHXBzVi6XTJoUF6sUYwIqVDk61tSm856OMTWxocAQqT3UdWwneOdp1
	 WP3XPuuXXpT9Q==
Date: Tue, 13 Jan 2026 15:34:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mturquette@baylibre.com, linux-pm@vger.kernel.org, sboyd@kernel.org,
	conor+dt@kernel.org, kernel@collabora.com, matthias.bgg@gmail.com,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: power: mt7622-power: Add
 MT7622_POWER_DOMAIN_AUDIO
Message-ID: <176834005718.194670.8916534798894456790.robh@kernel.org>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
 <20260113110012.36984-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113110012.36984-3-angelogioacchino.delregno@collabora.com>


On Tue, 13 Jan 2026 12:00:09 +0100, AngeloGioacchino Del Regno wrote:
> Add the missing power domain for the Audio IPs in this SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/power/mt7622-power.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


