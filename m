Return-Path: <linux-pm+bounces-31652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863FB16B22
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 06:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728D07B5F16
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 04:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1323312D;
	Thu, 31 Jul 2025 04:21:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE263595A;
	Thu, 31 Jul 2025 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935675; cv=none; b=IpQb5yK21j6stohGMc7JTqXX0e+j2UQmIktkjEsIilEjDvHodFcLUKdEkk7m60HWGpDXbn0rPOHXHp57WtjedeMLNIiQ0+xhbCgl9SybmdJMwbTed7dsOuPgUOWcoyG/46PQDKUukIn8ewuNpMj1sG7dBJtgSh7mPkmlLkJCH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935675; c=relaxed/simple;
	bh=oYxhoe8fD/RXglBEsKSCYvmB6bdqsbvA/HeTvmq8FQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kVWOQBPLZWMtXebgfY7Cowyf1u1pDSzqJMsrLHscdI++Uc1JipwjW9C3y8uvehUd2xakj9s98rjjYZi+mJl+mPqtb7D70hiYOjAeIreYxY8bPiOuCdt4CZgoparLU8oj9XGemOmWfQnoi1mFpTxfnwnY9QMaxnaYpik8hxiLGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bswkK145Dz14M40;
	Thu, 31 Jul 2025 12:16:09 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 925F4140133;
	Thu, 31 Jul 2025 12:21:02 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Jul
 2025 12:21:01 +0800
Message-ID: <baef79be-5969-fa4b-3802-ac49d071b11b@hisilicon.com>
Date: Thu, 31 Jul 2025 12:21:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
To: Markus Elfring <Markus.Elfring@web.de>, <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, Beata
 Michalska <beata.michalska@arm.com>, Bowen Yu <yubowen8@huawei.com>, Huisong
 Li <lihuisong@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lifeng Zheng
	<zhenglifeng1@huawei.com>, Prashant Malani <pmalani@google.com>
References: <20250730032312.167062-3-yubowen8@huawei.com>
 <4955be6b-9806-4f73-8618-1d8de7d3a9dc@web.de>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <4955be6b-9806-4f73-8618-1d8de7d3a9dc@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 31/07/2025 02:38, Markus Elfring wrote:
>> Perf counters could be 0 if the cpu is in a low-power idle state. Just try
>> it again next time and update the frequency scale when the cpu is active
>> and perf counters successfully return.
>>
>> Also, remove the FIE source on an actual failure.
> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n145
> 
> Regards,
> Markus

Hi Markus,

We don't think it's necessarily a bugfix that should be backported to
old/stable kernels.  This is mainly an extra error handling for cases that
may happen on our platform when a CPU is in a deep idle state.

Similar patches were merged before.
https://lore.kernel.org/linux-pm/20240929033214.1039485-2-zhanjie9@hisilicon.com/

Perhaps the 'Fix' in the patch title is a bit misleading.  I'll write a
more appropriate patch description in the following version.

Thanks,
Jie

