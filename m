Return-Path: <linux-pm+bounces-40765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D323BD1B6A8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 22:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8598D30222F0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 21:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A0328B72;
	Tue, 13 Jan 2026 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7DOZsRt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA573191D8;
	Tue, 13 Jan 2026 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340096; cv=none; b=UdVhQCj50eUpCYHY5IA/IhEK80ODmCnx7yooJEdovCeHA2DPhHImhu1cVeyAnBvAXwIsxTcgI9aiQO+L46zfzst7b+QgRT/+HBDWebnT6Q7y/ajInOXE+MVda0orf994sKAFqA2cNGGIAF/Ok8YTOarhlmc/x4kysLc2e8n2XvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340096; c=relaxed/simple;
	bh=AnaM8x3f3W5v51ldvRJdYxt23fxs7tH71LL/EHiuuHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6orTYFF6Fvk+8TMESF/nesYfu2gVH+xZZc8k9zdJiP2A/T+jPi6PU3McMUO7f+5AgHV4Z6AGt/SjK/Md8f0o6tjEaPOP6agI0Er5mucsMCcujvjOcDY5GjPtiJHmIk3VzAu0KMQSJfmD788p9gKBKBEhFydV/3OUQkkTzqet98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7DOZsRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2E4C116C6;
	Tue, 13 Jan 2026 21:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340096;
	bh=AnaM8x3f3W5v51ldvRJdYxt23fxs7tH71LL/EHiuuHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7DOZsRtYsi8tQ07yvJmBY197Ps+YF5i45xHC7lnF4We8vBF0KOQCCjaVE6MQnmK1
	 BewQRe/Xe4mibBZd+IiOA/EHpZ35RqlMKn3vXzTrRWoDKCwRtzRqcVTAvOaejd6mqF
	 uLXiD+wmN1eNahhvm826cWRK/mjL2Cy3NWCufJG6E47CoYYGE6g/GlCFzTAT9lhLGq
	 wxIZ6phqwK0QtFlfy08DmUoeduPbP8q4PLVaUHUxxCU2bjhEDaMXvUb2VB339469vz
	 tuH22HCo0I2X9kszfxQOmyCpH1gfKA5L48itAsFk0HskG+P7FQ1goKEocSuvGAXtGU
	 k22NPKK05CY4w==
Date: Tue, 13 Jan 2026 15:34:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ulf.hansson@linaro.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, sboyd@kernel.org,
	mturquette@baylibre.com, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: mediatek,mt7622-pciesys: Remove
 syscon compatible
Message-ID: <176834009281.195401.17311235589252333547.robh@kernel.org>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
 <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>


On Tue, 13 Jan 2026 12:00:08 +0100, AngeloGioacchino Del Regno wrote:
> The PCIESYS register space contains a pure clock controller, which
> has no system controller register, so this definitely doesn't need
> any "syscon" compatible.
> 
> As a side note, luckily no devicetree ever added the syscon string
> to PCIESYS clock controller node compatibles, so this also resolves
> a dtbs_check warning for mt7622.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt7622-pciesys.yaml        | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


