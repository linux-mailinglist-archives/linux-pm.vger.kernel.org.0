Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CC63333A1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 04:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhCJDJT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 22:09:19 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:14144 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhCJDI4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 22:08:56 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210310030854epoutp01cf6c8c4e68e7605d731b30db04bd92ac~q3GMq1-N11172111721epoutp01c
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:08:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210310030854epoutp01cf6c8c4e68e7605d731b30db04bd92ac~q3GMq1-N11172111721epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615345734;
        bh=u6LWVhklORJCQniApS2trCO6hM0Uulf6xgJQQBG6QmY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Nf5Ch+ZtJmc6OGzr4htcpwdx2T8z4k1rtq4vM9hIV5klv+pdIhRRygcLNFo52blnh
         1KHrwxheDWvnINVCk+25YBUlRbdQQdbrzGxt2WFwSRLI7OyIpGv/DAjJmuEDdBjzcg
         Cy7P5b1g5v2Ai2ZQD4ZkZ0CCeLdQhr+UjetJlMr8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210310030853epcas1p1b75f93310a3e58e6e56007546422ffb7~q3GLfC9d92679026790epcas1p1D;
        Wed, 10 Mar 2021 03:08:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DwH8y5KLqz4x9Pv; Wed, 10 Mar
        2021 03:08:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.FA.59147.24838406; Wed, 10 Mar 2021 12:08:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210310030849epcas1p14d94cf79d0879a82784373ed1fafed4b~q3GHtrkix2679026790epcas1p19;
        Wed, 10 Mar 2021 03:08:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210310030849epsmtrp2070d50a4d94739a54ab6efcd0abbeb3a~q3GHs0nNR2333523335epsmtrp2i;
        Wed, 10 Mar 2021 03:08:49 +0000 (GMT)
X-AuditID: b6c32a38-e53ff7000000e70b-84-6048384202e8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.A8.13470.14838406; Wed, 10 Mar 2021 12:08:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210310030849epsmtip11bf9c5b37c25b12799c3753d13e2337e~q3GHaUE4V2646326463epsmtip1v;
        Wed, 10 Mar 2021 03:08:49 +0000 (GMT)
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start
 monitor
To:     Dong Aisheng <dongas86@gmail.com>,
        Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Abel Vesa <abel.vesa@nxp.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <31be2267-8988-f162-f5a6-6e6389bbf1fb@samsung.com>
Date:   Wed, 10 Mar 2021 12:25:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAA+hA=QZbxE-aFh2UnH6wHBUStj8SAtW8C4SEZtGcxQwsOO=Aw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmvq6ThUeCwaFXGhbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGigU7WQpmqlRs7bvI2sDYLtvF
        yMkhIWAiMeP8edYuRi4OIYEdjBJbeiezgiSEBD4xStw9JAKR+MYo8fnsLiaYjjfbW6E69jJK
        /D25mhnCec8ocbjrIViVsECIxOTTf5lBbBEBD4lL06ewgRQxCyxklvi85xELSIJNQEti/4sb
        bCA2v4CixNUfjxlBbF4BO4nHX1eANbMIqErM7N/IDmKLCoRJnNzWAlUjKHFy5hOwOZwCgRKz
        py8Eq2cWEJe49WQ+E4QtL9G8dTbYdRICZzgkFn3YBeSwAzkuEs8EIL4Rlnh1fAs7hC0l8fnd
        XjYIu1pi5ckjbBCtHcBw2X+BFSJhLLF/6WSg+RxA8zUl1u/ShwgrSuz8PZcRYi2fxLuvPawg
        JRICvBIdbUIQJcoSlx/chQaipMTi9k62CYxKs5A8MwvJA7OQPDALYdkCRpZVjGKpBcW56anF
        hgUmyJG9iRGcgLUsdjDOfftB7xAjEwfjIUYJDmYlEV6/424JQrwpiZVVqUX58UWlOanFhxhN
        gcE7kVlKNDkfmAPySuINTY2MjY0tTAzNTA0NlcR5kwwexAsJpCeWpGanphakFsH0MXFwSjUw
        lbLFcD6z2Pl7O1vni3TPvoVz2pI7DjAc0WznbOB24BVUOS3M7v5t/3wlvzV+/B1Mj1W2prHG
        KCnNuLvw2ZKPtXezMu/+vGcoJphwp27np4/Hl+/3iDkwm0t96hrmpZGGf2evi41tvnnp6NvL
        fYz3Zsq9Clv1PVJxYp6U7uTAU5f3FKmcfNfWIW6nEJ/T1Hfh1IFjEyVW57j+WWt3k8NOofc1
        25S6T7Na1l+3kb4YevSq3sTu7fL3asz11y9y/pJy+9iLTfyH8qWP5TAvjm79kytcb/8uce/U
        p3nKhYtuPeys+7zqMEf7rUlWbFM2tqYuclrqOM3YomXZNsYv/7Pkue7mHcya0VcVxufoflR1
        shJLcUaioRZzUXEiADRMs1xJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnK6jhUeCwZT74hbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2PFgp0s
        BTNVKrb2XWRtYGyX7WLk5JAQMJF4s72VtYuRi0NIYDejxMbdfWwQCUmJaRePMncxcgDZwhKH
        DxdD1LxllHh9bjVYjbBAiMTk03+ZQWwRAQ+JS9OnsIEUMQssZJZYuHcFM0RHA7PE3pfXmECq
        2AS0JPa/uAHWzS+gKHH1x2NGEJtXwE7i8dcVYJNYBFQlZvZvZAexRQXCJHYuecwEUSMocXLm
        ExYQm1MgUGL29IVg9cwC6hJ/5l2CssUlbj2ZzwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUB
        I8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgeNTS3MG4fdUHvUOMTByMhxglOJiV
        RHj9jrslCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDU
        ZbTPcfP27jOhFReMDrCdksqIvVebseS/8jO9+Ifurmbu1X7pC4SsTV6sy9kjrxZ6gInDSWxZ
        ilxcY/tZi4KrH0Wf8X3Z6CxQKHqq/hDnouSpZvlhnw96Z/6MfPinJvhu1XeGRrMLRVeFo3tS
        70WczE63qUn6zDuf6U/C9G0bI26WXv4oK63FzJp47fjNnp49U7X7mbYr8m36riW0gfnR1xD7
        eI3EA78u/Bb87m2tksZwcX9w29edjJ/PScydPeW3DnPjXzeTI81uzvv+pOd5Zq2+o2RwlVHr
        6arvr2/9+lr01dP4Tf3hReu5T3y9WCmdrPyxo7p1qmvx+eXujDZXqvr/mkw+HesdfE1niaUS
        S3FGoqEWc1FxIgB+ZENmNgMAAA==
X-CMS-MailID: 20210310030849epcas1p14d94cf79d0879a82784373ed1fafed4b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210310025703epcas1p10fdb324cc7ce1accfdc8f66315e8a93e
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
        <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com>
        <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
        <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com>
        <CGME20210310025703epcas1p10fdb324cc7ce1accfdc8f66315e8a93e@epcas1p1.samsung.com>
        <CAA+hA=QZbxE-aFh2UnH6wHBUStj8SAtW8C4SEZtGcxQwsOO=Aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/10/21 11:56 AM, Dong Aisheng wrote:
> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>
>> On 21. 3. 10. 오전 12:58, Chanwoo Choi wrote:
>>> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>>>> The devfreq monitor depends on the device to provide load information
>>>> by .get_dev_status() to calculate the next target freq.
>>>>
>>>> And this will cause changing governor to simple ondemand fail
>>>> if device can't support.
>>>>
>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>>> ---
>>>>   drivers/devfreq/devfreq.c                 | 10 +++++++---
>>>>   drivers/devfreq/governor.h                |  2 +-
>>>>   drivers/devfreq/governor_simpleondemand.c |  3 +--
>>>>   3 files changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 7231fe6862a2..d1787b6c7d7c 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct
>>>> *work)
>>>>    * to be called from governor in response to DEVFREQ_GOV_START
>>>>    * event when device is added to devfreq framework.
>>>>    */
>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
>>>>   {
>>>>       if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>>>> -        return;
>>>> +        return 0;
>>>> +
>>>> +    if (!devfreq->profile->get_dev_status)
>>>> +        return -EINVAL;
>>
>> Again, I think that get_dev_status is not used for all governors.
>> So that it cause the governor start fail. Don't check whether
>> .get_dev_status is NULL or not.
>>
> 
> I'm not quite understand your point.
> it is used by governor_simpleondemand.c and tegra_devfreq_governor.
> get_target_freq -> devfreq_update_stats -> get_dev_status

The devfreq can add the new governor by anyone.
So these functions like devfreq_monitor_* have to support 
the governors and also must support the governor to be added
in the future.

> 
> Without checking, device can switch to ondemand governor if it does not support.
> 
> Am i missed something?
> 
> Regards
> Aisheng
> 
>>>>       switch (devfreq->profile->timer) {
>>>>       case DEVFREQ_TIMER_DEFERRABLE:
>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>>>           INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>>>           break;
>>>>       default:
>>>> -        return;
>>>> +        return -EINVAL;
>>>>       }
>>>>       if (devfreq->profile->polling_ms)
>>>>           queue_delayed_work(devfreq_wq, &devfreq->work,
>>>>               msecs_to_jiffies(devfreq->profile->polling_ms));
>>>> +    return 0;
>>>>   }
>>>>   EXPORT_SYMBOL(devfreq_monitor_start);
>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>>>> index 5cee3f64fe2b..31af6d072a10 100644
>>>> --- a/drivers/devfreq/governor.h
>>>> +++ b/drivers/devfreq/governor.h
>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
>>>>                   unsigned int event, void *data);
>>>>   };
>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
>>>>   void devfreq_monitor_stop(struct devfreq *devfreq);
>>>>   void devfreq_monitor_suspend(struct devfreq *devfreq);
>>>>   void devfreq_monitor_resume(struct devfreq *devfreq);
>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
>>>> b/drivers/devfreq/governor_simpleondemand.c
>>>> index d57b82a2b570..ea287b57cbf3 100644
>>>> --- a/drivers/devfreq/governor_simpleondemand.c
>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct
>>>> devfreq *devfreq,
>>>>   {
>>>>       switch (event) {
>>>>       case DEVFREQ_GOV_START:
>>>> -        devfreq_monitor_start(devfreq);
>>>> -        break;
>>>> +        return devfreq_monitor_start(devfreq);
>>>>       case DEVFREQ_GOV_STOP:
>>>>           devfreq_monitor_stop(devfreq);
>>>>
>>>
>>> Need to handle the all points of devfreq_monitor_start() usage.
>>> please check the tegra30-devfreq.c for this update.
>>>
>>> $ grep -rn "devfreq_monitor_start" drivers/
>>> drivers/devfreq/governor_simpleondemand.c:92:
>>> devfreq_monitor_start(devfreq);
>>> drivers/devfreq/tegra30-devfreq.c:744:
>>> devfreq_monitor_start(devfreq);
>>> ......
>>>
>>
>>
>> --
>> Best Regards,
>> Samsung Electronics
>> Chanwoo Choi
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
