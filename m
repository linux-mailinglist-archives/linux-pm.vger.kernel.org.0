Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC7336C6B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 07:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhCKGpF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 01:45:05 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:33501 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhCKGor (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 01:44:47 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210311064445epoutp020d45c6cac0fbdc3b9d5e3e957593e2ab~rNr8L0Ltr0462904629epoutp02N
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 06:44:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210311064445epoutp020d45c6cac0fbdc3b9d5e3e957593e2ab~rNr8L0Ltr0462904629epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615445085;
        bh=pMFn9EayTQ69JcaUJZXw6TWW78K+IaDdH231vbsCQ5A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jxDGeKXLVLaPSJU5TjlxvpbzgOwc9gfbh9YnAuSF9S9fGH3kFjrYsLKh6n4p3aU7C
         QgEihnhPIxH/jKl+rDhM78R1QXqx9fe5XQvAR6+g11o86PPoahzltlGgzrXAiQ33JT
         c21u7WQC9MKMV1MmsYyLAAy5VXizh7yGfxqILdpA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210311064444epcas1p46d4bb2a7d5aa20a5babdf4dfc9ca7ffb~rNr7LFACm0463004630epcas1p46;
        Thu, 11 Mar 2021 06:44:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DwzvZ0RLwz4x9QK; Thu, 11 Mar
        2021 06:44:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.4A.59147.95CB9406; Thu, 11 Mar 2021 15:44:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210311064441epcas1p2959db5cf163809fcece8e0026b620b74~rNr4MrxKt2237022370epcas1p2U;
        Thu, 11 Mar 2021 06:44:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210311064441epsmtrp1889f3c669a273651081f4f674d5ed2e2~rNr4LVIpx2132221322epsmtrp1H;
        Thu, 11 Mar 2021 06:44:41 +0000 (GMT)
X-AuditID: b6c32a38-e3dff7000000e70b-5a-6049bc59318a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.63.08745.95CB9406; Thu, 11 Mar 2021 15:44:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210311064440epsmtip1c429cb87b81f947f81f9faee99034d0a~rNr34MQir1126411264epsmtip1B;
        Thu, 11 Mar 2021 06:44:40 +0000 (GMT)
Subject: Re: [PATCH 08/11] PM / devfreq: check get_dev_status in
 devfreq_update_stats
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
Message-ID: <740a4f0e-ee41-1e14-7b06-ab0202fd1e9f@samsung.com>
Date:   Thu, 11 Mar 2021 16:01:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAA+hA=T8qezc_oL8KmoWQXg9+3MzykFxh0kW2044hBxcVpmb+g@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmnm7kHs8Eg54XphbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG9l1zWQoOCFasO9bI1sB4gbeL
        kZNDQsBEYnvjN/YuRi4OIYEdjBLvJ59jg3A+MUp8Pj8LKvOZUaLr2Vl2mJb1V3awgthCArsY
        JZ4dl4coes8osen2RbAiYYFwiZaOO0wgtoiAh8Sl6VPAxjILLGSW+LznEQtIgk1AS2L/ixts
        IDa/gKLE1R+PGUFsXgE7iTfNvWDNLAKqEg39f8HiogJhEie3tUDVCEqcnPkEbA6nQKDE+fv/
        wS5iFhCXuPVkPhOELS/RvHU2M8hiCYEzHBJH73eyQLzgIvGlewYThC0s8er4FqjXpCRe9rdB
        2dUSK08eYYNo7mCU2LL/AitEwlhi/9LJQM0cQBs0Jdbv0ocIK0rs/D2XEWIxn8S7rz2sICUS
        ArwSHW1CECXKEpcf3IVaKymxuL2TbQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGB
        CXJ0b2IEJ2Etix2Mc99+0DvEyMTBeIhRgoNZSYTX77hbghBvSmJlVWpRfnxRaU5q8SFGU2AA
        T2SWEk3OB+aBvJJ4Q1MjY2NjCxNDM1NDQyVx3iSDB/FCAumJJanZqakFqUUwfUwcnFINTLE7
        TMsMBR4Y9H7eddJKcyOv8nS1KVft53QsD5aep3Z4wtN9s1wZdOs3iUa1iWyb9pJL602skpy0
        542c1y5XX02bfeHJFMG14ltKez72ickJ3YqLDmw2m9vzwmJL4YmMjd98zT2Obr4bYvV5V8on
        QZ5Lds+f26ytOzmr9/G1XZI9CoHXXp7m3yjsv5KF161IOUV4/7v5DVkdjVcSX7gXOLfZNO18
        V5SapVIl+8bPxzV67cbLnPZr83mfXdsmtX2bYkKm1ysR0bb5qWa36r4ulFusUNBSf/LNzHQX
        n0fxG670LJPcP+3Zq6SZ10ofSJm1myjetis2umExUTcj7TD3RQNfhyWqOt0XBWy3rHy0Voml
        OCPRUIu5qDgRAPGzz7JLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnG7kHs8Eg9avLBbLLh1ltPgydRez
        xbOj2hZ/N09ns1g1dSeLxdmmN+wWmx5fY7Xo+rWS2eLyrjlsFp97jzBa3G5cwWbxYou4A4/H
        zll32T02repk89i8pN5j47sdTB79fw08+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2P7rrks
        BQcEK9Yda2RrYLzA28XIySEhYCKx/soO1i5GLg4hgR2MEg/OH2aCSEhKTLt4lLmLkQPIFpY4
        fLgYouYtUE3POWaQGmGBcImWjjtg9SICHhKXpk9hAyliFljILLFw7wpmiI6zTBJ7pjxmBali
        E9CS2P/iBhuIzS+gKHH1x2NGEJtXwE7iTXMv2CQWAVWJhv6/YHFRgTCJnUseM0HUCEqcnPmE
        BcTmFAiUOH//P9hMZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKA
        kWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwPGpp7WDcs+qD3iFGJg7GQ4wSHMxK
        Irx+x90ShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCK
        niMqLjHTNSKjo9zz9v2/dtYt307ysaxo0nA48/M5R+Sn3BXTvSc7xF3s6jtX9NQ0STE0/OPS
        /wdc2yLEA6fOUek7ZjBXeO29piqltyZPprzwjL24uqrz/ayJ+ie7X7+XSTIq05q48Ne0lBKV
        aZEfOO7IidyftFohbu+za85PP5YbhZh/etgzM+HAmdglHNK+FqpHM05K/zf698flygv9uirD
        rSfee7vFW1+9f1VP8rHEu9IZzO67ko8qbCq6wHX6xIKbaYvN2LJVJZc8WH1MKPTJhqAfcapP
        p3D/XrBO9hT7x9VBNjsuOipqlV36r3U2vSpB+tY6bjvNaxy/Ixek3km7/ik9V13qgkVtfYGP
        EktxRqKhFnNRcSIAxJvI/zYDAAA=
X-CMS-MailID: 20210311064441epcas1p2959db5cf163809fcece8e0026b620b74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210310030121epcas1p1eeee9aabd374b0346001b098810488fc
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
        <1615294733-22761-9-git-send-email-aisheng.dong@nxp.com>
        <0b6ceb75-040f-8e1c-73ea-9d60344b9918@gmail.com>
        <CGME20210310030121epcas1p1eeee9aabd374b0346001b098810488fc@epcas1p1.samsung.com>
        <CAA+hA=T8qezc_oL8KmoWQXg9+3MzykFxh0kW2044hBxcVpmb+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/10/21 12:00 PM, Dong Aisheng wrote:
> On Wed, Mar 10, 2021 at 12:20 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>
>> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>>> Check .get_dev_status() in devfreq_update_stats in case it's abused
>>> when a device does not provide it.
>>>
>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>> ---
>>>   drivers/devfreq/governor.h | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>>> index 31af6d072a10..67a6dbdd5d23 100644
>>> --- a/drivers/devfreq/governor.h
>>> +++ b/drivers/devfreq/governor.h
>>> @@ -89,6 +89,9 @@ int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
>>>
>>>   static inline int devfreq_update_stats(struct devfreq *df)
>>>   {
>>> +     if (!df->profile->get_dev_status)
>>> +             return -EINVAL;
>>> +
>>
>> I'm considering the following method instead of returning the error
>> when .get_dev_status is NULL.
>>
>>         if (!df->profile->get_dev_status) {
>>                 df->last_status.total_time = 0;
>>                 df->last_status.busy_time = 0;
>>                 df->last_status.current_frequency = 0;
>>                 return 0;
>>         }
> 
> I might  suggest not cause it's meaningless for ondemand governor but
> introducing confusing. Simply return error could make the life a bit easier.
> does it make sense to you?

Actually, I considered the some corner case as following:
We can see the simple_ondemand governor through available_governors
even if the devfreq driver doesn't implement the .get_dev_status.
In this corner case, My intention tried to prevent the error
on this case. But, actually, it is different issue. I'll fix
this issue when get_dev_status is NULL, don't show the
simple_ondemand governor name through available_governors
on other patch.

And I applied it. Thanks.

> 
> Regards
> Aisheng
> 
>>
>>>       return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>>>   }
>>>   #endif /* _GOVERNOR_H */
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
