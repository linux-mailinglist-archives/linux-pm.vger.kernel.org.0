Return-Path: <linux-pm+bounces-16104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288DE9A6A1F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDF5281FF7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4471E1F8EE9;
	Mon, 21 Oct 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UbKTYOde"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA161F81BA;
	Mon, 21 Oct 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517144; cv=none; b=S80wHPhzS9ELqNvfcWby2fimaqwDrAnHgzJUXv8NJrzDYbS/zM2iv3baO9CSLPXLwCEUXLfyzkJDA4uTeaUmtk1hEiJmrStWHXDHOFFhQ4DzeEjpCj8DAY8kCJcbCszGCp+zflC6S2AcHEmdS/ygoJmJ3oIgK0SvmryKbjdWuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517144; c=relaxed/simple;
	bh=uYWC/DG5xTZcjFW/SXNzk+0WkPCWF8jfgMFknvCWaL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB2CnA972MfbgqLOPqoe5yIC3jN3OEfxmZLa96V0E7NSiWbT/S2dVaxVlREKvlcy8vlZ+Gse6C1TLkcVQ/6fZfv/J01xfY6nwtX052ffE3HUQAaRlH5LxjMghPRXoYxJPQLccOv7YeD3gnpTlsXDX4mEQI9tH5Ohd5oWTgBqRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UbKTYOde; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729517140;
	bh=uYWC/DG5xTZcjFW/SXNzk+0WkPCWF8jfgMFknvCWaL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UbKTYOdejnTHi/frnF0rQvi0lsfZVRhD/G2+Xt04xboSHKvtlP1cL2d6LgF5uRt9V
	 3MDeCJqbt8cjehzRpvNTxuS/tuwutHx0W0wQH5+SbDHUsSzn2MRd9F9Z6INBFbMxKh
	 8ePXfFXDgq/aQIbCOiQRxl90Us+pClWLRVx/1R3VS5yKstpdmqc18jsHQric7uQgPZ
	 tRbH9yY2y1M43G6kAe75kbCNxWYmBV95rAP/yMKfpCYJ/IUAK1UxHTtsSlO51U2EWp
	 e+xGPTfm0AAX/CTE2P2p+OZkms5lLrctjUSj8RclEKC9Hf6Oz8Gp3oWc5tWy2hD00C
	 v83s+ZuqUvP0A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B59F17E3618;
	Mon, 21 Oct 2024 15:25:39 +0200 (CEST)
Message-ID: <9aa9a99a-4518-40a6-9556-7de1d0669327@collabora.com>
Date: Mon, 21 Oct 2024 15:25:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: mfd: mediatek: mt6397: Add bindings for
 MT6328
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-3-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018081050.23592-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 10:10, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add compatible strings for the MT6328 PMIC.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


