Return-Path: <linux-pm+bounces-34667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA557B57694
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F52E17D363
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182302FD1B5;
	Mon, 15 Sep 2025 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SrkMRLFT"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584C2F60DF;
	Mon, 15 Sep 2025 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932553; cv=none; b=L6EprZgoKqoWrwBGg5VqDosmgadvbPwg0/nykdPK0vfznpbDUbN6J1e6TdZnn83V3RK71Z+lQ+z2T2/+QI4Zmi/26XgpD9A8j3EzVJ6c7tMdxaYudsy7Cjz+9FViaOcVhlJdzURArra3yMhY3dGJQDf3PClwq0ApNem5ofKfsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932553; c=relaxed/simple;
	bh=Aa9ZL/X4bPp5w+MdeWDS3WTgkxlZOjtygj8nuNk04VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dH9h49IP48VDw3YBKh4MefQGWvsTNrvHxj8GRAA/70Xy+M7hNX/Bg/BgSNmxS40qUDO3Wg21kO2AVIiU5NdEC6xhx0KWfm2ceM202Ko7j0Xce3UEtAw4MAaVmw9wS96bicELpVcTjVGQbpBn6bR9b3wVODvXANv1xJ1CQe/GJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SrkMRLFT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757932549;
	bh=Aa9ZL/X4bPp5w+MdeWDS3WTgkxlZOjtygj8nuNk04VI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SrkMRLFTOcFjgV9yFNegoLT/ZRb1CVY72iNiyvsXeuXc4Axco+sF4rY/tFgkN695c
	 BnLsEU2JJgLEdSMy+vI9TM1tXpQw+wBDkT1oNuGWzudFXMCNpCHlR57hCo95NCO0T+
	 uf9mN7B2uGSO4goFhVSymjNxGjwSmvUx3XKe+mqYk8FOg0nDEzhDR6y2rLBm0vVG7j
	 n4cH/RMvB+UrwtnTfizGo6ej0wSBCuSwy/LMDSltg/Owb1f7W8u8FCzLYW938vRO/k
	 /1RbFElNXZt6wHIMJUIGqxe3mrIss94YK8GWgOQpNsVBEIrbmNEdMtPVgpQrBvlHcL
	 dKv11E22Gx+9w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6155817E0147;
	Mon, 15 Sep 2025 12:35:48 +0200 (CEST)
Message-ID: <982e21c1-b929-4921-aadb-2ce8ab573cfd@collabora.com>
Date: Mon, 15 Sep 2025 12:35:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] drm/panthor: call into devfreq for current
 frequency
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
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
 <20250912-mt8196-gpufreq-v2-6-779a8a3729d9@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250912-mt8196-gpufreq-v2-6-779a8a3729d9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/09/25 20:37, Nicolas Frattaroli ha scritto:
> As it stands, panthor keeps a cached current frequency value for when it
> wants to retrieve it. This doesn't work well for when things might
> switch frequency without panthor's knowledge.
> 
> Instead, implement the get_cur_freq operation, and expose it through a
> helper function to the rest of panthor.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



