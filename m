Return-Path: <linux-pm+bounces-34863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD5B7E37B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1619C3258C1
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717591F462C;
	Wed, 17 Sep 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S5ck+4lq"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFDA337EB9;
	Wed, 17 Sep 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113026; cv=none; b=JizuxZqlgWqzn5l+9H2bwxxcoc8toV8MjkMvKWkWZN+m/JCc0b0LhNATxPGl76cJcm4CVyJH03YEouKo485zBIId1Lr1bJ9Fk+gxlz40VxMAnXDbthYKTMk6wzEJo5wkSz22NXTnHKqZBHpgfRepqa61r/yl3ULLzf5zfS1rsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113026; c=relaxed/simple;
	bh=f/DltGKx9pSF+Vy+y1ZLxi8tkefLICe4HyQIufxy04w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCOumzjQV+lAtcwZQMEqZTBPi/5TtBjYo5BLckMSczaDlLgb7BeuGU0C2jpVkaPP/7kvqy6nkqO6Jjg23KQf55X/tGyAjQQuGCHvQklrxKY4LfqMNKyEU4HIsR/Jz8BPHT64JbrxvCKTCwG5eProrpCj88GaVGwjihzoD3N54qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S5ck+4lq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758113022;
	bh=f/DltGKx9pSF+Vy+y1ZLxi8tkefLICe4HyQIufxy04w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S5ck+4lqyVEaw6X+IVc7RImLkxZ8jIdtgAFomf8EY48Pa3HILQXwxjm2TckX+mbq2
	 cHHNPX0nflnhiuiofgtcBE9AGsclKEeQ3ouWgagveQPH4K3UM8F9gTrwnqmIN9TpEh
	 +B7/jf8wIJRKJJIYlLX+dRMXbG/tJ+nKjGad/nPQn7J9DSZ5KGibQ0+3280T/qxSbn
	 0i92rWwjMgsmP/czMsd7UspUbcxOzms1s3z8ArVeA6+F9MYZYbl5UIynhuLsTRgbgK
	 LErt7RqYx3Bmjsl0QNBSxhdm24IggBRp4nRR/5JpT7GlenTB6GtUqDAt/tFP6jpgQJ
	 ZMuh1G+SA9u7g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EF3B17E10D3;
	Wed, 17 Sep 2025 14:43:41 +0200 (CEST)
Message-ID: <4522baca-7262-457c-94d4-326b660aad97@collabora.com>
Date: Wed, 17 Sep 2025 14:43:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] drm/panthor: add no_clocks soc_data member for
 MT8196
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
 <20250917-mt8196-gpufreq-v3-9-c4ede4b4399e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250917-mt8196-gpufreq-v3-9-c4ede4b4399e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 14:22, Nicolas Frattaroli ha scritto:
> While panthor does not try to do anything untoward with the core clock
> outside of increasing its enable/disable count, the spirit of using DT
> to describe hardware, not what drivers need, informs us that on the
> MT8196, panthor should work without one, as the true owner of the clocks
> in this case is the performance-domain.
> 
> Add a boolean to the soc_data struct that tells panthor whether on any
> given SoC, it can leave even the core clock NULL. Set it to true for the
> MT8196 soc_data instance.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The only doubt that I have here is about the "no_clocks" name, as it may be read
as "number of clocks" ("no" is often used as "number").

I don't really have any better name to suggest though, and the execution is right,
so.....

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

