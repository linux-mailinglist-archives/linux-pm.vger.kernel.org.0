Return-Path: <linux-pm+bounces-25501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F8A8AE58
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 05:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBB3189E91D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4F227B83;
	Wed, 16 Apr 2025 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WJ9yoUEr"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1614B08E;
	Wed, 16 Apr 2025 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744772713; cv=none; b=H5PE3sCqrAIjQHGxnNiVmdEVfwuLRz+GmqGiNvMiAHxc83wMXkadpU+GQtityRwyNLZpW2wrrRPKbKmWTQ19rqiNdmnUDc5weMfTqfBZfBE3vFSEZUCysBjiVUFoFZL9jmEhXVk/riTsYIqAlRXMUuNHWKHZRtjHUse44M3zvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744772713; c=relaxed/simple;
	bh=EJVUI9KSvQfQwUCZePCOhcJz4E1p4vOGAWLbEepgnTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbiMdgK5+OXQL5+EkQ5D8GEDzBEJdfCJtEF0TGd+id/m0k6KkCORmbQCGNzW0MVLPhvaJOYMrRJcINXC9YvnlgWlH8p+wiRvmo6CG3m3aOK8iBd05XiXsUgb1n6IFedWbBP2UHQs3p8hh/uNY1oMosHuR84y8uBFOjuH2SPvWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WJ9yoUEr; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744772705; bh=hAWduTvr0sJAnXhsLn2DSAj0wDfYHSVg47D65kJ4tQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WJ9yoUErHNaXDk0FB5qfhChc/N3OMfUiA1Ntk0Myj6MZIkuyxD4tXU5AhpaAvcEKH
	 gH1bcoZrM1NIlGBiWDfsuTOYKa8WKOkPhUVG/vfEyah9wPERG3a/osSffhColruaFw
	 hpHCKDGWwuDAWO98M8uUPTmv7JNMBjQUGQQgBnEA=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id E2C1BEA6; Wed, 16 Apr 2025 10:56:44 +0800
X-QQ-mid: xmsmtpt1744772204tma6pjlhf
Message-ID: <tencent_8E3A87C6D6A193F757BA846F0C41887CC405@qq.com>
X-QQ-XMAILINFO: OUUXHEo9i1uk26ueGppu7GY2aV/A+sCMmnRPkhBh0ngRNdwXQTQh+Y3KrHjQdk
	 +xpMvJ4U6N7PrzocNH39CzKLyrEaEQn7JDX3oN6/XhzerTEEyvqsbmfcJukd/+s1BPtaxB37yGQ2
	 IdNA/5kPWbf2QXiLSmVqZyNngok+FjCcGvkg81zUtdvKfg9stej8NO1jeLpeNnyIJE4hpBo+h+oP
	 S+7+RJtH51rlGEdj2au7L9BDw9f+rrc4qOrdyV/h16I/rV419e10YTdbha0wLIaMKCBVyyQaBvN9
	 vxlskQiFYqk2US9LZbQAUJfGk6xbOBBCeYZqnHKCzr76zjCmcxHYwFrj46XGv58WqM7PEM+nmHdH
	 nx1DC5fIFxsAlDVDydd3QUyR07BVZ4vkwnr3z0KSgcm8cTEKhEcylPRvpezBA2rSnyW5Hlvo1xvN
	 Ym16CvrbVWGkh1ualHBsRNhIBBYAdr2PGlp1z1N1xq9wzGsDXx/Pkx7OdSt1+8Qzz1PxTrTeVvgO
	 Cnj/IZ82udEWOEoLq6ilCDd2EFYrP7XYx/FuvmiTMjNErVOCGHHZk7lcX7YYnTR9eG27TnB6v/ff
	 d+2to97fLmSiGJIgvoxkY870VyQ//py+vwOZa2j8KKKJ/NMqzHquasQgqSpf86ZirGrv/GThIHTL
	 PPiD+prEmtom/1Ta0Hm/DOkvSqLwNpqC7xCdyO0c3syv4zxts5xY1KhnM9vtbOJD7mGySUaPl6op
	 qEDUJoCYJL3Jj0dQOee6Ay4Jf9iGehICuwMFnWN9eWAL5cwEiU6PBoxBl9Pq4lnAE9gZ0ddlEvjz
	 9847I+9G+HUQQxDeAM8hqHQXVpCYxv48Cqn5d58VVOx06Fa4ImLH5dKif7fVNEC1uMlqwpaGo8tv
	 oRCkOF8rurXLu3vHwKIj1vxFOODJOAK7x8TxSDvLe1FsuMP6vDzutOG97npU1W+S+b8ljBIreL25
	 us1fOGBvvm8j0zkmuHPCbHgQ0nW3H6DsS6uuQuDkg=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <056eb78e-7d1f-446c-a2a6-03ee1cc16a46@qq.com>
Date: Wed, 16 Apr 2025 10:56:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
 <CAJZ5v0iE_iw+pSBppEWnJw=2=DFNa-J2VPDorTNF=Mve+0PNCg@mail.gmail.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <CAJZ5v0iE_iw+pSBppEWnJw=2=DFNa-J2VPDorTNF=Mve+0PNCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/16 01:17, Rafael J. Wysocki 写道:
> On Mon, Apr 14, 2025 at 11:09 AM Yaxiong Tian <iambestgod@qq.com> wrote:
>>
>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>
>> When the device is of a non-CPU type, table[i].performance won't be
>> initialized in the previous em_init_performance(), resulting in division
>> by zero when calculating costs in em_compute_costs().
>>
>> Since the 'cost' algorithm is only used for EAS energy efficiency
>> calculations and is currently not utilized by other device drivers, we
>> should add the _is_cpu_device(dev) check to prevent this division-by-zero
>> issue.
>>
>> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")
> 
> Please look at the Fixes: tags in the kernel git history.  They don't
> look like the one above.
> 
Yes, there's an extra '<>' here.

>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   kernel/power/energy_model.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index d9b7e2b38c7a..fc972cc1fc12 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -235,7 +235,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>
>>          /* Compute the cost of each performance state. */
>>          for (i = nr_states - 1; i >= 0; i--) {
>> -               unsigned long power_res, cost;
>> +               unsigned long power_res, cost = 0;
>>
>>                  if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>>                          ret = cb->get_cost(dev, table[i].frequency, &cost);
>> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>                                          cost, ret);
>>                                  return -EINVAL;
>>                          }
>> -               } else {
>> +               } else if (_is_cpu_device(dev)) {
> 
> Can't you just check this upfront at the beginning of the function and
> make it bail out if dev is not a CPU device?
> 
Sure, But the current implementation applies em_compute_costs() to both 
non-CPU devices and CPU devices. After carefully reviewing the latest code,
I've found this issue has expanded in scope.

There are currently three call paths for invoking em_compute_costs():

1) Registering performance domains (for both non-CPU and CPU devices)
em_dev_register_perf_domain() → em_create_pd() →
em_create_perf_table() → em_compute_costs()

2)EM update paths (CPU devices only)

Periodic 1000ms update check via em_update_work work item:
em_check_capacity_update() → em_adjust_new_capacity() → 
em_recalc_and_update() → em_compute_costs()

Exynos-chip initialization:
em_dev_update_chip_binning() → em_recalc_and_update() → em_compute_costs()

3) Device cost computation (non-CPU devices only - currently unused)
em_dev_compute_costs() → em_compute_costs()

Note: In em_dev_compute_costs(), when calling em_compute_costs(),
neither the callback (cb) nor flags are set.In fact, it either does
nothing at all or performs incorrect operations.

Therefore, should we mandate that non-CPU devices must provide a
get_cost callback?

So Should we add a check at the beginning of the em_compute_costs() to:

	if (!_is_cpu_device(dev) && !cb->get_cost) {
		dev_dbg(dev, "EM: No get_cost provided, cost unset.\n");
		return 0;
	}
And Modify em_dev_compute_costs() to require callers to provide the cb
callback function,Also need to update its corresponding comments.


>>                          /* increase resolution of 'cost' precision */
>>                          power_res = table[i].power * 10;
>>                          cost = power_res / table[i].performance;
>> --


