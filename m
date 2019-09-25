Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B05BBD654
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 04:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbfIYCN1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 22:13:27 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:58726 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390331AbfIYCN1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 22:13:27 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190925021322epoutp025dfce387a406f8f715e6f7a08f7570a2~HjJ1eBuDV3128931289epoutp028
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 02:13:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190925021322epoutp025dfce387a406f8f715e6f7a08f7570a2~HjJ1eBuDV3128931289epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569377602;
        bh=ZsAfpqk5E1HRlS/OA77q+He4oFUDuv8j0tzTi9pvCcM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MLlcc5VO2C7pvQ0y7oJzcXHUdAqZmob1QvozOcpxrVTohjDd+O+pCeF03uU9lGe6w
         HLZJJoWrhQnSVd/lIWSl8OkvXVhFVSwY5PwJ9bEArfKnDjH+mYbZgPyCxKKI9cxor0
         +71adOkWTtC6UixNF7TU7P/Hoq0mHkR3nhO/NfmY=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925021322epcas1p15a2c9ac35b2d4f89ca090f12bcb2f6a8~HjJ1BW2zW0208802088epcas1p1E;
        Wed, 25 Sep 2019 02:13:22 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46dM6R2Fd1zMqYkk; Wed, 25 Sep
        2019 02:13:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.04.04224.E3DCA8D5; Wed, 25 Sep 2019 11:13:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925021318epcas1p2f5145aa74ebfc55d2ea3bea604c94818~HjJxqaI7e0776107761epcas1p2H;
        Wed, 25 Sep 2019 02:13:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925021318epsmtrp1212215fbadb50eaaa7308fe1b3093040~HjJxm1rj-1832418324epsmtrp1a;
        Wed, 25 Sep 2019 02:13:18 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-aa-5d8acd3ea12c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.98.03889.E3DCA8D5; Wed, 25 Sep 2019 11:13:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190925021318epsmtip1dc6807582dc707642fad7a8d26f6297e~HjJxSfWeb2273922739epsmtip1P;
        Wed, 25 Sep 2019 02:13:18 +0000 (GMT)
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
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
Message-ID: <080027a2-d807-5fa4-f148-4469678ce849@samsung.com>
Date:   Wed, 25 Sep 2019 11:17:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023034123415F86CC045CCDEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmrq792a5Yg4VTBS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyM1acfcdY8Eas4uu6cywNjOuFuhg5OSQETCQmz+xk7mLk4hAS
        2MEoMX3TYUYI5xOjxIa7x9ggnG+MEnPPd7PCtHQ+WwZVtZdR4mL/DxYI5z2jxO05+8GqhAVs
        JP5f/cgGYosIhEp8eXqJGcRmFmhilfh0pAzEZhPQktj/4gZYDb+AosTVH48ZQWxeATuJ1qX/
        wOIsAqoS7aevg9miAhESnx4cZoWoEZQ4OfMJC4jNKRArMW/mBnaI+eISt57MZ4Kw5SWat84G
        e05C4BK7xJImiEESAi4S/081MEPYwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2juYJTYsv8C1P/G
        EvuXTgbawAG0QVNi/S59iLCixM7fcxkhFvNJvPvawwpSIiHAK9HRBg1sZYnLD+4yQdiSEovb
        O9kmMCrNQvLOLCQvzELywiyEZQsYWVYxiqUWFOempxYbFpggR/cmRnAq17LYwbjnnM8hRgEO
        RiUeXgfWrlgh1sSy4srcQ4wSHMxKIryzZIBCvCmJlVWpRfnxRaU5qcWHGE2BoT2RWUo0OR+Y
        Z/JK4g1NjYyNjS1MDM1MDQ2VxHk90htihQTSE0tSs1NTC1KLYPqYODilGhi1z771KOqZnPzU
        y9Oz7dGkJa4LJUQKvEpNPhUH2514evOjRd1ZC7cHhnGzfDxPCZ+duyTi+ryw/7YHk8s7q/2D
        j/CbVp3ITTvn0al2v3jXEqdPonvVYpRV7Xe88fBlDdG6wOxwx2ymzJROwYy3LowT7hrFR77N
        YnJPT/FZGHirXOf4oX6rh0osxRmJhlrMRcWJAADWf8n7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSnK7d2a5Yg97JshaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuKC6blNSczLLUIn27BK6MFWffMRa8Eav4uu4cSwPjeqEuRk4O
        CQETic5nyxhBbCGB3YwSczs5IOKSEtMuHmXuYuQAsoUlDh8u7mLkAip5yygx+XIrK0iNsICN
        xP+rH9lAbBGBUIk/nctZQYqYBZpYJbq+X2eE6LjDJPF691ywKjYBLYn9L26A2fwCihJXfzwG
        28wrYCfRuvQfWJxFQFWi/fR1MFtUIELi8I5ZUDWCEidnPmEBsTkFYiXmzdzADnIds4C6xPp5
        YM8wC4hL3HoynwnClpdo3jqbeQKj8Cwk3bMQOmYh6ZiFpGMBI8sqRsnUguLc9NxiwwKjvNRy
        veLE3OLSvHS95PzcTYzgeNbS2sF44kT8IUYBDkYlHl4H1q5YIdbEsuLK3EOMEhzMSiK8s2SA
        QrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhibTzjYuRxd
        rKczf44Gr8VtA11Pw6dpQcpOl4KXPMkze/12f72ryjFf4y9z9rmuaJukInZ9+gteoVyLubcz
        f6pzB6qUP+Xx9ihMk7lnGqq1oc7Jn0Esb3EzpxX7jdXNi711VtzdoXrxWPOjIwb6k7euc4/V
        0z7Cduz6qpIu0SUa2m+sOcW2hyixFGckGmoxFxUnAgAUbK504wIAAA==
X-CMS-MailID: 20190925021318epcas1p2f5145aa74ebfc55d2ea3bea604c94818
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924192429epcas3p196a7de011d3e78508d1e643efd27e717
References: <cover.1569319738.git.leonard.crestez@nxp.com>
        <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
        <20190924191124.GJ133864@google.com>
        <CGME20190924192429epcas3p196a7de011d3e78508d1e643efd27e717@epcas3p1.samsung.com>
        <VI1PR04MB7023034123415F86CC045CCDEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 25. 오전 4:22, Leonard Crestez wrote:
> On 24.09.2019 22:11, Matthias Kaehlcke wrote:
>> On Tue, Sep 24, 2019 at 01:11:29PM +0300, Leonard Crestez wrote:
>>> Register notifiers with the PM QoS framework in order to respond to
>>> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
>>>
>>> No notifiers are added by this patch but PM QoS constraints can be
>>> imposed externally (for example from other devices).
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>   drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>>>   include/linux/devfreq.h   |  5 +++
>>>   2 files changed, 80 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index eee403e70c84..784f3e40536a 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -22,15 +22,18 @@
>>>   #include <linux/platform_device.h>
>>>   #include <linux/list.h>
>>>   #include <linux/printk.h>
>>>   #include <linux/hrtimer.h>
>>>   #include <linux/of.h>
>>> +#include <linux/pm_qos.h>
>>>   #include "governor.h"
>>>   
>>>   #define CREATE_TRACE_POINTS
>>>   #include <trace/events/devfreq.h>
>>>   
>>> +#define HZ_PER_KHZ	1000
>>> +
>>>   static struct class *devfreq_class;
>>>   
>>>   /*
>>>    * devfreq core provides delayed work based load monitoring helper
>>>    * functions. Governors can use these or can implement their own
>>> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>   static void get_freq_range(struct devfreq *devfreq,
>>>   			   unsigned long *min_freq,
>>>   			   unsigned long *max_freq)
>>>   {
>>>   	unsigned long *freq_table = devfreq->profile->freq_table;
>>> +	unsigned long qos_min_freq, qos_max_freq;
>>>   
>>>   	lockdep_assert_held(&devfreq->lock);
>>>   
>>>   	/*
>>>   	 * Init min/max frequency from freq table.
>>> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>>>   	} else {
>>>   		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>>   		*max_freq = freq_table[0];
>>>   	}
>>>   
>>> +	/* constraints from PM QoS */
>>> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>> +					     DEV_PM_QOS_MIN_FREQUENCY); >
>> This needs to be DEV_PM_QOS_MAX_FREQUENCY. I missed this in the earlier
>> reviews, but stumbled across it when testing.
>>
>> !Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> I broke it in v8 while processing comments. Thanks for catching it.

Did you test this patchset with v8?
Maybe it is not working with this mistake.

> 
> --
> Regards,
> Leonard
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
