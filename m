Return-Path: <linux-pm+bounces-37823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9482C52105
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143D1188532E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA5315D2D;
	Wed, 12 Nov 2025 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cK21f6Gt"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE60313E24;
	Wed, 12 Nov 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947896; cv=none; b=Eru+RW9Jb9kcGLXjQJd9ZfeCEXnoaYAkGaF/kiRhSkRNNr158KgPiWKI8v1KFRNplwH5vpMuZKabBqmd41aHztc4i1fRKSbY04T31LPnLnO0937iGOVrAKiZ5RCtp71Y7uuqwrcH+IsOgOEcN8qR5HA5njW8e5Tlt1ga+mLTWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947896; c=relaxed/simple;
	bh=txQYXefWwC2PZqEQ4vuwFQ5aaHRR6QGqriUDT6flUq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hu48YhNPe/8hS3HD+Y9BVLbLx4uj6QZgbY1xBEygkAvNBQijkYHlEJ/3H9dDSNjdd40T3+GYNTwgsFkFPTClvDcbResqrNwzc2owrqwzzyqSYZeA/7xOoB7tu7D2RTF1lQYPcA6JqSNKLa9BRPzoYeOPNqNIsQo4leRObSDRTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cK21f6Gt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762947893;
	bh=txQYXefWwC2PZqEQ4vuwFQ5aaHRR6QGqriUDT6flUq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cK21f6Gt4ebuuEMkr8T4xExWaiZikMRwdU3xD+guk8+7Gm5W1VgzofKs7cog+vdRx
	 o9LtWn3ArAHcp0G74dAZOwCtgDJIc07BZFnETnImHBG2CVWiI4whIFgYBG1I28Q2Xe
	 dwCJxnHLYerOzf2j9uwg3t1wi63zGW3fMwtEM6/4zifIuViwq7kQ9WbLnkUyXq9Ocf
	 zRyNsEq4KYlUDBo4smccBlW6+d8U3oVHeU5U/jEHxoLjGpG3J6GQg8U0idnseanwfM
	 rulu1XG6f/eYKL+2rVYk7U13TP39NzkX5q6/+5A/tUJlTGEFsUKZc/57XqqKMxmJAO
	 xM6CEeQYaXfFA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDED017E129C;
	Wed, 12 Nov 2025 12:44:51 +0100 (CET)
Message-ID: <e6d208a2-b4a3-4c9e-abe2-1da1e5ae1245@collabora.com>
Date: Wed, 12 Nov 2025 12:44:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] firmware: qcom: scm: Simplify with
 of_machine_device_match()
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
 linux-tegra@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
 <20251112-b4-of-match-matchine-data-v2-6-d46b72003fd6@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-6-d46b72003fd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/11/25 11:28, Krzysztof Kozlowski ha scritto:
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


