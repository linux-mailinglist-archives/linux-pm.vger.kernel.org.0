Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3666B204A72
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 09:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgFWHEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 03:04:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730765AbgFWHEH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 03:04:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 14EE8C2AE916BDDE6F2F;
        Tue, 23 Jun 2020 15:04:05 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 23 Jun 2020
 15:03:59 +0800
Subject: Re: [PATCH] cpufreq: cppc: Reorder code and remove
 apply_hisi_workaround variable
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>
CC:     <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <b217dc843935e3f86584a73893d330fd99a4e472.1592889188.git.viresh.kumar@linaro.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <eeb00973-3333-747b-b75a-72360db67042@huawei.com>
Date:   Tue, 23 Jun 2020 15:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b217dc843935e3f86584a73893d330fd99a4e472.1592889188.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 2020/6/23 13:15, Viresh Kumar wrote:
> With the current approach we have an extra check in the
> cppc_cpufreq_get_rate() callback, which checks if hisilicon's get rate
> implementation should be used instead. While it works fine, the approach
> isn't very straight forward, over that we have an extra check in the
> routine.
> 
> Rearrange code and update the cpufreq driver's get() callback pointer
> directly for the hisilicon case. This gets the extra variable is removed
> and the extra check isn't required anymore as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Xiongfeng Wang, will it be possible for you to give this a try as I
> can't really test it locally.

I have tested it on D05. It works well.

Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>


Thanks,
Xiongfeng

> 
>  drivers/cpufreq/cppc_cpufreq.c | 91 ++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726a4456..03a21daddbec 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -45,8 +45,6 @@ struct cppc_workaround_oem_info {
>  	u32 oem_revision;
>  };
>  
> -static bool apply_hisi_workaround;
> -
>  static struct cppc_workaround_oem_info wa_info[] = {
>  	{
>  		.oem_id		= "HISI  ",
> @@ -59,50 +57,6 @@ static struct cppc_workaround_oem_info wa_info[] = {
>  	}
>  };
>  
> -static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
> -					unsigned int perf);
> -
> -/*
> - * HISI platform does not support delivered performance counter and
> - * reference performance counter. It can calculate the performance using the
> - * platform specific mechanism. We reuse the desired performance register to
> - * store the real performance calculated by the platform.
> - */
> -static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> -{
> -	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
> -	u64 desired_perf;
> -	int ret;
> -
> -	ret = cppc_get_desired_perf(cpunum, &desired_perf);
> -	if (ret < 0)
> -		return -EIO;
> -
> -	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
> -}
> -
> -static void cppc_check_hisi_workaround(void)
> -{
> -	struct acpi_table_header *tbl;
> -	acpi_status status = AE_OK;
> -	int i;
> -
> -	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> -	if (ACPI_FAILURE(status) || !tbl)
> -		return;
> -
> -	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> -		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> -		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> -		    wa_info[i].oem_revision == tbl->oem_revision) {
> -			apply_hisi_workaround = true;
> -			break;
> -		}
> -	}
> -
> -	acpi_put_table(tbl);
> -}
> -
>  /* Callback function used to retrieve the max frequency from DMI */
>  static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
>  {
> @@ -402,9 +356,6 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>  	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>  	int ret;
>  
> -	if (apply_hisi_workaround)
> -		return hisi_cppc_cpufreq_get_rate(cpunum);
> -
>  	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>  	if (ret)
>  		return ret;
> @@ -455,6 +406,48 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.name = "cppc_cpufreq",
>  };
>  
> +/*
> + * HISI platform does not support delivered performance counter and
> + * reference performance counter. It can calculate the performance using the
> + * platform specific mechanism. We reuse the desired performance register to
> + * store the real performance calculated by the platform.
> + */
> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
> +	u64 desired_perf;
> +	int ret;
> +
> +	ret = cppc_get_desired_perf(cpunum, &desired_perf);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
> +}
> +
> +static void cppc_check_hisi_workaround(void)
> +{
> +	struct acpi_table_header *tbl;
> +	acpi_status status = AE_OK;
> +	int i;
> +
> +	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> +	if (ACPI_FAILURE(status) || !tbl)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> +		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> +		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> +		    wa_info[i].oem_revision == tbl->oem_revision) {
> +			/* Overwrite the get() callback */
> +			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
> +			break;
> +		}
> +	}
> +
> +	acpi_put_table(tbl);
> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
>  	int i, ret = 0;
> 

