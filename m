Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6BF30BABF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 10:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhBBJRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 04:17:12 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:23375 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhBBJQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 04:16:17 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210202091532epoutp046e4159c2f535fe24299bbe08bd5241ca~f44BrqSXA3273632736epoutp04T
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 09:15:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210202091532epoutp046e4159c2f535fe24299bbe08bd5241ca~f44BrqSXA3273632736epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612257332;
        bh=8/Uvc2DmZxqBGq92uwV/OhQPnZnLm+kTteq+2NC33l0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eUGZp9Y8pmE6341+OEhUYvcx7qXUA9DZcTDbQMjCWnemoJ5Y3pbuxeBDWxt99T/BN
         u/lL6BtRomVcmtvPgjvLaRtrfHrncgcMXwhs7o23a+XY8oY3FL23mQN2K+/x2eyi74
         2c43NQANkZ517nNFD+3Drb463ZeVUNx/GCB2nESU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210202091531epcas1p23e9a8c125919ea74106d0fd05309c35b~f44BB0SQI0045700457epcas1p2A;
        Tue,  2 Feb 2021 09:15:31 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DVK0c12XTz4x9Q2; Tue,  2 Feb
        2021 09:15:28 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.3B.09577.03819106; Tue,  2 Feb 2021 18:15:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210202091527epcas1p1a36f7f50dfbae8a9bc25887234a029fa~f439GkTWT1857018570epcas1p1C;
        Tue,  2 Feb 2021 09:15:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210202091527epsmtrp196e202efa637dd91aec8f43a338465ea~f439FsOrZ0702607026epsmtrp1E;
        Tue,  2 Feb 2021 09:15:27 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-b3-601918302b6d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.39.13470.F2819106; Tue,  2 Feb 2021 18:15:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210202091527epsmtip134a588b4f81711fb74024495a4a53389~f438u3rGw2067220672epsmtip1k;
        Tue,  2 Feb 2021 09:15:26 +0000 (GMT)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     Lukasz Luba <lukasz.luba@arm.com>, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, Dietmar.Eggemann@arm.com,
        amitk@kernel.org, rui.zhang@intel.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d05b247e-2294-e5f0-15bb-1a7a09a8e40e@samsung.com>
Date:   Tue, 2 Feb 2021 18:31:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <5751adfa-6e25-3f3c-4a60-9b3c739fec1f@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmvq6BhGSCwa4vzBaH51dYzPssa/F0
        wlZmi7NNb9gtLu+aw2bxufcIo8XCphZ2i9uNK9gs5n6Zymzx5GEfm8XmB8fYHLg91sxbw+ix
        eM9LJo9NqzrZPO5c28Pm0bdlFaPH501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7Iz5re3sBX8Fql4/uM1SwPjT4EuRk4OCQETif9n
        ZzN1MXJxCAnsYJRoPNDDDuF8YpR413kDKvONUWLPvSfMMC2LD31mgUjsZZRYvPwyK4TznlHi
        5qYf7CBVwgLBEhOX3mYCsUUEHCRmz58GVsQscJdRovX4czaQBJuAlsT+FzfAbH4BRYmrPx4z
        gti8AnYSu1/dZQGxWQRUJN5t3QY2SFQgTOLkthaoGkGJkzOfgNVwClhLrP0yFayGWUBc4taT
        +VC2vETz1tnMIIslBI5wSPxsO8wO8YOLxIz+ViYIW1ji1fEtUHEpiZf9bVB2tcTKk0fYIJo7
        GCW27L/ACpEwlti/dDJQMwfQBk2J9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQAr0RHmxBEibLE
        5Qd3odZKSixu72SbwKg0C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlpsWGCKHN+bGMFpV8ty
        B+P0tx/0DjEycTAeYpTgYFYS4T01SSxBiDclsbIqtSg/vqg0J7X4EKMpMIAnMkuJJucDE39e
        SbyhqZGxsbGFiaGZqaGhkjhvksGDeCGB9MSS1OzU1ILUIpg+Jg5OqQamns/x9gtvTljtzzDn
        4lxdFulalhtdv8/8uZK+W2ISQ1WbtOopZiF/GZY1u7pnHFT+5nnp4Kf1GZ9Y8h4pFtYssgk2
        zPefwCdyMvh1ZVHTypkFS1N7be98MBcQfXixxDbn54Tc8+Y9jBPvTfovIck8x1Htzn3f6sVS
        PeI7d37mLvXqMulPz1EImNlVeOenFduJRPeDblwfY8zvRv6Kzl+yNEFin+62lM65/LafGV6o
        PJsYrHZry/rkyccf/GZcHK/8q/mZSsR54ePH1x1K9HjiueFXjd26Lp+1qjKJTB8+CEv5F7o1
        aTzfMF/ocr1bc3r4xGd7/Zon9Z39rcVcu26RdOAtz4VCOm/Nu4zPr3RRYinOSDTUYi4qTgQA
        UQpMIkQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK6+hGSCQWsTr8Xh+RUW8z7LWjyd
        sJXZ4mzTG3aLy7vmsFl87j3CaLGwqYXd4nbjCjaLuV+mMls8edjHZrH5wTE2B26PNfPWMHos
        3vOSyWPTqk42jzvX9rB59G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8b89ha2gt8iFc9/vGZp
        YPwp0MXIySEhYCKx+NBnli5GLg4hgd2MEpv23WaHSEhKTLt4lLmLkQPIFpY4fLgYouYto8SF
        jR9ZQWqEBYIlJi69zQRiiwg4SMyeP40VpIhZ4C6jxM1rm9kgOvYySnz/dZoZpIpNQEti/4sb
        bCA2v4CixNUfjxlBbF4BO4ndr+6ygNgsAioS77ZuA5sqKhAmsXPJYyaIGkGJkzOfgNVwClhL
        rP0yFSzOLKAu8WfeJWYIW1zi1pP5UHF5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQ
        nJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERx/Wpo7GLev+qB3iJGJg/EQowQHs5II76lJYglC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MM1sX7r8xFar
        fxY3AxUkBA/whUpWH3w4rZTj29L0z5WPlTo+3nNU6Vuv9GSSJP+mx9der/KfN0G8av5tVqes
        rosSbs6TdmX9FX/FZXQ4+1v6brPeLuHS2r9drXd3uWUEdPeuvtR2m0Gz9didXLlLGuKMd56u
        nZDE8O4qe+/6dVnZLt8etr17eiTr0kVmaecpge+yb52fbd1+JCP8YtPG1yc9itceyjsqWPnf
        c8Lif8yL1AqZ4yetEC72Ywp95OM0weWISGZf6GnjmbuOMQs3XJjy0Diu5JbYe32D9jfrJ//N
        FLPbxbQtlsdCdNMcfa4TEfVN4SynXr8KCfjJ/ltA4UH4sfn6TFn3XhruaxXU+qPEUpyRaKjF
        XFScCACZ87TNLgMAAA==
X-CMS-MailID: 20210202091527epcas1p1a36f7f50dfbae8a9bc25887234a029fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210201112455epcas1p3abb4475b1690d1b6b9260a78a373e04c
References: <20210126104001.20361-1-lukasz.luba@arm.com>
        <CGME20210201112455epcas1p3abb4475b1690d1b6b9260a78a373e04c@epcas1p3.samsung.com>
        <5751adfa-6e25-3f3c-4a60-9b3c739fec1f@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

I'll review this patchset until tomorrow.

Thanks.
Chanwoo Choi 

On 2/1/21 8:23 PM, Lukasz Luba wrote:
> Daniel, Chanwoo
> 
> Gentle ping. Have you have a chance to check these patches?
> 
> On 1/26/21 10:39 AM, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set tries to add the missing feature in the Intelligent Power
>> Allocation (IPA) governor which is: frequency limit set by user space.
>> User can set max allowed frequency for a given device which has impact on
>> max allowed power. In current design there is no mechanism to figure this
>> out. IPA must know the maximum allowed power for every device. It is then
>> used for proper power split and divvy-up. When the user limit for max
>> frequency is not know, IPA assumes it is the highest possible frequency.
>> It causes wrong power split across the devices.
>>
>> This new mechanism provides the max allowed frequency to the thermal
>> framework and then max allowed power to the IPA.
>> The implementation is done in this way because currently there is no way
>> to retrieve the limits from the PM QoS, without uncapping the local
>> thermal limit and reading the next value. It would be a heavy way of
>> doing these things, since it should be done every polling time (e.g. 50ms).
>> Also, the value stored in PM QoS can be different than the real OPP 'rate'
>> so still would need conversion into proper OPP for comparison with EM.
>> Furthermore, uncapping the device in thermal just to check the user freq
>> limit is not the safest way.
>> Thus, this simple implementation moves the calculation of the proper
>> frequency to the sysfs write code, since it's called less often. The value
>> is then used as-is in the thermal framework without any hassle.
>>
>> As it's a RFC, it still misses the cpufreq sysfs implementation, but would
>> be addressed if all agree.
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (3):
>>    PM /devfreq: add user frequency limits into devfreq struct
>>    thermal: devfreq_cooling: add new callback to get user limit for min
>>      state
>>    thermal: power_allocator: get proper max power limited by user
>>
>>   drivers/devfreq/devfreq.c             | 41 ++++++++++++++++++++++++---
>>   drivers/thermal/devfreq_cooling.c     | 33 +++++++++++++++++++++
>>   drivers/thermal/gov_power_allocator.c | 17 +++++++++--
>>   include/linux/devfreq.h               |  4 +++
>>   include/linux/thermal.h               |  1 +
>>   5 files changed, 90 insertions(+), 6 deletions(-)
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
