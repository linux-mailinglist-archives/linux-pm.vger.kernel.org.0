Return-Path: <linux-pm+bounces-12938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A096048C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D4A2841B1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994019342E;
	Tue, 27 Aug 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PYCGkb1K"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED914A90;
	Tue, 27 Aug 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747752; cv=none; b=BZuoM1U6pOQ17eyIJhUHhnJNUv95ZDHSuI+iJIHgnFi6fh+FGycpLZs9o3T+6FarzmsWZG/CnBkiDIybgRdUt0wAJlFfY0op0Yv/uwiANAQluZZHjJ0gUidXkWXNgWSZp+CBYfLBiBNa96aD0P4GxCRwEIlNNnvb3d1uHwESggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747752; c=relaxed/simple;
	bh=xEUpYp0je7oKMTEnx48I9vtTKW4Nuu8Lt0HeCRT52vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMxho+R/QyENMflrfH4hK9yXZdO6IEE/nolGbb8Dmpr2Nv41AQpCfFy7ZRmC4NrpgzshSIfKGtYIMWBAaEp6DW9Ep+lQM91XQPv27BWADx/7rkDMN5h3eUnKJvfMRozlgjNnKYxn0+CGn/mYmsbNi1SYK/+GY6aJUmI4Y3nmjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PYCGkb1K; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724747747; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XVjKbCb21liJy2wBYvTC4xS7sjOXiQNSn4t/bSACcxo=;
	b=PYCGkb1Khhdv2ix+Kk3N4SeL+gOZURSbl+6ng2uJOzRuOV1rieQ8h0eaGx4579aF/pYzgPr3pXnuxAgLYocylYub6RJDEftc1kFKL2f7D/LKqxHq4CwVxV/Qnyk8oK6s2NVofc+uiO4ksHOM8GXqHoiDkXUJERKpzQcxw6lQkkA=
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDm-lXk_1724747745)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 16:35:46 +0800
Message-ID: <d335fd2a-9ab6-4f91-aa11-559deb419433@linux.alibaba.com>
Date: Tue, 27 Aug 2024 16:35:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: sprd: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240820094450.101976-1-link@vivo.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240820094450.101976-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/20 17:44, Huan Yang wrote:
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Signed-off-by: Huan Yang <link@vivo.com>

Thanks. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/thermal/sprd_thermal.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index 874192546548..dfd1d529c410 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -359,21 +359,17 @@ static int sprd_thm_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	thm->clk = devm_clk_get(&pdev->dev, "enable");
> +	thm->clk = devm_clk_get_enabled(&pdev->dev, "enable");
>   	if (IS_ERR(thm->clk)) {
>   		dev_err(&pdev->dev, "failed to get enable clock\n");
>   		return PTR_ERR(thm->clk);
>   	}
>   
> -	ret = clk_prepare_enable(thm->clk);
> -	if (ret)
> -		return ret;
> -
>   	sprd_thm_para_config(thm);
>   
>   	ret = sprd_thm_cal_read(np, "thm_sign_cal", &val);
>   	if (ret)
> -		goto disable_clk;
> +		return ret;
>   
>   	if (val > 0)
>   		thm->ratio_sign = -1;
> @@ -382,7 +378,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
>   
>   	ret = sprd_thm_cal_read(np, "thm_ratio_cal", &thm->ratio_off);
>   	if (ret)
> -		goto disable_clk;
> +		return ret;
>   
>   	for_each_child_of_node(np, sen_child) {
>   		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
> @@ -439,8 +435,6 @@ static int sprd_thm_probe(struct platform_device *pdev)
>   
>   of_put:
>   	of_node_put(sen_child);
> -disable_clk:
> -	clk_disable_unprepare(thm->clk);
>   	return ret;
>   }
>   
> @@ -526,8 +520,6 @@ static void sprd_thm_remove(struct platform_device *pdev)
>   		devm_thermal_of_zone_unregister(&pdev->dev,
>   						thm->sensor[i]->tzd);
>   	}
> -
> -	clk_disable_unprepare(thm->clk);
>   }
>   
>   static const struct of_device_id sprd_thermal_of_match[] = {

