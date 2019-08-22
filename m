Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8A99074
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 12:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbfHVKLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 06:11:13 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55982 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHVKLN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 06:11:13 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190822101110epoutp01eb38d7bae455a80c2ddb3208e064cad5~9NvTYBNeK0052100521epoutp01u
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 10:11:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190822101110epoutp01eb38d7bae455a80c2ddb3208e064cad5~9NvTYBNeK0052100521epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566468670;
        bh=7Ntwkl1U2OuS6n5AJKvGWth4LuW/2agHt3V1L/sQU+g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gR9wYDPgNJrwNge1k8dJeAj1uQzDgL9LhoIjv7JSJd9mEQNMW9v/7ki27b1oHynUa
         Q/Bg8IabbuHxZ0lKlLblZHdyJ0+smEUuRrFRwgoX4rW4ZCgXbu62eWZO/3XB3VEUhq
         vSt5eaGVRtnAdcvbODWLu2c8PKV1AunaCix/Znes=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190822101109epcas1p1ac77ac1aaea2dc11e99f105e475ed472~9NvScSQ6Y1668716687epcas1p1j;
        Thu, 22 Aug 2019 10:11:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46DgKR2CYnzMqYkW; Thu, 22 Aug
        2019 10:11:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.23.04085.B3A6E5D5; Thu, 22 Aug 2019 19:11:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190822101106epcas1p4529de5a578a67294056eecb6db4b031f~9NvPakcfG0753007530epcas1p4T;
        Thu, 22 Aug 2019 10:11:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190822101106epsmtrp25655c16d854d66d02cd64e3f7df91714~9NvPZqICO0051100511epsmtrp2z;
        Thu, 22 Aug 2019 10:11:06 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-94-5d5e6a3b2b1c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.AF.03706.A3A6E5D5; Thu, 22 Aug 2019 19:11:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190822101106epsmtip140efba1d8d4fb618e807ced4a86c0141~9NvPGflPc2300023000epsmtip1w;
        Thu, 22 Aug 2019 10:11:06 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cca5be9f-5552-2aa1-e428-540545b9bdd3@samsung.com>
Date:   Thu, 22 Aug 2019 19:14:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023E05C5683C4392CEA5915EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0wTWRT29jEzGKqXKnKtWcUxJEJs6QjFWxeQxNcYjcFojCFWnNAJIH2l
        06KoiawPVokYjFGEXQUTjIgmSqGKAlaKIrhal4gERYwRfuhmaVWswaCbbTsa+fed73znfOfc
        ByVV9hMqqtDi4O0WzkQT02U3uhLV6l937TBoP5+Pwd5uN4mDfz0E+J03EVd1uAj85Ml1Ej8+
        +C+JG4Y/yLFrZECOxyvuATz0WwOBr/g6CVzu/UbgpiCbpWADg0dIts7lZF2Nxwj25UA7wTbX
        H2Cb/K0SttPfLmFPtDQCdtw1Pzsqpyi9gOeMvD2et+RZjYWW/Ax6/ebclbm6NC2jZvR4GR1v
        4cx8Br1qQ7Z6TaEpNDQdX8yZnCEqmxMEOjkz3W51Ovj4AqvgyKB5m9Fk09s0AmcWnJZ8TZ7V
        vJzRapfqQsKdRQVt/gTbQbjn+afYUjAaXQ6iKART0dv+UVk5mE4pYStAbWMVcjH4GAqCfRIx
        +AxQoK9f9qOkynWfEBMdAJ3xXCbFIABQ83BAElbNglnI33YzopoNDwHk7hmL9JLCMSl69PgV
        GVYRMAl53g4SYTwTLkTPJkZAGCtgJmpo7JaHsQwmoO72vggfC7ehj6+75KImBvVWj0ZmioIG
        dKzMH9FIYRx6MVorEfECdMj9hzRsjKCLRI+e9nxfYhUKvqkFIp6F/nnQQopYhcb9HYSI96HL
        vfcIsfgoQC2ev+ViIgV5Lp4KOVAhh0R07XaySC9EtybPfe+pQKVNk6Q4xAzkDx6Xh+Vh/miZ
        UpQsQk9fD0sqwaKaKevUTFmhZsoKNT/N6oCsEczhbYI5nxcYm27qdbtA5EUn6VtBt2+DF0AK
        0NGKSrXBoJRzxUKJ2QsQJaVnK/b8mWNQKoxcyV7ebs21O0284AW60GmflKpi86yh/2Fx5DK6
        pSkpKTiVSdMxDB2nuDCBDUqYzzn4Ip638fYfdRIqSlUKlkcPXqDdHs3vdzbigC9zd2XWV0rv
        flg9UMFQYxlfhs6+SNjUs/3M3Pp1suSrmt5raQ2nf/mWrserR6renzr9aV61ytdrvLRNs2Ia
        WHJ3xdZm3/ZJmBpbZtIOxm2p+6/za5FxbX1MV8597YHDJT7dxIPdtYsDxftLio/HKWRDO++q
        aZlQwDFJUrvA/Q9RrMY35wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnK5VVlyswfr1PBaHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWK+5+ZLXY9Pgaq8Xn3iOMFrcbV7BZrD53kM2i69BfNouN
        Xz0ceD3e32hl91iwqdRj06pONo871/aweWxeUu+x8d0OJo+D7/YwefRtWcXo8XmTXABnFJdN
        SmpOZllqkb5dAlfG7neqBU0CFTe/iDYwPuHpYuTkkBAwkZi+6ShbFyMXh5DAbkaJp/1zWCAS
        khLTLh5l7mLkALKFJQ4fLoaoecso0fd0DRtIjbCAg8S73dvBmkUEWhkl7pz+AeYwC7xnlth0
        6BALRMsrJonrPyaDtbAJaEnsf3EDzOYXUJS4+uMxI4jNK2AnsWLVMVYQm0VAVeLYnotgcVGB
        CInDO2ZB1QhKnJz5BOw8ToFYic62d2BxZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoPAtJ
        +ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwrGpp7mC8vCT+
        EKMAB6MSD+8E3dhYIdbEsuLK3EOMEhzMSiK8FXOiYoV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Ps07FikkkJ5YkpqdmlqQWgSTZeLglGpgVM5Wylhzic1Q7Yv7QUN3wSnirofu3LjfOsvqUfQf
        7aLS+2t+RURt2H2/5LTwy9OvDld94H/B+qR357ynv6/ufaNt1hm39Xntqp280z+rCAsvvqLl
        M7uwKuBliN70DTrajOLB13MTkvwX5kVxHI39/z41ruLChTk5L5PXvuT1kcnxeMQWdllJXIml
        OCPRUIu5qDgRAMbTWyfRAgAA
X-CMS-MailID: 20190822101106epcas1p4529de5a578a67294056eecb6db4b031f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190820152410epcas4p214cadab5d2acfb2c659a777f2caa002b
References: <cover.1566314535.git.leonard.crestez@nxp.com>
        <CGME20190820152410epcas4p214cadab5d2acfb2c659a777f2caa002b@epcas4p2.samsung.com>
        <3b93af7e61a573ea2a123c353255645b5ad2a805.1566314535.git.leonard.crestez@nxp.com>
        <6134bb9e-9a16-b432-c191-c91f93844319@samsung.com>
        <VI1PR04MB7023E05C5683C4392CEA5915EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 21. 오후 10:00, Leonard Crestez wrote:
> On 21.08.2019 04:40, Chanwoo Choi wrote:
> 
>> On 19. 8. 21. 오전 12:24, Leonard Crestez wrote:
>>> Add dev_pm_qos notifies to devfreq core in order to support frequency
>>> limits via the dev_pm_qos_add_request.
>>>
>>> +static unsigned long get_effective_min_freq(struct devfreq *devfreq)
>>
>> I'm not sure that 'effective' expression is correct.
>>  From this function, the devfreq can get the final target frequency.
>>
>> I think that we need to use the more correct expression
>> to give the meaning of function as following:
>>
>> get_min_freq
>> get_max_freq
> 
> OK, will rename to get_min_freq and get_max_freq
> 
>>> @@ -636,21 +688,40 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>   		err = -ENOMEM;
>>>   		goto err_out;
>>>   	}
>>>   
>>>   	mutex_init(&devfreq->lock);
>>> -	mutex_lock(&devfreq->lock);
>>
>> Basically, I think that it is safe to lock when touch
>> the variable of the devfreq.
>>
>> it is not proper way for the dev_pm_qos because
>> it breaks the existing locking reason of devfreq's variables.
> 
> I don't understand what you mean. I'm initializing some stuff outside 
> the lock to avoid circular lock warning between:
> 
> (&devfreq->lock){+.+.}, at: devfreq_qos_min_notifier_call+0x24/0x48
> (&(n)->rwsem){++++}, at: blocking_notifier_call_chain+0x3c/0x78
> 
> In general you don't need to lock an object while initializing except 
> after it becomes accessible from the outside so devfreq_add_device 
> doesn't need to take the lock so early.
> 
> The QOS notifiers are registered on the parent device so in theory it's 
> possible for somebody to add QOS requests while devfreq_add_device is 
> executing. Maybe notifier registration should be moved at the end after 
> unlock?

I think that it is more clear to add notifier
after mutex_unlock(&devfreq->lock) if there are no any issue.

> 
> --
> Regards,
> Leonard
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
