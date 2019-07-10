Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613CD6453F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfGJKmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 06:42:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39853 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfGJKmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 06:42:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190710104222euoutp0199f17883e1e246c6991ca719efdabc85~wBbRexOdd1907719077euoutp01a
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 10:42:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190710104222euoutp0199f17883e1e246c6991ca719efdabc85~wBbRexOdd1907719077euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562755342;
        bh=2z2ahGjFwmsI9ql24fx+1WAqXfGQrrX50RO4rMZBCWA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HADQMatBzghu6dlsWIkf14BR1hIdEOiTwCSSL6gTeUkAj8Q7wHsGY2jpROOsd1pr8
         Gd9arv/r2AJFaqxMlVywRSWO2JRlnAF1GHpNJYTutqJJYa0dvTUc870TL8CeD6PbdY
         +JbDp1wLsjjE0lX2O8rhn9ZD3jhx3R0oW/Vo1jmg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190710104222eucas1p26e7c6acfd7999bd7c42b87b728a5db85~wBbQsSco01409914099eucas1p2z;
        Wed, 10 Jul 2019 10:42:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D2.C7.04298.D01C52D5; Wed, 10
        Jul 2019 11:42:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190710104221eucas1p25c30e9e03691a1a60eda63da68c57082~wBbP13_Mx1214512145eucas1p2j;
        Wed, 10 Jul 2019 10:42:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190710104220eusmtrp27c7b82ebdf031e1d3f29ce02c1ee756e~wBbPnasK20975709757eusmtrp2n;
        Wed, 10 Jul 2019 10:42:20 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-82-5d25c10dfbd9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.2B.04140.C01C52D5; Wed, 10
        Jul 2019 11:42:20 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190710104220eusmtip27436b226a92c0312fb8b5037b9811c80~wBbO2UPw_2745627456eusmtip2R;
        Wed, 10 Jul 2019 10:42:20 +0000 (GMT)
Subject: Re: [PATCH 1/3] opp: core: add regulators enable and disable
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Message-ID: <2f02b5bb-6258-754d-d2d2-bd73e34b0dbc@partner.samsung.com>
Date:   Wed, 10 Jul 2019 12:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3d6eacb8-ed8d-d4ac-1c36-6224ab88a5dc@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX8P9/t182vffml9VsZ28hTKU/M1ZiwPv2GG2Ihw9FOmO+2u
        PP5RkYeuCTVD2l2GZS0Pd0W0GHXrRCTH3clTdOShPB2TmeLux/Tf+/v+vD7fz+e9fXhafMNG
        8Bv0GbJBr03TqNTMpYYfd8cIN4YmjS0tHU+sR8+zxP21gyUW+12WHGh/T5Pm5gscubOzkyO2
        dhdLnDUlKuLbb0fkaPM1ipy1P+XIaXcLRR7nnFGRzu47FNl91c6RHpeVIdZvEqlsa1BNF6UK
        cwWSbOV5KumJq1YlVZ7KkgqqypHk8FRTks82aCGXqJ6aLKdt2CwbYqetUacWFu2i083C1o5b
        HiYbfVSbUBAPeCIcb+xmTUjNi/gMgmcXnYzy+IrgmHsf8lMi9iH47hzyr8P9NJ9WoDIEnS9+
        /W3vQvDr0GHOT4XiWfDQUkb7tQpPgpfVTZQJ8fwAHA1vH8l+nsY/GLjgtAZ4Ac8Gd05VYBqD
        h4L3emdAh+FlcMtuZhQmBBqPeRn/P0F4DrT9XOS3aRwOrV4LpejBUN1VElgO8GEeKnp8KmXr
        mfDZXUspOhTeOao4RQ+E3iuWv/4WeHWigFOacxG07f3MKIUpUO9oYf2DaTwSztfEKvYMaM+r
        D+QCHAyerhBlh2AovHSEVmwB9u0RFXoMmHubWEVHgqn3HHsQaYr7BCvuk6a4T5ri/3NLEVOO
        wuVMoy5FNo7Ty1tijFqdMVOfErNuk86G/tzf7R7Hl8vo2/21dQjzSNNfgNyoJJHVbjZu09Uh
        4GnNAOHanCFJopCs3bZdNmxabchMk411KJJnNOHCjn5tK0Scos2QN8pyumz4V6X4oIhsFHdv
        mK8g3jX65pcl3eDcuIK5P8Ib+kmMTmgevmdeZt2jCaZVqfFlCV4+5/XiUXOXBp9cOCg/7M2C
        lMLW+ZasJx+m7hitr8l4OzzKZs13kbyHHjxZq5vXQy0vwJDY/8bJ2gQP9yxR2Ll+5aeYNMPz
        SjbqXWmrWSopehAS5yhqmlWlYYyp2nHRtMGo/Q2LmXf4ewMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xe7o8B1VjDaYdM7HYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxcavHhabHxxjcxDyWDNvDaPHplWdbB53ru1h89i8pN6j
        b8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXMWlyM3PBPN6K56dusDQwvufqYuTkkBAwkbh+t5u5i5GLQ0hgKaNEQ2cX
        K0RCWqLx9GomCFtY4s+1LjaIoteMEr9OPwFLCAu4Slydv5wZxGYTMJd4tP0MUJyDQ0RAS+Ll
        zVSQemaB3ywS+xeeZwOpERLYzyTxZ682iM0r4CZxvXELI4jNIqAq8eTAGzBbVCBCYtK1nSwQ
        NYISJ2c+YQGZySngLvHgdyBImFlAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpHsWkpZZ
        SFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzDitx37uWUHY9e74EOMAhyMSjy8
        Ei0qsUKsiWXFlbmHGCU4mJVEePe5K8cK8aYkVlalFuXHF5XmpBYfYjQF+m0is5Rocj4wGeWV
        xBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBMmPf/8jMeBm/nzWf2
        ZgW/+7HgPg/vVY/s5izRxz2X5ZbVLaupfZ735u9TWR3LtrkxuT+OTZgSy3ntsbUPv0+B0KmL
        wg7q7x+7H7D2rRMU+zW3b3m3gaPx9IUvI1MOOa7NmH5Ki0XXJrx7ubScTE9JWfBUE61Ol0ma
        eY7nSq3bGyyEFVbplCqxFGckGmoxFxUnAgCayn5xDgMAAA==
X-CMS-MailID: 20190710104221eucas1p25c30e9e03691a1a60eda63da68c57082
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190708141159eucas1p1751506975ff96a436e14940916623722
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190708141159eucas1p1751506975ff96a436e14940916623722
References: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
        <CGME20190708141159eucas1p1751506975ff96a436e14940916623722@eucas1p1.samsung.com>
        <20190708141140.24379-2-k.konieczny@partner.samsung.com>
        <20190709054014.o3g4e6gbovrq3vvn@vireshk-i7>
        <3d6eacb8-ed8d-d4ac-1c36-6224ab88a5dc@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10.07.2019 12:16, Kamil Konieczny wrote:
> 
> 
> On 09.07.2019 07:40, Viresh Kumar wrote:
>> On 08-07-19, 16:11, k.konieczny@partner.samsung.com wrote:
>>> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>
>>> Add enable regulators to dev_pm_opp_set_regulators() and disable
>>> regulators to dev_pm_opp_put_regulators(). This prepares for
>>> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
>>>
>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>> ---
>>>  drivers/opp/core.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>> index 0e7703fe733f..947cac452854 100644
>>> --- a/drivers/opp/core.c
>>> +++ b/drivers/opp/core.c
>>> @@ -1580,8 +1580,19 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>>>  	if (ret)
>>>  		goto free_regulators;
>>>  
>>> +	for (i = 0; i < opp_table->regulator_count; i++) {
>>> +		ret = regulator_enable(opp_table->regulators[i]);
>>> +		if (ret < 0)
>>> +			goto disable;
>>> +	}
>>
>> I am wondering on why is this really required as this isn't done for
>> any other platform, probably because the regulators are enabled by
>> bootloader and are always on.
> 
> It was not enabled for historical reasons, from design point regualtors
> should be enabled before use.
 
On Exynos platform devfreq driver (exynos-bus) always enabled them,
so I wanted to preserve the current behaviour.

I've also checked the change with cpufreq-dt driver and it doesn't cause
issues.

Do you find this change acceptable?


-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

