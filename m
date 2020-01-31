Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B039814E6AC
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 01:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgAaAkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 19:40:01 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43475 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgAaAkA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 19:40:00 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200131003956epoutp038761f22093372543abcf55368d26fdac~u0cyffQjv1320913209epoutp036
        for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2020 00:39:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200131003956epoutp038761f22093372543abcf55368d26fdac~u0cyffQjv1320913209epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580431196;
        bh=RmDZhqN+LgY1O2sgdYddSNPyGXXJExcb+Z4r7dLG1qA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IvznxriRJF7jUGraTxMkkzpFvN5so8GZWQ3Xw7BUmWlj9+fY0fou3OhKNVf/pRUgw
         bkAzKlrkaNpE8tud1a7UpELWcwYOAa6B8cid0z9Iw4Bjw5+Va9nyRKcutuMPXLHjSr
         tD1lTZK6LciR32wcglk3bHIrb6iy0EeII8tC3kAo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200131003955epcas1p4399ea7f6080759effc31152f534d6ed3~u0cxxeicG2600526005epcas1p4F;
        Fri, 31 Jan 2020 00:39:55 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 487yzX6SX1zMqYls; Fri, 31 Jan
        2020 00:39:52 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.11.48019.257733E5; Fri, 31 Jan 2020 09:39:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200131003945epcas1p2be3f7fb3d380429c400a28c5c5f9a07a~u0co5zR7H2017620176epcas1p2U;
        Fri, 31 Jan 2020 00:39:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200131003945epsmtrp2b87a799f1c06bc91660866e3fdeed480~u0co5ASTt0771307713epsmtrp2e;
        Fri, 31 Jan 2020 00:39:45 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-7d-5e337752cae2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.9F.06569.157733E5; Fri, 31 Jan 2020 09:39:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200131003944epsmtip28df7c9238130fad61b983afa0b867147~u0coF-Lhk0483704837epsmtip2Y;
        Fri, 31 Jan 2020 00:39:44 +0000 (GMT)
Subject: Re: [PATCH 0/1] drivers: devfreq: use DELAYED_WORK in DEVFREQ
 monitoring subsystem
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, Kamil Konieczny <k.konieczny@samsung.com>
Organization: Samsung Electronics
Message-ID: <f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com>
Date:   Fri, 31 Jan 2020 09:47:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmvm5QuXGcwfHV7BYbZ6xntVjwaQar
        xdmmN+wWl3fNYbP43HuE0WJhUwu7xe3GFWwO7B5r5q1h9OjbsorR4/MmuQDmqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjMUz/jEVbNOs
        OPrnJHMDY7dSFyMnh4SAicTEOU+Yuxg5OIQEdjBKPMvtYuQCMj8xStxfMpUdwvnGKNEx9z87
        TMOhj59YIRJ7GSUurn/AApIQEnjPKPHvXCqILSwQK7Fl8jE2EJtNQEti/4sbbCANIgLTGCU+
        HZnFCJJgFnCXmNf6nBnE5hdQlLj64zFYnFfATuJr4xwmEJtFQFXi8PTJrCC2qECYxMltLVA1
        ghInZz4BW8wpYC8xs/coE8RMcYlbT+ZD2fISzVtnM0Nc/ZhN4vD/BAjbRaLh8geouLDEq+Nb
        oD6Tkvj8bi8bhF0tsfLkEbCjJQQ6GCW27L/ACpEwlti/dDITKLyYBTQl1u/ShwgrSuz8PRfq
        Lz6Jd197WEFKJAR4JTrahCBKlCUuP7jLBGFLSixu72SbwKg0C8k3s5B8MAvJB7MQli1gZFnF
        KJZaUJybnlpsWGCCHNebGMHJUstiB+Oecz6HGAU4GJV4eD3OGMUJsSaWFVfmHmKU4GBWEuEV
        dTWME+JNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wESeVxJvaGpkbGxsYWJoZmpoqCTO+zBS
        M05IID2xJDU7NbUgtQimj4mDU6qBsVLx/aWcVwpnJvnXPxcIubtt8qFk43stp+xjHzKVcL/4
        l2XJn3Pe5pM4x4P9pnO/Nj9rusGZkWwZ2Dq555SskJNx5PEsW2v7G4++ue8QczHc+9HHJLVv
        /uWE1yc6+vnPt2mvVO3Tadhds8zYSqnql8wWv9h25g+7Hjxc/+/lY6nd0lcPq7+Zr8RSnJFo
        qMVcVJwIANVX9J6sAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXjew3DjO4M9uLYuNM9azWiz4NIPV
        4mzTG3aLy7vmsFl87j3CaLGwqYXd4nbjCjYHdo8189YwevRtWcXo8XmTXABzFJdNSmpOZllq
        kb5dAlfG4hn/mAq2aVYc/XOSuYGxW6mLkZNDQsBE4tDHT6xdjFwcQgK7GSX+nX3LCJGQlJh2
        8ShzFyMHkC0scfhwMUTNW0aJt0tPs4LUCAvESmyZfIwNxGYT0JLY/+IGG0iRiMA0Rom1K5ez
        gCSYBdwl5rU+Z4bo/sgosXLXRXaQBL+AosTVH4/BtvEK2El8bZzDBGKzCKhKHJ4+GWyDqECY
        xM4lj5kgagQlTs58AjaUU8BeYmbvUSaIBeoSf+ZdYoawxSVuPZkPFZeXaN46m3kCo/AsJO2z
        kLTMQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwdGjpbWD8cSJ+EOM
        AhyMSjy8HmeM4oRYE8uKK3MPMUpwMCuJ8Iq6GsYJ8aYkVlalFuXHF5XmpBYfYpTmYFES55XP
        PxYpJJCeWJKanZpakFoEk2Xi4JRqYHT86HzHs+Dj5hObNs6f8fGW1j/Fq0skRLgTvC5Vv9hp
        4PlPUSPlUqvTOu9629VlsTW3Bdt0VebLmL+L5aq/pDLlRKCJkWAPb+78SHHRm2EHvoW9y+st
        3qDgaHV1Z4/AWqtlDhHtBzYVLG0w3d3/9uKn0x1RnR1nzjeaTLLcI1J7yobtQUlxrRJLcUai
        oRZzUXEiAM+5XKqaAgAA
X-CMS-MailID: 20200131003945epcas1p2be3f7fb3d380429c400a28c5c5f9a07a
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
        <6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/31/20 9:42 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 1/30/20 8:47 PM, Lukasz Luba wrote:
>> Hi Chanwoo, MyungJoo,
>>
>> Gentle ping. The issue is not only in the devfreq itself,
>> but also it affects thermal. The devfreq cooling rely on
>> busy_time and total_time updated by the devfreq monitoring
>> (in simple_ondemand).
>> Thermal uses DELAYED_WORK and is more reliable, but uses stale
>> data from devfreq_dev_stats. It is especially visible when
>> you have cgroup spanning one cluster. Android uses cgroups
>> heavily. You can make easily this setup using 'taskset',
>> run some benchmarks and observe 'devfreq_monitor' traces and
>> timestamps, i.e. for your exynos-bus.
>>
>> The patch is really non-invasive and simple. It can be a good starting
>> point for testing and proposing other solutions.
> 
> Sorry for late reply. I'm preparing the RFC patch about my approach
> to support this requirement as following:
> 
> As you knew, DEFERRABLE_WORK with CONFIG_NO_HZ focuses on removing
> the redundant of power-consumption by preventing the unneeded wakeup
> from idle state if there are no any interrupts and runnable threads.
> 
> Finally, I agree the requirement of delaywd_work for devfreq subsystem.
> But, I would like to support both deferrable_work and delayed_work
> on devfreq subsystem. It is better to select either deferrable_work
> or delayed_work by user like Kamil's suggestion[1].
> [1] https://lore.kernel.org/patchwork/patch/1164317/
> - [2/4] PM / devfreq: add possibility for delayed work
> 
> But, I want to change the timer type for devfreq device
> using simple_ondemand governor via sysfs as following:
> 
> Example:
> 
> 1.
> enum work_timer_type {
> 	DEVFREQ_WORK_TIMER_DEFERRABLE = 0,
> 	DEVFREQ_WORK_TIMER_DELAYED = 0,
> };
> 
> struct devfreq_simple_ondemand_data {
> 	unsigned int upthreshold;
> 	unsigned int downdifferential;
> 	enum work_timer_type timer_type;
> };
> 
> The developer of devfreq device driver can choose
> the default work time type by initializing the 'timer_type of 
> struct devfreq_simple_ondemand_data'.
> 
> 2. Change the work timer type at the runtime
> - Change the work timer type from 'deferrable' to 'delayed'
> $ echo delayed > /sys/class/devfreq/devfreq0/work_timer_type
> $ cat /sys/class/devfreq/devfreq0/work_timer_type
> delayed
> 
> - Change the work timer type from 'delayed' to 'deferrable'
> $ echo deferrable > /sys/class/devfreq/devfreq0/work_timer_type
> $ cat /sys/class/devfreq/devfreq0/work_timer_type
> deferrable
> 

And
Only show '/sys/class/devfreq/devfreq0/work_timer_type' sysfs attribute,
if devfreq device uses the simple_ondemand. Because this 'work_timer_type'
sysfs attribute only depends on simple_ondemand governor and are useful.

So, 'work_timer_type' sysfs attribute will be handled
at drivers/devfreq/governor_simpleondemand.c.

After posting my suggestion, we can discuss it.


> I'm developing the RFC patch and then I'll send it as soon as possible.
> 
>>
>> Regards,
>> Lukasz
>>
>> On 1/27/20 3:17 PM, lukasz.luba@arm.com wrote:
>>> From: Lukasz Luba <lukasz.luba@arm.com>
>>>
>>> Hi all,
>>>
>>> This patch is a continuation of my previous work for fixing DEVFREQ monitoring
>>> subsystem [1]. The issue is around DEFERRABLE_WORK, which uses TIMER_DEFERRABLE
>>> under the hood which will work normally when the system is busy, but will not
>>> cause a CPU to come out of idle and serve the DEVFREQ monitoring requests.
>>>
>>> This is especially important in the SMP systems with many CPUs, when the load
>>> balance tries to keep some CPUs idle. The next service request could not be
>>> triggered when the CPU went idle in the meantime.
>>>
>>> The DELAYED_WORK is going to be triggered even on an idle CPU. This will allow
>>> to call the DEVFREQ monitoring in reliable intervals. Some of the drivers might
>>> use internal counters to monitor their load, when the DEVFREQ work is not
>>> triggered in a predictable way, these counters might overflow leaving the
>>> device in undefined state.
>>>
>>> To observe the difference, the trace output might be used, i.e.
>>>
>>> echo 1 > /sys/kernel/debug/tracing/events/devfreq/enable
>>> #your test starts here, i.e. 'sleep 5' or 'dd ' or 'gfxbench'
>>> echo 0 > /sys/kernel/debug/tracing/events/devfreq/enable
>>> cat /sys/kernel/debug/tracing/trace
>>>
>>> When there are some registered devfreq drivers, you should see the traces
>>> 'devfreq_moniotor' triggered in reliable intervals.
>>>
>>> The patch set is based on Chanwoo's devfreq repository and branch
>>> 'devfreq-next' [2].
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> [1] https://protect2.fireeye.com/url?k=d26154c0-8fb20fd4-d260df8f-0cc47a31ce4e-ba68a61e16ee1965&u=https://lkml.org/lkml/2019/2/12/1179
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next
>>>
>>>
>>> Lukasz Luba (1):
>>>    drivers: devfreq: add DELAYED_WORK to monitoring subsystem
>>>
>>>   drivers/devfreq/Kconfig   | 19 +++++++++++++++++++
>>>   drivers/devfreq/devfreq.c |  6 +++++-
>>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
