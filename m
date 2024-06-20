Return-Path: <linux-pm+bounces-9658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6A91015F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 12:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C201C2132E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F91A8C39;
	Thu, 20 Jun 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w1lp5TpY"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633A1A8C2B;
	Thu, 20 Jun 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878913; cv=none; b=MI8hb2a78ZcZE4XROPHe6yUofQ7Rk6+yWKi1Wz5cCvzRWISL1YJ/7gXMFY1WWjPmybxuIdYM4K7dnvfnB+c953BX+r3my9TMl8yAhSybvmI46b+M+YaPIT3VASfWAoxHsj8Mm1rVe/dMCYCtFjmlDa3mzDHtexmdvgW2c9MhyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878913; c=relaxed/simple;
	bh=nCk+s9gsu5b4yUK/EK+MBN5vgThELD1rn/D27UNOsIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIno8LvWVh1+w4INle+d3eSXiMsqx3fmSpZ3t2+2SvoE06LyMIaxQAf12aabizgCn+N/jO/Mq28AycnX0E1Tp7tBMoSE2lYWhQelUnu13IiJVGiCoLy9ga+gRWIIwdn+8XULEz9NIUI/qLCs9Us0f6rRVyGWCMukT+iJann0tKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w1lp5TpY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878909;
	bh=nCk+s9gsu5b4yUK/EK+MBN5vgThELD1rn/D27UNOsIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w1lp5TpYcyof799ZyVr51hHtK12dhICJnFufQGfrbwCs/AS2yjmW7nW1FnEUtmrM4
	 OYUY9WKujoNltnDBlrB0ZrizZijHjPtxkDHrzbiZUQTR/8HbbGFp2qT9rlapmfjqks
	 D8yDrVjFxqGGDQxpwW3ZfGzJ6aEEENRs5ARM6OApuGtszpR/M/vM2lD+WQOK3OwO3h
	 8a2o4xxEwjIjEP6mA9b3lR3IZriQLcSnbQz52zPclKWNTRxqD5AVYhA5i2/tP3XRNd
	 AdJn3sqJwa+yhVrz67mycX3Po/Ove61XwWng5j6h7wGK6WNuWoa20JPV4DSASgRH/O
	 1V6ccWMC5JgeQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DE35E3780698;
	Thu, 20 Jun 2024 10:21:48 +0000 (UTC)
Message-ID: <8d83fa71-4230-404c-829a-8afca6db203e@collabora.com>
Date: Thu, 20 Jun 2024 12:21:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Provide default
 calibration data
To: Chen-Yu Tsai <wenst@chromium.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Julien Panis <jpanis@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240620092306.2352606-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240620092306.2352606-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/06/24 11:23, Chen-Yu Tsai ha scritto:
> On some pre-production hardware, the SoCs do not contain calibration
> data for the thermal sensors. The downstream drivers provide default
> values that sort of work, instead of having the thermal sensors not
> work at all.
> 
> Port the default values to the upstream driver. These values are from
> the ChromeOS kernels, which sadly do not cover the MT7988.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



