Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E83114BBE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 05:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfLFEtB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 23:49:01 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:62550 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfLFEtB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 23:49:01 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191206044857epoutp0285b97eef4f337acd37d0b8b3633300fe~druOeeaD31933619336epoutp02c
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 04:48:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191206044857epoutp0285b97eef4f337acd37d0b8b3633300fe~druOeeaD31933619336epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575607737;
        bh=98EpzWRqTaw820CpOipjqLPhwdJjteNTaPAwmorOCQg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mzh/QWXOJVKeZK3Zo2EQ6fsb9UIR2o58kMDYH3ppMun1BNmumC3KJAYwW8mlIJ9Aw
         6RtvCz3v3GYOIof4sR7anDFzjreyQVkqBs5YntyTti7EchZlJmYDBLCImU7RcqvurP
         E+aiTTsoAlLR68+bMmJemsunaZWo2F03hqJUpQOs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191206044856epcas1p33344c60914a2bad71e11907e27087873~druN6S5oD1335313353epcas1p3D;
        Fri,  6 Dec 2019 04:48:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Tg8l4bClzMqYkg; Fri,  6 Dec
        2019 04:48:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.5D.48019.CADD9ED5; Fri,  6 Dec 2019 13:48:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191206044844epcas1p355dd1e712879d6bd5a777cbb1f9cb55d~druCd4mpy1335313353epcas1p3k;
        Fri,  6 Dec 2019 04:48:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206044844epsmtrp1bcc63a8d5166779883bfe152a42b1deb~druCczyFj2461424614epsmtrp1Q;
        Fri,  6 Dec 2019 04:48:44 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-db-5de9ddaceb0b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.66.10238.CADD9ED5; Fri,  6 Dec 2019 13:48:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206044844epsmtip19d31e4afa69789fc7be1efa4da91c958~druCLLM5X1202412024epsmtip1_;
        Fri,  6 Dec 2019 04:48:44 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] PM / devfreq: Add dev_pm_qos support
From:   Chanwoo Choi <cw00.choi@samsung.com>
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
Organization: Samsung Electronics
Message-ID: <8065d609-da24-76bc-8425-652d1fd83768@samsung.com>
Date:   Fri, 6 Dec 2019 13:54:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <f98b309f-028a-c78e-8698-765bbd52b204@samsung.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmnu6auy9jDabPNbU4dGwru8X9ea2M
        FtP3bmKzONv0ht1ixd2PrBabHl9jtej6tZLZ4nPvEUaLzxseM1rcblzBZrH63EE2i7lfpjJb
        nDl9idVi41cPBz6P2Q0XWTw2repk87hzbQ+bx+Yl9R4b3+1g8jj4bg+Tx5ar7SwefVtWMXp8
        3iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDI
        FKgwITvjz6ItTAWTlStOPuhkbGDskuti5OSQEDCReP/lHmMXIxeHkMAORokP79YwQzifGCVO
        b9sB5XxjlJjz8AcLTMu7r+uhWvYySix9tJINwnnPKLHu0D/2LkYODmEBB4k/LdIgDWwCWhL7
        X9wAqxERaGKU+Devhx3EYRZ4wyxxuecEK0gVv4CixNUfjxlBbF4BO4lnZ5aCrWMRUJHYv/IY
        mC0qECZxclsLVI2gxMmZT1hAlnEK2Eus2igFEmYW0JN4dmoWC4QtLnHryXwmCFteYvvbOcwQ
        Hxxil3h43RvCdpHobJzEBGELS7w6voUdwpaSeNnfBmVXS6w8eQTsAQmBDkaJLfsvsEIkjCX2
        L50M1awosfP3XEaIZXzAIOphBblNQoBXoqNNCKJEWeLyg7tQ5ZISi9s72SYwKs1C8s0sJC/M
        QvLCLCQvLGBkWcUollpQnJueWmxYYIIc35sYwSlby2IH455zPocYBTgYlXh4Z3x+ESvEmlhW
        XJl7iFGCg1lJhDed72WsEG9KYmVValF+fFFpTmrxIUZTYGhPZJYSTc4H5pO8knhDUyNjY2ML
        E0MzU0NDJXFejh8XY4UE0hNLUrNTUwtSi2D6mDg4pRoYF3BKOaffcJApZlGf3L7ScG1E+RS5
        rZdmr9/du0H734Y/b5dMWKz1Yn3dpL36dponJwddt17NF/3hmdeeHIPv359Oy5W4MJPzWsGa
        ghuJIq47/W7mL1Nw+iHjuPVIdfkyjWWL2IKF/d9+nnmp9tG2+VE6O1xlnm2eVHNlzknPpdOv
        fWw5KrVN20CJpTgj0VCLuag4EQA8OWnG7wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSnO6auy9jDV4e5rc4dGwru8X9ea2M
        FtP3bmKzONv0ht1ixd2PrBabHl9jtej6tZLZ4nPvEUaLzxseM1rcblzBZrH63EE2i7lfpjJb
        nDl9idVi41cPBz6P2Q0XWTw2repk87hzbQ+bx+Yl9R4b3+1g8jj4bg+Tx5ar7SwefVtWMXp8
        3iQXwBnFZZOSmpNZllqkb5fAlfFn0RamgsnKFScfdDI2MHbJdTFyckgImEi8+7qesYuRi0NI
        YDejRO/LDUwQCUmJaRePMncxcgDZwhKHDxdD1LxllFj15S0TSFxYwEHiT4s0SDmbgJbE/hc3
        2EBqRARaGCX6Vq9mBXGYBd4xSyxobmSB6L7LJNH6di4jSAu/gKLE1R+PwWxeATuJZ2eWsoDY
        LAIqEvtXHgOzRQXCJHYuecwEUSMocXLmExaQzZwC9hKrNkqBhJkFdCTaPi9kgrDFJW49mQ9l
        y0tsfzuHeQKj8Cwk3bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5
        mxjBkauluYPx8pL4Q4wCHIxKPLwzPr+IFWJNLCuuzD3EKMHBrCTCm873MlaINyWxsiq1KD++
        qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxj73lToTrpXUNW6LOlrO4S3z
        ZK9PkE0GG/9dpl33P8UVVi9a5349M/T1qoi6nb3SQQc4Zq49pn5h+qEFDvGblq0v2Ca7eGuy
        JJ9ml3Zw882Jes72Sacso0p+tomwt7vOd7EtiJlvGbzmRv8SDl/3kK7D9wOEZU5vWhbw4cOW
        QMY9AY8ibJ/OV2Ipzkg01GIuKk4EAI8krerYAgAA
X-CMS-MailID: 20191206044844epcas1p355dd1e712879d6bd5a777cbb1f9cb55d
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
        <f98b309f-028a-c78e-8698-765bbd52b204@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/6/19 12:27 PM, Chanwoo Choi wrote:
> On 12/5/19 7:44 PM, Leonard Crestez wrote:
>> On 2019-12-05 12:13 PM, Rafael J. Wysocki wrote:
>>> On Thu, Dec 5, 2019 at 11:05 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>>>>
>>>> Add dev_pm_qos notifiers to devfreq core in order to support frequency
>>>> limits via dev_pm_qos_add_request.
>>>>
>>>> Unlike the rest of devfreq the dev_pm_qos frequency is measured in kHz,
>>>> this is consistent with current dev_pm_qos usage for cpufreq and
>>>> allows frequencies above 2Ghz (pm_qos expresses limits as s32).
>>>>
>>>> Like with cpufreq the handling of min_freq/max_freq is moved to the
>>>> dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
>>>> store, instead all values can be written and we only check against OPPs in a
>>>> new devfreq_get_freq_range function. This is consistent with the design of
>>>> dev_pm_qos.
>>>>
>>>> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
>>>> need to take devfreq->lock, this means that calls into dev_pm_qos while holding
>>>> devfreq->lock are not allowed (lockdep warns about possible deadlocks).
>>>>
>>>> Fix this by only adding the qos request and notifiers after devfreq->lock is
>>>> released inside devfreq_add_device. In theory this means sysfs writes
>>>> are possible before the min/max requests are initialized so we guard
>>>> against that explictly. The dev_pm_qos_update_request function would
>>>> otherwise print a big WARN splat.
>>>>
>>>> This series depends on recently accepted series restoring
>>>> DEV_PM_QOS_MIN/MAX_FREQUENCY inside the pm core:
>>>>
>>>>          https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11262633%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C265c079a936b4c2a9c6608d7796bbc16%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637111375932506745&amp;sdata=uI0if7aNnedxEsMlNQ4sCDOElVBxCp%2B%2BVGaeZC0DaMk%3D&amp;reserved=0
>>>>
>>>> It would be great for this to get into 5.5-rc1
>>>
>>> Not at this point.  The earliest realistic target can be -rc2.
>>>
>>> Does this still depend on anything which has not been included into
>>> the Linus' tree to date?
>>
>> This series depends on DEV_PM_QOS_MIN/MAX_FREQUENCY and that's already 
>> in. It also depends on a few other patches from devfreq-next:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=1d81785fd070088c952fd9f0d8cb4c47c192122b
>> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=a2b3d24b75036c44a5509e9ec3a5c14672e98c73
>> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=0f68bfe7d58dfb49972f93768f9fdd97ce205844
> 
> And this patch depends on patch[1] in order to prevent the merge conflict.
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-fixes&id=6306ad828b335ba967d2f3c2cbfdb84ebda46cb8
> 
> For sending the devfreq pm-qos features for rc2 period,
> - "devfreq-fixes" branch contains the required patches for devfreq pm-qos feature.
> - "devfreq-testing-pm-qos" branch contains the devfreq pm-qos feature based on devfreq-fixes branch.
>   To prevent the build error, applied the following four patches picked from linux-pm.git.
> 	PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCYdevfreq-testing-pm-qos
> 	PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
> 	PM / QoS: Initial kunit test
> 	PM / QoS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
> : https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

I'm sorry. I wrote the wrong branch name previously.
Write the correct url of "devfreq-testing-pm-qos" branch.
: https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-pm-qos

> 
> After released the v5.5-rc1, I'll send the devfreq pm-qos patches.
> 
>>
>> It doesn't currently apply on torvalds/master
>>
>> There are some interconnect patches which depend on this for proper 
>> functionality but we can figure something out with icc maintainer.
>>
>> * https://patchwork.kernel.org/cover/11244421/
>> * https://patchwork.kernel.org/patch/11153917/
>>
>> I personally always test with linux-next so RC schedules don't affect me 
>> very much.
>>
>> --
>> Regards,
>> Leonard
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
