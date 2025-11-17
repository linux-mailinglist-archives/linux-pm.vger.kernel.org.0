Return-Path: <linux-pm+bounces-38124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA6C642B9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 185664EDCDE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A80334379;
	Mon, 17 Nov 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mUMAUTy7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AC32E13D;
	Mon, 17 Nov 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383192; cv=none; b=VqDvCucdp9ncwy4GE/Uy2U+bS8CqqlPZ2UV2BbbB4TCbKQ6Y3xzKqYVOP49awQzCgm4Zw3AiUTBQvbLuz2Fuz56zgu9XbXnIRt9ynJXNidAdYUvpH3ZzJKHFJAk8bbTz8UV49+kmDTrSPLRxFv14dWfsmQ7D6CUU+9ePvUm1jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383192; c=relaxed/simple;
	bh=Jw2sRzJoJU/CuzcziJhRnNu6CtWaCgLJpIwQLt9l66s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R26Y942rBejQnYDeq+/4mB9EWMEXpoIF1YgnW753KGYG+RYNqkBRApTJcooiIVlFELhrxOzZ4MtZ6XjFtxNvzWccjv1CrEcUuKYYdJfPA7Susb3Pzhglyq50Nq8cgt+/4K7NdhBXo+Zb38KSNj3il2IUWzWYRbgT+HC1q7jcMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mUMAUTy7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763383187;
	bh=Jw2sRzJoJU/CuzcziJhRnNu6CtWaCgLJpIwQLt9l66s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mUMAUTy7PNxVnPK272ufjc6P2C/ZiAcQF/azJRUjLl9QAQIiI73jDd7pS8u/SjerD
	 6o3iqGxrSEaskBwr/i8yLVTJ25fZlTktErORF5bIetaOWLnXRAWTSR0hsRowW0K3JW
	 mFZf3RO597TFbLvgzs9EXtqZQJEZkHusiGMgVwJAbFtWPZL/CJPPkarclyQyj8eaih
	 CxdtNncPX7f7GXCX4XDeWOjpPTka+9eI9sS+WURVkLW18EJNWHJSrFQ90q050lR14F
	 P9am3tZMqe3VQprE/X08Efb5rdmtvSnKyJl2sItlzAS9tSok69HCYDdV0hVOxO7Wwp
	 NUlo6OXHvmXUg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C17317E0B85;
	Mon, 17 Nov 2025 13:39:46 +0100 (CET)
Message-ID: <a804ec3f-ffa5-4eab-a20d-3abc204c4849@collabora.com>
Date: Mon, 17 Nov 2025 13:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] interconnect: mediatek: Aggregate bandwidth with
 saturating add
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Henry Chen <henryc.chen@mediatek.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-13-b956d4631468@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251114-mt8196-dvfsrc-v1-13-b956d4631468@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/11/25 17:54, Nicolas Frattaroli ha scritto:
> By using a regular non-overflow-checking add, the MediaTek icc-emi
> driver will happy wrap at U32_MAX + 1 to 0. As it's common for the
> interconnect core to fill in INT_MAX values, this is not a hypothetical
> situation, but something that actually happens in regular use. This
> would be pretty disasterous if anything used this driver.
> 
> Replace the addition with an overflow-checked addition from overflow.h,
> and saturate to U32_MAX if an overflow is detected.
> 
> Fixes: b45293799f75 ("interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



