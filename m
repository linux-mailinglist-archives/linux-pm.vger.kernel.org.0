Return-Path: <linux-pm+bounces-22706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88EA4039F
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 00:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F568189F17D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6405253F0B;
	Fri, 21 Feb 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUAOYy+/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B82500B1;
	Fri, 21 Feb 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181415; cv=none; b=iGztr5zIKyivVvXvSkNGjWmOx/mxJDcnVIQP1x5nKCrxBjLEZd9OSRvnaRUsIardSA8aBxd4OG4BSbNbEyF6X3+hblGJX6h4aIfhC81/N6cRn22oiP9eYHMlW0VYY9I38ciLOa7mG0T3+8oDHBjKbMoDsiwPnjIrdwwHiNEgxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181415; c=relaxed/simple;
	bh=GigKIqugzG3RnBUJxgRg750/c4rFtzjUiyDG9IUNwbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIrCkOWsod52eH2gnSPub7oialOcHf4QBudgwI4dCskk/GtRn7eOtyWZgUkzgPkacjOC1gbAO2fQ92LQbs4fICKc48yrYTCCsrGo2M1/MBFXJe1QgLHloQK3xytLu7fISg7IHJzTZy6gQD70HnrgN6faRpzuA5pANxLqgIclH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUAOYy+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2AAC4CED6;
	Fri, 21 Feb 2025 23:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181415;
	bh=GigKIqugzG3RnBUJxgRg750/c4rFtzjUiyDG9IUNwbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUAOYy+/YJy7QI9SjZaPQFB33Job5VD8SqGBh5+UJAK7Fh1/SYsbAEjVu94E40ZIP
	 1G2zYt5QKpK09qUmMWzl2nUbiPFq+oz4cKl33uDY6h5UmvRL4JqcZIB2IRTdYMn60f
	 VMtAUlH+CYQs3lnMjfaI5Hy/zg8G8rP79DfOEnfvzzj4ivsU1FCx7GMyA1nAUObN+7
	 DXba4FJo3HIbqQQhT3HMvPjLklpHh+qId5Xl32iS1Oxlkb/xyDt/PsvAD9JqRWZ3To
	 tXKN9NObT19kEXAxLKrKtkw2uzgUzFVMSNyZXniFs3yCNxEVO1XraqooJS/EBhyegr
	 nsN43cCRgsIVg==
Date: Fri, 21 Feb 2025 17:43:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
	dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
Message-ID: <174018141298.394778.13629046631332003048.robh@kernel.org>
References: <20250221005802.11001-1-andre.przywara@arm.com>
 <20250221005802.11001-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221005802.11001-2-andre.przywara@arm.com>


On Fri, 21 Feb 2025 00:57:58 +0000, Andre Przywara wrote:
> The Allwinner H6 and some later SoCs contain some bits in the PRCM (Power
> Reset Clock Management) block that control some power domains.
> Those power domains include the one for the GPU, the PLLs and some
> analogue circuits.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../power/allwinner,sun50i-h6-prcm-ppu.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


