Return-Path: <linux-pm+bounces-23278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E2A4BDBC
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E8A3B4F7C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDED1F4635;
	Mon,  3 Mar 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SQSdbgHf"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243A1F4616;
	Mon,  3 Mar 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000026; cv=none; b=dt2hkvkrRXwMlt9zcKLL/03+oKwmBaOL+Glqmx1kHDo2LtTnJYtKbxEXG4BJ3leBHabD9NbRhkLgwAn+QVzDY/13fVS7fEXQqi1OLoLeOWoJ/DU3HwN3yLs71CjNS4NA56/M8+0DWN2DZlZNBkh/3G43qzkG14lyATcm+C2uQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000026; c=relaxed/simple;
	bh=G4hUql/r+AOpKgzvOwOid63ZNjiK3cqKnq3PjI+Um0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvXiYAG+8xgEvj6NNaR6Chx0YFvBEcPKVJiog9xd69n+neKO6rd9UTevANSx6gJ+lOkgLNw8q9abJqkT8VdBgrfpKK97Q5AVZBZwn1RjUcbIoKhwV4/LLv6++lbTRm1tevQRKlH56tgaF3ABOK/jJ72MJLmMEQScDTWyVCENPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SQSdbgHf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000023;
	bh=G4hUql/r+AOpKgzvOwOid63ZNjiK3cqKnq3PjI+Um0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SQSdbgHf01wJIx6zi4vp7QuOMMVrlLciGvtFzuZKOTM2dVinlHfqCp3tU7RSAl9KU
	 6vSUJ7fyPHcCPdiVcyi+A2eV79xnjuufeGn73YzkRkA+QtN3zSbfgrekNqmTFV/zaM
	 ZPaXp+hpz96Dq4bD/Ejfu7mFmj8FGUKhgBGB53g77BUs7QHTqfQWCpUpuFq1cOyKCq
	 2hm8Pl8gJBpuuBAY5R58WsmbWJqUlSEJgyZFTKDu0VwbNj+Ot/rl1jdKnzv7IK/buH
	 QEHqkY1x/6PDlF5EmnJ7v78gzo2S1blvrBFyE9Xikup3bJVMy2pYgfxRj2uTDY0JKw
	 qtLZ0XG4yiAHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 14FD617E068F;
	Mon,  3 Mar 2025 12:07:01 +0100 (CET)
Message-ID: <dac1dae7-55eb-45a5-903f-afb71320361b@collabora.com>
Date: Mon, 3 Mar 2025 12:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] ASoC: mediatek: mt6359-accdet: Make PWM debounce
 settings internal
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-13-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-13-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> Instead of reading a bunch of PWM debounce settings from the Devicetree,
> set reasonable values inside the driver that are known to work across
> multiple boards. There are no current users of these DT properties, so
> no backward compatibility needs to be maintained. The properties can be
> properly introduced in the binding in the future if different boards
> really need to override them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



