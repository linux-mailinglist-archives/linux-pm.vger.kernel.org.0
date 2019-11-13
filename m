Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9804FAD7D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKMJq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:46:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:33924 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfKMJq6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:46:58 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191113094655epoutp046d8fac25fd89814825bf4cd0970dd47d~Wr801ug491712517125epoutp04p
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:46:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191113094655epoutp046d8fac25fd89814825bf4cd0970dd47d~Wr801ug491712517125epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573638415;
        bh=VsyYZ9+HL/OjPZaEPukjhHvzqd+m/yivBbTZkkOgxV8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Dyyi5qtw7/n4x4BsEHMwY+9Vvw+CUDfh1RppT/YDlklgJ6asngQ4pGwCFjBK98//A
         4iBcXbM4DbqxLCPttgamw4xAM5zjiRqA0XuPWmiOoHMet0QzfO+R5oDDNI/JDH7H38
         3tOtSBTmZ7/LtAlJw0iU7MM1FzE+9Ow9p5aULG4o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113094655epcas1p1fb9d2e93579c5db9818397db3b2aff4d~Wr80YBgzL0338203382epcas1p1g;
        Wed, 13 Nov 2019 09:46:55 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Cfs90d11zMqYkb; Wed, 13 Nov
        2019 09:46:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.C0.04135.C01DBCD5; Wed, 13 Nov 2019 18:46:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113094652epcas1p255dbe5f7b1b813fb99a7a052d9297d17~Wr8x4DY3R2763427634epcas1p2i;
        Wed, 13 Nov 2019 09:46:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113094652epsmtrp20876f43432e2026b982aff0b45cfd60a~Wr8x3Rz8r0325703257epsmtrp2i;
        Wed, 13 Nov 2019 09:46:52 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-d4-5dcbd10c73e8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.9D.24756.C01DBCD5; Wed, 13 Nov 2019 18:46:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113094652epsmtip1b83a1dd5a07b503244f1c19eb1aa2c13~Wr8xk4Ccw0869808698epsmtip1f;
        Wed, 13 Nov 2019 09:46:52 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <60d9c577-128a-3ca9-2979-aa444cfb4e12@samsung.com>
Date:   Wed, 13 Nov 2019 18:52:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4f14d3af-e455-d05b-fc03-cba58e001f41@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmvi7PxdOxBke+2FhsnLGe1aJv339G
        i/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7fHplWd
        bB6bl9R7HHy3h8mjb8sqRo/Pm+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOALlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW
        6BUn5haX5qXrJefnWhkaGBiZAhUmZGdMWLuKtWCDRMX3/aUNjLeFuxg5OSQETCQWrDvM1sXI
        xSEksINR4vS9a6wQzidGidvnjrNAON8YJY7Mv8AK09K3dz07iC0ksJdRYt5HQ4ii94wS+1e8
        YwNJCAtkS3w7vYwZxGYT0JLY/+IGWFxEQFli8r3pzCANzAJdzBL7n14GK+IXUJS4+uMxI4jN
        K2An8XDeMRYQm0VAVWLh/oNANgeHqECExOmviRAlghInZz4BK+EUsJf40XSICcRmFhCXuPVk
        PpQtL9G8dTbYLgmBbnaJe7P2MkN84CKx4s50JghbWOLV8S3sELaUxOd3e9kg7GqJlSePsEE0
        dzBKbNkP876xxP6lk5lADmIW0JRYv0sfIqwosfP3XEaIxXwS7772sIKUSAjwSnS0CUGUKEtc
        fnAXaq2kxOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBUbIkb2JEZxotcx2
        MC4653OIUYCDUYmHV2LhqVgh1sSy4srcQ4wSHMxKIrw7Kk7ECvGmJFZWpRblxxeV5qQWH2I0
        BQb2RGYp0eR8YBbIK4k3NDUyNja2MDE0MzU0VBLndVy+NFZIID2xJDU7NbUgtQimj4mDU6qB
        0WK77PmsTQUCHnG3U/90PFGfERHvHqFozZ+85H6O87eXp50WnQ+bJOl0frpO02VRg8TcnjNL
        H33p0Ghd6Lh717JtvRpKcjW1BzPe5fLc5NrotnONgpYJy5U/mof7NLr3bfVcPW9Pz8uUozM+
        TV4eqn/oB4ub1Nzq4//n9NftM53jnsLcOiWsQomlOCPRUIu5qDgRANizwHrKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnC7PxdOxBnseiFlsnLGe1aJv339G
        i/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7fHplWd
        bB6bl9R7HHy3h8mjb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4MiasXcVasEGi4vv+0gbG28Jd
        jJwcEgImEn1717N3MXJxCAnsZpRYtPE2C0RCUmLaxaPMXYwcQLawxOHDxRA1bxklzi9ZzgRS
        IyyQLfHt9DJmEJtNQEti/4sbbCC2iICyxOR705lBGpgFepgl2vc3M0F0n2WUeDBvJiNIFb+A
        osTVH4/BbF4BO4mH846BbWYRUJVYuP8gmC0qECHxfPsNqBpBiZMzn4DFOQXsJX40HQK7gllA
        XeLPvEvMELa4xK0n86Hi8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAw
        L7Vcrzgxt7g0L10vOT93EyM46rQ0dzBeXhJ/iFGAg1GJh1di4alYIdbEsuLK3EOMEhzMSiK8
        OypOxArxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXA2Bcl
        L9Xx75/fx5e3Di7jOOafckLcw2Si3LNbUlV1y2azRMeucrix9eTtf87FQolNi2zLX/OXqcim
        edjndy7Me8Sg/W+Nf0WiXGrzoo7dl50D7+eeP8HErVIkop95OkY0zvbhGcXag5tPfXu+4vx6
        VrG4+ADO5dPe52+/Psl9noPvoR+P6k5dVmIpzkg01GIuKk4EAA5sYfm2AgAA
X-CMS-MailID: 20191113094652epcas1p255dbe5f7b1b813fb99a7a052d9297d17
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

Ping.

On 10/10/19 11:50 AM, Chanwoo Choi wrote:
> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>> dev_pm_opp_set_rate()") introduced errors:
>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>> ...
>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>
>> They are caused by incorrect PLL assigned to clock source, which results
>> in clock rate outside of OPP range. Add workaround for this in
>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
> 
> If the clock caused this issue, you can set the initial clock on DeviceTree
> with assigned-clock-* properties. Because the probe time of clock driver
> is early than the any device drivers.
> 
> It is not proper to fix the clock issue on other device driver.
> I think you can fix it by using the supported clock properties.

Is there any reply? or other patch to fix it?

> 
> 
>>
>> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>  drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index c832673273a2..37bd34d5625b 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>  {
>>  	struct device *dev = bus->dev;
>>  	struct dev_pm_opp *opp;
>> -	unsigned long rate;
>> +	unsigned long rate, opp_rate;
>>  	int ret;
>>  
>>  	/* Get the clock to provide each bus with source clock */
>> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>>  	}
>>  
>>  	rate = clk_get_rate(bus->clk);
>> -
>> -	opp = devfreq_recommended_opp(dev, &rate, 0);
>> +	opp_rate = rate;
>> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>>  	if (IS_ERR(opp)) {
>>  		dev_err(dev, "failed to find dev_pm_opp\n");
>>  		ret = PTR_ERR(opp);
>>  		goto err_opp;
>>  	}
>> +	/*
>> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
>> +	 * in clock rate outside defined OPP rate. Work around this bug by
>> +	 * setting clock rate to recommended one.
>> +	 */
>> +	if (rate > opp_rate)
>> +		clk_set_rate(bus->clk, opp_rate);
>> +
>>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>  	dev_pm_opp_put(opp);
>>  
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
