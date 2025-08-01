Return-Path: <linux-pm+bounces-31732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A1B17D7B
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD56662254F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23E214209;
	Fri,  1 Aug 2025 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yn+pVNue"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D952036FE;
	Fri,  1 Aug 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033328; cv=none; b=lDMHh4G6tEmo7MKcrBXWp8kadb0FGZpw2bi8yoE1SrVcG1UUBUymLtEAKgTa3yqGAIdh6VqnApOk6JSx2VDoW0VQNv56F6gggy6KYUfyEAAnA0+dCXyrJJ9L1ghu8hHmGs4CMaRK2oFO1Y+1fMl3wFhuBYscrbBQBd6atTDqnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033328; c=relaxed/simple;
	bh=jXYnqKd+evMLO6CdXgt/eiSiWPrES/uLOFR0c+/Ng1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJ2id01bhaU//XdiNbiyAJwgZ4+24NiVfRu4k8b9Nbou+3j456k1b0NEzPYuKg4hYXF2iwDRtobCCrY4m2iONALeD/2lv38gSmwN9d4S9vIOqCVaRv801zkwp7xEBwDwZMnuT1MQaWFvH4aW6Py+qI01wcEhN8OB0KmmUfHSKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yn+pVNue; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033319;
	bh=jXYnqKd+evMLO6CdXgt/eiSiWPrES/uLOFR0c+/Ng1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yn+pVNuew58PUcsiidTiHFo6YO3PUcK4wnCs5F1lV+vwHfnMx/QXXLdYdpBMl3Z44
	 nHEgMMNpc+DogNWCPVIWvux0fT7edEKTJ2Y6gCuJXRt8sTF96ifOHmrlKyxBOlJrEy
	 k1BejyM4RzROH646ZXaLvyI1F046zUdrRtV8p07pzyww7qJZcMOZ23twBM7oSdXsQn
	 aBC6KHRUBnacIHI6RNY8Rwrk9LPSiJtZUNuLchABUmt4uOHer02BEHwp5WlaIg8F9u
	 9g6mGjue0qPQhzw0INM70tWhdKJNjedk/4mTPQ76a6dnpnqiHR+Jadl41U+PK6iHMQ
	 615It7xfCE+3A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 496BA17E130E;
	Fri,  1 Aug 2025 09:28:38 +0200 (CEST)
Message-ID: <ff101a12-2b71-4641-af57-f70f4055cd78@collabora.com>
Date: Fri, 1 Aug 2025 09:28:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] thermal/drivers/mediatek/lvts: Guard against zero
 temp_factor in lvts_raw_to_temp
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: wenst@chromium.org, nfraprado@collabora.com, arnd@arndb.de,
 colin.i.king@gmail.com, u.kleine-koenig@baylibre.com,
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com,
 frank-w@public-files.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250730152128.311109-1-laura.nao@collabora.com>
 <20250730152128.311109-4-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-4-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
> division by zero and ensure safe conversion.
> 
> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff configurable")
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



