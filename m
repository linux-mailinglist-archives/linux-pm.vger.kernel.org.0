Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0E8C576
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 03:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHNBOM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 21:14:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:39673 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfHNBOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 21:14:11 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190814011404epoutp02075ad65af7f5792c1601cfcc5f8e909c~6pQEudq_R2537525375epoutp02O
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 01:14:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190814011404epoutp02075ad65af7f5792c1601cfcc5f8e909c~6pQEudq_R2537525375epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565745244;
        bh=SQHsqDV4uJ+abV41RKfiRD79x2YaVt8hGdI7wb3HQeE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bOyUDWzo5GRe5kp3OBhoyXxE2vbtXW+1z51991rn5UjGVy4/W/ezRi+4DI8MOxrOe
         mTGhn1BOUxBCYa/VDsHqsphrUGk4ExFUWbGIrwG51xlhQwz3vU5kjeKH93D/SCIxFQ
         DdcFKz2ErNOASk6RYofJEvULIZpKdyGiVmvY/Ocs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190814011404epcas1p4eedfacd32c69fadd8a14ed06c60c53e3~6pQD9I1Dw0470904709epcas1p4E;
        Wed, 14 Aug 2019 01:14:04 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 467WnP0fpxzMqYlp; Wed, 14 Aug
        2019 01:14:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.14.04085.850635D5; Wed, 14 Aug 2019 10:14:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190814011400epcas1p14db429c8ea6174570187e7c2ddfd74ef~6pQAWeeQa2757727577epcas1p1U;
        Wed, 14 Aug 2019 01:14:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190814011400epsmtrp1ca64f510bfd75378b990ee2ac910bc4c~6pQAVi1ao0552905529epsmtrp1I;
        Wed, 14 Aug 2019 01:14:00 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-c6-5d536058d9e0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.72.03638.850635D5; Wed, 14 Aug 2019 10:14:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190814011400epsmtip291ec905882919c5be9af03a9f5644f27~6pQAJDJZH2067720677epsmtip2P;
        Wed, 14 Aug 2019 01:14:00 +0000 (GMT)
Subject: Re: [PATCHv2] PM / devfreq: Add dev_pm_qos support
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Organization: Samsung Electronics
Message-ID: <195bef25-5235-4c24-cc7a-48d368da3bbd@samsung.com>
Date:   Wed, 14 Aug 2019 10:17:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a9328230-96f3-6bab-826a-bb199de4ad48@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmgW5EQnCswb511haHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWtxpkLFbc/chqsenxNVaLz71HGC1uN65gszhz+hKrRdeh
        v2wWG796OPB5vL/Ryu6xYFOpx6ZVnWwed67tYfPYvKTeY+O7HUweB9/tYfLYcrWdxaNvyypG
        j8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4CuV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoY
        GJkCFSZkZ8ybfoO1YKtyRe/dVYwNjCdkuhg5OCQETCQedHp1MXJxCAnsYJSY1tDIDOF8YpRo
        nDGRBcL5xihx7fxCoAwnWMeyD9uhqvYySnRt3wLlvGeUeHzkCStIlbCAtcSyj7PAOtgEtCT2
        v7jBBmKLCNRL/Nj8F6yBWWAFi8SkiWvYQRL8AooSV388ZgSxeQXsJL5O6AdrYBFQlXj/ZCPY
        UFGBCIlPDw6zQtQISpyc+YQFxOYUsJdYc3ExE4jNLCAucevJfChbXqJ562ywZRICh9gldryY
        D/WDi8Sv+dvYIWxhiVfHt0DZUhIv+9ug7GqJlSePsEE0dzBKbNl/gRUiYSyxf+lkJlDwMQto
        SqzfpQ8RVpTY+XsuI4TNK9Gw8Tc7xBF8Eu++9rBCQptXoqNNCKJEWeLyg7tMExiVZyF5ZxaS
        F2YheWEWwrIFjCyrGMVSC4pz01OLDQtMkaN7EyM4aWtZ7mA8ds7nEKMAB6MSD2/AlqBYIdbE
        suLK3EOMEhzMSiK8Ey4ChXhTEiurUovy44tKc1KLDzGaAkN7IrOUaHI+MKPklcQbmhoZGxtb
        mBiamRoaKonzLvxhESskkJ5YkpqdmlqQWgTTx8TBKdXAuDavqtCmR79iiVG5rfx0nbWN9iJu
        T5c/Ktat5W6ftzRm8t35nHE2bJNrpt4v2b7fluvRb92imHey9bJq029/04lyqJnZeGKHLP/m
        N2r77xR9M/x8uocvYOp7/4tyDgnTLr9OY2X7ZfvUqf0j//p1lZo6q/jOzrqk90jEV/qWQr12
        aNXym5EZSizFGYmGWsxFxYkAysa1z/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSvG5EQnCswYoZPBaHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWtxpkLFbc/chqsenxNVaLz71HGC1uN65gszhz+hKrRdeh
        v2wWG796OPB5vL/Ryu6xYFOpx6ZVnWwed67tYfPYvKTeY+O7HUweB9/tYfLYcrWdxaNvyypG
        j8+b5AK4orhsUlJzMstSi/TtErgy5k2/wVqwVbmi9+4qxgbGEzJdjJwcEgImEss+bGfuYuTi
        EBLYzShx4MljRoiEpMS0i0eBEhxAtrDE4cPFEDVvGSUWbTjJBlIjLGAtsezjLGYQm01AS2L/
        ixtsIEUiAo2MEoefrwCbyiywjkWi/9Badoj2d0wSX+a/AmvhF1CUuPoDYh2vgJ3E1wn9YGNZ
        BFQl3j/ZyApiiwpESBzeMQuqRlDi5MwnLCA2p4C9xJqLi5lAbGYBdYk/8y4xQ9jiEreezIeK
        y0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
        TYzgCNbS2sF44kT8IUYBDkYlHt6ALUGxQqyJZcWVuYcYJTiYlUR4J1wECvGmJFZWpRblxxeV
        5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamBU4NHeuPBBhezOjzF7uhpk/Oz/
        r+m9ZNPadnB7h8Gf37kBv+9dEP3jfq7h4xVjjh2Mn9lORVz6fG+V3fJj5SLONqG/6/Y+nJv1
        bUnn3c/CBxkLxGd82eMscTBu+8UimZSb9Wcr7VZvmdSl0Wkofc+Ta+Ulse1LBNXm/r588MXi
        iwsbJp/9tV6RXYmlOCPRUIu5qDgRAGDiLZTcAgAA
X-CMS-MailID: 20190814011400epcas1p14db429c8ea6174570187e7c2ddfd74ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160
References: <CGME20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160@epcas4p3.samsung.com>
        <e45c28528ff941abb1f72fdb1eedf65fb3345c5a.1565274802.git.leonard.crestez@nxp.com>
        <b3941b19-f0aa-87a6-d50a-299d07a26532@samsung.com>
        <VI1PR04MB7023EB13BB2DE94814B38477EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <a9328230-96f3-6bab-826a-bb199de4ad48@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 14. 오전 10:06, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 8. 13. 오후 8:27, Leonard Crestez wrote:
>> On 13.08.2019 09:10, Chanwoo Choi wrote:
>>> In case of cpufreq, cpufreq.c replace the body of store_min_freq()
>>> and store_max_freq() by using struct dev_pm_qos_request instancce
>>> with dev_pm_qos_update_request().
>>>
>>> If you use the new way with dev_pm_qos_update_request() for
>>> min_freq_store() and max_freq_store(), it doesn't need to
>>> get the final frequency from three candidate frequencies.
>>
>> Yes, I saw that but didn't implement the equivalent for devfreq because 
>> it's not clear what there is to gain.
> 
> I think that it is clear. Just use the dev_pm_qos_request interface
> for both user input through sysfs and device input with qos request.
> Already PM_QOS has the feature to get the final freuency among
> the multiple request. When use the dev_pm_qos request, the devfreq
> doesn't need to compare between user input and device input with qos.
> It make devfreq core more clear and simple
> 
>>
>> Since dev_pm_qos is measured in khz it means that min_freq/max_req on 
>> sysfq would lose 3 significant digits, however those digits are probably 
>> useless anyway.
> 
> I think that it doesn't matter. This patch already considers the this issue
> by using '* 1000'. We can get either KHz or MHz with additional operation.
> I think that it is not problem.
> 
>>
>>> In result, We only consider the following two candidate frequencies
>>> as following:
>>> 1. "devfreq->scaling_min_freq" will contain the requirement
>>>     from devfreq thermal throttling by OPP interface.
>>
>> It's a bit awkward that the OPPs enable/disable API is not obviously 
>> specific to "thermal".
> 
> driver/thermal/devfreq_cooling.c uses the OPP interface to enable/disable
> the OPP entries according to the thermal throttling policy. 
> 
>>
>>> 2. "devfreq->min_freq" will contain the requirements
>>>     from both user input through sysfs and the dev_pm_qos_request.
>> According to a comment on a previous version it would be useful to have 
>> a separate files for "constraint min/max freq" and "user min/max freq":
>>
>>      https://patchwork.kernel.org/patch/11078475/#22805379
> 
> Actually, I think that I want to use the only dev_pm_qos_request
> for all external request like devfreq cooling of thermal,
> user input through sysfs and device request with dev_pm_qos_request.
> 
> Already, dev_pm_qos_request is designed to consider the multiple requirements.
> We don't need to use the various method (OPP interface, sysfs input, dev_pm_qos)
> because make it more simple and easy.
> 
> I think that after finished the review of this patch, I will do refactor the devfreq_cooling.c
> by using the dev_pm_qos_request. Or, if there are some volunteeer,

Sorry, I would withdraw the this opinion about replacing
the OPP enable/disable interface with the dev_pm_qos_request
because even if devfreq-cooling.c needs the 'dev' instance
to use the dev_pm_qos_request method, it is not clear until now.
It needs how to get the device instance of devfreq on device-tree.

Keep discussing without it. 

> 
>>
>> Combining min/max requests from dev_pm_qos and sysfs would make this 
>> harder to implement. I guess user_min_freq could be implemented by 
> 
> I think that it is not difficult. Just make the different dev_pm_qos_request
> instances. When qos has the multiple request from one more dev_pm_qos_request,
> just get the value by using dev_pm_qos_read_value().
> - a dev_pm_qos_request for user input
> - b dev_pm_qos_request for device request on other device driver
> 
> 
>> reading back the dev_pm_qos request but there would be no way to 
>> implement a qos_min_freq entry.
> 
> I don't understand. Just devfreq show the min freq from dev_pm_qos_request
> which contains the all requirement of minimum frequency.
> 
> If there are no any request to dev_pm_qos_request, we can just
> get the minimum frequency from dev_pm_qos_request because 
> the devfreq device would call the dev_pm_qos_update_request(..., min_freq)
> on the probe time.
> 
> If I know the wrong information, please let me know.
> 
> 
>>
>>>> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb, unsigned long val, void *ptr)
>>>
>>> Please keep the under 80 line if there are no any special reason.
>>
>> OK, will check.
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
