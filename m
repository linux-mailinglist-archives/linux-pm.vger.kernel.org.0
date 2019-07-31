Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3B7B93F
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 07:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfGaFwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 01:52:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:10748 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfGaFwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 01:52:40 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190731055238epoutp03d462289653b0bad7c380460956df2dd8~2aBS3YKZN2530625306epoutp035
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:52:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190731055238epoutp03d462289653b0bad7c380460956df2dd8~2aBS3YKZN2530625306epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564552358;
        bh=EMxpV94QnLFbbK1m6QEpygJ/Sg51qPVlUyqEEBfBw/M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lXTDzIuT64cTSwFRAR32w74D1fO15huL8grvgNL2/ar87CuttWVH1q8nziruKBoEr
         RDq59M6f6xoxtPqdNBxp+z3n/cPv0V9UKqGhW0xDGNCsy0+7rJnKAtgbWJYymKekhP
         AON1hL3IDsfONUuHmXXLaoSJq99Jic+8AZ0do/j4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190731055238epcas1p2d859d47c3528bf0c575ee322fabad602~2aBSZ2_oO0728107281epcas1p2L;
        Wed, 31 Jul 2019 05:52:38 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45z2dG04RqzMqYkg; Wed, 31 Jul
        2019 05:52:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.AB.04075.E9C214D5; Wed, 31 Jul 2019 14:52:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190731055229epcas1p401605ac929a4ba47b5caef8951756e59~2aBKrJzhO1900119001epcas1p4I;
        Wed, 31 Jul 2019 05:52:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190731055229epsmtrp2b787ec8d5b0c390fb43f6dd5f4cc9a59~2aBKqc3go2571825718epsmtrp2F;
        Wed, 31 Jul 2019 05:52:29 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-01-5d412c9e2bfc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.D7.03638.D9C214D5; Wed, 31 Jul 2019 14:52:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190731055229epsmtip17c301a1d607429a22316721b3997a4e9~2aBKg0rUx2539025390epsmtip1j;
        Wed, 31 Jul 2019 05:52:29 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Drop the name check to request module in
 try_then_request_governor()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cf760204-2504-cef9-09e7-19643986a902@samsung.com>
Date:   Wed, 31 Jul 2019 14:55:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731133808.00006f5b.zbestahu@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTYRzHeXa32yldPc3MX/sj7aQ3ydptzc5SM4oSGjGoPyRY63CXjr3c
        2s2R9c8sMbNXqYhmpWVvWhKIlkXDsBctLAQtIxm9R2VYbBRW/7TriPzv83x/3y+/+z730IS+
        gTLQLl9QDPgED0ulktfvLjTmnlm0ym5su5jN326MEfzj3V90fOLgPcSPVl+m+NOPUou1JTcj
        MV3Joc42VJLomF3SdbWFsJGb3QUVouAUA1mir0xyunzlhez6jY7VDkuekcvl8vllbJZP8IqF
        7BqrLXety5Ncy2aFBE9lUrIJsswuKSoISJVBMatCkoOFrOh3evz5/sWy4JUrfeWLyyTvcs5o
        NFmSxq3uiu6aO5S/b/aOswM/yTA6NasepdCAl8LIsWtkPUql9bgbQXTsgEY9xBG8CbdS6uEH
        gqeHzycn9N9IzctMJa3HUQQ1DaB6viL4PTRMKIM07IL3z1tIhWfgTBj79E2nZAm8DS7FeEWm
        cA70fHxOKTwNz4GnE2+RYmFwEdzvKlZkEs+F14fadAqn41KIv7qrVZjB0+HhyXekYk/B+XDn
        ZUiRCZwBL941aVTOhD1djYTyZYBHKRgZjBNq4TWw51c7qXIafO7r1KlsgMR4lFJ5F7Q+vEep
        4ToEnT2DWnVghp4LRzVqlYVw7dYSVZ4DN3+fRuriqTD+/YBWvSkG6mr1qiUbhl7FNCrPgpa9
        +6gjiI1MahOZVCEyqULk/7JmRLahmaJf9paLMuc3Tf7THejvc8zJ60bnnlh7EaYRO4Xptxfb
        9VohJFd5exHQBDuDaclYadczTqFqpxiQHIFKjyj3IkvyshsIQ3qZlHzcvqCDs5jMZjO/lMuz
        cBybwZyd4O16XC4ERbco+sXAv5yGTjGE0ZW6Doclnba15lmeNS7rupQtSD9CH06ggQvRROkz
        Ml693SSbr8sj3upQ6XDzfFdwf2yFlHDbr0iltvDyAas42L4fFW1asMHptlZx9WMxv8mgnauv
        JY9TH+on5jUfuWFF69p3eQrQgwWPxpsZ5sRo/+1gU9gVj0e3pJ2rZUm5QuByiIAs/AFeXjeJ
        pAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnO5cHcdYg+5nphZ7Zt9ltjjb9Ibd
        4nPvEUaL240r2CzmnuJyYPXYOesuu0ffllWMHp83yXlsXbOYOYAlissmJTUnsyy1SN8ugStj
        R8sBtoLjchULz/xkaWCcI9nFyMEhIWAi0XJfvouRi0NIYDejxL09D1m6GDmB4pIS0y4eZYao
        EZY4fLgYouYto8TMxW8ZQWqEBTIlnt5YDFYvIiAv8frlB3YQm1kgTWLps+msEA3vGCVuHdzB
        DJJgE9CS2P/iBhuIzS+gKHH1x2NGkAW8AnYSR7c6gIRZBFQlHvatApsjKhAhcXjHLLBdvAKC
        EidnPmEBKecUsJQ4cL8MYpW6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkexaSlllIWmYh
        aVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4UrS0djCeOBF/iFGAg1GJh/dE
        rEOsEGtiWXFl7iFGCQ5mJRHexeL2sUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeW
        pGanphakFsFkmTg4pRoY8znTFuqV7T+c/nMKk3pu44SCnJy9dzcfu5JU2sr9/47JnaWnzXZs
        MElWPLFo/s2n3EULm509f877+HxBc3RTWWLEOmP9cE29W17rtARE4r8c2+o9eZnXhpLC0tYl
        L7SXzUziZbq8tcfY/LgIr6Hu/rmSv+9OX7Hssk3Pzw/6xd9vRh7ocHUqU2Ipzkg01GIuKk4E
        AOVF2FqQAgAA
X-CMS-MailID: 20190731055229epcas1p401605ac929a4ba47b5caef8951756e59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190730100844epcas4p14dfa39fff2636e89c94033f154240db0
References: <CGME20190730100844epcas4p14dfa39fff2636e89c94033f154240db0@epcas4p1.samsung.com>
        <20190730100819.8056-1-zbestahu@gmail.com>
        <8e5efa9c-96c4-0c2c-b92a-d72ee598838c@samsung.com>
        <20190731133808.00006f5b.zbestahu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 31. 오후 2:38, Yue Hu wrote:
> On Wed, 31 Jul 2019 09:33:06 +0900
> Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>> On 19. 7. 30. 오후 7:08, Yue Hu wrote:
>>> From: Yue Hu <huyue2@yulong.com>
>>>
>>> No need to check specific governor name of `simple_ondemand` to request
>>> module, let's change the name string to `simpleondemand` to keep the
>>> consistency on loading module if needed.  
>>
>> NACK.
>>
>> hmm.... It is impossible to change the devfreq governor name
>> because there are many reason.
>>
>> The devfreq governor could be changed through the sysfs interface
>> on runtime. For a long time, many users or platforms change
>> the devfreq governor with the defined governor name through sysfs.
>> If it is just changed, it breaks ABI interface and cannot support
>> the compatibility. It is very critical problem. Please drop it.
> 
> Yes, needs update also if using sysfs. it's problem indeed.

No, It is impossible to update it. You have to change all kind of
platform in the world. We never know the all use-case in the world.
As I said, it break the ABI interface. 

> 
>>
>>
>> Maybe, you didn't check the usage of devfreq device driver
>> in the mainline kernel. Almost devfreq device using simple_ondemand
>> governor have to add the governor name with devfreq_add_device().
>> If changed the governor name, it cause the fault of device driver
>> using the devfreq framework with simple_ondemand.
> 
> Currently, seems no devfreq users use the simple_ondemand directly in
> mainline kernel.

You can find them in the mainline kernel as following:

drivers/gpu/drm/panfrost/panfrost_devfreq.c:160:&panfrost_devfreq_profile, "simple_ondemand", NULL);
drivers/gpu/drm/msm/msm_gpu.c:98:		&msm_devfreq_profile, "simple_ondemand", NULL);

drivers/scsi/ufs/ufshcd.c:1333:			DEVFREQ_GOV_SIMPLE_ONDEMAND,
drivers/devfreq/tegra20-devfreq.c:176:		DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
drivers/devfreq/rk3399_dmc.c:452:		DEVFREQ_GOV_SIMPLE_ONDEMAND,
drivers/devfreq/exynos-bus.c:437:		DEVFREQ_GOV_SIMPLE_ONDEMAND,

> 
> Maybe we can rename the governor file name to governor_simpleondemand.c,
> just not compatible to module name compared with this change.

The file name was already 'drivers/devfreq/governor_simpleondemand.c'.


> 
> Thanks.
> 
>>
>>
>>>
>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 6 +-----
>>>  include/linux/devfreq.h   | 2 +-
>>>  2 files changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 784c08e..baff682 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -246,11 +246,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>>>  	if (IS_ERR(governor)) {
>>>  		mutex_unlock(&devfreq_list_lock);
>>>  
>>> -		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>> -			     DEVFREQ_NAME_LEN))
>>> -			err = request_module("governor_%s", "simpleondemand");
>>> -		else
>>> -			err = request_module("governor_%s", name);
>>> +		err = request_module("governor_%s", name);
>>>  		/* Restore previous state before return */
>>>  		mutex_lock(&devfreq_list_lock);
>>>  		if (err)
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index 2bae9ed..41e8792 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -17,7 +17,7 @@
>>>  #define DEVFREQ_NAME_LEN 16
>>>  
>>>  /* DEVFREQ governor name */
>>> -#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
>>> +#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simpleondemand"
>>>  #define DEVFREQ_GOV_PERFORMANCE		"performance"
>>>  #define DEVFREQ_GOV_POWERSAVE		"powersave"
>>>  #define DEVFREQ_GOV_USERSPACE		"userspace"
>>>   
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
