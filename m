Return-Path: <linux-pm+bounces-23276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F34A4BD79
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C61893848
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB01F416F;
	Mon,  3 Mar 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Oa72sakP"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20D1F3BB2;
	Mon,  3 Mar 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000021; cv=none; b=iYzNrNI85YeHp4eMYclL7MwA0Ognw0izjVYlkh5ok12F9JFmzSLfihkKP7crecBbRkZ9MRkg4jiJX83yLND3f/iL+DnVn8o7xEvFhs8Eq+mWwa2RIb7PGKHSgGB0jpgeJ5bEhRHcHdVkLCCfbLy3TCc2P/qnD2UWwgy2G2ho0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000021; c=relaxed/simple;
	bh=b3+Xdqb81IiwLAoh7b8p9zmgG4Hhtw3o80AXe+lcmaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0ajQ49HucuctWmv7h+hsoBeWjLeqYbIgq4XnMAN2WP8LBnldFMvp8z1OXtXcBusLlcxtf+Igs5X/PiCe9/gOgY6aQ/BG+XXnF+6u+JIqUsqShebdfOrsMAb5EPCkbaRmgxlyDbuvJE1jVGMfB72G4lliXaMCXHsaQWLizvOkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oa72sakP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000018;
	bh=b3+Xdqb81IiwLAoh7b8p9zmgG4Hhtw3o80AXe+lcmaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oa72sakPA+mY6MuNMvym/Ulzf+1mMz2H2MhjVi4CmH7uXN8cEhwtxBa6zF8cEKwwu
	 L04nLgulUTfSEmz9eQc8BAz95oJUYoD83IJq901oUwch4eRe+gVKtPb2/F0DMPaCtN
	 Porxm168SjeUtFnJDHn1OP1+G/r4lj8/D9iw8cwL76A2Ov5UEGrMlaV8JYvZFosigE
	 r0v252gRC7hhqm+pFQjJM8ZbAnNxKsaafwsIQfhE+2m0Ykucry/ZU0CWSkRzekk1CV
	 DptyICCuMskSCb4/o2YH8oYlOusbWsnC9IsX5hCAoH2SL0GiTK3Tn/KmoiMlXPvqHZ
	 APcWLj3q5oq1g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A549617E0E91;
	Mon,  3 Mar 2025 12:06:56 +0100 (CET)
Message-ID: <d9b64bb7-d4b1-4817-8d14-14ebabf40e88@collabora.com>
Date: Mon, 3 Mar 2025 12:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] ASoC: mediatek: mt6359-accdet: Always set
 micbias1 to 2.8V
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
 <20250302-mt6359-accdet-dts-v2-15-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-15-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> The driver currently reads a mediatek,mic-vol property from DT to
> determine the micbias1 setting to configure in hardware. Since there are
> no current users of the property and the default value (2.8V) is known
> to work on multiple boards, remove the code handling this property and
> instead always configure the micbias1 to 2.8V. The property can be
> properly introduced in the binding in the future if it really turns out
> that different boards need different configurations.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



