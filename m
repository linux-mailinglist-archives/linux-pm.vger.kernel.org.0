Return-Path: <linux-pm+bounces-17557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B49C8856
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 12:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C1B2F084
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBB11F81A4;
	Thu, 14 Nov 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BS56wmC8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779481D9A41;
	Thu, 14 Nov 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579770; cv=none; b=REqOaNi8WsfM9U6SajmwtJb4H/HgODlCNSx1KosBQXkhFt2CyQjRBSUjyTwcuQxeSI0o3sLOxkMp/YD6MGNXNFfuhz9kzB3dPVJEspCanbu2rO8kA/ZU+wSFP2OeKQVyih8xs0gcy/eE/brta0y1XrX9+gevwJR0SPk+/xsgSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579770; c=relaxed/simple;
	bh=N0Zs06FQ5Xtv3SHbCA4mOGMqJ8tnWHRBdA2cSQ+32Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJaoHyx7ki6zz02bPmQ3F7z5ch4Poob8lTf28Ildq92oGRi1W1+pbWkKw31wEgxc2U8GVb8pMDkJpUFALYshLOnGopSsnGvsp0zDp+936nd3wnS808gBU4NohL3+yj7EvpjDE6pJ363x8HltBBdLeKNiXj1mLRaiI6oNkuKsBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BS56wmC8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731579766;
	bh=N0Zs06FQ5Xtv3SHbCA4mOGMqJ8tnWHRBdA2cSQ+32Nk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BS56wmC8dD7ZOfnypazCktbot14vilOAIeneaG4ZyzWr8JY5UbLY16X5RL4jskCm5
	 I0dOZNQfcpaWMdiaft42eej+JtjZhga4BY+ss563+AkGfe081OWzH8vHnpanKdEc1E
	 uU0UbM1jokCZf8z8uWVIjpNQlvOIIv/OHLaXg6WSobK04nOrAeZIQQVRhQQ26YdWWy
	 TL/YD2iHuEzY/bEMbN6MMTdGGBsu47DUSHaZHgrF1uv58IFgK5j4DYge2cgP46Qnfv
	 HsSOmcjyrzOuImoVNZ4CU3SV6oU+MBQVfjL6iLLm6NP7Lz/xqs8X9awWH/WWgh6tgG
	 +qdRy0lMeLfRA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 34DE117E14EF;
	Thu, 14 Nov 2024 11:22:46 +0100 (CET)
Message-ID: <9f9a969f-6ce5-4e6c-89bd-51fe121db693@collabora.com>
Date: Thu, 14 Nov 2024 11:22:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] cpufreq: mediatek: CCI support SoC , the
 transition_delay set to 10 ms
To: Mark Tseng <chun-jen.tseng@mediatek.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241108063942.19744-1-chun-jen.tseng@mediatek.com>
 <20241108063942.19744-2-chun-jen.tseng@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241108063942.19744-2-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/11/24 07:39, Mark Tseng ha scritto:
> SoC with CCI architecture should set transition_delay to 10 ms because
> cpufreq need to call devfreq notifier in async mode. if delay less than
> 10 ms, it may get wrong OPP-level in devfreq passive governor.
> 

This means that MediaTek SoCs can change their CPU frequency once every
10 milliseconds?!?!?!

I don't think that's really the case.

Besides, are you aware that this will have a *huge* impact on either power
consumption or performance?
We're going from a bunch of microseconds to *multiple* milliseconds here.

Regards,
Angelo


