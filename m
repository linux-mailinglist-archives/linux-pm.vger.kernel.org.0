Return-Path: <linux-pm+bounces-19884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DA69FF7F2
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882FA162179
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78DE1ABEB0;
	Thu,  2 Jan 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LNHwV93G"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A419CC3C;
	Thu,  2 Jan 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813569; cv=none; b=Ib11Qo8AWn86Rf+KM41YUx0DIpgM6LqbDeteUqiH7t5q69xAA1w3m95fpGh+xOdA1lv4ShYZ+5vfjEsjyCpR/+8B6VAXgNS2GR49hrxSpxnhKRk8dM7ZGqCVTc2inBlhuLkX4JTxIB6t3c7pS9Jmq6eEK95Xw15hGRmSsvFDBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813569; c=relaxed/simple;
	bh=ykJuvkkfSPLUvUQaNqnjAoimIgJBLgUoIdS4Mduzc6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmXH1Y3mdVO8DFbQYiHcTk8PKqrcl/83n/bAJluVBsM5Y8257GKkksABh27gecdLG4j7khgF1pQUdRQBj4cfs2YCUI25MOd1xKmhEcRvToULL4hs9tx4ADCHrzu/ww73ZJBETVXHIoHj4L48fW/VnHOktdygdGkHz48+GSqfbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LNHwV93G; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813565;
	bh=ykJuvkkfSPLUvUQaNqnjAoimIgJBLgUoIdS4Mduzc6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LNHwV93GuGolKA/Xp7D0d4fm6xYKC6ai2DD4iQW8e/Gfg6F7sUvKlYlmED7aGzwwM
	 LvcwkwWBUufowhuNe/0QoRuetd1rCB3mxLbDx9qCMN8fAaNWacclhdTlZbQ5wBAItg
	 Q2xE3ETWG02IIwYjSSNIgWwNBQLtDzlFDAfnFsOsH+gvawTN/UE2kXtPMSa+mRL/zW
	 xy65xJVtlsxwvvIsd+/pyVmAl793ssQSA9gpiRppmmjsqS8RpFOdDgu82c32AnpwBi
	 Iw77BM2oO/OmIWh4/UU+KiNMu9w96tNLzxqyX6qtiAJssrqsFl5xLMaHJWZjdQX9ML
	 QyXWpByh/lkmg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA84A17E1556;
	Thu,  2 Jan 2025 11:26:04 +0100 (CET)
Message-ID: <2183cbe1-e60c-4bb6-89ab-aa0c4da79afa@collabora.com>
Date: Thu, 2 Jan 2025 11:26:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] soc: mediatek: mtk-pmic-wrap: add compatible for
 MT6392 PMIC
To: Val Packett <val@packett.cool>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Fabien Parent <parent.f@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-6-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-6-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> The MT6392 PMIC is equivalent to the MT6323 in terms of pwrap.
> Add the compatible to use the same configuration.
> 
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



