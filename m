Return-Path: <linux-pm+bounces-34884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC50B806D3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB261C27274
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D59332A43;
	Wed, 17 Sep 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPT4O+Xv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E6332A39;
	Wed, 17 Sep 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121361; cv=none; b=ACSeIGDeOAtNYLCTep6Rb/ix4nHEt0XA30qRZXIcJ16zcdL7lAVTEejQIco9MKGj1GNNlksYIboO7IM3LyoNoOVdC+jvimUCXHzK8/H/daKp6NWvxGnr76bAa1qIJh1SCMiZIbwTUnjTUNx7DPsr1lGpnPmlsy82x5BvHsbBqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121361; c=relaxed/simple;
	bh=DkAob/mYPV+ZNAEqdno0NyXMgOtH4pnIcMp+zpKJAxo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ETIURkWlzygAZ5X8pl6Z99kENYKuvTRSIG1J/nrGPBBVgOkxg5IR9LAofWZAj2oJ2wDVEYcTmaI64Xw1zvGIg/2vv1dbgK5DkkXPZO3YWYwdEpzRlgdaCOmoUVvGkhm2V5T9XuBAsnokQrnpAMEZw148L6RABQE7QoRFIwnTXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPT4O+Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCF7C4CEF0;
	Wed, 17 Sep 2025 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758121361;
	bh=DkAob/mYPV+ZNAEqdno0NyXMgOtH4pnIcMp+zpKJAxo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=sPT4O+XvDEdrvk/c00OHoqwWJCwrh5WRxwW2tzfT6VyUHJdXBW/vpmYjndvYkUg9Q
	 4Jj9Bu94e75coQqY0ZAY3DnhFg5EnUERYbd+Vaw8+dHEgY/SaTmvfFtvCWDker95nM
	 s12OIAXMjopWutHC5B0Za8oNtIDlU7dyKOuKm5ZSCarfmgLIUyiIepAtgS0QXD3Ffc
	 zs+brP/jrIpbtZnJtf8IuRs5IGUWOWNxBhmesgdnr/BBP+LjJ2EYVPOO49nNr5QV6L
	 c2FZ4OI4wGqia7QEs/0k4oAvTRgJtumOc1CuOa9RiZ3b+U34Djc9Idi3hiLW4FfUxg
	 1kQS/hbO4N+tQ==
Date: Wed, 17 Sep 2025 10:02:40 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, Conor Dooley <conor+dt@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-arm-kernel@lists.infradead.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Steven Price <steven.price@arm.com>, 
 David Airlie <airlied@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, kernel@collabora.com, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 linux-hardening@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
In-Reply-To: <20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com>
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com>
Message-Id: <175812136009.2068624.13991293282844294346.robh@kernel.org>
Subject: Re: [PATCH v3 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant


On Wed, 17 Sep 2025 14:22:32 +0200, Nicolas Frattaroli wrote:
> The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> control the power and frequency of the GPU.
> 
> It lets us omit the OPP tables from the device tree, as those can now be
> enumerated at runtime from the MCU. It also means the mali GPU node
> described in this binding does not have any clocks in this case, as all
> clock control is delegated to the MCU.
> 
> Add the mediatek,mt8196-mali compatible, and a performance-domains
> property which points to the MCU's device tree node in this case. It's
> required on mt8196 devices.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.example.dtb: gpu@48000000 (mediatek,mt8196-mali): 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-valhall-csf.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


