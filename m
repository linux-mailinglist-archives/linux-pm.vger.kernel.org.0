Return-Path: <linux-pm+bounces-30998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C185B08A7B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 12:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EF61891B73
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCB2989BF;
	Thu, 17 Jul 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i2tfqxfP"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A362046B3;
	Thu, 17 Jul 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748082; cv=none; b=AALZbl9maLSLn2hJxmltmUpCPO/cj8yOha0DEgOiV5DNkiedw5bbeEyyonlxCt9ObMXJVq/hAzJlMxiPPN6nHaBRM68+DOPvAmMQh1FB7tmmA8VOEBYpdGvF2eNlnFBUDvr9ylOUdgkKx2/ZAkjwpSz132I3OrUM5n9mS2dqiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748082; c=relaxed/simple;
	bh=kZAo/gWKz5R05BbdTMkuNvyoBn5ADeZBmyt+dfokfUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOzGMH7YR3p2FJ7hMPtf+iU59CWy3k24aBshXZO5Cg412rwbMel5PFcF1+e99rZW+5QWbf6PsbdVL+nmYzDzUStKzA6NY4wVFD0vBST2oFgg1nwSEo7xMC5wZx5BnpCQtPRvJ9BPq/tMeZdMnQ8Vgqnvf4d6oNbV2nCNj1jj244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i2tfqxfP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752748078;
	bh=kZAo/gWKz5R05BbdTMkuNvyoBn5ADeZBmyt+dfokfUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i2tfqxfPA271AfqEbRdi8hCJHi3qedj+kHeVNbbEE894k4HJEHVV/jNvgb9Toh/Bq
	 DpruPNCztV+FcO7a80k80d+WIU700AWXzuqrJ3fSLjaOAHNKFcOwjd8NAC8uZsGkl9
	 GjlBRkNolFxFaiCWo5wQyeOnEtyCIOCGisyBPmJ0T2k93xEVJFZGmqjFGIfM7WwuoH
	 Mt8ZPaUFaJpM03vPkAZyF8PaXVzeMbunxkw56TjOTKSZ+Ac59T6aJPocdHkqBfAicx
	 I92wDcy49czV8pDkQzoWZICWSFN+HTYcAmngcCjlkEnONoEOjqGqvF+Qg+aAM58/6Q
	 E2y5YF0Prdoog==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C1DB17E0D15;
	Thu, 17 Jul 2025 12:27:57 +0200 (CEST)
Message-ID: <c97f9e7c-4985-4e2f-aaaf-981960974212@collabora.com>
Date: Thu, 17 Jul 2025 12:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cpufreq: mediatek-hw: Add support for MT8196
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
 <20250716-mt8196-cpufreq-v3-4-d440fb810d7e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250716-mt8196-cpufreq-v3-4-d440fb810d7e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/07/25 19:51, Nicolas Frattaroli ha scritto:
> The MT8196 SoC uses DVFS to set a desired target frequency for each CPU
> core. It also uses slightly different register offsets.
> 
> Add support for it, which necessitates reworking how the mmio regs are
> acquired, as mt8196 has the fdvfs register before the performance domain
> registers.
> 
> I've verified with both `sysbench cpu run` and `head -c 10G \
> /dev/urandom | pigz -p 8 -c - | pv -ba > /dev/null` that we don't just
> get a higher reported clock frequency, but that the observed performance
> also increases, by a factor of 2.64 in an 8 thread sysbench test.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>


