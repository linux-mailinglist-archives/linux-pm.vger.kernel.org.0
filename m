Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6BF323811
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 08:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhBXHs3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 02:48:29 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:54190 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhBXHs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 02:48:27 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210224074741epoutp01da88f1b8dfc17b70c310b69e17081e78~mn3nN1sa11130111301epoutp01D
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 07:47:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210224074741epoutp01da88f1b8dfc17b70c310b69e17081e78~mn3nN1sa11130111301epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614152861;
        bh=P035y0zmHlLzg94shumKEeUe5Y8UYjSLNUCKnFMbOcw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b8HSIP5cs7zSjZLk6IvFHo/syogHipXR/6n9fOnHIFiTNQ1AHXSGbwuwovErlrIyc
         aBMKQMq2O86Swc/aITTCxIDColCoRnR+ZS2HH6E1sqP2zjgQEdOGsu1IxXeZjTrWfd
         MYu3WriU0L869Sh/KTgXweL1x51DKBrG7iMdyOJo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210224074740epcas1p3d3af7e7fe7989a28be97c1a6d3c982fc~mn3mSlhGW3130331303epcas1p3q;
        Wed, 24 Feb 2021 07:47:40 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Dlp161Tk6z4x9Q6; Wed, 24 Feb
        2021 07:47:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.25.09582.A9406306; Wed, 24 Feb 2021 16:47:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210224074737epcas1p4ab2d977b19ef0844f3421a9712b53882~mn3jIIU0h2819828198epcas1p47;
        Wed, 24 Feb 2021 07:47:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210224074737epsmtrp2ec838e37444d395778c0dfdff313046c~mn3jHLyop0402804028epsmtrp2I;
        Wed, 24 Feb 2021 07:47:37 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-e9-6036049a5694
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.DC.08745.99406306; Wed, 24 Feb 2021 16:47:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210224074737epsmtip1db7f2bb61ea1292992d8953af627c9df~mn3izLYqh0317503175epsmtip1V;
        Wed, 24 Feb 2021 07:47:37 +0000 (GMT)
Subject: Re: [RFC][PATCH 1/3] PM /devfreq: add user frequency limits into
 devfreq struct
To:     Lukasz Luba <lukasz.luba@arm.com>, cwchoi00@gmail.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, amitk@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <131bb44f-803c-4dac-3c60-24c3148e8814@samsung.com>
Date:   Wed, 24 Feb 2021 17:04:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <89343e3c-3213-19d4-e67e-1dc56afebf4c@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmge4sFrMEg3/32C0Oz6+weHZU22Le
        Z1mLpxO2MlucbXrDbnF51xw2i8+9RxgtFja1sFvcblzBZjH3y1RmiycP+9gsNj84xubA47Fm
        3hpGj52z7rJ7LN7zkslj06pONo871/awefRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66
        rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCZSgpliTmlQKGAxOJiJX07m6L80pJU
        hYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjK3r9rIV9AVXnF4g1cA4xbWL
        kZNDQsBEYuXvhexdjFwcQgI7GCVWL5vJCOF8YpSYvuoKG4TzmVFi5812FpiWeRPWsoHYQgK7
        gFouOEAUvWeU2D/zOCNIQlggSmL/ob1gtoiApcTNTa1MIEXMAn+YJHavO8wKkmAT0JLY/+IG
        2CR+AUWJqz8egzXwCthJnFr1Fmwbi4CqxO/tc5hBbFGBMImT21qgagQlTs58AlbDKWAt8bBp
        JTuIzSwgLnHryXwmCFteonnrbGaQxRICJzgkzv9bD/WCi8Sk5z+ZIGxhiVfHt7BD2FISn9/t
        ZYOwqyVWnjzCBtHcwSixZf8FVoiEscT+pZOBmjmANmhKrN+lDxFWlNj5ey4jxGI+iXdfe1hB
        SiQEeCU62oQgSpQlLj+4C7VWUmJxeyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRi
        wwJj5NjexAhOwlrmOxinvf2gd4iRiYPxEKMEB7OSCO/mf6YJQrwpiZVVqUX58UWlOanFhxhN
        gQE8kVlKNDkfmAfySuINTY2MjY0tTAzNTA0NlcR5kwwexAsJpCeWpGanphakFsH0MXFwSjUw
        RW2KX8bUymZ8NkIzW+fvlTqORxue/VG8Y/2lXWi//cebT09LR4Vqx/plJ93JnW/ZXn15q8Yt
        IeFH1ltbHiQtWa3SstZC7edml+htzbon1lc4GcRPXaKd/udIuszLu6/NciS2sn94Hp77sePE
        qpttTgW6NdkRdyTUzZOX/ZWJ2uz0JaH0M2ec7ebSf945vQkeC+QVMsKFbq1cWHG95YHfhsBg
        mSfPbj/n+hs90b8oTdvq7X3tM1NUdU7uWDzp96xUz9ucR1T/XcjwzhU7tth+WbmXxJ2iZ6dF
        NU6kxL5reXQ+VrzzAXtq6qvZb80mv2hz5tkszaDTwphT+veHE0eV+wY335YjqluYl18xNfyr
        xFKckWioxVxUnAgA+hvXvksEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnO5MFrMEgzlzpS0Oz6+weHZU22Le
        Z1mLpxO2MlucbXrDbnF51xw2i8+9RxgtFja1sFvcblzBZjH3y1RmiycP+9gsNj84xubA47Fm
        3hpGj52z7rJ7LN7zkslj06pONo871/awefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfG1nV7
        2Qr6gitOL5BqYJzi2sXIySEhYCIxb8Jati5GLg4hgR2MEgemdTFDJCQlpl08CmRzANnCEocP
        F0PUvGWUOPrxMiNIjbBAlMT+Q3vBbBEBS4mbm1qZQIqYBf4xSez5MYUFouM3s8TdL/PAprIJ
        aEnsf3GDDcTmF1CUuPrjMVg3r4CdxKlVb1lAbBYBVYnf2+eA1YsKhEnsXPKYCaJGUOLkzCdg
        NZwC1hIPm1ayg9jMAuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEj
        yypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOB41NLawbhn1Qe9Q4xMHIyHGCU4mJVE
        eDf/M00Q4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgcnI
        MDMk7IOn1z+NydN/+runHHDTe1nrvTRUzb/W/Q23q86sx50XwsouHWHq271y74F6w16V/Tof
        vvz371xWuIr37N4MmzWCTQ92yWz5lKf6v9+thpHlxI+yTR0d6yonFfMcC31XYt/rO6ny7f2l
        c9ILjuUIf6vrOvvrq/P9RY76TQUdYukLp8xesyQi5PrroGVpVfNvn/1hrfhkS9/dfSIKHa8e
        GJm0spYuWfKiNPHq3T72/r7jplvmLmoWSdQo5T9vx5Qlf0P5YIQzh35gcM+rGbp/mdjElBxn
        7bxTafclMvDXPwV7ofpqqZ2sYYnfF/7JXd7l+v3GTk2Z7CVZKkkVN+vqVe+y8LTHSP+ep8RS
        nJFoqMVcVJwIAHzJS+c2AwAA
X-CMS-MailID: 20210224074737epcas1p4ab2d977b19ef0844f3421a9712b53882
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210126104217epcas1p349c717ccf0ea4f964153040b48c72352
References: <20210126104001.20361-1-lukasz.luba@arm.com>
        <CGME20210126104217epcas1p349c717ccf0ea4f964153040b48c72352@epcas1p3.samsung.com>
        <20210126104001.20361-2-lukasz.luba@arm.com>
        <ea409e2f-f3ca-437f-d787-7ba793a2c226@samsung.com>
        <5bd13e13-202f-d059-da29-f82806c33a38@arm.com>
        <fe7763c8-22f7-65ad-94ee-3c4a78a3f6eb@arm.com>
        <932c04da-46bf-8867-6b10-c6af83a36588@arm.com>
        <CAGTfZH12DwvKDv7aKwisL-mvx0tyMcXA96nLTbSpO5zVp5UCiA@mail.gmail.com>
        <89343e3c-3213-19d4-e67e-1dc56afebf4c@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/16/21 7:41 PM, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/15/21 3:00 PM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On Fri, Feb 12, 2021 at 7:28 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>>
>>>
>>> On 2/11/21 11:07 AM, Lukasz Luba wrote:
>>>> Hi Chanwoo,
>>>>
>>>> On 2/3/21 10:21 AM, Lukasz Luba wrote:
>>>>> Hi Chanwoo,
>>>>>
>>>>> Thank you for looking at this.
>>>>>
>>>>> On 2/3/21 10:11 AM, Chanwoo Choi wrote:
>>>>>> Hi Lukasz,
>>>>>>
>>>>>> When accessing the max_freq and min_freq at devfreq-cooling.c,
>>>>>> even if can access 'user_max_freq' and 'lock' by using the 'devfreq'
>>>>>> instance,
>>>>>> I think that the direct access of variables
>>>>>> (lock/user_max_freq/user_min_freq)
>>>>>> of struct devfreq are not good.
>>>>>>
>>>>>> Instead, how about using the 'DEVFREQ_TRANSITION_NOTIFIER'
>>>>>> notification with following changes of 'struct devfreq_freq'?
>>>>>
>>>>> I like the idea with devfreq notification. I will have to go through the
>>>>> code to check that possibility.
>>>>>
>>>>>> Also, need to add codes into devfreq_set_target() for initializing
>>>>>> 'new_max_freq' and 'new_min_freq' before sending the DEVFREQ_POSTCHANGE
>>>>>> notification.
>>>>>>
>>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>>> index 147a229056d2..d5726592d362 100644
>>>>>> --- a/include/linux/devfreq.h
>>>>>> +++ b/include/linux/devfreq.h
>>>>>> @@ -207,6 +207,8 @@ struct devfreq {
>>>>>>    struct devfreq_freqs {
>>>>>>           unsigned long old;
>>>>>>           unsigned long new;
>>>>>> +       unsigned long new_max_freq;
>>>>>> +       unsigned long new_min_freq;
>>>>>>    };
>>>>>>
>>>>>>
>>>>>> And I think that new 'user_min_freq'/'user_max_freq' are not necessary.
>>>>>> You can get the current max_freq/min_freq by using the following steps:
>>>>>>
>>>>>>      get_freq_range(devfreq, &min_freq, &max_freq);
>>>>>>      dev_pm_opp_find_freq_floor(pdev, &min_freq);
>>>>>>      dev_pm_opp_find_freq_floor(pdev, &max_freq);
>>>>>>
>>>>>> So that you can get the 'max_freq/min_freq' and then
>>>>>> initialize the 'freqs.new_max_freq and freqs.new_min_freq'
>>>>>> with them as following:
>>>>>>
>>>>>> in devfreq_set_target()
>>>>>>      get_freq_range(devfreq, &min_freq, &max_freq);
>>>>>>      dev_pm_opp_find_freq_floor(pdev, &min_freq);
>>>>>>      dev_pm_opp_find_freq_floor(pdev, &max_freq);
>>>>>>      freqs.new_max_freq = min_freq;
>>>>>>      freqs.new_max_freq = max_freq;
>>>>>>      devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>>>>
>>>>> I will plumb it in and check that option. My concern is that function
>>>>> get_freq_range() would give me the max_freq value from PM QoS, which
>>>>> might be my thermal limit - lower that user_max_freq. Then I still
>>>>> need
>>>>>
>>>>> I've been playing with PM QoS notifications because I thought it would
>>>>> be possible to be notified in thermal for all new set values - even from
>>>>> devfreq sysfs user max_freq write, which has value higher that the
>>>>> current limit set by thermal governor. Unfortunately PM QoS doesn't
>>>>> send that information by design. PM QoS also by desing won't allow
>>>>> me to check first two limits in the plist - which would be thermal
>>>>> and user sysfs max_freq.
>>>>>
>>>>> I will experiment with this notifications and share the results.
>>>>> That you for your comments.
>>>>
>>>> I have experimented with your proposal. Unfortunately, the value stored
>>>> in the pm_qos which is read by get_freq_range() is not the user max
>>>> freq. It's the value from thermal devfreq cooling when that one is
>>>> lower. Which is OK in the overall design, but not for my IPA use case.
>>>>
>>>> What comes to my mind is two options:
>>>> 1) this patch proposal, with simple solution of two new variables
>>>> protected by mutex, which would maintain user stored values
>>>> 2) add a new notification chain in devfreq to notify about new
>>>> user written value, to which devfreq cooling would register; that
>>>> would allow devfreq cooling to get that value instantly and store
>>>> locally
>>>
>>> 3) How about new define for existing notification chain:
>>> #define DEVFREQ_USER_CHANGE            (2)
>>
>> I think that if we add the notification with specific actor like user change
>> or OPP change or others, it is not proper. But, we can add the notification
>> for min or max frequency change timing. Because the devfreq already has
>> the notification for current frequency like DEVFREQ_PRECHANGE,
>> DEVFREQ_POSTCHANGE.
>>
>> Maybe, we can add the following notification for min/max_freq.
>> The following min_freq and max_freq values will be calculated by
>> get_freq_range().
>> DEVFREQ_MIN_FREQ_PRECHANGE
>> DEVFREQ_MIN_FREQ_POSTCHANGE
>> DEVFREQ_MAX_FREQ_PRECHANGE
>> DEVFREQ_MAX_FREQ_POSTCHANGE
> 
> Would it be then possible to pass the user max freq value written via
> sysfs? Something like in the example below, when writing into max sysfs:
> 
> 1) starting in max_freq_store()
>         freqs.new_max_freq = max_freq;
>         devfreq_notify_transition(devfreq, &freqs, DEVFREQ_MAX_FREQ_PRECHANGE);
>     dev_pm_qos_update_request()


When we use the PRECHANGE and POSTCHANGE notification,
we should keep the consistent value.

When PRECHANGE, notify the previous min/max frequency
 containing the user input/cooling policy/OPP.
When POSTCHANGE, notify the new min/max frequency
 containing the user input/cooling policy/OPP.

But, in case of your suggestion, DEVFREQ_MAX_FREQ_PRECHANGE considers
only user input without cooling policy/opp.

> 
> 2)then after a while in devfreq_set_target()
>     get_freq_range(devfreq, &min_freq, &max_freq);
>     dev_pm_opp_find_freq_floor(pdev, &min_freq);
>     dev_pm_opp_find_freq_floor(pdev, &max_freq);
>     freqs.new_min_freq = min_freq;
>     freqs.new_max_freq = max_freq;
>     devfreq_notify_transition(devfreq, &freqs, DEVFREQ_MAX_FREQ_POSTCHANGE);
> 
> This 2nd part is called after the PM QoS has changed that limit,
> so might be missing (in case value was higher that current),
> but thermal would know about that, so no worries.

It doesn't focus on only thermal. We need to consider
all potential user of max_freq notification.

In the devfreq subsystem like devfreq governor,
we might use the user min/max_freq without any restrictions.
But, in this case, devfreq provides the min/max_freq
to outside subsystem/drivers like devfreq-cooling.c of thermal.
IMHO, it is difficult to agree this approach.

If devfreq provides the various min/max_freq value to outside
of devfreq, it makes the confusion to understand the meaning
of min/max_freq. Actually, the other user doesn't need to 
know the user input for min/max_freq.

> 
>>
>>
>>>
>>> Then a modified devfreq_notify_transition() would get:
>>> @@ -339,6 +339,10 @@ static int devfreq_notify_transition(struct devfreq
>>> *devfreq,
>>>
>>> srcu_notifier_call_chain(&devfreq->transition_notifier_list,
>>>                                   DEVFREQ_POSTCHANGE, freqs);
>>>                   break;
>>> +       case DEVFREQ_USER_CHANGE:
>>> +               srcu_notifier_call_chain(&devfreq->transition_notifier_list,
>>> +                               DEVFREQ_USER_CHANGE, freqs);
>>> +               break;
>>>           default:
>>>                   return -EINVAL;
>>>           }
>>>
>>> If that is present, I can plumb your suggestion with:
>>> struct devfreq_freq {
>>> +       unsigned long new_max_freq;
>>> +       unsigned long new_min_freq;
>>>
>>> and populate them with values in the max_freq_store() by adding at the
>>> end:
>>>
>>> freqs.new_max_freq = max_freq;
>>> mutex_lock();
>>> devfreq_notify_transition(devfreq, &freqs, DEVFREQ_USER_CHANGE);
>>> mutex_unlock();
>>>
>>> I would handle this notification in devfreq cooling and keep the
>>> value there, for future IPA checks.
>>>
>>> If you agree, I can send next version of the patch set.
>>>
>>>>
>>>> What do you think Chanwoo?
>>
>> I thought that your suggestion to expose the user input for min/max_freq.
>> But, these values are not valid for the public user. Actually, the devfreq core
>> handles these values only internally without any explicit access from outside.
>>
>> I'm not sure that it is right or not to expose the internal value of
>> devfreq struct.
>> Until now, I think that it is not proper to show the interval value outside.
>>
>> Because the devfreq subsystem only provides the min_freq and max_freq
>> which reflect the all requirement of user input/cooling policy/OPP
>> instead of user_min_freq, user_max_freq.
>>
>> If we provide the user_min_freq, user_max_freq via DEVFREQ notification,
>> we have to make the new sysfs attributes for user_min_freq and user_max_freq
>> to show the value to the user. But, it seems that it is not nice.
> 
> I would say we don't have to expose it. Let's take a closer look into
> an example. The main problem is with GPUs. The middleware is aware of
> the OPPs in the GPU. If the middleware wants to switch into different
> power-performance mode e.g. power-saving, it writes into this sysfs
> the max allowed freq. IPA does not know about it and makes wrong
> decisions. As you said, the sysfs read operation combines all:
> user input/cooling policy/OPP, but that's not a problem for this aware
> middleware. So it can stay as is.
> The only addition would be this 'notification about user attempt of
> reducing max device speed' internally inside the kernel, for those
> subsystems which are interested in it.
As I commented on above, I'm not sure to provide the multiple
min/max_freq to outside of devfreq subsytem. Instead, it is ok
to use user min/max_freq inside of devfreq subsystem.

Unfortunately, I didn't suggests the good solution.
It is very important changes. So that I want to consider
the all users of devfreq.

> 
>>
>> Actually, I have no other idea how to support your feature.
>> We try to find the more proper method.
>>
> 
> Thank you for coming back with your comments. I know it's not
> an easy feature but I hope we can find a solution.
> 
> Regards,
> Lukasz
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
