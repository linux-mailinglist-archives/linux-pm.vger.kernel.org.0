Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCE7B960
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 07:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfGaF7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 01:59:46 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:40749 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaF7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 01:59:45 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190731055941epoutp0467dd332b9492eb36ed0fb97f5fc3f33e~2aHcvPKla3213732137epoutp04U
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:59:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190731055941epoutp0467dd332b9492eb36ed0fb97f5fc3f33e~2aHcvPKla3213732137epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564552781;
        bh=xB1BtDc7Td0WqeSb+RfxdTz7QOB8xqClgnbel9tM/Aw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SXSBYWP3KTaLhLCkEnzSbs9YKrHoJDtgg0kEYZ2s2LCseoK3mScGRNd3bC9tBGL9o
         ti/cxNA1dhJUJrmg71LA2ANIB9CXGpmic6a6qeIDMzBGBSHhkHrfNojWsBzsQrpDDK
         ai0A/RPGjO0BwkbTx9aT6ONDhzcRd6fXTA9HCsAs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190731055940epcas1p1fb5b52f1c4745f318eac07bc5b20e62f~2aHcDxyEN1197911979epcas1p1J;
        Wed, 31 Jul 2019 05:59:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45z2nN6n6szMqYm1; Wed, 31 Jul
        2019 05:59:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.B9.04088.73E214D5; Wed, 31 Jul 2019 14:59:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190731055919epcas1p3c1375339831c9022fd72a3a35ab14887~2aHIT-RZI1249212492epcas1p39;
        Wed, 31 Jul 2019 05:59:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190731055919epsmtrp2089dfc4c98ca6a1d9b4513a7c599a749~2aHITPuwg3017830178epsmtrp2p;
        Wed, 31 Jul 2019 05:59:19 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-00-5d412e37918c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.58.03638.73E214D5; Wed, 31 Jul 2019 14:59:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190731055919epsmtip24aa5aa0872b1c8f5cfe4aa3f2398dc4b~2aHIMIbxt1857718577epsmtip2l;
        Wed, 31 Jul 2019 05:59:19 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Drop the name check to request module in
 try_then_request_governor()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2e16d9c4-3207-6f0d-9210-1948f64b20cc@samsung.com>
Date:   Wed, 31 Jul 2019 15:02:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731135736.00006a55.zbestahu@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN67TTAa0+K8uVKMugH2IoHbA4KGAJxpBgEMOPMWlwLCMg3dIp
        ROTHJVEkYDSiSBGXFKPiUkNAQTEolAhEcSEKgdQlYgQXNKxGTLDtSOTv3PPOeSfnvUsRykoy
        hMo32XiriTPQpL/0bsfamGhWlaJTv5yUsK01boJ9dvibnJ2ocCF26NA1kq3t8dfK0lrsbnna
        icZ6lDbREJrWdNNBZEp3FSTm8VwObw3nTXpzTr4pN4lOz8pOzdbEq5loJoHdQIebOCOfRG/Z
        lhm9Nd/giaXDizhDoYfK5ASBjklOtJoLbXx4nlmwJdG8JcdgSbCoBM4oFJpyVXqzcSOjVsdq
        PMLdBXm9znLS4li9/9GFKulBNLmqDPlRgNdDq/OKrAz5U0rcjKBnqJUQh3EED2pnZV6VEk8j
        mBrbM++Yudn5z/EQwemZUlIcfiBwOf7IvarlOB8+DTikXhyAw+Dr6E8PT1EE3gtX3ayXJnEU
        tI0MkF68FEfA618fkRcrcDJ0znz3BUvxGnjbcIzw4kC8E8bfd8hEzTLorh72Xe+HE2B2rtqn
        IXAwDA5flIg4DI401fjaAO4n4U7XZ1JssAWcv28RIl4OX540ykUcAhNjD/9pSuB6t4sUzaUI
        GtteyMSDOGi7cloillkLzvsxIh0BLbO1SAxeAmNT5TKvBLACSo8qRUkk9L13S0S8AhzHjpMn
        EW1fUMe+oIJ9QQX7/7BLSFqPgniLYMzlBcbCLPzsBuTbyChNM6rs3daOMIXoxYounVanlHFF
        QrGxHQFF0AEKR/BmnVKRwxUf4K3mbGuhgRfakcbz2qeIkEC92bPfJls2o4mNi4tj1zPxGoah
        gxWXf7E6Jc7lbHwBz1t467xPQvmFHERddWNaktI8H3qszwiWR9QdTn319HtSeueXnh3Df+7d
        jn3UN/g5oqYsdt3oh3stI30pAUVR7tDn77Rr4rNe+a9MrlhUVtVkytLeXRfAqjuOXHjT+/sG
        d7ayns3YrjdPy0pdZOo5VVB/fFVr4Nz4DUdzZsm3fV2bFLNBkWeOT5jPL3XRUiGPY6IIq8D9
        BTeyk8qnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvK65nmOswfUeLYs9s+8yW5xtesNu
        8bn3CKPF7cYVbBZzT3E5sHrsnHWX3aNvyypGj8+b5Dy2rlnMHMASxWWTkpqTWZZapG+XwJVx
        bn0PW8FilYoD86azNDB+ke1i5OSQEDCR+L7mKGsXIxeHkMBuRondp68zQiQkJaZdPMrcxcgB
        ZAtLHD5cDBIWEnjLKPH6QwSILSyQKfH0xmIWEFtEQF7i9csP7CA2s0CaxNJn06FmXmKSmL+u
        EyzBJqAlsf/FDTYQm19AUeLqj8dgu3gF7CSOfn/LCmKzCKhK3NvUzgxiiwpESBzeMQuqRlDi
        5MwnYMs4BSwlfv+fyQyxTF3iz7xLULa4xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQs
        YGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHC1aWjsYT5yIP8QowMGoxMN7ItYh
        Vog1say4MvcQowQHs5II72Jx+1gh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1Kz
        U1MLUotgskwcnFINjKmL2K200ox5GKfwn9opalOoJuV9hVXDqXiZt/Jn5s8cChun5Mu2BXzi
        6JipNsP3yKrFngfalj5+wh8Qpr7Aes0S381sc5uVjhwUEXhk0DzT8J2we9TZ5RN1H+yQv8C2
        V1cg9XnCFF6HYEmhLa5BMuHn3VlzvkxulH2zpFX5oEKC3anYKyH8SizFGYmGWsxFxYkAro+L
        tJICAAA=
X-CMS-MailID: 20190731055919epcas1p3c1375339831c9022fd72a3a35ab14887
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
        <cf760204-2504-cef9-09e7-19643986a902@samsung.com>
        <20190731135736.00006a55.zbestahu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 31. 오후 2:57, Yue Hu wrote:
> On Wed, 31 Jul 2019 14:55:39 +0900
> Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>> On 19. 7. 31. 오후 2:38, Yue Hu wrote:
>>> On Wed, 31 Jul 2019 09:33:06 +0900
>>> Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>   
>>>> On 19. 7. 30. 오후 7:08, Yue Hu wrote:  
>>>>> From: Yue Hu <huyue2@yulong.com>
>>>>>
>>>>> No need to check specific governor name of `simple_ondemand` to request
>>>>> module, let's change the name string to `simpleondemand` to keep the
>>>>> consistency on loading module if needed.    
>>>>
>>>> NACK.
>>>>
>>>> hmm.... It is impossible to change the devfreq governor name
>>>> because there are many reason.
>>>>
>>>> The devfreq governor could be changed through the sysfs interface
>>>> on runtime. For a long time, many users or platforms change
>>>> the devfreq governor with the defined governor name through sysfs.
>>>> If it is just changed, it breaks ABI interface and cannot support
>>>> the compatibility. It is very critical problem. Please drop it.  
>>>
>>> Yes, needs update also if using sysfs. it's problem indeed.  
>>
>> No, It is impossible to update it. You have to change all kind of
>> platform in the world. We never know the all use-case in the world.
>> As I said, it break the ABI interface. 
>>
>>>   
>>>>
>>>>
>>>> Maybe, you didn't check the usage of devfreq device driver
>>>> in the mainline kernel. Almost devfreq device using simple_ondemand
>>>> governor have to add the governor name with devfreq_add_device().
>>>> If changed the governor name, it cause the fault of device driver
>>>> using the devfreq framework with simple_ondemand.  
>>>
>>> Currently, seems no devfreq users use the simple_ondemand directly in
>>> mainline kernel.  
>>
>> You can find them in the mainline kernel as following:
>>
>> drivers/gpu/drm/panfrost/panfrost_devfreq.c:160:&panfrost_devfreq_profile, "simple_ondemand", NULL);
>> drivers/gpu/drm/msm/msm_gpu.c:98:		&msm_devfreq_profile, "simple_ondemand", NULL);
> 
> drm related code is already updated as below link:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=67fe62dcf713c36f4766c0218cc14796ee9536e1
> 
>>
>> drivers/scsi/ufs/ufshcd.c:1333:			DEVFREQ_GOV_SIMPLE_ONDEMAND,
>> drivers/devfreq/tegra20-devfreq.c:176:		DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
>> drivers/devfreq/rk3399_dmc.c:452:		DEVFREQ_GOV_SIMPLE_ONDEMAND,
>> drivers/devfreq/exynos-bus.c:437:		DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>
>>>
>>> Maybe we can rename the governor file name to governor_simpleondemand.c,
>>> just not compatible to module name compared with this change.  
>>
>> The file name was already 'drivers/devfreq/governor_simpleondemand.c'.
> 
> Sorry for the typo error. I mean governor_simple_ondemand.c?

Actually, it is not necessary because there are no benefit.

> 
> Thanks.
> 
>>
>>
>>>
>>> Thanks.
>>>   
>>>>
>>>>  
>>>>>
>>>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>>>>> ---
>>>>>  drivers/devfreq/devfreq.c | 6 +-----
>>>>>  include/linux/devfreq.h   | 2 +-
>>>>>  2 files changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index 784c08e..baff682 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -246,11 +246,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>>>>>  	if (IS_ERR(governor)) {
>>>>>  		mutex_unlock(&devfreq_list_lock);
>>>>>  
>>>>> -		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>>>> -			     DEVFREQ_NAME_LEN))
>>>>> -			err = request_module("governor_%s", "simpleondemand");
>>>>> -		else
>>>>> -			err = request_module("governor_%s", name);
>>>>> +		err = request_module("governor_%s", name);
>>>>>  		/* Restore previous state before return */
>>>>>  		mutex_lock(&devfreq_list_lock);
>>>>>  		if (err)
>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>> index 2bae9ed..41e8792 100644
>>>>> --- a/include/linux/devfreq.h
>>>>> +++ b/include/linux/devfreq.h
>>>>> @@ -17,7 +17,7 @@
>>>>>  #define DEVFREQ_NAME_LEN 16
>>>>>  
>>>>>  /* DEVFREQ governor name */
>>>>> -#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
>>>>> +#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simpleondemand"
>>>>>  #define DEVFREQ_GOV_PERFORMANCE		"performance"
>>>>>  #define DEVFREQ_GOV_POWERSAVE		"powersave"
>>>>>  #define DEVFREQ_GOV_USERSPACE		"userspace"
>>>>>     
>>>>
>>>>  
>>>
>>>
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
