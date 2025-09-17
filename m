Return-Path: <linux-pm+bounces-34864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14DB7E4F5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DD86218E0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D742F5A08;
	Wed, 17 Sep 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oPTwi+Ug"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E830BBBC;
	Wed, 17 Sep 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113068; cv=none; b=DFNbTL7Mey34FrlWExbEVCXVd5xtSao1aIX+igsF+CgTiUQaDCqJhOoRtz5PODHSlscVF8P9GjyqaAewzgRkE6JJnTfdg9ImzY7BQo4IVS+SsvcYoE0E4GhCCeDa6uuY8UrQDJ4M1xHDPmN9KAgTy8HE8q5ydz/FPwS3Vc3a/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113068; c=relaxed/simple;
	bh=q/Y6LU1/0Tlr24LP7xTr0Py6bHWN+pDK01NRDaUO/+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5FiTXu9yYzkbUxWtqfNU5izCl2StX6E56XtgvfM8g5YSkEfuyoEhca4e73TQkNvptlW3NVBmV6pVLNvtMGCME9l80vJqyAxOyZQgjc+XtABcuCc9eKcRIuhBnhezkB5t6hGUBQIUvYnZR/f89L7Afqw24+ETkZaFDivU/RbWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oPTwi+Ug; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758113065;
	bh=q/Y6LU1/0Tlr24LP7xTr0Py6bHWN+pDK01NRDaUO/+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oPTwi+UgoDysY0Ojh4Rgw3WQjm/OKI2BKEgkdR4/DCrHK28tf+mnrCIfxv2M0puJL
	 oL/1kM+aUfz9LmE1BFm3N0a7ldZmW00H1Tw1x5jjnlV+qBsklCJ6LDEiMTkXB0qYwJ
	 NLEnKGsWrDU0XcAgHnlY6UoVidvQBSzwpIH3/CkyrSW4ZG2Rlfh9CY3wsAmf/L15jM
	 W5bI6uEFskh8Dm7CGMf+pYv5yATptSUxbLWzBgxLBNhZFaExeygPEebb6jl5HwdnqR
	 Pb3CbHn4R+51C8ft6kAve2CNMQeZ08sfSNzJ2YpLbSsKtMR6kM8YesDdAsYCHj8ppq
	 lsFVIFuRt/smg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3A2F617E090E;
	Wed, 17 Sep 2025 14:44:24 +0200 (CEST)
Message-ID: <ec3352cf-c089-4cd6-bfec-ffe02542917a@collabora.com>
Date: Wed, 17 Sep 2025 14:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] dt-bindings: sram: Add compatible for
 mediatek,mt8196-gpufreq-sram
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-3-c4ede4b4399e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250917-mt8196-gpufreq-v3-3-c4ede4b4399e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 14:22, Nicolas Frattaroli ha scritto:
> This compatible is used for an SRAM section that's shared between the
> MT8196's application processor cores and the embedded GPUEB MCU that
> controls the GPU frequency.
> 
> Through this SRAM section, things about the GPU frequency controller
> like the OPP table can be read.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



