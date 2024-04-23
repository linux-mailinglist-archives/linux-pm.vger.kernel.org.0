Return-Path: <linux-pm+bounces-6914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D58AE0EB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 11:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F6B2824CF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CD5C613;
	Tue, 23 Apr 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cmeFpD26"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430C56B65;
	Tue, 23 Apr 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864133; cv=none; b=KIeBaEn/n7ENiKqWfeXzjBOBBzBZhxA+kBpElxlns8b7nt4zzTjDRNmvZMoHwg+pQoQfN9sLU4FIBmpRJ+y2Hcy5d01UohiI0Fw8+9Dl88QOiKnC1bLt6aXj9PlbxgvAphxsHxbUZHpcyJLyKbjxFfVm8hD4toA/DwXxv3cY4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864133; c=relaxed/simple;
	bh=FjKigUCfND/yp/nDDgcfrG3dAnCXLuVl43TcITs3ywA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbRsdG/AuTOAKZc8ioIaiIpMGavzNDi1ToC/h34nfOGHV4CBRMxVOGwGBf1ZIAwdNyVcbxLQAytEDMQOQNou+bbI4nsjgqYg9nhIjSMc5lFaRxMIFJKYqW1ku7sMGmkvNoagQmXjA7+lEsq1SoTDCJL8KV7mZYFvPP7p7ic8tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cmeFpD26; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713864129;
	bh=FjKigUCfND/yp/nDDgcfrG3dAnCXLuVl43TcITs3ywA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cmeFpD26AokQActMeUtYI378J8vQtgdQ/44EN20pPRIvLBef2hKpchW5av5QRs7/4
	 dMqfUD6PbzcIFpFuHLUjgSQrsIdPUCMnzXAs7/KLGybd2xWI3GGpTT3FI1Egc4OcLS
	 MW6V8IcTOhte8770C4qxsTYRxUjB4YvVNz/aai5vtiiUtVe5ikpxNU9d9/nR4bMsiT
	 BwWBUHiydI13yCNfsIAYjSAH7c5THIL5OrDNFPSBKHUr5friWlRUfyrhpvYG58i0an
	 +yAvKNKcMZxqgvWDU+d09nDdmvihR9BiHnJFGmcjD2oTYAG8RMXovPPDsiJqCXPafr
	 eXUvdbZNBTZIQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4B0633781453;
	Tue, 23 Apr 2024 09:22:09 +0000 (UTC)
Message-ID: <981a8748-16d0-4744-b097-aa9dd14c63a8@collabora.com>
Date: Tue, 23 Apr 2024 11:22:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Mediatek thermal sensor driver support for
 MT8186 and MT8188
To: Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240402032729.2736685-1-nico@fluxnic.net>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240402032729.2736685-1-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/04/24 05:25, Nicolas Pitre ha scritto:
> This is a bunch of patches to support the MT8186 and MT8188 thermal
> sensor configurations. Several changes are needed to cope with oddities
> these SOCs implement.
> 
> All values (calibration data offsets, etc.) were lifted and adapted from
> the vendor driver source code.
> 

I picked patches 7 and 12 (and also fixed them) introducing the nodes for the
LVTS controllers, but will not pick 9 and 15, as they're either missing thermal
zones and/or using the wrong names; let's wait for the next cycle for those, as
I will also be able to add the SVS on top (needs a bit of time for testing),
getting both SoCs complete on the LVTS side, without rushing.

Cheers,
Angelo

> Changes from v2:
> 
>   - use meaningful name for binding index definitions
>   - reuse LVTS_COEFF_*_MT7988 on MT8186 per reviewer request
>   - do similarly for MT8188 that now reuses LVTS_COEFF_*_MT8195
>   - use thermal zone names the svs driver wants
>   - adjust some DT node names and iospace length
>   - remove variable .hw_tshut_temp as it is constant across all SOCs
> 
> Version 2 can be found here:
> 
>   https://lore.kernel.org/all/20240318212428.3843952-1-nico@fluxnic.net/
> 
> Changes from v1:
> 
>   - renamed CPU cluster thermal zones in DT
>   - fixed logic to cope with empty controller slots at the beginning
>   - isolated bindings to their own patches
>   - added MT8188 default thermal zones
> 
> Version 1 can be found here:
> 
>   https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/
> 
> diffstat:
> 
>   .../thermal/mediatek,lvts-thermal.yaml        |   6 +
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 256 +++++++++++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 383 ++++++++++++++++
>   drivers/thermal/mediatek/lvts_thermal.c       | 434 +++++++++++++-----
>   .../thermal/mediatek,lvts-thermal.h           |  26 ++
>   5 files changed, 987 insertions(+), 118 deletions(-)


