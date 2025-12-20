Return-Path: <linux-pm+bounces-39718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A15CD254F
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 02:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AD9301FF50
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 01:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D02DE1E4;
	Sat, 20 Dec 2025 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7k7N6jG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F82DC783;
	Sat, 20 Dec 2025 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766195900; cv=none; b=mNM5uz8hrFmE8h74Bo1UtLEVirm5UoC1MK06rvpq2LHVh8bfMxPiZk2OsZrMe9Pz1YaxGvVzXArkc7qWogYdYdmx8Op9R8MK18vouXQcVodumeACw4LNuz2Hk+/413Qw4QQ8Oi7Yn12gxdvR85mmzh+I3PAkVlYfYalnbXeb2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766195900; c=relaxed/simple;
	bh=WNfNeRNtBHMdT3MgMNoIm2HEkpmzRyn8zXURCSnutSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km7x+WVnyqIayRO3xI5Yfa30/b3j2sRmj2s9ejwZoDZwosqK+yJtuGIKlHRCSyeEWvRzDd/u08p9MpZs9qwMu+JLikpP6vp8K8cizkUxjhTmP/OIyPRAfu6JLADbGreiysPQv3q78/0OKPw00tNQwgvSZejtSAUuGYnF2xMOuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7k7N6jG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5005CC4CEF1;
	Sat, 20 Dec 2025 01:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766195899;
	bh=WNfNeRNtBHMdT3MgMNoIm2HEkpmzRyn8zXURCSnutSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7k7N6jGCuh/KOw8VYsG4g230WVUnnQx/8NKaj78m0lsETxEtxnLzGF8xMn8Skv5c
	 6iH1jTqGr57q6v0pp44XfdtK0mRGFkVlDqHCrPye8Hip7mOhStFt2yjJ3kaYP71plb
	 wSrQk9C4tOGKtKy9IRcJm9lB/rlYrykLT5KZmg4FHjTZAdl26BBYDFzqy0MCunnQcb
	 iYyXzkqvNEHJ2h6yTeiutbvDpXESGSUfhsVuWoIf3OfSGAQBngL+kS3t+mDNatx/l/
	 daKyKHz7A+0p0ecJc1LtYbRSiuBy7lIo1BFYXrGrYB2Vs1tueSYNsp7kkml8dzEq7U
	 9ME9RVMes7/pw==
Date: Fri, 19 Dec 2025 19:58:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	kernel@collabora.com, Liviu Dudau <liviu.dudau@arm.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Steven Price <steven.price@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: gpu: mali-valhall-csf: Add
 shader-present nvmem cell
Message-ID: <176619589672.357311.747766699419646929.robh@kernel.org>
References: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
 <20251217-mt8196-shader-present-v1-1-f6f8f3aa1e93@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217-mt8196-shader-present-v1-1-f6f8f3aa1e93@collabora.com>


On Wed, 17 Dec 2025 18:03:27 +0100, Nicolas Frattaroli wrote:
> On the MediaTek MT8196 SoC, the bitmask for which shader cores are
> present and functional is not the one in the Mali GPU's registers, but
> in an external efuse.
> 
> Add the nvmem cell properties to describe such a setup, and make them
> required on MT8196.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


