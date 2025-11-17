Return-Path: <linux-pm+bounces-38126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEDBC64404
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99D354EE4A0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B532C321;
	Mon, 17 Nov 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kJYyrBui"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F40261581;
	Mon, 17 Nov 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383693; cv=none; b=kbZQcdxBaIyDq8DEAwCJStTmd+eecDZUQ+GV0IMmsn+QRSdozWO3DmjCI5/xCJB85YI6Dth112h9YZlfveRfOlWqfeWvbXEGaUXRvEp/BVoi4WikoqCLbKL9olyo8udzh46/zJ7gPQbEHTmWFVhgMDMl/T9t8hgW7+EPP/7bb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383693; c=relaxed/simple;
	bh=+MFGG8MAg9lirzqKLV5cI/CokpPWWF061SoFUkLSFvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9Dj/kec7DQutTNVvVT/mRHIWOFid1qiWk7DsSERkZ1kukxCTDXeWnV3aAq8Mh2PunbexmokWY9o6hcmcDe8RxTiZkTuVFBMX2dD2GvumAYUDsqkmzM1hZenRvgw/+0whuBhtEZOoPO+zLIFH+ZKvg+ivWJRnaIDNb8OF4T/BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kJYyrBui; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763383689;
	bh=+MFGG8MAg9lirzqKLV5cI/CokpPWWF061SoFUkLSFvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kJYyrBuiQNyFB//1l745/976UtuqtR7p5FmlRqy2doCi1+pFFhoVZoUgpiPrKjPt+
	 KKeooJsIqn8uN3FtztwGpGkYkwMhw9SbTbx7+vXuJVfqNSjWOORQoMQ6uEl76V3zF2
	 /aB8ZY3aeo8g4dZ0YMXjVh/1fe5n4bQuYgFFzhWPqJIPT15lnNVc5LKNJmzPinaqjQ
	 W2ZhpVYBkY4YxGg0y3Iz9ahgw/9CUC51zIBDX3qd9A3tc7WHAmKzKOLwZF9otYCIM5
	 a3O+KPIqDwujmoElsPEEFaizeFoK2yVXP68gVQkfWpSQaNxxV/KJ91g2TBsJPCIxdc
	 cHMGWZ37THYOQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7D9117E0B85;
	Mon, 17 Nov 2025 13:48:08 +0100 (CET)
Message-ID: <8bbb405e-203a-44d2-8f94-6b7cbcf1589d@collabora.com>
Date: Mon, 17 Nov 2025 13:48:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] dt-bindings: soc: mediatek: dvfsrc: Document clock
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Henry Chen <henryc.chen@mediatek.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-2-b956d4631468@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251114-mt8196-dvfsrc-v1-2-b956d4631468@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/11/25 17:53, Nicolas Frattaroli ha scritto:
> The DVFSRC hardware has a clock on all platforms.
> 
> Instead or proliferating the culture of omitting clock descriptions in
> the clock controller drivers or marking them critical instead of
> declaring these types of relationships, add this one to the binding.
> 
> Any device that wishes to use this binding should figure out their
> incomplete or incorrect clock situation first before piling more
> features on top.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


