Return-Path: <linux-pm+bounces-17329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32D9C40DD
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63BF1F22BCF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F631A00D1;
	Mon, 11 Nov 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbqA4CXw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720115A85A;
	Mon, 11 Nov 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335260; cv=none; b=SqEIT18XpIXjG8qj7CBSGnliq569DC9sPWL3+WTF7K5H1zOJEtRxuPhZVpnFXFtpLKWGLIbmDXBVvZivCyAQ/mjUKM8NQVvNd/wDS+1F/POYTNm4GmkFV7jHCmxVmcDm8Txoh5xK6z2y/w4ic6eRVWKA/xEkBMsPGfuZ20hsRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335260; c=relaxed/simple;
	bh=0HBp91eFMMg3rKBeBDysVTX9mLxQIHz9phYBimdndCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gH1DexspTWD5QXeNS80pGiITm/KnxOapgBRm+tHi90V+kAqYdI2Q4bS9pyJHI5IkGUbQUEyUY8/SHvtAXeVdSi4DueU2qyaBhkEL0rM4tOdQXsO7FIgQ83/EHF6a6eqdXLAMOZKi/hfzM710k/DJYyih9VPGgye3N+d/cz/B1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbqA4CXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70BCC4CECF;
	Mon, 11 Nov 2024 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731335259;
	bh=0HBp91eFMMg3rKBeBDysVTX9mLxQIHz9phYBimdndCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sbqA4CXwcNwBw8gvLUFLeNBaL48iTGzehpPg5Yhv0GwvduUO+nKVZahYoI2wdEQwi
	 4BNpw+B4xRdHlzD8ZyUoZWhF5lpd4KL6Favdt3REZqqZPEs1OiVJEOyZi0zSAtx6Cs
	 x98lCeuqTAtNNPvzPEejZyU7/45eOlFzcPYAGfmBltgfjVMo53DDBzpnarihw20/GQ
	 Qx//WwmaP/HOa/mfOyQ8KAIi4S8s4d9/0eHgLGOyZngJWGH7ScMg5NMrS3NVTOY8kK
	 r1Q0pjJW9N/UYlHS5ULw6XjL59ERlJ3eskvHZN2pzq/AD9x/6G5ScRAspOKKfeKuFJ
	 I1AzT8XdOb8vg==
Message-ID: <0c2f2274-4487-4d7e-a558-cb9608f59118@kernel.org>
Date: Mon, 11 Nov 2024 16:27:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Paul Cercueil
 <paul@crapouillou.net>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Tony Lindgren <tony@atomide.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-tegra@vger.kernel.org
References: <1a44c5fc95616d64157d2f4a55f460476d382554.1730987047.git.ukleinek@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1a44c5fc95616d64157d2f4a55f460476d382554.1730987047.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/11/2024 16:57, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/memory to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> A few white space changes are included to make indention consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

for drivers/memory/omap-gpmc.c 

Reviewed-by: Roger Quadros <rogerq@kernel.org>

