Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F105937552
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfFFNfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 09:35:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52651 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfFFNfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 09:35:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190606133522euoutp01b48ddf82993d4ff08b568af312a578ac~ln2mv6Shj1755817558euoutp01U
        for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2019 13:35:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190606133522euoutp01b48ddf82993d4ff08b568af312a578ac~ln2mv6Shj1755817558euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559828122;
        bh=3M/G3KWFVRvfQVQ8wa9cPwyi0fym0xnczXtfcnAQRG0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cfnogv/SUNySPtfO1s6wo4wPMFrpvsEWHiOt0LzzzeZk2jAfQANxzICiJJYIDGthu
         4OuvVJSsRpM4032f9RCnZGWZsn62MWYJlbSvCF2bMLKaeJILjGDdDNWD2XhgYls51+
         O7Anr7Y78KZRqfVPSSO5iO/nj6ZeEcCXdj+TTua8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606133521eucas1p2c06084f280b0af1f5474a0830a049122~ln2mAzf9n1223512235eucas1p2r;
        Thu,  6 Jun 2019 13:35:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 76.19.04325.99619FC5; Thu,  6
        Jun 2019 14:35:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606133520eucas1p14b8720349f70eceba874d3ff204ef08f~ln2lJiHCi1256112561eucas1p1P;
        Thu,  6 Jun 2019 13:35:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190606133520eusmtrp1d5ff5cb7f1790f6052802ef3631b0a99~ln2k52IWp2328723287eusmtrp1D;
        Thu,  6 Jun 2019 13:35:20 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-08-5cf916994751
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 46.6B.04140.89619FC5; Thu,  6
        Jun 2019 14:35:20 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190606133519eusmtip1ab9099e80e7fcadbbf9caeb0b6f4d20b~ln2kMtXz02303323033eusmtip17;
        Thu,  6 Jun 2019 13:35:19 +0000 (GMT)
Subject: Re: [PATCH v8 08/13] drivers: memory: add DMC driver for Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <20a5e3a9-3ac9-2bb6-2c26-fab02d92c2b4@partner.samsung.com>
Date:   Thu, 6 Jun 2019 15:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfiFCp52rYtOBk5mfHfLLA=VtBpakAdUB__UcVCqbma-g@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuzszO6O0y+xYerCHtPQhA60s8EYlBiKDGuSHooeQU04muZvu
        qGUWrdnTtIeW5apsQZKsiWmSupHRalm+TUvTXuRSZBqIr7Y0cpwiv/3u+f/PPed/uQzBDVLe
        TJwxSTQZhXi92p188MzV5pfv6Ypa3VdO44ob5RTuGftCYWtDG4VLRwYQzm0qUuGWCwZ8aeAb
        gdvb79G49eQQjbvshWo8mt2A8I32OhUua3hH4/70EjWuHzpL4cfdYbj/lxZPPP+Egjl+YjyH
        5AvMnSRfa3lH85W282o+O+O7mr9YZUP8/eY0frRy6VZml/vGGDE+LkU0rQqKdj+Qa/9IJ7To
        jjjejhJm9FSTidwYYNfB7dIPKBO5MxxbgiCvtxjJAseOIbhwapkijCJoqetWZSJmtqNjiFTq
        dxAM3C+glMMwgofvX6vkbg82AvLTMyiZF7C+0DM9OWsi2AoSqmvstHyTmvWHGlui7NGwofDi
        /BVCZpJdDp8vv5rdYiG7A8ZqK5Hi0cGLfCcpsxsbCc+aOmmZCdYL+pxWlcI+UD1cSMizgC1i
        oMTyFSk5Q+CH1Uoo7AGDjVW0wouhOTeLVFgCc/atv/5jMHCp6K9nA9Q3dlLyzsRMmHL7KqW8
        GVw2M1IeRQu9wzplBS3kPLhOKGUNnDvDKe4VUJXVoVLYE+7czaMvI71lTjDLnDCWOWEs/+fe
        RKQNeYnJkiFWlNYaxcP+kmCQko2x/vsOGSrRzA9s/t04XoPqpvY6EMsg/XwNT7uiOEpIkVIN
        DgQMoV+gSen4EcVpYoTUo6Lp0B5TcrwoOdAihtR7adLmfdzNsbFCknhQFBNE0z9Vxbh5m1Fr
        QF6oJoaoCS7OvGalerc7C47mvYz5Gf5Iu2+yLai7u+9ttHZJ4P75ub6tx3Om4kO9Q5aGvhHC
        KGfG3kEfEz6blePaovXpH+F61k8mBEaGb7p6ItF5LajLR4qIDAjRPXZ4Rq0o2xZx2m9aKH3a
        OoV3BnsvWq22G4tjnyT+7H+ZqielA8KalYRJEv4Asha4QH0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7ozxH7GGJxbwGOxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlTN71gL3gjGDFoTufmRsYj/J2MXJwSAiYSFx4w9LFyMkhJLCUUWLt
        kVQQW0JATGLSvu3sELawxJ9rXWwQNa8ZJX62i4HYwgI+EjMbm1lBbBEBTYnrf78D2VwczAIb
        WSQuvuplAnGEBKYwS1y5tJ4dZBmbgJ7EjlWFIA28Am4SJzsnMoPYLAIqEs8mXGUEsUUFIiRm
        72pggagRlDg58wmYzSkQKHHs1EWwg5gFzCTmbX7IDGGLS9x6Mp8JwpaX2P52DvMERqFZSNpn
        IWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKjftuxn1t2MHa9Cz7EKMDB
        qMTDO4PpZ4wQa2JZcWXuIUYJDmYlEd6yCz9ihHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkf
        mJDySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwugQyXMl+22jQ
        dGPujKs+ntPWnZ4vGxG5RenBesOrk7bU9VmWrVrZWFon+IJt3w32r16fVnDOn5dsunv/+9/i
        PNGHLddfYl2/Zo7diTMsp75vnHvjd/zDrfLtrfe4dvUaXIpedvrD+z0n+Ddkv/znf6V99r0F
        SkcTyp+w779qx/W7KKL6FDdHQZoSS3FGoqEWc1FxIgCfs1vCEAMAAA==
X-CMS-MailID: 20190606133520eucas1p14b8720349f70eceba874d3ff204ef08f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165435eucas1p2fa32f4583f396fdce443b6943ac180d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165435eucas1p2fa32f4583f396fdce443b6943ac180d3
References: <CGME20190605165435eucas1p2fa32f4583f396fdce443b6943ac180d3@eucas1p2.samsung.com>
        <20190605165410.14606-1-l.luba@partner.samsung.com>
        <20190605165410.14606-9-l.luba@partner.samsung.com>
        <CAJKOXPfKbWpx9AapOudDyEZjDpgtMX-aHPQHRivuVNKaap8EQg@mail.gmail.com>
        <d5758d38-c0e5-1732-1407-91d602ae5500@partner.samsung.com>
        <CAJKOXPfiFCp52rYtOBk5mfHfLLA=VtBpakAdUB__UcVCqbma-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/6/19 1:45 PM, Krzysztof Kozlowski wrote:
> On Thu, 6 Jun 2019 at 12:38, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>> Hi Krzysztof,
>>>> +/**
>>>> + * exynos5_dmc_init_clks() - Initialize clocks needed for DMC operation.
>>>> + * @dmc:       DMC structure containing needed fields
>>>> + *
>>>> + * Get the needed clocks defined in DT device, enable and set the right parents.
>>>> + * Read current frequency and initialize the initial rate for governor.
>>>> + */
>>>> +static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
>>>> +{
>>>> +       int ret;
>>>> +       unsigned long target_volt = 0;
>>>> +       unsigned long target_rate = 0;
>>>> +
>>>> +       dmc->fout_spll = devm_clk_get(dmc->dev, "fout_spll");
>>>> +       if (IS_ERR(dmc->fout_spll))
>>>> +               return PTR_ERR(dmc->fout_spll);
>>>> +
>>>> +       dmc->fout_bpll = devm_clk_get(dmc->dev, "fout_bpll");
>>>> +       if (IS_ERR(dmc->fout_bpll))
>>>> +               return PTR_ERR(dmc->fout_bpll);
>>>> +
>>>> +       dmc->mout_mclk_cdrex = devm_clk_get(dmc->dev, "mout_mclk_cdrex");
>>>> +       if (IS_ERR(dmc->mout_mclk_cdrex))
>>>> +               return PTR_ERR(dmc->mout_mclk_cdrex);
>>>
>>> You are not enabling this clock. It is divider so it is fine for him
>>> but what about its parents? How can you guarantee that parents are
>>> enabled?
>> It uses two parents in this configuration:
>> 1. 'mout_bpll' which is set by the bootloader and is a default mode
>> 2. 'mout_mx_mspll_ccore' which is used temporary as a 'bypass clock
>> source' only for the time when BPLL is changing it's settings
>>
>> Do you suggest to put a call:
>>
>> to make sure the parent is up and running?
>> OR just move the lines from the end of this function:
>>          clk_prepare_enable(dmc->fout_bpll);
>>          clk_prepare_enable(dmc->mout_bpll);
>> and add:
>>          ret = clk_set_parent(dmc->mout_mclk_cdrex, dmc->mout_bpll);
>> then call the clk_get_rate on 'mout_mclk_cdrex'
>>
> 
> Ah, It's my mistake. I missed that later you enable its new parent. It's fine.
OK, so I will leave it as is and just fix the other stuff that you've
mentioned.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
