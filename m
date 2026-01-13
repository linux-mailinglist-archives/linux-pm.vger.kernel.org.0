Return-Path: <linux-pm+bounces-40766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A244D1B6BC
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 22:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38CF9301519D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E4325709;
	Tue, 13 Jan 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNsMCwgP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28331DDA4;
	Tue, 13 Jan 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340133; cv=none; b=h1K3oeBV6VJ2U9NQ0SrbmZwsciokHH6YJFfxwDFD+rqfPw3uqSnyCxe5i7rjY1VgnmRYw3PiNiyVs4WvfI5cSI17z0oUAPnJhbwtH5zddHJ5ZuDIi2fw/QTZyttGbWa/00IfGf04wOjbKrid1jjrduoZXl4o39NsYB/QTov9wcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340133; c=relaxed/simple;
	bh=Dbm8u1nxv0SFdoJYYafBE70biE2TqlrwQCv2IgpJL9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+U/AfuzUfgt3bYUtONc8QWm1FTRlCXuNwSBkxcZnFaqLNo1hWvXpArCLUHIDdTdBbfvrGBHcH9IThSeaSrzsvXHPiE6Lv9vnnIf73QjtY1MF06Pf6Mq09qhVIi6P+zmmBPKsPB10QcT4itm0L6/3b0KILWVF1MAegYPM0uCitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNsMCwgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A8DC116C6;
	Tue, 13 Jan 2026 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340133;
	bh=Dbm8u1nxv0SFdoJYYafBE70biE2TqlrwQCv2IgpJL9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNsMCwgPNrJ7I1l70NhY9QVgqFHw7VX3Tq9I3nM+/mQCY7dwHqSGLHvZ/d4vE8iu0
	 S+AvEbWZjH1rXJc4FrHOhe+mkiR8hHINWtScgYY0kpMdPj5ci4IkIJQ0FVxt+2Dg7q
	 8k97e1dU726l+JifhX4aH+jFid171BZDURhOT80//HhTegiaGCov5RjtXfCTRNlxmW
	 Pry3S8Yqw+MclexkUTpFw9C/st/n22/l57nzezevBCRBPpch4yVVGx0QvtJyqQKNK0
	 9p7hB4bmQJAr9Pd3pLKSKzpZ9I8yi2oO1uVuIxws5/sx2yxeKGi2AL6BN55JmkQ95h
	 FuTYpWLk3/5qA==
Date: Tue, 13 Jan 2026 15:35:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzk+dt@kernel.org, sean.wang@mediatek.com, broonie@kernel.org,
	sen.chu@mediatek.com, lee@kernel.org, macpaul.lin@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	lgirdwood@gmail.com, matthias.bgg@gmail.com
Subject: Re: [PATCH 1/6] dt-bindings: mfd: mediatek,mt8195-scpsys: Add
 mediatek,mt6795-scpsys
Message-ID: <176834012975.196178.18344573393379510251.robh@kernel.org>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
 <20260113110000.36953-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113110000.36953-2-angelogioacchino.delregno@collabora.com>


On Tue, 13 Jan 2026 11:59:55 +0100, AngeloGioacchino Del Regno wrote:
> Add a new compatible for the SCPSYS IP block found in the MT6795
> Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


