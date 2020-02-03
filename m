Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE1C150031
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 02:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBCBCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Feb 2020 20:02:19 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:19506 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBCBCT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Feb 2020 20:02:19 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200203010215epoutp0280c10f471771c535bf3a90a1e22af0f8~vvsJKVRMJ2692226922epoutp02L
        for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2020 01:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200203010215epoutp0280c10f471771c535bf3a90a1e22af0f8~vvsJKVRMJ2692226922epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580691735;
        bh=2FwVrGlwaYbgic9bnLnPLjOB21m9Nn35aPYVdnTo5kA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qchiYCiozB1t5Ui5hlcXcK1jH4h6Lzts0wdc4wKFWEZvQH7Z4+KxjrpilFbR11xtY
         OAsFZH2bFREFNrlDL335kUXAI2ZLI3noapVt54A7u6sM5eyh4B/51ZMa+hOivLqy6q
         oLOMkzsT9yR+RwKWayf9q/aBlStLdKUF5XZkteCg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200203010215epcas1p106c5b2b07e8ced079c871962187a2479~vvsIksI2F2531725317epcas1p1K;
        Mon,  3 Feb 2020 01:02:15 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 489qKw3bKJzMqYm0; Mon,  3 Feb
        2020 01:02:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.BE.57028.411773E5; Mon,  3 Feb 2020 10:02:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200203010212epcas1p26a3d99b150514bbd8f0e342a3b8cbba9~vvsFlontq3087830878epcas1p2K;
        Mon,  3 Feb 2020 01:02:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200203010212epsmtrp238fdd337e08433cb3beb526df78ee1cf~vvsFkoHH71762117621epsmtrp2R;
        Mon,  3 Feb 2020 01:02:12 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-dc-5e377114ed7b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.3E.06569.311773E5; Mon,  3 Feb 2020 10:02:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200203010211epsmtip260eda329d8576d33e7d5f84d832c943b~vvsFW_6oA1730717307epsmtip2c;
        Mon,  3 Feb 2020 01:02:11 +0000 (GMT)
Subject: Re: [PATCH 0/1] drivers: devfreq: use DELAYED_WORK in DEVFREQ
 monitoring subsystem
To:     Lukasz Luba <lukasz.luba@arm.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, Kamil Konieczny <k.konieczny@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <931bb376-0045-9929-6e67-15d34ebf3fbe@samsung.com>
Date:   Mon, 3 Feb 2020 10:10:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <729911b2-434b-fbe5-b556-5bdba8114085@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmga5IoXmcwYQVshYbZ6xntVjwaQar
        xdmmN+wWl3fNYbP43HuE0WJhUwu7xe3GFWwO7B5r5q1h9OjbsorR4/MmuQDmqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjOUHsgpeKVZ0
        3exhbGD8LN3FyMkhIWAisXh1L0sXIxeHkMAORonfB1+xgCSEBD4xSqy6ZQiR+MYocfv/dXaY
        jqOdz1khEnsZJT4/eMII4bxnlNh+bTMjSJWwQKzElsnH2EASIgLTGCU+HZkFlmAWcJeY1/qc
        GcRmE9CS2P/iBhuIzS+gKHH1x2OwGl4BO4lrPROYQGwWARWJjfcbWUFsUYEwiZPbWqBqBCVO
        znwCdiungLXEuc71LBDzxSVuPZnPBGHLSzRvnc0McoSEwGM2iRdvXjFD/OAi8en5GlYIW1ji
        1fEtUL9JSXx+t5cNwq6WWHnyCBtEcwejxJb9F6AajCX2L50MtIEDaIOmxPpd+hBhRYmdv+dC
        Pckn8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaSF2YheWEWwrIFjCyr
        GMVSC4pz01OLDQsMkWN7EyM4YWqZ7mCccs7nEKMAB6MSD++Mh2ZxQqyJZcWVuYcYJTiYlUR4
        66xM44R4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjCZ55XEG5oaGRsbW5gYmpkaGiqJ8z6M
        1IwTEkhPLEnNTk0tSC2C6WPi4JRqYCyZUbO5rZw36tH8bNM9UWrX5z6z/33ln94r+cDNkhon
        np1o3cY64crkWRPOcKku9D/ab/r+VeB14X1fbVPe32/qZT7zN7ra9/uP5zHxW+eFJmw4UbPo
        3ZrAa2xtK5bvXn6oOqLwzVKvp6d3RHSUnJ310zJA+++0uXOTjW+v2rFdueb882fd5ZGaSizF
        GYmGWsxFxYkArgsBgK4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXle40DzO4MV9S4uNM9azWiz4NIPV
        4mzTG3aLy7vmsFl87j3CaLGwqYXd4nbjCjYHdo8189YwevRtWcXo8XmTXABzFJdNSmpOZllq
        kb5dAlfG8gNZBa8UK7pu9jA2MH6W7mLk5JAQMJE42vmctYuRi0NIYDejxJabl1kgEpIS0y4e
        Ze5i5ACyhSUOHy6GqHnLKLHp2lxGkBphgViJLZOPsYEkRASmMUqsXbkcrJlZwF1iXutzZoiO
        60wSR88sYQNJsAloSex/cQPM5hdQlLj64zHYJF4BO4lrPROYQGwWARWJjfcbWUFsUYEwiZ1L
        HjNB1AhKnJz5BGwBp4C1xLnO9VDL1CX+zLvEDGGLS9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTM
        QtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwbGjpbWD8cSJ+EOMAhyM
        Sjy8Mx6axQmxJpYVV+YeYpTgYFYS4a2zMo0T4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuffyxS
        SCA9sSQ1OzW1ILUIJsvEwSnVwLhst2PiMpYY0zl8t2xU85qct1jtWN3v59cvWHh2spNiWN++
        GKdPXze/ePYoUDw4zGNOXngI49/tsVELVWbeaj7b96gk8sWJX4pGe2VfvLS44vxI7ItDXn7V
        cebXB6t+bfnrInnTc82nBfO2ul2eX7pwdatpcKKU1QOHZe5at5zXPuHa7vPvs4ESS3FGoqEW
        c1FxIgC2/SV7mQIAAA==
X-CMS-MailID: 20200203010212epcas1p26a3d99b150514bbd8f0e342a3b8cbba9
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
        <f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com>
        <729911b2-434b-fbe5-b556-5bdba8114085@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/31/20 6:38 PM, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 1/31/20 12:47 AM, Chanwoo Choi wrote:
>> On 1/31/20 9:42 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> On 1/30/20 8:47 PM, Lukasz Luba wrote:
>>>> Hi Chanwoo, MyungJoo,
>>>>
>>>> Gentle ping. The issue is not only in the devfreq itself,
>>>> but also it affects thermal. The devfreq cooling rely on
>>>> busy_time and total_time updated by the devfreq monitoring
>>>> (in simple_ondemand).
>>>> Thermal uses DELAYED_WORK and is more reliable, but uses stale
>>>> data from devfreq_dev_stats. It is especially visible when
>>>> you have cgroup spanning one cluster. Android uses cgroups
>>>> heavily. You can make easily this setup using 'taskset',
>>>> run some benchmarks and observe 'devfreq_monitor' traces and
>>>> timestamps, i.e. for your exynos-bus.
>>>>
>>>> The patch is really non-invasive and simple. It can be a good starting
>>>> point for testing and proposing other solutions.
>>>
>>> Sorry for late reply. I'm preparing the RFC patch about my approach
>>> to support this requirement as following:
>>>
>>> As you knew, DEFERRABLE_WORK with CONFIG_NO_HZ focuses on removing
>>> the redundant of power-consumption by preventing the unneeded wakeup
>>> from idle state if there are no any interrupts and runnable threads.
>>>
>>> Finally, I agree the requirement of delaywd_work for devfreq subsystem.
>>> But, I would like to support both deferrable_work and delayed_work
>>> on devfreq subsystem. It is better to select either deferrable_work
>>> or delayed_work by user like Kamil's suggestion[1].
>>> [1] https://lore.kernel.org/patchwork/patch/1164317/
>>> - [2/4] PM / devfreq: add possibility for delayed work
>>>
>>> But, I want to change the timer type for devfreq device
>>> using simple_ondemand governor via sysfs as following:
>>>
>>> Example:
>>>
>>> 1.
>>> enum work_timer_type {
>>>     DEVFREQ_WORK_TIMER_DEFERRABLE = 0,
>>>     DEVFREQ_WORK_TIMER_DELAYED = 0,
>>> };
>>>
>>> struct devfreq_simple_ondemand_data {
>>>     unsigned int upthreshold;
>>>     unsigned int downdifferential;
>>>     enum work_timer_type timer_type;
>>> };
>>>
>>> The developer of devfreq device driver can choose
>>> the default work time type by initializing the 'timer_type of
>>> struct devfreq_simple_ondemand_data'.
>>>
>>> 2. Change the work timer type at the runtime
>>> - Change the work timer type from 'deferrable' to 'delayed'
>>> $ echo delayed > /sys/class/devfreq/devfreq0/work_timer_type
>>> $ cat /sys/class/devfreq/devfreq0/work_timer_type
>>> delayed
>>>
>>> - Change the work timer type from 'delayed' to 'deferrable'
>>> $ echo deferrable > /sys/class/devfreq/devfreq0/work_timer_type
>>> $ cat /sys/class/devfreq/devfreq0/work_timer_type
>>> deferrable
>>>
>>
>> And
>> Only show '/sys/class/devfreq/devfreq0/work_timer_type' sysfs attribute,
>> if devfreq device uses the simple_ondemand. Because this 'work_timer_type'
>> sysfs attribute only depends on simple_ondemand governor and are useful.
>>
>> So, 'work_timer_type' sysfs attribute will be handled
>> at drivers/devfreq/governor_simpleondemand.c.
>>
>> After posting my suggestion, we can discuss it.
>>
>>
>>> I'm developing the RFC patch and then I'll send it as soon as possible.
> 
> Good, thank you for the explanation. For the first glance the design
> looks OK, we can discuss it a bit more in you RFC series.
> I would recommend to not make it conditional on simple_ondemand governor
> just add a comment that for i.e. performance or passive governors it has
> less sense to use this setting. There might be some other governors
> loaded as modules, which could benefit from it, or in Android e.g.
> https://android.googlesource.com/kernel/msm/+/refs/heads/android-msm-coral-4.14-android10/drivers/devfreq/governor_msm_adreno_tz.c

OK. Instead, I'll add the flag for governors. The governor flag
indicates each sysfs entries like polling_interval, work_timer_type.

If each governor want to use the specific sysfs attributes,
just set the flag when governor is defined.

Thanks.

> 
> It would be good if it can land in mainline before v5.8-v5.9.
> 
> Regards,
> Lukasz
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
