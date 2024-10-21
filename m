Return-Path: <linux-pm+bounces-16101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590C79A6A11
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876951C228E4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013051F8931;
	Mon, 21 Oct 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oMhaaCvG"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CA1F7091;
	Mon, 21 Oct 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517098; cv=none; b=XWLLJdezR3yBt0/ni9PYEvpTWRFazM5MBA8KDqGh9tQ/uZ0CQgihNyaXK8AomLPhFeweklNimKmTdP7KwE7P/ZEUWhjedIJzfep/W9Jw3bR8MdoWZIDGMM73V/yEHk6r83gHvZFO6lSFAkSG4kbVfpXd2q/Zl173dl2XcxEa3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517098; c=relaxed/simple;
	bh=a6no6SukAF7TPDcSQa66DG7acqCpfgzjuCnc6eY9CEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRWe/j7EcuewULiHM2xjp/PstlLxj33TkLifhyDESRYFOsqVRLK+u9RO4jD/u2nwVwa+1SOr3gkU20Cp73aT4TrUW8ytwGkcsQ77RfJKkoTM081Z9sBoDBhBcKSybyxX31xiEyZy5PII591AvFvVj04XwAlRbbX7X0MxfpfcwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oMhaaCvG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729517095;
	bh=a6no6SukAF7TPDcSQa66DG7acqCpfgzjuCnc6eY9CEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oMhaaCvGRrKoWi7djsxzsCNS6HW+aiFMVwECybnqkd0MRSiLwvj63HVjiScOXdbAb
	 vQZls2RK0wJvk7za/Z5xZcm7x2qT1bk2Ke+81YmNchjyobN0q+UsfJi3p/BolV7z8y
	 hKAPUG9f2KT+iJLKObjiT96SdgO7GfWsPQC9sCwyWFYqyHPwixhVeldh2uL2FT8SZL
	 iDhyrNt4Gu5x4JoFOO7NXqJGV7sFlmMStV329M7fx9XsBKUe8/+cuHUsFidjYCxVfl
	 JKL0w6mX69kf6rweyWirzWHmlVQS92oVNhsjoGxx2bue3F/wXLJNBDCik/i1UvyXYk
	 qX9BU0UlS7lnQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1DF9017E361A;
	Mon, 21 Oct 2024 15:24:54 +0200 (CEST)
Message-ID: <9fbe6e8e-623a-4c8c-b6ea-c3aea8a5a56d@collabora.com>
Date: Mon, 21 Oct 2024 15:24:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mfd: mt6397: Add initial support for MT6328
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-5-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018081050.23592-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 10:10, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The MT6328 PMIC is commonly used with the MT6735 SoC. Add initial
> support for this PMIC.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

You're sending this from another email... and you have to add or change the signoff
to the other email....

...but yeah I know it's still you, so I'm confident to tell you that in your
correctly signed off v2 you can add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

