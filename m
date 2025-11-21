Return-Path: <linux-pm+bounces-38366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06440C791C0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DA52365119
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1732F6939;
	Fri, 21 Nov 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dc2UOHlt"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23613959D;
	Fri, 21 Nov 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730035; cv=none; b=Up9UWJNK0y5hOsHNH2XYTcsbZpaqltTZtutEssRXhU3/nCfY1RcEsanmyjq1h5iUd/MrwYbcTuYfsR2cXF+I8snDWTEVYE+DHl8RZ3WeTg/MBV6wv0X7LditnsInk0Pchd09oaAmjNMJBBRDg/2EqldQ/ClflVxkPhVfAlPxESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730035; c=relaxed/simple;
	bh=0q8lJac2Ro37pgatCsRo9rk/Wt2xs8etD7oACwU8Mys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFnmB/uNWbH/5JwRBDAuWxG9V4K849wGGMg3Lfoqcc5Df0J27H0FKLrSVxRFC7N/PPujAKTkGfLgtTqjsFVCP6kdOCB4lFPYPfU663qILkyYZYxzQniwW/L+S0+UD/5ZXh/7G189uL0zX+wVKYZ+eswXyCmpWfktG/Jbe4ewl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dc2UOHlt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763730031;
	bh=0q8lJac2Ro37pgatCsRo9rk/Wt2xs8etD7oACwU8Mys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dc2UOHltPreccS0EiGGniBIQW6xWYGJxrfyhCSrXwW74ZlRGLfE+O9Ih23ROR8OFY
	 Os+4946W9zkMljD9lCB9N47w4I+saTyhg2wUAHzAImN29OrOZwS/KgL2EttQ9iRrpG
	 kr8KeKUXlU+MU09OiNoMZDF/lRHQvydHCcrvQ73aiWaCbrsq4UrPUMwj07TI2P549L
	 r9XOYL1Hjmdbs7hgOuyA0JUj6gIOexz8AqzMybOxRqIG+g+l2CmGRxBWjFyp0oxcJL
	 TepJ8p4SZO+XOrwmE7NquSAsH7mWYe0nAvDHDeuJ8Hi60fQ0TZMM5vzVtPiGziSjdM
	 wSaWfRY9ukSzg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF3FC17E12D2;
	Fri, 21 Nov 2025 14:00:30 +0100 (CET)
Message-ID: <84571de3-27c4-4448-a3fc-b937d175de29@collabora.com>
Date: Fri, 21 Nov 2025 14:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] thermal: mediatek: lvts: Add platform ops to
 support alternative conversion logic
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 wenst@chromium.org, fshao@chromium.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
 <20251121-mt8196-lvts-v4-v4-4-357f955a3176@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251121-mt8196-lvts-v4-v4-4-357f955a3176@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/11/25 12:16, Laura Nao ha scritto:
> Introduce lvts_platform_ops struct to support SoC-specific versions of
> lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.
> 
> This is in preparation for supporting SoCs like MT8196/MT6991, which
> require a different lvts_temp_to_raw() implementation.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



