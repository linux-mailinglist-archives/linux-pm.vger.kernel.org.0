Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09B2A9071
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKFHel (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:34:41 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64571 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgKFHek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:34:40 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201106073435epoutp02d0cc4a2d6f23f0f95338e7071d7e5a77~E2uxPjc4v3092830928epoutp02H
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 07:34:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201106073435epoutp02d0cc4a2d6f23f0f95338e7071d7e5a77~E2uxPjc4v3092830928epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604648075;
        bh=q970vv8s62XPkoucluNk/h+Bajm6Y938td+8aJMMAw4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eq3kAYeOVZEkw3hlpWCYmUbJ7IMRsMlju7vx6JmQu20UqtupxqljcyrxY/RJ+3FGI
         4Ml8f8ZUYesV+UCDBTJbCylsVuqzSwARvFqZVXUWhWWnOsICj7ggqEOCHsPKQw0dF7
         7SoxtKlIMaXrH06WYb+ugRFNK1YqmZSZ3ktZETHg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201106073435epcas1p125afa6d21d5ae454f02de15ffce340ad~E2uwwi4-p2629926299epcas1p1D;
        Fri,  6 Nov 2020 07:34:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CSBwm25H5zMqYkV; Fri,  6 Nov
        2020 07:34:32 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.F2.09582.88CF4AF5; Fri,  6 Nov 2020 16:34:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201106073431epcas1p2993319f4ff36cfb3b3d5ed0291ffd492~E2utsIQpD1083410834epcas1p2N;
        Fri,  6 Nov 2020 07:34:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201106073431epsmtrp1b3cd262c18b472e9559413e04dba4e32~E2utrMe2i0289402894epsmtrp1P;
        Fri,  6 Nov 2020 07:34:31 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-d3-5fa4fc88bdff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.03.13470.78CF4AF5; Fri,  6 Nov 2020 16:34:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201106073431epsmtip299c4225a08abf332bb859f8b498f4a32~E2utZU25v2894528945epsmtip2a;
        Fri,  6 Nov 2020 07:34:31 +0000 (GMT)
Subject: Re: [PATCH 4/7] devfreq: exynos: dev_pm_opp_put_*() accepts NULL
 argument
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <5a9625bc-9e40-fb18-b111-9cd797943af3@samsung.com>
Date:   Fri, 6 Nov 2020 16:48:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <4b13f82c-fa2a-939f-e26f-e8fc4d34d567@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmrm7HnyXxBmdv8lis/viY0aL/8Wtm
        i/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaL240r2Cze/DjLZHHm9CVWi3/XNrJY
        dBz5xmyx8auHA5/Hzll32T02repk87hzbQ+bx+Yl9R5brrazePRtWcXocfzGdiaPz5vkAjii
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRn
        TP35i7ngNn/FkxvTWBsYP/N0MXJwSAiYSCyaZ9XFyMUhJLCDUeLGhBXMEM4nRomV59ewQzjf
        GCWefrgAlOEE67gybz0jRGIvo8T9ZQuYIJz3jBKNa04xgVQJC4RINLw/ygJiswloSex/cYMN
        pEhE4ASjxKz+b2AdzAJrmCT617wG6+AXUJS4+uMxI4jNK2An0XSoAcxmEVCR+Ld0A5gtKhAm
        cXJbC1SNoMTJmU/ANnAK2Eu8fv2JDcRmFhCXuPVkPhOELS+x/e0csI8kBN5wSHxf/o8R4gkX
        ifdnt7FC2MISr45vYYewpSRe9rdB2dUSK08eYYNo7mCU2LL/AlSDscT+pZOZQOHHLKApsX6X
        PkRYUWLn77mMEIv5JN597WGFBDGvREebEESJssTlB3eZIGxJicXtnWwTGJVmIXlnFpIXZiF5
        YRbCsgWMLKsYxVILinPTU4sNC4yR43sTIzhRa5nvYJz29oPeIUYmDsZDjBIczEoivBf8FsUL
        8aYkVlalFuXHF5XmpBYfYjQFBvBEZinR5HxgrsgriTc0NTI2NrYwMTQzNTRUEuf9o90RLySQ
        nliSmp2aWpBaBNPHxMEp1cC0+u3P8DPPJqQ9tBJf+fKyj13bIfmOtXkvPr6+Hx27p190qsqN
        bR0Sz88uvLvaw/tXyjxFRW7Ot1Pufcy2eb71colrRejHM/temTuYWFXwC2jcT7F09mgJ1j2Z
        EWgVb2hm58z3M9B+4Z6V5qcMDhaHdzbcqVGakyr0IU/OZ8+W/X/lHD4sfp4TcEvUqmXZ0+rX
        7ya9LRd36bY4fuf1Q6dZC5Xeuc+54ny+8ufci4fO/TuzQd7X3ODfzZB12gka8Z969bg8ti9w
        +ibMkJItWfPZIn5LnqHWecuXjzkcKv7fNOt3X2h2IFGmPfnEbI7CiWJKm1sian4w/f9bPXf7
        5u0WF2dEJle47s9VvdDU28ehxFKckWioxVxUnAgAfcdB710EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvG77nyXxBr8bjC1Wf3zMaNH/+DWz
        xfnzG9gtzja9YbfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbBZvfpxlsjhz+hKrxb9rG1ks
        Oo58Y7bY+NXDgc9j56y77B6bVnWyedy5tofNY/OSeo8tV9tZPPq2rGL0OH5jO5PH501yARxR
        XDYpqTmZZalF+nYJXBlTf/5iLrjNX/HkxjTWBsbPPF2MnBwSAiYSV+atZ+xi5OIQEtjNKLFv
        y3dWiISkxLSLR5m7GDmAbGGJw4eLIWreMkrc6XvMBFIjLBAi0fD+KAuIzSagJbH/xQ02kCIR
        gVOMEjdf9LODOMwCa5gkrpxawAbRfoZJ4tukp+wgLfwCihJXfzxmBLF5Bewkmg41gNksAioS
        /5ZuALNFBcIkdi6BWMcrIChxcuYTsHWcAvYSr19/YgOxmQXUJf7Mu8QMYYtL3HoynwnClpfY
        /nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC
        Y1ZLcwfj9lUf9A4xMnEwHmKU4GBWEuG94LcoXog3JbGyKrUoP76oNCe1+BCjNAeLkjjvjcKF
        cUIC6YklqdmpqQWpRTBZJg5OqQam82tnWKptkJi7dl1vm0K7x2atfyX5CRdW8UaV8HRsOT7n
        huSaxT0PH2UVXz3613At/3K/L7y7Erek194yu9DfYu8pv11HLmKz1v3Ve6teGu+9cdW7acO7
        8uK2Kp4bR39O+3bshdxJ/oQP59Ja15YVXJsu8Lbz8EfzfQkb3v8Wb83eecReqe/p/0SpU2tc
        Sh+7ceeWP3q3LT3ov7zVRdvqox52p4VruYvOsa3l5He3X8HE7HHWTPiX8pQVx8oOZK+0esm9
        VU0/N3TNzD12m6KOdV06s/appH6p+OlLqVu3L027tOkkc4ZocOnkxSb/73L/3vhv1hRtWY3b
        T6NPqsw3DG15zb41+Mjndys0lxvJ1yixFGckGmoxFxUnAgDfXt+1SAMAAA==
X-CMS-MailID: 20201106073431epcas1p2993319f4ff36cfb3b3d5ed0291ffd492
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201106070533epcas1p480406659e38528d1263641612fcff8bb
References: <cover.1604646059.git.viresh.kumar@linaro.org>
        <CGME20201106070533epcas1p480406659e38528d1263641612fcff8bb@epcas1p4.samsung.com>
        <b3c936d862b8c81ab568f38bd7acc438cb7efac8.1604646059.git.viresh.kumar@linaro.org>
        <a2f9dbba-1c07-8b60-fda5-737843be92e0@samsung.com>
        <4b13f82c-fa2a-939f-e26f-e8fc4d34d567@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/6/20 4:46 PM, Chanwoo Choi wrote:
> On 11/6/20 4:42 PM, Chanwoo Choi wrote:
>> Hi Viresh,
>>
>> On 11/6/20 4:03 PM, Viresh Kumar wrote:
>>> The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
>>> there is no need for us to carry the extra check. Drop them.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 12 ++++--------
>>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 1e684a448c9e..143fd58ec3dc 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -158,10 +158,8 @@ static void exynos_bus_exit(struct device *dev)
>>>  
>>>  	dev_pm_opp_of_remove_table(dev);
>>>  	clk_disable_unprepare(bus->clk);
>>> -	if (bus->opp_table) {
>>> -		dev_pm_opp_put_regulators(bus->opp_table);
>>> -		bus->opp_table = NULL;
>>> -	}
>>> +	dev_pm_opp_put_regulators(bus->opp_table);
>>> +	bus->opp_table = NULL;
>>>  }
>>>  
>>>  static void exynos_bus_passive_exit(struct device *dev)
>>> @@ -444,10 +442,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  	dev_pm_opp_of_remove_table(dev);
>>>  	clk_disable_unprepare(bus->clk);
>>>  err_reg:
>>> -	if (!passive) {
>>> -		dev_pm_opp_put_regulators(bus->opp_table);
>>> -		bus->opp_table = NULL;
>>> -	}
>>> +	dev_pm_opp_put_regulators(bus->opp_table);
>>> +	bus->opp_table = NULL;
>>>  
>>>  	return ret;
>>>  }
>>>
>>
>> Applied it. Thanks.
>>
> 
> It seems that this patch depends on first patch.
> So, need to be merged to one git repository.
> 
> Instead of applying it to devfreq.git,
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Also, need to add 'PM /' prefix to patch title 
in order to keep the same format with already merged devfreq patches.
- 'PM / devfreq: exynos: dev_pm_opp_put_*() accepts NULL argument'

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
