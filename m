Return-Path: <linux-pm+bounces-39698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6DCCECC5
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 08:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF01301339D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CA32BF3DF;
	Fri, 19 Dec 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpBVSxT1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F34A0C;
	Fri, 19 Dec 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129790; cv=none; b=RzugNODfzSav4ELkEI+eUr+flO8sp17/BAiS4RI6MDZL1Qu1JBdwFLUEwcf8PK+N2YSZGQqjthxO79ZnRItmx4CfetJ2M3/0JcwnyQH7KQLzZcADX/cdUbcbv/hWzyGfmcAZ2+ciF/XXXrQBqNgsoWHCIHeay2mf4/AK/a2RLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129790; c=relaxed/simple;
	bh=aCodlFFXHQBWaHWICD9txtmi5ow3KNr2Et6gGaYS0Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INEMBQK99CE6FE/sKHKNT9NsF3SCDpi3zl+4wCY0YERgY50Bo90Nh6Qhaapg6UexaRbYFMWiHdm21CzgYMr8kx19kOoVWkGQFCk1wQN4ggOa6YcbSFQ2vAtZHw1MY6hkrhaPm45kQqvxAn3NSmebDAdQ93STiY5kUqyfqi7rpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpBVSxT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AACC4CEF1;
	Fri, 19 Dec 2025 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766129790;
	bh=aCodlFFXHQBWaHWICD9txtmi5ow3KNr2Et6gGaYS0Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpBVSxT1nNM8br11CaoNIEktIFCoo1I0t1wbvowO5w1uBfxPKJR6YohzaXTdMn5FN
	 dm5ARDtTuLIZLHvdHRjEjbEzABBm99J8rjNn/Rs8aoh4aFh4kNgsBSPA3akHdWZtuY
	 nY8TtyqnaSyRHkZ9dxrvqlAZDBuh4uCFSuwYspkCpOn/lTCEMvBdFKRDhzS8c5lTIj
	 DTdhFRpgXZlemZqxLF8DkvUJX+dQsApoBBST1n3yhx49vQE7+K/qgdbG+BwZSmjZIX
	 y9SBFwwn34HyJFm55RdVVkHZSqMNZc4MTZUVt7d/HOZEB5R/qxSCy9Nq946cuM3Cq5
	 J35Lf7byM5s4w==
Date: Fri, 19 Dec 2025 08:36:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
Subject: Re: [PATCH v4 02/21] dt-bindings: power: mediatek: Add MT8189 power
 domain definitions
Message-ID: <20251219-hissing-chicken-of-poetry-5fbfd9@quoll>
References: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
 <20251215034944.2973003-3-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215034944.2973003-3-irving-ch.lin@mediatek.com>

On Mon, Dec 15, 2025 at 11:49:11AM +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add device tree bindings for the power domains of MediaTek MT8189 SoC.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  1 +
>  .../dt-bindings/power/mediatek,mt8189-power.h | 38 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h

You did not cc maintainer of the binding, so either it's fake entry or
you forgot to use tools.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument, so you will
not CC people just because they made one commit years ago). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about 'b4 prep --auto-to-cc' if you added new
patches to the patchset.

Best regards,
Krzysztof


