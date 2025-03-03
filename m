Return-Path: <linux-pm+bounces-23284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA7A4BD94
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B97188DCCA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E31F7069;
	Mon,  3 Mar 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UqrBbBBo"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE831F585B;
	Mon,  3 Mar 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000052; cv=none; b=F0IQu5WlihaPTZueXpEx4KuE68pUMH2H/a1HFXuXistoXqF8vZvOzCHqVFp54M8aRlwLcnKGCeEnt29ps91xBpj6fKL0lKQkCnpICaZrRvNghqlFXLk2TEuRMfpYooKx6krh6sgkIxGhqRHJ5+Rv7jL7QFZ73dbxluq7TpyNUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000052; c=relaxed/simple;
	bh=vFfigEl9JtFE8tbSRW6zvkOLxEZfMTm7xZiNuaYSepk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me8miSOpNwTcIT+OmZmFjIsi/0UNn9FeB9RT+bR1+EAUccWnAzKy8Z+BRU8adY8FqHdDCueVkyO0RT3oWGRhFSfm+NdC0zRFHcEMWC4Wl7QqIoOP7hM9z1YSELpVtLjmNXlLlBIbqrlZoBpsgsdXqGwsWkPx7o8p59aLbBO3+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UqrBbBBo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000049;
	bh=vFfigEl9JtFE8tbSRW6zvkOLxEZfMTm7xZiNuaYSepk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UqrBbBBoRzhmFeT7N9CYWxuGC7e0mvHYcx4+KjVzEwmoaZYsp8OVRZoFxcIaUBOPD
	 OrQZTJuPbzuXayGOVKSoLxCSPKYP0zpC12bTZtL4Zz8vsCP1Bm0pUfNnxDqfWudaX3
	 7K40ONJS8mBsPTvRp2QAaHZv+TImuv6sq6FkO6/MexVeQ2S/COe8+OS5LlpRhgBATy
	 ibOfWr33zSuMvXPg4WYcMcF2mQWAkXiex4wczG3beVqw+MNXO5PTjItmHNhVzTwJRs
	 3lElGWMTpCvIpOxFWmmwV3BQuLthKSxqVxwPc0gZHekTAYP2D3gLmogRtr8Cb1Ct/2
	 T29tloQ5HAcQg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC24717E068F;
	Mon,  3 Mar 2025 12:07:27 +0100 (CET)
Message-ID: <40c421e1-efc4-492a-9e48-077a95509a18@collabora.com>
Date: Mon, 3 Mar 2025 12:07:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/20] ASoC: mediatek: mt6359-accdet: Drop dead code
 for EINT trigger setting
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
 <20250302-mt6359-accdet-dts-v2-8-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-8-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> None of the EINT trigger options are implemented and the DT property is
> not described in the binding. Remove the unused code.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


