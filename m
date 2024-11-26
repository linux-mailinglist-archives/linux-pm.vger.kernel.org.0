Return-Path: <linux-pm+bounces-18117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6E9D94C8
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 10:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF13164B60
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7FB1CDFAE;
	Tue, 26 Nov 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G4yBJzk7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85EB1C4A3D;
	Tue, 26 Nov 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614233; cv=none; b=XhMRIwNriYvtVUIGptUO2x173uSW2ejDe9WtMB6wWWTfhP9LZ+aCyVK4J/G2hwJmNqGXrrOWWLjc08lzZEd0RtPYH3C2lMId06D/WTi2uLh4phd5LFIQxUjWBKibwplvltLk/0Nj+7cXZDS1EqqdPLXfFdQYB3XFgMvX9KxIoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614233; c=relaxed/simple;
	bh=silOpgBaB1TBfyEkySYbdFpUMzvfOGkWRJVI7SuKIcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpIa5RntIQNkWZ1XbyuIlUlwoiVaMW3oYcB6RwG0jDaCUqIbIsbe328sf3Um/I+pzZ6dgmMneF9VXzNeZ7F2P1/N2WZvspxvX7fMV1zXllWvgqE4pXwIo232cxFVPChBcuqFw8f9c08f+YqmCELpBslWuwIyHJhHDelKwPX253s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G4yBJzk7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732614229;
	bh=silOpgBaB1TBfyEkySYbdFpUMzvfOGkWRJVI7SuKIcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G4yBJzk78+efknk2ReghOk5HGUa5kceRDLNt5ZNvSo/lreXTqMihuYIuBBvTw9hVy
	 FFjaWx8j/mdTjC3cshUAeVm32yDISS6PlvZuG6BrUTG7wt4WXbiK9ci7AlqoUCFWv2
	 nGbA8emn67cWT09UkMaE22cZRZfuVGlheCNVN1x73MloygYAqr531HfiH4BcgAXJL9
	 iIjT9vxP4L14bf+MAiEDrcm/ozV0UO8rJ3ryiCmnmfwIyU1oe/nx785Ric4jLtjPVT
	 2FRgHw3qPVuBvPLU1sWzKS+gC0cZlm2fELx85a6xgaGQjxMkcy6bvWp63LcxPX5+wJ
	 gNjlXzb5NZd8w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C8F117E35E9;
	Tue, 26 Nov 2024 10:43:49 +0100 (CET)
Message-ID: <6eece7bb-acb8-4b0d-9d45-86e8dff44ed3@collabora.com>
Date: Tue, 26 Nov 2024 10:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] thermal/drivers/mediatek/lvts: Disable Stage 3
 thermal threshold
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 stable@vger.kernel.org
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-2-42e3c0528c6c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-2-42e3c0528c6c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/11/24 22:20, Nícolas F. R. A. Prado ha scritto:
> The Stage 3 thermal threshold is currently configured during
> the controller initialization to 105 Celsius. From the kernel
> perspective, this configuration is harmful because:
> * The stage 3 interrupt that gets triggered when the threshold is
>    crossed is not handled in any way by the IRQ handler, it just gets
>    cleared. Besides, the temperature used for stage 3 comes from the
>    sensors, and the critical thermal trip points described in the
>    Devicetree will already cause a shutdown when crossed (at a lower
>    temperature, of 100 Celsius, for all SoCs currently using this
>    driver).
> * The only effect of crossing the stage 3 threshold that has been
>    observed is that it causes the machine to no longer be able to enter
>    suspend. Even if that was a result of a momentary glitch in the
>    temperature reading of a sensor (as has been observed on the
>    MT8192-based Chromebooks).
> 
> For those reasons, disable the Stage 3 thermal threshold configuration.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



