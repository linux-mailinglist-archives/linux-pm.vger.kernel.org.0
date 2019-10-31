Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9593EA945
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJaCjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:39:00 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50830 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJaCjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:39:00 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191031023857epoutp0470ed6c5c318bd0ed1264e34da4b3559e~Smuc1zGDu2775427754epoutp04H
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 02:38:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191031023857epoutp0470ed6c5c318bd0ed1264e34da4b3559e~Smuc1zGDu2775427754epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572489537;
        bh=ZrjSXqnWX0WknqRM4jVLDmtjrEYlYqAHDbrn5Zg62L0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bcGhSi+9PieLRNNBN0eCV1Ug0BLHrDCGTOkmVfAL0QzfgvUCKnLWU57KgD9y02I26
         7iP13pwmkF1LTaqYHk+L7S2d9XC3+ZCWpigvzWVNFcwxLPNXgg2umJMljAXf72rHBE
         gf1jQ/8TugqI92w5HOVbQB4Ub3P7XT3937zmY5Aw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191031023856epcas1p21fcdbe2a33aaddd66a96984ee5fd1522~Smub874dL1604016040epcas1p2a;
        Thu, 31 Oct 2019 02:38:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 473TzL1LLZzMqYkd; Thu, 31 Oct
        2019 02:38:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.A1.04224.E394ABD5; Thu, 31 Oct 2019 11:38:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191031023853epcas1p33c52d3887cf7295734bdf635aa107faa~SmuZItrkL1184111841epcas1p3a;
        Thu, 31 Oct 2019 02:38:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191031023853epsmtrp2be24731b617a689675cc21c6859b83b2~SmuZHuPds0115601156epsmtrp2U;
        Thu, 31 Oct 2019 02:38:53 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-66-5dba493e08a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.3C.25663.D394ABD5; Thu, 31 Oct 2019 11:38:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191031023853epsmtip253adc914cce4c206565fc3eca3c7b411~SmuY6RSyS1170711707epsmtip2K;
        Thu, 31 Oct 2019 02:38:53 +0000 (GMT)
Subject: Re: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <28744ca2-93c4-936c-e8fa-cfc96ddab3ca@samsung.com>
Date:   Thu, 31 Oct 2019 11:44:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011182907.GN87296@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMJsWRmVeSWpSXmKPExsWy7bCmga6d565Yg20TOC0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyM9bN/sVe8Fy0on3hLJYGxpeCXYycHBICJhJXft1k7mLk4hAS
        2MEosejJJVYI5xOjRNfzrewQzjdGif+929lgWrrO/odK7GWUmL+gB6r/PaPE01MHmEGqhAU8
        JTYv7QCq4uAQEaiWuPdMGiTMLDCFRWJxaz6IzSagJbH/xQ2wofwCihJXfzxmBLF5Bewkdh26
        ygzSyiKgKjHjeDmIKSoQIXH6ayJEhaDEyZlPWEBsTgEDieVrrrFCTBeXuPVkPhOELS/RvHU2
        M8TJp9glHtz2BBkjIeAisfSfLERYWOLV8S3sELaUxOd3e6E+rJZYefIIG8hTEgIdjBJb9l9g
        hUgYS+xfOpkJZA6zgKbE+l36EGFFiZ2/5zJCrOWTePe1hxViFa9ER5sQRImyxOUHd5kgbEmJ
        xe2dbBMYlWYheWYWkgdmIXlgFsKyBYwsqxjFUguKc9NTiw0LTJBjehMjOIFrWexg3HPO5xCj
        AAejEg/vhLKdsUKsiWXFlbmHGCU4mJVEeL/ZAIV4UxIrq1KL8uOLSnNSiw8xmgJDeiKzlGhy
        PjC75JXEG5oaGRsbW5gYmpkaGiqJ8zouXxorJJCeWJKanZpakFoE08fEwSnVwLgzmTE74pXN
        Zf339zOKGrS+cP7VKtF9Jnm3yWl+Z7TQVeWzlQrmoTyL369d+6a7aG74z7SaqfX//2lcT7a4
        5Pxn295SxdCbIp6P2r4++PjxyCzzk+ISvyTYtqzhFF4uz5kqEfZLXD7Cd2l5uMdmHS2/+uab
        Yldk9r97P4/L656iwfqw9ZPYNiqxFGckGmoxFxUnAgA2p4TC9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvK6t565Yg7k/NS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUVw2Kak5mWWpRfp2CVwZ62b/Yi94LlrRvnAWSwPjS8EuRk4O
        CQETia6z/9m7GLk4hAR2M0ps/vyCFSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSh3bdZAOpERbw
        lNi8tIMdxBYRqJWY27QVrJdZYBqLxOUGVYiGdUwS+1/cBUuwCWgB2TfAmvkFFCWu/njMCGLz
        CthJ7Dp0FWwZi4CqxIzj5SBhUYEIiefbb0CVCEqcnPmEBcTmFDCQWL7mGtQudYk/8y4xQ9ji
        EreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5x
        aV66XnJ+7iZGcERrae1gPHEi/hCjAAejEg/vhLKdsUKsiWXFlbmHGCU4mJVEeL/ZAIV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwcnw1urlV8vNs5RZb
        1lt8ZsdvL//Dbn3w+c2cotdTpt0M75ukGL9QIyszM/9Z/MIgof4Eu89sc88925D4rmJfvtfu
        j/628wJqi21/SrwWXn3jy1aFFpVVlQa2AdPVub0Oz1svNLtQ+9IT47RTsQFzVBmSGk//C2aP
        F+88sT1AND9EVsy+olhGiaU4I9FQi7moOBEAs8cfU+QCAAA=
X-CMS-MailID: 20191031023853epcas1p33c52d3887cf7295734bdf635aa107faa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191011182914epcas2p31a3a7d5371b5e2cd17cbb80d909348d7
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
        <20191003181938.GJ87296@google.com>
        <CGME20191011182914epcas2p31a3a7d5371b5e2cd17cbb80d909348d7@epcas2p3.samsung.com>
        <20191011182907.GN87296@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 12. 오전 3:29, Matthias Kaehlcke wrote:
> On Thu, Oct 03, 2019 at 11:19:38AM -0700, Matthias Kaehlcke wrote:
>> On Wed, Oct 02, 2019 at 10:25:09PM +0300, Leonard Crestez wrote:
>>> Moving handling of min/max freq to a single function and call it from
>>> update_devfreq and for printing min/max freq values in sysfs.
>>>
>>> This changes the behavior of out-of-range min_freq/max_freq: clamping
>>> is now done at evaluation time. This means that if an out-of-range
>>> constraint is imposed by sysfs and it later becomes valid then it will
>>> be enforced.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>  drivers/devfreq/devfreq.c | 110 +++++++++++++++++++++-----------------
>>>  1 file changed, 62 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 87eff789ce24..2d63692903ff 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>>
>>> ...
>>>
>>>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>>>  			     char *buf)
>>>  {
>>>  	struct devfreq *df = to_devfreq(dev);
>>> +	unsigned long min_freq, max_freq;
>>>  
>>> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
>>> +	mutex_lock(&df->lock);
>>> +	get_freq_range(df, &min_freq, &max_freq);
>>
>> With this min/max_freq shown aren't necessarily those set through sysfs,
>> but the aggregated PM QoS values (plus OPP constraints).
>>
>> I did some testing with a WIP patch that converts devfreq_cooling.c to
>> PM QoS. When reading sysfs min/max values to double check the limits
>> set earlier I found it utterly confusing to see the sysfs min/max values
>> fluctuating due to thermal throttling, and not being able to see the
>> configured values.
>>
>> Looks like cpufreq does the same, but I'm not convinced this is a good
>> idea. I think we want to display the values set by userspace, as done
>> before managing the limits through PM QoS. Viresh, was this change of
>> userspace visible behavior done intentionally for cpufreq?
> 
> ping
> 
> Viresh / devfreq maintainers:
> 
> Do we really want to expose through sysfs the potentially constantly
> changing aggregate min/max values, instead of those set by userspace?

Until now, the devfreq core show the available min/max frequency
through sysfs interface. I think the available min/max frequency is proper
for sysfs.

> At least for cpufreq that's a divergence from previous behavior, and
> from a userspace perspective it seems odd that you can't reliably read
> back the limit set by userspace.
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
