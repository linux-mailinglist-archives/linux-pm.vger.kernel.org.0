Return-Path: <linux-pm+bounces-37822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE111C52183
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 12:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 912394F49A5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B5314B84;
	Wed, 12 Nov 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RAs1YDMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D93148B9;
	Wed, 12 Nov 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947880; cv=none; b=r9EDhj96TCSP/Sus0NTTp4+zsFQ80dE0Uhgfof/8HuATv7gclVg+86+wI2jKSliccjnvpIzcn+GRhNVmh56k64FLC1GHAY58sHI1ehZ8tGeDltM8wZduHgpLXSRTI5rr0BWIsYLDGmHX/DghpToS7mGUxqCIubFKqYsgj/KvsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947880; c=relaxed/simple;
	bh=Y1y1gZcX2EdkMSO5z5aSqFFh2Gh4L2+1EXVlaMbLXhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7ryZMxx6lwjzOUT5Tciv8B56wSZc99CMc66AotLgFiHLmrhOck2lGzhMzRcq077qtda6407HIDEezSKs17CRNtKfN4x4i9YLnRc2XZIBURNZlDr+ft+z6OaOpOODJ8FCnlnB9K3X4bE/flDy6sP3MRSg5omLdAqqa0xiGuio5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RAs1YDMX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762947876;
	bh=Y1y1gZcX2EdkMSO5z5aSqFFh2Gh4L2+1EXVlaMbLXhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RAs1YDMXMNt80xS3E02vZIiii8sjfUtiJnXJK6osttgASryJHCQNv5mWatuzuZxp/
	 ynpBg7szyrveT1X+/16t8rXUzRNPyBFaVFi4JvN+MJV7PW2lImVMjtZMiTkzsF8S9N
	 C+L8O95LyVHSr6lgGMVq1TWkC6M14ZNPvZ1fngMEpfGqpFwAsz+lF7aOYSKkx5Sb5J
	 6ichLHkn9000ei4sAyIW0oakJB/yW93W/oOllI929I/JRgmrdix+USZ/GIH1jvmNQI
	 swpcjLhMO0CEck0O31B2oczfbbwCZfpan3nYTSfFAKKkH7fyemFtnOx5n/ufRWM40C
	 NMvFR4vzPCvzA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A989A17E13DC;
	Wed, 12 Nov 2025 12:44:35 +0100 (CET)
Message-ID: <c08e6e56-5b6b-436e-bc78-c2112ba46bfc@collabora.com>
Date: Wed, 12 Nov 2025 12:44:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] cpufreq: dt-platdev: Simplify with
 of_machine_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
 <20251112-b4-of-match-matchine-data-v2-2-d46b72003fd6@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-2-d46b72003fd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/11/25 11:28, Krzysztof Kozlowski ha scritto:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with two new helpers: of_machine_get_match_data() and
> of_machine_device_match().
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


