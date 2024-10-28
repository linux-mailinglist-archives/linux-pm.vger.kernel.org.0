Return-Path: <linux-pm+bounces-16592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFC09B35DE
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6661EB21CD9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB91DED5B;
	Mon, 28 Oct 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LnP7lfOS"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAC15C13A;
	Mon, 28 Oct 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131741; cv=none; b=HLXqPXSH8LrTvLaQPALdLtzB5W6dQhzeDxMHsHz3wzFTtzxiLiPAaGdAsJIFwC8gue0/FXopJ74PokMEdqobcb/VqKvexmQmfyuiOXBz0CCPE1Jsfeo7rj//nzMQ/zU74iS2eTX4KzQvd0Mey8kX4oKQuroDYqZKBXNhW63Sjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131741; c=relaxed/simple;
	bh=RFIuHkEL9QlURGA8odJLQx+5TzCk9F/XU/g4Ze+ayaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0RnLbNDTIPOYnTiZBHm2E2Fw3qshNrpAPwLytMs2sbsda+7cY0tyDYnrWu96W1iBWqtgXgnVfYQ++MvXvkANNCwIPagji/sPY3kSKg4Hqlo+XYnKfyXPO/Plx+abPU9z6ebIfkauVY/TtY1BSaBqa+LEhTv0WZOdKn0KhzK47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LnP7lfOS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730131737;
	bh=RFIuHkEL9QlURGA8odJLQx+5TzCk9F/XU/g4Ze+ayaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LnP7lfOS/ZKF0gdhu6J4yKLLyvp6/z6MZnb8GwOvInLDSODHuT4wcS3dC36ZFWSKM
	 oUMo6abWT5nc69ETfNHy0ZTItIvwU1ZjooRzCz+Hh3PoBNanqgrlbV3/5v+kPRdU9h
	 xEc1vCOOm1ysf/9jwW6gUZl5AunFMwPuCE6RE4SjsmWHSkmbIZm/fPvIzUw/gWIdMz
	 1GqSGykSd5VCOjWf0c7pCksRO/yjQKJF78jnY0xAfLcLWow1xgPgAzfjH77o8xz5WV
	 iW6u9KiYfsn35uS+sVN/lCVBHdYllJt48fAnq1qjV8pqqIW0Ldk6vxEJ0rmbAeMZxP
	 1p1Ry3c1FgwGA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A783217E3663;
	Mon, 28 Oct 2024 17:08:56 +0100 (CET)
Message-ID: <006dfe88-25fd-47a1-a57c-3345af2bff21@collabora.com>
Date: Mon, 28 Oct 2024 17:08:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: mediatek: mt6397: add adc, codec
 and regulators for mt6359
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241004030148.13366-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/10/24 05:01, Macpaul Lin ha scritto:
> Since MT6359 PMIC has been added as one of the compatibles of
> "mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC",
> "MT6359 Audio Codec"  and "MT6359 PMIC Regulators" should also be
> contained in this DT Schema as well.
> 
> This patch includes:
>   - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
>   - add 'mt6359-regulator' to the compatibles of regulators.
>   - add 'mt6359-codec' to the compatibles of audio-codec.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com


