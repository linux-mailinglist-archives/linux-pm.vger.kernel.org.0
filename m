Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE0333354
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 03:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhCJCvI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 21:51:08 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:48379 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhCJCuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 21:50:51 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210310025049epoutp01e9e164128b7829ab0101fbaef2d71223~q22aL4idS2855028550epoutp01E
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 02:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210310025049epoutp01e9e164128b7829ab0101fbaef2d71223~q22aL4idS2855028550epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615344649;
        bh=qIxUNdnPO494Nd9HXhp2ZTWIoilJGB57TyEjNOyPpRs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pYPNmGI36EhaEAMFO+sctiARjBHT7qnS9q0j15iZ6HD+1A5GgU46hny6la2glZXCk
         7ITHGrKF4rFr1FyciCpk9DZuIgmaoqGivOVznIBOFDjVysilru9yljDUaL/l/MYJeW
         2NRIrBBnWqMggra74j5Z4DWB2RrkpDsplRwt1tHk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210310025049epcas1p35da29764350859070edea4759b96be41~q22ZaY3Cf0942409424epcas1p3a;
        Wed, 10 Mar 2021 02:50:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DwGm65v4Bz4x9Q2; Wed, 10 Mar
        2021 02:50:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.35.02418.60438406; Wed, 10 Mar 2021 11:50:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210310025046epcas1p1f5d3cecf2bbd82209db185a3587454d9~q22WqGhWK1365613656epcas1p13;
        Wed, 10 Mar 2021 02:50:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210310025046epsmtrp1e4aad8a3f02e7661e3bef0b5d973628f~q22WpLg7C0937509375epsmtrp1g;
        Wed, 10 Mar 2021 02:50:46 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-20-604834064b2e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.E6.13470.50438406; Wed, 10 Mar 2021 11:50:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210310025045epsmtip1fa5b563fb18243a790bf34e18de5f7c2~q22WXGri61715217152epsmtip1P;
        Wed, 10 Mar 2021 02:50:45 +0000 (GMT)
Subject: Re: [PATCH 05/11] PM / devfreq: use more accurate returned new_freq
 as resume_freq
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
Message-ID: <aea8cf18-ebe3-6140-e202-5f082040bbae@samsung.com>
Date:   Wed, 10 Mar 2021 12:07:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAA+hA=QpAcu0OVZwm8DuqUsENMem-+59QwOt0Y9cqstuGO5VEw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmgS6biUeCwdm/uhbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGz0//WQvm8VXsuHWZsYFxIXcX
        IyeHhICJxM2jC5i6GLk4hAR2MEo8nHqEGSQhJPCJUeLDER2IxDdGiXu7V7PDdLxZtZ8RIrGX
        UeL697vsEM57Ronj+yexglQJC8RKdE3bwQRiiwh4SFyaPoUNpIhZYCGzxOc9j1hAEmwCWhL7
        X9xgA7H5BRQlrv54zAhi8wrYSXSunwYWZxFQleh/tw1sqKhAmMTJbS1QNYISJ2c+AZvDKRAo
        serBXrDzmAXEJW49mc8EYctLNG+dzQyyWELgDIfEs87zrBA/uEjsfbCfEcIWlnh1fAvUb1IS
        L/vboOxqiZUnj7BBNHcwSmzZfwGq2Vhi/9LJQBs4gDZoSqzfpQ8RVpTY+XsuI8RiPol3X3tY
        QUokBHglOtqEIEqUJS4/uMsEYUtKLG7vZJvAqDQLyTuzkLwwC8kLsxCWLWBkWcUollpQnJue
        WmxYYIgc3ZsYwUlYy3QH48S3H/QOMTJxMB5ilOBgVhLh9TvuliDEm5JYWZValB9fVJqTWnyI
        0RQYwBOZpUST84F5IK8k3tDUyNjY2MLE0MzU0FBJnDfJ4EG8kEB6YklqdmpqQWoRTB8TB6dU
        A9OxmFXylZcW/PnHVxhamHjJfE3LPG4J0bMmx90YDPdeynZmEmc8G2vgt2flS75vrT+9F/hw
        Nht/aPX+t6NO8YJj2SruBMu1ySXPZXr2Tttfb7vlX1L2hNd5mhGscV8k901Ne/nzwORDSuws
        WQvqlxmbXPf+yMlx89CnU/qXIi5MLchhnnHpWf3XhHWXXopIqP7sF+oqq4moK3j71eD1sWZt
        52fd4utkZdRuTNewcXn9zd9GRmhC/PepS7UXifIteGTK93ji56lVRU7bi9eYX5q3u/hYnOuH
        FbfevF6Td1Sl6v5/bXbPv0IH/iXJp4Y1ubin2S1+aKSbOiXEx3/ylw3yZSczX7PJFfG3lnFd
        fqrEUpyRaKjFXFScCACCp22HSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnC6riUeCwcIeS4tll44yWnyZuovZ
        4tlRbYu/m6ezWayaupPF4mzTG3aLTY+vsVp0/VrJbHF51xw2i8+9RxgtbjeuYLN4sUXcgcdj
        56y77B6bVnWyeWxeUu+x8d0OJo/+vwYefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlfHz03/W
        gnl8FTtuXWZsYFzI3cXIySEhYCLxZtV+xi5GLg4hgd2MEt1bWhghEpIS0y4eZe5i5ACyhSUO
        Hy6GqHnLKDF34RsWkBphgViJrmk7mEBsEQEPiUvTp7CBFDELLGSWWLh3BTNEx1kmidV/b4BN
        ZRPQktj/4gYbiM0voChx9cdjsDivgJ1E5/ppYHEWAVWJ/nfbWEFsUYEwiZ1LHjNB1AhKnJz5
        BGwzp0CgxKoHe9lBbGYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTMQtKy
        gJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcDxqae5g3L7qg94hRiYOxkOMEhzM
        SiK8fsfdEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        snDQ/6RRuk4r0OGjTUds0JLkzM3ajC/3SkipLzmg+fNF+Mpgr4xf733sil4s8fplb3i0UE6a
        fbHJnr6th+a+FZvOoFnMp5sXt+jEprgPth4lf3vFLpdflKzhNqlqid6uUP6smOuDrpIQq5+/
        u34Qi/sqcZWo5KpS+YLvGZe6OP1W8zjyNdz5ufT4Eo5VanOyk8583ZAns1onf1dExmwnnwC9
        /cEcDcbb3ly/vDR/pfUGpliJ+M/96XWmPY7mS//2HXq5VouBQ+K/7MfFR3fnb2hcuul9ue4z
        fr/uUMWUBO7uNXu/zg7kO957dpezwfPrByYvtX4qE/9n4kR+hQsqdywC/qa9u1CZmnbp8Dwl
        luKMREMt5qLiRABOXjloNgMAAA==
X-CMS-MailID: 20210310025046epcas1p1f5d3cecf2bbd82209db185a3587454d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210310024415epcas1p1796666ad300fc299194df162299d389b
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
        <1615294733-22761-6-git-send-email-aisheng.dong@nxp.com>
        <83240e9d-383a-74a9-3222-68cf42d3d0e1@gmail.com>
        <CGME20210310024415epcas1p1796666ad300fc299194df162299d389b@epcas1p1.samsung.com>
        <CAA+hA=QpAcu0OVZwm8DuqUsENMem-+59QwOt0Y9cqstuGO5VEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/10/21 11:43 AM, Dong Aisheng wrote:
> On Tue, Mar 9, 2021 at 11:53 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>
>> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>>> Use the more accurate returned new_freq as resume_freq.
>>> It's the same as how devfreq->previous_freq was updated.
>>>
>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>> ---
>>>   drivers/devfreq/devfreq.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 6e80bf70e7b3..ce569bd9adfa 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -390,7 +390,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>>       devfreq->previous_freq = new_freq;
>>>
>>>       if (devfreq->suspend_freq)
>>> -             devfreq->resume_freq = cur_freq;
>>> +             devfreq->resume_freq = new_freq;
>>>
>>>       return err;
>>>   }
>>>
>>
>> This patch fixes the previous patch[1]. So that you need to
>> add 'Fixes' tag as following:
>>
>> Fixes: 83f8ca45afbf0 ("PM / devfreq: add support for suspend/resume of a
>> devfreq device")
>>
> 
> Will add Fixes tag in next version.


On next version, recommend to place this patch at the first.

> 
>> commit 83f8ca45afbf041e312909f442128b99657d90b7
>> Refs: v4.20-rc6-2-g83f8ca45afbf
>> Author:     Lukasz Luba <lukasz.luba@arm.com>
>> AuthorDate: Wed Dec 5 12:05:53 2018 +0100
>> Commit:     MyungJoo Ham <myungjoo.ham@samsung.com>
>> CommitDate: Tue Dec 11 11:09:47 2018 +0900
>>
>>      PM / devfreq: add support for suspend/resume of a devfreq device
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
