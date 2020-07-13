Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCC21D884
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgGMOaS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 10:30:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12190 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOaS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 10:30:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c6fed0000>; Mon, 13 Jul 2020 07:30:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 07:30:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 07:30:17 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 14:30:09 +0000
Subject: Re: [TEGRA194_CPUFREQ PATCH v4 3/4] cpufreq: Add Tegra194 cpufreq
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        <mirq-linux@rere.qmqm.pl>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
 <1593186236-12760-4-git-send-email-sumitg@nvidia.com>
 <20200629061639.7cwxfi64drkof6yu@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <0d04d2c8-8f87-ecc7-9bd6-633d84b60e8b@nvidia.com>
Date:   Mon, 13 Jul 2020 19:59:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200629061639.7cwxfi64drkof6yu@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594650605; bh=cczukomO7UcCHwxyADg2/yNUOTAA7Ksj6A5ikRcdVSA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZseOkDY3VI8BBpYTwAQpZqe6ktLrz0X4KF9iKWlMzXm81N5tZVCx7P9cwtXlKw/V/
         cdls1zrdFWpmKpSv/v0ICmHIx5ZjCiVT2ViSPXqCvbuxRBZZYZJOJqL/XQ9lIBDYBt
         Jlj+THatHHPaGH1xG8du4Xi13uygwwJWLIMAFtFyk6znhBTGcu4+TzmSDFDx/yHnPG
         QSlAlx2JA0WOKpgdJY9RSv5UF8Ftc9mHWFobovQ05rfoLMRVQsEOGUFpekhZSh3WBi
         /cUvhBKOlKDxYhxF3BxI0qnLLZ1TCDz0QoSyRAPEBcvwXFwWL0XnR4/4QK/iUFkXoj
         7GOq0EISwKABw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> 
> On 26-06-20, 21:13, Sumit Gupta wrote:
>> +static int tegra194_cpufreq_probe(struct platform_device *pdev)
>> +{
>> +     struct tegra194_cpufreq_data *data;
>> +     struct tegra_bpmp *bpmp;
>> +     int err, i;
>> +
>> +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     data->num_clusters = MAX_CLUSTERS;
>> +     data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
>> +                                 sizeof(*data->tables), GFP_KERNEL);
>> +     if (!data->tables)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, data);
>> +
>> +     bpmp = tegra_bpmp_get(&pdev->dev);
>> +     if (IS_ERR(bpmp))
>> +             return PTR_ERR(bpmp);
>> +
>> +     read_counters_wq = alloc_workqueue("read_counters_wq", __WQ_LEGACY, 1);
>> +     if (!read_counters_wq) {
>> +             dev_err(&pdev->dev, "fail to create_workqueue\n");
>> +             err = -EINVAL;
>> +             goto put_bpmp;
> 
> This will call destroy_workqueue() eventually and it will crash your
> kernel.
> 
> Apart from this, this stuff looks okay. Don't resend the patch just
> yet (and if required, send only this patch using --in-reply-to flag
> for git send email). Lets wait for an Ack from Rob for the first two
> patches.
> 
Sorry for the delayed response as i was on PTO.
Thank you for the feedback.

Have posted a v5 based on v4 patch set.

>> +     }
>> +
> 
> --
> viresh
> 
