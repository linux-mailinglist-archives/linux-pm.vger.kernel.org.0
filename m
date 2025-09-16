Return-Path: <linux-pm+bounces-34700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528EB58AE3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 03:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2678E1B20786
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58931D31B9;
	Tue, 16 Sep 2025 01:10:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9981C84C0;
	Tue, 16 Sep 2025 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985030; cv=none; b=kk6OtZiC3/KuE9W6M4YJW0XI+FVsZYP85aXG8DNXEeRSQSWgHxuDhh57A0Pqr5Rmd7MM9Hbp60LjtwAiew021rv+2poRqacu57k+XIaoN4jJgDKKCom1AHDNS8+hhqNEgPwRwxrLo1Uk+yTl1eoggeRA26CffS4Wcgm+6INpU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985030; c=relaxed/simple;
	bh=y3MeIsefnG5tLWf7LJp6Nrk2brtQsFgp+68E4kEaiDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JxwRiwWESSco8z4jN1unpFcjV0QBuVO4vEs7pRE3K+Gbce/NVPWumYr4whyM7Zb3BUg+H7UqgVghv8R3uL9R8o0+uAX9VTLHEcH1DG5BA/BA+pqIrwlpwd6Z1C1FdzRgU1pc2P/RAy4eA/y3XoMd2D2/Ekvb2IuILMoCCeu/4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cQkJP1973z2VRcm;
	Tue, 16 Sep 2025 09:07:01 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 495251400CB;
	Tue, 16 Sep 2025 09:10:24 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 09:10:23 +0800
Message-ID: <bdc702db-a898-4b92-bc5f-db802fe235b5@hisilicon.com>
Date: Tue, 16 Sep 2025 09:10:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / devfreq: hisi: Fix potential UAF in OPP handling
To: Pengjie Zhang <zhangpengjie2@huawei.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20250915062135.748653-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250915062135.748653-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 9/15/2025 2:21 PM, Pengjie Zhang wrote:
> Ensure all required data is acquired before calling dev_pm_opp_put(opp)
> to maintain correct resource acquisition and release order.
> 
> Fixes: 7da2fdaaa1e6 ("PM / devfreq: Add HiSilicon uncore frequency scaling driver")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  drivers/devfreq/hisi_uncore_freq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
Hi Pengjie,

Yeah dev_pm_opp_put() should be after dev_pm_opp_get_freq().
Thanks for spotting this.

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> 
> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
> index 96d1815059e3..c1ed70fa0a40 100644
> --- a/drivers/devfreq/hisi_uncore_freq.c
> +++ b/drivers/devfreq/hisi_uncore_freq.c
> @@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev, unsigned long *freq,
>  		dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq);
>  		return PTR_ERR(opp);
>  	}
> -	dev_pm_opp_put(opp);
>  
>  	data = (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
>  
> +	dev_pm_opp_put(opp);
> +
>  	return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data);
>  }
>  

