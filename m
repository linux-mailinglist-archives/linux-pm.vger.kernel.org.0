Return-Path: <linux-pm+bounces-39721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E300ACD2BCC
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3E24300C350
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538632FD660;
	Sat, 20 Dec 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dnFirHVs"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E2156678
	for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766221805; cv=none; b=UpID9FRJKnlalSMVHnxYTMs2b3DcjI2ZK5kAHG6DXfqc1fQUDTPfHJKsDxd/JFpQEOdq4/Ab/2XiiJm+3oM/H4rcUZfs0VEbN6vRvS1ZcMfpdaDPQOVgdLiHdFpzmHhCfIpfXcKIk0rZhQcIUdNsxnnE1I2cBH04lZckNxheuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766221805; c=relaxed/simple;
	bh=Wq8heGKAJZkrhzzjaNdYSFBNIGbi1OuAmrxIqSYn1Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X1D789K8v9vVELN4QOmBRZw4Zx3NdYdIsaTrCOqYxMfmyImZzxjMSqGNNqZe8/9Bxpv9fIkkpcmd5WbfiUBTS3e5afn3T2Gopikbfi9PXhkvcgyMmKO+BDX5uMCx4AJIrD0CzB/E1WcErx+QGOHe2ugoFhS9HUxdYqi2SrY/Fjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dnFirHVs; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5L9v6OHnfP7k9c007lGzW0HGlDUIr8rUpNU8k/eVRD0=;
	b=dnFirHVsQJG1MYA63EaUda5tdfnpb6DM+gkVVQb9asWwPX/RRRbmKnSFqj1A0pRr4czlGluYL
	OaTaxpkhysq955QRNaU7xyZBdsvIMm1ioJrEUdT/PUWTGs7BAVs0Te62V7BnbNHH1rH7V2pJfrX
	frcQCnXIpZQ1zZp8D29GYss=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dYJS90lXGzRhRm;
	Sat, 20 Dec 2025 17:06:49 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id EA80940565;
	Sat, 20 Dec 2025 17:09:53 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 20 Dec
 2025 17:09:53 +0800
Message-ID: <62ad0257-aa50-4ab6-bd46-64c3963e4b94@huawei.com>
Date: Sat, 20 Dec 2025 17:09:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU
 hotplug
To: Beata Michalska <beata.michalska@arm.com>
CC: Will Deacon <will@kernel.org>, <catalin.marinas@arm.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>, <sudeep.holla@arm.com>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <ionela.voinescu@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<vincent.guittot@linaro.org>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
 <aS2z0EURwHbbGZab@arm.com> <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>
 <aS8GZOuaS1-j14MD@arm.com> <29253319-ced9-4ab6-a58e-28afdf235cde@huawei.com>
 <aTx2V4am0FNHm03R@google.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <aTx2V4am0FNHm03R@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/13 4:08, Will Deacon wrote:
> On Fri, Dec 12, 2025 at 05:27:09PM +0800, zhenglifeng (A) wrote:
>> On 2025/12/2 23:31, Beata Michalska wrote:
>>> On Tue, Dec 02, 2025 at 11:05:25AM +0800, zhenglifeng (A) wrote:
>>>> On 2025/12/1 23:27, Beata Michalska wrote:
>>>>> Hi,
>>>>>
>>>>> Apologies for the delay in reviewing this - currently in progress....
>>>>> Out of curiosity: what's the cpufreq driver used for testing this series ?
>>>>
>>>> I used cppc_cpufreq for testing this. But with some modifications in
>>>> processor_driver.c, or you'll find that the driver will fail to load with
>>>> maxcpus set. The modification below is only a temporary solution. I'm still
>>>> working on that.
>>>>
>>> Right, so overall the implementation looks good - thanks for that.
>>> There are two issues though with the cppc cpufreq driver.
>>>
>>> One: as you have already noticed - it fails to register when
>>> cpumask_present != cpumask_online.
>>>
>>> Second: it will mix the sources of the freq scale if not all CPUs within the
>>> policy have AMUs enabled/valid. This is due to the fact that at the time of
>>> registering the driver and initializing the FIE support policy->cpus ==
>>> policy->related_cpus. Assuming scenario when there are two CPUs within the
>>> policy, one being offline and missing valid AMU counters,
>>> the topology_set_scale_freq_source from cppc cpufreq driver will register
>>> the tick handler for both CPUs, whereas AMU support will (rightly so) register
>>> only for the firs one. When the second CPU comes online, the mismatch will be
>>> detected and the arch callback will get cleared for the first CPU, but the
>>> second one will remain unchanged.
>>>
>>> That said, I do not think any of those issues is a blocker for this series.
>>> But both would need fixing.
>>
>> I believe Beata is OK with this series. So I think we can move ahead with it
>> now.
> 
> Please repost at -rc1. It would be nice to have an Ack from Beata...

Hi Beata,

It would be nice if you could give this patch an Ack.

Thanks.

> 
> Will
> 


