Return-Path: <linux-pm+bounces-39027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EDDC99C1B
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 02:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C47CE4E1F89
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFA1191F91;
	Tue,  2 Dec 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z1jeCOy9"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612B19F13F;
	Tue,  2 Dec 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639168; cv=none; b=EiUGLnQio+VYycWubzXM0BeFGRUO2wbv5py4a8SYUXRjNM5O+5uYVciDSyQw5YPvbKol24zFm9A8vLWlrrmFefSFW/JZGSATQuGgXE3+qimQ5iq3WbzO+GihhLaP/qS4wl4XFX9NQGxlYykU4qOBUha4NOSUb7Enrox/cFPpB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639168; c=relaxed/simple;
	bh=7vnB+uuMt9Ve48g+y8sSfoXBNTy/j63c346NWQ1LKZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AME3xxxy3yNPXRI0uxsvvEkuBXn0oT9wP6I7rg+hAKztLO2MwuCbjAPHwzXxqjO4YnmWjJFxb8ts7bdqvWFTnhbPAAMKu0iAVZCKEIs2BvKL/VP9k/SjXwcGN+pjWzvOlaMc/0bwmO9F9YkYfPXqIcwdadasLCyIeK2j7odQCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z1jeCOy9; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dvjUtgdz8YA+mDrrZbql8hEdI85agS+YD1FFUYfzzfY=;
	b=z1jeCOy9+2hb6oho9pv+Lqvr4LVw1EPe4afLxpcozA/WuEEefraMWkg8REPpbM1Kso5Pv+3Ma
	q/sKxsZZPTEIRBJ8HcBNyoaM8FjXEPmjghKkvXx3onKO9891BnkrJbTRVnjuVUtqRV6LiqkkX3U
	xHnOTPq96bzqUyIZH8vPzBk=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dL39g39dkz12LDK;
	Tue,  2 Dec 2025 09:30:15 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id EDFA5180476;
	Tue,  2 Dec 2025 09:32:37 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Dec
 2025 09:32:37 +0800
Message-ID: <3f51db20-3822-4be7-ba13-e858aab25dad@huawei.com>
Date: Tue, 2 Dec 2025 09:32:37 +0800
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
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <3t6quaz6j5mbzewgrszuzmjmv74bzqrskx5k4ewgsfbaijmoli@y7goctaq35mj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/1 11:42, Viresh Kumar wrote:
> On 28-11-25, 17:13, Lifeng Zheng wrote:
>> Simplify the error handling branch code in cpufreq_boost_trigger_state().
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index a4399e5490da..a725747572c9 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2824,18 +2824,13 @@ static int cpufreq_boost_trigger_state(int state)
>>  
>>  		ret = policy_set_boost(policy, state);
>>  		if (ret)
>> -			goto err_reset_state;
>> +			break;
>>  	}
>>  
>> -	if (ret)
>> -		goto err_reset_state;
>> -
>>  	cpus_read_unlock();
>>  
>> -	return 0;
>> -
>> -err_reset_state:
>> -	cpus_read_unlock();
>> +	if (!ret)
> 
> Maybe we can make this `if (likely(!ret))`

For the platforms which are not boost supported, this will never be
matched. Is `likely` OK in this situation?

> 
>> +		return 0;
>>  
>>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>>  	cpufreq_driver->boost_enabled = !state;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


