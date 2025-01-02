Return-Path: <linux-pm+bounces-19885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D399FF7F8
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D433A2EE8
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F51AE01B;
	Thu,  2 Jan 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pH8zx77y"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021A1AC887;
	Thu,  2 Jan 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813571; cv=none; b=Z9/J7eDipvcDDNPMaIB8n1cDKEFa8mKJGOKPjFsLgwu4hyJ6ddE4Zf+3LRMkx3lIjuAZq3+X4/KFOAx7uUgLqU2tkc569tlMpMz99U64TFPGx913vbvPVxaNTJTob24j44i5hMg0v1W5ODQ5wImcyAij9POkyZ10Iw43EMdDvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813571; c=relaxed/simple;
	bh=Czb6aXX2yCzHoge+VlRIHz2pmWSjuJOZlfjlLJLxNQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZouRRf1R3N/tNYOp4Zd3yj4NyTmBvubJ+5FIcCjMXZQ9RTi3m8AuRVdROL7AeZml/O4mT7/H1QoDOy9nczG0R1QbvWTmpOeHZNaLdjJ1PUk1qeS1P9Ar+PZGNN/7GdXhGXzk6QKRZ3K9nxZEf1eLBjMsy1mwMhcL3jmdapOCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pH8zx77y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813568;
	bh=Czb6aXX2yCzHoge+VlRIHz2pmWSjuJOZlfjlLJLxNQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pH8zx77y7dr7sqBwC2P2G0A5wY6tGua8hIQDYA6lkbVtRRYlv4LHj6fX0r8Qa/FDa
	 CGcNZcGAX4NtkNu1Wo8SmFAnnHKjMQD6SkPPAtBSAw4zNC0jxXGG5F4zoBvC0t31aN
	 DJIyjjNVGyy3HdH0zvH9lDykHYbBTdv5H2cRE5vzLXEtS6BQb9zZiG6hwN8EBegbK+
	 4aU2Jbo8dNq85M0o9TmkDhb03cUqwQg/8BkfnCZprSt8aC1whOMACbweuMhy3l0EVt
	 mF7elsE0aNzTwN4sN2YcQeO2Cu/4TXjZDBrL3FyNQDkjl9WJSr33n6HZx0s9QBW8EV
	 LB6XIwYI4FJvg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3463F17E1558;
	Thu,  2 Jan 2025 11:26:07 +0100 (CET)
Message-ID: <49874ffe-61b2-4532-b3ce-e5d9e408fdd5@collabora.com>
Date: Thu, 2 Jan 2025 11:26:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>, Rob Herring <robh@kernel.org>,
 Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
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
 <20241226050205.30241-2-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-2-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


