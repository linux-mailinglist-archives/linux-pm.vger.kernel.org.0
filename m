Return-Path: <linux-pm+bounces-41084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B584D3A802
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96277305BC3C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35849314A77;
	Mon, 19 Jan 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k1k9lPCX"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E822FE0E;
	Mon, 19 Jan 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824407; cv=none; b=kFB8yj1nS/tofAttA7dtg0fBIzgILXMJqcqNUBPluN7D6T2k9EeetB7vl1DowCH6beuO1o/X680wr9lYZHHNMjRozbb3cnN5YkRMq7/FDpSi4A9jrzIkZ50KHlO9CEgKMZBvNhKKyqacV8z8OG8UYZCgI6Lqnqzam9b3Ug7uG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824407; c=relaxed/simple;
	bh=pPdubwyELJ6eLp6ruX+Kdi2iQrXdabzZV/vm7/YSVjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXefFXjdXanM/wvJ6FBbq2QEmToYIWkCvOH5e36nnhtvrOIzeLwxYqm1/dz9ZKFFtkhzQh6kq+wdWP1JZLckIDg7c7LF/JHml159ojI1tKNP29/umAnLodRZZ8/IxI98XSOOp3Y69NcL/RxMUgMW8YT769Iphnatp2QpVw9LiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k1k9lPCX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768824404;
	bh=pPdubwyELJ6eLp6ruX+Kdi2iQrXdabzZV/vm7/YSVjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k1k9lPCXUjqexHoc4MT9fjH24GqwS6e25/S5egxGsqN7wAgUpKktMAlNW5K7rMDI8
	 0k+yKOSSRv0UTGep45P9j5uoBGr2cpnxcg0dYIhFkRElMvN/AYXN2ZAIvo6+6hyAxt
	 8S1IS2C/vhVICIrxuLhDSfmqOtCfVUwtC0yORqiXgpQHP5/Whm7jSgVI8J94Ova1Mh
	 aam4DM7QxRXUVwUpX5vStEzGHE9yr1tyv/VsK4FA96+DdHfCn46a1nqDirArP8nmCF
	 0hcfnjVG/CekH6ekakMeJa4XDfFcDc4H45luv28JAU9L00+IqLhStBanOofMZVY3C3
	 K+piMja9NZL2A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4686F17E0117;
	Mon, 19 Jan 2026 13:06:43 +0100 (CET)
Message-ID: <351b7dec-8b82-4ea2-87fc-ab07b2fd145f@collabora.com>
Date: Mon, 19 Jan 2026 13:06:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] thermal/drivers/mediatek/lvts: Make number of
 calibration offsets configurable
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, fshao@chromium.org
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
 <20251125-mt8196-lvts-v4-v5-2-6db7eb903fb7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251125-mt8196-lvts-v4-v5-2-6db7eb903fb7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/11/25 17:16, Laura Nao ha scritto:
> MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
> supported by the driver rely on 3 bytes. Make the number of calibration
> bytes per sensor configurable, enabling support for SoCs with varying
> calibration formats.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



