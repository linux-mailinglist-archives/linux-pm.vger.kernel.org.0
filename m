Return-Path: <linux-pm+bounces-19886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A1C9FF7FB
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492271625D3
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA01AF0DC;
	Thu,  2 Jan 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H3c7D7gv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19351AF0CA;
	Thu,  2 Jan 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813575; cv=none; b=ZY8LNt//XuLZZ2f7kCxL5D507L0mwRRZvI/hG5pSO1Uw0xgM/WOjGN9ldZ96DEltwQQ+zG60JBuSdAxDkK9s/twH6f22QIC37Se+tLSRzgqTFvxebao373LWW0RR7DTfTQOnKcTIZq0odaXvH+aXWIz1NhMEsiov7DtoiupYltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813575; c=relaxed/simple;
	bh=wJuYZa1Z2y++bkR6W+53NDWLih/Ax8RRNEbL+4eSPig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHt6mR61ZGOSwSPZS8bZNRC7gycbDZrapisvndrCl1sczuvJaK5JnUqP8kd2GAOR2yZx3Dr/rMV3jfO+XCLHLV2Bswtn2pEDL6XUbB++vBz8RrTTKX6SQ9Hll2muxqYE+UxrmVmQeuQN8DUQ1Pm32KNopE8DioTKNUoonGNdtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H3c7D7gv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813572;
	bh=wJuYZa1Z2y++bkR6W+53NDWLih/Ax8RRNEbL+4eSPig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H3c7D7gvvYK0mpbJ13WKxi8g65Gr/jhoTPMC2LUcllLJLGJn3Hq9Fei1upWjqjzlH
	 rRH75WC8Vb0X7qvJGLKpyShTz71K1iJMGG579cAJyMk9gMcN1KjRJpvekRbR2g6odz
	 FpIxhD54WBpRGRJp3kmlmBQA8sCmy1N0KgCzyKEWN+SnFpUy5/X1DL55nO49b7Uybe
	 MIgMU5L185MWQ2dbkJqny8BHNRmZbSnGdSSh3lil6sPiDT5EEcZMH++k7vigq6ey0Y
	 Syl+gfJv5ElVuuh7jt2uD3GOvP9z+e3+Hf8chjVSrPx/jnIU8fVtq5kuo4BgosYD8R
	 IA+prRUCimduw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0049417E155B;
	Thu,  2 Jan 2025 11:26:10 +0100 (CET)
Message-ID: <7dae1442-c6e8-4610-a23e-8f8d4658bad7@collabora.com>
Date: Thu, 2 Jan 2025 11:26:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: input: mtk-pmic-keys: add MT6392 binding
 definition
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>, Rob Herring <robh@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-4-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-4-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


