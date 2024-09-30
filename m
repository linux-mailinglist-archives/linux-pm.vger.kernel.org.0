Return-Path: <linux-pm+bounces-14936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3B989EC5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BB81C21AFB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8D189F5C;
	Mon, 30 Sep 2024 09:53:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B2189BAC;
	Mon, 30 Sep 2024 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690028; cv=none; b=gEFKHZPeuwmXJSD6IriGYOYuSB4iszHe++ixNS9cR3fvbbTOOo1W2I16lkch2xTLA86kt+VPZ1g+LPkZ7p8vZWupkkMbZdJ2KmzLobaQaS/5XvBMGKx5uicDnekA2SW5OLLJml9F1USm11mXJ/sr4RtX/CNjXhX+YKALv8egsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690028; c=relaxed/simple;
	bh=RmgnHYxboZxokVh2pEqYY1w2qrz1HXqLTNCsYRXejHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=l/BggMCApHVvwJJMf0VMIbjHxAGLw7l2oDEE0f/ZXv6bkW8yPVl9SomI53tdtes4ouoj6ZvXyGfbVY6rGm1dPPevwgMjD///mRxc/6Rrs80wZbB6TMqFurPzL+yVzc57cZNhcGYTubZyZXl1tSu3V4tB0+v8SjUgcxU9Bq2LYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XHGb55qGWz2Dd5j;
	Mon, 30 Sep 2024 17:52:49 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 8667214013B;
	Mon, 30 Sep 2024 17:53:43 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Sep 2024 17:53:42 +0800
Message-ID: <6436838e-8b2d-4727-b207-e6c3168960e5@huawei.com>
Date: Mon, 30 Sep 2024 17:53:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: cpr: Fix possible uninitialized value
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20240930094456.2593136-1-ruanjinjie@huawei.com>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <20240930094456.2593136-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Hi, Jinjie

I have sent a patch with the same modification before:

https://lore.kernel.org/linux-pm/20240926134211.45394-1-zhangzekun11@huawei.com/

Best Regards,
Zekun

在 2024/9/30 17:44, Jinjie Ruan 写道:
> of_property_read_u64() can fail and left "rate" uninitialized,
> and the zero check in cpr_corner_init() for cpr_get_opp_hz_for_req()
> can not prevent it and it will assign cdata[level - 1].freq to random
> value, so init it to fix it.
> 
> Cc: stable@vger.kernel.org # v6.12
> Fixes: 181c8148556a ("pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/pmdomain/qcom/cpr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
> index e1fca65b80be..26a60a101e42 100644
> --- a/drivers/pmdomain/qcom/cpr.c
> +++ b/drivers/pmdomain/qcom/cpr.c
> @@ -1052,7 +1052,7 @@ static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
>   			of_parse_phandle(child_np, "required-opps", 0);
>   
>   		if (child_req_np == ref_np) {
> -			u64 rate;
> +			u64 rate = 0;
>   
>   			of_property_read_u64(child_np, "opp-hz", &rate);
>   			return (unsigned long) rate;

