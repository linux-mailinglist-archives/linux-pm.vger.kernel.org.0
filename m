Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2A220CF0
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgGOMbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:31:16 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9678 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgGOMbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:31:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0ef6d90000>; Wed, 15 Jul 2020 05:30:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jul 2020 05:31:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jul 2020 05:31:15 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 12:31:07 +0000
Subject: Re: [TEGRA194_CPUFREQ PATCH v5 3/4] cpufreq: Add Tegra194 cpufreq
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mirq-linux@rere.qmqm.pl>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>, <talho@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
 <1594649209-29394-4-git-send-email-sumitg@nvidia.com>
 <20200715111631.o46qgajh56pjkwfo@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <f2cbe396-6c55-3e22-84b6-fd93db88fab7@nvidia.com>
Date:   Wed, 15 Jul 2020 18:01:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200715111631.o46qgajh56pjkwfo@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594816217; bh=VQDWxbcw8MKnUsRvwe8qTIxaVj+CvfrrW9jG8J1GFd8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pA2DMnNnByRrm1aSJm2+u4d+QnShXpHPDhLjcDDyZLf1/X3D4evn4++cN6DmExGu8
         FgN9INQv++2mJzzoeWVMM0QcZjX/GIFnN/8TcK15ZKjHFCKks/SdsHu1KvR0A8afHh
         LNquFB0OyV8w5HVwanZNEnyIDQUDEyiNy+NgX9UIaeCkml7+nxTg/Q7rZnq4grJtdv
         aM5AGhzxIrVswIEA4eZhunPnQFWlh9Ryz9KppVW4UzjuY1b4r8KixZmw+ZVPDnKSus
         lW0mOLR26vlG7axPq9VxWpcvSa37rjsPhIL6a6jLLIn3akMQINVauoZ/tjLptg7H3U
         8K+IISsoaqQnw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you for the review,

>> Add support for CPU frequency scaling on Tegra194. The frequency
>> of each core can be adjusted by writing a clock divisor value to
>> a MSR on the core. The range of valid divisors is queried from
>> the BPMP.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/Kconfig.arm        |   6 +
>>   drivers/cpufreq/Makefile           |   1 +
>>   drivers/cpufreq/tegra194-cpufreq.c | 397 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 404 insertions(+)
>>   create mode 100644 drivers/cpufreq/tegra194-cpufreq.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 15c1a12..f3d8f09 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -314,6 +314,12 @@ config ARM_TEGRA186_CPUFREQ
>>        help
>>          This adds the CPUFreq driver support for Tegra186 SOCs.
>>
>> +config ARM_TEGRA194_CPUFREQ
>> +     tristate "Tegra194 CPUFreq support"
>> +     depends on ARCH_TEGRA && TEGRA_BPMP
> 
> Shouldn't this depend on ARCH_TEGRA_194_SOC instead ? And I asked you
> to add a default y here itself instead of patch 4/4.
> 
Ok.

>> +     help
>> +       This adds CPU frequency driver support for Tegra194 SOCs.
>> +
>>   config ARM_TI_CPUFREQ
>>        bool "Texas Instruments CPUFreq support"
>>        depends on ARCH_OMAP2PLUS
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index f6670c4..66b5563 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -83,6 +83,7 @@ obj-$(CONFIG_ARM_TANGO_CPUFREQ)             += tango-cpufreq.o
>>   obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)    += tegra20-cpufreq.o
>>   obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)   += tegra124-cpufreq.o
>>   obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)   += tegra186-cpufreq.o
>> +obj-$(CONFIG_ARM_TEGRA194_CPUFREQ)   += tegra194-cpufreq.o
>>   obj-$(CONFIG_ARM_TI_CPUFREQ)         += ti-cpufreq.o
>>   obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)       += vexpress-spc-cpufreq.o
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> +static struct cpufreq_frequency_table *
>> +init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
>> +             unsigned int cluster_id)
>> +{
>> +     struct cpufreq_frequency_table *freq_table;
>> +     struct mrq_cpu_ndiv_limits_response resp;
>> +     unsigned int num_freqs, ndiv, delta_ndiv;
>> +     struct mrq_cpu_ndiv_limits_request req;
>> +     struct tegra_bpmp_message msg;
>> +     u16 freq_table_step_size;
>> +     int err, index;
>> +
>> +     memset(&req, 0, sizeof(req));
>> +     req.cluster_id = cluster_id;
>> +
>> +     memset(&msg, 0, sizeof(msg));
>> +     msg.mrq = MRQ_CPU_NDIV_LIMITS;
>> +     msg.tx.data = &req;
>> +     msg.tx.size = sizeof(req);
>> +     msg.rx.data = &resp;
>> +     msg.rx.size = sizeof(resp);
>> +
>> +     err = tegra_bpmp_transfer(bpmp, &msg);
>> +     if (err)
>> +             return ERR_PTR(err);
>> +
>> +     /*
>> +      * Make sure frequency table step is a multiple of mdiv to match
>> +      * vhint table granularity.
>> +      */
>> +     freq_table_step_size = resp.mdiv *
>> +                     DIV_ROUND_UP(CPUFREQ_TBL_STEP_HZ, resp.ref_clk_hz);
>> +
>> +     dev_dbg(&pdev->dev, "cluster %d: frequency table step size: %d\n",
>> +             cluster_id, freq_table_step_size);
>> +
>> +     delta_ndiv = resp.ndiv_max - resp.ndiv_min;
>> +
>> +     if (unlikely(delta_ndiv == 0))
>> +             num_freqs = 1;
>> +     else
>> +             /* We store both ndiv_min and ndiv_max hence the +1 */
>> +             num_freqs = delta_ndiv / freq_table_step_size + 1;
> 
> You need {} in the if else blocks here because of the comment here.
> 
Ok.

>> +
>> +     num_freqs += (delta_ndiv % freq_table_step_size) ? 1 : 0;
>> +
>> +     freq_table = devm_kcalloc(&pdev->dev, num_freqs + 1,
>> +                               sizeof(*freq_table), GFP_KERNEL);
>> +     if (!freq_table)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     for (index = 0, ndiv = resp.ndiv_min;
>> +                     ndiv < resp.ndiv_max;
>> +                     index++, ndiv += freq_table_step_size) {
>> +             freq_table[index].driver_data = ndiv;
>> +             freq_table[index].frequency = map_ndiv_to_freq(&resp, ndiv);
>> +     }
>> +
>> +     freq_table[index].driver_data = resp.ndiv_max;
>> +     freq_table[index++].frequency = map_ndiv_to_freq(&resp, resp.ndiv_max);
>> +     freq_table[index].frequency = CPUFREQ_TABLE_END;
>> +
>> +     return freq_table;
>> +}
>> +
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
>> +     }
>> +
>> +     for (i = 0; i < data->num_clusters; i++) {
>> +             data->tables[i] = init_freq_table(pdev, bpmp, i);
>> +             if (IS_ERR(data->tables[i])) {
>> +                     err = PTR_ERR(data->tables[i]);
>> +                     goto err_free_res;
>> +             }
>> +     }
>> +
>> +     tegra194_cpufreq_driver.driver_data = data;
>> +
>> +     err = cpufreq_register_driver(&tegra194_cpufreq_driver);
>> +     if (err)
>> +             goto err_free_res;
>> +
>> +     tegra_bpmp_put(bpmp);
>> +
>> +     return err;
> 
> rather just do:
> 
> if (!err)
>          goto put_bpmp;
> 
Sure, will add in next version.

>> +
>> +err_free_res:
>> +     tegra194_cpufreq_free_resources();
>> +put_bpmp:
>> +     tegra_bpmp_put(bpmp);
>> +     return err;
>> +}
> --
> viresh
> 
