Return-Path: <linux-pm+bounces-36765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85DC046D9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 07:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5163B9EC5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 05:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E3242D62;
	Fri, 24 Oct 2025 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RNO34Uju"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF226AEC;
	Fri, 24 Oct 2025 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285200; cv=none; b=u/mOUD16hELgUIAx7UI+NPCJ7N+nIJ0lXvQOgho3v5GgeVRVsSjq0N7VYPFPkSnlPkHJok35IdBsrzJQ+RepBDerkdyIJhT6O19HbB6BbOXeIAQFo5vTXeX9hPC1+3Oud5Ks/nuZ8y8FflW9U5OhgrVsxYIOHzNHc1cYKuUStfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285200; c=relaxed/simple;
	bh=CX/6xNCkWzoa/34JQHAzp6QuK8mm/NivX3nU1pFQYJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6suWyPx7b3obb/nzdfM7ux0Z2SIQGqqVRXSNrZFU3RR8fpKtUMqVWhUWVFnXS6xF3JSFZlQma8/Qo0LwYihAbkQZyo+L2ivw1isItfcrto0oCrqWGvuyRo21qV8rfDcMkt2udvUf33nIUavPYQGD8GLsJR3PCrv6q3H5MkIBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RNO34Uju; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761285196;
	bh=CX/6xNCkWzoa/34JQHAzp6QuK8mm/NivX3nU1pFQYJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RNO34UjuD8cmIPiDKUA2FqjCJfJeIR+S9mPQsOFXWdl4aWhGvn795QH8kzbKJkJoU
	 B//1D8lqvlSAKaqB/svEhNPUyB74YjpgfXRNgfpt510BthEz3xe0YprHX6CiyK7y7j
	 EkzsbWkFjujZ8VNcIsYdbjH0eYhQHS99N+njLtvszDK+BHOMDn0Z9WnEYvXpA7lE2D
	 8xKY7HpeXZOHYLWFZNgnQ8wBUSlaCMMeE0vUfvLChg+b3Ld0v7PUtD58KrLux+IHGd
	 W/CUtNvn+gO4xn2gtfzj9wRSO1ZHPf/5AnUPt9hOCpTqq5AcdLpwcRFSmHE/rbpWxp
	 4NiHgUd9Xij/g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C461C17E0CA1;
	Fri, 24 Oct 2025 07:53:15 +0200 (CEST)
Message-ID: <1d69e292-f0c6-48de-a70c-ff2223e40fa6@collabora.com>
Date: Fri, 24 Oct 2025 07:53:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: Fix build-errors
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>
References: <20251023114436.185320-1-ulf.hansson@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251023114436.185320-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/10/25 13:44, Ulf Hansson ha scritto:
> Let's add the missing header to fix the reported build-errors.
> 

Ouch. Sorry about that.


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Fixes: df4e9ec1ed86 ("pmdomain: mediatek: Add support for secure HWCCF infra power on")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510231317.ZZxNaFG0-lkp@intel.com/
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index ac144ab8fce0..164c6b519af3 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright (c) 2020 Collabora Ltd.
>    */
> +#include <linux/arm-smccc.h>
>   #include <linux/clk.h>
>   #include <linux/clk-provider.h>
>   #include <linux/init.h>



