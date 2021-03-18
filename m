Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7C340244
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCRJnD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:43:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44924 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCRJmb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 05:42:31 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210318094229epoutp01fcc0ac5d114b6ee7b2e2ef4ab745284c~tZoIGaYmT0033400334epoutp01d
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 09:42:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210318094229epoutp01fcc0ac5d114b6ee7b2e2ef4ab745284c~tZoIGaYmT0033400334epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616060549;
        bh=FpnHDzjLsD0eou2f54DyEkrjl+YFeQwbawPVaFntxCI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YAXEZncP1genbpKi8zHiLwz0bCE3ddz0bAx2L0mFlv5/eKzBPDxMGJFIEzE3jirVS
         OU96Jd5hPF5M2UY0mnEyrF/vzMrWpolbluGg1VL1JlKczGownhSiaYLWvBp7fvzzCe
         KBQ5dCHNY06XCR7p559L8XNQ/jkAp750W8JNK3OU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210318094229epcas1p3739da8958f547bcf34986a9575855c73~tZoHY2SEM1858418584epcas1p3D;
        Thu, 18 Mar 2021 09:42:29 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F1MWQ5BC1z4x9Ps; Thu, 18 Mar
        2021 09:42:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.AA.63458.08023506; Thu, 18 Mar 2021 18:42:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210318094223epcas1p43678e2bd346aaf0b8d4a3d2845e7622c~tZoCaVpbE2728027280epcas1p4t;
        Thu, 18 Mar 2021 09:42:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210318094223epsmtrp26d753b7fea75820ce81e4796b2e031de~tZoCZVN542253222532epsmtrp26;
        Thu, 18 Mar 2021 09:42:23 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-71-605320806540
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.50.08745.F7023506; Thu, 18 Mar 2021 18:42:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210318094223epsmtip2688ecbdf2f0ea1a2876eb7010924183a~tZoCBo4wZ3024830248epsmtip2O;
        Thu, 18 Mar 2021 09:42:23 +0000 (GMT)
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start
 monitor
From:   Chanwoo Choi <cw00.choi@samsung.com>
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
Organization: Samsung Electronics
Message-ID: <4b5a0c61-2bab-8b00-621c-25f1244fee92@samsung.com>
Date:   Thu, 18 Mar 2021 18:59:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <0e518145-5cae-63f1-c32f-e6207fdeae54@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmgW6DQnCCwZ9vshbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGzCfrWQp6/Ct+TpnG1sC4waGL
        kZNDQsBE4tKhl+xdjFwcQgI7GCW27V7GBOF8YpR42bqDEcL5zChx9fQ0ZpiWppV7oBK7GCVO
        TZ0M1fKeUWLGny8sIFXCAiESk0//BetgE9CS2P/iBhuILSLgIXFp+hQ2kAZmgYXMEp/3PAJr
        4BdQlLj64zEjiM0rYCex6dpzJhCbRUBVYs6BtWDNogJhEie3tUDVCEqcnPkErJdTwF7i28WP
        YHFmAXGJW0/mM0HY8hLNW2czgyyTEDjBIXGqbxUjxA8uEtf3/mOCsIUlXh3fwg5hS0l8freX
        DcKullh58ggbRHMHo8SW/RdYIRLGEvuXgvzMAbRBU2L9Ln2IsKLEzt9zoY7gk3j3tYcVpERC
        gFeio00IokRZ4vKDu1BrJSUWt3eyTWBUmoXknVlIXpiF5IVZCMsWMLKsYhRLLSjOTU8tNiww
        Qo7vTYzgNKxltoNx0tsPeocYmTgYDzFKcDArifCa5gUkCPGmJFZWpRblxxeV5qQWH2I0BQbw
        RGYp0eR8YCbIK4k3NDUyNja2MDE0MzU0VBLnTTR4EC8kkJ5YkpqdmlqQWgTTx8TBKdXANPvm
        hdkzt8R1PfuY90/F6d5HQYdpk9kStWfMsckON3x7W3tFDkMi5zmTjqh/QZ1fs/7GbD7arFTd
        z7XGz65pnaZXzCbRtXkc24uCHxr42Wkk6JyIYOPmvL0hSyIsNH9v3ruX8x2uGzzxjVzxx5gr
        0eTE8fPhgQ29HoGbAied+Btw1qv2WMAsjqC78W9MnH4HlJgdm2AoX+t9fr9B/RIr1nSny5zt
        a/baipq/WXfq1fEfHRxTjH5X/5nzsK10cbdEpMEC7zVSehd6DufJFR6ozX3O8dLwccuFs/HS
        qX0ZwltyX/Ctb/RsDRaq9/lhL35ek7mbSy3UMnOKowDXzKvs75YsWL/g7+VUhQlZiixKLMUZ
        iYZazEXFiQD5bmVVTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvG69QnCCwaNDGhbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2Pmk/Us
        BT3+FT+nTGNrYNzg0MXIySEhYCLRtHIPYxcjF4eQwA5GiQcnbjFDJCQlpl08CmRzANnCEocP
        F0PUvGWUWPvoFQtIjbBAiMTk03/B6tkEtCT2v7jBBmKLCHhIXJo+hQ2kgVlgIbPEwr0rmCG6
        37FJ3GqfwAhSxS+gKHH1x2Mwm1fATmLTtedMIDaLgKrEnANrwSaJCoRJ7FzymAmiRlDi5Mwn
        YJs5Bewlvl38CNbLLKAu8WfeJWYIW1zi1pP5TBC2vETz1tnMExiFZyFpn4WkZRaSlllIWhYw
        sqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiORy2tHYx7Vn3QO8TIxMF4iFGCg1lJ
        hNc0LyBBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbo
        yJvzRffq+F7KntHWYRLySoTJW/Ck4ruuKwtYma9UfWVqmMasqJrpaSj0t+7i/D/b27/+PmRk
        os47v+6q4dWAYydWF8e7sXBaNHXeSTmfYKCeX5o3wcDUUlH4lcpRm2SFKywb17TOX+vi/qD6
        qdW2jpQdMx836v5Py/TY3eS48mXQ+UeHF8w4FGzJWL7ImaNSXlxJMSag7Y7mJqtjVilCjtK3
        lfa8WPZTrudukY3g6iNMb4tufox2Zd40R23D3QccM37JBX40fVIsq3aV7VG6wISzLyT3bFbW
        Utqgwrv2e/dTXsMzJ40uG69uysiL0WtmWHSWLXBl08bvO7U9mOxynkT5TqwTXZl1IGzZFiWW
        4oxEQy3mouJEAJxulqM2AwAA
X-CMS-MailID: 20210318094223epcas1p43678e2bd346aaf0b8d4a3d2845e7622c
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
        <0e518145-5cae-63f1-c32f-e6207fdeae54@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/18/21 6:54 PM, Chanwoo Choi wrote:
> On 3/18/21 5:03 PM, Dong Aisheng wrote:
>> Hi Chanwoo,
>>
>> On Sat, Mar 13, 2021 at 2:45 PM Dong Aisheng <dongas86@gmail.com> wrote:
>>>
>>> On Sat, Mar 13, 2021 at 12:09 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>>>
>>>> On 21. 3. 12. 오후 7:57, Dong Aisheng wrote:
>>>>> On Thu, Mar 11, 2021 at 2:54 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>>>
>>>>>> On 3/10/21 1:56 PM, Dong Aisheng wrote:
>>>>>>> On Wed, Mar 10, 2021 at 11:08 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>>>>>
>>>>>>>> On 3/10/21 11:56 AM, Dong Aisheng wrote:
>>>>>>>>> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 21. 3. 10. 오전 12:58, Chanwoo Choi wrote:
>>>>>>>>>>> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>>>>>>>>>>>> The devfreq monitor depends on the device to provide load information
>>>>>>>>>>>> by .get_dev_status() to calculate the next target freq.
>>>>>>>>>>>>
>>>>>>>>>>>> And this will cause changing governor to simple ondemand fail
>>>>>>>>>>>> if device can't support.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>    drivers/devfreq/devfreq.c                 | 10 +++++++---
>>>>>>>>>>>>    drivers/devfreq/governor.h                |  2 +-
>>>>>>>>>>>>    drivers/devfreq/governor_simpleondemand.c |  3 +--
>>>>>>>>>>>>    3 files changed, 9 insertions(+), 6 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>>>>>>> index 7231fe6862a2..d1787b6c7d7c 100644
>>>>>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>>>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct
>>>>>>>>>>>> *work)
>>>>>>>>>>>>     * to be called from governor in response to DEVFREQ_GOV_START
>>>>>>>>>>>>     * event when device is added to devfreq framework.
>>>>>>>>>>>>     */
>>>>>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>>>>>    {
>>>>>>>>>>>>        if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>>>>>>>>>>>> -        return;
>>>>>>>>>>>> +        return 0;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (!devfreq->profile->get_dev_status)
>>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>
>>>>>>>>>> Again, I think that get_dev_status is not used for all governors.
>>>>>>>>>> So that it cause the governor start fail. Don't check whether
>>>>>>>>>> .get_dev_status is NULL or not.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I'm not quite understand your point.
>>>>>>>>> it is used by governor_simpleondemand.c and tegra_devfreq_governor.
>>>>>>>>> get_target_freq -> devfreq_update_stats -> get_dev_status
>>>>>>>>
>>>>>>>> The devfreq can add the new governor by anyone.
>>>>>>>> So these functions like devfreq_monitor_* have to support
>>>>>>>> the governors and also must support the governor to be added
>>>>>>>> in the future.
>>>>>>>
>>>>>>> Yes, but devfreq_monitor_* is only used by polling mode, right?
>>>>>>> The governor using it has to implement get_dev_status unless
>>>>>>> there's an exception in the future.
>>>>>>>
>>>>>>> Currently this patch wants to address the issue that user can switch
>>>>>>> to ondemand governor (polling mode) by sysfs even devices does
>>>>>>> not support it (no get_dev_status implemented).
>>>>>>
>>>>>> As I commented, I'll fix this issue. If devfreq driver doesn't implement
>>>>>> the .get_dev_status, don't show it via available_governors. I think that
>>>>>> it is fundamental solution to fix this issue.
>>>>>
>>>>> Sounds good
>>>>>
>>>>>> So on this version,
>>>>>> don't add the this conditional statement on this function
>>>>>>
>>>>>
>>>>> Almost all this patch did is adding a checking for get_dev_status.
>>>>> So do you mean drop this patch?
>>>>> I wonder it's still a necessary checking to explicitly tell devfreq monitor
>>>>> users that get_dev_status is needed during governor startup.
>>>>
>>>> I think that the it is enough to check .get_dev_status in
>>>> devfreq_update_stats. We have to check it on where it is used.
>>>>
>>>
>>> I think the drawback of only checking .get_dev_status in
>>> devfreq_update_stats is:
>>> 1. devfreq will still register successfully and ondemand governor starts ok
>>> 2. ondemand governor will still be shown in sysfs which is something
>>> you want to fix
>>> 3. devfreq will end up printing endless error messages in devfreq_monitor worker
>>>     "dvfs failed with (%d) error" as the possible missing .get_dev_status
> 
> I think that devfreq_monitor_start have to handle only work instance.
> This approach is too considering the deep check list.
> I want to resolve this periodical error log with different solution.
> 
> Actually, we have to reject the registration of devfreq device
> when calling devfreq_add_device instead of checking .get_dev_status
> in devfreq_monitor_start().


I'll reject the registration of devfreq device if the mandatory
function pointer of struct devfreq_dev_profile are not initialized.
- .get_dev_status
   If some governors like simple_ondemand, have to initialize it.
   So, I need to add the new flag to specify this feature.
- .target is mandatory for all devfreq devices. I'll check it.

> 
> 
>>>
>>> So i wonder if you don't like changing the common devfreq_monitor_start in order
>>> to make it look common for all governors, then we probably still need
>>> to fix it in
>>> ondemand governor in order to avoid the possible above issues.
>>>
>>> static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>>>                                 unsigned int event, void *data)
>>> {
>>>         switch (event) {
>>>         case DEVFREQ_GOV_START:
>>>                 if (!devfreq->profile->get_dev_status)
>>>                         return -EINVAL;
>>>
>>>                 return devfreq_monitor_start(devfreq);
>>> ...
>>> }
>>>
>>> How do you think?
>>
>> Any feedback?
>>
>> I'm waiting for your confirmation whether dropping this one,
>> then I can re-sent the series.
>>
>> Regards
>> Aisheng
>>
>>>
>>> Regards
>>> Aisheng
>>>
>>>
>>>>>
>>>>>> And on next version, please use the capital letter for first character
>>>>>> on patch title as following:
>>>>>>
>>>>>> - PM / devfreq: Check get_dev_status before start monitor
>>>>>>
>>>>>
>>>>> Okay to me.
>>>>> Thanks for the suggestion.
>>>>>
>>>>> Regards
>>>>> Aisheng
>>>>>
>>>>>>>
>>>>>>> Regards
>>>>>>> Aisheng
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Without checking, device can switch to ondemand governor if it does not support.
>>>>>>>>>
>>>>>>>>> Am i missed something?
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>> Aisheng
>>>>>>>>>
>>>>>>>>>>>>        switch (devfreq->profile->timer) {
>>>>>>>>>>>>        case DEVFREQ_TIMER_DEFERRABLE:
>>>>>>>>>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>>>>>            INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>>>>>>>>>>>            break;
>>>>>>>>>>>>        default:
>>>>>>>>>>>> -        return;
>>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>>>        }
>>>>>>>>>>>>        if (devfreq->profile->polling_ms)
>>>>>>>>>>>>            queue_delayed_work(devfreq_wq, &devfreq->work,
>>>>>>>>>>>>                msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>>>>>>>>> +    return 0;
>>>>>>>>>>>>    }
>>>>>>>>>>>>    EXPORT_SYMBOL(devfreq_monitor_start);
>>>>>>>>>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>>>>>>>>>>>> index 5cee3f64fe2b..31af6d072a10 100644
>>>>>>>>>>>> --- a/drivers/devfreq/governor.h
>>>>>>>>>>>> +++ b/drivers/devfreq/governor.h
>>>>>>>>>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
>>>>>>>>>>>>                    unsigned int event, void *data);
>>>>>>>>>>>>    };
>>>>>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
>>>>>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
>>>>>>>>>>>>    void devfreq_monitor_stop(struct devfreq *devfreq);
>>>>>>>>>>>>    void devfreq_monitor_suspend(struct devfreq *devfreq);
>>>>>>>>>>>>    void devfreq_monitor_resume(struct devfreq *devfreq);
>>>>>>>>>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>>> b/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>>> index d57b82a2b570..ea287b57cbf3 100644
>>>>>>>>>>>> --- a/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
>>>>>>>>>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct
>>>>>>>>>>>> devfreq *devfreq,
>>>>>>>>>>>>    {
>>>>>>>>>>>>        switch (event) {
>>>>>>>>>>>>        case DEVFREQ_GOV_START:
>>>>>>>>>>>> -        devfreq_monitor_start(devfreq);
>>>>>>>>>>>> -        break;
>>>>>>>>>>>> +        return devfreq_monitor_start(devfreq);
>>>>>>>>>>>>        case DEVFREQ_GOV_STOP:
>>>>>>>>>>>>            devfreq_monitor_stop(devfreq);
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Need to handle the all points of devfreq_monitor_start() usage.
>>>>>>>>>>> please check the tegra30-devfreq.c for this update.
>>>>>>>>>>>
>>>>>>>>>>> $ grep -rn "devfreq_monitor_start" drivers/
>>>>>>>>>>> drivers/devfreq/governor_simpleondemand.c:92:
>>>>>>>>>>> devfreq_monitor_start(devfreq);
>>>>>>>>>>> drivers/devfreq/tegra30-devfreq.c:744:
>>>>>>>>>>> devfreq_monitor_start(devfreq);
>>>>>>>>>>> ......
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Best Regards,
>>>>>>>>>> Samsung Electronics
>>>>>>>>>> Chanwoo Choi
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Best Regards,
>>>>>>>> Chanwoo Choi
>>>>>>>> Samsung Electronics
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Best Regards,
>>>>>> Chanwoo Choi
>>>>>> Samsung Electronics
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Samsung Electronics
>>>> Chanwoo Choi
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
