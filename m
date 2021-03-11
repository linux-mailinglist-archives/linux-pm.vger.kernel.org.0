Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE094336C89
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 07:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhCKGyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 01:54:13 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:11335 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhCKGyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 01:54:12 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210311065410epoutp04a1a1e730ba49384f773c2a28d6d7c3e0~rN0KUjDcR0858908589epoutp042
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 06:54:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210311065410epoutp04a1a1e730ba49384f773c2a28d6d7c3e0~rN0KUjDcR0858908589epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615445650;
        bh=1SKavNcvKEiXQ2vHcHjxl2zorqJ6iU+5NwC0spP2h9I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZBlBwuLjbCUfftkNtwPL2gd9cIQW51ObG+yddvN87OmYaxIxq726MyiZpVJry4HxB
         dBXOMKaMsHEk0dMLO5gDfwH8IFoulhEH7MnM+tOM5SwJfYuyY/lclo0AR0zX9f3P1Y
         OzXnusm7dGFRoAIKVu0pu4yoZLiFwyOk5uaVgaVE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210311065409epcas1p272adc96f7516eadfc7396ab070e8a196~rN0JvjZ3L3111631116epcas1p20;
        Thu, 11 Mar 2021 06:54:09 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Dx06R31rQz4x9Pv; Thu, 11 Mar
        2021 06:54:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.4E.59147.F8EB9406; Thu, 11 Mar 2021 15:54:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210311065406epcas1p374520f410148634741b2b9e2927c9d96~rN0G9J28Q2120621206epcas1p3J;
        Thu, 11 Mar 2021 06:54:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210311065406epsmtrp169106dc6487abccd2583e05d3251a5ac~rN0G8M6tj2566425664epsmtrp1Z;
        Thu, 11 Mar 2021 06:54:06 +0000 (GMT)
X-AuditID: b6c32a38-e3dff7000000e70b-47-6049be8f28b1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.F3.13470.E8EB9406; Thu, 11 Mar 2021 15:54:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210311065406epsmtip18ce31088337cb4f2f880d91a435e18c6~rN0Gnlp9o1552715527epsmtip1P;
        Thu, 11 Mar 2021 06:54:06 +0000 (GMT)
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start
 monitor
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
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
Message-ID: <b5a3ee55-0c71-a0ca-b03f-3b6790f3d2f4@samsung.com>
Date:   Thu, 11 Mar 2021 16:10:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAA+hA=S76yHTeL_yCDkv55iKpBLbtZc_cV8sjORheLxbSuenzA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmgW7/Ps8Eg5dPRCyWXTrKaPFl6i5m
        i2dHtS3+bp7OZrFq6k4Wi7NNb9gtNj2+xmrR9Wsls8XlXXPYLD73HmG0uN24gs3ixRZxBx6P
        nbPusntsWtXJ5rF5Sb3Hxnc7mDz6/xp49G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqt
        kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0JVKCmWJOaVAoYDE4mIlfTubovzSklSF
        jPziElul1IKUnALLAr3ixNzi0rx0veT8XCtDAwMjU6DChOyMX4+OMxXM16v4uGouYwPjDtUu
        Rk4OCQETifX/ZrCD2EICOxgldjV5djFyAdmfGCVaj+5hh3C+MUqcnf+QEabj++6lLBCJvYwS
        3WcPMUE47xkltsxYyApSJSwQIjH59F9mEFtEQFVi7orvjCBFzAJHmCV+TZwAtpBNQEti/4sb
        bCA2v4CixNUfj8FW8ArYSVz+tADMZgFqXrRgFli9qECYxMltLVA1ghInZz5hAbE5BQIleve0
        gi1mFhCXuPVkPhOELS/RvHU2M8TZZzgkbnS4QNguEuvev2GCsIUlXh3fwg5hS0m87G+Dsqsl
        Vp48wgZytIRAB9Bn+y+wQiSMJfYvnQzUzAG0QFNi/S59iLCixM7fcxkh9vJJvPvawwpSIiHA
        K9HRJgRRoixx+cFdqLWSEovbO9kmMCrNQvLNLCQfzELywSyEZQsYWVYxiqUWFOempxYbFpgg
        x/YmRnAK1rLYwTj37Qe9Q4xMHIyHGCU4mJVEeP2OuyUI8aYkVlalFuXHF5XmpBYfYjQFhu9E
        ZinR5HxgFsgriTc0NTI2NrYwMTQzNTRUEudNMngQLySQnliSmp2aWpBaBNPHxMEp1cDkUHk4
        OKg+eofKrB65pbJFTlmlvGmdud2qO6QOaFQ8y1rqc/KO8uEvkhefftIW2vdiv1reRWsVbuFt
        mWWrP1wV1jg9f71OcMuX98sXv9rkWPH93/be95OLM0PCbp48EsnJ33rZvvji9zjHPzKRHFIJ
        M/5fXDk979SLw3xrOdbz5P/suC3ZpFy98/7l3Y+nsa+f8Kz72+4jp6ZldYkcNrpz64jI7+a3
        wXovX1+edXRaxNSuT24lk9jKTq27qrvklVTb20PFGnKGiy+WPy67dmrrZv7Ahr129y8s+L/g
        YtEexioevgI5q9SV7ZetfqT88jjirpQ87eZUp1ktoU0f33hk/3ySWVOY8OfH50nn+f1KHiux
        FGckGmoxFxUnAgBNx67eSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnG7fPs8Eg1PXtC2WXTrKaPFl6i5m
        i2dHtS3+bp7OZrFq6k4Wi7NNb9gtNj2+xmrR9Wsls8XlXXPYLD73HmG0uN24gs3ixRZxBx6P
        nbPusntsWtXJ5rF5Sb3Hxnc7mDz6/xp49G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8avR8eZ
        CubrVXxcNZexgXGHahcjJ4eEgInE991LWboYuTiEBHYzSpx49JgRIiEpMe3iUeYuRg4gW1ji
        8OFiiJq3jBLdi1rZQWqEBUIkJp/+ywxiiwioSsxd8Z0RpIhZ4BizxPot75kgOv4wSzQcmgPW
        wSagJbH/xQ02EJtfQFHi6g+IbbwCdhKXPy0As1mAJi1aMAusXlQgTGLnksdMEDWCEidnPmEB
        sTkFAiV697SygtjMAuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEj
        yypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOB41NLcwbh91Qe9Q4xMHIyHGCU4mJVE
        eP2OuyUI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLTl
        ev3xjs5jk6NdeIS4BXnmdlbM6HyyanvxSZVY9aNbhIuaJucZqzjEzTOfK3N1RgDrE45sr6Xn
        TIIfzG+sq1s5e0bHnW39Zi31YrsYJ7vZ7Og/Wdy/YPv1B+d1pue/uS8db6Ou1tXBJLSM8dzb
        uQp2J613n3fh5DnwOeShTrOJ6+7L/z5Ov3Eq6OZ3+3OHL1ovc7gv4vvknWKc8MSVdqdPlO/8
        viL5DhPfcqZ/KdfTTZYZ1Gp136/9XMm8x3Jz995z4npVmQWs+y3Oa1w6y5HMyrujlPdTiPz6
        oqi0zV5HQjx5OjsPmi5U75zNH34u/v3XyUc/cEwrUoiYuvDPvRlSeZKT4l5k7GA7dEPh+Csl
        luKMREMt5qLiRAA6aptENgMAAA==
X-CMS-MailID: 20210311065406epcas1p374520f410148634741b2b9e2927c9d96
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
        <31be2267-8988-f162-f5a6-6e6389bbf1fb@samsung.com>
        <CAA+hA=S76yHTeL_yCDkv55iKpBLbtZc_cV8sjORheLxbSuenzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/10/21 1:56 PM, Dong Aisheng wrote:
> On Wed, Mar 10, 2021 at 11:08 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> On 3/10/21 11:56 AM, Dong Aisheng wrote:
>>> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>>>
>>>> On 21. 3. 10. 오전 12:58, Chanwoo Choi wrote:
>>>>> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>>>>>> The devfreq monitor depends on the device to provide load information
>>>>>> by .get_dev_status() to calculate the next target freq.
>>>>>>
>>>>>> And this will cause changing governor to simple ondemand fail
>>>>>> if device can't support.
>>>>>>
>>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>>>>> ---
>>>>>>   drivers/devfreq/devfreq.c                 | 10 +++++++---
>>>>>>   drivers/devfreq/governor.h                |  2 +-
>>>>>>   drivers/devfreq/governor_simpleondemand.c |  3 +--
>>>>>>   3 files changed, 9 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>> index 7231fe6862a2..d1787b6c7d7c 100644
>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct
>>>>>> *work)
>>>>>>    * to be called from governor in response to DEVFREQ_GOV_START
>>>>>>    * event when device is added to devfreq framework.
>>>>>>    */
>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>   {
>>>>>>       if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>>>>>> -        return;
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    if (!devfreq->profile->get_dev_status)
>>>>>> +        return -EINVAL;
>>>>
>>>> Again, I think that get_dev_status is not used for all governors.
>>>> So that it cause the governor start fail. Don't check whether
>>>> .get_dev_status is NULL or not.
>>>>
>>>
>>> I'm not quite understand your point.
>>> it is used by governor_simpleondemand.c and tegra_devfreq_governor.
>>> get_target_freq -> devfreq_update_stats -> get_dev_status
>>
>> The devfreq can add the new governor by anyone.
>> So these functions like devfreq_monitor_* have to support
>> the governors and also must support the governor to be added
>> in the future.
> 
> Yes, but devfreq_monitor_* is only used by polling mode, right?
> The governor using it has to implement get_dev_status unless
> there's an exception in the future.
> 
> Currently this patch wants to address the issue that user can switch
> to ondemand governor (polling mode) by sysfs even devices does
> not support it (no get_dev_status implemented).

As I commented, I'll fix this issue. If devfreq driver doesn't implement
the .get_dev_status, don't show it via available_governors. I think that
it is fundamental solution to fix this issue. So on this version,
don't add the this conditional statement on this function

And on next version, please use the capital letter for first character
on patch title as following:

- PM / devfreq: Check get_dev_status before start monitor

> 
> Regards
> Aisheng
> 
>>
>>>
>>> Without checking, device can switch to ondemand governor if it does not support.
>>>
>>> Am i missed something?
>>>
>>> Regards
>>> Aisheng
>>>
>>>>>>       switch (devfreq->profile->timer) {
>>>>>>       case DEVFREQ_TIMER_DEFERRABLE:
>>>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>           INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>>>>>           break;
>>>>>>       default:
>>>>>> -        return;
>>>>>> +        return -EINVAL;
>>>>>>       }
>>>>>>       if (devfreq->profile->polling_ms)
>>>>>>           queue_delayed_work(devfreq_wq, &devfreq->work,
>>>>>>               msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>>> +    return 0;
>>>>>>   }
>>>>>>   EXPORT_SYMBOL(devfreq_monitor_start);
>>>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>>>>>> index 5cee3f64fe2b..31af6d072a10 100644
>>>>>> --- a/drivers/devfreq/governor.h
>>>>>> +++ b/drivers/devfreq/governor.h
>>>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
>>>>>>                   unsigned int event, void *data);
>>>>>>   };
>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
>>>>>>   void devfreq_monitor_stop(struct devfreq *devfreq);
>>>>>>   void devfreq_monitor_suspend(struct devfreq *devfreq);
>>>>>>   void devfreq_monitor_resume(struct devfreq *devfreq);
>>>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
>>>>>> b/drivers/devfreq/governor_simpleondemand.c
>>>>>> index d57b82a2b570..ea287b57cbf3 100644
>>>>>> --- a/drivers/devfreq/governor_simpleondemand.c
>>>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
>>>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct
>>>>>> devfreq *devfreq,
>>>>>>   {
>>>>>>       switch (event) {
>>>>>>       case DEVFREQ_GOV_START:
>>>>>> -        devfreq_monitor_start(devfreq);
>>>>>> -        break;
>>>>>> +        return devfreq_monitor_start(devfreq);
>>>>>>       case DEVFREQ_GOV_STOP:
>>>>>>           devfreq_monitor_stop(devfreq);
>>>>>>
>>>>>
>>>>> Need to handle the all points of devfreq_monitor_start() usage.
>>>>> please check the tegra30-devfreq.c for this update.
>>>>>
>>>>> $ grep -rn "devfreq_monitor_start" drivers/
>>>>> drivers/devfreq/governor_simpleondemand.c:92:
>>>>> devfreq_monitor_start(devfreq);
>>>>> drivers/devfreq/tegra30-devfreq.c:744:
>>>>> devfreq_monitor_start(devfreq);
>>>>> ......
>>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Samsung Electronics
>>>> Chanwoo Choi
>>>
>>>
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
