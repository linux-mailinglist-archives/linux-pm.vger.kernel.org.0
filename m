Return-Path: <linux-pm+bounces-29079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A747AAE0873
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C708817C977
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613F212B2B;
	Thu, 19 Jun 2025 14:18:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054D1EE7D5
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342695; cv=none; b=pfWdX7LmClWawpYXArzL3LbFINSEyqy/fX7nY69c96Tr27qo6YxMJNn2wW2SJS9klKCAH0WqANFwl14l11wDug7G/xicQ71dvSz3d+sDBb0jaCXGuiA2JUUKQOp4nThKpIg+ok1COMMH4lIw9kPQ73DKZnG/gwxzRinha8wi3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342695; c=relaxed/simple;
	bh=gEDTyiDi8UBGaUgIEUcuLEXa+HdzbE9hOfzPmoQ0dLM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=oALk3lRPB1YXtad+F+qnSsAI0RKGiRiBCQQ64DwO9bUacAmpcKjzVOgS6lkXCSzi5CBgFJsZYSRF7QCWMGw8XZbH6ZuvI+PddPLmOEpO+rU258RMIjZH2XkjYmDGuiBNW6YpuUgc+yzNOKc9jF5BhCYZQQ4/F/fiOUvx1/hPqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bNN2Q6QcHz27g4P;
	Thu, 19 Jun 2025 22:16:30 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 69AF71400D3;
	Thu, 19 Jun 2025 22:18:01 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Jun
 2025 22:18:00 +0800
Message-ID: <246d0247-2cca-dae0-827e-c20174bd3f49@hisilicon.com>
Date: Thu, 19 Jun 2025 22:18:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From: Jie Zhan <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v4 2/2] PM / devfreq: Add HiSilicon uncore frequency
 scaling driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <linuxarm@huawei.com>
CC: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <alireza.sanaee@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<liwei728@huawei.com>, <prime.zeng@hisilicon.com>
References: <20250530081722.280776-1-zhanjie9@hisilicon.com>
 <20250530081722.280776-3-zhanjie9@hisilicon.com>
 <20250616103447.000024dd@huawei.com>
In-Reply-To: <20250616103447.000024dd@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100006.china.huawei.com (7.202.195.47)



On 16/06/2025 17:35, Jonathan Cameron wrote:
> On Fri, 30 May 2025 16:17:22 +0800
> Jie Zhan <zhanjie9@hisilicon.com> wrote:
> 
>> Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
>> the devfreq framework.  The uncore domain contains shared computing
>> resources, including system interconnects and L3 cache.  The uncore
>> frequency significantly impacts the system-wide performance as well as
>> power consumption.  This driver adds support for runtime management of
>> uncore frequency from kernel and userspace.  The main function includes
>> setting and getting frequencies, changing frequency scaling policies, and
>> querying the list of CPUs whose performance is significantly related to
>> this uncore frequency domain, etc.  The driver communicates with a platform
>> controller through an ACPI PCC mailbox to take the actual actions of
>> frequency scaling.
>>
>> Co-developed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Hi Zhanjie,
> 
> A few comments inline.  In general nice and clean.
> 
> I think only one that really needs a change it the one around the
> CPU association firmware handling.
> 
> Jonathan
> 
Thanks again!

All accepted, except for the cleanup of putting devm_add_action_or_reset()
before opp_add().

See inline replies below.

Jie

> 
>> ---
>>  Documentation/ABI/testing/sysfs-class-devfreq |   9 +
>>  drivers/devfreq/Kconfig                       |  11 +
>>  drivers/devfreq/Makefile                      |   1 +
>>  drivers/devfreq/hisi_uncore_freq.c            | 656 ++++++++++++++++++
>>  4 files changed, 677 insertions(+)
>>  create mode 100644 drivers/devfreq/hisi_uncore_freq.c
>>

>> +		rc = dev_pm_opp_add(dev, freq_mhz * HZ_PER_MHZ, 1000000);
>> +		if (rc) {
>> +			dev_pm_opp_remove_all_dynamic(dev);
>> +			return dev_err_probe(dev, rc,
>> +				"Add OPP %lu failed\n", freq_mhz);
>> +		}
>> +	}
>> +
>> +	return devm_add_action_or_reset(dev, devm_hisi_uncore_remove_opp, uncore);
> Hmm. I'm normally a fan of registering these after the calls, but this is one
> of the rare cases where pushing it before (with a comment) cleans up the code.
> 
> If you do that, then all the error cases in the loop just need to return and not
> call the cleanup manually.
I'd prefer to keep the current order so as to keep logic and style
consistent across places where devm_add_action is used.  It would be easier
for people to follow.
> 
...
>> +static int hisi_uncore_mark_related_cpus(struct hisi_uncore_freq *uncore,
>> +				 char *property, int (*get_topo_id)(int cpu),
>> +				 const struct cpumask *(*get_cpumask)(int cpu))
>> +{
>> +	unsigned int i, cpu;
>> +	size_t len;
>> +	int rc;
>> +
>> +	rc = device_property_count_u32(uncore->dev, property);
>> +	if (rc < 0)
>> +		return rc;
> Most of the errors here don't reflect it not being found and are things
> were we should probably fail the driver probe (so someone can fix whatever
> is wrong with the firmware.)  I think only -EINVAL means not here
> (technically arguments are not valid)
> 

Thanks for spotting this.

Had a dig.

In the case here:
rc > 0, success, rc is the number of elements in this property.
rc == 0, property found but no elements in it, the firmware might have a
property without values.
rc == -EINVAL, property not found, or invalid arguments received in any of
the subroutine, e.g. NULL pointer.
rc < 0 && rc != -EINVAL, firmware probably broken.

I think we can take 0 and -EINVAL as not found, and try the other property
name.  If rc == 0, the firmware might just have some redundant code, not a
big issue.  If rc == -EINVAL, it's likely that the property is not found
unless some data go wrong and make arguments invalid.

Other negative error codes should fail the driver probe.

The device_property_read_u32_array() below is similar.
I'll put this in comments and update hisi_uncore_mark_related_cpus_wrap().
This function doesn't need to change.

>> +	if (rc == 0)
>> +		return -EINVAL;
>> +
>> +	len = rc;
>> +	u32 *num __free(kfree) = kcalloc(len, sizeof(*num), GFP_KERNEL);
>> +	if (!num)
>> +		return -ENOMEM;
> 

...

>> +static int hisi_uncore_devfreq_register(struct hisi_uncore_freq *uncore)
>> +{
>> +	struct devfreq_dev_profile *profile;
>> +	struct device *dev = uncore->dev;
>> +	unsigned long freq;
>> +	u32 data;
>> +	int rc;
>> +
>> +	rc = hisi_uncore_get_cur_freq(dev, &freq);
> One for another day:
> Whilst we do indeed need to do this, it seems like a small optimization to
> devfreq would be to check for initial_freq == 0 and if it is try get_cur_freq()
> after registration. Mind you I checked and this only seems to apply to
> the imx drivers and this one.
> 
Yeah, understood.
Let's check and improve that later.

