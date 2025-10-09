Return-Path: <linux-pm+bounces-35878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E236CBCAB02
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7DBD4EF8EF
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AD259C84;
	Thu,  9 Oct 2025 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocOfs+N7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25352571A0;
	Thu,  9 Oct 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038030; cv=none; b=TVIAVvzKXayKkhe/ObFqVtZY7kh5BmB45bk0YUTxOIzoR1ZJUq686Wfg4ty0M3u0NcQ3OoqroheAtvw7KFrTksYVCm7/ADSYFsUBZ/mdz9596hv2Sr2Urvc3jrtaao6U4/Xt4RJRTEOCUi+IvB1TUsqOjQ7kfNj1PzXVmG+6v7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038030; c=relaxed/simple;
	bh=J7CUiWc0ADF5tenIxtE4W4RrkCaIIs7aFDIdrQb3yuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqihMIat9Y//V9N+ATMmd+/GP9rem0zqSMjDxBRekhcOAP84z+p2IxdQv2nX6+kJxmLYp69o8fdXab6xKMemunxRYWFZLQWtWo7jMCmJCivRvJgF0V49Lx+h/l42hITCKDRNfVgjxthvGVjnx1Maque9MtztnycBPQmhjkou7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocOfs+N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB6C116C6;
	Thu,  9 Oct 2025 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038029;
	bh=J7CUiWc0ADF5tenIxtE4W4RrkCaIIs7aFDIdrQb3yuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocOfs+N7rtJInE5RqP5OdMODSvcF4BMfHOQ/dcESFUUiWLWZAxbZaF5uNBcC7hENh
	 qSwKlQWc7ueBC64kW2mHYeok0OYGmn9lyK+JRYDFeqfUUJL++YiR0VukEUdApGwZ4P
	 06fxejW18TPzKsAf3FaJh5To8Xpr1/s8bqgN9DgXGr/z1ZXFBh272XQyfXUJXlKFAv
	 4mF3dyXq7P/6ESbB3idH+ngJx9sPFTjCaHZ8861rBV4KfbYP+Zth70YDTTW0kAiNxW
	 8QJP0JGvJcnnBDViirhzGPJdCFx3Ynf1ASJF8rtJ/rR02QsosocZbskOnujsGkzC/J
	 /yWABoLKDafzg==
Date: Thu, 9 Oct 2025 14:27:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Steven Price <steven.price@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Liviu Dudau <liviu.dudau@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@collabora.com,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v6 2/7] dt-bindings: power: Add MT8196 GPU frequency
 control binding
Message-ID: <176003802776.3154911.16315672930945564696.robh@kernel.org>
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
 <20251003-mt8196-gpufreq-v6-2-76498ad61d9e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-mt8196-gpufreq-v6-2-76498ad61d9e@collabora.com>


On Fri, 03 Oct 2025 22:15:04 +0200, Nicolas Frattaroli wrote:
> On the MT8196 and MT6991 SoCs, the GPU power and frequency is controlled
> by some integration logic, referred to as "MFlexGraphics" by MediaTek,
> which comes in the form of an embedded controller running
> special-purpose firmware.
> 
> This controller takes care of the regulators and PLL clock frequencies
> to squeeze the maximum amount of power out of the silicon.
> 
> Add a binding which models it as a power domain.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/power/mediatek,mt8196-gpufreq.yaml    | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


