Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DCBBD606
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 03:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfIYBRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 21:17:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41059 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389624AbfIYBRI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 21:17:08 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190925011705epoutp04165fa97ff7d6cf27cc824bf4ef2fa9df~HiYsZI6Vs0169601696epoutp04t
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 01:17:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190925011705epoutp04165fa97ff7d6cf27cc824bf4ef2fa9df~HiYsZI6Vs0169601696epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569374225;
        bh=xkaCLWrLKj+AkjeEu7zrWGqv27T5WLC7y3MFPMEtPSU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=A7KLROs5UlLDgSRIIw1ecamfhd2txsc0t/6p7SWw1dkfRSHWFCBia+ZktR/fL4tVu
         52fImgPwH5UehVzfoA+hWoaf2P93CJE/qmOQlbCH5ntbxDmkCJUqzyGRvDlRjJWP0p
         4/5QxQY9WeOHPeXd9KYa4b408n/Jrl/JQ/QPe2TI=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925011705epcas1p195a41cd92587eacfbdf138ced7b8af7a~HiYr4gzbZ3260032600epcas1p1z;
        Wed, 25 Sep 2019 01:17:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46dKsV01nwzMqYkb; Wed, 25 Sep
        2019 01:17:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.F2.04224.D00CA8D5; Wed, 25 Sep 2019 10:17:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190925011701epcas1p449a16c4eec6162795025fe27bb543243~HiYohVL4K1436714367epcas1p4w;
        Wed, 25 Sep 2019 01:17:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925011701epsmtrp13de392985aa725327020543f74c4b9de~HiYogaU9i1264112641epsmtrp1W;
        Wed, 25 Sep 2019 01:17:01 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-5f-5d8ac00dc6d2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.22.04081.D00CA8D5; Wed, 25 Sep 2019 10:17:01 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190925011701epsmtip13f1014b02bfcd3beb2026c45b594451e~HiYoTxEyx2014920149epsmtip1W;
        Wed, 25 Sep 2019 01:17:01 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Lock devfreq in trans_stat_show
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <98042a95-40cc-7f05-ede7-d042640b135b@samsung.com>
Date:   Wed, 25 Sep 2019 10:21:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023BF1AD2C61C8A5ABAD5FEEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmgS7vga5Ygxk3rC0OHdvKbjF97yY2
        i/PnN7BbnG16w25xq0HGYsXdj6wWmx5fY7Xo+rWS2eJz7xFGi88bHjNa3G5cwebA7TG74SKL
        x6ZVnWwed67tYfPYvKTeY+O7HUweB9/tYfLo27KK0ePzJrkAjqhsm4zUxJTUIoXUvOT8lMy8
        dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygO5UUyhJzSoFCAYnFxUr6djZF+aUl
        qQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2Rl7u7awFKyRq9g5+zRLA+NU
        iS5GDg4JAROJ93vEuxg5OYQEdjBKvP5i2MXIBWR/YpR4tegTK4TzjVFi9c+dLDANK+4VQ8T3
        Mkqcb9zNDOG8Z5R4/qObEWSUsICTxKs3b9hAbBGBUIkvTy+BFTELnGCW6N7zFqyITUBLYv+L
        G2BF/AKKEld/PAaL8wrYSfzdMQssziKgKvHgQg9YXFQgQuLTg8OsEDWCEidnPmEBsTkFYiWe
        Pe0Hq2cWEJe49WQ+E4QtL9G8dTbYYgmBRewSR752gCUkBFwkFt18xwJhC0u8Or6FHcKWknjZ
        3wZlV0usPHmEDaK5g1Fiy/4LrBAJY4n9SyczgcKCWUBTYv0ufYiwosTO33MZIRbzSbz72sMK
        CS5eiY42IYgSZYnLD+5CnSApsbi9k20Co9IsJO/MQvLCLCQvzEJYtoCRZRWjWGpBcW56arFh
        gQlyZG9iBCdhLYsdjHvO+RxiFOBgVOLhdWDtihViTSwrrsw9xCjBwawkwjtLBijEm5JYWZVa
        lB9fVJqTWnyI0RQY2hOZpUST84EZIq8k3tDUyNjY2MLE0MzU0FBJnNcjvSFWSCA9sSQ1OzW1
        ILUIpo+Jg1OqgbFuw3vuuiaLaE1HocU2c1YWFuW3emrsOHSlxyFpM+PBvBaeFpb+okjvIxqf
        T5jfCq9aFhZzQW7Bkklqc2fMu8PQw3S8du4N/cdiOe3tcUunhbAKf3B67dP5oHHHmgvmH6vv
        Cq04ZraOV1Ff98isu5u81x83Kt8Wdf6AgtO07ROdLi9iPHr8XqcSS3FGoqEWc1FxIgBvseZg
        2AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSnC7vga5YgzlfJS0OHdvKbjF97yY2
        i/PnN7BbnG16w25xq0HGYsXdj6wWmx5fY7Xo+rWS2eJz7xFGi88bHjNa3G5cwebA7TG74SKL
        x6ZVnWwed67tYfPYvKTeY+O7HUweB9/tYfLo27KK0ePzJrkAjigum5TUnMyy1CJ9uwSujL1d
        W1gK1shV7Jx9mqWBcapEFyMHh4SAicSKe8VdjFwcQgK7GSVWTd3M2sXICRSXlJh28SgzRI2w
        xOHDUDVvGSXOfm5mB6kRFnCSePXmDRuILSIQKvGnczkrSBGzwAlmiVMTOxkhOnYySTy/v4gJ
        pIpNQEti/4sbYB38AooSV388ZgSxeQXsJP7umAUWZxFQlXhwoQcsLioQIXF4xyyoGkGJkzOf
        sIDYnAKxEs+e9oPVMwuoS/yZd4kZwhaXuPVkPhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYF
        jCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI1JLcwfj5SXxhxgFOBiVeHgdWLti
        hVgTy4orcw8xSnAwK4nwzpIBCvGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1
        tSC1CCbLxMEp1cDY2B65N6H9ZgXj7GzLh0tDZ5UvtezxiZ9UqTZLQkZ+J6PXDuPU66ds2+fd
        L/j9Kmm/yMFzpYEH29s6GLc+UbHmD2Zs3GK+7EnHdo42tZb7DwIOikn937RBPuXpvL7WBYWZ
        L4MMWkx7l7AzHDtydKGP2Kn+bysjRGoKXaL+TbPOr/0k2dInsUaJpTgj0VCLuag4EQCkm8OL
        xAIAAA==
X-CMS-MailID: 20190925011701epcas1p449a16c4eec6162795025fe27bb543243
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923162736epcas3p2c1db3bf767a07f17b609bc91fbbd9648
References: <CGME20190923162736epcas3p2c1db3bf767a07f17b609bc91fbbd9648@epcas3p2.samsung.com>
        <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
        <979d107f-0a52-3aa4-a397-acb0ff754a3c@samsung.com>
        <VI1PR04MB7023BF1AD2C61C8A5ABAD5FEEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 24. 오후 4:44, Leonard Crestez wrote:
> On 2019-09-24 5:07 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> On 19. 9. 24. 오전 1:27, Leonard Crestez wrote:
>>> There is no locking in this sysfs show function so stats printing can
>>> race with a devfreq_update_status called as part of freq switching or
>>> with initialization.
>>>
>>> Also add an assert in devfreq_update_status to make it clear that lock
>>> must be held by caller.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>   drivers/devfreq/devfreq.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> Changes since v1:
>>> * Split from series: low-priority bugfix not strictly required for PM QoS
>>> * Only keep lock during update, release before sprintf
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 4c58fbf7d4e4..00fc23fea5b2 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -206,10 +206,11 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>   {
>>>   	int lev, prev_lev, ret = 0;
>>>   	unsigned long cur_time;
>>>   
>>>   	cur_time = jiffies;
>>> +	lockdep_assert_held(&devfreq->lock);
>>
>> It better to move lock checking before 'cur_time = jiffies'
>> in order to reduce the redundant code execution.
> 
> OK but I don't see how this makes a difference for an assert? It just 
> prints a warning and carries on.

According to the sequence between 'lockdep_assert_held' and 'cur_time = jiffies',
cur_time will be initialized with different jiffies because 'jiffies' is continuously
changed. In order to get the more correct time from 'jiffies',
we better to get 'jiffies' after releasing the lock.

> 
>>>   	/* Immediately exit if previous_freq is not initialized yet. */
>>>   	if (!devfreq->previous_freq)
>>>   		goto out;
>>>   
>>> @@ -1507,16 +1508,22 @@ static ssize_t trans_stat_show(struct device *dev,
>>>   	struct devfreq *devfreq = to_devfreq(dev);
>>>   	ssize_t len;
>>>   	int i, j;
>>>   	unsigned int max_state = devfreq->profile->max_state;
>>>   
>>> -	if (!devfreq->stop_polling &&
>>> -			devfreq_update_status(devfreq, devfreq->previous_freq))
>>> -		return 0;
>>>   	if (max_state == 0)
>>>   		return sprintf(buf, "Not Supported.\n");
>>>   
>>> +	/* lock and update */
>>
>> It is not necessary. Anyone can know that this code is related to mutex lock/unlock.
> 
> OK. You're the second person to mention this but it's quite strange to 
> see objections raised against comments.

The comment is very important to understand the code
for everyone. But, in this case, almost people understand
the usage of mutex_lock/mutex_unlock. It is no difficult
to understand the meaning of below codes.

Usually, we would add the comments if some codes are very difficult
without comments or some codes have depend on some call sequence and so on.

> 
>>> +	mutex_lock(&devfreq->lock);
>>> +	if (!devfreq->stop_polling &&
>>> +			devfreq_update_status(devfreq, devfreq->previous_freq)) {
>>> +		mutex_unlock(&devfreq->lock);
>>> +		return 0;
>>> +	}
>>> +	mutex_unlock(&devfreq->lock);
>>> +
>>>   	len = sprintf(buf, "     From  :   To\n");
>>>   	len += sprintf(buf + len, "           :");
>>>   	for (i = 0; i < max_state; i++)
>>>   		len += sprintf(buf + len, "%10lu",
>>>   				devfreq->profile->freq_table[i]);
>>>
>>
>> Basically, it is necessary. Please edit it by my comments.
>> Also, you have to add the following 'fixes' as following:
>> and send it stable mailing list.
>>
>> Fixes: 39688ce6facd ("PM / devfreq: account suspend/resume for stats")
>>
>> If you edit it by my comments, feel free to add my tag:
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
