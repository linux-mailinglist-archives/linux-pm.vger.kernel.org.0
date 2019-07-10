Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A606479A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfGJNwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 09:52:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52691 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfGJNwK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 09:52:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190710135208euoutp01ab770818f2926bf68c4cf058acab5c05~wEA9V_f5t3197131971euoutp01J
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 13:52:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190710135208euoutp01ab770818f2926bf68c4cf058acab5c05~wEA9V_f5t3197131971euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562766728;
        bh=bi+QQHJqP04uD+8PUqyDhDmLPS7ewuxGeL+v9hDW43c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XkDjrsQoRhYpbRBFf0mdiNpg334WtZe92Ste2Es0DVO/nkNlrn8UAREbPSI+3o4RO
         AEgR2PBc2QD0Js1S9NRE3KYpf1WnOuOu31mNQZXlGvFWJcRlaP7cNce4LR99q/j7FU
         ZG5XoUu2v3G0gHriVqFL8Px20Gu80nLv6EmOtEpM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190710135207eucas1p235be02737ffa0a20f8b784ed6eea3104~wEA8Mb-2g0520205202eucas1p2l;
        Wed, 10 Jul 2019 13:52:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B8.11.04298.78DE52D5; Wed, 10
        Jul 2019 14:52:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190710135206eucas1p1a8bb3868e3358ac992d3337ce291fbdb~wEA7dMCQM2743727437eucas1p1z;
        Wed, 10 Jul 2019 13:52:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190710135206eusmtrp115a884e0bda6f826981f7bb4f39154aa~wEA7O02i70752007520eusmtrp1x;
        Wed, 10 Jul 2019 13:52:06 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-f8-5d25ed878a38
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.D3.04140.68DE52D5; Wed, 10
        Jul 2019 14:52:06 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190710135205eusmtip1139c29f0c0309ada945ad5f5326d2267~wEA6hgMwP1936419364eusmtip1X;
        Wed, 10 Jul 2019 13:52:05 +0000 (GMT)
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
Message-ID: <96583e19-f838-efe2-bd75-2f66d1deb0e5@partner.samsung.com>
Date:   Wed, 10 Jul 2019 15:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1795603c-686f-dfb5-5982-c836b36dca9c@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+93Xrub0NhVPFkkLIYUysehHShSmjiCoxCjttdlFJZ2y+ciC
        zF7WMJUkKimnYGg+ci7R8BXobJUv1HxWaE0zH+ulUlZabtfI/z7nnO/5nfP9cVhSMk67slHK
        eF6llEdLGVuq6tlc+6Y0s/uxLdV1DrjiTjmN+2bGaKw1tNM40zRJ4o4OnQi3XZwSYb2pl8bd
        NfcYPH3DgPCdjgYClxneivCDvk4Cv04tYvDUjzYCX6k3iPBCbwWFK2Zl+PHwM2aXRFaaW4pk
        +uLrjOxNbx0je1yQIsuoLEYyY381IZvWr9svCrX1O8VHRyXyKq+dJ20jB373E3GFK8+0lFZR
        F1CJjQbZsMBthdrmdkKDbFkJV4RgvLKEEYIZBLk6EykE0wjuD2XQGsRaW7LrwoV8IYKe4nlK
        CMwIxmqrRJZ3HbkA6NEWkhZmuO3wvrqVsDQ7cZ4wPsBb9CQ3R4Guu8KqF3OB0Jw6TluY4twh
        U9fPWNiZOwwvDbmUoFkFL+6OWNmGCwLt/TKrhuRcYHBESwjsBtXme9atgbvFQvlcvUgwuge+
        D31eYkeYMFYu8VpoyU6nBE6C0fwMkdB8GcFw2telgi80GTut9knOA8prvIT0bjBdbyKEX7GH
        fvMqYQd7uFl1mxTSYrh2VSKoN0Hun1Za4DWg+fOIzkLSnGXOcpa5yVnmJuf/3DxEFSMXPkEd
        E8GrvZV80ma1PEadoIzYHB4bo0eLB9iyYPz2BM12KRoRxyKpnZhdPEYJLU9UJ8c0ImBJqZO4
        IWjDMYn4lDz5LK+KPaFKiObVjWgNS0ldxOdWDIdJuAh5PH+a5+N41b8qwdq4XkAK/w95P81R
        x2cO7jV5BE6l6kYLfvQO7Qv8Qkz5B2wLdVN5p3seSco0TibaX9S/a1BsfHIp2FXTvlOrqk8N
        CVu/L3ihwTG76fmOm7+j4j8eUtwdmZ/1tevyOW9KVLxSKCJTsi7dzlTmH0h6WHJ0Ps3NL311
        yKenv3x+wdj8oMNEcJGzlFJHyr09SZVa/hcyH+rzfAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7ptb1VjDU48lLLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxcavHhabHxxjcxDyWDNvDaPHplWdbB53ru1h89i8pN6j
        b8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXcfPPDaaC5dwVp9dsY2lgXM3ZxcjBISFgIjF5T3IXIxeHkMBSRoktG4+x
        djFyAsWlJRpPr2aCsIUl/lzrYoMoes0ocXVdPztIQljAVeLq/OXMIDabgLnEo+1nmECGigho
        Sby8mQpSzyzwm0Vi/8LzUM37mSTmrtgANpVXwE3iaONLsG0sAqoS/RtusIHYogIREpOu7WSB
        qBGUODnzCZjNKeAuMX/uWrAaZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRaBaS9llIWmYh
        aZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwJjfduznlh2MXe+CDzEKcDAq8fAG
        PFSNFWJNLCuuzD3EKMHBrCTCu89dOVaINyWxsiq1KD++qDQntfgQoynQcxOZpUST84HpKK8k
        3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+NN8S+PWxpE163iYDZW
        4GZk++cupXjvnM31gCNN1zRnWokc+i+trcd9cJ6xGedN2fPvMo5eSH7f/q8ha39A1i3Vi0/K
        XfYdvuHWvX6WZUJsXHRCyoGi1InvxMvPR6ttXNP2cDXrGU/do1z77xjWCbg5qG8/+2FuaNaX
        LbuaTmjwPA+x55CPnqfEUpyRaKjFXFScCAB2qey4DwMAAA==
X-CMS-MailID: 20190710135206eucas1p1a8bb3868e3358ac992d3337ce291fbdb
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
        <1795603c-686f-dfb5-5982-c836b36dca9c@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 10.07.2019 12:43, Kamil Konieczny wrote:
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
> It is not ABI break, it should work with existing DTBs

Sorry, this answer should go to question by Krzysztof

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

