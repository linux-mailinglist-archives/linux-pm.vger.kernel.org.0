Return-Path: <linux-pm+bounces-23761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F9A59598
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 14:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133D416AA5E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC8225416;
	Mon, 10 Mar 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IheArypQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1F178395;
	Mon, 10 Mar 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612115; cv=none; b=ako2Xd6poivFYaVQVoXTDlugr5Pc0s/he8x2sxbig4FT35zBxhwo1YTMPjWSDyDftck2SiX84jZJW56DsdkcgIF+tFSpNTglhYqwoxyUfkT4NRR5CTSjvXKHa5LPdsR83mKT0/RGGy7mPNWw/K0KhIUKF8P7joC74JZ7SpAR4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612115; c=relaxed/simple;
	bh=2V13hVHvXTQg/CvSvaloH3gQXs0wrbSB+sIyuBsXghs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tH+5vQagTJRz+4RgZQa7VwIteKQCebScZ/PbctH1K3tXDPYKzD2D4thoebMvGK3BntyvquEErFWDvca4edE/yL/86Y0tuNbQ8QxC3AReRHQB6O0rR3PLsvwfrJ3iFRePOXn6sI+Pjgphfi7JM2Y1mAiG2qhJDmpmmk/w9aRTNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IheArypQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741612111;
	bh=2V13hVHvXTQg/CvSvaloH3gQXs0wrbSB+sIyuBsXghs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IheArypQWOv9UwpKrgUcsLA0s7vBqv5CjrTQWYvVaDACSjJcSVW7bOxWJJRWuNh+K
	 P8pVN2NV/ZzDfik5eC98VMBi0z9/pAVoYCsSipyoaSWI14fRFHIAcgFx9/07A9jH2f
	 ikaVTr48JHjOeEvHeYEWjriIS8PvlAMvqWegW+2YuwO2lQEzImraGGMR+xrR1U3ZbX
	 tDSpvYfMD461Pmq358tMEeUNDUiPbGuhIQY0jJSpDpJQvCAYB3sZPT5Rett2ym7MvC
	 29jSKLt//tJqG22ia6WF/qvx1lBLSabvt2VLpd5gDufDoCc4G2GrxcJHYCcPqtUzs4
	 HYeq7Ba7hvQkQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BE4517E0B56;
	Mon, 10 Mar 2025 14:08:31 +0100 (CET)
Message-ID: <0abe6c3a-cffe-4aec-a95d-ea27704729b2@collabora.com>
Date: Mon, 10 Mar 2025 14:08:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] pmdomain: mediatek: Add MT8196 power domain
To: Guangjie Song <guangjie.song@mediatek.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250307034454.12243-1-guangjie.song@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250307034454.12243-1-guangjie.song@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/25 04:44, Guangjie Song ha scritto:
> This series is based on linux-next, tag: next-20250306.
> 
> Changes:
> - Update mtk-scpsys driver for MT8196
> - Add MT8196 power domain support

The mtk-scpsys driver is deprecated since ... 2 years ago, and I have no idea why
MediaTek folks still use it downstream.

Please refactor this and use the mtk-pm-domains driver for any new MTCMOS
implementation.

Thanks,
Angelo

> 
> Guangjie Song (13):
>    pmdomain: mediatek: Support sram isolation
>    pmdomain: mediatek: Support sram low power
>    pmdomain: mediatek: Support power on bypass
>    pmdomain: mediatek: Support check power on/off ack
>    pmdomain: mediatek: Support voting for power domain
>    pmdomain: mediatek: Support trigger subsys save/restore regesters
>    pmdomain: mediatek: Support power domain irq safe
>    pmdomain: mediatek: Support power domain always on
>    pmdomain: mediatek: Refactor parameters of init_scp
>    pmdomain: mediatek: Support bus protect with table
>    pmdomain: mediatek: Add post init callback
>    dt-bindings: power: mediatek: Add new MT8196 power domain
>    pmdomain: mediatek: Add MT8196 power domain support
> 
>   .../mediatek,mt8196-power-controller.yaml     |   74 +
>   drivers/pmdomain/mediatek/mt8196-scpsys.h     |  114 ++
>   drivers/pmdomain/mediatek/mtk-scpsys.c        | 1276 ++++++++++++++++-
>   include/dt-bindings/power/mt8196-power.h      |   57 +
>   4 files changed, 1483 insertions(+), 38 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
>   create mode 100644 drivers/pmdomain/mediatek/mt8196-scpsys.h
>   create mode 100644 include/dt-bindings/power/mt8196-power.h
> 




