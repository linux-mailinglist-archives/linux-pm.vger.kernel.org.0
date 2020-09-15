Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE790269B93
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIOBsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 21:48:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:27774 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgIOBsp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 21:48:45 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200915014842epoutp024b8f87cb05cd8e78e082912c585a8c33~00d7cA-Lb1468114681epoutp02D
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 01:48:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200915014842epoutp024b8f87cb05cd8e78e082912c585a8c33~00d7cA-Lb1468114681epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600134522;
        bh=TCodoHKM/DE6wbRWBwtvBDZkLlnnk1vgzezOOIBxb1w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XZgd0O4SLxXktJOC1S85lweU0YXuVDf0OGM8dtkOpGTjz2JWvFNVW8JnJxW0H+boW
         Shb0n1W4vAO4r5INN0exK5N7ZORkTZmEduLC9pcGncIYkjOACw4+f/bH4MbmMhaihg
         qfis0d0yEWeH2i7dntOojVMQmg2Mxu+MaaDZurp4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200915014842epcas1p123a4ea4d3891f114f650cf5e40504b25~00d66WpWM0359503595epcas1p1-;
        Tue, 15 Sep 2020 01:48:42 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Br5jg73GdzMqYkV; Tue, 15 Sep
        2020 01:48:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.08.29173.77D106F5; Tue, 15 Sep 2020 10:48:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200915014839epcas1p3ca92db27d4bf6c12d01649d4c7a9007f~00d4S0cZx0198401984epcas1p3i;
        Tue, 15 Sep 2020 01:48:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200915014839epsmtrp21a528a016396b5cec868ebbfb666f004~00d4RtOwE0163601636epsmtrp2Y;
        Tue, 15 Sep 2020 01:48:39 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-af-5f601d7771f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.3C.08382.77D106F5; Tue, 15 Sep 2020 10:48:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200915014838epsmtip12114e109a55f93e95db7b308107f0ba8~00d39RHnu0071600716epsmtip1H;
        Tue, 15 Sep 2020 01:48:38 +0000 (GMT)
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
Message-ID: <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
Date:   Tue, 15 Sep 2020 11:00:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmrm65bEK8wd4Zphav/01nsVj98TGj
        RcusRSwWW29JW5xtesNu8bn3CKNF55dZbBa3G1ewWfzcNY/FgdNj56y77B69ze/YPD4+vcXi
        0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QPcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7Izdkz+zVqwnb/i5tJNjA2MD3m6GDk5JARMJL6t3c7WxcjFISSwg1Fi8af/
        LCAJIYFPjBL75yh0MXIA2d8YJabB1bcsvsoKUb+XUWLP9zWMEPXvGSV+PNAFsYUFvCV+P/jF
        CmKLCARJ7Po8kxmkgVmgnUlievs7sASbgJbE/hc32EBsfgFFias/HoMN4hWwkzjRfIYZxGYR
        UJXYvf4amC0qECZxclsLVI2gxMmZT8AO5RSwlbh7D2IOs4C4xK0n85kgbHmJ5q2zwRZLCCzl
        kFh06wcLxAsuEsu37IKyhSVeHd/CDmFLSXx+t5cNwq6WWHnyCBtEcwejxJb9F1ghEsYS+5dO
        ZgIFC7OApsT6XfoQYUWJnb/nMkIs5pN497WHFaREQoBXoqNNCKJEWeLyg7tMELakxOL2TrYJ
        jEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBcbIcb2JEZxStcx3ME57+0HvECMTB+Mh
        RgkOZiUR3gON8fFCvCmJlVWpRfnxRaU5qcWHGE2BATyRWUo0OR+Y1PNK4g1NjYyNjS1MDM1M
        DQ2VxHkf3lKIFxJITyxJzU5NLUgtgulj4uCUamCaHbTpqTcnT4WdwUfZHeumtcfO26jw5sc3
        2ZUFNne4vt5T2iI65WpeItc03uI1O8wmtcVfsFjKd1T6+hS7wl8rH3iEfTrovO0gszxTsN71
        ym+rPe/IHOAx9tqeunZedPArvfW6lSXWgZxaat2KMu1bf8h43fJiusDoP+M9/8xTRqZnd69f
        1fXJt2Hbq83tT7PW7dVkO7Mv+oLYsYW+bIUhvXUMVbohLPvSF1j+YW18XpqwrpwrekNF8d1p
        sw/wHSzRvTcpaoEN9/9j57hPvO/pZwxNYd5X6v9bTPVE56+mhHLlqc0T/X6cXnfsyVZPA6Ne
        VmWplA4bmde3dS4odLzt2mn1SHif7Kxn5UvVVy1RYinOSDTUYi4qTgQAXjQUIzIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTrdcNiHeYP8aLovX/6azWKz++JjR
        omXWIhaLrbekLc42vWG3+Nx7hNGi88ssNovbjSvYLH7umsfiwOmxc9Zddo/e5ndsHh+f3mLx
        6NuyitHj8ya5ANYoLpuU1JzMstQifbsErowdk3+zFmznr7i5dBNjA+NDni5GTg4JAROJlsVX
        WbsYuTiEBHYzShyffocFIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBK9R06yg9QIC3hL/H7wixXE
        FhEIkji1+S0jiM0s0MkkcfyMHUTDC0aJZ7v2gRWxCWhJ7H9xgw3E5hdQlLj64zFYA6+AncSJ
        5jPMIDaLgKrE7vXXwGxRgTCJnUseM0HUCEqcnPkE7DhOAVuJu/cg5jALqEv8mXeJGcIWl7j1
        ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
        9ZLzczcxgiNMS3MH4/ZVH/QOMTJxMB5ilOBgVhLhPdAYHy/Em5JYWZValB9fVJqTWnyIUZqD
        RUmc90bhwjghgfTEktTs1NSC1CKYLBMHp1QDk8o78SNqX7jySxM5Hv1evVWIccmTRqdnazYG
        vJCN6fiSxL7vZXES58R/YWvyn2x5cKdJWpAp9V62USWT7OYXhV7LU2N/7VH3LY8OPhxXcdd0
        j+nzw/GeScoRt6QW3wvQkPKJvnanQnnxcr2rFU7LOVRc/BdOr3zvV55UdmOy+mTVswJ10+73
        XJ23QD/IT/FWQE98mlDz3ZoFLXvdnKo0hBZPnLrHn9Er8IvbxXeTDFK0Yjsn8n+xY7Y3ir7x
        2vFTjpmTzErNNv4MlXDWO/tdhRs3SwVMnhei9OpE7pVudtvMiQHvFu1dwLid7dlaxgP6JV4f
        +G9zH7y8YWvTRu7jPoXRNyVPy7bJe/HIe9kpsRRnJBpqMRcVJwIAbZnr/B8DAAA=
X-CMS-MailID: 20200915014839epcas1p3ca92db27d4bf6c12d01649d4c7a9007f
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 9/14/20 10:56 PM, Dmitry Osipenko wrote:
> 14.09.2020 10:09, Chanwoo Choi пишет:
>> Hi,
>>
>> On 9/8/20 4:25 PM, Dan Carpenter wrote:
>>> This error path needs to call clk_disable_unprepare().
>>>
>>> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>> index e94a27804c20..dedd39de7367 100644
>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>  	if (rate < 0) {
>>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>> -		return rate;
>>> +		err = rate;
>>> +		goto disable_clk;
>>>  	}
>>>  
>>>  	tegra->max_freq = rate / KHZ;
>>> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>>  
>>>  	reset_control_reset(tegra->reset);
>>> +disable_clk:
>>>  	clk_disable_unprepare(tegra->clock);
>>
>> Is it doesn't need to reset with reset_contrl_reset()?
> 
> Hello, Chanwoo!
> 
> It's reset just before the clk_round_rate() invocation, hence there
> shouldn't be a need to reset it second time.

Do you mean that reset is deasserted automatically
when invoke clk_round_rate() on tegra?

If tree, I think that 'reset_control_reset(tegra->reset)' invocation
is not needed on 'remove_opp:' goto. Because already reset deassertion
is invoked by clk_round_rate(), it seems that doesn't need to invoke
anymore during exception case.

Actually, it is not clear in my case.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
