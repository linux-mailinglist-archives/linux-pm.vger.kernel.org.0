Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE313577E
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 11:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgAIK5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 05:57:10 -0500
Received: from foss.arm.com ([217.140.110.172]:57036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgAIK5K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jan 2020 05:57:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB9C31B;
        Thu,  9 Jan 2020 02:57:08 -0800 (PST)
Received: from [10.37.12.111] (unknown [10.37.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA023F703;
        Thu,  9 Jan 2020 02:57:05 -0800 (PST)
Subject: Re: [PATCH v2 02/11] PM / devfreq: Remove
 devfreq_get_devfreq_by_phandle function
To:     Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        krzk@kernel.org, heiko@sntech.de, leonard.crestez@nxp.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20191220002430.11995-1-cw00.choi@samsung.com>
 <CGME20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0@epcas1p4.samsung.com>
 <20191220002430.11995-3-cw00.choi@samsung.com>
 <b9a1ebe5-e114-3a6b-6081-c794e1341329@arm.com>
 <22cde618-d51e-2d4d-461e-e2d2c1b52af2@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3cb1e237-84b2-f110-4eb3-6394151cecc4@arm.com>
Date:   Thu, 9 Jan 2020 10:57:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <22cde618-d51e-2d4d-461e-e2d2c1b52af2@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/9/20 10:54 AM, Chanwoo Choi wrote:
> On 1/9/20 7:37 PM, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 12/20/19 12:24 AM, Chanwoo Choi wrote:
>>> Previously, devfreq core support 'devfreq' property in order to get
>>> the devfreq device by phandle. But, 'devfreq' property name is not proper
>>> on devicetree binding because this name doesn't mean the any h/w attribute.
>>>
>>> The devfreq core hand over the right to decide the property name
>>> for getting the devfreq device on devicetree. Each devfreq driver
>>> will decide the property name on devicetree binding and then get
>>> the devfreq device by using devfreq_get_devfreq_by_node().
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>    drivers/devfreq/devfreq.c    | 35 -----------------------------------
>>>    drivers/devfreq/exynos-bus.c | 12 +++++++++++-
>>>    include/linux/devfreq.h      |  8 --------
>>>    3 files changed, 11 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index cb8ca81c8973..c3d3c7c802a0 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>>          return ERR_PTR(-ENODEV);
>>>    }
>>> -
>>> -/*
>>> - * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
>>> - * @dev - instance to the given device
>>> - * @index - index into list of devfreq
>>> - *
>>> - * return the instance of devfreq device
>>> - */
>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>>> -{
>>> -    struct device_node *node;
>>> -    struct devfreq *devfreq;
>>> -
>>> -    if (!dev)
>>> -        return ERR_PTR(-EINVAL);
>>> -
>>> -    if (!dev->of_node)
>>> -        return ERR_PTR(-EINVAL);
>>> -
>>> -    node = of_parse_phandle(dev->of_node, "devfreq", index);
>>> -    if (!node)
>>> -        return ERR_PTR(-ENODEV);
>>> -
>>> -    devfreq = devfreq_get_devfreq_by_node(node);
>>> -    of_node_put(node);
>>> -
>>> -    return devfreq;
>>> -}
>>> -
>>>    #else
>>>    struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>>>    {
>>>        return ERR_PTR(-ENODEV);
>>>    }
>>> -
>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
>>> -{
>>> -    return ERR_PTR(-ENODEV);
>>> -}
>>>    #endif /* CONFIG_OF */
>>>    EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
>>> -EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
>>>      /**
>>>     * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 7f5917d59072..1bc4e3c81115 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -86,6 +86,16 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
>>>        return ret;
>>>    }
>>>    +static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node *np)
>>> +{
>>> +    struct device_node *node = of_parse_phandle(np, "devfreq", 0);
>>> +
>>> +    if (!node)
>>> +        return ERR_PTR(-ENODEV);
>>> +
>>> +    return devfreq_get_devfreq_by_node(node);
>>> +}
>>> +
>>>    /*
>>>     * devfreq function for both simple-ondemand and passive governor
>>>     */
>>> @@ -353,7 +363,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>        profile->exit = exynos_bus_passive_exit;
>>>          /* Get the instance of parent devfreq device */
>>> -    parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>>> +    parent_devfreq = exynos_bus_get_parent_devfreq(dev->of_node);
>>>        if (IS_ERR(parent_devfreq))
>>>            return -EPROBE_DEFER;
>>>    
>>
>> These changes won't apply, probably I need some base for it.
> 
> I developed it on devfreq-next branch[1]
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next
> 
> And I try to apply these patchset to linux-next[2] with tags/next-20200109.
> But, patch10/11 of deviceetree has some merge conflict
> because patch[3] related to exynos-bus was merged.
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/
> [3] https://patchwork.kernel.org/cover/11303235/
>      - [v2,0/2] Exynos5422: fix bus related OPPs for Odroid XU3/XU4/HC1
> 
> On next version, I'll rebase it on latest patches.

Thank you for the information. I will update the base and continue the
review.

Lukasz
