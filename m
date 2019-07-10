Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9C6454B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGJKnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 06:43:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40233 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfGJKnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 06:43:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190710104340euoutp01da21e14decfa121a2e8e87d2792a98a2~wBcZqX_AJ2098820988euoutp01q
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 10:43:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190710104340euoutp01da21e14decfa121a2e8e87d2792a98a2~wBcZqX_AJ2098820988euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562755420;
        bh=DGGSStnE8hfpWYVCDu2TLFZ0Ng6S0e/fEz3/71WaMS4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PU3zUfUKbTxQGpP/eJNwFTYVWg9HGELEZYYT5xaLwXSXeS+iXV2Xsmrc4H2uW3M8z
         YzljColupHSUvCx0xto5+6flzm6Wng0nbJjGDv0Afrha2smRr25li6NbFW7RVi5Weh
         NPnAESVxcG7uCm7hSTzf04Cu7Rnjf6B5ar0fNy5E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190710104339eucas1p2b87acc4b58219affc082fce7b280b574~wBcY8NakG2721527215eucas1p25;
        Wed, 10 Jul 2019 10:43:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.33.04377.B51C52D5; Wed, 10
        Jul 2019 11:43:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190710104338eucas1p1d2047febe63064b119636f3d3937813e~wBcYMPbxF2192621926eucas1p1v;
        Wed, 10 Jul 2019 10:43:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190710104338eusmtrp2a14ee9863a89120a79e4597f45456a13~wBcYJi2Ty1066010660eusmtrp2D;
        Wed, 10 Jul 2019 10:43:38 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-63-5d25c15b8a28
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.4B.04140.A51C52D5; Wed, 10
        Jul 2019 11:43:38 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190710104338eusmtip23e52dc9119a4006f313b1f6cfaa72859~wBcXaYpTL2747527475eusmtip2h;
        Wed, 10 Jul 2019 10:43:37 +0000 (GMT)
Subject: Re: [PATCH 1/3] opp: core: add regulators enable and disable
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
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <1795603c-686f-dfb5-5982-c836b36dca9c@partner.samsung.com>
Date:   Wed, 10 Jul 2019 12:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709054014.o3g4e6gbovrq3vvn@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURjFu2+b59DIdVT80DamDCxNi5bbghS0zD9GRaAkU436MtExmefS
        AmVRlpPpmIE2hVNkqZNpLriVljppmktSaYvRoIYtaoZTJITW+JL878c55+OeA5enlUOsJx8V
        Gy/oY7UxKk7OVDZPdPqFNnhrAi52uZHSnBKW9NqHWGK2drIkY+ArTbq67stIx5lhGSkb6GHJ
        i9rrHBm/ZEUkp6ueIves72Xkdm83Rd6dLuDI8K8Oipyrs8rIZE8pQ0p/qEm5rZnbrFQX5RYh
        dZkllVP39Tzk1OV5p9TpFRakbnldRanHyxbsku2Tb4oQYqISBb1/4EH54Y6RFCrOLD/a2TfG
        JqNq3oCceMCrobiphDMgOa/EBQjumrNZh6HEdgTna/ZLxjiC/udp3MxF+61vtBTKRzCatVEK
        jSDorXsyHXLF2+CVOf9viOfd8DL4/EZwZGg8wcD9F6UyR4bD66C/qp1ysAJvh1/dhdO3DPaG
        vOxR5GB3HAJt1lxGyrhA69XBaXbC62H04s/ppjT2gLeDZkrihVA1cp2WimbyUJSxSOKtYHlw
        l5LYFb60VMgkngdTNeZ/ehJ8vJkucxQFfBaB7fx3RjI2QlNLN+sYQ2MfKKn1l+QtMJDaRDlk
        wM7wesRFquAMlyuzaUlWwIUUpZT2g9ypdlZiLzBMFbNGpDLNGmaaNcY0a4zp/7s3EGNBHkKC
        qIsUxFWxQtIKUasTE2IjV4Qf0ZWhv9/v2WSLvRrV/g5rRJhHqrkKOLtEo2S1ieIxXSMCnla5
        Kep3LNYoFRHaY8cF/ZED+oQYQWxEXjyj8lCcmGMLVeJIbbwQLQhxgn7GpXgnz2RE37TJXZBn
        in/4q0T6cZpzVdPSO0HBFuOn3aErzw2LvjH6Sbthc9AhYtuQNWH/EuyzNoc0vAwwPzJqAlvT
        MzyMXmGB/rq6vj1vPZMyi3Z+LdQaTYaTY21ON+zv90Ul7t2S8PQa2eWd5usX35P6I2RN3PxT
        hg/d0dlX3IfeLXdvG1Ix4mHtymW0XtT+AbSY9TZ6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xe7pRB1VjDb5u1bPYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxcavHhabHxxjcxDyWDNvDaPHplWdbB53ru1h89i8pN6j
        b8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXcfZtG1PBfK6Kc3c+sDYw7uDoYuTkkBAwkTiz+D1zFyMXh5DAUkaJiR1/
        WSES0hKNp1czQdjCEn+udbFBFL1mlDiyZwVYQljAVeLq/OVA3RwcIgJaEi9vpoLUMAv8ZpHY
        v/A8VEMTk8TuYwfZQBrYBMwlHm0/A9bMK+Am8ePiSrA4i4CqxJLp7xhBbFGBCIlJ13ayQNQI
        Spyc+QTM5hSwlHjX/Q3sOmYBdYk/8y4xQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZ
        haRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCo33bs55YdjF3vgg8xCnAwKvHwSrSo
        xAqxJpYVV+YeYpTgYFYS4d3nrhwrxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAhJRXEm9o
        amhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGx+rMsy2Qz1fxn99ncNxel
        vJxexMPtfOhiCfe3y1VPv2z/taMz7UH403N198sZWQ+WRXI0NkZ8aHep/n/jop97d/8vjh0p
        sV4lSjfZpFS6GDi/5iut8zvH9NqLv+7aj3SxI+Zv3wTvENmnkmbc/GzCdgXdO64WFmXTc2PU
        uVpEb2Rc/fF6gYoSS3FGoqEWc1FxIgDuwhf2EAMAAA==
X-CMS-MailID: 20190710104338eucas1p1d2047febe63064b119636f3d3937813e
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09.07.2019 07:40, Viresh Kumar wrote:
> On 08-07-19, 16:11, k.konieczny@partner.samsung.com wrote:
>> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>
>> Add enable regulators to dev_pm_opp_set_regulators() and disable
>> regulators to dev_pm_opp_put_regulators(). This prepares for
>> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>  drivers/opp/core.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 0e7703fe733f..947cac452854 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1580,8 +1580,19 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>>  	if (ret)
>>  		goto free_regulators;
>>  
>> +	for (i = 0; i < opp_table->regulator_count; i++) {
>> +		ret = regulator_enable(opp_table->regulators[i]);
>> +		if (ret < 0)
>> +			goto disable;
>> +	}
> 
> I am wondering on why is this really required as this isn't done for
> any other platform, probably because the regulators are enabled by
> bootloader and are always on.

It is not ABI break, it should work with existing DTBs

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

