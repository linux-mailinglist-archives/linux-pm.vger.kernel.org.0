Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02526F8FA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Sep 2020 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIRJKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Sep 2020 05:10:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:15031 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgIRJKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2020 05:10:39 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200918091035epoutp012e2f58e015ae7065e19d420229a43b81~11bmY3i-Q1918819188epoutp01e
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2020 09:10:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200918091035epoutp012e2f58e015ae7065e19d420229a43b81~11bmY3i-Q1918819188epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600420235;
        bh=9hEEharbFv8Fok59V6bIO/eYDO3oAd8HaEy7ef+bvEQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=md+fv0ZgsatUTE+i6hnjkpDcwD4L7P41+nhRacPI11V3h7XwV74+8LsqRFnc79zpl
         eIMKG4QLqXidIx+U3RP7qZ5HhsfcdjOQOfNUmlQyjS042kHeEz22AMrpHVCXcUX2A+
         UHTuPMkb/9iXz9jO59ELXsbVzTVJynrEzj7dhHd4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200918091034epcas1p24ccd1a54fa1c8d186b88d371fa6bdf0b~11bk_goDI1286812868epcas1p2K;
        Fri, 18 Sep 2020 09:10:34 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Bt7N80mlbzMqYkg; Fri, 18 Sep
        2020 09:10:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.24.28581.689746F5; Fri, 18 Sep 2020 18:10:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200918091029epcas1p4fbd0c7f41208c9a5796d241d0f237932~11bgk_1WS0749807498epcas1p4z;
        Fri, 18 Sep 2020 09:10:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200918091029epsmtrp259f3608be794af9947f88ae7aeb8cd54~11bgj-zFw1313513135epsmtrp2d;
        Fri, 18 Sep 2020 09:10:29 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-1f-5f6479860c11
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.27.08382.589746F5; Fri, 18 Sep 2020 18:10:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200918091029epsmtip13ca7c41c5ddeb008664faeaa6b1abdfb~11bgW6_5b1887618876epsmtip1-;
        Fri, 18 Sep 2020 09:10:29 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <64f4b682-00b7-60f2-902f-e50a40a04a55@samsung.com>
Date:   Fri, 18 Sep 2020 18:23:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <57e8ccad-f0d5-febb-7a31-8d34430a5cb8@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmgW5bZUq8wenJQhav/01nsVj98TGj
        RcusRSwWW29JW5xtesNu8bn3CKNF55dZbBa3G1ewWfzcNY/FgdNj56y77B69ze/YPD4+vcXi
        0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QPcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7IzGmbuYim4IFrx8FAXewPjd4EuRk4OCQETicVHHjKD2EICOxglLn917mLk
        ArI/MUocm3yTFcL5xijx5+9hRpiOKfM2MkIk9jJK9H4+zgLhvGeUeNTfzQZSJSzgLfH7wS9W
        EFtEIEhi1+eZzCBFzALtTBLT29+BJdgEtCT2v7gB1sAvoChx9cdjsBW8AnYSC55MBjuKRUBV
        Yt7BDWD1ogJhEie3tUDVCEqcnPmEBcTmFLCVuLjsLhOIzSwgLnHryXwoW16ieetssMUSAis5
        JKbsO8cG8YOLxJS/m5ggbGGJV8e3sEPYUhKf3+2FqqmWWHnyCBtEcwejxJb9F1ghEsYS+5dO
        BmrmANqgKbF+lz5EWFFi5++5jBCL+STefe1hBSmREOCV6GgTgihRlrj84C7UWkmJxe2dbBMY
        lWYheWcWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LTJCjexMjOLFqWexgnPv2g94hRiYOxkOM
        EhzMSiK8zbbJ8UK8KYmVValF+fFFpTmpxYcYTYEBPJFZSjQ5H5ja80riDU2NjI2NLUwMzUwN
        DZXEeR/eUogXEkhPLEnNTk0tSC2C6WPi4JRqYEp7teZ7VUF7Q+JCK8M3YVdUYvove1pomVvk
        xNpIfJuT16ncE6Mj4bTV00o6eW/Ep63nD80IWMa758rJTWonEyNiu9d2Ntilb9637t0O126F
        g+bcQhI7Up7tzd9e/VClfFfTvYkPrs9zevK2Vq698MbPC0/Ug/5+rLoQNcP2YqCprbf7kkcH
        r97Nd5az+dd21eG1xgcd9llTtdNTIuSZl1XsOX/OwNrFmHHtVeHVLZXiDya/E4gJsnecKHVZ
        +KTntonHnH39039ZV390ag6dFm3j+uXEnnYtc7nToZnF3OcKO/i59TZuO9h49+fuFfvjtRw8
        7rleTuFbZPhfqFi61v3GljVqa4yOXXsW3tTyUomlOCPRUIu5qDgRANfT48M1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTre1MiXe4OV5MYvX/6azWKz++JjR
        omXWIhaLrbekLc42vWG3+Nx7hNGi88ssNovbjSvYLH7umsfiwOmxc9Zddo/e5ndsHh+f3mLx
        6NuyitHj8ya5ANYoLpuU1JzMstQifbsEroyGmbtYCi6IVjw81MXewPhdoIuRk0NCwERiyryN
        jF2MXBxCArsZJfYvWMMEkZCUmHbxKHMXIweQLSxx+HAxSFhI4C2jxMPDiSC2sIC3xO8Hv1hB
        bBGBIIlTm98ygtjMAp1MEsfP2EHMvMoi8XXODnaQBJuAlsT+FzfYQGx+AUWJqz8egzXwCthJ
        LHgymRnEZhFQlZh3cAPYUFGBMImdSx4zQdQISpyc+YQFxOYUsJW4uOwuE8QydYk/8y4xQ9ji
        EreezIeKy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLS
        vHS95PzcTYzg+NLS3MG4fdUHvUOMTByMhxglOJiVRHibbZPjhXhTEiurUovy44tKc1KLDzFK
        c7AoifPeKFwYJySQnliSmp2aWpBaBJNl4uCUamCqic24qigkbfot3Nd6xbx9IU/OPEqy9Ttw
        MdIh7H3dptcnUpZOzH/x1soz0fHWgb6FHybM3HU56s6f7xZd3Dlfthaq/N3mxv9B/5DcQoWe
        0OWG1QaVBdm/I+w2L07vjwsQczh6Y9skrdWXv5/anxK1z/eh4O/NOlzNevsW89Qfnpvdrtnp
        PkfwvaPp0v5y+yNlKU4Td8y7b/Fz014bw2imhTtYPjEkq/BeOD3Z95+vtqb4SkOOr12fJm/s
        +vo65nn8rIpD7tNPH58W/k3jt9REEz7vN98CdZ5PTRGojRRLWtwmc0R1r5/liaOq191qcqRV
        3CoSePTs4y9PPO5ksWvbh5MmBUoujKdDf/wWYvuixFKckWioxVxUnAgAO08HXR4DAAA=
X-CMS-MailID: 20200918091029epcas1p4fbd0c7f41208c9a5796d241d0f237932
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
        <20200908072557.GC294938@mwanda>
        <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
        <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
        <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
        <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
        <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
        <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
        <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
        <8edcfd7b-110b-3886-64ee-3ec02cc6bd19@samsung.com>
        <57e8ccad-f0d5-febb-7a31-8d34430a5cb8@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/18/20 6:14 AM, Dmitry Osipenko wrote:
> 17.09.2020 05:32, Chanwoo Choi пишет:
> ...
>>> There is no need to deassert the reset if clk-enable fails because reset
>>> control of tegra30-devfreq is exclusive, i.e it isn't shared with any
>>> other peripherals, and thus, reset control could asserted/deasserted at
>>> any time by the devfreq driver. If clk-enable fails, then reset will
>>> stay asserted and it will be fine to re-assert it again.
>>>
>>
>> Thanks for the detailed explanation. 
>> But, I think that almost people don't know the detailed h/w information.
>> If possible, how about matching the pair when clk-enable fails as following?
>>
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -828,6 +828,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>         if (err) {
>>                 dev_err(&pdev->dev,
>>                         "Failed to prepare and enable ACTMON clock\n");
>> +               reset_control_deassert(tegra->reset);
>>                 return err;
>>         }
> 
> That change won't bring any real benefits and will confuse people who
> know the HW, so we shouldn't do it.
> 
> Since the interrupt is disabled by default at the probe time, we
> actually don't need to care in a what state ACTMON hardware is at the
> driver-probe time since even if HW is active, it won't cause any damage
> to the system since ACTMON only collects and processes stats.
> 
> I made some experiments and looks like at least on Tegra30 the ACTMON
> hardware block uses multiple clocks and the ACTMON-clk isn't strictly
> necessary for the resetting of the HW state, it's actually quite common
> for Tegra peripherals that a part of HW logic runs off some root clk.
> 
> Hence if we want to improve the code, I think we can make this change:
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c
> b/drivers/devfreq/tegra30-devfreq.c
> index ee274daa57ac..4e3ac23e6850 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -891,8 +891,6 @@ static int tegra_devfreq_probe(struct
> platform_device *pdev)
>  		return err;
>  	}
> 
> -	reset_control_assert(tegra->reset);
> -
>  	err = clk_prepare_enable(tegra->clock);
>  	if (err) {
>  		dev_err(&pdev->dev,
> @@ -900,7 +898,7 @@ static int tegra_devfreq_probe(struct
> platform_device *pdev)
>  		return err;
>  	}
> 
> -	reset_control_deassert(tegra->reset);
> +	reset_control_reset(tegra->reset);
> 
>  	for (i = 0; i < mc->num_timings; i++) {
>  		/*

It looks good to me for improving the readability
for everyone who don't know the detailed h/w information.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
