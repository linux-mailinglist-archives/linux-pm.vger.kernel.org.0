Return-Path: <linux-pm+bounces-35274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2DAB999C8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1B7320F86
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB342FDC4B;
	Wed, 24 Sep 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WLkIaNPp"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1924DFF4;
	Wed, 24 Sep 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713758; cv=none; b=lYd7bta4oq0NYGSxTN5yz/9+0a6O/+Gwl3IxLIsjoiC2c5nII0kBMI1Z/ITNcGgoNf0UsrFPgS8PghfCY1e1DGycGemAkG6xQZCU5Jux88QjUIiE2PsE3LiPQGGwK0YdDSOpoCALQZlbeS2evWlkd3vgWoLwJraxChdlyDHD8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713758; c=relaxed/simple;
	bh=cwneILn6ZVC29eFS05rUz6lGLlw/AQ/6m5dsiihK55g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoSZnKZhlqnLikwKhdtXdSOd2tQFKE3oGrg00HAy3/u6XlpsAHtM48kgWtOPZYIGFB88L4YWEvPoQXlwpDz14x/mLH645uzYx1lkwUDC7DgBXMsXweWwat1ijV5z/vhUSV6XA5YHIKOEUBz6jydseo4qbcPJvSB62SDQK0JMCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WLkIaNPp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758713751;
	bh=cwneILn6ZVC29eFS05rUz6lGLlw/AQ/6m5dsiihK55g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WLkIaNPpWRiIekxvXilghkdGQpTr7UPljwSUQQNEy+zQxBZhDdmEl7xtSqm6EYArg
	 EDFH90PlD/WUere4CBQGzMY1VA9HQHBHs2X/xyXG+WAr1RwBJ4qYtA8obudaz7vJp0
	 fOtyIKJxBngqmWSkrMtRV6fMAYwWhYK7o3+Zh6KX3dqa1NtueX109ivMZ4bsl/l6O1
	 7+5nyMDMqY4muqjoHCy8f+kZ3KPX/ucBMm0kAPyg397DDYyJ0dRwJsf36Ee4DssNgb
	 n59KWdu86YleG0oSLiFgcpc2MiWFx2jDhWT0viE8fa0lXoR9ZdFGAA+HGG6KBe74dC
	 tSdfdXfBU5Qfw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D9D717E00EC;
	Wed, 24 Sep 2025 13:35:50 +0200 (CEST)
Message-ID: <63be9fee-46b4-4bde-8e42-18966981f165@collabora.com>
Date: Wed, 24 Sep 2025 13:35:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] mailbox: add MediaTek GPUEB IPI mailbox
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
 <20250923-mt8196-gpufreq-v4-5-6cd63ade73d6@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923-mt8196-gpufreq-v4-5-6cd63ade73d6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 13:39, Nicolas Frattaroli ha scritto:
> The MT8196 SoC uses an embedded MCU to control frequencies and power of
> the GPU. This controller is referred to as "GPUEB".
> 
> It communicates to the application processor, among other ways, through
> a mailbox.
> 
> The mailbox exposes one interrupt, which appears to only be fired when a
> response is received, rather than a transaction is completed. For us,
> this means we unfortunately need to poll for txdone.
> 
> The mailbox also requires the EB clock to be on when touching any of the
> mailbox registers.
> 
> Add a simple driver for it based on the common mailbox framework.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



