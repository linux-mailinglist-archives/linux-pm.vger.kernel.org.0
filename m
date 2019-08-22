Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788EE99049
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfHVKDc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 06:03:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46927 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfHVKDc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 06:03:32 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190822100329epoutp027630027a21d6ad56842d17b139d98b20~9NomS33ES2524625246epoutp02k
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 10:03:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190822100329epoutp027630027a21d6ad56842d17b139d98b20~9NomS33ES2524625246epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566468209;
        bh=YO7b8S9II7RkNd+4ciy8wx0Pe5Mjkjhke0PrQyjYo/A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SGnygrtAlW635Yb1qKLDbJmji0MbeU5gtuulJFaR8c1pOOolNhfcoP6V1Z9ZxG0NR
         iGaUsnqui1VLKpa65DpGrfDv7VXTWslEJvaDv0pm3dPuC2NZLOFgApf5WfCg2NfM9f
         mCZ5qYqEdbqILmq9oA3EkUxTZft6KyEUFoZLoWXM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190822100329epcas1p2890013896a49b40c40fe409d4b5e1811~9NolsQBOA3216232162epcas1p2K;
        Thu, 22 Aug 2019 10:03:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46Dg8Z36w5zMqYlq; Thu, 22 Aug
        2019 10:03:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.F5.04088.E686E5D5; Thu, 22 Aug 2019 19:03:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190822100325epcas1p23d11864c4b6445d04731aedf62b8a550~9NoiZds3Q0648106481epcas1p2I;
        Thu, 22 Aug 2019 10:03:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190822100325epsmtrp1ccbac386ed77f954cc46dbf0aff5633f~9NoiYYk6l2930629306epsmtrp1_;
        Thu, 22 Aug 2019 10:03:25 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-27-5d5e686e40b8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.20.03638.D686E5D5; Thu, 22 Aug 2019 19:03:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190822100325epsmtip21b7869beb74d8a54fa5ed08ae54090fe~9NoiMY5xf0864908649epsmtip2-;
        Thu, 22 Aug 2019 10:03:25 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
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
Message-ID: <921d9eb8-aa38-6e67-ac2e-55e01bf630f5@samsung.com>
Date:   Thu, 22 Aug 2019 19:07:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023A7AC7DDE349BF6D2D2C9EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmgW5eRlysweJ94haHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWK+5+ZLXY9Pgaq8Xn3iOMFrcbV7BZrD53kM2i69BfNouN
        Xz0ceD3e32hl91iwqdRj06pONo871/aweWxeUu+x8d0OJo+D7/YwefRtWcXo8XmTXABnVLZN
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDRSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjOcb
        O9kLdstX7P7xmKmBcadkFyMnh4SAicSrHeeYuhi5OIQEdjBKnPzaywLhfGKUuPNyMxuE841R
        YtPtl6wwLb+ff2EGsYUE9jJKrJwfAWG/Z5Q48Fi5i5GDQ1ggUGL2rjSQXhGBZkaJrSfegq1g
        FnjLLHHm7D12kAY2AS2J/S9usIHY/AKKEld/PGYEsXkF7CSOXXsNZrMIqEosn3cCbJmoQITE
        pweHWSFqBCVOznzCArKMUyBW4sPiEJAws4C4xK0n85kgbHmJ5q2zmUH2SghsY5c40TQT6gEX
        ifsflrFD2MISr45vgbKlJF72t0HZ1RIrTx5hg2juYJTYsv8CVLOxxP6lk5lAFjMLaEqs36UP
        EVaU2Pl7LiOEzSvRsPE3O8QRfBLvvvawgpSDxDvahCBKlCUuP7jLNIFReRaSb2YheWEWkhdm
        ISxbwMiyilEstaA4Nz212LDAEDmyNzGC07OW6Q7GKed8DjEKcDAq8fBO0I2NFWJNLCuuzD3E
        KMHBrCTCWzEnKlaINyWxsiq1KD++qDQntfgQoykwsCcyS4km5wNzR15JvKGpkbGxsYWJoZmp
        oaGSOO/CHxaxQgLpiSWp2ampBalFMH1MHJxSDYwzP3J1nfgzN/DBNtPVslmuVq8aAwyYucT5
        p5790hp72+l5reKkpDORZjNjmRrcdBatcOOeMWXGFZ/FTbG5pjysx3NLAjY3i5TVbl9eN/dW
        01OjTVu2Sn6//Ma9tpJLbnFU8cf8NeuOLA776Ck76Vvv0pYWO/ODvJ4upZfSrNyfNMu0MQU8
        3qjEUpyRaKjFXFScCAAX3fuq5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSvG5uRlyswYaNahaHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWK+5+ZLXY9Pgaq8Xn3iOMFrcbV7BZrD53kM2i69BfNouN
        Xz0ceD3e32hl91iwqdRj06pONo871/aweWxeUu+x8d0OJo+D7/YwefRtWcXo8XmTXABnFJdN
        SmpOZllqkb5dAlfG842d7AW75St2/3jM1MC4U7KLkZNDQsBE4vfzL8xdjFwcQgK7GSWu7N7K
        BpGQlJh28ShQggPIFpY4fLgYouYto8TKDW2MIHFhgUCJ2bvSQOIiAq2MEndO/2ADcZgF3jNL
        bDp0iAWi4xWTROuPV8wgU9kEtCT2v7gBtoFfQFHi6o/HjCA2r4CdxLFrr8FsFgFVieXzToDV
        iwpESBzeMQuqRlDi5MwnLCCbOQViJT4sDgEJMwuoS/yZd4kZwhaXuPVkPhOELS/RvHU28wRG
        4VlIumchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCY1VLawfj
        iRPxhxgFOBiVeHgn6MbGCrEmlhVX5h5ilOBgVhLhrZgTFSvEm5JYWZValB9fVJqTWnyIUZqD
        RUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBcblP5x/Fqw3Oq42XRa1RMWQNnN2904qj7e6a
        sIKlHK0cTS9+nNU4eL74/YqJ8i0MneXH2MLv13LLybmEcDquEniT8XEzx4mgyu4vGRvr9V3m
        huzTdenaMefv3WsHVbQ7y2TU19lsW82gGyv6Yq/wKuaXTzdNaeXSvp5YenzN+rnX3/rsNa09
        rsRSnJFoqMVcVJwIAFzf5cPRAgAA
X-CMS-MailID: 20190822100325epcas1p23d11864c4b6445d04731aedf62b8a550
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 21. 오후 10:03, Leonard Crestez wrote:
> On 21.08.2019 05:02, Chanwoo Choi wrote:
>> On 19. 8. 21. 오전 12:24, Leonard Crestez wrote:
>>> Now that devfreq supports dev_pm_qos requests we can use them to handle
>>> the min/max_freq values set by userspace in sysfs, similar to cpufreq.
>>>
>>> Since dev_pm_qos handles frequencies as kHz this change reduces the
>>> precision of min_freq and max_freq. This shouldn't introduce problems
>>> because frequencies which are not an integer number of kHz are likely
>>> not an integer number of Hz either.
>>>
>>> Try to ensure compatibilitity by rounding min values down and rounding
>>> max values up.
>>>
>>> Simplify the {min,max}_freq_store code by setting "null" values of 0 and
>>> MAX_S32 respectively instead of clamping to what freq tables are
>>> actually supported. Values are already automatically clamped on
>>> readback.
>>>
>>> Also simplify by droping the limitation that userspace min_freq must be
>>> lower than userspace max_freq, it is already documented that max_freq
>>> takes precedence.
>>>
>>> @@ -1358,33 +1371,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>   
>>>   	ret = sscanf(buf, "%lu", &value);
>>>   	if (ret != 1)
>>>   		return -EINVAL;
>>>   
>>> -	mutex_lock(&df->lock);
>>> -
>>> -	if (value) {
>>> -		if (value > df->max_freq) {
>>> -			ret = -EINVAL;
>>> -			goto unlock;
>>> -		}
>>
>> Actually, the user can input the value they want.
>> So, the above code is not necessary because the devfreq->scaling_max_freq
>> is never overflow from supported maximum frequency. The devfreq->scaling_max_freq
>> is based on OPP entries from DT.
>>
>> But, if we replace the existing request way of devfreq-cooling.c
>> with dev_pm_qos, devfreq->scaling_max_freq doesn't guarantee
>> the supported maximum frequency. >
>> We need to keep the supported min_freq/max_freq value without dev_pm_qos
>> requirement because the dev_pm_qos requirement might have the overflow value.
>> the dev_pm_qos doesn't know the supported minimum and maximum frequency
>> of devfreq device.
> 
> I'm not sure I understand what you mean. My patch allows user to set 
> entirely arbitrary min/max rates and this is good because we already 
> have a well-defined way to handle this: max overrides min.
> 
> The scaling_min_freq and scaling_max_freq variables can just be kept 
> around indefinitely no matter what happens to thermal. They're just a 
> cache for dev_pm_opp_find_freq_ceil and dev_pm_opp_find_freq_floor.

This patch doesn't check the range of input value
with the supported frequencies of devfreq device.

For example,
The devfreq0 device has the following available frequencies
100000000 200000000 300000000

and then user enters the 500000000 as following:
echo 500000000 > /sys/class/devfreq/devfreq0/min_freq

In result, get_effective_min_freq() will return the 500000000.
It is wrong value. it show the unsupported frequency through
min_freq sysfs path.

- devfreq->scaling_min_freq is 100000000,                                   
- 1000 * (unsigned long)dev_pm_qos_read_value(devfreq->dev.parent,
  DEV_PM_QOS_MIN_FREQUENCY)); is 500000000


> 
> BTW: I noticed that scaling_min_freq and scaling_max_freq are updated in 
> devfreq_notifier_call but devfreq->nb is not registered by default, only 
> when a driver requests it explicitly. Is there a reason for this?

Initial version of devfreq has not forced to use the OPP interface 
as the mandatory. So, it just provides the external function
devfreq_register_opp_notifier.

But,
We can call 'devfreq_register_opp_notifier' during devfreq_add_device()
because the OPP interface is mandatory for devfreq.

> Because I'd call dev_pm_opp_register_notifier inside devfreq_add_device 
> and remove all the devfreq_register/unregister_notifier APIs.

OK.

> 
> --
> Regards,
> Leonard
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
