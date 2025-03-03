Return-Path: <linux-pm+bounces-23290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F962A4BE23
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CBC16935B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6C31F585F;
	Mon,  3 Mar 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MuQbYTgV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961A1F543F;
	Mon,  3 Mar 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000418; cv=none; b=kRXScXOKA4eV3eUlNIIncNQfuEuV1y8TLqJy6ayu4orhpY81hd81zBTa7gCRlmHGSsU/oIZF3YGhekVnuKCWYuKdx9HWA4VbWy0xUKkh0QQV2ldJX9mzYXQfEc2p0L6Nn5zsXblAE7nZaBJBXDueuKK5cqi9GMu5Otnpmh1PUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000418; c=relaxed/simple;
	bh=cKliQVSyA9HiccVc5AaYvxTkqdes1M5wnZBsjWWCr68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fL+thD0k8WB0cCgZbfdXjixEgAl6Utgv4degBhHmNrLnIm/PKrjM6Gl8jH0wXQiqGq+krH2SwampCxmNqKeoAhXqVS6Z+l/cDa663QQh/PW7cBDwWMXS4C+jpUd9YNEhel2NockrdFd6NPEBTcqb8SJLC83P7IGlhQaQYBTOBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MuQbYTgV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741000414;
	bh=cKliQVSyA9HiccVc5AaYvxTkqdes1M5wnZBsjWWCr68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MuQbYTgVnLgFLb0e4IYfEAvR1BPOArpOWEbF/8jFQ/g82TOECRFoQsrFBHmnu3y9U
	 zFJLm9RRtRqReIOjxhayQ2lof7rJvUbTUuX3Bdyk8RZM+/XOf88UsiZH3ilZLQZqzj
	 nxEi/aDg5AGYDIpKebJJHKVW9pxNr9HZBQZ613cTQsxS+fg4ayNuRvNtMJoujzj+mS
	 mQRrtLFIRVJnt9nbLhtaHk+wJhWlIwuVKAlKa7p342WQU2rrZM3ztQaQ2LE/Yelgfi
	 vghOPThQ5UioJgTVMlPib5ORs3tfe22O3heQqmFdFp+062xg/VaqQ8XYtQmL76SpuR
	 oUh4ste8JvaEA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 61B8217E0881;
	Mon,  3 Mar 2025 12:13:33 +0100 (CET)
Message-ID: <32d41fc8-1855-4078-a5df-a0f3a7cbd423@collabora.com>
Date: Mon, 3 Mar 2025 12:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] mfd: mt6397-core: Add mfd_cell for mt6359-accdet
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
 linux-pm@vger.kernel.org, Andrew Perepech <andrew.perepech@mediatek.com>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-3-5bd633ee0d47@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250302-mt6359-accdet-dts-v2-3-5bd633ee0d47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/03/25 17:30, Nícolas F. R. A. Prado ha scritto:
> From: Andrew Perepech <andrew.perepech@mediatek.com>
> 
> Add an mfd_cell for mt6359-accdet and describe its IRQ resources to
> allow the mt6359-accdet driver to probe.
> 
> Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



