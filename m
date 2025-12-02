Return-Path: <linux-pm+bounces-39034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF07AC9A3DE
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 07:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0D2E4E1420
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 06:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ECF2FFFB3;
	Tue,  2 Dec 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Xogy1VOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1152FE060;
	Tue,  2 Dec 2025 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656694; cv=none; b=hSVDflL8qf9JkkmyjzMVweyaJ9fo9bJn+JtRhKfv2f2BA+3Bo9DUXYckC1srZIYLd1Hek+0pO2EdvShJcSOfOqYKBOLxR4NhhX82LeoPHZKp9lacfubyoVCQ8DJzsZVqUvG/Inyeby0SV2gj4blX+V3U3UuaNaxdjsiplRWAOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656694; c=relaxed/simple;
	bh=3qlU0R4yafuTK+KdXZPalFqNk81NApAR7r+shyA5GmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iuEWWwIF3yFFuQc02j2lEt7bmPqoe4DAW+7Xs9FdqX5p52oUw3MdSasCtR4R97SOb5hcU2HyCenhFBrJZrOGNrJ2B6MiljDuIe2Jj7IIDa1tkXQDjrfsIvaHi3c6xxHVralEnr0XlSguV1x75MCxpQw4rD2q7JZKA3k0oxgUw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Xogy1VOO; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ka8XXlrkYOjYgwI7yj+xdHhRwl0ZG1Q8UkWDfo38Z9c=;
	b=Xogy1VOOxJ9C8rgHMpBpOE44e+tsW2cVLTdN+U4POxheDVYDPff0nhPCZLIM+0JftA6ltnypk
	MEsjR31i35ZP4AXZYP20c3W1MmToAdn/9npu2wOO7eEswuJ5pKP0Ff+hhAaiKZq/YU2j1tjb/w3
	Ma6tgtblc2ubTOvWI7G/Jk4=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dL9fk032Jzcb1N;
	Tue,  2 Dec 2025 14:22:22 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id C535F180BCE;
	Tue,  2 Dec 2025 14:24:47 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Dec
 2025 14:24:47 +0800
Message-ID: <9590b0fb-f297-4e6a-9265-ba7a17abef31@huawei.com>
Date: Tue, 2 Dec 2025 14:24:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: cpufreq_boost_trigger_state()
 optimization
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>
References: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
 <20251128091352.1969333-3-zhenglifeng1@huawei.com>
 <3t6quaz6j5mbzewgrszuzmjmv74bzqrskx5k4ewgsfbaijmoli@y7goctaq35mj>
 <3f51db20-3822-4be7-ba13-e858aab25dad@huawei.com>
 <a6p3btn4ykt6rzdduww6ozunusfubv2dmczqfr4uuttgcnyjqh@kevefkumtidj>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <a6p3btn4ykt6rzdduww6ozunusfubv2dmczqfr4uuttgcnyjqh@kevefkumtidj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/2 12:58, Viresh Kumar wrote:
> On 02-12-25, 09:32, zhenglifeng (A) wrote:
>> On 2025/12/1 11:42, Viresh Kumar wrote:
>>> On 28-11-25, 17:13, Lifeng Zheng wrote:
>>>> Simplify the error handling branch code in cpufreq_boost_trigger_state().
>>>>
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>> ---
>>>>  drivers/cpufreq/cpufreq.c | 11 +++--------
>>>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>> index a4399e5490da..a725747572c9 100644
>>>> --- a/drivers/cpufreq/cpufreq.c
>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>> @@ -2824,18 +2824,13 @@ static int cpufreq_boost_trigger_state(int state)
>>>>  
>>>>  		ret = policy_set_boost(policy, state);
>>>>  		if (ret)
>>>> -			goto err_reset_state;
>>>> +			break;
>>>>  	}
>>>>  
>>>> -	if (ret)
>>>> -		goto err_reset_state;
>>>> -
>>>>  	cpus_read_unlock();
>>>>  
>>>> -	return 0;
>>>> -
>>>> -err_reset_state:
>>>> -	cpus_read_unlock();
>>>> +	if (!ret)
>>>
>>> Maybe we can make this `if (likely(!ret))`
>>
>> For the platforms which are not boost supported, this will never be
>> matched. Is `likely` OK in this situation?
> 
> Ideally they won't have a `boost` file in sysfs, and if they have it, we don't
> really need to optimize the failure case.

I see. Then I think the `if (ret)` in the loop should be
`if (unlikely(ret))` too.


