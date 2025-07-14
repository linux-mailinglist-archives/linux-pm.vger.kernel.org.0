Return-Path: <linux-pm+bounces-30807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6301B04205
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4950177BA0
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E6257AF2;
	Mon, 14 Jul 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fjzlb4el"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F125743E;
	Mon, 14 Jul 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504153; cv=none; b=rDiIi/JQnSfI+NO3JDD39PimXydmDTZiHJjMLys86x+xLSssUtWDWzlH5Rp0DR45UBclPYWPx5CzAVozyWLolPKD3RM98yND+5mrgZAlqFoVNRICaJpOaDkqQNhTXyRksbWvRJN3pVPl41ulzyiuF9n4P8+dGkuMCYlUOZwVGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504153; c=relaxed/simple;
	bh=0VtL9HUqlMsmAiP98DqIfNZWGaoaVpSGJEtLSMSugIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pa0ZnopG1nzDvtkrO4SATQYo4H+fy1DDkHkgFnnT++8t2ND5Ww0ga3CBgJRuN4p7uaj7lCfU0zTcGzOY4ZqCbQSQ4g8hq8iYr/1Z5mKG6GnbHd0jMzHD2akibr3kWtPbT5o9TCoxkLejKthDeDUPTKwX6LhBeZJWaNhX3X+3Iu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fjzlb4el; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752504149;
	bh=0VtL9HUqlMsmAiP98DqIfNZWGaoaVpSGJEtLSMSugIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fjzlb4elvs2yCknABpwicAp1UwFsAHWBn4kyGKDkYGP0aHfqQaTVHEKxfPSoU+C8y
	 zx2vwvZdO/9XqCQzslZNRPRh8oVVsqAUxMQqBUnFNTJWMxqjwvATzL4qYDaJfttJs+
	 W14E22TEDoUvuwPR6RDXeXJQJFo+WxpLaykCiOuQUMqnErgKE5XaszRAJlGalO2Wsf
	 +iJ5kNYFZMcs6jX+NRhB9GOm7hULVk+oc1uptlnNK7tRqSfSyoo/azsgKLMeehuitC
	 TjpyKq305/Bug52wMKhQeM+nTOMO2EqBm6D1GTlNpzKHhZBShLirMUcayx4gdbQGaO
	 WH7pc7Ba2DPnA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 98F1C17E01CC;
	Mon, 14 Jul 2025 16:42:28 +0200 (CEST)
Message-ID: <47a6b9ac-a23b-4861-a3ba-f292acf1e79f@collabora.com>
Date: Mon, 14 Jul 2025 16:42:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek-hw: Separate per-domain and
 per-instance data
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
 <20250714-mt8196-cpufreq-v2-3-cc85e78855c7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250714-mt8196-cpufreq-v2-3-cc85e78855c7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/07/25 16:08, Nicolas Frattaroli ha scritto:
> As it stood, the mediatek cpufreq driver could get away with never
> really having a private driver instance struct. This is because all data
> was stored in the per-domain structs.
> 
> However, this complicates matters when actual per-instance data like the
> variant struct is introduced. Instead of having a pointer to it for
> every domain, have a pointer to a global "priv" struct that can be
> extended over time, and rename the "data" struct to "domain" to
> distinguish its purpose better.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



