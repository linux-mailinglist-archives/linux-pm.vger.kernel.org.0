Return-Path: <linux-pm+bounces-35202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB7B952ED
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611883A4874
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A4320A09;
	Tue, 23 Sep 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T04R9PGN"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDF3128D1;
	Tue, 23 Sep 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618787; cv=none; b=VvRrHal6pb1BXLifdsgzyiZVbgWy4e6VH0YQuiXvpILzDkIICZ2mg0TpmcaBb1U3ZswhJ3Ynt/Qo9xm6wWj8D8BlSzVav8UIeqTAjODabO+4XD77WQvuMmpzNcNyu4aZjW8Ri4q5C7uNNo+IdeFWxU2x9OpxGpzzCnSiCBw//dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618787; c=relaxed/simple;
	bh=IjPHyUs+/qi+cj9v3JJ8bxTkTPkvKjgFnFOqLC1M2G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdeR0rYmAOthZfVrN4hLxbw207SD9hNtdeT6J/PtlwJlbKsxpF4hoPwz21lDcLOSgNNTOYAN/ZjuRntX0Bc1E842VN89v4vHxThXLSxV5ERaK5vVwgyoD712kIPBvorZnKiOl08HJE+GhPAPVY/znuN52OEDXHsZ39jzmbYMqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T04R9PGN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758618783;
	bh=IjPHyUs+/qi+cj9v3JJ8bxTkTPkvKjgFnFOqLC1M2G8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T04R9PGNcMlBc0OEdNVti89foPGVnPMcEqdCz/ASgtoNlOFI9lad76nZQs20wR7JT
	 bnWWKDXH28heCcgtMlQnJoSLqOt0rm44VcEcTmDOmBMTlyVagTyRDP50xTnwsZoici
	 nKanuWPCJOOdSTWtLELjOd/BEXg5VjSpzKx8dF8aTH94iBeDtDevjMCRfniUSJpytk
	 qS7t0ljvRTXje4BxL+OjQsxMYZniz/zAeo0Tpo5BbIsOxDuG5HqFpz8fzn3NwzyUg6
	 yzZFfG+6sFH5HzazGB58eozCBVVxmlwE2sHB75aktXaXFnWS0cdShJrewmkzkFIayN
	 mIXpNdwoU8Quw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 938AC17E032F;
	Tue, 23 Sep 2025 11:13:03 +0200 (CEST)
Message-ID: <7649cf04-3f0c-4d28-b7da-fc7dea5fefa0@collabora.com>
Date: Tue, 23 Sep 2025 11:13:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: set default off flag for MT8195 AUDIO
 power domain
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250923-mt8195-pmdomain-audio-fix-v1-1-782190385f46@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923-mt8195-pmdomain-audio-fix-v1-1-782190385f46@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 10:52, Louis-Alexis Eyraud ha scritto:
> In MT8195 power domain data array, set the KEEP_DEFAULT_OFF and
> ACTIVE_WAKEUP flags for the AUDIO power domain entry to avoid
> having this domain being on during boot sequence when unneeded.
> 
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Not sure if those Fixes tags are acceptable - but for the sake of backport
AUTOSEL this is correct.

For the code:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



