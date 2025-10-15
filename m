Return-Path: <linux-pm+bounces-36173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF8BDD934
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12238545224
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE5931A577;
	Wed, 15 Oct 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fiHu5AEM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BE31A07F;
	Wed, 15 Oct 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518769; cv=none; b=VcwNnOXJ0cy/x03LbdOukgtq3D1z+VZbKFVZQwDhmihzMCs3Fk1Ga/ptbW9nm686ty/tO5b8MWOp7C9qZXVZLh4QaUgTCp1lEwbYEuj9gjqHeYKmlaiEtWrp2pj7l4bVoxoY4nt/vdOnwiUVLMriV7Rn3aDTt9Aro9c0YeI0dME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518769; c=relaxed/simple;
	bh=XCOa6UKMhp1ANTY93PkNLWmuW4ZzjeRtQ3m+yYFujDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pD+0Svu1HFVT9aKxa3rqNmRytfnrkWXqgUAH1K77td4HRLF+Nn7hxLHkQSAwp05wusFosaaWyb2qXKMuXRDwBr/m409pc2DB6/5L7xE0jtkF2JUdu/4JxJXW6yLf8oISAxHgXoi1PSW+g833eXMeWWHz76iRR155hbpjOxjyL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fiHu5AEM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760518763;
	bh=XCOa6UKMhp1ANTY93PkNLWmuW4ZzjeRtQ3m+yYFujDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fiHu5AEM86zk+RnqhjIILNMO66Za6N7CHFpcg1o4H5JZ70pcbus27J6Hk7uv1BV0r
	 pdK+20Ruz9ynZp9ZviI7augpG2ZJk2avc1+DiwyC2dYrrzHOPlx3VBod5e/NyNhusR
	 eJJ5DtlBV4KrutK2/E7ckvjnsMMF2U1b/e0vVb4/hSPWUTwGhR03M/S/Tqm7zNB8El
	 6LQjk/5UswIBswaDAaEZaiO2QflDq36Ibkv6VaSno5ZYSel72NsLp3lwZ/RI/werdw
	 oPT/D6rGLLskHGoFMOAIkn2FKeZZmyL5WGq7/lUjCCRiKFAdxX47tccjXhiBxxmTSJ
	 gBXIwzR7Lg2vg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CE5B017E12EB;
	Wed, 15 Oct 2025 10:59:22 +0200 (CEST)
Message-ID: <da324c96-2cba-46cf-af69-c9eaf7ea697f@collabora.com>
Date: Wed, 15 Oct 2025 10:59:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251015-mt8196-gpufreq-v7-0-0a6435da2080@collabora.com>
 <20251015-mt8196-gpufreq-v7-5-0a6435da2080@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015-mt8196-gpufreq-v7-5-0a6435da2080@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 10:50, Nicolas Frattaroli ha scritto:
> Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> integration silicon is required to power on the GPU.
> 
> This glue silicon is in the form of an embedded microcontroller running
> special-purpose firmware, which autonomously adjusts clocks and
> regulators.
> 
> Implement a driver, modelled as a pmdomain driver with a
> set_performance_state operation, to support these SoCs.
> 
> The driver also exposes the actual achieved clock rate, as read back
> from the MCU, as common clock framework clocks, by acting as a clock
> provider as well.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


