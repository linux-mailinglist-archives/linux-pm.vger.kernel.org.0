Return-Path: <linux-pm+bounces-16593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A647D9B35E0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5241E1F22F1D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983341DED72;
	Mon, 28 Oct 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S4RgWV6U"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE171DED44;
	Mon, 28 Oct 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131742; cv=none; b=lPf2VKWSZ2v2C9Cdjem1uxB7YGd9YLjJeDXoJTdVKcsb9P/dQt4QPMhrsL4bBO5SKMHxQHwDsz7B5IwiabgS0qrb8u9ucXZWCbGmVLkX3jetZ5A3eL465k0N0vEQmqYO+amf8FIyCPG64o/ZlKT7r6BCOUifV/RmDWTFarBpP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131742; c=relaxed/simple;
	bh=1THuqio++W+7jbROKSG1qt1l+ZvCjDv4tyB3qjxS6io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZULEehhqhvrWOdQSccN/YIrjfF68LK6lpFNjSM9b6n/7/a8mOz1FyNTmL/sCmZ8JgKDiek4wl3nGzlUvSepdllL9Z1tpywxbF/GBisK+uPuiiNstkaQpZhCwmwLEvXPMm0UVeXa2VW9DKM46A459eEpwv324WeM71LlrttatHho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S4RgWV6U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730131738;
	bh=1THuqio++W+7jbROKSG1qt1l+ZvCjDv4tyB3qjxS6io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S4RgWV6UBYoHHy1QTaFKmYLAN1q/CXAm3CsNGhHrflPcciW64H5FxpZYdcYZPJlce
	 0me9l5SGplWIFagSeoU1bWvPicIHF05fncpaLjGT5XpJTkfplaWixDRKhnT3q7WtdM
	 Jremsj3+ZXTsHpTxUofUmrBwu90kwYq1A73niCG90ezpf0SeJi9fsItAnLZa/cQLCY
	 AafYxnz1XckumeHzycdjISA5g2cYo8/DJ3TtH3l7qmT3bC0SVGvLJnpLybCY8QSD/S
	 Xp7fkThMGRUJ4URiT7IrRLVX39yolJfUf6VIvHHLAmHQ4rvo3BfLsmOOJQLYzA2A4s
	 1+F4dgDxfRFfg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A752C17E3676;
	Mon, 28 Oct 2024 17:08:57 +0100 (CET)
Message-ID: <f39f0740-d0e7-4f8a-a0c5-2d23146672d4@collabora.com>
Date: Mon, 28 Oct 2024 17:08:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt6359: fix dtbs_check error
 for RTC and regulators
To: Macpaul Lin <macpaul.lin@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241004030148.13366-1-macpaul.lin@mediatek.com>
 <20241004030148.13366-2-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241004030148.13366-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/10/24 05:01, Macpaul Lin ha scritto:
> This patch fixes the following dtbs_check errors:
> 1. 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
>   - Update 'mt6359rtc' in 'mt6359.dtsi' with a generic device name 'rtc'
> 2. 'pmic: regulators: 'compatible' is a required property'
>   - Add 'mediatek,mt6359-regulator' to compatible property.
> 
> Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



