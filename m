Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6FCEBF2D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 09:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfKAIZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 04:25:50 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:53242 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfKAIZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 04:25:50 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191101082544epoutp0126af0a023b76bd5025c91697021e3a90~S-GhQqaNQ2074120741epoutp01B
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 08:25:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191101082544epoutp0126af0a023b76bd5025c91697021e3a90~S-GhQqaNQ2074120741epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572596744;
        bh=roQQq6L24tjjeQ/Fbnrwlk6m+bJMna+39cbViVWB4sw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZW+p/xVnbz4fIR2sCl0fCkU8ecfvhfOLmXYovvJgzdnUIj8NZqpd9iGAYRWUGy4sW
         NtC2v/+I0folTxzFlVwvFRfsYCGGYLU+uyTl7lIPDMJ3/ui3Hb4+aOhz058LwFUYAD
         yUwFqcqprjlasqsYbH5zthy64ZVJp6/IID/9Yf0E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191101082544epcas1p19ba7d0fb00f9fd9fa867881dcd0eeeae~S-Ggqxoib2651126511epcas1p1K;
        Fri,  1 Nov 2019 08:25:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 474Fd15xwGzMqYkf; Fri,  1 Nov
        2019 08:25:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.14.04144.50CEBBD5; Fri,  1 Nov 2019 17:25:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191101082541epcas1p1392a9d2a87c6240ef470162c5cfef685~S-Gd-8aKK2419524195epcas1p1W;
        Fri,  1 Nov 2019 08:25:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191101082541epsmtrp1218f8ceaf45e254b2986efd523c67da9~S-Gd-CAkS0584805848epsmtrp1T;
        Fri,  1 Nov 2019 08:25:41 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-62-5dbbec05651e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.1D.25663.50CEBBD5; Fri,  1 Nov 2019 17:25:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191101082540epsmtip19f57c47a75a241fe2aa83b90760e4d88~S-Gda1g3i0180501805epsmtip1W;
        Fri,  1 Nov 2019 08:25:40 +0000 (GMT)
Subject: Re: [PATCH v9 4/8] PM / devfreq: Move more initialization before
 registration
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6f9334b3-01f9-a7c5-a87b-7e8a77c8d6e0@samsung.com>
Date:   Fri, 1 Nov 2019 17:31:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB70234DF1004231D1BB02A41DEE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsWy7bCmvi7rm92xBrO/GlgcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4AeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZzzddpm94KdmxbTt25kbGG8pdjFycEgImEh8PynfxcjFISSw
        g1Fi2cvbbBDOJ0aJnYfeMEE43xglrtw6wQ7T8XeDDkR8L6NE56RVzBDOe0aJKfufsIEUCQtE
        SHR9zQQxRYDMaa/dQUqYBf6zSNye9oGli5GTg01AS2L/ixtsIDa/gKLE1R+PGUFsXgE7iZkr
        TzOB2CwCKhLrpp1iBJkjCjTn9NdEiBJBiZMzn4CN4RSIlbjadAHMZhYQl7j1ZD4ThC0v0bx1
        NthpEgKX2CW2zHgAlpAQcJE4eLqRGcIWlnh1fAs7hC0l8bK/Dcqullh58ggbRHMHo8SW/RdY
        IRLGEvuXTmYCOYhZQFNi/S59iLCixM7fcxkhFvNJvPvawwoJK16JjjYhiBJlicsP7kKdICmx
        uL2TbQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBIXJUb2IEp3At0x2MU875HGIU
        4GBU4uGdcG53rBBrYllxZe4hRgkOZiUR3u3rgEK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5
        H5hf8kriDU2NjI2NLUwMzUwNDZXEeR2XL40VEkhPLEnNTk0tSC2C6WPi4JRqYJQqsfmzoPvR
        Os+/TlX7/k7pCVn1r6XXQcxNIGKHwge77C+zt2330LXlzfJ+0l7VlXTyWeB9m/96tzxra/eo
        7Dy44epN5waHw3cal+nqPc2/mN4oLb8uZ5ns8fSlmv8c2xr9Z8iEPVVbH7b59Bqen4n/t2lW
        T3ebM1+qL/isyf7E4ybz2Sqnv1JiKc5INNRiLipOBAAZEHmG9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSnC7rm92xBq9/CVkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgynm67zF7wU7Ni2vbtzA2MtxS7GDk4
        JARMJP5u0Oli5OQQEtjNKHFgpS+ILSEgKTHt4lFmiBJhicOHi7sYuYBK3jJKnFg2lwkkLiwQ
        IdH1NROkXATInDNtBgtIDbPAfxaJpjV9jBANr5gkdl05yAxSxSagJbH/xQ02EJtfQFHi6o/H
        jCA2r4CdxMyVp5lAbBYBFYl1006BxUWBpj7ffgOqRlDi5MwnLCA2p0CsxNWmC2A2s4C6xJ95
        l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM4nrW0djCeOBF/iFGAg1GJh3dG1+5YIdbEsuLK3EOMEhzMSiK829cB
        hXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTBW3j1kycG1
        Vn9+7/UtU2YWRuctuRGQLcC49c3hR983Cb3Rd97P4FmoItPpsI1/16b5HzuXndVof7Pm4eKl
        hsu6fh6vyNoUd1PGQIqn4ccBV87llinTGa6f97wt7suw87YzL9OjZteMi34hf3uNmIIDVF1u
        MWvuCFt/no9h93vRN9NZruZ92xGqxFKckWioxVxUnAgABq+K2OMCAAA=
X-CMS-MailID: 20191101082541epcas1p1392a9d2a87c6240ef470162c5cfef685
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191002192527epcas3p3ba24247bd1b8ce8ac33f7e4431c25241
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <CGME20191002192527epcas3p3ba24247bd1b8ce8ac33f7e4431c25241@epcas3p3.samsung.com>
        <25f46d76dc95d5509edd7bf9d1a2e0532faef4cc.1570044052.git.leonard.crestez@nxp.com>
        <0cadb00d-d34e-4028-93c4-b4902a50f5e2@samsung.com>
        <VI1PR04MB70234DF1004231D1BB02A41DEE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 31. 오후 10:31, Leonard Crestez wrote:
> On 31.10.2019 05:10, Chanwoo Choi wrote:
>> Hi Leonard,
>>
>> This patch didn't get the acked-by from devfreq maintainer.
>> I think that we need to discuss this patch with more time.
>> Also, it is possible to make it as the separate patch
>> from this series.
>>
>> IMHO, if you make the separate patch for this and
>> resend the separate patch on later, I think that
>> we can merge the remained patch related to PM_QOS.
> 
> The devfreq initialization cleanups are required for dev_pm_qos support, 
> otherwise lockdep warnings are triggered. I can post the cleanups as a 
> separate series but the PM QoS one would depend on the cleanups.
> 
> Do you prefer multiple smaller series?

After read the v10, I think v9 is better than v10
for this issue. 

> 
> I try to order my patches with uncontroversial fixes and cleanups first 
> so in theory the earlier parts could be applied separately. It's very 
> rare to see series partially applied though.
> 
> Earlier objection was that devm should be kept, I think this can be 
> accomplished by splitting device_register into device_initialize and 
> device_add.
> 
>> On 19. 10. 3. 오전 4:25, Leonard Crestez wrote:
>>> In general it is a better to initialize an object before making it
>>> accessible externally (through device_register).
>>>
>>> This makes it possible to avoid remove locking the partially initialized
>>> object and simplifies the code. However devm is not available before
>>> device_register (only after the device_initialize step) so the two
>>> allocations need to be managed manually.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>   drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------
>>>   1 file changed, 25 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 3e0e936185a3..0b40f40ee7aa 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -591,10 +591,12 @@ static void devfreq_dev_release(struct device *dev)
>>>   	mutex_unlock(&devfreq_list_lock);
>>>   
>>>   	if (devfreq->profile->exit)
>>>   		devfreq->profile->exit(devfreq->dev.parent);
>>>   
>>> +	kfree(devfreq->time_in_state);
>>> +	kfree(devfreq->trans_table);
>>>   	mutex_destroy(&devfreq->lock);
>>>   	kfree(devfreq);
>>>   }
>>>   
>>>   /**
>>> @@ -674,44 +676,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>   	devfreq->max_freq = devfreq->scaling_max_freq;
>>>   
>>>   	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>>   	atomic_set(&devfreq->suspend_count, 0);
>>>   
>>> -	dev_set_name(&devfreq->dev, "devfreq%d",
>>> -				atomic_inc_return(&devfreq_no));
>>> -	err = device_register(&devfreq->dev);
>>> -	if (err) {
>>> -		mutex_unlock(&devfreq->lock);
>>> -		put_device(&devfreq->dev);
>>> -		goto err_out;
>>> -	}
>>> -
>>> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
>>> +	devfreq->trans_table = kzalloc(
>>>   			array3_size(sizeof(unsigned int),
>>>   				    devfreq->profile->max_state,
>>>   				    devfreq->profile->max_state),
>>>   			GFP_KERNEL);
>>>   	if (!devfreq->trans_table) {
>>>   		mutex_unlock(&devfreq->lock);
>>>   		err = -ENOMEM;
>>> -		goto err_devfreq;
>>> +		goto err_dev;
>>>   	}
>>>   
>>> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>>> -			devfreq->profile->max_state,
>>> -			sizeof(unsigned long),
>>> -			GFP_KERNEL);
>>> +	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
>>> +					 sizeof(unsigned long),
>>> +					 GFP_KERNEL);
>>>   	if (!devfreq->time_in_state) {
>>>   		mutex_unlock(&devfreq->lock);
>>>   		err = -ENOMEM;
>>> -		goto err_devfreq;
>>> +		goto err_dev;
>>>   	}
>>>   
>>>   	devfreq->last_stat_updated = jiffies;
>>>   
>>>   	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>>   
>>> +	dev_set_name(&devfreq->dev, "devfreq%d",
>>> +				atomic_inc_return(&devfreq_no));
>>> +	err = device_register(&devfreq->dev);
>>> +	if (err) {
>>> +		mutex_unlock(&devfreq->lock);
>>> +		put_device(&devfreq->dev);
>>> +		goto err_out;

err_out -> err_dev
When failed to register, have to free resource.

>>> +	}
>>> +
>>>   	mutex_unlock(&devfreq->lock);
>>>   
>>>   	mutex_lock(&devfreq_list_lock);
>>>   
>>>   	governor = try_then_request_governor(devfreq->governor_name);
>>> @@ -737,14 +738,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>   
>>>   	return devfreq;
>>>   
>>>   err_init:
>>>   	mutex_unlock(&devfreq_list_lock);
>>> -err_devfreq:
>>>   	devfreq_remove_device(devfreq);
>>> -	devfreq = NULL;
>>> +	return ERR_PTR(err);


It is not proper to return on the middle 
of the exception handling. Need to consider more clean method.

>>> +
>>>   err_dev:
>>> +	/*
>>> +	 * Cleanup path for errors that happen before registration.
>>> +	 * Otherwise we rely on devfreq_dev_release.
>>> +	 */
>>> +	kfree(devfreq->time_in_state);
>>> +	kfree(devfreq->trans_table);
>>>   	kfree(devfreq);
>>>   err_out:
>>>   	return ERR_PTR(err);
>>>   }
>>>   EXPORT_SYMBOL(devfreq_add_device);


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
