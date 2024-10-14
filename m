Return-Path: <linux-pm+bounces-15586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB599BDB1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 04:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787C0282139
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300627470;
	Mon, 14 Oct 2024 02:22:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68F200A0
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872546; cv=none; b=f/OEx3IU3jPWqpk9nmI/mVURkoQKdPQKpjsc3roDA57+XylRCPNhbxkkGu5i3TfJvepIvrBAITEtEH1UAKKkO25FXUhzODm9tg1PtfzTJyOYANdU+ckvo9Z61XF7IipKKmg7iNYsWhHxZvA6AU/zMxE0XI9n7Ldptz/mhgCKWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872546; c=relaxed/simple;
	bh=SAPApBP51G3RN4q/P8NArjhtuGveDvf04uaposnJ1m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rb++HuTAPLaAGgVYt18cE/G11iaQTFyhdXvWVtGy45qID615I2N/KCeUXq87wZIhgOYclw0ZxYLQByX2CaMU9fw5nmOGaW/8qxZ5KdL0YTz4I8jQGBa67P+o8TGXKfo27bYpNkayXbPBD+fAs6oBxOIAavzeoInysOHDCTet/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XRgvV1CRFz1j9pN;
	Mon, 14 Oct 2024 10:21:10 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 3078818002B;
	Mon, 14 Oct 2024 10:22:21 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 10:22:20 +0800
Message-ID: <cdfcaee9-711e-4b0b-8c69-fdba7d434e91@huawei.com>
Date: Mon, 14 Oct 2024 10:22:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 1/2] pmdomain: ti-sci: Add missing of_node_put()
 for args.np
To: Dhruva Gole <d-gole@ti.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>, <chenjun102@huawei.com>
References: <20240926012551.31712-1-zhangzekun11@huawei.com>
 <20240926012551.31712-2-zhangzekun11@huawei.com>
 <20240926093033.hxdfk7a2kowizowm@lcpd911>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <20240926093033.hxdfk7a2kowizowm@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/9/26 17:30, Dhruva Gole 写道:
> On Sep 26, 2024 at 09:25:50 +0800, Zhang Zekun wrote:
>> of_parse_phandle_with_args() need to call of_node_put() to decerement
> 
> s/need/needs
> s/decerement/decrement ?
> 
>> the refcount of args.np. Adding backing the missing of_node_put().
> 
> Add back* the missing...
> 
> Also, Just curious on why you're saying "Adding back", was it was there before but someone
> removed it?
> 
Hi,Dhruva,

Sorry for the delay, I have missed this question before.
There is no of_node_put() before and no one has removed it. It is newly 
added in this patch.

Best Regards,
Zekun

>>
>> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
>> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
>> ---
>> v2: Add missing brackets.
> 
> where? Please specify links to previous revision patches.
> Here, I have no real context of what's changes in V2 and why :)
> 
>>
>>   drivers/pmdomain/ti/ti_sci_pm_domains.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> index 1510d5ddae3d..0df3eb7ff09a 100644
>> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> @@ -161,6 +161,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>>   				break;
>>   
>>   			if (args.args_count >= 1 && args.np == dev->of_node) {
>> +				of_node_put(args.np);
>>   				if (args.args[0] > max_id) {
>>   					max_id = args.args[0];
>>   				} else {
>> @@ -192,7 +193,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>>   				pm_genpd_init(&pd->pd, NULL, true);
>>   
>>   				list_add(&pd->node, &pd_provider->pd_list);
>> +			} else {
>> +				of_node_put(args.np);
>>   			}
> 
> No need of else, I feel you just need to use of_node_put once, and it
> can be done after the whole if block, no?
> 
>> +
>>   			index++;
>>   		}
>>   	}
>> -- 
>> 2.17.1
>>
>>
> 

