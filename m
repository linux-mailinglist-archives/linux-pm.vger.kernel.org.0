Return-Path: <linux-pm+bounces-34831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FCB7CA03
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C533E2A35A1
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68E32D5A8;
	Wed, 17 Sep 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CK3wcRbP"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F1225390;
	Wed, 17 Sep 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102065; cv=none; b=SQIT2K5ja5GTwmyAaiw+2zJIXiguRt7SV7iZaa8AIW+HMhN4o7vzMhQODgBnygiL/6ZRwo8Inowxv6i6nET3PDOXQsC++HakqFxxSTmOXacw9uIo80c3lkQ1m0NdH012ibHXfOI/r2Ou6niR8GbGkEAufVAe0THsEeth0CdiVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102065; c=relaxed/simple;
	bh=yiTw2Nyg3T/+NeQdCbVD+R8TqqELRHWmLB+xAh+cjrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKbnxUGYW/KNJkGHodL/HQuvFRVxgDcTeZnk/1wcqCwks4fHx/eT7dkaXK5swEUBb/1e0bdlxts4mUfmCfellTD3hJnN4qWCNAEVMmKoYp3lEuOfOfh6q63E86lYjWIgSf/pFME/AoyvhlTCCi4vegRyzbWMPqe+t7/0ZgNWqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CK3wcRbP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758102060;
	bh=yiTw2Nyg3T/+NeQdCbVD+R8TqqELRHWmLB+xAh+cjrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CK3wcRbPkUm/RD5cSFPvZM85dvFTYOF3yu5E7DFatwJfUPDGPSfA9ptmYukX9piJx
	 ZBN8sTreTr5vm4js3HyQnoK5Wdyfvq+hWQNVp4gPIPDESkAzdLv7sFsMjD1dMKnkd3
	 /xr8GCfR3FiLA3+OadvuT6qMvGSsNmjhCSsyrwHyYfJyVl22Qo7GFPFIxOrTfY7Sqp
	 nKVYfMTFLW4oODubiq+pC4GgWqwa7/JFkrivm0sgSXqUru1yF93QI+2+EQuULIdBvc
	 3zhuk7kjqnMNw86+kyltd7H192mXMLr+/BVXjz2nIUfardinEdVPcPNKjqRwrI+/lj
	 xNgaeYiCaGW8g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E6A5017E0202;
	Wed, 17 Sep 2025 11:40:59 +0200 (CEST)
Message-ID: <eb2b4c98-44b1-4e9a-8e6a-1bc19b42eaf5@collabora.com>
Date: Wed, 17 Sep 2025 11:40:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] pmdomain: mediatek: Add power domain driver for
 MT8189 SoC
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
 <20250912120508.3180067-5-irving-ch.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250912120508.3180067-5-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/09/25 14:04, irving.ch.lin ha scritto:
> From: Irving-ch Lin <irving-ch.lin@mediatek.com>
> 
> Introduce a new power domain (pmd) driver for the MediaTek mt8189 SoC.
> This driver ports and refines the power domain framework, dividing
> hardware blocks (CPU, GPU, peripherals, etc.) into independent power
> domains for precise and energy-efficient power management.
> 
> Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>

No. This driver is legacy and shall not be used for new platforms.

Please integrate the MT8189 CMOS in mtk-pm-domains instead.

Regards,
Angelo

> ---
>   drivers/pmdomain/mediatek/mt8189-scpsys.h |  75 ++
>   drivers/pmdomain/mediatek/mtk-scpsys.c    | 967 +++++++++++++++++++++-
>   2 files changed, 999 insertions(+), 43 deletions(-)
>   create mode 100644 drivers/pmdomain/mediatek/mt8189-scpsys.h
> 

