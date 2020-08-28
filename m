Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78521255296
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgH1Bfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 21:35:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37049 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgH1Bfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 21:35:34 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200828013529epoutp0488eecd021502c5d267f444e9d710e95d~vSrQN-FN11156811568epoutp04M
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 01:35:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200828013529epoutp0488eecd021502c5d267f444e9d710e95d~vSrQN-FN11156811568epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598578529;
        bh=mfZS9t3mm4EcSIakzUimqKpFxitij5KZmxwTrUCgxhc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u7auesJfbgAw2m+bpWAjU7aJ0vNeEXVLoQODJgIbfdZYitK/9443Vm9mvSgHDpS60
         Tp0jhxn1pZayhKfqPXBXIP8hDz91LZkusCei/90IVBw4CidlBjnRTLtQISPwTWuh49
         6TkIQDX/4v6le91qnI3r+yrFn5VOXyrpuQc3us5g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200828013529epcas1p47231fba0fb8e3486082f079f17624411~vSrPXxycJ3008030080epcas1p4J;
        Fri, 28 Aug 2020 01:35:29 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Bd2Gh6nN0zMqYmD; Fri, 28 Aug
        2020 01:35:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.BE.29173.85F584F5; Fri, 28 Aug 2020 10:35:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200828013520epcas1p2bc32bd495a6427a36bc7e016dea98e27~vSrHIUnUo0309303093epcas1p2z;
        Fri, 28 Aug 2020 01:35:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200828013520epsmtrp1aae0b48885e40c8b76c3a48da1087bfe~vSrHHRFUJ0208202082epsmtrp1S;
        Fri, 28 Aug 2020 01:35:20 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-02-5f485f584a00
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.F2.08382.75F584F5; Fri, 28 Aug 2020 10:35:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200828013519epsmtip2cb4c7fb54f955a09e82cac16c65c1415~vSrG0NQaN0625906259epsmtip2I;
        Fri, 28 Aug 2020 01:35:19 +0000 (GMT)
Subject: Re: [PATCH v5 13/36] PM / devfreq: tegra30: Use MC timings for
 building OPP table
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2a255211-5426-d78f-d266-cdb958f4c658@samsung.com>
Date:   Fri, 28 Aug 2020 10:47:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1de8aa41-8001-cf46-026c-b00f8df0b9a3@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmnm5EvEe8QdsSI4t3n56yWsw/co7V
        YvXHx4wWV76+Z7OYvncTm0XLrEUsFmeb3rBbXN41h83ic+8RRovOL7PYLC6ecrW43biCzWLS
        2qmMFq17j7Bb/Lu2kcXi5655LA4CHu9vtLJ77Jx1l93j0rk/zB6bVnWyedy5tofN4373cSaP
        3uZ3bB59W1YxenzeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeY
        m2qr5OIToOuWmQP0hpJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0
        L10vOT/XytDAwMgUqDAhO2Nx4ySmgvN8FR/udrE2ML7i7mLk5JAQMJFoe7CftYuRi0NIYAej
        xMMt/UwgCSGBT4wSc7ZoQCS+MUq8/tPBDNNxccN0RojEXkaJ9ncXmSGc94wSTQv/sINUCQvE
        SJyZt5EdJCEicIRZYnXncUaQBLPADEaJO3uUQWw2AS2J/S9usIHY/AKKEld/PAar4RWwk5j8
        4xtYnEVAVeLa28tgN4kKhEmc3NYCVSMocXLmExYQm1PAVmLd/jUsEPPFJW49mc8EYctLNG+d
        DXadhMB/Dompp38DNXMAOS4SGz87Q7wjLPHq+BZ2CFtK4mV/G5RdLbHy5BE2iN4ORokt+y+w
        QiSMJfYvncwEModZQFNi/S59iLCixM7fc6F+5JN497WHFWIVr0RHmxBEibLE5Qd3mSBsSYnF
        7Z1sExiVZiH5ZhaSD2Yh+WAWwrIFjCyrGMVSC4pz01OLDQuMkWN7EyM4iWuZ72Cc9vaD3iFG
        Jg7GQ4wSHMxKIryvj7rHC/GmJFZWpRblxxeV5qQWH2I0BYbvRGYp0eR8YB7JK4k3NDUyNja2
        MDE0MzU0VBLnfXhLIV5IID2xJDU7NbUgtQimj4mDU6qByYib2++EtvOLZX+/Vcxcq7R3blRs
        I2vBnh2Zq6wFVLoSQ5O/CU+dsePmukmeb0NXrZQJirqRn1NouVb91d8ff4Imq9xgvTulzmLR
        BEHlHbJvL7VZr4x737P4+eNglcSPAd8WMDaqGR05/3d1G/8/foZGl2T7+Xq1SbIzg00nqUgu
        4nqeu/BipNfVCY92REqvnZR2UjOt8q7JXZZn/7fJMxREvln26s2WaKUEv0lme57KpHzOTir1
        VCmsKZ0jd93GYMHVfblicmGGcmdSJk9OTdYJC+WV0J6TxZgWIdJ1bXa4q/7Ut0pzu9ND77L4
        9u3Z5J2hImw46Yqhm8MEqcOma/gqWyU3M60wrzeK+HNIiaU4I9FQi7moOBEAfmno22sEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSvG5EvEe8wZlOJot3n56yWsw/co7V
        YvXHx4wWV76+Z7OYvncTm0XLrEUsFmeb3rBbXN41h83ic+8RRovOL7PYLC6ecrW43biCzWLS
        2qmMFq17j7Bb/Lu2kcXi5655LA4CHu9vtLJ77Jx1l93j0rk/zB6bVnWyedy5tofN4373cSaP
        3uZ3bB59W1YxenzeJBfAGcVlk5Kak1mWWqRvl8CVsbhxElPBeb6KD3e7WBsYX3F3MXJySAiY
        SFzcMJ2xi5GLQ0hgN6PE9u3bmSESkhLTLh4FsjmAbGGJw4eLIWreMkpM2PkIrEZYIEbizLyN
        7CAJEYFjzBKbTp9mAnGYBWYwSvzZAJEREpjDJHF0zjw2kBY2AS2J/S9ugNn8AooSV388ZgSx
        eQXsJCb/+AYWZxFQlbj29jITiC0qECaxc8ljJogaQYmTM5+wgNicArYS6/avAbOZBdQl/sy7
        xAxhi0vcejKfCcKWl2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBYZ5qeV6
        xYm5xaV56XrJ+bmbGMExraW5g3H7qg96hxiZOBgPMUpwMCuJ8L4+6h4vxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdG4cI4IYH0xJLU7NTUgtQimCwTB6dUA1Ob1I9zPnO5j8zS4d637czuA4wW
        5XOKmsoOZL5omCt+7cvyRcFzL5QavJoSuPdN3zn3rfl+zRKnGDh2xrk5lwtm/5itoSE26dJh
        xVLZ/kVHF3Vf2yehcTF93ZNpDblPr642Wv/g+PZHtxoD2atnJlhZzvEO/BUsm7rSgttBYVWn
        Y5tXfKPb+6tukrsqD1dttXmoUeBXMlFKdFPgvdbv6TN01wbdmVK5pUHPoXj3zGV3G/eukb/6
        TD/6jv7JX/rGD761TH4nfT+Pf0nN9MnCTEs7mF4Gnt6gvJHn6dzIyU47LzDI/uBtEFhrnL49
        b8VmWVvNY5/PtbZxvhRm1efxNP6tz1Qf9ftOu0RpSJuScbQSS3FGoqEWc1FxIgB9F1inWAMA
        AA==
X-CMS-MailID: 20200828013520epcas1p2bc32bd495a6427a36bc7e016dea98e27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200814000944epcas1p3dfd0104c5fa640695dfcd4949f6b1818
References: <20200814000621.8415-1-digetx@gmail.com>
        <CGME20200814000944epcas1p3dfd0104c5fa640695dfcd4949f6b1818@epcas1p3.samsung.com>
        <20200814000621.8415-14-digetx@gmail.com>
        <1b0d75fe-79af-70eb-8450-999a3bc72bac@samsung.com>
        <1de8aa41-8001-cf46-026c-b00f8df0b9a3@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/15/20 1:47 AM, Dmitry Osipenko wrote:
> 14.08.2020 05:02, Chanwoo Choi пишет:
>> Hi Dmitry,
>>
>> I add the minor comment. Except of some comments, it looks good to me.
> 
> Hello, Chanwoo! Thank you for the review!
> 
> ...
>>> +struct tegra_devfreq_soc_data {
>>> +	const char *mc_compatible;
>>> +};
>>> +
>>> +static const struct tegra_devfreq_soc_data tegra30_soc = {
>>> +	.mc_compatible = "nvidia,tegra30-mc",
>>> +};
>>> +
>>> +static const struct tegra_devfreq_soc_data tegra124_soc = {
>>> +	.mc_compatible = "nvidia,tegra124-mc",
>>> +};
> .
>>> +	soc_data = of_device_get_match_data(&pdev->dev);
>>
>> I think that better to check whether 'soc_data' is not NULL.
> 
> It's a quite common misconception among kernel developers that
> of_device_get_match_data() may "accidentally" return NULL, but it
> couldn't if every driver's of_match[] entry has a non-NULL .data field
> and because the OF-matching already happened at the driver's probe-time
> [1], which is the case of this driver.
> 
> [1] https://elixir.bootlin.com/linux/v5.8/source/drivers/of/device.c#L189
> 
> Hence the NULL-checking is unnecessary.
> 
> When I first encountered the of_device_get_match_data(), I was also
> thinking that adding the NULL-checks is a good idea, but later on
> somebody pointed out to me (maybe Thierry) that it's unnecessary to do.

OK. Thanks.

> 
>>> +
>>> +	mc = tegra_get_memory_controller(soc_data->mc_compatible);
>>> +	if (IS_ERR(mc))
>>> +		return PTR_ERR(mc);
>>
>> You better to add error log.
> 
> In practice we should get only -EPROBE_DEFER here ever. I'll consider
> adding the message in the next revision, at least just for consistency.

In order to handle -EPROBE_DEFER, recommend the using of dev_err_probe().

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
