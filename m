Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C360226BA0D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 04:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIPCZ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 22:25:29 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21259 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgIPCZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 22:25:27 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200916022524epoutp027771ad7c919857b49ce13697646cd2a4~1InQCG__a2780727807epoutp02g
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 02:25:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200916022524epoutp027771ad7c919857b49ce13697646cd2a4~1InQCG__a2780727807epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600223124;
        bh=DgSbnlkhPXweofxhNtRa//REujvuzOp6oxSaxCZxs90=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q0u7ccqrSmCt2teaaa3jk6lmHKBpYe6MowF+DuQxAIBsi8V7ZkH6nV5XHIJIexQuC
         5+2AXlWLDeUt8sQ3c+wIbg0zfA8mT6kWzXDeV6Vl2ZMVMFyJ7bKyy1vk3uV+3eMGzl
         M3atoCFlscpaAtS4ewmUaLBneW2QYwIUmOR8VlTY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200916022523epcas1p4324233a9576127a6ae282012d45440ab~1InPT_xzw2647326473epcas1p4P;
        Wed, 16 Sep 2020 02:25:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BrkTZ33GyzMqYkb; Wed, 16 Sep
        2020 02:25:22 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.DD.18978.E87716F5; Wed, 16 Sep 2020 11:25:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200916022517epcas1p49afb776853192263d022df4b9e688396~1InJ32iVY1367113671epcas1p4M;
        Wed, 16 Sep 2020 02:25:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200916022517epsmtrp26544f9005f6422e4b0f96ad3150181d1~1InJ2CB2x2139321393epsmtrp2h;
        Wed, 16 Sep 2020 02:25:17 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-2e-5f61778e38a1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.99.08382.D87716F5; Wed, 16 Sep 2020 11:25:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200916022517epsmtip22e61fb78cd374e55f9f707a431902a07~1InJczQx70634006340epsmtip2p;
        Wed, 16 Sep 2020 02:25:17 +0000 (GMT)
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
Message-ID: <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
Date:   Wed, 16 Sep 2020 11:38:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmgW5feWK8wZIZkhav/01nsVj98TGj
        RcusRSwWW29JW5xtesNu8bn3CKNF55dZbBa3G1ewWfzcNY/FgdNj56y77B69ze/YPD4+vcXi
        0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QPcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7IzNr5PKuiQrLj5ailLA+MfkS5GTg4JAROJtXs/sXUxcnEICexglDgzu4sJ
        wvnEKPHy1SxGkCohgW+MEv1Py2A6zv//xw5RtJdR4kf3IyaIoveMEg83cYDYwgLeEr8f/GIF
        sUUEgiR2fZ7JDNLALNDOJDG9/R1Ygk1AS2L/ixtsIDa/gKLE1R+PwbbxCthJ7F/whx3EZhFQ
        lfi/dCILiC0qECZxclsLVI2gxMmZT8DinAK2Eo1TP4DNYRYQl7j1ZD4ThC0v0bx1NthiCYGl
        HBIne94BFXEAOS4SO+amQnwjLPHq+BZ2CFtK4vO7vWwQdrXEypNH2CB6Oxgltuy/wAqRMJbY
        v3QyE8gcZgFNifW79CHCihI7f89lhNjLJ/Huaw8rxCpeiY42IYgSZYnLD+4yQdiSEovbO9km
        MCrNQvLNLCQfzELywSyEZQsYWVYxiqUWFOempxYbFhgix/UmRnBK1TLdwTjx7Qe9Q4xMHIyH
        GCU4mJVEeA80xscL8aYkVlalFuXHF5XmpBYfYjQFhu9EZinR5HxgUs8riTc0NTI2NrYwMTQz
        NTRUEud9eEshXkggPbEkNTs1tSC1CKaPiYNTqoFJZkOIkom1ic22h2u29wtMf/Lh2zuxm3Lu
        P6eyfDh5v27D4wlH69c+ydgjl/LMfOHBoK6vMm+ehS6/lDTpbdiUFFvNgsMcS89/vKyxatPn
        pyl6/G/iuzt2PPq9MPJm/tybHpynj12K1O1b6O7cVBjwYtb8Szb5DYmivGe2i+3WncoqfSbz
        YaGowodj/Z6vtTfPW/a+QM+vblHDw7c8R5aKnvVc1HX054m21XPsNlW3HmHh7Aien8jTrnmR
        y2XmbcW9z64/f6/N+UVNv+Xq8xfnFhzZfGdS/+obV85YCExSnCv+uLDf9Me8sxNm3T77Q2bG
        mvIMZrMHn2OnuU1bVXf7/UdZ2dnJE/6oT1/TOpXT/Z20EktxRqKhFnNRcSIApe4tMDIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXre3PDHeYON9KYvX/6azWKz++JjR
        omXWIhaLrbekLc42vWG3+Nx7hNGi88ssNovbjSvYLH7umsfiwOmxc9Zddo/e5ndsHh+f3mLx
        6NuyitHj8ya5ANYoLpuU1JzMstQifbsEroyN75MKOiQrbr5aytLA+Eeki5GTQ0LAROL8/3/s
        XYxcHEICuxklzs3pYYdISEpMu3iUuYuRA8gWljh8uBii5i2jxPbWtcwgNcIC3hK/H/xiBbFF
        BIIkTm1+ywhiMwt0MkkcP2MH0dDKLLF08WWwBjYBLYn9L26wgdj8AooSV388BmvgFbCT2L/g
        D9hiFgFVif9LJ7KA2KICYRI7lzxmgqgRlDg58wlYnFPAVqJx6gc2iGXqEn/mXWKGsMUlbj2Z
        zwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS9
        5PzcTYzg+NLS3MG4fdUHvUOMTByMhxglOJiVRHgPNMbHC/GmJFZWpRblxxeV5qQWH2KU5mBR
        Eue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cDEus92peVvmeqQ24kpAr/frCo1ujwjgUt9yuse
        o6Nukl+ZOfgLf3Zv3Rm4TLNyl0j28kWv9tjbfMiTuFEZmr1rc4H3sySGc3eNWV5ka010ORmg
        HZXOrnTTwP5a82l7DcUit0vZone3ZM/gOa4ycesVjYsu55XLN0Que6yj7i5X3DKntvSliVN2
        oW+MmJ3+xonJClJX3yzSfaP4mG+Zyr277lHKPTqhuacqt1zScbDsKC2bmOF8hDuJY3tX/QFG
        u4tPqnu0X815/rCA/9vXew+2XZi/nPP3eT0+vQSOnECzSYY3j2o94bm3907kx99FE2fevDmD
        lV9n2dpF9qpRcR6qU4t/9u0viy7boafX8UCJpTgj0VCLuag4EQBOCKveHgMAAA==
X-CMS-MailID: 20200916022517epcas1p49afb776853192263d022df4b9e688396
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/16/20 2:01 AM, Dmitry Osipenko wrote:
> 15.09.2020 05:13, Chanwoo Choi пишет:
>> On 9/15/20 11:00 AM, Chanwoo Choi wrote:
>>> Hi Dmitry,
>>>
>>> On 9/14/20 10:56 PM, Dmitry Osipenko wrote:
>>>> 14.09.2020 10:09, Chanwoo Choi пишет:
>>>>> Hi,
>>>>>
>>>>> On 9/8/20 4:25 PM, Dan Carpenter wrote:
>>>>>> This error path needs to call clk_disable_unprepare().
>>>>>>
>>>>>> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
>>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>>> ---
>>>>>> ---
>>>>>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>>>>> index e94a27804c20..dedd39de7367 100644
>>>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>>>> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>>>>  	if (rate < 0) {
>>>>>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>>>>> -		return rate;
>>>>>> +		err = rate;
>>>>>> +		goto disable_clk;
>>>>>>  	}
>>>>>>  
>>>>>>  	tegra->max_freq = rate / KHZ;
>>>>>> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>>>>>  
>>>>>>  	reset_control_reset(tegra->reset);
>>>>>> +disable_clk:
>>>>>>  	clk_disable_unprepare(tegra->clock);
>>>>>
>>>>> Is it doesn't need to reset with reset_contrl_reset()?
>>>>
>>>> Hello, Chanwoo!
>>>>
>>>> It's reset just before the clk_round_rate() invocation, hence there
>>>> shouldn't be a need to reset it second time.
>>>
>>> Do you mean that reset is deasserted automatically
>>> when invoke clk_round_rate() on tegra?
> 
> I only mean that the tegra30-devfreq driver deasserts the reset before
> the clk_round_rate():
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/tegra30-devfreq.c?h=v5.9-rc5#n834
> 
>>> If tree, I think that 'reset_control_reset(tegra->reset)' invocation
>>
>> I'm sorry for my typo. s/tree/true.
>>
>>> is not needed on 'remove_opp:' goto. Because already reset deassertion
>>> is invoked by clk_round_rate(), it seems that doesn't need to invoke
>>> anymore during exception case.
>>>
>>> Actually, it is not clear in my case.
> 
> The reset_control_reset() in the error path of the driver probe function
> is placed that way to make the tear-down order match the driver removal
> order. Perhaps the reset could be moved before the remove_opp, but this
> change won't make any real difference, hence it already should be good
> as-is.
> 
> 

I have one more question.
When failed to enable clock on line829[1],
does it need any reset_control invocation?
In this case on line829, just return without any restoration 
about reset control.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/tegra30-devfreq.c?h=v5.9-rc5#n829

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
