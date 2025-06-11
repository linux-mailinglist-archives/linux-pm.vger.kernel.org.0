Return-Path: <linux-pm+bounces-28463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F9AD500F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C613A9A39
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13F626A08F;
	Wed, 11 Jun 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jwCAm7ig"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCDB2698A2;
	Wed, 11 Jun 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634434; cv=none; b=iHzVnQM/1JFaA0vB+DKpacwIhpyc8GGRRQBMqyLt0jMvhtOLox3kFSnHd89KtkPxcoyjbJchZ0hundFie+L2YvdrjtsY/Vq7hd2h2Ck9DIxeRXXAayhqXofBC9cKF/r7ZX1PKEYqWVlDqZXaw0L7pmc+9Pb7lM6o95sV2WdRdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634434; c=relaxed/simple;
	bh=aVqfa+rUoywoe8vYl+T8e4/6MblA1+D7SSSfmwI7pFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st3rbdYjrZa2XTx+oiF/KtsUt2dCdW7ul1llMo4YMhrEzcvyv1n9gC5fK9OLNroEUZ+EtBVRAaVDMM/WDoYg26ccp0bnJyNt62ttq2XYipbeJSUmQ+VZM+t0j+pXTOxcNFyO08DIhl4GXmMbBEBzg9yUxDe7Mt4ALVmPNsBMWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jwCAm7ig; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634431;
	bh=aVqfa+rUoywoe8vYl+T8e4/6MblA1+D7SSSfmwI7pFo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jwCAm7igJDiNWfPFK6ayvAuRcMPlY1z66lq7UJ37mZGM1K8yDZ4nqgA81Uz5ClO94
	 Yzdv8bfwZ3FT1vBwtw1s/47Ihi1g6glMmOe9uxtuK+gD5LA/JLAVg8rBoLRO9WzkOv
	 Q0S97y5n4zSgKyw5C4rgcBcbQ/C6R0NW6C3hcaKsjUV87IX7oyJHHNZJHzFi6y3v/V
	 KMg5JLdIgSNAKaubYqbj4lmf+bvGoMKowCP1KMm/EgKB7oCB4e0agMFUpkrHEusU4P
	 m9dHi+OheXfchlPaOy/nVPO67AeQWIS9XrAPyJVUfrs4xcBC4UyPggXuLwNVGa0jaZ
	 IRF9KrlWD95JA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3D8517E378F;
	Wed, 11 Jun 2025 11:33:49 +0200 (CEST)
Message-ID: <44c53bcb-3df1-41b2-a5ba-8024cbad4aa4@collabora.com>
Date: Wed, 11 Jun 2025 11:33:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] arm64: dts: mediatek: mt7988a-bpi-r4: add
 proc-supply for cci
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
 <20250608211452.72920-9-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-9-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> CCI requires proc-supply. Add it on board level.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



