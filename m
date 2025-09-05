Return-Path: <linux-pm+bounces-34036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8AB46732
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 01:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B768A480A0
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 23:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52228E571;
	Fri,  5 Sep 2025 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyF/8o2W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E587274FEF;
	Fri,  5 Sep 2025 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114896; cv=none; b=BX8P3LPXLHwP6ig6ES+KQQx0zg2nnxMVScfqpC/59c3JZ3VKCqVdfH0PoDoYBt0yFMDhcgcIFewbHJH2avCFyAO0JDCw+RIcK4ftnS26dxYiScgDR6W6IuNql5RlH3oSs28+/HY23ZRVQRFCqxUBsWyErGV2Gk6kmVKTpAv2M+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114896; c=relaxed/simple;
	bh=sHDzQNR+4667hi5yiXtnj/s70kNPk7kjxozWctS/6wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE2VpTec3zPUCVg41JyEItWii15Ilut+kE/c3w9yBdf+dY5Kfu7hn7l885FD9qS9/d9X8J6j1456UJvm6wiyPirwDJpjWpOHM+IftNt+kKjuSMVtG+6/abwiMHGy1awJS6e+vtT5PEgIq2oT81VBWZ6Ze1nWxNw6tvq878+WaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyF/8o2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40DBC4CEF1;
	Fri,  5 Sep 2025 23:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757114896;
	bh=sHDzQNR+4667hi5yiXtnj/s70kNPk7kjxozWctS/6wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyF/8o2Wy9POeXCaDjWYs/9R6CSYmeh9r/M2PRpfA4L9DGcUBwEUEbI6X26kA61LU
	 yCDjRjNRuNAVtBjI0yKApZGnoKrQoW5prezgO6vG7QcW8ufhPAdYS6cW/oFw618sVf
	 AOUfK2s9ZdvAHQrqKe+3PK4dWD7kUsLfFXdYqfrYBtgrg/dkVHGzApS+dWHf9xiWSx
	 7idD8L5Zm1fLgge50y279bTRqys4e+pZXl2r7u3Q/2d1TaNrBEFcuJoCnIoOAQVZO5
	 TgRG8bZwL7EnAfB3io/hw/RoAWiEOSM60SVMAgH3mH1EQQdmi4NAhAr/+cSsWzH4wl
	 yPxOqH5Fc6tDg==
Date: Fri, 5 Sep 2025 18:28:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Steven Price <steven.price@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH RFC 03/10] dt-bindings: sram: Add compatible for
 mediatek,mt8196-gpufreq-sram
Message-ID: <175711489460.1508247.14844222484675872512.robh@kernel.org>
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
 <20250905-mt8196-gpufreq-v1-3-7b6c2d6be221@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-mt8196-gpufreq-v1-3-7b6c2d6be221@collabora.com>


On Fri, 05 Sep 2025 12:22:59 +0200, Nicolas Frattaroli wrote:
> This compatible is used for an SRAM section that's shared between the
> MT8196's application processor cores and the embedded GPUEB MCU that
> controls the GPU frequency.
> 
> Through this SRAM section, things about the GPU frequency controller
> like the OPP table can be read.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  Documentation/devicetree/bindings/sram/sram.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


