Return-Path: <linux-pm+bounces-15376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7A49965BF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 11:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160DF1F227A2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E767A18B470;
	Wed,  9 Oct 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F/WLdswv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3032C85;
	Wed,  9 Oct 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467052; cv=none; b=mfSBX+Qy0R0BV5VT6oZnslfVq1tOTpo4We0HcNHO0jNvNLMTi48ZuHTkvgK+jUuBrvSIjb1ouJSPHsfmCeBKShHnOupS8GadEH5izxRvB6ZpgvuE+gesNHNLnxdeTiX/CvdBc3XhsHHLsTvfJdlJ3955aEG4orsfrAIoSQNGIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467052; c=relaxed/simple;
	bh=Z3iinUjgnAvC1S95E+xKJvY9e95ZF0aoef8w+t7z4Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2XLgDc+DXGZ2CGlnu16JYjWUQBThXJX++MvAi1G374fSnpZM1NJ5HjTqmgwBSfuyLfAdFDGrubEjwCs+juqJ2BAPoSnU6AdPRlntOUOdEpDM+fDXOJtNxEFUOglKGjxCwuaCFuuXB317Xm9H0BguOsgDAECJ/swKp2IueR4yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F/WLdswv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728467043;
	bh=Z3iinUjgnAvC1S95E+xKJvY9e95ZF0aoef8w+t7z4Lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F/WLdswvR0RLYChmpOxzQ8J66bjMJ5ClcudqSqQ1VOXUfcSWUxw+DZaE3gSjUgj8I
	 C5+CErRmXg0sbc010nABjdQpKE8ygLc944c0rtOA5UiomXeUCH0ufVMnSjp7ZUzg+h
	 YCj1qxnbvh7A2OSujxBxCwMSgP2ANUiCVf3wZXevgGzUT3HYXIy9KUc/df28dGE5GL
	 CS8Ddg7wfvkDIOy2/4VEEs/OD729xLPfiUFkWIWW0eHskMXJ2gjfO4VapoB30woKpA
	 OpnEUzsFnJs6Oobvrd3wFsV4bmXlNFrvFm3cOwNJzgnBPSuRBF2G00bFSg5ee3w8l3
	 b5MvI81wL6kXQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B3C1417E120F;
	Wed,  9 Oct 2024 11:44:02 +0200 (CEST)
Message-ID: <37648a24-03be-4acc-bfba-cf0ecb4b8f91@collabora.com>
Date: Wed, 9 Oct 2024 11:44:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] pmdomain: mediatek: Use OF-specific regulator API
 to get power domain supply
To: Chen-Yu Tsai <wenst@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Johan Hovold <johan@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240930044525.2043884-1-wenst@chromium.org>
 <20240930044525.2043884-4-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240930044525.2043884-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/24 06:45, Chen-Yu Tsai ha scritto:
> The MediaTek power domain driver contains a hack that assigns the device
> node of the power domain to the struct device of the power domain
> controller in order to use the devres regulator API.
> 
> Now that there is a proper OF-specific regulator API, and even a devres
> version, replace the hack with proper code.
> 
> This change is incompatible with incomplete device trees. Instead of
> assigning the dummy regulator in cases where the power domain requires
> a supply but the device tree does not provide one, the driver will just
> error out. This will be seen on the MT8390 EVK, which is missing
> supplies for the IMG_VCORE and CAM_VCORE domains. And likely all the
> MediaTek EVBs, which have no power domain supplies specified. This is
> however the correct behavior. If the power domain's supply is missing,
> then it should not work. Relying on other parts of the system to keep
> the unattached regulator enabled is likely to break in ways less easier
> to understand.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


