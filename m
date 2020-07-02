Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442CF211819
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 03:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgGBBZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 21:25:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:42941 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgGBBXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 21:23:50 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200702012347epoutp0391809d19f88f3a8e43e47559c108e366~dyvwXQpON2031720317epoutp03J
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 01:23:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200702012347epoutp0391809d19f88f3a8e43e47559c108e366~dyvwXQpON2031720317epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593653027;
        bh=BIJ8exSrtpBrvnlfhORDNhW3IdqqFicMwvVZdnwAlgA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LfPsp3YKR8kXsQSyds2krh39VDoL1EP+twUykAj+nF2idGNOEvdoICZg3Ibt+HI37
         QRdpFjvP1J5uO2Y1R7RNME03igxDbCUEU3oNp3krXLEC0A6OYyGkEj1mnF0zsoipcx
         84AFSbAdkmdtgJHQzMnZL4aWaNNvmnXZqLDSThg8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702012346epcas1p1c09d5dbb8bbeb1971d6ad253475d9431~dyvv5rLx41303413034epcas1p19;
        Thu,  2 Jul 2020 01:23:46 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49y0jX3GSFzMqYlp; Thu,  2 Jul
        2020 01:23:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.C2.28578.0273DFE5; Thu,  2 Jul 2020 10:23:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702012343epcas1p1da44b969ce1f7e8bd846e8ad189f4a9f~dyvtKsN-g1302913029epcas1p16;
        Thu,  2 Jul 2020 01:23:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702012343epsmtrp1866b875c83d13cc0e2f99f86f2d9dd09~dyvtJF35c1496914969epsmtrp1Q;
        Thu,  2 Jul 2020 01:23:43 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-2d-5efd37207f79
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.D6.08382.F173DFE5; Thu,  2 Jul 2020 10:23:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702012343epsmtip230d85c2293146ac2c4cb517e993ff3ca~dyvs2ipBj2710327103epsmtip2z;
        Thu,  2 Jul 2020 01:23:43 +0000 (GMT)
Subject: Re: [PATCH v4 11/37] PM / devfreq: tegra30: Silence deferred probe
 error
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8e941321-5da6-e9e7-6a4e-8c0477911ebd@samsung.com>
Date:   Thu, 2 Jul 2020 10:34:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <fda8aa80-04f1-af00-7a0d-f9b589cdb37e@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmrq6C+d84g5/fJCzuz2tltHj36Smr
        xfwj51gtVn98zGhx5et7NovpezexWbTMWsRicbbpDbvF5V1z2Cw+9x5htOj8MovN4uIpV4vb
        jSvYLCatncpo0br3CLvFv2sbWSx+7prH4iDo8f5GK7vHzll32T0unfvD7LFpVSebx51re9g8
        7ncfZ/LobX7H5tG3ZRWjx+dNcgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
        5koKeYm5qbZKLj4Bum6ZOUC/KCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0
        ihNzi0vz0vWS83OtDA0MjEyBChOyM843drIW7BCs2P9kOmMDYy9fFyMnh4SAicSt/vVsXYxc
        HEICOxgllm9rYIZwPjFKnP58HyrzjVHiwOPrLDAtG4+0gtlCAnsZJV6uEoIoes8o8e7nezaQ
        hLBAsMSx15fYQRIiAkeYJVZ3HmcEcZgFLjNKnG37AlbFJqAlsf/FDTCbX0BR4uqPx4wgNq+A
        ncS8hk1gK1gEVCQWX5rDDGKLCoRJnNzWAlUjKHFy5hOwGk4BW4mJFzrB4swC4hK3nsxngrDl
        JZq3zgZ7SEKgmVPiwPMDbBA/uEisWL+YEcIWlnh1fAs7hC0l8bK/Dcqullh58ggbRHMHo8SW
        /RdYIRLGEvuXTgbawAG0QVNi/S59iLCixM7fc6GO4JN497WHFaREQoBXoqNNCKJEWeLyg7tM
        ELakxOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBabI8b2JEZzStSx3ME5/
        +0HvECMTB+MhRgkOZiUR3tMGv+KEeFMSK6tSi/Lji0pzUosPMZoCA3gis5Rocj4wq+SVxBua
        GhkbG1uYGJqZGhoqifM6WV+IExJITyxJzU5NLUgtgulj4uCUamBaerl4Z9jvpq//be+/qojt
        4Pv/v2zb61szBX6t5ugRXpz3UNKa6z53V9C+6sLg7nAvwSsJJyume7yLeyvhKZaisbmv0vzC
        sf/t57vNvk0/Wmpk+yOwYFFsgLoX91+TvxvDHNf79i44bnPJb9ltD/H8/OcP/7WXVX/drmnP
        Ep2o8Uv9rHRjMcfp5NkX5qxeIvO24shOxwyfijnHnr18n7bW168r+vSXLzFshT7Vgu+3bngy
        Yaa5xGP/i62N//xnX73mFtzG6N35L3azi9Kt1MZDdQdezA8NVhGc8eDbhtP3md8wPGpaJL1A
        tXiCGmvTNZ45yhqBvQ/eHVB89/adUdzEV+KS0w5aJT6aWG7DreGrxFKckWioxVxUnAgAy4Yu
        U3IEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTURyAOfde77YLs7ut8mShNIqalClEHntIqcEtg4qyUGp50cuU3NJt
        ZkaBZTO3WqX0XDJzipVR4FLT8oXOma1Ml9rwkaAWQaWplT3MahuB/33n/L7v8IPDx8XthD8/
        RaXl1Co2VUpSRHWLNHB1YNhveci0UYaGzDqAxibf+qAiW4cPujcxAlD313ESXau3kuiMyUKg
        F6c/8tCrx4UkmjLaANJ/MZGo69lW1H/qDokK7l8BSFdv46HZ3goC/XhsJjaLmHGXjsfUmgZ5
        jLNjBmes5XqSGeitI5mhc20YY8wZI5kLleWAmbIG7BLEUxuTuNSUo5x6TUQClfzylN4nrUZ0
        rHH0GsgGRl8DEPAhvRZW2HSEm8X0EwD7XfHe+0XwalcrbgD8fyyBLS0aA6D+KZ8AbHozAtyO
        hN4D7R+cPPdgPm3HodXhwNwHnH4FYI3+K+lNzBhsLCzC3QlJB8HG9y7SzfPopbDnu/cpIR0B
        zdlWzxoEvQyWOAs9/gJ6H6wtHcG8jgi23xj1OAJ6E8zv1HtanF4BZ8xO3Mt+sG+0CPNyIMyp
        uolfAhLTnNw0JzHNSUxzkluAKAeLuDSNUqHUhKaFqrjMYA2r1GSoFMGJR5RW4PntIFkNeFT+
        ObgZYHzQDCAfl84XOkJ+ysXCJDbrOKc+ckidkcppmsFiPiH1E7rSi+ViWsFqucMcl8ap/08x
        vsA/G9tWkZRU1aabWJtZZFRgZ89iWylLZ3QnahJdyhSFlQzEhftKfjVlZFkMCU9T7NIfQiUW
        dCjKrxjJIt7Z1h/oC0iRVGGxk3Dovqw6NXo4hHGEbfiJop4/KCjVb/qV6/tNJ195Oy+bjZye
        96dsv6wDVW9v6KECr2BE3NVSe7diduZTQ1RDgUQozlXFh1gbtmjzqcTu/HBqLOD8jg7LZecs
        1TRgEA2vm647LNsb0R6J0d9fH2AjE+X49tiXMYPXKx07hx/uPrlKfyKDe6A4eVB7UcAtX1Jo
        rU3Y5p8ec6fVqN2SY7kbW58XXrswLNFl74qZ8JvIjVsqU7BlPFApJTTJbGgQrtawfwFIpLrp
        XAMAAA==
X-CMS-MailID: 20200702012343epcas1p1da44b969ce1f7e8bd846e8ad189f4a9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609131843epcas1p3a5b06308559ff03ef1b27521f412b656
References: <20200609131404.17523-1-digetx@gmail.com>
        <CGME20200609131843epcas1p3a5b06308559ff03ef1b27521f412b656@epcas1p3.samsung.com>
        <20200609131404.17523-12-digetx@gmail.com>
        <136b430d-2097-7b2b-d7dd-b438deee8f5d@samsung.com>
        <fda8aa80-04f1-af00-7a0d-f9b589cdb37e@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/2/20 10:20 AM, Dmitry Osipenko wrote:
> 02.07.2020 03:59, Chanwoo Choi пишет:
>> Hi,
>>
>> On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
>>> Tegra EMC driver was turned into a regular kernel driver, it also could
>>> be compiled as a loadable kernel module now. Hence EMC clock isn't
>>> guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER and
>>> there is no good reason to spam KMSG with a error about missing EMC clock
>>> in this case, so let's silence the deferred probe error.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>> index e94a27804c20..423dd35c95b3 100644
>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>> @@ -801,9 +801,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  	}
>>>  
>>>  	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
>>> -	if (IS_ERR(tegra->emc_clock)) {
>>> -		dev_err(&pdev->dev, "Failed to get emc clock\n");
>>> -		return PTR_ERR(tegra->emc_clock);
>>> +	err = PTR_ERR_OR_ZERO(tegra->emc_clock);
>>> +	if (err) {
>>> +		if (err != -EPROBE_DEFER)
>>> +			dev_err(&pdev->dev, "Failed to get emc clock: %d\n",
>>> +				err);
>>> +		return err;
>>>  	}
>>>  
>>>  	err = platform_get_irq(pdev, 0);
>>>
>>
>> As I commented on patch10, I recommend that you add the Tegra EMC driver
>> commit information into patch description and Looks good to me.
>>
> 
> Hello, Chanwoo!
> 
> This patch11 and patch10 are depending on the patches 4/5 (the Tegra EMC
> driver patches) of *this* series, hence there is no commit information.
> I'm expecting that this whole series will go via tegra tree once all the
> patches will be reviewed and collect all the necessary acks from you,
> ICC and CLK subsystem maintainers.
> 
> Please feel free to give yours ack to the patches 10/11 if they are good
> to you :)
> 
> 

OK. Looks good to me
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
