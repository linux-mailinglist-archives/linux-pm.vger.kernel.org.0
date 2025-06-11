Return-Path: <linux-pm+bounces-28466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B37CAD5066
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59831886728
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8426280F;
	Wed, 11 Jun 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KkgND5am"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D82206BB;
	Wed, 11 Jun 2025 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634828; cv=none; b=s0fW18zqQrbzJ2V25MypNqW0L8Sf1IZw3Ezvr4nAwURn7ImRVHHSXQ3d8JYLpKoQONYNJO5n7Db8Y0p3oTPdPAzrd8VRBjKDm02I7b3WDOCLJKvrXsydvyuvQRYlpmJsq5USMHWQyUcPVebitcAaajRucQrqItgXa2OzCoQdlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634828; c=relaxed/simple;
	bh=aWSrVg6trcSvidS1Tw5OfSRqvl9oKQxDz8kbvLt0OCk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TERaD2K3bzl3itZaYUnk8C+sbkNxwaMM+RKfmSJ9m+eFGy4wer20cidPWyHqKcuvK2LRWoLmrjYnLadgTEjOqicFrmiCwZiWu63RIohClydPNOqZVpSR2ZvWDV8v5um7HI8olizLOoJBTqh2Rps0rNxyo1WmUnHitMLlYe1wv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KkgND5am; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634824;
	bh=aWSrVg6trcSvidS1Tw5OfSRqvl9oKQxDz8kbvLt0OCk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=KkgND5amME3BftnewrZ+UluRD84GILsHRZ+b9TWEVUfhepgjrDHrP8OA4oBwOJ3Tj
	 faQ4Ubh4lXj3guMCFSRGwNVY9q4GeGoghqcJVYY8wUxg4bSfIQdlPbE7JnnQJ/6kdB
	 KHt034d0PVhAyJESrZVUTLlnbaVgVFH1j8Oy5QsLwYaqobWGtTS78ws9V2pT0NtqxM
	 eDIEsmF3OFGTj69U/+8WoTLzDC+OJ6IBF0vW0zTYhGrq6B0+3WHrXi+MQSMwRqLcYZ
	 srFlTEaJxHNXvMj9xT5Sy3dR8TQkbxswJyCXK4zbf+FUNW4QJfwHwhIrbc1aiLDCm/
	 t3oFOs/HGTLQQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1194117E3789;
	Wed, 11 Jun 2025 11:40:23 +0200 (CEST)
Message-ID: <2f03fe56-f471-43be-8774-1db92d376861@collabora.com>
Date: Wed, 11 Jun 2025 11:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 04/13] dt-bindings: interconnect: add mt7988-cci
 compatible
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
 <20250608211452.72920-5-linux@fw-web.de>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-5-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible for Mediatek MT7988 SoC with mediatek,mt8183-cci fallback
> which is taken by driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



