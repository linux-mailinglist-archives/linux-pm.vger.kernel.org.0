Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155C08C562
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 03:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHNBDS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 21:03:18 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48209 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHNBDS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 21:03:18 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190814010312epoutp016f5407231afc26a390df6b7ce61add73~6pGku0qZB0494004940epoutp01F
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 01:03:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190814010312epoutp016f5407231afc26a390df6b7ce61add73~6pGku0qZB0494004940epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565744592;
        bh=ekUHXfl5xMwX8ETi8uKcxfcJ/yFAKHc+alvQ2aGyq3U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gIu3c5uYpMP3KOl/gEbr0jiCiCwSGEerO13BtylnWfqJ059Py+cw/Uvo7B8YFN1Ly
         t2awe4YeHY12/OunLiyT+UJbQjdgTCKDbC9+pyA8+hKObotrMv7FmlU8uOHndZ+OOL
         7jCJoGbWmdhX7UrDc+1H5Dr3Br3NWP1eYf5notj8=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190814010311epcas1p45c076f9c617ba50028c4380e302f30e9~6pGj8mgtA2482924829epcas1p4z;
        Wed, 14 Aug 2019 01:03:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 467WXr4BLfzMqYkc; Wed, 14 Aug
        2019 01:03:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.6D.04075.CCD535D5; Wed, 14 Aug 2019 10:03:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190814010308epcas1p1cc3b7ae78610a659f464d6b04ad2f876~6pGg8ELRZ2495024950epcas1p1p;
        Wed, 14 Aug 2019 01:03:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190814010308epsmtrp292f6605f02c398b63491c1fc964167c1~6pGg7CZ072326323263epsmtrp2N;
        Wed, 14 Aug 2019 01:03:08 +0000 (GMT)
X-AuditID: b6c32a36-b61ff70000000feb-69-5d535dcccfdd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.D0.03706.BCD535D5; Wed, 14 Aug 2019 10:03:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190814010307epsmtip2c6b9facb8801270edbd2ef7f943e2510~6pGgsNNG21394113941epsmtip2i;
        Wed, 14 Aug 2019 01:03:07 +0000 (GMT)
Subject: Re: [PATCHv2] PM / devfreq: Add dev_pm_qos support
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a9328230-96f3-6bab-826a-bb199de4ad48@samsung.com>
Date:   Wed, 14 Aug 2019 10:06:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023EB13BB2DE94814B38477EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmge6Z2OBYgzMdChaHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWtxpkLFbc/chqsenxNVaLz71HGC1uN65gszhz+hKrRdeh
        v2wWG796OPB5vL/Ryu6xYFOpx6ZVnWwed67tYfPYvKTeY+O7HUweB9/tYfLYcrWdxaNvyypG
        j8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4CuV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoY
        GJkCFSZkZ7xtfs9cME2+ouPoZKYGxkWSXYycHBICJhLzdv5mAbGFBHYwSqy8at3FyAVkf2KU
        WNDwkgXC+cYo8eDpUiaYjhX/NzBBJPYySmy/8pUdwnkP1DJxAiNIlbCAtcSyj7OYQWwRgXqJ
        H5v/MoMUMQusYJGYNHENO0iCTUBLYv+LG2wgNr+AosTVH4/BmnkF7CSOnHkG1swioCrxr+0S
        2IGiAhESnx4cZoWoEZQ4OfMJWJxTIFZi69wVYPXMAuISt57MZ4Kw5SWat84GWywhcIxd4tDk
        TywQP7hI/Pp9nhXCFpZ4dXwLO4QtJfH53V42CLtaYuXJI2wQzR2MElv2X4BqMJbYv3Qy0AYO
        oA2aEut36UOEFSV2/p7LCGHzSjRs/M0OcQSfxLuvPawg5SDxjjYhiBJlicsP7jJNYFSeheSd
        WUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBCju5NjOCkrWW2g3HROZ9DjAIcjEo8vAFbgmKF
        WBPLiitzDzFKcDArifBOuAgU4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKiyfnAjJJXEm9oamRs
        bGxhYmhmamioJM678IdFrJBAemJJanZqakFqEUwfEwenVANjzodJV9vW/nsQcXPFJ8vQHqbV
        +gHMjT4PFz85b3k9Ndd4SnxL+u/dRxvbmmsuHuLvZzNkTjeTWvD1Q5Oa4qPcP72TS1WLprLb
        rdwS3iMcX3LWRs1x25bOpRXmbyaqKcXesAm8qj4reP4CoxP6ztrrHorfKVp8m//hzON8Il0T
        lf73CZScUX6ixFKckWioxVxUnAgAjvh9fvADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSvO7p2OBYgx8HrS0OHdvKbvH19ClG
        i5eHNC2m793EZnH+/AZ2i7NNb9gtbjXIWKy4+5HVYtPja6wWn3uPMFrcblzBZnHm9CVWi65D
        f9ksNn71cODzeH+jld1jwaZSj02rOtk87lzbw+axeUm9x8Z3O5g8Dr7bw+Sx5Wo7i0ffllWM
        Hp83yQVwRXHZpKTmZJalFunbJXBlvG1+z1wwTb6i4+hkpgbGRZJdjJwcEgImEiv+b2DqYuTi
        EBLYzShx5PV6NoiEpMS0i0eZuxg5gGxhicOHi0HCQgJvGSWW/Q4AsYUFrCWWfZzFDNIrItDI
        KHH4+Qowh1lgHYtE/6G17BBTdzJJnPvwgRmkhU1AS2L/ixtgG/gFFCWu/njMCGLzCthJHDnz
        DKyGRUBV4l/bJRYQW1QgQuLwjllQNYISJ2c+AYtzCsRKbJ27Auw6ZgF1ifXzhEDCzALiEree
        zGeCsOUlmrfOZp7AKDwLSfcshI5ZSDpmIelYwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9d
        Lzk/dxMjOHa1NHcwXl4Sf4hRgINRiYc3YEtQrBBrYllxZe4hRgkOZiUR3gkXgUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUw6ln1vy5rat5XtXqu2tHn
        M6R99ju9lrl7emtz6YpdEasdjrzf31U294a3cZBaywa/oqZbgWXT257b/5DfdL93q37lLM1p
        Znui5M4ab2ecPo/z/6OFvHKra/+GlmszuCbFlMaIvixO/W6xzSGz1O2uaOKS+4tvrlMLeXPu
        Z++j7KDr0b6cG4SVlFiKMxINtZiLihMBammK79kCAAA=
X-CMS-MailID: 20190814010308epcas1p1cc3b7ae78610a659f464d6b04ad2f876
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 13. 오후 8:27, Leonard Crestez wrote:
> On 13.08.2019 09:10, Chanwoo Choi wrote:
>> In case of cpufreq, cpufreq.c replace the body of store_min_freq()
>> and store_max_freq() by using struct dev_pm_qos_request instancce
>> with dev_pm_qos_update_request().
>>
>> If you use the new way with dev_pm_qos_update_request() for
>> min_freq_store() and max_freq_store(), it doesn't need to
>> get the final frequency from three candidate frequencies.
> 
> Yes, I saw that but didn't implement the equivalent for devfreq because 
> it's not clear what there is to gain.

I think that it is clear. Just use the dev_pm_qos_request interface
for both user input through sysfs and device input with qos request.
Already PM_QOS has the feature to get the final freuency among
the multiple request. When use the dev_pm_qos request, the devfreq
doesn't need to compare between user input and device input with qos.
It make devfreq core more clear and simple

> 
> Since dev_pm_qos is measured in khz it means that min_freq/max_req on 
> sysfq would lose 3 significant digits, however those digits are probably 
> useless anyway.

I think that it doesn't matter. This patch already considers the this issue
by using '* 1000'. We can get either KHz or MHz with additional operation.
I think that it is not problem.

> 
>> In result, We only consider the following two candidate frequencies
>> as following:
>> 1. "devfreq->scaling_min_freq" will contain the requirement
>>     from devfreq thermal throttling by OPP interface.
> 
> It's a bit awkward that the OPPs enable/disable API is not obviously 
> specific to "thermal".

driver/thermal/devfreq_cooling.c uses the OPP interface to enable/disable
the OPP entries according to the thermal throttling policy. 

> 
>> 2. "devfreq->min_freq" will contain the requirements
>>     from both user input through sysfs and the dev_pm_qos_request.
> According to a comment on a previous version it would be useful to have 
> a separate files for "constraint min/max freq" and "user min/max freq":
> 
>      https://patchwork.kernel.org/patch/11078475/#22805379

Actually, I think that I want to use the only dev_pm_qos_request
for all external request like devfreq cooling of thermal,
user input through sysfs and device request with dev_pm_qos_request.

Already, dev_pm_qos_request is designed to consider the multiple requirements.
We don't need to use the various method (OPP interface, sysfs input, dev_pm_qos)
because make it more simple and easy.

I think that after finished the review of this patch, I will do refactor the devfreq_cooling.c
by using the dev_pm_qos_request. Or, if there are some volunteeer,

> 
> Combining min/max requests from dev_pm_qos and sysfs would make this 
> harder to implement. I guess user_min_freq could be implemented by 

I think that it is not difficult. Just make the different dev_pm_qos_request
instances. When qos has the multiple request from one more dev_pm_qos_request,
just get the value by using dev_pm_qos_read_value().
- a dev_pm_qos_request for user input
- b dev_pm_qos_request for device request on other device driver


> reading back the dev_pm_qos request but there would be no way to 
> implement a qos_min_freq entry.

I don't understand. Just devfreq show the min freq from dev_pm_qos_request
which contains the all requirement of minimum frequency.

If there are no any request to dev_pm_qos_request, we can just
get the minimum frequency from dev_pm_qos_request because 
the devfreq device would call the dev_pm_qos_update_request(..., min_freq)
on the probe time.

If I know the wrong information, please let me know.


> 
>>> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb, unsigned long val, void *ptr)
>>
>> Please keep the under 80 line if there are no any special reason.
> 
> OK, will check.
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
