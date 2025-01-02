Return-Path: <linux-pm+bounces-19891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1239FF834
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DB81624C5
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A61AD3E0;
	Thu,  2 Jan 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o+VSF47g"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C519F12D;
	Thu,  2 Jan 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814074; cv=none; b=GaF7T+w6GKcD60WDqXByJjIVfdBGMj8wwamwgqirqFQUS+SSTvTpD/tEI6n84IkLMUu7bSRWa/bzGZN0ko+9kdn4p/BUpc9G7l6ElN5P7UKjUdzDgr5n+DSmDuI1Dw07X7xXEXNNpCcEUZcUqG9uiy3J1zs4wMnFummGvd8tiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814074; c=relaxed/simple;
	bh=vh+43YniS6Ugh2sXp2QxZgxf26XqzpzMRNyItfYPoHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfs22d44drTfO7snp1fAaiaJPJQJjb2y4yFAh92JR3NTI56mV9wWX1HctP8/kNEVFO6XMkOKMeO3ur6eHSe9x4/EK3ybXUhR8AxfvsYRkLtWLc0cjXQpZ+iiFiQFR4KJBH28n1xCLLP6Jaa5UVIGWEqImwwwusMVME8BnOi+db4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o+VSF47g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813557;
	bh=vh+43YniS6Ugh2sXp2QxZgxf26XqzpzMRNyItfYPoHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+VSF47gC0Wqe8H1tsm3Zz2GmXFTmB4fqAcT5gPx/okxIWqo0HWezRMr0x86HfX9i
	 KcOm6MpK47mAWAruWI5OcKXsKSa6WZjY65UrK32WzChrYVewkGFgIQo1Bjza8H88qa
	 TLkPpEK2iye6eJtVvDIWBBu0xhwjgvya+b5tppKyBdj8dD1CYAlJtCBKCxDhTBKzL0
	 u3ZyMpxkFWARHpSxpMzhE41cyuumyERQDFN9URi1I6fefJGWCCViG4tggjEuFTDmgl
	 /3TmAN+1ELMxijBEPg5X67IZyaHEmYdgo/YmsHVA9rljwMA5ndbv/831qG7mYft6jF
	 Jwv1rJBemM/xA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0321717E154D;
	Thu,  2 Jan 2025 11:25:55 +0100 (CET)
Message-ID: <45b41817-554d-43af-98b7-ccc0d0e6dd5d@collabora.com>
Date: Thu, 2 Jan 2025 11:25:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] rtc: mt6397: add compatible for MT6392 PMIC
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
 <20241226050205.30241-9-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-9-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> Add a compatible, using the same data as the MT6397.
> 
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


