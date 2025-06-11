Return-Path: <linux-pm+bounces-28462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A3AD5021
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A021BC366B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF4269AE3;
	Wed, 11 Jun 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nqfkRAAy"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100C269827;
	Wed, 11 Jun 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634433; cv=none; b=Ti0c6KfIixlCrVIJyV7WUaMCW1za6+ErtRKMUb5mnhPLwu0PDvHm7hWnKafwXNIwdGKgIjDzSYsE3OKb7wZ8jOHYEeacdeo15ywqmh21LaU41IBDms9pPMgKaSrbfwd0LMpzGey1kdRf8EK93+R9CZVf1xMQSNjE6klmWa/zgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634433; c=relaxed/simple;
	bh=zCCyZx0OYW+yvOTE8Ci6a80riXGgIIfyVSbsjo4X6m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTMs392rdLf+7PSjevD7/sTwXNjnGePRCO2xepo/4i/JU4udRyQAOkfUD51TEwzsxE8AmDsAEcuQCgUpywNN7/P5He8V/9D94zf5eDMH3K02KC/VpsOJevkr557et4COUfAR24xTx8Vlgf5DtsykdxD4IkCEck4i7LGc7JFrDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nqfkRAAy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634429;
	bh=zCCyZx0OYW+yvOTE8Ci6a80riXGgIIfyVSbsjo4X6m4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nqfkRAAy682u+Zdra5IbBIOtKVicuau8Bqv51dmGLvltbOZuF+adcBmAxNZHMdaZ7
	 cDqFqnCtkA/DEmAf9ZeNNs4ujX40m3PTRkQiRBIwbl7xUe2CkjvYRXCtUbgS4Il8I8
	 mlI3LAjxCFVcsGJXMb9dzb+DcE+0yJSOkUJBpLAQj5PX573l4WLm2ViIEgwfd1WGOm
	 OscA08n9U/Y1x9pI4pxDXTQObOa0E/+rV49oGsXO/+9+AW37l1SOoLknadhHR7JFAA
	 gkK4ODNoPpUY6SilMyccCyoLVFfUnyQW1HJjXUfmAkF2Vpp4pLx0F7ivfXCOLIRzcS
	 dnqG/J2HWTWOg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ECFE817E36D4;
	Wed, 11 Jun 2025 11:33:47 +0200 (CEST)
Message-ID: <d9811928-5236-43d7-8343-2cd26cf873f2@collabora.com>
Date: Wed, 11 Jun 2025 11:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] arm64: dts: mediatek: mt7988a-bpi-r4: drop
 unused pins
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-10-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-10-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Pins were moved from SoC dtsi to Board level dtsi without cleaning up
> to needed ones. Drop the unused pins now.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



