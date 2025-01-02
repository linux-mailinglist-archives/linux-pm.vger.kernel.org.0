Return-Path: <linux-pm+bounces-19892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F179FF842
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C75F1883091
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441151AF0DC;
	Thu,  2 Jan 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oxOW8IWA"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91F1A8408;
	Thu,  2 Jan 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814075; cv=none; b=SWM58aRiGwPBzwXrohxWsPsVo1Mx2XDjKjFmgyh9ri7w/0MDTSE7mcnbGSZ/cI9TQ6Lo4lXMk/OQ00mZyAdu3TKOJV81VMXTy7p44qGfnVOJM+kqQ9tj2vcEqATtGn6OZn9u9RwMSFlUOskVKQ8HXvxgbq4Ax6PYG0tK5zl587E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814075; c=relaxed/simple;
	bh=g3uOhxGhdR27AA2G951/fppRBjpoR1zt9a4A7UgaIhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe3oD8T3w9aXjaSMvT72XJplqVtJ70ToWkx6z1E344Z4bKjKsVjc+L3J0ljkEC+Cpkl5Brx74qg71+FD0HbNR7Bctom449Y39kFrh1W85myttjNwndx1cCUewc8D/9KMWf91gditNb4FYFYPOtIh4dMBb4Qmt8Fko82YvqHms/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oxOW8IWA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813558;
	bh=g3uOhxGhdR27AA2G951/fppRBjpoR1zt9a4A7UgaIhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxOW8IWArLK9a2Gm/2Iq4bcXJGnL6Sx8Lua9oOfy4PKcP+LMTVliPd7qTDNSfeJib
	 jLnVpTy5KhxGgRlK7MMbPnA1oDeCbX/thb8HmsSmHEpaedkPU87hx8sXb+bhs82Ui/
	 bCSkctTgqpx2xVze2/uvibzY/11obQjdMGf7Q1cHQL3s3DYiOat4N0Lr+A38S7yS3C
	 j7KS4xAVDlgqCEi+AoCOnRzjLVjKz33Uo1rC4xgl4rEvN1l8k95+9RTajNXBsX+DId
	 Mhdm3uuUhwYfVuSNYinewJ4ha+65Yt53kMUBIzRgB9AZsIpnCMfUEWkTN2FkJD5KJa
	 t9pbPoOz7XVrQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8AAFC17E154F;
	Thu,  2 Jan 2025 11:25:57 +0100 (CET)
Message-ID: <ad1a74e4-6714-480f-b516-feef8ea0f908@collabora.com>
Date: Thu, 2 Jan 2025 11:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] input: keyboard: mtk-pmic-keys: add MT6392 support
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
 <20241226050205.30241-8-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-8-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> Add support for the MT6392 PMIC to the keys driver.
> 
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



