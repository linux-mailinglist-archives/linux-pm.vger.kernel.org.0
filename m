Return-Path: <linux-pm+bounces-25903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF123A96DD3
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E951887499
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51CC27C158;
	Tue, 22 Apr 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QkAj8plt"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7627BF7C;
	Tue, 22 Apr 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330507; cv=none; b=d0Nm9mRkBWAa4PXe/0ackbtXcwcqxvv4VZf7T2YWHQUR0ZToorlbIv3Q26a0fX9v4ESV15nu6hojbRJIlpNyC12c0mdYkQGhC2g5am2ymuRs9/CUUYZ5C3SAs3SOxc3h1RzDGe8EfF0vPdIWIgEflpTK5sMk8MQZEj26M4ZDt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330507; c=relaxed/simple;
	bh=9kg8U/I7iTtYhBC4HBcL5LySSlN4zeLs7ZD1KhdJjP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdFtxd46Lq/Yflqs0jFEhj1H96BrfDelZQ+t57aSGG1LULpiQyKPOh1YKIjdcQeA7tFPLKrOFxQi6S++vIvStodH4VgMrhfTrK2l8bnuTMrzRioBlauRbkrOUgxU7F7OgLaTUmUHmSgTDqMn2+vU6/uiNHAD+EgjZgLp+aOYkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QkAj8plt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745330504;
	bh=9kg8U/I7iTtYhBC4HBcL5LySSlN4zeLs7ZD1KhdJjP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QkAj8pltAJtmonNL2wrSc4wWbqx5IXJPad3NDaCXIor5EVWvxTiLmbEbgGifGPXo+
	 hcpYGPlKcTh3n8NXtYOyNm7QqoVSZEuFQvPq1qfmk/xHgiU19jmNwWOBe0WvQcLaBR
	 CF1Ayi+0VZfAyYN5k8jyJijMBACDx0uDhabH0ghyryOm1bvFWP7RY0KCMUseoV5t9X
	 nxlgDNxVHOjGvSQQAahFg2eYYDpHtJcyy7wSU2mA4vjM9bkpnOdhseqIUCnfjxff7o
	 r1TdWhVdZQsv8eM4Uu/0K4vzKJWZaiE6lz4Mzc7YZNtY1inmvhlldU0jyUTL77Uh57
	 bQeoWdp0gLB8w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87D0E17E078A;
	Tue, 22 Apr 2025 16:01:43 +0200 (CEST)
Message-ID: <3a2c9ae8-06a9-4ac4-bd41-6d0e2dd3636e@collabora.com>
Date: Tue, 22 Apr 2025 16:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: Add error messages for missing
 regmaps
To: Chen-Yu Tsai <wenst@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250421090951.395467-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250421090951.395467-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/04/25 11:09, Chen-Yu Tsai ha scritto:
> A recent change to the syscon regmap API caused the MediaTek power
> controller drivers to fail, as the required regmap could no longer be
> retrieved. The error did not have an accompanying message, making the
> failure less obvious. The aforementioned change has since been reverted.
> 
> Add error messages to all the regmap retrievals, thereby making all
> error paths in scpsys_add_one_domain() have visible error messages.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

FYI - I'm restructuring this driver to handle retrieving the regmaps differently,
as the mt8196 mtcmos are a bit different and need even more, with different names
and this is a trend that goes on and on with new SoCs.... so I'm most probably
about to deprecate those "mediatek,infracfg" "mediatek,smi" "mediatek,something"
for external regmaps, and changing everything to an array of handles in a
"mediatek,bus-protection" (or different name anyway) property.

For now, though:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



