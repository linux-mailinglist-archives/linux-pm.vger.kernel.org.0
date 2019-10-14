Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0ED5B8D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 08:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfJNGlR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 02:41:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:56051 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfJNGlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 02:41:16 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191014064113epoutp02366c670733d4f50d26dd969927531a95~NcEHxrLpn2315123151epoutp02E
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2019 06:41:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191014064113epoutp02366c670733d4f50d26dd969927531a95~NcEHxrLpn2315123151epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571035273;
        bh=etSmYkdlLCLqB+EQLVgfIlp/7aIMo3cLq0v/Hx3Nrvs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JDbMiGt1aUZjoL667/X1a71yzZJv3wNMlMyzqbuiVAjrss/LpuKRG65tRSP31BiWj
         FguYoLPFyvouzsS7dbgvx1BOu2F2yt0oYpwoYDGJAR0CdgFXLWyJbPMsllXyuVzSyI
         IFVeZubhVj8X7utUsq6AMxBaiLu43L2J3g/GMEQs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191014064113epcas1p347dc9c7f71af8295f8c38114783c475c~NcEHa9vq_0560805608epcas1p3u;
        Mon, 14 Oct 2019 06:41:13 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46s88c5hdyzMqYkX; Mon, 14 Oct
        2019 06:41:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.DC.04224.08814AD5; Mon, 14 Oct 2019 15:41:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191014064103epcas1p35c029412778c82b174330560b5651196~NcD_dLO-Z0544405444epcas1p3S;
        Mon, 14 Oct 2019 06:41:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191014064103epsmtrp1b166e8df8c2ad17648b32d758d1032ab~NcD_cSe4z1480814808epsmtrp1a;
        Mon, 14 Oct 2019 06:41:03 +0000 (GMT)
X-AuditID: b6c32a38-1b4639c000001080-b8-5da41880d38c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.5C.04081.F7814AD5; Mon, 14 Oct 2019 15:41:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191014064103epsmtip1e2707a260a0879b4da818937faf1ac81~NcD_B-bYV0502505025epsmtip1G;
        Mon, 14 Oct 2019 06:41:03 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d742e7be-ca79-ae9e-6cc2-dc1fae08d252@samsung.com>
Date:   Mon, 14 Oct 2019 15:46:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0ce56e65-d989-18f8-af84-2fbd74ba20aa@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmrm6DxJJYg1kd+hYbZ6xntejb95/R
        ov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMHmwO2xaVUn
        m8fmJfUeB9/tYfLo27KK0ePzJrkA1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNL
        C3MlhbzE3FRbJRefAF23zBygy5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYF
        esWJucWleel6yfm5VoYGBkamQIUJ2RlXHt5gK5ijVrH65S3GBsap8l2MHBwSAiYSb44rdjFy
        cQgJ7GCUuPtjGnsXIyeQ84lRomt1IUTiG6PE/kVtTDANO4/bQMT3MkpsmL2cCaLhPaPE+enJ
        ILawQLbEt9PLmEFsEYEgicX3ZzCCNDAL3GaS6P30iwUkwSagJbH/xQ02EJtfQFHi6o/HjCA2
        r4CdxOV3DWBxFgFViaeHt7KCLBYViJA4/TURokRQ4uTMJ2BjOAXsJR7/2w92NLOAuMStJ/OZ
        IGx5ieats5lB9koI9LNLzFzbCdYgIeAi8ef7VyYIW1ji1fEt7BC2lMTL/jYou1pi5ckjbBDN
        HYwSW/ZfYIVIGEvsXzoZHBLMApoS63fpQ4QVJXb+nssIsZhP4t3XHlZIYPFKdLQJQZQoS1x+
        cBdqraTE4vZOtgmMSrOQvDMLyQuzkLwwC2HZAkaWVYxiqQXFuempxYYFJshRvYkRnGS1LHYw
        7jnnc4hRgINRiYdXIW1xrBBrYllxZe4hRgkOZiURXoYJC2KFeFMSK6tSi/Lji0pzUosPMZoC
        A3sis5Rocj4wA+SVxBuaGhkbG1uYGJqZGhoqifOyMs6PFRJITyxJzU5NLUgtgulj4uCUamD0
        5mxbL2Rpxd9s1en35Xdyy80l7/2WGwZxzvzbFX5vp3G5SveMdywGn70u78hdmLswbJrXbe3A
        PuWE1qyPppen8VuVCfjEmC5n2nN0E+eTEzU/uQXaWgXs1Teeqn15W39/ROjkgD3HXRgrb30R
        bNFlZp39xSnpdc7X5NdJ3O5OM3UCajWDziuxFGckGmoxFxUnAgA/rkBGyAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnG69xJJYg71npCw2zljPatG37z+j
        Rf/j18wW589vYLc42/SG3WLT42usFpd3zWGz+Nx7hNFixvl9TBZrj9xlt7jduILNgdtj06pO
        No/NS+o9Dr7bw+TRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGVce3mArmKNWsfrlLcYGxqny
        XYwcHBICJhI7j9t0MXJxCAnsZpTYvWcaUxcjJ1BcUmLaxaPMEDXCEocPF0PUvGWUuPXrHwtI
        jbBAtsS308uYQWwRgSCJRzNesYEUMQvcZZJY9+0DE0RHE5PE55k7GUGq2AS0JPa/uMEGYvML
        KEpc/fEYLM4rYCdx+V0DWJxFQFXi6eGtrCC2qECExPPtN6BqBCVOznwCtplTwF7i8b/97CA2
        s4C6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfY
        sMAwL7Vcrzgxt7g0L10vOT93EyM46rQ0dzBeXhJ/iFGAg1GJh/dE8uJYIdbEsuLK3EOMEhzM
        SiK8DBMWxArxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXA
        WOmVY5LIrzK1aDdH7zYGjngG11viwR7BDusNmj7LKtasyEo5GLJSM/NzSzvTSb1fp6WZd21L
        aKvuOVQ39/YN8UtWmeHtcztPK2xqs7n+JrV+WsBS66eKl5Zs/ZN06tDFbxw2mXG5W3arnoi/
        VO2cd9NplddO24crLj4I2FLy68tlG94ns6ZOUmIpzkg01GIuKk4EABQJz9S2AgAA
X-CMS-MailID: 20191014064103epcas1p35c029412778c82b174330560b5651196
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
References: <CGME20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b@eucas1p1.samsung.com>
        <20191008134923.30123-1-k.konieczny@partner.samsung.com>
        <4f14d3af-e455-d05b-fc03-cba58e001f41@samsung.com>
        <0ce56e65-d989-18f8-af84-2fbd74ba20aa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 19. 10. 11. 오후 8:33, Marek Szyprowski wrote:
> Hi Chanwoo,
> 
> On 10.10.2019 04:50, Chanwoo Choi wrote:
>> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>>> dev_pm_opp_set_rate()") introduced errors:
>>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>>> ...
>>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>>
>>> They are caused by incorrect PLL assigned to clock source, which results
>>> in clock rate outside of OPP range. Add workaround for this in
>>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
>> If the clock caused this issue, you can set the initial clock on DeviceTree
>> with assigned-clock-* properties. Because the probe time of clock driver
>> is early than the any device drivers.
>>
>> It is not proper to fix the clock issue on other device driver.
>> I think you can fix it by using the supported clock properties.
> 
> This issue is about something completely different. The OPPs defined in 
> DT cannot be applied, because it is not possible to derive the needed 
> clock rate from the bootloader-configured clock topology (mainly due to 
> lack of common divisor values for some of the parent clocks). Some time 
> ago Lukasz tried initially to redefine this clock topology using 
> assigned-clock-rates/parents properties (see 
> https://protect2.fireeye.com/url?k=4b80c0304459bc8e.4b814b7f-f87f1e1aee1a85c0&u=https://lkml.org/lkml/2019/7/15/276), but it has limitations and some 
> such changes has to be done in bootloader. Until this is resolved, 
> devfreq simply cannot set some of the defined OPPs.

As you mentioned, the wrong setting in bootloader cause the this issue.
So, this patch change the rate on exynos-bus.c in order to fix
the issue with workaround style. 

But, also, it can be fixed by initializing the clock rate on DT
although it is not fundamental solution as you mentioned.

If above two method are workaround way, I think that set the clock
rate in DT is proper. The role of 'assigned-clock-*' properties
is for this case in order to set the initial frequency on probe time.

I think that the previous patch[1] of Kamil Konieczny is missing
the patches which initialize the clock rate on DT file.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4294a779bd8dff6c65e7e85ffe7a1ea236e92a68

> 
> This issue was there from the beginning, recent Kamil's patch only 
> revealed it. In fact it was even worse - devfreq and common clock 
> framework silently set lower clock than the given OPP defined.
> 
>>> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>> ---
>>>   drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index c832673273a2..37bd34d5625b 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>   {
>>>   	struct device *dev = bus->dev;
>>>   	struct dev_pm_opp *opp;
>>> -	unsigned long rate;
>>> +	unsigned long rate, opp_rate;
>>>   	int ret;
>>>   
>>>   	/* Get the clock to provide each bus with source clock */
>>> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>   	}
>>>   
>>>   	rate = clk_get_rate(bus->clk);
>>> -
>>> -	opp = devfreq_recommended_opp(dev, &rate, 0);
>>> +	opp_rate = rate;
>>> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>>>   	if (IS_ERR(opp)) {
>>>   		dev_err(dev, "failed to find dev_pm_opp\n");
>>>   		ret = PTR_ERR(opp);
>>>   		goto err_opp;
>>>   	}
>>> +	/*
>>> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
>>> +	 * in clock rate outside defined OPP rate. Work around this bug by
>>> +	 * setting clock rate to recommended one.
>>> +	 */
>>> +	if (rate > opp_rate)
>>> +		clk_set_rate(bus->clk, opp_rate);
>>> +
>>>   	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>   	dev_pm_opp_put(opp);
>>>   
>>>
>>
> Best regards
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
