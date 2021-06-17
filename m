Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C953AA9C9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 06:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhFQEKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 00:10:25 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21668 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhFQEKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 00:10:25 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210617040816epoutp03c681b7abe380e6ddfe6166a53f96e7bb~JQxSvZY1J0838108381epoutp03Z
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 04:08:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210617040816epoutp03c681b7abe380e6ddfe6166a53f96e7bb~JQxSvZY1J0838108381epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623902896;
        bh=Q8Fodmj38I8eNh20GrvEU/iWhFr21sMrbrfqSoPoRQI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MPPOGjKiT/hqRG7vZ/+slWxuM8NZFhyhUsQktNtuFNEyu2KKD2PBFFI4DSVqNgTXN
         B03621eX3NDyumYGAHC+VkSkQY2vfXuWUQ48/i+AoHqzvvTWP27XrsOdTdhzQSkxyn
         9SuEyogZk6NDVF5nZHtMrPcGSOgeRyzDWv+I0TGw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210617040816epcas1p2206de7c1166d6e29bd17e71ce1526ef7~JQxSYIbf51422314223epcas1p2R;
        Thu, 17 Jun 2021 04:08:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G57nn3998z4x9Q8; Thu, 17 Jun
        2021 04:08:13 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.64.09578.DAACAC06; Thu, 17 Jun 2021 13:08:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210617040812epcas1p22d31cb142f2cdcc497a236246f3b0a4b~JQxPMceXA1524715247epcas1p2j;
        Thu, 17 Jun 2021 04:08:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210617040812epsmtrp1e81987e92e5734a875239eb451d02a1b~JQxPLuTD10608006080epsmtrp1n;
        Thu, 17 Jun 2021 04:08:12 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-c2-60cacaadacfc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.E2.08637.CAACAC06; Thu, 17 Jun 2021 13:08:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210617040812epsmtip2324c6fcfac62356b81c3e685ef27d814~JQxO5yhIu1193511935epsmtip2E;
        Thu, 17 Jun 2021 04:08:12 +0000 (GMT)
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non
 genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9879b9c5-a5e6-425b-8184-868880f04f53@samsung.com>
Date:   Thu, 17 Jun 2021 13:27:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210617040027.vtqlhxqq7cwzeygg@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmru7aU6cSDOY+FLXYvv4Fq8WE1u3M
        Fpd3zWGz+Nx7hNHizY+zTBb/rm1ksdj41cNi84NjbA4cHrMbLrJ4bFrVyeZx59oeNo+Wk/tZ
        PI7f2M7k8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k
        /FwrQwMDI1OgwoTsjCe9agXLOCpebb3O2MB4m62LkZNDQsBE4tbtLUA2F4eQwA5GiYXN55kg
        nE+MEmvu32eEcL4xSpxde5cFpuXx4eUsEIm9jBJ7L8xkh3DeM0qsbdjJDFIlLBAgsXnlT6B2
        Dg4RAS2JlzdTQWqYBf4wSkz+ewZsEhtQfP+LG2CH8AsoSlz98ZgRxOYVsJOYdekeWJxFQFXi
        8c//YHFRgTCJk9taoGoEJU7OfAI2h1PAUmLS7qWsIDazgLjErSfzmSBseYntb+cwgyyWEFjK
        ITHl/WFmiBdcJLr/7GaFsIUlXh3fwg5hS0m87G+DsqslVp48wgbR3MEosWX/BagGY4n9Sycz
        gXzGLKApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGWuPzgLhOELSmxuL2TbQKj
        0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBIXJsb2IEp1Ut0x2ME99+0DvEyMTBeIhR
        goNZSYRXt/hEghBvSmJlVWpRfnxRaU5q8SFGU2AAT2SWEk3OByb2vJJ4Q1MjY2NjCxNDM1ND
        QyVx3p1shxKEBNITS1KzU1MLUotg+pg4OKUamLqzf2wr7TRpzWdOu1fVl6u4XU9gy4y1vrt3
        OC2arsX0mY23wH6+epeaYKe+zuKgN5c/7Zswa5vineq8aln1F00WFultG3Vkw9t2frwe+ZPF
        XEnFbu7dJxnzu3dJTBM58a3plf1b7Ve6E5wudZVc0RUJUNRXUj12q4TXs9xLepem3YNHwknX
        b0yK0pcvVl36zMNI7uWe0pdx1/k49uyM4HMXmT5p5v1b9fsfiMvGJr/Ozfo1q/6ygWNaJKud
        eqtDTGmXysuEWQULa7JjTh2f/ov5GjO3wSdPi1sCvPYJe4ptJnsszJl158P8+PwppkEGe26n
        3EiyELgfk5dkbD4neocr79sXc/qYju+0se1WYinOSDTUYi4qTgQAt/FJ6jQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXnfNqVMJBktbDC22r3/BajGhdTuz
        xeVdc9gsPvceYbR48+Msk8W/axtZLDZ+9bDY/OAYmwOHx+yGiywem1Z1snncubaHzaPl5H4W
        j+M3tjN5fN4kF8AWxWWTkpqTWZZapG+XwJXxpFetYBlHxaut1xkbGG+zdTFyckgImEg8Pryc
        BcQWEtjNKNE/yRsiLikx7eJR5i5GDiBbWOLw4eIuRi6gkreMEtu2vWYGqREW8JN4NHcyWI2I
        gJbEy5upIDXMAv8YJd5N3M0G0fCSWWJn73uwBjagov0vboAt5hdQlLj64zEjiM0rYCcx69I9
        sDiLgKrE45//weKiAmESO5c8ZoKoEZQ4OfMJ2KGcApYSk3YvZQWxmQXUJf7Mu8QMYYtL3Hoy
        nwnClpfY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1
        kvNzNzGCo0tLcwfj9lUf9A4xMnEwHmKU4GBWEuHVLT6RIMSbklhZlVqUH19UmpNafIhRmoNF
        SZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTQy/7Qp+gZREfN06r/ca90swtcq5P7q0/OnMF
        905Y9PJD/sLcZxxhDOyTmVdfKXDaz/x05UL2P2nTJ3CJ5u1NuHCz966+0icHjdviS48HB90L
        Cdfa2qrJwnW4P8E3YYP9qh89nfUrmouWlRV5VgTy75ac1F6S1GW5ovNGTFGndXP6oeCcSPmP
        N/t/i7CYejjsWRAQ+mH6hn2r2GyfLPM6dLrk5epwl63JPjIvHSts6rTfRQbs3CLkt3Gv/uNl
        PQV5Jnc3J+TM+jXHydhAtPHozr4vWy70z4ti26J9c4fAM9+08kN96gd3r7hbaXg2RGSvbdiZ
        B/8YHtttL1z7Yq9b0s6ULsck3tUzbZ6dYJZWYinOSDTUYi4qTgQA5ud9fh0DAAA=
X-CMS-MailID: 20210617040812epcas1p22d31cb142f2cdcc497a236246f3b0a4b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc
References: <20210616053335.4181780-1-hsinyi@chromium.org>
        <CGME20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc@epcas1p1.samsung.com>
        <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
        <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
        <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
        <742b2623-e8ff-db1f-9168-bdbde98110dd@samsung.com>
        <20210617033351.44pxdpjicm62byuh@vireshk-i7>
        <c40f535b-3075-62eb-3b82-837ad13d67d4@samsung.com>
        <20210617040027.vtqlhxqq7cwzeygg@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/17/21 1:00 PM, Viresh Kumar wrote:
> On 17-06-21, 13:09, Chanwoo Choi wrote:
>> On 6/17/21 12:33 PM, Viresh Kumar wrote:
>>> On 17-06-21, 10:13, Chanwoo Choi wrote:
>>>> The devfreq driver(exynos-bus.c) has used the dev_pm_opp_set_rate()
>>>> and used the passive governor without the required-opp property.
>>>
>>> Which is fine.
>>>
>>>> I have a plan to use the required-opp property
>>>> between devfreq drivers (exynos-bus.c) with dev_pm_opp_set_rate().
>>>>
>>>> I'll support them on later if this approach doesn't break the any
>>>> rule of required-opp property.
>>>
>>> You will be required to make some changes in core for that I am
>>> afraid. It won't work automatically.
>>
>> Do you think that better to use clk_enable/regulator_enable directly
>> instead of dev_pm_opp_set_rate() for using required-opp property?
> 
> No. All I am saying is that the OPP core won't work for your use case
> today and may need some updates.

OK. I'll update them for this case.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
