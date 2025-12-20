Return-Path: <linux-pm+bounces-39719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1750CD2557
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 02:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75C153020C73
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34F2DE70B;
	Sat, 20 Dec 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHBcNsI+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24029B77E;
	Sat, 20 Dec 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766195991; cv=none; b=NJ1XCtjTaESN8n4wLfq+0dbA7Ro9lkn3Vx4xaPfFJOtqxUBHZP/gEKLHPieFsozUpd7xI9lsgVDQMTKbBb0W7MVlwQS8H3MUTBpSl1h6GmMVqeE7V8OW3YuA/JAhD9wGLqK3VbQzN7xl23ef789ibJ6yVHrERpLWZCV9+6tRmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766195991; c=relaxed/simple;
	bh=os1jh+uZ9JsdSlnhfREmRKroQHOLlY2V9cVjgynwxB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3MQQ7m5f1UKl+fCrJwbyuNgrK9wMG0hm9+lxDmlkPEsXraw4r8eIYP8Her0xIyHaCC6h1TIH8YKqGg3fEaGqj501QEVykTUWCXGuQ/lXgMrEH3TSVppMhuaGtNAaiAKwnra9bZ3W9VeVKd2MV5k0DIDux1+PeDVpKqMQ9myyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHBcNsI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FC7C4CEF1;
	Sat, 20 Dec 2025 01:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766195991;
	bh=os1jh+uZ9JsdSlnhfREmRKroQHOLlY2V9cVjgynwxB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHBcNsI+BT4SfEzjOuUyUlFgXxxsfU1cSymkC/KMEuxeQCV0RnQPMbWYWiWtARQ+S
	 roy2dQvnmshflaSieqDX4PRCmO+Wf8YHIWNFqNI6MdGbZTL3YikWsRqVcmgHkf5Ymi
	 fCIeh5cq3R11d4zZyWraYiJxA2UPdRR70H1AB7q2CNN4oeiRqBZcA1wwXelPUk7LwW
	 RzXBx4vKfypoojYjBWtlD2zYR/3hCLvUohUnhAIpuOqklGbGMW8KQmitcH/a1GCAKa
	 v6esnMcGmeiglkzGHLsdzq00xaB3nGrfUSEfAK0eRu4kMd8mId+B2Qrb5eR2IKcW76
	 c3qCIn5Sqw/HQ==
Date: Fri, 19 Dec 2025 19:59:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>,
	Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Steven Price <steven.price@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: power: mt8196-gpufreq: Describe nvmem
 provider ability
Message-ID: <176619598779.359396.11418181120053228697.robh@kernel.org>
References: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
 <20251217-mt8196-shader-present-v1-2-f6f8f3aa1e93@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217-mt8196-shader-present-v1-2-f6f8f3aa1e93@collabora.com>


On Wed, 17 Dec 2025 18:03:28 +0100, Nicolas Frattaroli wrote:
> On the MediaTek MT8196 SoC, the Mali GPU's "shader_present" hardware
> register may also include a non-functional shader core, along with the
> present shader cores. An efuse elsewhere in the SoC provides the
> shader_present mask with the fused off core omitted.
> 
> However, the efuse address is not publicly disclosed. What is known
> though is that the GPUEB MCU reads this efuse, and exposes its contents
> in the memory it shares with the application processor.
> 
> We can therefore describe the mediatek,mt8196-gpufreq device as being an
> nvmem provider for this purpose, as it does provide nvmem access in an
> indirect way.
> 
> The shader-present child node is left out of the list of required
> properties as we may one day be able to describe the actual efuse region
> this value comes from, so the gpufreq device isn't necessarily the only
> device that can provide this cell, and implementations shouldn't need to
> implement this functionality once this is the case.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


