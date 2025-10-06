Return-Path: <linux-pm+bounces-35724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32EABBD751
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6233D3B3AAB
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA891F4622;
	Mon,  6 Oct 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oqea8QCy"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5AC1F09AD;
	Mon,  6 Oct 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743376; cv=none; b=pGHqLG3AsX6aSvpsbyEHf2Of7T6boZz83gBndeJ5+zUoEUeqL9UyRrg32DItE7W7oP/QaORhbRZ42Y6n/eUJQ3eBubuNhHZ9oCJptaF1/8PpoLC3SuNtwWBBzs40lErJe5yKyugq/vmiAF8+BWGJf5dyWjbBOdUOGwTOznl3fJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743376; c=relaxed/simple;
	bh=Xp3by8t0maP1Vb90Nju6hz9/zSoF5Ht9B7xI4C7ASrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM6rWStWJt9fqmsIw5fhE80CvQixXgI15peiz3FxWJZ2X6p7/iGA4Zb7qys7Sp2nWMYtJyo9G6Iyi0m90JDrGyo1fBCyqVNt237oOElGReZLQO3PsSYgkMo98hX4ABfHypUVF1XJK0HnIPGsstdhDbXdV5Ko8txRWvVep2wfFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oqea8QCy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759743371;
	bh=Xp3by8t0maP1Vb90Nju6hz9/zSoF5Ht9B7xI4C7ASrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oqea8QCyl47tPr2p/I2JBWilB27/dytrdw7oUiy72JMtI+hZdP+/GK6bMH2b1ME3U
	 tBJTqozUMuhy57OsKjw9xE+X2Mn2TK0KFsoxYVqVEPoT8sm3MhgeDQnLL6eHT8KN6P
	 yfxg1uwEWuCeR7B/NKGiy645OImZrboJpCg5VUzChTWyElKansn6MrrDbbzT3Pbmvi
	 9myQ4DYvltdcxXoVbXZM5kIIDecRP7QVtSNFTJLIZLEzNBlbFZt6m1c0TsshyPYifc
	 Vmb1J6wn5DEuCDQG3hAdm9SOVs6Mcb42/H3Wtw/ACt0oshGypbrkCRrFxmkYeUq1J0
	 TbpwM/i587E1Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C34CF17E0FC2;
	Mon,  6 Oct 2025 11:36:10 +0200 (CEST)
Message-ID: <137811e2-f28e-4605-a6b2-935a0a8b463b@collabora.com>
Date: Mon, 6 Oct 2025 11:36:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dt-bindings: power: Add MT8196 GPU frequency
 control binding
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
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
 <20251003-mt8196-gpufreq-v6-2-76498ad61d9e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251003-mt8196-gpufreq-v6-2-76498ad61d9e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/10/25 22:15, Nicolas Frattaroli ha scritto:
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



