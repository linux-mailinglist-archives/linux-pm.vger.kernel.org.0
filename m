Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F504991A3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfHVLGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 07:06:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13580 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfHVLGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 07:06:38 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190822110635epoutp0430989018756128ae6a2cb6346e81bb94~9Ofr5FX-92066620666epoutp04W
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 11:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190822110635epoutp0430989018756128ae6a2cb6346e81bb94~9Ofr5FX-92066620666epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566471995;
        bh=TAoKfGBQpqWLoUvIFbA8wZ6nWF6kfhBScSiKNEYhBiE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DtB5kOFR5DlJtSLj5Eu+GhIIS0ZAzy4hTIMmuR2dEhWztbDT6fpp0kQ3YxyWSUS41
         u3a2V2nFrwVnm/z4fmPFE3AMLEc3deBq7kOQmOi28RG9uOxDc0AO0W8W6sPWZ9MFhy
         MRNfo5vSu4U9Uos+1O1WmJeX9q+4bHYJEVghEiqc=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190822110634epcas1p2b8a5872bc9f1c97a77c71be029c58bf8~9OfrXCRJa2560525605epcas1p2V;
        Thu, 22 Aug 2019 11:06:34 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46DhYN5SNlzMqYkh; Thu, 22 Aug
        2019 11:06:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.9A.04085.8377E5D5; Thu, 22 Aug 2019 20:06:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190822110632epcas1p42a10918858f147261f07c0e51c7ae907~9Ofo55jSL0654606546epcas1p4Q;
        Thu, 22 Aug 2019 11:06:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190822110632epsmtrp1a6dacf92ef708b814e8b805cbe090340~9Ofo5Atjd0142401424epsmtrp1Q;
        Thu, 22 Aug 2019 11:06:32 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-ba-5d5e7738f37c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.B3.03638.8377E5D5; Thu, 22 Aug 2019 20:06:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190822110632epsmtip1afbecc74250951fc3972a8b7b3504f13~9OfoqwDfm2504525045epsmtip1_;
        Thu, 22 Aug 2019 11:06:32 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4bdc0742-42ab-1ab6-4868-409eb9738cd8@samsung.com>
Date:   Thu, 22 Aug 2019 20:10:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023D551332373BE98CA60E8EEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmga5FeVysQcspbYtDx7ayW3w9fYrR
        4uUhTYvpezexWZw/v4Hd4mzTG3aLFXc/slpsenyN1eJz7xFGi9uNK9gsVp87yGbRdegvm8XG
        rx4OvB7vb7SyeyzYVOqxaVUnm8eda3vYPDYvqffY+G4Hk8fBd3uYPPq2rGL0+LxJLoAzKtsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hoJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xqKv
        u5kKtqhVzPtc0cC4QL6LkZNDQsBE4vHsa8xdjFwcQgI7GCWmNlxlhXA+MUq8e7mPEcL5xiix
        pus5O0zLxAXTmSASexklGg5uZoFw3jNKPNl0ECjDwSEsECgxe1caSFxEYC2jxOT588DmMgsc
        ZZY4taqPGWQUm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYSd+dMZwGxWQRUJV7cnQFWLyoQIfHp
        wWFWiBpBiZMzn4DVcArESuz8+wjsPGYBcYlbT+YzQdjyEs1bZzNDnL2JXeJzdz2E7SLRfv4J
        G4QtLPHq+Bao16QkXva3QdnVEitPHmEDOVpCoINRYsv+C6wQCWOJ/Usng33JLKApsX6XPkRY
        UWLn77mMEDavRMPG31D38Em8+9rDClIOEu9oE4IoUZa4/OAu0wRG5VlIvpmF5INZSD6YhbBs
        ASPLKkax1ILi3PTUYsMCU+TY3sQITtBaljsYj53zOcQowMGoxMM7QTc2Vog1say4MvcQowQH
        s5IIb8WcqFgh3pTEyqrUovz4otKc1OJDjKbAwJ7ILCWanA/MHnkl8YamRsbGxhYmhmamhoZK
        4rwLf1jECgmkJ5akZqemFqQWwfQxcXBKNTCmXtv6cfc59eUcUwV8v5+1Ul5+9MS00tlM0k3r
        Fj4SmjWB+3+2zpTzX/nPGxocCN+dyFpbeS7mSa3PMqvot4xrDzo4FPv+na+wPlHcIzf+aqpy
        tN8SVmbD2dtD95r6Cq6UXSAuF6S55f+eZP6KznJdw1mpPBZ3rGSzfd9XcHWlS05boW7E06HE
        UpyRaKjFXFScCADbVCuz5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnK5FeVyswYKTnBaHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWK+5+ZLXY9Pgaq8Xn3iOMFrcbV7BZrD53kM2i69BfNouN
        Xz0ceD3e32hl91iwqdRj06pONo871/aweWxeUu+x8d0OJo+D7/YwefRtWcXo8XmTXABnFJdN
        SmpOZllqkb5dAlfGoq+7mQq2qFXM+1zRwLhAvouRk0NCwERi4oLpTF2MXBxCArsZJVY9msYK
        kZCUmHbxKHMXIweQLSxx+HAxRM1bRontfyYygsSFBQIlZu9KAykXEVjPKNFzxh/EZhY4yiyx
        a00yRP0nIPvpHGaQBJuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2EnfnTGcBsVkEVCVe3J0BVi8q
        ECFxeMcsqBpBiZMzn4DVcArESuz8+4gdYpm6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWk
        fRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4TrW0djCeOBF/
        iFGAg1GJh3eCbmysEGtiWXFl7iFGCQ5mJRHeijlRsUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        5fOPRQoJpCeWpGanphakFsFkmTg4pRoYzYWYQ1NkXj61/uJQwxMWzJf0SHtjzN/E+bMrGM4/
        TdnAK2F7i1nbqC08zfDss4nbhU7P+nHvz/vthTM2OO/Y9nsWZ4TPDo01b9x+bVg5nSsneGP6
        /tYtfjOlzk3ist5bXH40duf7ZnYNxtApFvkh3ad69DUiUvwEP9SJmjPsdj+0kClZ/VSzEktx
        RqKhFnNRcSIAHMRXcM8CAAA=
X-CMS-MailID: 20190822110632epcas1p42a10918858f147261f07c0e51c7ae907
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1
References: <cover.1566314535.git.leonard.crestez@nxp.com>
        <CGME20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1@epcas4p3.samsung.com>
        <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
        <e2ba9b0d-1930-0d2a-c262-72f0f85c86d0@samsung.com>
        <VI1PR04MB7023A7AC7DDE349BF6D2D2C9EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <921d9eb8-aa38-6e67-ac2e-55e01bf630f5@samsung.com>
        <VI1PR04MB7023D551332373BE98CA60E8EEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 22. 오후 7:58, Leonard Crestez wrote:
> On 8/22/2019 1:03 PM, Chanwoo Choi wrote:
>> On 19. 8. 21. 오후 10:03, Leonard Crestez wrote:
>>> On 21.08.2019 05:02, Chanwoo Choi wrote:
>>>> On 19. 8. 21. 오전 12:24, Leonard Crestez wrote:
>>>>> Now that devfreq supports dev_pm_qos requests we can use them to handle
>>>>> the min/max_freq values set by userspace in sysfs, similar to cpufreq.
>>>>>
>>>>> Since dev_pm_qos handles frequencies as kHz this change reduces the
>>>>> precision of min_freq and max_freq. This shouldn't introduce problems
>>>>> because frequencies which are not an integer number of kHz are likely
>>>>> not an integer number of Hz either.
>>>>>
>>>>> Try to ensure compatibilitity by rounding min values down and rounding
>>>>> max values up.
>>>>>
>>>>> Simplify the {min,max}_freq_store code by setting "null" values of 0 and
>>>>> MAX_S32 respectively instead of clamping to what freq tables are
>>>>> actually supported. Values are already automatically clamped on
>>>>> readback.
>>>>>
>>>>> Also simplify by droping the limitation that userspace min_freq must be
>>>>> lower than userspace max_freq, it is already documented that max_freq
>>>>> takes precedence.
>>>>>
>>>>> @@ -1358,33 +1371,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>    
>>>>>    	ret = sscanf(buf, "%lu", &value);
>>>>>    	if (ret != 1)
>>>>>    		return -EINVAL;
>>>>>    
>>>>> -	mutex_lock(&df->lock);
>>>>> -
>>>>> -	if (value) {
>>>>> -		if (value > df->max_freq) {
>>>>> -			ret = -EINVAL;
>>>>> -			goto unlock;
>>>>> -		}
>>>>
>>>> Actually, the user can input the value they want.
>>>> So, the above code is not necessary because the devfreq->scaling_max_freq
>>>> is never overflow from supported maximum frequency. The devfreq->scaling_max_freq
>>>> is based on OPP entries from DT.
>>>>
>>>> But, if we replace the existing request way of devfreq-cooling.c
>>>> with dev_pm_qos, devfreq->scaling_max_freq doesn't guarantee
>>>> the supported maximum frequency. >
>>>> We need to keep the supported min_freq/max_freq value without dev_pm_qos
>>>> requirement because the dev_pm_qos requirement might have the overflow value.
>>>> the dev_pm_qos doesn't know the supported minimum and maximum frequency
>>>> of devfreq device.
>>>
>>> I'm not sure I understand what you mean. My patch allows user to set
>>> entirely arbitrary min/max rates and this is good because we already
>>> have a well-defined way to handle this: max overrides min.
>>>
>>> The scaling_min_freq and scaling_max_freq variables can just be kept
>>> around indefinitely no matter what happens to thermal. They're just a
>>> cache for dev_pm_opp_find_freq_ceil and dev_pm_opp_find_freq_floor.
>>
>> This patch doesn't check the range of input value
>> with the supported frequencies of devfreq device.
>>
>> For example,
>> The devfreq0 device has the following available frequencies
>> 100000000 200000000 300000000
>>
>> and then user enters the 500000000 as following:
>> echo 500000000 > /sys/class/devfreq/devfreq0/min_freq
>>
>> In result, get_effective_min_freq() will return the 500000000.
>> It is wrong value. it show the unsupported frequency through
>> min_freq sysfs path.
> 
> Through dev_pm_qos devices can also ask for a freq higher than the 
> maximum OPP and unlike sysfs there is no way to reject such requests, 
> instead PM qos claims it's based on "best effort".
> 
> There are many requests in the kernel for "PM_QOS_CPU_DMA_LATENCY 0" and 
> I think that DEV_PM_QOS_MIN_FREQUENCY, MAX_S32 is a reasonable way for a 
> device to request "max performance" from devfreq.
> 
> Rejecting min > max is complicated (what happens to rejected requests 
> when max goes back up?) and I think it's better to just stick with a 
> "max overrides min" policy since it can already deal with conflicts.
> 
> Do you have a usecase for rejecting out-of-range min_freq from 
> userspace? cpufreq also accepts arbitrary min/max values and handles them.

I don't mean the rejecting when user enter the out-of-range frequency.
As I commented, user can enter the value they want. But, we should
check the range of input because devfreq have to show the correct supported
frequency through sysfs.

> 
> In theory pm_qos could be extended to differentiate between "soft" 
> requests (current behavior) and "hard" requests which return errors if 
> they can't be guaranteed but this is far out of scope.

I think that you agreed the limitation of dev_pm_qos when entering
or requesting the unsupported frequency.

Until fixing it on dev_pm_qos, it have to be handled on consumer
like devfreq. I think that get_min_freq() and get_max_freq() have
to check the range of return value of dev_pm_qos_read_value().


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
