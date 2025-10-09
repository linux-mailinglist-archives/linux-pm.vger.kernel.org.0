Return-Path: <linux-pm+bounces-35877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BCBCAAF0
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59EB3ABF99
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33822257427;
	Thu,  9 Oct 2025 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5UXUgWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E01E0E1F;
	Thu,  9 Oct 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037938; cv=none; b=YlNHecJX05YdTlixkyQh0vGlnywW84+tiW43/4BGd2uz8HXXop/ZzqyFdibHcM3CDIhXFhI0uiIME55Y5b4h2NZVGLD80z63ecxM91RFY2Vivfe3U4422y893Thz9js2xRVx0SIcu0myYX/TALY9YwvZmk2mxXp9DLwkcYratwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037938; c=relaxed/simple;
	bh=ZleYVLbg1TqX6cXrbg8yQvDdGj6LBQ3wULzm7dwdO6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKpyNb3pXy/4Z0TcdPV2RhAt4ZPpGlsEe75NfFNL9hHQtuBaiA232XUqLG1WdDw8+oAUMH59ozGGfB9pRwlWKHTNZTfWcgf/4voDav3NLeWQiCbph5/b6Of4H9/Ibqyi+Qr8DAT8l2HtL+Tj0fyJxnsSjLxWJccBSH7vytZ6eKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5UXUgWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405B5C4CEE7;
	Thu,  9 Oct 2025 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760037937;
	bh=ZleYVLbg1TqX6cXrbg8yQvDdGj6LBQ3wULzm7dwdO6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5UXUgWM7C5XGdo1qWqAPTsCK9nnFVgTTrpj8r6TNc2SibypxPp2RmL6ltpQew+Xz
	 FAUVZDAysSwbBqBx3NAJWldPACkKw13KYYfuEXDmLX0betBRXRQ6RU5L0Qx3IsVEHv
	 dqxyIiAlIXTXaBwGWDSjo1yvX7MncGZF9UWqG5RP32s2xstqvNk34xxc+6V+qgyEtf
	 bLE0O4SK5XtWy3XOoEW8MOp+/C1JJcmQVf2+M+HogTO/Ws9iEvTMCPh5lXdpNODYi8
	 TihPh6SrK1+80/r4vD3XWG0bnp/MvyrUC0eFGl6lKt8Wq2L/s4eIQTihQmLN1s3gC5
	 DIXYyXlb9tMoQ==
Date: Thu, 9 Oct 2025 14:25:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Airlie <airlied@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
	Chia-I Wu <olvaffe@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-hardening@vger.kernel.org, kernel@collabora.com,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v6 1/7] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Message-ID: <176003793576.3141336.11200895939203051819.robh@kernel.org>
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
 <20251003-mt8196-gpufreq-v6-1-76498ad61d9e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-mt8196-gpufreq-v6-1-76498ad61d9e@collabora.com>


On Fri, 03 Oct 2025 22:15:03 +0200, Nicolas Frattaroli wrote:
> The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> control the power and frequency of the GPU. This is modelled as a power
> domain and clock provider.
> 
> It lets us omit the OPP tables from the device tree, as those can now be
> enumerated at runtime from the MCU.
> 
> Add the necessary schema logic to handle what this SoC expects in terms
> of clocks and power-domains.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 40 ++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


