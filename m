Return-Path: <linux-pm+bounces-17091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971969BFB76
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 02:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487CB1F221B0
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 01:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBC79E1;
	Thu,  7 Nov 2024 01:30:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFFD515;
	Thu,  7 Nov 2024 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943018; cv=none; b=o+R4Mt4cx0kxAkAT7AeXgtxCaFWIx8uTT6qS10uCqfpcSWdHLSZDy1H96a4cHkassERWWyBCp0iTep8V7REhfqdqDGjYWifLrHImhME/AfK8T7Rl8iSu9aTeMwsy6ofdWKJ3gr2/i0xmyw/dB9TbRlrsAFLhvvS0AJM8Pqci4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943018; c=relaxed/simple;
	bh=bX59sfmm+6NRT9Uask54M+OybjX7jicZBwIVTsf1PrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VKzZxeDlk3Qj2pHquK81V3qfsw1vrA1S82f8iP0jVZyXaWxj29/HHSQXU+HMlfPlGdLdjLy/FEb340omm+CZ9K2uku8Dbdii+FDLtIcOzj8KYDWK+yYAajeIUCbrB1ubf3YawJGg2pLfjmEWJUJOs5YBSNhyRwI+DU5jOT+UitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XkPZw6HwWz1T90v;
	Thu,  7 Nov 2024 09:27:52 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id A2619140337;
	Thu,  7 Nov 2024 09:30:13 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 09:30:13 +0800
Message-ID: <2d04feea-c568-5ff8-019b-119b824e8a0f@huawei.com>
Date: Thu, 7 Nov 2024 09:30:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] powercap: dtpm_devfreq: Fix possible memory leak in
 __dtpm_devfreq_setup()
Content-Language: en-US
To: <daniel.lezcano@kernel.org>, <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241026082525.474914-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241026082525.474914-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Gentle ping.

On 2024/10/26 16:25, Jinjie Ruan wrote:
> If dev_pm_qos_add_request() fails, dtpm_devfreq will fail
> to free, which cause the memory leak, add a new goto label
> to free it.
> 
> Fixes: e44655617317 ("powercap/drivers/dtpm: Add dtpm devfreq with energy model support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/powercap/dtpm_devfreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
> index d1dff6ccab12..85b6982901d1 100644
> --- a/drivers/powercap/dtpm_devfreq.c
> +++ b/drivers/powercap/dtpm_devfreq.c
> @@ -171,8 +171,7 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
>  	ret = dtpm_register(dev_name(dev), &dtpm_devfreq->dtpm, parent);
>  	if (ret) {
>  		pr_err("Failed to register '%s': %d\n", dev_name(dev), ret);
> -		kfree(dtpm_devfreq);
> -		return ret;
> +		goto out_dtpm_free;
>  	}
>  
>  	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
> @@ -190,6 +189,8 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
>  out_dtpm_unregister:
>  	dtpm_unregister(&dtpm_devfreq->dtpm);
>  
> +out_dtpm_free:
> +	kfree(dtpm_devfreq);
>  	return ret;
>  }
>  

