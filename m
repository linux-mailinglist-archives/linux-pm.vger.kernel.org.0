Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA47A6B6B4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfGQGfn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:35:43 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:51740 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfGQGfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:35:43 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190717063541epoutp03e2f45d92c1fce8a17c33a463881714d1~yHk4Sy05D2099420994epoutp03_
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 06:35:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190717063541epoutp03e2f45d92c1fce8a17c33a463881714d1~yHk4Sy05D2099420994epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563345341;
        bh=zhgJp2c1EEd5zsHzQMcfN8W5rw9BTdRu/SSkbuNu8x8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kMk6ctcFCYLNDAToKyAVWNpnv6yc6XNgyYyGLuEC7YVh3Bsu6XVVH0Ge3UqsGR11y
         OQEJcxn4i83vmYFQ+Bvy/TYYEeZtZA1EOGEa8mlFdLxQ+oHohMrQqbYzglOpJvcEbQ
         IEYYR4HWHauy1KqtGR7ThglVDNkthozuecPBR4no=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190717063540epcas1p14851c1bc431c0f8da57014affbf4f72f~yHk3w-Ued0307803078epcas1p1e;
        Wed, 17 Jul 2019 06:35:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45pSFQ4LLWzMqYkc; Wed, 17 Jul
        2019 06:35:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.8E.04088.AB1CE2D5; Wed, 17 Jul 2019 15:35:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190717063537epcas1p44d32e5af3318f4b9d197f7be657c72e4~yHk1IEBvU1593015930epcas1p4t;
        Wed, 17 Jul 2019 06:35:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190717063537epsmtrp14c938f7baf65c4d1b3ab90a270966475~yHk1HQs_c0166501665epsmtrp19;
        Wed, 17 Jul 2019 06:35:37 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-4b-5d2ec1ba2bf7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.CF.03706.9B1CE2D5; Wed, 17 Jul 2019 15:35:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190717063537epsmtip1112b8079667f54e0015e327883f5d903~yHk07EKR90815208152epsmtip13;
        Wed, 17 Jul 2019 06:35:37 +0000 (GMT)
Subject: Re: [PATCH v4 03/24] PM / devfreq: tegra30: Handle possible
 round-rate error
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <faf0f014-71e6-ace9-391f-8b0080d94dc6@samsung.com>
Date:   Wed, 17 Jul 2019 15:38:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e9fd7f68-8ad1-058f-7c87-ccd280ba0b0e@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm85ydTWn1NbPe9qPsdAEVdUedncpJUcmgfhgR3RA76UHF7Wzt
        zNJuWAtTU7sHHc0iu5hZmVnMkVhzkBndnFEURmV0R6lcaUW17Rj57/me53mv36siNE2UVpUn
        2HmbwJloKoy81hEVH+u6GZehc/RNZ89/7kPsLukkyd7d+UnJel01FPu10oPYskGJYp/tqKfY
        YVctyVZd6KbmhxqdvaeQsVXqVRorHf2UsaqlARm/Nk9JV6zJT8nluWzeFskLWZbsPCHHQC9Z
        nrkwU5+sY2KZOexsOlLgzLyBXrQ0PTYtz+RviI7cyJkK/FQ6J4p0fGqKzVJg5yNzLaLdQPPW
        bJN1jjVO5MxigZATl2Uxz2V0ugS937guP/d+hZOw9oQXln55SxSjz+PKUagKcBL0+M4oylGY
        SoOdCI6UeBUBQYO/IHh4YJssfEPgcV0L+RfR19mllIU2BDs7/1DyYwBB04OHVMAVjlfC0OXD
        QWEC/o2gbNgRFAi8GjpazwdTUTga2t89CfLj8DR4NNSHAliNU6H+5aNgHySeCSeltiAfgVdB
        l6eWlD3j4fbR10Ecig1QNVAzkn8SPH19PETGU8FxtZoINAHYoYTHwxeV8gyL4NXV65SMw+HD
        rZYRXgvv95aM4C1w7raHkoNLEbS0P1DIQiK0nz7or6DyV4iCS654mZ4GrT+PIbnwWOj3VSgC
        FsBqKC3RyJbp4H3RO7LGyVC3u4zah2hp1DjSqBGkUSNI/4udQGQDmshbRXMOLzJWZvR3N6Pg
        tUbrnejQvaVuhFWIHqM2dsRmaBTcRrHI7EagIugJaoMvJkOjzuaKNvM2S6atwMSLbqT3b3s/
        oY3IsvhvX7BnMvqExMRENolJ1jMMPUld+ysqQ4NzODufz/NW3vYvLkQVqi1Gs3Vba84kdSUd
        N857c0q4s2LQkPfRmrrpcD89Y+6COz5n41nJ8SPLq21Yk/b0e92yPc+FWZ6iwc7mAfJW8yac
        pu7esGyo9YSxd+2YlHdkRaN3e1FI9fyt64nGxS/Kfe4bV2KSb7LF7sL6BNeryuSfuidp3i1/
        xtdNVe9afbGwJCKsjSbFXI6JJmwi9xfKQMYBwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO7Og3qxBic2GFus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlnO/ZwVxwRbii49Nz5gbGj/xdjJwcEgImEo9P
        nGIHsYUEdjNKHLpoCxGXlJh28ShzFyMHkC0scfhwcRcjF1DJW0aJY2s7mEFqhAXCJX5snMoG
        khARaGKS2NR7AWwQs0CkRM/cLWwQHbOZJO4f+s4EkmAT0JLY/+IGG4jNL6AocfXHY0YQm1fA
        TmLFw6usIDaLgKrEoll7weKiAhESk67tZIGoEZQ4OfMJmM0pYCvR934OG8QydYk/8y4xQ9ji
        EreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5x
        aV66XnJ+7iZGcIxpae5gvLwk/hCjAAejEg/vhwO6sUKsiWXFlbmHGCU4mJVEeG2/ascK8aYk
        VlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDihcX+QeMRVw/ie
        Gw+v8t488bRS/06+wrnS6TpHG9X/+99UTZj7mjM/gfVa76KLT6cYrJRd4ir/1yX1gu1PBka+
        3bs4T318asK4JCTF7cUv65jzZlMe+7WwXAj+mT+t9earJ1sfLcir3vpnQpPW22gBiV2T3LRy
        TlzQDAwsf62uEi0uxPF/xR4lluKMREMt5qLiRACFiLzdrQIAAA==
X-CMS-MailID: 20190717063537epcas1p44d32e5af3318f4b9d197f7be657c72e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223726epcas4p1790944443c61b34e6c8dd4d64200a2a2
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223726epcas4p1790944443c61b34e6c8dd4d64200a2a2@epcas4p1.samsung.com>
        <20190707223303.6755-4-digetx@gmail.com>
        <f28470ca-93dc-cdf9-b008-54c7b50cfd83@samsung.com>
        <e9fd7f68-8ad1-058f-7c87-ccd280ba0b0e@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 16. 오후 10:09, Dmitry Osipenko wrote:
> 16.07.2019 14:50, Chanwoo Choi пишет:
>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>> The EMC clock rate rounding technically could fail, hence let's handle
>>> the error cases properly.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>> index 5e2b133babdd..5e606ae3f238 100644
>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>> @@ -592,8 +592,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  	struct tegra_devfreq_device *dev;
>>>  	struct tegra_devfreq *tegra;
>>>  	struct devfreq *devfreq;
>>> -	unsigned long rate;
>>>  	unsigned int i;
>>> +	long rate;
>>>  	int err;
>>>  
>>>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>>> @@ -650,8 +650,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  
>>>  	reset_control_deassert(tegra->reset);
>>>  
>>> -	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
>>> +	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>> +	if (rate < 0) {
>>> +		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>> +		return rate;
>>> +	}
>>> +
>>>  	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>>> +	tegra->max_freq = rate / KHZ;
>>>  
>>>  	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
>>>  		dev = tegra->devices + i;
>>> @@ -662,6 +668,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>>>  		rate = clk_round_rate(tegra->emc_clock, rate);
>>>  
>>
>> Please remove unneeded blank line.
> 
> I can remove it, but it was added specifically to ease reading of the code.
> 
>>> +		if (rate < 0) {
>>> +			dev_err(&pdev->dev,
>>> +				"Failed to round clock rate: %ld\n", rate);
>>> +			err = rate;
>>> +			goto remove_opps;
>>> +		}
>>
>> Also, this patch doesn't contain code which restore the previous
>> tegra->cur_freq/max_freq when error happen.
> 
> The error here results in abortion of the driver's probing, hence
> nothing need to be restored in that case because nothing was changed at
> this point yet.
> 
> 

OK.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
