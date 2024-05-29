Return-Path: <linux-pm+bounces-8345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B478D3106
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353F3B27CF6
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE317B4F2;
	Wed, 29 May 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h5wjrRC4"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ECE179957;
	Wed, 29 May 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970671; cv=none; b=rhVpYljWFm2T9YxCUaFVUSn+HxGaabnWGKXOkfeVzwp6dlF1TvLVMiWwEi6XyL6D+AFSzWw4F8q7yq6FadJILr/8tjVlGE9CiM4QociZQ4zMljPMxOTC29XsdVla4Qon+G/rqyH+yuqGsuUY+HpyJjP4WxMA32NqZLpZ4njq0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970671; c=relaxed/simple;
	bh=fHj9eLgnKKslWu+AKFRFaZvuAD6KevAgJPrKaOpy1bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD2wupIH1EHPmU77j/H9f3uQDoZVjApJfKOFzwEXk3UeeLlkxyuQTCcS45Wr+fZXQcm7yS827/IG7XFWMgjnN7SUfxDeaYq2U1SdxDc1mnX7Pvvb1uUNDjwLQGPKrHsNR81VRqNM0W236TA9EqCgrTvl/73QIN+amyo1FK7qcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h5wjrRC4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716970668;
	bh=fHj9eLgnKKslWu+AKFRFaZvuAD6KevAgJPrKaOpy1bs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5wjrRC43xN41I3TTIZ62IkvVio6xWo+HzdpIH43StkHbNoBdsoJbGupTbGkQyoWF
	 93ZrFcbH2ybXrrgQWOuAZrdO4b4EVilLIasEZJKdU60Sbr98lTETbVqtMwfYN4SD8G
	 0yda7Y3klu/gDIpJAM64kdxamBQcpZszBYigouY6Bxt6qzKB9NAXCaPrgZ0b6NpDRl
	 Tf+ZX0pMpVx/qPHzH/qj7oRKte5/APkMAXjH+D7qwv5ZthQchKgPehYKjMhpAYrswI
	 oTtsYZhxpCPTaUvjXrP3cV1Yrb6tta6h4wMDvfJ2LYmHxA9P+4T9LrGrEECQSVcxlL
	 /eyJcIiiYB8Lg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 87D85378215E;
	Wed, 29 May 2024 08:17:47 +0000 (UTC)
Message-ID: <b941ed93-2fe9-40b1-b0c1-343602802685@collabora.com>
Date: Wed, 29 May 2024 10:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] arm64: dts: mediatek: mt8188: add default thermal
 zones
To: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-6-0c71478a9c37@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-6-0c71478a9c37@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/05/24 07:58, Julien Panis ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Inspired by the vendor kernel but adapted to the upstream thermal
> driver version.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



