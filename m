Return-Path: <linux-pm+bounces-19893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C54459FF843
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDA81883038
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3061AF0D6;
	Thu,  2 Jan 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FbicFpRb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AA1A8415;
	Thu,  2 Jan 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814075; cv=none; b=Vb7RYxkivfhW3OaN8u4uRwYR+Xi8kyQ6GOLACVR5PGkrJ6t9aORAGHaUgWgezU0bGzJXrYkpvJH9yQwvyM+rgB+HHeKpEXw8rFuqIyhZC5hJPD9znqh92VZj9FFxNpsyvekZEDlIcu2b0mV5n+Ofjk42AoL0dxVT2ofxLfQ9WJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814075; c=relaxed/simple;
	bh=0tYrz61oD1++DkdZhfVjk2QczHG0iMWOdbWTNRwVrHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqtrPqZMQtziyEskn3k9PfHUnSb9lQeH3dYxub5MdXSc6wAAs4PjHZRH9keWIdp0TGOSfIkiLX/ZJ2o+0lYmQDdzd7S1WFPXzNizoOYdqTVF2VqbIPENFjGv//NUIwzVxAXlyOcpCFtRHBFmgamtjtU34pQu524bxGkAQOH9WSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FbicFpRb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735813563;
	bh=0tYrz61oD1++DkdZhfVjk2QczHG0iMWOdbWTNRwVrHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FbicFpRbKW3WZvBLtVT/loRE+7JT+98Wcrb6L0RBrJljDdNB+LFi6qxcqVw3erYFq
	 j+aHc9ezA/YqxC+pDt8S5cM4oUx/rsKflPEq9G4TkbUWyCuwfLqGZr/V7a62S79QX4
	 6MluNSu5Kviv9NLCVq7yU10UKokRYD4LscEjbCtVmEkJ4nyNlXDyfiGjFBzbOvnutY
	 jv+lS8NNuQkchkCD0xPcM4yZQJ82Ja8FP/+7WEgm3YBfwAOkcF5DQXlgEkuHryrosz
	 bwXo1YC7i5Ohve/0LvlrFlEpWhFqst9q5Yy4XuwCZc9zyYmNjKyW8WZvUAlI4gzTBX
	 qAbpo1ahXh+hA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C872717E1552;
	Thu,  2 Jan 2025 11:26:01 +0100 (CET)
Message-ID: <9a3a8ec5-a0fa-4e27-a5dc-b1c041686dd8@collabora.com>
Date: Thu, 2 Jan 2025 11:26:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] mfd: mt6397: Add support for MT6392 pmic
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
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
 <20241226050205.30241-5-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241226050205.30241-5-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/12/24 05:58, Val Packett ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Update the MT6397 MFD driver to support the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


