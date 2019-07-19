Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025C56D806
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 02:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfGSA7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 20:59:03 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47121 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfGSA7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 20:59:03 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190719005858epoutp04df956621347ebafdf32b234440b0f75a~yqRdSjhqv0969709697epoutp04c
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 00:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190719005858epoutp04df956621347ebafdf32b234440b0f75a~yqRdSjhqv0969709697epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563497938;
        bh=aeL5K6hO1Ww0ITOd2OOw8yicQFDZbATYOFExm26xgGE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KXi1aLL8ymo2hzDb3PUwH3GWT3I9XGHJdfnvwkgnr0GiBhrTXjbxEepnAaWdrkzlq
         GCKUBlwykhDyOUpo9N1Hst8ikHYAEzKvxSzLfof1NsWi+dhbb1trcZoNg3Jkwcdass
         ALic1SLbBEer4g7Vvsm9AjwtnfB/ZupwJE/5Ja9Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190719005857epcas1p4805d6709c61649d3387bd6ccf8d08a9d~yqRcu0WyL1663716637epcas1p4X;
        Fri, 19 Jul 2019 00:58:57 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45qXgz5RCpzMqYlm; Fri, 19 Jul
        2019 00:58:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.88.04085.BC5113D5; Fri, 19 Jul 2019 09:58:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719005850epcas1p16122ecc9591d3ee91cea29f8fd62af5e~yqRWOa77u2970029700epcas1p18;
        Fri, 19 Jul 2019 00:58:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719005850epsmtrp221e10e8c0d2ba280d33fad716f45fb1b~yqRWNoogf1688316883epsmtrp2j;
        Fri, 19 Jul 2019 00:58:50 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-19-5d3115cb9490
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.E0.03706.AC5113D5; Fri, 19 Jul 2019 09:58:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719005850epsmtip222d43257c50d4f512a48d90ac50dbf0f~yqRV-xhpj2068620686epsmtip28;
        Fri, 19 Jul 2019 00:58:50 +0000 (GMT)
Subject: Re: [PATCH v4 17/24] PM / devfreq: tegra30: Use tracepoints for
 debugging
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ffa24275-4499-c27a-8c60-a5f4d738913c@samsung.com>
Date:   Fri, 19 Jul 2019 10:01:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719034938.6382f989@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmru5pUcNYgyNbRSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ6zadJGp4E5Axas7NxkbGK86dTFyckgImEgsOXCcvYuRi0NIYAejxIp9
        q5kgnE+MEgs+NUJlvjFKbG+bxwjT8uv9STaIxF5GiY7zx5hBEkIC7xklfh/36WLk4BAWCJHY
        Pc0dJCwioCax/OgfVpB6ZoGNTBLHN6xhAkmwCWhJ7H9xgw3E5hdQlLj64zHYAl4BO4k7K96y
        g9gsAqoSrz6cAasRFYiQ+PTgMCtEjaDEyZlPWEBsTgE9iYdTn4PVMAuIS9x6Mp8JwpaXaN46
        mxlksYTAfzaJfxeboD5wkXg6bR4rhC0s8er4FnYIW0ri87u9bBB2tcTKk0fYIJo7GCW27L8A
        1WAssX/pZCaQL5kFNCXW79KHCCtK7Pw9lxFiMZ/Eu689rCAlEgK8Eh1tQhAlyhKXH9xlgrAl
        JRa3d7JNYFSaheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBFju1NjODEqmW5g/HYOZ9D
        jAIcjEo8vAG5BrFCrIllxZW5hxglOJiVRHhvv9SPFeJNSaysSi3Kjy8qzUktPsRoCgzticxS
        osn5wKSfVxJvaGpkbGxsYWJoZmpoqCTOO++PZqyQQHpiSWp2ampBahFMHxMHp1QDY1BJxt6e
        jyqbItlXTLtxhEvaqWtyatHFxP6IGYsqTyVy/+0ySgmTmJMaq2ty2OPm98L2Due7hzIXPcxb
        nvhsTcysc+vnPL79Jq5scbQet/Wv5K5FXh5nJzhqT0p4/a7u647/SW+37nvdvTOg+5e6+nPT
        dXH2Vd8TnuRpRpkqb/mTorN0uc6VW0osxRmJhlrMRcWJAPhfVMHCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvO4pUcNYg/UflC1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyVm26yFRwJ6Di1Z2bjA2MV526GDk5JARMJH69
        P8nWxcjFISSwm1HiatsKZoiEpMS0i0eBbA4gW1ji8OFiiJq3jBJ9R94ygsSFBUIkdk9zBykX
        EVCTWH70DytIDbPAZiaJs6dWQw3tZQIaegNsKJuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2EndW
        vGUHsVkEVCVefTgDViMqECFxeMcsqBpBiZMzn7CA2JwCehIPpz4Hq2EWUJf4M+8SM4QtLnHr
        yXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al
        6yXn525iBMeYluYOxstL4g8xCnAwKvHwBuQaxAqxJpYVV+YeYpTgYFYS4b39Uj9WiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBkbOrQdteL4Fb62faCO9
        927tmt5Su4lmzDqhuXeOBIiu/rrd587EPZwVjxvEOTd3fFTnaYw0l5sRomTyvLu2aX71CmOL
        Sd7dPA6zlvN+sTjIHqDUL7IzLvuPZOF015ffFVzdvOL+z7Y7J5bEWcUkt+DrtGurrk+K2fSu
        7TvffIX0/DnzvvFn+SuxFGckGmoxFxUnAgC+5t/xrQIAAA==
X-CMS-MailID: 20190719005850epcas1p16122ecc9591d3ee91cea29f8fd62af5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223623epcas4p13d01a60ae2b88dde4c4f7fdba04da170
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223623epcas4p13d01a60ae2b88dde4c4f7fdba04da170@epcas4p1.samsung.com>
        <20190707223303.6755-18-digetx@gmail.com>
        <209220ec-b677-3500-0e55-6cad57e97f88@samsung.com>
        <20190719034938.6382f989@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 9:49, Dmitry Osipenko wrote:
> В Thu, 18 Jul 2019 18:47:09 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>> Debug messages create too much CPU and memory activity by
>>> themselves, so it's difficult to debug lower rates and catch
>>> unwanted interrupts that happen rarely. Tracepoints are ideal in
>>> that regards because they do not contribute to the sampled date at
>>> all. This allowed me to catch few problems which are fixed by the
>>> followup patches, without tracepoints it would be much harder to do.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c      |  43 +++-------
>>>  include/trace/events/tegra30_devfreq.h | 105
>>> +++++++++++++++++++++++++ 2 files changed, 117 insertions(+), 31
>>> deletions(-) create mode 100644
>>> include/trace/events/tegra30_devfreq.h  
>>
>> As I knew, 'include/trace/events' don't include the header file
>> for only one device driver. Usually, the trace event is provided
>> by framework instead of each devic driver.
> 
> There are at least trace headers there for the tegra-apbdma,
> tegra-host1x, intel-sst and intel-ish devices. I don't think that there
> is a strict rule for the trace headers placement.

OK.

But, As I already replied on patch4, if you want to show the register dump,
you better to add the debugfs feature to devfreq framework for showing
the register dump instead of printing the register dump with debug level
and this trace event. 

As I said, just register dump is not useful for all developers.
Almost developer cannot understand the meaning of debug log for register dump.

Also, it is not proper way that front patch adds the some code
and then later patch removes the additional code in the same series.
Before sending the patches, you can renew them.

> 
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c index
>>> 6ebf0f505767..43c9c5fbfe91 100644 ---
>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>> b/drivers/devfreq/tegra30-devfreq.c @@ -19,6 +19,9 @@
>>>  #include <linux/reset.h>
>>>  #include <linux/workqueue.h>
>>>  
>>> +#define CREATE_TRACE_POINTS
>>> +#include <trace/events/tegra30_devfreq.h>
>>> +
>>>  #include "governor.h"
>>>  
>>>  #define ACTMON_GLB_STATUS
>>> 0x0 @@ -283,9 +286,6 @@ static void
>>> tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, unsigned
>>> long *lower, unsigned long *upper)
>>>  {
>>> -	struct device *ddev = tegra->devfreq->dev.parent;
>>> -	u32 offset = dev->config->offset;
>>> -
>>>  	/*
>>>  	 * Memory frequencies are guaranteed to have 1MHz
>>> granularity
>>>  	 * and thus we need this rounding down to get a proper
>>> watermarks @@ -298,8 +298,8 @@ static void
>>> tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, *lower =
>>> tegra_actmon_lower_freq(tegra, target_freq); *upper =
>>> tegra_actmon_upper_freq(tegra, target_freq); 
>>> -	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper
>>> freq %lu\n",
>>> -		offset, target_freq, *lower, *upper);
>>> +	trace_device_lower_upper(dev->config->offset, target_freq,
>>> +				 *lower, *upper);
>>>  
>>>  	/*
>>>  	 * The upper watermark should take into account CPU's
>>> frequency @@ -377,30 +377,13 @@ static void
>>> tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>> device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK); }
>>>  
>>> -static void actmon_device_debug(struct tegra_devfreq *tegra,
>>> -				struct tegra_devfreq_device *dev,
>>> -				const char *prefix)
>>> -{
>>> -	dev_dbg(tegra->devfreq->dev.parent,
>>> -		"%03x: %s: 0x%08x 0x%08x a %u %u %u c %u %u %u b
>>> %lu cpu %u\n",
>>> -		dev->config->offset, prefix,
>>> -		device_readl(dev, ACTMON_DEV_INTR_STATUS),
>>> -		device_readl(dev, ACTMON_DEV_CTRL),
>>> -		device_readl(dev, ACTMON_DEV_AVG_COUNT),
>>> -		device_readl(dev, ACTMON_DEV_AVG_LOWER_WMARK),
>>> -		device_readl(dev, ACTMON_DEV_AVG_UPPER_WMARK),
>>> -		device_readl(dev, ACTMON_DEV_COUNT),
>>> -		device_readl(dev, ACTMON_DEV_LOWER_WMARK),
>>> -		device_readl(dev, ACTMON_DEV_UPPER_WMARK),
>>> -		dev->boost_freq, cpufreq_get(0));
>>> -}
>>> -
>>>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>>>  			      struct tegra_devfreq_device *dev)
>>>  {
>>>  	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
>>>  
>>> -	actmon_device_debug(tegra, dev, "isr+");
>>> +	trace_device_isr_enter(tegra->regs, dev->config->offset,
>>> +			       dev->boost_freq, cpufreq_get(0));
>>>  
>>>  	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
>>>  	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>>> @@ -455,7 +438,8 @@ static void actmon_isr_device(struct
>>> tegra_devfreq *tegra, device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
>>>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>>> ACTMON_DEV_INTR_STATUS); 
>>> -	actmon_device_debug(tegra, dev, "isr-");
>>> +	trace_device_isr_exit(tegra->regs, dev->config->offset,
>>> +			      dev->boost_freq, cpufreq_get(0));
>>>  }
>>>  
>>>  static unsigned long actmon_update_target(struct tegra_devfreq
>>> *tegra, @@ -749,7 +733,6 @@ static struct devfreq_dev_profile
>>> tegra_devfreq_profile = { static int
>>> tegra_governor_get_target(struct devfreq *devfreq, unsigned long
>>> *freq) {
>>> -	struct device *ddev = devfreq->dev.parent;
>>>  	struct devfreq_dev_status *stat;
>>>  	struct tegra_devfreq *tegra;
>>>  	struct tegra_devfreq_device *dev;
>>> @@ -770,13 +753,11 @@ static int tegra_governor_get_target(struct
>>> devfreq *devfreq, dev = &tegra->devices[i];
>>>  
>>>  		dev_target_freq = actmon_update_target(tegra, dev);
>>> -
>>>  		target_freq = max(target_freq, dev_target_freq);
>>>  
>>> -		dev_dbg(ddev, "%03x: upd: dev_target_freq %lu\n",
>>> -			dev->config->offset, dev_target_freq);
>>> -
>>> -		actmon_device_debug(tegra, dev, "upd");
>>> +		trace_device_target_freq(dev->config->offset,
>>> dev_target_freq);
>>> +		trace_device_target_update(tegra->regs,
>>> dev->config->offset,
>>> +					   dev->boost_freq,
>>> cpufreq_get(0)); }
>>>  
>>>  	*freq = target_freq;
>>> diff --git a/include/trace/events/tegra30_devfreq.h
>>> b/include/trace/events/tegra30_devfreq.h new file mode 100644
>>> index 000000000000..8f264a489daf
>>> --- /dev/null
>>> +++ b/include/trace/events/tegra30_devfreq.h
>>> @@ -0,0 +1,105 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#undef TRACE_SYSTEM
>>> +#define TRACE_SYSTEM tegra30_devfreq
>>> +
>>> +#if !defined(_TRACE_TEGRA30_DEVFREQ_H) ||
>>> defined(TRACE_HEADER_MULTI_READ) +#define _TRACE_TEGRA30_DEVFREQ_H
>>> +
>>> +#include <linux/io.h>
>>> +#include <linux/tracepoint.h>
>>> +#include <linux/types.h>
>>> +
>>> +DECLARE_EVENT_CLASS(device_state,
>>> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
>>> cpufreq),
>>> +	TP_ARGS(base, offset, boost, cpufreq),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, offset)
>>> +		__field(u32, intr_status)
>>> +		__field(u32, ctrl)
>>> +		__field(u32, avg_count)
>>> +		__field(u32, avg_lower)
>>> +		__field(u32, avg_upper)
>>> +		__field(u32, count)
>>> +		__field(u32, lower)
>>> +		__field(u32, upper)
>>> +		__field(u32, boost_freq)
>>> +		__field(u32, cpu_freq)
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->offset		= offset;
>>> +		__entry->intr_status	= readl_relaxed(base +
>>> offset + 0x24);
>>> +		__entry->ctrl		= readl_relaxed(base
>>> + offset + 0x0);
>>> +		__entry->avg_count	= readl_relaxed(base +
>>> offset + 0x20);
>>> +		__entry->avg_lower	= readl_relaxed(base +
>>> offset + 0x14);
>>> +		__entry->avg_upper	= readl_relaxed(base +
>>> offset + 0x10);
>>> +		__entry->count		= readl_relaxed(base
>>> + offset + 0x1c);
>>> +		__entry->lower		= readl_relaxed(base
>>> + offset + 0x8);
>>> +		__entry->upper		= readl_relaxed(base
>>> + offset + 0x4);
>>> +		__entry->boost_freq	= boost;
>>> +		__entry->cpu_freq	= cpufreq;
>>> +	),
>>> +	TP_printk("%03x: intr 0x%08x ctrl 0x%08x avg %010u %010u
>>> %010u cnt %010u %010u %010u boost %010u cpu %u",
>>> +		__entry->offset,
>>> +		__entry->intr_status,
>>> +		__entry->ctrl,
>>> +		__entry->avg_count,
>>> +		__entry->avg_lower,
>>> +		__entry->avg_upper,
>>> +		__entry->count,
>>> +		__entry->lower,
>>> +		__entry->upper,
>>> +		__entry->boost_freq,
>>> +		__entry->cpu_freq)
>>> +);
>>> +
>>> +DEFINE_EVENT(device_state, device_isr_enter,
>>> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
>>> cpufreq),
>>> +	TP_ARGS(base, offset, boost, cpufreq));
>>> +
>>> +DEFINE_EVENT(device_state, device_isr_exit,
>>> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
>>> cpufreq),
>>> +	TP_ARGS(base, offset, boost, cpufreq));
>>> +
>>> +DEFINE_EVENT(device_state, device_target_update,
>>> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
>>> cpufreq),
>>> +	TP_ARGS(base, offset, boost, cpufreq));
>>> +
>>> +TRACE_EVENT(device_lower_upper,
>>> +	TP_PROTO(u32 offset, u32 target, u32 lower, u32 upper),
>>> +	TP_ARGS(offset, target, lower, upper),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, offset)
>>> +		__field(u32, target)
>>> +		__field(u32, lower)
>>> +		__field(u32, upper)
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->offset = offset;
>>> +		__entry->target = target;
>>> +		__entry->lower = lower;
>>> +		__entry->upper = upper;
>>> +	),
>>> +	TP_printk("%03x: freq %010u lower freq %010u upper freq
>>> %010u",
>>> +		__entry->offset,
>>> +		__entry->target,
>>> +		__entry->lower,
>>> +		__entry->upper)
>>> +);
>>> +
>>> +TRACE_EVENT(device_target_freq,
>>> +	TP_PROTO(u32 offset, u32 target),
>>> +	TP_ARGS(offset, target),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, offset)
>>> +		__field(u32, target)
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->offset = offset;
>>> +		__entry->target = target;
>>> +	),
>>> +	TP_printk("%03x: freq %010u", __entry->offset,
>>> __entry->target) +);
>>> +#endif /* _TRACE_TEGRA30_DEVFREQ_H */
>>> +
>>> +/* This part must be outside protection */
>>> +#include <trace/define_trace.h>
>>>   
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
