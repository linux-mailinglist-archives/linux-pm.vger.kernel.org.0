Return-Path: <linux-pm+bounces-30805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5DEB041D5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F7F4A1B55
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F592571B3;
	Mon, 14 Jul 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q1ZcdiF3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BD246BB6;
	Mon, 14 Jul 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503807; cv=none; b=gz7aU9Bezfw3SLAgPyjbtwqSqJLfuCTRMYEgbhJpacVgb/kCn568UvqKi75ehbELwtNekm+JLkTOyukUdLYI/PRzrhPb2c8sGKh2/smv+Ux5Qn8/krR9K5q69+k7g1hE4Pj33e4pXvUGwVPPbPPM3/XK1MIAa6YI53dCBaSCvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503807; c=relaxed/simple;
	bh=CPBGw37uUOIUouSs+t086VvCKYv3aNz8eMWmHpwWGCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCD6OBog6CvefAizU+8ALeD6X6fdG2OMHUyYGYg5CK0Nyhq54m5PU8IbkWtqIzMFOqtnxaXWzQGlOmvqJ9ACYu+/Krr5bGVD0r4UyWyw0AGeDzm8l3vqsxu7jtDyBfJgzBMZ2ataBwEiC9uOwe6P+jYeVkkM0zO8DCiTPIzYjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q1ZcdiF3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752503804;
	bh=CPBGw37uUOIUouSs+t086VvCKYv3aNz8eMWmHpwWGCE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q1ZcdiF3ICiO4lfEo4vQzyUuiXCt1ZovW/3HrQ7qK35sWxvUtQ16xdekPWyv8zKAZ
	 7dM95beiMCFrkGbvVgBVXjMzQ2HjA8SrJdtYaGmdTJcAktXf6VBvGhn8vETWtXZ2Vs
	 6pZnqswVY7gteMDfXbpAcu302Qfq3WU2nbRh40CNxHmPO5sQsT0ITffJiTXOyRi33h
	 oixshOEdPM/fPinBefJY6YLKeiR4RARYN5vRSoAKOCfAyKtO+aBdpO0gLdrdfSCcCE
	 dqj+qhvzEMke/fFRrTBVkMkH4iNWfVBji+BY0rBRGGXUi/HpmDPXwk1B6T15ybKyrv
	 p7XxnXYdqGnRQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A6A8317E1008;
	Mon, 14 Jul 2025 16:36:43 +0200 (CEST)
Message-ID: <fb53a3e9-8673-4001-9a58-927bf01d6edd@collabora.com>
Date: Mon, 14 Jul 2025 16:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cpufreq: mediatek-hw: Refactor match data into
 struct
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
 <20250714-mt8196-cpufreq-v2-2-cc85e78855c7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250714-mt8196-cpufreq-v2-2-cc85e78855c7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/07/25 16:08, Nicolas Frattaroli ha scritto:
> While the driver could get away with having the per-compatible match
> data just be an array of the reg offsets, the only thing it used it for
> right now, this doesn't really allow it to be extended in any meaningful
> way if some other per-variant information needs to be communicated.
> 
> Refactor the code to make the DT match data a struct, which currently
> only contains a single member: the reg offsets. This will allow this
> struct to be extended with other members for other hardware variants.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

You could explicitly state, in the commit description, something like:
"In preparation to add support for new Hybrid "FDVFS" CPUFreq for MT8196,
refactor the code to make the DT match data...."

Regardless of that:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


