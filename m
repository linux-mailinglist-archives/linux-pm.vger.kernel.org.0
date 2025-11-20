Return-Path: <linux-pm+bounces-38238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F58C71835
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 01:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 50F342981D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 00:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E363CB;
	Thu, 20 Nov 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrQNDIf5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C72186A;
	Thu, 20 Nov 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597480; cv=none; b=QA/WDcwM6qbrOHN/OixePnLadNX3ZcRyeI/xFWP2y8/Qh0UkLOGGGXs+zulotRPAIFl2K7pGCdKIILFo14zEUn46eCvAS+//YmL1qKJ+c5TV8d7rvasvwCKDfsXffqajYUa66re6pRT1gckIoue24aXOmNhlfGb8Fy5JMrWSYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597480; c=relaxed/simple;
	bh=sv1fkok2N+aLyYVgNquI/uq2Ye6mJG47tXK86nl4Hpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8+84JS11laaJ67r+mOJp6dOkYj3Or8vTlyllxrzr0PG5Z7gzBPph6Tjh6Ao0Bf9d8EUcHnFWgy4XFq34LGzrGntJA9J1Ws0DrhYGX8kDBlJujAjUj1ZJKDxB0X830PHA0054W7hcUDqrI+e2Xr6SLCD9T6iAWIqGgUkgnsTMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrQNDIf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F24C4CEF5;
	Thu, 20 Nov 2025 00:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763597480;
	bh=sv1fkok2N+aLyYVgNquI/uq2Ye6mJG47tXK86nl4Hpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WrQNDIf5h8U04GRpL+stTSw+b/uLkBEXTXEHautRVHiMoUgIN/s+foGGDLuIUU20g
	 bMNOTF1EwFFMn5UH5ZPzwBInEsqFDm4wGhIe3RpRPmUiURV+8jfXoZ9iazunNzl/0T
	 MOkYsh/030fUc0wiwWgjowPxeo/ajev+7ufyvLo5hjd0b1lm9RylQJRcezyP8Iknj6
	 FTah9Tx5jHHLytaCFIxZ8GaiNBTkdNkLGofFpxmqlDZJ/KMXONevNoPbvohfmv4zVn
	 KZTsabtvucGqHdPaW2zMDcO86ragISyB+tD+vgoXR71RISNZc1DJApGkY5VEsOuebe
	 N1PQsv55MUkpw==
Date: Wed, 19 Nov 2025 18:11:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Georgi Djakov <djakov@kernel.org>,
	Henry Chen <henryc.chen@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 02/13] dt-bindings: soc: mediatek: dvfsrc: Document clock
Message-ID: <176359747794.3605292.8742901410982819930.robh@kernel.org>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-2-b956d4631468@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-mt8196-dvfsrc-v1-2-b956d4631468@collabora.com>


On Fri, 14 Nov 2025 17:53:56 +0100, Nicolas Frattaroli wrote:
> The DVFSRC hardware has a clock on all platforms.
> 
> Instead or proliferating the culture of omitting clock descriptions in
> the clock controller drivers or marking them critical instead of
> declaring these types of relationships, add this one to the binding.
> 
> Any device that wishes to use this binding should figure out their
> incomplete or incorrect clock situation first before piling more
> features on top.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


