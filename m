Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D548340236
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCRJhf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:37:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:54407 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhCRJhZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 05:37:25 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210318093723epoutp0392b68666f1348bd8b94e440ad41ff727~tZjqdWFM52029920299epoutp03q
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 09:37:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210318093723epoutp0392b68666f1348bd8b94e440ad41ff727~tZjqdWFM52029920299epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616060243;
        bh=6SaYaiy79O/OjpADCgJc+9tLRpr4nVMSOT6EqKFfGoA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LS4Sfhf+p1LIP3CKXRvy00se3h2TzBRX9cqKNX+NxmZcsLgrOSyad4xvNnFqFpz5S
         MuxYXtZrmPBBPev0gAPBDTFMxTvdMiAL/8oDtkZbWDRaN7DxTfO1iSqVqinA0rrSRJ
         w2PePuDk7p+Hp6WwhUslWy7tXdr625UQprefaokQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210318093722epcas1p3d0c1344e378b1c5140ece27424c297a1~tZjp5QWhv2607326073epcas1p3q;
        Thu, 18 Mar 2021 09:37:22 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F1MPX3Sbzz4x9Pv; Thu, 18 Mar
        2021 09:37:20 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.D0.02418.05F13506; Thu, 18 Mar 2021 18:37:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210318093719epcas1p431f8a1f49fe3ec457475b5fdd14772ab~tZjnK6mFC0400004000epcas1p4d;
        Thu, 18 Mar 2021 09:37:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210318093719epsmtrp2bd8749122724c0e6573787a2e847c76a~tZjnJVYl_1994919949epsmtrp2G;
        Thu, 18 Mar 2021 09:37:19 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-f2-60531f504bdb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.4F.08745.F4F13506; Thu, 18 Mar 2021 18:37:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210318093719epsmtip24f0933735e134abd03418a3e3693ceac~tZjm3HSn-2653226532epsmtip2Z;
        Thu, 18 Mar 2021 09:37:19 +0000 (GMT)
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
Message-ID: <0e518145-5cae-63f1-c32f-e6207fdeae54@samsung.com>
Date:   Thu, 18 Mar 2021 18:54:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAA+hA=QOhUH19an+=p5womfp+oJRJPrFoVuLN4Ai0oezB8myNQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmgW6AfHCCwcpPEhbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGkt9iBf88K9Z/e8rSwPjLuouR
        k0NCwETi7YrfTF2MXBxCAjsYJb5db2OHcD4xSjRO+waV+cwosfnaRHaYlk9bHjBDJHYxSnxu
        2A7lvGeUOHL1BiNIlbBAiMTk03+ZQWwRAQ+JS9OnsIEUMQssZJb4vOcRC0iCTUBLYv+LG2wg
        Nr+AosTVH4/BmnkF7CS6jq1iArFZBFQleroh4qICYRInt7VA1QhKnJz5BGwOp0CgxKmep2Dn
        MQuIS9x6Mp8JwpaXaN46G+w6CYETHBKtn5ewQPzgIvFzQTcbhC0s8er4FqjfpCQ+v9sLFa+W
        WHnyCBtEcwejxJb9F1ghEsYS+5dOBtrAAbRBU2L9Ln2IsKLEzt9zGSEW80m8+9rDClIiIcAr
        0dEmBFGiLHH5wV0mCFtSYnF7J9sERqVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAkPk
        6N7ECE7CWqY7GCe+/aB3iJGJg/EQowQHs5IIr2leQIIQb0piZVVqUX58UWlOavEhRlNgAE9k
        lhJNzgfmgbySeENTI2NjYwsTQzNTQ0Mlcd4kgwfxQgLpiSWp2ampBalFMH1MHJxSDUz2aRYB
        oqFKHB2ffHQVDCr/v221FnfwbVi2g+Fq3fS5XL+aPA/xm5orbZvRc9w0yX5l7qW7Sxw4tYPd
        9AyVrF9dLE8WfFndX6hsdjUlimeKwPrI2TtnuZxZmtHgpvszoHihhJbTkVPPeGMlVpq3ft77
        ald50883T67pM08zerb50/n2fbcDo04HKafNPl184fyGrLzkw1JR7E+2OErmbb4YvvPwrIuO
        ByrUe05NaXO+oScR/frzjeDoRZnmj0WWMlgfdjFb2D31uMY/N6e5XvnvdzNWlO35mc6ZVm26
        yPHz6VtBXDrmRpWHSvbJHd05w/LC9p2bbS+rNflucmNpdv+iYmAU/39ygfxLzquaHEosxRmJ
        hlrMRcWJAIkeuJlLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvK6/fHCCwYNXShbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2PJb7GC
        f54V6789ZWlg/GXdxcjJISFgIvFpywPmLkYuDiGBHYwSnztesEIkJCWmXTwKlOAAsoUlDh8u
        hqh5yyjxbMYDJpAaYYEQicmn/zKD2CICHhKXpk9hAyliFljILLFw7wqoqTvZJHq7d7KDVLEJ
        aEnsf3GDDcTmF1CUuPrjMSOIzStgJ9F1bBXYVBYBVYmeboi4qECYxM4lj5kgagQlTs58wgJi
        cwoESpzqeQo2k1lAXeLPvEvMELa4xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZ
        xSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHI1aWjsY96z6oHeIkYmD8RCjBAezkgiv
        aV5AghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M7Q3L
        mDZNVyu20ZgTtPtR9NIdTY+WFe4UZX57I+KvwpYvXG7n+yvTra7zss/itrn8l9l3d2u6WmWC
        6n416d/X5/dYTIjdtMqc/3yXyLWFF0Mbk35d2aO0NfazLF/ClAq/WUyRxi8nbBDYETSjVf4k
        i7a6b7B81DWvIgvrq1dO12zasme9l1Dh6rCk8H0tEW+uKNx/5lCwP9/uZ7dK1wWmrSd9l97a
        9aW4PUd0pfdVHWcb3q9XPHvv5h6a9reWN7rwoVX20pcpB3mOpO6Z9oJr94XFrVd90mftWeHV
        8XRfLCsTV725m7nX5KvnHgb99lx+qW37VLuDV97bvNZd2Km3J+Zc+8xiyTOh2g3bRD2+KbEU
        ZyQaajEXFScCAHOyU0c1AwAA
X-CMS-MailID: 20210318093719epcas1p431f8a1f49fe3ec457475b5fdd14772ab
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
        <b5a3ee55-0c71-a0ca-b03f-3b6790f3d2f4@samsung.com>
        <CAA+hA=Q0M0bTf0VLjNmf23HqFn4Unk0h4BN-mEQXb1LkZLV=NQ@mail.gmail.com>
        <d92b7660-a622-06f3-6e1f-03c99fdf0a55@gmail.com>
        <CAA+hA=T3A=FW-kCu=3jDTP+o3JpPYVB6VnphazXVkybGZCanaQ@mail.gmail.com>
        <CAA+hA=QOhUH19an+=p5womfp+oJRJPrFoVuLN4Ai0oezB8myNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/18/21 5:03 PM, Dong Aisheng wrote:
> Hi Chanwoo,
> 
> On Sat, Mar 13, 2021 at 2:45 PM Dong Aisheng <dongas86@gmail.com> wrote:
>>
>> On Sat, Mar 13, 2021 at 12:09 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>>
>>> On 21. 3. 12. 오후 7:57, Dong Aisheng wrote:
>>>> On Thu, Mar 11, 2021 at 2:54 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>>
>>>>> On 3/10/21 1:56 PM, Dong Aisheng wrote:
>>>>>> On Wed, Mar 10, 2021 at 11:08 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>>>>
>>>>>>> On 3/10/21 11:56 AM, Dong Aisheng wrote:
>>>>>>>> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> On 21. 3. 10. 오전 12:58, Chanwoo Choi wrote:
>>>>>>>>>> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>>>>>>>>>>> The devfreq monitor depends on the device to provide load information
>>>>>>>>>>> by .get_dev_status() to calculate the next target freq.
>>>>>>>>>>>
>>>>>>>>>>> And this will cause changing governor to simple ondemand fail
>>>>>>>>>>> if device can't support.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>>>>>>>>>> ---
>>>>>>>>>>>    drivers/devfreq/devfreq.c                 | 10 +++++++---
>>>>>>>>>>>    drivers/devfreq/governor.h                |  2 +-
>>>>>>>>>>>    drivers/devfreq/governor_simpleondemand.c |  3 +--
>>>>>>>>>>>    3 files changed, 9 insertions(+), 6 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>>>>>> index 7231fe6862a2..d1787b6c7d7c 100644
>>>>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct
>>>>>>>>>>> *work)
>>>>>>>>>>>     * to be called from governor in response to DEVFREQ_GOV_START
>>>>>>>>>>>     * event when device is added to devfreq framework.
>>>>>>>>>>>     */
>>>>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>>>>    {
>>>>>>>>>>>        if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>>>>>>>>>>> -        return;
>>>>>>>>>>> +        return 0;
>>>>>>>>>>> +
>>>>>>>>>>> +    if (!devfreq->profile->get_dev_status)
>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>
>>>>>>>>> Again, I think that get_dev_status is not used for all governors.
>>>>>>>>> So that it cause the governor start fail. Don't check whether
>>>>>>>>> .get_dev_status is NULL or not.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'm not quite understand your point.
>>>>>>>> it is used by governor_simpleondemand.c and tegra_devfreq_governor.
>>>>>>>> get_target_freq -> devfreq_update_stats -> get_dev_status
>>>>>>>
>>>>>>> The devfreq can add the new governor by anyone.
>>>>>>> So these functions like devfreq_monitor_* have to support
>>>>>>> the governors and also must support the governor to be added
>>>>>>> in the future.
>>>>>>
>>>>>> Yes, but devfreq_monitor_* is only used by polling mode, right?
>>>>>> The governor using it has to implement get_dev_status unless
>>>>>> there's an exception in the future.
>>>>>>
>>>>>> Currently this patch wants to address the issue that user can switch
>>>>>> to ondemand governor (polling mode) by sysfs even devices does
>>>>>> not support it (no get_dev_status implemented).
>>>>>
>>>>> As I commented, I'll fix this issue. If devfreq driver doesn't implement
>>>>> the .get_dev_status, don't show it via available_governors. I think that
>>>>> it is fundamental solution to fix this issue.
>>>>
>>>> Sounds good
>>>>
>>>>> So on this version,
>>>>> don't add the this conditional statement on this function
>>>>>
>>>>
>>>> Almost all this patch did is adding a checking for get_dev_status.
>>>> So do you mean drop this patch?
>>>> I wonder it's still a necessary checking to explicitly tell devfreq monitor
>>>> users that get_dev_status is needed during governor startup.
>>>
>>> I think that the it is enough to check .get_dev_status in
>>> devfreq_update_stats. We have to check it on where it is used.
>>>
>>
>> I think the drawback of only checking .get_dev_status in
>> devfreq_update_stats is:
>> 1. devfreq will still register successfully and ondemand governor starts ok
>> 2. ondemand governor will still be shown in sysfs which is something
>> you want to fix
>> 3. devfreq will end up printing endless error messages in devfreq_monitor worker
>>     "dvfs failed with (%d) error" as the possible missing .get_dev_status

I think that devfreq_monitor_start have to handle only work instance.
This approach is too considering the deep check list.
I want to resolve this periodical error log with different solution.

Actually, we have to reject the registration of devfreq device
when calling devfreq_add_device instead of checking .get_dev_status
in devfreq_monitor_start().


>>
>> So i wonder if you don't like changing the common devfreq_monitor_start in order
>> to make it look common for all governors, then we probably still need
>> to fix it in
>> ondemand governor in order to avoid the possible above issues.
>>
>> static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>>                                 unsigned int event, void *data)
>> {
>>         switch (event) {
>>         case DEVFREQ_GOV_START:
>>                 if (!devfreq->profile->get_dev_status)
>>                         return -EINVAL;
>>
>>                 return devfreq_monitor_start(devfreq);
>> ...
>> }
>>
>> How do you think?
> 
> Any feedback?
> 
> I'm waiting for your confirmation whether dropping this one,
> then I can re-sent the series.
> 
> Regards
> Aisheng
> 
>>
>> Regards
>> Aisheng
>>
>>
>>>>
>>>>> And on next version, please use the capital letter for first character
>>>>> on patch title as following:
>>>>>
>>>>> - PM / devfreq: Check get_dev_status before start monitor
>>>>>
>>>>
>>>> Okay to me.
>>>> Thanks for the suggestion.
>>>>
>>>> Regards
>>>> Aisheng
>>>>
>>>>>>
>>>>>> Regards
>>>>>> Aisheng
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Without checking, device can switch to ondemand governor if it does not support.
>>>>>>>>
>>>>>>>> Am i missed something?
>>>>>>>>
>>>>>>>> Regards
>>>>>>>> Aisheng
>>>>>>>>
>>>>>>>>>>>        switch (devfreq->profile->timer) {
>>>>>>>>>>>        case DEVFREQ_TIMER_DEFERRABLE:
>>>>>>>>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>>>>            INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>>>>>>>>>>            break;
>>>>>>>>>>>        default:
>>>>>>>>>>> -        return;
>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>>        }
>>>>>>>>>>>        if (devfreq->profile->polling_ms)
>>>>>>>>>>>            queue_delayed_work(devfreq_wq, &devfreq->work,
>>>>>>>>>>>                msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>>>>>>>> +    return 0;
>>>>>>>>>>>    }
>>>>>>>>>>>    EXPORT_SYMBOL(devfreq_monitor_start);
>>>>>>>>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>>>>>>>>>>> index 5cee3f64fe2b..31af6d072a10 100644
>>>>>>>>>>> --- a/drivers/devfreq/governor.h
>>>>>>>>>>> +++ b/drivers/devfreq/governor.h
>>>>>>>>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
>>>>>>>>>>>                    unsigned int event, void *data);
>>>>>>>>>>>    };
>>>>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
>>>>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
>>>>>>>>>>>    void devfreq_monitor_stop(struct devfreq *devfreq);
>>>>>>>>>>>    void devfreq_monitor_suspend(struct devfreq *devfreq);
>>>>>>>>>>>    void devfreq_monitor_resume(struct devfreq *devfreq);
>>>>>>>>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>> b/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>> index d57b82a2b570..ea287b57cbf3 100644
>>>>>>>>>>> --- a/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct
>>>>>>>>>>> devfreq *devfreq,
>>>>>>>>>>>    {
>>>>>>>>>>>        switch (event) {
>>>>>>>>>>>        case DEVFREQ_GOV_START:
>>>>>>>>>>> -        devfreq_monitor_start(devfreq);
>>>>>>>>>>> -        break;
>>>>>>>>>>> +        return devfreq_monitor_start(devfreq);
>>>>>>>>>>>        case DEVFREQ_GOV_STOP:
>>>>>>>>>>>            devfreq_monitor_stop(devfreq);
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Need to handle the all points of devfreq_monitor_start() usage.
>>>>>>>>>> please check the tegra30-devfreq.c for this update.
>>>>>>>>>>
>>>>>>>>>> $ grep -rn "devfreq_monitor_start" drivers/
>>>>>>>>>> drivers/devfreq/governor_simpleondemand.c:92:
>>>>>>>>>> devfreq_monitor_start(devfreq);
>>>>>>>>>> drivers/devfreq/tegra30-devfreq.c:744:
>>>>>>>>>> devfreq_monitor_start(devfreq);
>>>>>>>>>> ......
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Best Regards,
>>>>>>>>> Samsung Electronics
>>>>>>>>> Chanwoo Choi
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Best Regards,
>>>>>>> Chanwoo Choi
>>>>>>> Samsung Electronics
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Chanwoo Choi
>>>>> Samsung Electronics
>>>
>>>
>>> --
>>> Best Regards,
>>> Samsung Electronics
>>> Chanwoo Choi
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
