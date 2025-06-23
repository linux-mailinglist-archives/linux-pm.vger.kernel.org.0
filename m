Return-Path: <linux-pm+bounces-29263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BF6AE3A86
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2849D1892156
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C08A23ABAF;
	Mon, 23 Jun 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V8bbwTY9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB2239E8A;
	Mon, 23 Jun 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671092; cv=none; b=FpvkZPx9F5oT24kmDnu72hyPIBdpDaoyzOOJyAQBUwhlfuEJQX7MY02AyxZYgrBe2GCqiRmKp/pJbLTKRq2jSx73wom7cJ3gfKqmH5Uak1aSpUdsDqJdmId2BeYZJeqfyH0U0Uw+T1YJZk39U0imHk/aQZX/k7rQTMA0RlChmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671092; c=relaxed/simple;
	bh=JaT2s8sZCiv76xiTzrJooBxZJYaZSavMoRgZIB0v8Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPtszRqNzrqwtNY0nLlVevSRiBegmRTpR869TquMIAR5YZ1Z17gi1OnTqNNZg8OXN2G/mFw9IWkK8+CA+pX02e5o+mvxbhtuuD73zvpW5AmrebP6SdwicD802e6D5/EAjFlQ1allVKWnf+Z8m4WQwfzCn8qfgST0b/FJanOvhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V8bbwTY9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750671088;
	bh=JaT2s8sZCiv76xiTzrJooBxZJYaZSavMoRgZIB0v8Mw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V8bbwTY9p4Qb0yiujQohkXGHiM8iQRUGkFFJ9UUyQtYLEU3HGjM1ZSmTb/N3Dysn5
	 Zxk8e8CXXsX2AYWNi7dB59K3eiPQj8ln4KPD9pYmRV3wpSriIJvSJ6thH2erf1QSw9
	 2Ki7ciAd8Y/fCc7yvLVFktNpegGnpBhzvPLwV62PLY6PNJv4fgjnGxF068GzpQVUC+
	 R40CN5Poejkjfv2xrMlEMxS6gBjqItwX5OekjaTu6XQUIwzJ7uaSm+THljd9S2HbGN
	 pyekTCUxXJ9dSFoLoiXlG8lBh4ylv1xqlqqjNhdDTnGnfV87+WaaxEOKYnsYMyi6oc
	 Sw03x2XUuTRJA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 19FF117E05BD;
	Mon, 23 Jun 2025 11:31:27 +0200 (CEST)
Message-ID: <a2e006c6-89d8-4997-a759-a461bcf891ea@collabora.com>
Date: Mon, 23 Jun 2025 11:31:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp
 cages and link to gmac
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
References: <20250620083555.6886-1-linux@fw-web.de>
 <20250620083555.6886-13-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250620083555.6886-13-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/06/25 10:35, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SFP cages to Bananapi-R4 board. The 2.5g phy variant only contains the
> wan-SFP, so add this to common dtsi and the lan-sfp only to the dual-SFP
> variant.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



