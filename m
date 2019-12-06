Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA0114B5F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 04:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfLFDVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 22:21:15 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:58038 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLFDVP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 22:21:15 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191206032112epoutp01f7e62f126ca9b6023534ec8aaec9cacd~dqhnMcRBV2460424604epoutp01Z
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 03:21:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191206032112epoutp01f7e62f126ca9b6023534ec8aaec9cacd~dqhnMcRBV2460424604epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575602472;
        bh=S/ssrkUlK7Am25p2QDtbg2ZOh0VPFi8zZoQ4LivLzJQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TsABKPhl7Yq1ZWiRY3HqeZK5TQSmmLI+1rUh4B9KwNyj1LYSHLCncPtSNHqABx6w9
         hUVV4nzddZlAMTItV+FApTUju7VASVgpy+kgNQ/ustPX9tG6kybh/Qjwou4AwSq5nU
         HtWut3lb6OFVbL0o6gJb7PQl09UKLu8voO4wFbdY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191206032111epcas1p4c84ebbcb2efc4cde6d833af2c933543e~dqhmjOTMS0921309213epcas1p4B;
        Fri,  6 Dec 2019 03:21:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47TdCT3cvrzMqYkV; Fri,  6 Dec
        2019 03:21:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.CB.51241.529C9ED5; Fri,  6 Dec 2019 12:21:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191206032108epcas1p114095dd6bb1338a44525cfc2893834e3~dqhjmLBRe1217212172epcas1p1m;
        Fri,  6 Dec 2019 03:21:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206032108epsmtrp2145ed7a83446b70aeeefb9a37eddc472~dqhjlUqI-1817518175epsmtrp2y;
        Fri,  6 Dec 2019 03:21:08 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-40-5de9c92548a6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.72.06569.429C9ED5; Fri,  6 Dec 2019 12:21:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206032108epsmtip12b5a4335a85ced8a3edb1648be7bc1b8~dqhjVZxLC2406524065epsmtip12;
        Fri,  6 Dec 2019 03:21:08 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f98b309f-028a-c78e-8698-765bbd52b204@samsung.com>
Date:   Fri, 6 Dec 2019 12:27:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023F70C008F07482DEFD9D5EE5C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmvq7qyZexBs8aZCwOHdvKbnF/Xiuj
        xfS9m9gszja9YbdYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3G1ewWaw+d5DNYu6XqcwW
        Z05fYrXY+NXDgc9jdsNFFo9NqzrZPO5c28PmsXlJvcfGdzuYPA6+28PkseVqO4tH35ZVjB6f
        N8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        3a6kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAy
        BSpMyM5Yst+tYLNCxaKVl5gbGG9KdzFyckgImEg82zWdtYuRi0NIYAejxL4vm9ghnE+MEtd/
        72OGcL4xSvz41MsG07Lq7ypGiMReRolL0/czQTjvGSVerFvN0sXIwSEs4CDxp0UaJC4i0MQo
        8W9eD9hcZoE3zBKXe06wgoxiE9CS2P/iBthYfgFFias/HjOC2LwCdhLn1z0Ei7MIqEj0TFkA
        Vi8qECZxclsLVI2gxMmZT1hAbE6BWIllU98zgdjMAnoSz07NYoGwxSVuPZkPFZeX2P52Dtg/
        EgKH2CXef5rADvGPi8Sx/r1QvwlLvDq+BSouJfH5HUy8WmLlySNsEM0djBJb9l9ghUgYS+xf
        OpkJwlaU2Pl7LiPENj6Jd197WEFBISHAK9HRJgRRoixx+cFdqHJJicXtnWwTGJVmIflnFpIf
        ZiH5YRaSHxYwsqxiFEstKM5NTy02LDBFjvBNjOCkrWW5g/HYOZ9DjAIcjEo8vDM+v4gVYk0s
        K67MPcQowcGsJMKbzvcyVog3JbGyKrUoP76oNCe1+BCjKTC8JzJLiSbnAzNKXkm8oamRsbGx
        hYmhmamhoZI4L8ePi7FCAumJJanZqakFqUUwfUwcnFINjEdt9avUw+eFzDPbyf1uY+iHf+fN
        OxNDVPfmKn584Zp0cdqXr2G/p9d8u/fkY/9/u2kWD0QO/2Pb56DgcvikeAxLxCK1g6cT9pl7
        7g7v6PdxCt95t1xDUDtBN2f6G93txYUWq67sY74w9dqBgnN8KjKWOdeO/Dh5uKT06aeKxr9d
        LyV5z/XoxSuxFGckGmoxFxUnAgBybZtr8AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSnK7KyZexBrN3ylgcOraV3eL+vFZG
        i+l7N7FZnG16w26x4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1uN65gs1h97iCbxdwvU5kt
        zpy+xGqx8auHA5/H7IaLLB6bVnWyedy5tofNY/OSeo+N73YweRx8t4fJY8vVdhaPvi2rGD0+
        b5IL4IzisklJzcksSy3St0vgyliy361gs0LFopWXmBsYb0p3MXJySAiYSKz6u4qxi5GLQ0hg
        N6PE1uddbBAJSYlpF48ydzFyANnCEocPF0PUvGWUWNb6lwkkLizgIPGnRRokLiLQwijRt3o1
        K4jDLPCOWWJBcyMLRMcKJomuaWuYQaayCWhJ7H9xA2wDv4CixNUfjxlBbF4BO4nz6x6CxVkE
        VCR6pixgBbFFBcIkdi55zARRIyhxcuYTFhCbUyBWYtnU92BxZgEdibbPC6FscYlbT+ZD2fIS
        29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cORqae1gPHEi/hCjAAejEg/vjM8vYoVYE8uKK3MPMUpwMCuJ8KbzvYwV4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwGh2t0yjVopBc4n3munP15fZM537
        vejXgeyqHvnzgg/L2y+HVERe+PP+vVqg93+eujk3fc/9zzgrE6D+apnVv0M7zi6Z6SReYBca
        t5Tpc0nrkr49npGyfsdF/hnEe03K8FjktoB5N+NmRrv8qUsnO7PfP3gxbvKzvk+lsn2fa3fb
        N7Y3svx59UeJpTgj0VCLuag4EQD0r3VT2AIAAA==
X-CMS-MailID: 20191206032108epcas1p114095dd6bb1338a44525cfc2893834e3
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191205104541epcas1p13a7fb13df8ca6565e10ec558be535152
References: <cover.1575540224.git.leonard.crestez@nxp.com>
        <CAJZ5v0jEuecAUS_BmxEWVdiMXEKh0ScxH1UW6udONxzqL+c3Vg@mail.gmail.com>
        <CGME20191205104541epcas1p13a7fb13df8ca6565e10ec558be535152@epcas1p1.samsung.com>
        <VI1PR04MB7023F70C008F07482DEFD9D5EE5C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/5/19 7:44 PM, Leonard Crestez wrote:
> On 2019-12-05 12:13 PM, Rafael J. Wysocki wrote:
>> On Thu, Dec 5, 2019 at 11:05 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>>>
>>> Add dev_pm_qos notifiers to devfreq core in order to support frequency
>>> limits via dev_pm_qos_add_request.
>>>
>>> Unlike the rest of devfreq the dev_pm_qos frequency is measured in kHz,
>>> this is consistent with current dev_pm_qos usage for cpufreq and
>>> allows frequencies above 2Ghz (pm_qos expresses limits as s32).
>>>
>>> Like with cpufreq the handling of min_freq/max_freq is moved to the
>>> dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
>>> store, instead all values can be written and we only check against OPPs in a
>>> new devfreq_get_freq_range function. This is consistent with the design of
>>> dev_pm_qos.
>>>
>>> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
>>> need to take devfreq->lock, this means that calls into dev_pm_qos while holding
>>> devfreq->lock are not allowed (lockdep warns about possible deadlocks).
>>>
>>> Fix this by only adding the qos request and notifiers after devfreq->lock is
>>> released inside devfreq_add_device. In theory this means sysfs writes
>>> are possible before the min/max requests are initialized so we guard
>>> against that explictly. The dev_pm_qos_update_request function would
>>> otherwise print a big WARN splat.
>>>
>>> This series depends on recently accepted series restoring
>>> DEV_PM_QOS_MIN/MAX_FREQUENCY inside the pm core:
>>>
>>>          https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11262633%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C265c079a936b4c2a9c6608d7796bbc16%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637111375932506745&amp;sdata=uI0if7aNnedxEsMlNQ4sCDOElVBxCp%2B%2BVGaeZC0DaMk%3D&amp;reserved=0
>>>
>>> It would be great for this to get into 5.5-rc1
>>
>> Not at this point.  The earliest realistic target can be -rc2.
>>
>> Does this still depend on anything which has not been included into
>> the Linus' tree to date?
> 
> This series depends on DEV_PM_QOS_MIN/MAX_FREQUENCY and that's already 
> in. It also depends on a few other patches from devfreq-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=1d81785fd070088c952fd9f0d8cb4c47c192122b
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=a2b3d24b75036c44a5509e9ec3a5c14672e98c73
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=0f68bfe7d58dfb49972f93768f9fdd97ce205844

And this patch depends on patch[1] in order to prevent the merge conflict.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-fixes&id=6306ad828b335ba967d2f3c2cbfdb84ebda46cb8

For sending the devfreq pm-qos features for rc2 period,
- "devfreq-fixes" branch contains the required patches for devfreq pm-qos feature.
- "devfreq-testing-pm-qos" branch contains the devfreq pm-qos feature based on devfreq-fixes branch.
  To prevent the build error, applied the following four patches picked from linux-pm.git.
	PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCYdevfreq-testing-pm-qos
	PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
	PM / QoS: Initial kunit test
	PM / QoS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
: https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

After released the v5.5-rc1, I'll send the devfreq pm-qos patches.

> 
> It doesn't currently apply on torvalds/master
> 
> There are some interconnect patches which depend on this for proper 
> functionality but we can figure something out with icc maintainer.
> 
> * https://patchwork.kernel.org/cover/11244421/
> * https://patchwork.kernel.org/patch/11153917/
> 
> I personally always test with linux-next so RC schedules don't affect me 
> very much.
> 
> --
> Regards,
> Leonard
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
