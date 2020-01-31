Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C356714E6A8
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 01:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgAaAez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 19:34:55 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:13532 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgAaAez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 19:34:55 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200131003453epoutp013f72d31a494f4a638391f07c2a1f58d5~u0YYdmCAo0369803698epoutp01y
        for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2020 00:34:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200131003453epoutp013f72d31a494f4a638391f07c2a1f58d5~u0YYdmCAo0369803698epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580430893;
        bh=brwn78jwLzLuVOvoyMiy5BVX1bbvj0BHTtZDjVXakV8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qNMLRCuaXlONwCDdt396FRPqm7Og4FY0oyq4pqbdc9dXFp48aU/2RkiLp5qJdDklg
         Crwy5l32hSBxNY+b0q62h05yf/bMW5nxqDiqcEWzpg4Xppcl2y/5RRJYet9WuIehYj
         GPOgQ/Z71UhlWUsE8oGcxCABqxz8RtiMAPhgUzyE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200131003452epcas1p1241338931aa3ce5c7c633be656dc6c43~u0YX4Hnwn1054610546epcas1p1M;
        Fri, 31 Jan 2020 00:34:52 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 487ysj3L0dzMqYkW; Fri, 31 Jan
        2020 00:34:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.DB.48498.826733E5; Fri, 31 Jan 2020 09:34:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200131003447epcas1p39ff91263b2c1a2e2f32f092e2270a3f7~u0YTL3SCD2490924909epcas1p3I;
        Fri, 31 Jan 2020 00:34:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200131003447epsmtrp11a640c7108e9e3bccfdccd21e03c5d93~u0YTLD-8w2468424684epsmtrp1d;
        Fri, 31 Jan 2020 00:34:47 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-8b-5e3376282f72
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.3F.06569.726733E5; Fri, 31 Jan 2020 09:34:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200131003447epsmtip19aed023ca766329da4fb605b5d55b89e~u0YS-rWLj1596415964epsmtip1J;
        Fri, 31 Jan 2020 00:34:47 +0000 (GMT)
Subject: Re: [PATCH 0/1] drivers: devfreq: use DELAYED_WORK in DEVFREQ
 monitoring subsystem
To:     Lukasz Luba <lukasz.luba@arm.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, Kamil Konieczny <k.konieczny@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com>
Date:   Fri, 31 Jan 2020 09:42:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <b4d1624f-4ca8-c985-ff42-f5f677c72fa9@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmga5GmXGcwZ5uQYuNM9azWiz4NIPV
        4mzTG3aLy7vmsFl87j3CaLGwqYXd4nbjCjYHdo8189YwevRtWcXo8XmTXABzVLZNRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtByJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xoF939kKbqpU
        nJu0hq2BcalcFyMnh4SAicSbvka2LkYuDiGBHYwS769sZodwPjFKXDn4gxXC+cYocW7eLiaY
        luv/TkIl9jJKHHw3jxkkISTwnlFi1jUeEFtYIFZiy+RjYHNFBKYxSnw6MosRJMEs4C4xr/U5
        WAObgJbE/hc32EBsfgFFias/HoPV8ArYSczpvAS0gYODRUBVYv8fC5CwqECYxMltLVAlghIn
        Zz5hAbE5BawlPjUeY4UYLy5x68l8JghbXqJ562xmiKMfs0nsXpkBYbtINC9eww5hC0u8Or4F
        ypaSeNnfBmVXS6w8eQTsfgmBDkaJLfsvsEIkjCX2L53MBHIbs4CmxPpd+hBhRYmdv+dCvcgn
        8e5rD9j5EgK8Eh1tQhAlyhKXH9yFhqGkxOL2TrYJjEqzkHwzC8kHs5B8MAth2QJGllWMYqkF
        xbnpqcWGBUbIkb2JEZwutcx2MC4653OIUYCDUYmH1+OMUZwQa2JZcWXuIUYJDmYlEV5RV8M4
        Id6UxMqq1KL8+KLSnNTiQ4ymwLCeyCwlmpwPTOV5JfGGpkbGxsYWJoZmpoaGSuK8DyM144QE
        0hNLUrNTUwtSi2D6mDg4pRoY16iUn/vx9GLXx0mVFpuXf3qve/Z1ZZH4vIhDqzdwTXyTEWu0
        e9n7jn3MrHHr+VQSeLy+ff1c+SvOcpa5mtAFnaw3rgwhnhYxbxQWfMqs+vVS4fSpI2abV76Z
        WBhRMzn/sNy9f3xdE2KmRs+IXuck0WBtFWKYf6GQ+Ur/LUvPukXanlzJSywPKbEUZyQaajEX
        FScCAAkgP2WtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTle9zDjOoPuQlMXGGetZLRZ8msFq
        cbbpDbvF5V1z2Cw+9x5htFjY1MJucbtxBZsDu8eaeWsYPfq2rGL0+LxJLoA5issmJTUnsyy1
        SN8ugSvjwL7vbAU3VSrOTVrD1sC4VK6LkZNDQsBE4vq/k6xdjFwcQgK7GSV2vFrPApGQlJh2
        8ShzFyMHkC0scfhwMUTNW0aJppvH2UFqhAViJbZMPsYGkhARmMYosXblcrBmZgF3iXmtz5kh
        OvYwSnR/3gfWwSagJbH/xQ02EJtfQFHi6o/HjCA2r4CdxJzOS6wg21gEVCX2/7EACYsKhEns
        XPKYCaJEUOLkzCdg8zkFrCU+NR5jhdilLvFn3iVmCFtc4taT+UwQtrxE89bZzBMYhWchaZ+F
        pGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjh0trR2MJ07EH2IU
        4GBU4uH1OGMUJ8SaWFZcmXuIUYKDWUmEV9TVME6INyWxsiq1KD++qDQntfgQozQHi5I4r3z+
        sUghgfTEktTs1NSC1CKYLBMHp1QDYwLDlY9W/xpM1q25uLDkwx8z5clcGuU6n+a1vJhju7L3
        5REJ4ZSjIToi/+dYib/yPPU7dKqBrGStdl3P3Hcfo2I0hJ+t+H1Xmv+sjUVWnOoz0/pIdlOR
        1U2HF3m2S4cfZc0J5PtdvX77/MdRN1JKtwgH9qgnT3q1X7X52P2Ldw02HVkYwX13hRJLcUai
        oRZzUXEiAPMr7A2ZAgAA
X-CMS-MailID: 20200131003447epcas1p39ff91263b2c1a2e2f32f092e2270a3f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200130114724epcas1p1b2a9ea756c7d53a2f26b60abbef0ab51
References: <20200127151731.8640-1-lukasz.luba@arm.com>
        <CGME20200130114724epcas1p1b2a9ea756c7d53a2f26b60abbef0ab51@epcas1p1.samsung.com>
        <b4d1624f-4ca8-c985-ff42-f5f677c72fa9@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 1/30/20 8:47 PM, Lukasz Luba wrote:
> Hi Chanwoo, MyungJoo,
> 
> Gentle ping. The issue is not only in the devfreq itself,
> but also it affects thermal. The devfreq cooling rely on
> busy_time and total_time updated by the devfreq monitoring
> (in simple_ondemand).
> Thermal uses DELAYED_WORK and is more reliable, but uses stale
> data from devfreq_dev_stats. It is especially visible when
> you have cgroup spanning one cluster. Android uses cgroups
> heavily. You can make easily this setup using 'taskset',
> run some benchmarks and observe 'devfreq_monitor' traces and
> timestamps, i.e. for your exynos-bus.
> 
> The patch is really non-invasive and simple. It can be a good starting
> point for testing and proposing other solutions.

Sorry for late reply. I'm preparing the RFC patch about my approach
to support this requirement as following:

As you knew, DEFERRABLE_WORK with CONFIG_NO_HZ focuses on removing
the redundant of power-consumption by preventing the unneeded wakeup
from idle state if there are no any interrupts and runnable threads.

Finally, I agree the requirement of delaywd_work for devfreq subsystem.
But, I would like to support both deferrable_work and delayed_work
on devfreq subsystem. It is better to select either deferrable_work
or delayed_work by user like Kamil's suggestion[1].
[1] https://lore.kernel.org/patchwork/patch/1164317/
- [2/4] PM / devfreq: add possibility for delayed work

But, I want to change the timer type for devfreq device
using simple_ondemand governor via sysfs as following:

Example:

1.
enum work_timer_type {
	DEVFREQ_WORK_TIMER_DEFERRABLE = 0,
	DEVFREQ_WORK_TIMER_DELAYED = 0,
};

struct devfreq_simple_ondemand_data {
	unsigned int upthreshold;
	unsigned int downdifferential;
	enum work_timer_type timer_type;
};

The developer of devfreq device driver can choose
the default work time type by initializing the 'timer_type of 
struct devfreq_simple_ondemand_data'.

2. Change the work timer type at the runtime
- Change the work timer type from 'deferrable' to 'delayed'
$ echo delayed > /sys/class/devfreq/devfreq0/work_timer_type
$ cat /sys/class/devfreq/devfreq0/work_timer_type
delayed

- Change the work timer type from 'delayed' to 'deferrable'
$ echo deferrable > /sys/class/devfreq/devfreq0/work_timer_type
$ cat /sys/class/devfreq/devfreq0/work_timer_type
deferrable

I'm developing the RFC patch and then I'll send it as soon as possible.

> 
> Regards,
> Lukasz
> 
> On 1/27/20 3:17 PM, lukasz.luba@arm.com wrote:
>> From: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Hi all,
>>
>> This patch is a continuation of my previous work for fixing DEVFREQ monitoring
>> subsystem [1]. The issue is around DEFERRABLE_WORK, which uses TIMER_DEFERRABLE
>> under the hood which will work normally when the system is busy, but will not
>> cause a CPU to come out of idle and serve the DEVFREQ monitoring requests.
>>
>> This is especially important in the SMP systems with many CPUs, when the load
>> balance tries to keep some CPUs idle. The next service request could not be
>> triggered when the CPU went idle in the meantime.
>>
>> The DELAYED_WORK is going to be triggered even on an idle CPU. This will allow
>> to call the DEVFREQ monitoring in reliable intervals. Some of the drivers might
>> use internal counters to monitor their load, when the DEVFREQ work is not
>> triggered in a predictable way, these counters might overflow leaving the
>> device in undefined state.
>>
>> To observe the difference, the trace output might be used, i.e.
>>
>> echo 1 > /sys/kernel/debug/tracing/events/devfreq/enable
>> #your test starts here, i.e. 'sleep 5' or 'dd ' or 'gfxbench'
>> echo 0 > /sys/kernel/debug/tracing/events/devfreq/enable
>> cat /sys/kernel/debug/tracing/trace
>>
>> When there are some registered devfreq drivers, you should see the traces
>> 'devfreq_moniotor' triggered in reliable intervals.
>>
>> The patch set is based on Chanwoo's devfreq repository and branch
>> 'devfreq-next' [2].
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] https://protect2.fireeye.com/url?k=d26154c0-8fb20fd4-d260df8f-0cc47a31ce4e-ba68a61e16ee1965&u=https://lkml.org/lkml/2019/2/12/1179
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next
>>
>>
>> Lukasz Luba (1):
>>    drivers: devfreq: add DELAYED_WORK to monitoring subsystem
>>
>>   drivers/devfreq/Kconfig   | 19 +++++++++++++++++++
>>   drivers/devfreq/devfreq.c |  6 +++++-
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
