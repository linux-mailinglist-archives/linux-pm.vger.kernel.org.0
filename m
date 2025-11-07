Return-Path: <linux-pm+bounces-37609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB371C3F2D9
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669F03B0764
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA67302748;
	Fri,  7 Nov 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fEglRBsP"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6182FFFB8;
	Fri,  7 Nov 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508058; cv=none; b=Z42WWph0HfLdd7zsGe4frGeHpBSgmQR7K9EC67K4KyAvLwCfpsLRO8n+HiC7f/au0IfQgeGI1Mk0k/8MFzwzx4l5KNo4PCAreYZbGvghIFpw77ibUHzb6QnNNIBYtipynLfFE3nsK+cFdA6MLWzvkyXRSSWodmvOf/28LKlNytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508058; c=relaxed/simple;
	bh=a5UV+lpy9dJymplUqRI6ybHCajuv+eTwea9Ciur0RJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj2Ye3a6heFcHnulNQgZ7yVxF3BWrf2Lb4sX5BuAqpblZV9DOABc17nvbwLshC7O1TiKdKvLmPUYzC3YSwl8mDllBDCBtG9vem8B8cYvfMG1ttxJkojEuYIhKMlfPzevmVumxcfkDtEX6+BrpvN1IO8MgXJumSOJ91bWbXRQXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fEglRBsP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762508053;
	bh=a5UV+lpy9dJymplUqRI6ybHCajuv+eTwea9Ciur0RJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fEglRBsPOQsTZmKXs8OKcLH0cWVanEagjfT04Qjlwm4ZuF27ym/Sjv9+KBKd20oiL
	 PnLIyErMJ3DYtEnAaB47eEveSPBg38+YWCKY49ISzuiBAozG6wW4K3buwuDchX7QDN
	 jEJge2CO6mPLeiXUGXN7is7jvmirC1WEcblWgoOlJsKrSu9lHmnQezKKubpf9mxvpS
	 1OZ/cAp9k9PwvrdQHBx3cY9gW3oF4XhKR5VthJYIP0CSPrzwaGdjZcivalB5SNFc0b
	 V1MgH/4a/XlmjhwqgN/Kwyis1+sms8+fu87uiJqs2XShNfPoLVHOyQr8+30TPH6WFA
	 I9Oywewz2w9qg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B10C17E0097;
	Fri,  7 Nov 2025 10:34:13 +0100 (CET)
Message-ID: <5faabbd0-2e7b-46ec-8da0-7be24f2e888e@collabora.com>
Date: Fri, 7 Nov 2025 10:34:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/21] clk: mediatek: fix mfg mux issue
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
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-4-irving-ch.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251106124330.1145600-4-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/11/25 13:41, irving.ch.lin ha scritto:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> MFG mux design is different for MTK SoCs,
> For MT8189, we need to enable parent first
> to garentee parent clock stable.
> 

Title:
clk: mediatek: clk-mux: Make sure bypass clk enabled while setting MFG rate

Also, please add a Fixes tag, this is not only useful for MT8189 - for the
others, this worked because the bypass (alt) clock is already enabled due to
it being a MFG power domain requirement, but the parent still needs to be enabled
otherwise there's no input clock to MFG during the PLL reconfiguration.

Besides, please clarify the commit description (and no, 8189 is not special
and doesn't really have a mux design that is all that different from the others).

> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mux.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index c5af6dc078a3..15309c7dbbfb 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -414,16 +414,20 @@ static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
>   	struct clk_notifier_data *data = _data;
>   	struct clk_hw *hw = __clk_get_hw(data->clk);
>   	struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
> +	struct clk_hw *p_hw = clk_hw_get_parent_by_index(hw,
> +							 mux_nb->bypass_index);

Fits in one line, 84 columns is ok.

>   	int ret = 0;
>   
>   	switch (event) {
>   	case PRE_RATE_CHANGE:
> +		clk_prepare_enable(p_hw->clk);

You have to check for error here - if you can't enable the clock, your system
is going to crash as soon as you switch parents.

Cheers,
Angelo

>   		mux_nb->original_index = mux_nb->ops->get_parent(hw);
>   		ret = mux_nb->ops->set_parent(hw, mux_nb->bypass_index);
>   		break;
>   	case POST_RATE_CHANGE:
>   	case ABORT_RATE_CHANGE:
>   		ret = mux_nb->ops->set_parent(hw, mux_nb->original_index);
> +		clk_disable_unprepare(p_hw->clk);
>   		break;
>   	}
>   



