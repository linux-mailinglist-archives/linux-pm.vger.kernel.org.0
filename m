Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1431E1E553C
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 06:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgE1ExN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 00:53:13 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31579 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgE1ExN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 00:53:13 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200528045306epoutp0223b94043a1417b747c358e0abab7b1f8~TGBhsasv60191401914epoutp02i
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 04:53:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200528045306epoutp0223b94043a1417b747c358e0abab7b1f8~TGBhsasv60191401914epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590641586;
        bh=JiZ1mXnfKpe9m6BNhP4M9O4R+4coStFJA2TE486yjc8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q/Op9jsfOa9AqUu9rHx06vsxXZ4Clh9w3GF6KtH0hrLwe91ILTmMMcd4hlAL+zoBf
         8RFVZfJw3Xf9jjIDcw5ads6IISfPLqlOPTzvj2hlZyeL8awjiKklnusbTTKrJmVuid
         Q+KcVIR2iqjbrBMTx6frNE0XGiYQHT+sEvn8Tcac=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200528045305epcas1p40cae63ccf88ab0ec10fc1ec724358b0d~TGBg9D5-i3216732167epcas1p4g;
        Thu, 28 May 2020 04:53:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49Xb1C07ZZzMqYkp; Thu, 28 May
        2020 04:53:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.CA.04392.EA34FCE5; Thu, 28 May 2020 13:53:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200528045302epcas1p25f00cf42a4ecd907e017f04970ab3566~TGBd43_kA1139311393epcas1p2T;
        Thu, 28 May 2020 04:53:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200528045302epsmtrp2ad52b1a91ea2ae7efea6aa20c721556b~TGBd3GPhA2826528265epsmtrp2C;
        Thu, 28 May 2020 04:53:02 +0000 (GMT)
X-AuditID: b6c32a37-cc3ff70000001128-7b-5ecf43aea493
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.96.08303.EA34FCE5; Thu, 28 May 2020 13:53:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200528045302epsmtip1fc88aff40189470bd8091a7a1a6c027d~TGBdcnvxv1896718967epsmtip19;
        Thu, 28 May 2020 04:53:02 +0000 (GMT)
Subject: Re: [PATCH 06/12] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fc718d05-6e03-e9df-df4b-10af26d17de3@samsung.com>
Date:   Thu, 28 May 2020 14:03:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200520034307.20435-7-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+6rRS3eFdQDySbejT8gIr3U6oGJWcAsN5nZcI4tGQvdDb2h
        jL68t9XplqiAk6owiFnUykQ3TRQZLxlFnto1wQ5hw0IhMhKQxrilSLLCxrZkWduLGf99zu98
        v/nmex5KXH1Skawss9gF0cKbGGod0fVDWmZGS/5PxZqRp68jd+szEn01F6RQo3eURCMVIQX6
        Y7waQx3zARL5exoo5K8cAyhc4wXoxuQYhiqqtGj65E0KhVZGMPRw+BGJTvV7FejfQDuBAtcW
        SXRvrJ5CF2bUqH2ZeyORa77SDDh/bQ3G3XXNKLiOJifF/RLoo7g7149zVb5BguucOE1wtZ1N
        gBuacmNcuOOVgvUflu8xCrxBEFMES4nVUGYpzWXeOqjP1+t2adgMNhvtZlIsvFnIZfbtL8h4
        s8wUacikHOZNjsiogJckJnPvHtHqsAspRqtkz2UEm8Fky7btkHiz5LCU7iixmnNYjSZLFxF+
        XG6ceXzAducb8OniJSd5AniPnwFxSkjvhJPhXuoMWKdU090A/hlaUMiL3wGsWX5KRVVqOgzg
        lV91Lxx/1fcRsqgHwJbrwVX7IoCz5y9iUVUC/REM9X+JRzmRnsZh3eX3oiKcrsfgwI+nYhsU
        nQ4Hn03FIjbS2+DEyjyIsoreC+fuuxVRJuhU+H1gKcab6Pehr6tqVfMS9F0KElGOo/Pg4oOL
        McbpLfBxsBGTeSt0LzTg0WBI346DF0JOIHfYB933Z0mZE+BvQ50KmZNh+Hk/JfNn8JbPS8nm
        agA7B39eNWjh4I3zkQRlJCENtvZkyuNt8O4/XwM5OB4+Xz5HRiWQVsHqL9Sy5FXon53BZE6C
        3552UnWAca2p41pTwbWmguv/sKuAaAKbBZtkLhUk1qZde90dIPb803d3g7bR/R5AKwGzQaXh
        RovVJH9YOmr2AKjEmURV3shwsVpl4I8eE0SrXnSYBMkDdJHTrseTN5VYI5/JYtezuiytVot2
        srt0LMtsUTWuPCxW06W8XSgXBJsgvvBhyrjkEyAvqdf63csfXP6kwX7A8HfhOLxde6TxtUcb
        Uo8MnK3DsvH1h1KfxC+0bX13YcmZc2x5umKiyM/6DiZ4hgcmy5oPjb8ztFHTUlQoLXU527Tb
        jehJ39laRzCtdX6zMiupu03v2X6zqD1nKl71uVjZLuT7K8X0xLcLH5wbtptqem/N3WMIyciz
        6bgo8f8BtZ7FVxQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSnO465/NxBrvXClhsX/+C1WLqwyds
        FvOPnGO1ONv0ht3i25UOJotNj6+xWlzeNYfN4nLzRUaLz71HGC2WXr/IZNHUYmxxu3EFm8Wb
        H2eZLM6cvsRq0br3CLvFv2sbWSyuLXzPanHg4kQ2i+l3hSw2fvVwEPFYM28No8flvl4mj52z
        7rJ7bFrVyeZx59oeNo/NS+o9Wk7uZ/HYcrWdxaNvyypGj+M3tjN5fN4kF8AdxWWTkpqTWZZa
        pG+XwJVx91ZgweZFjBXvZ3ayNjAeqe9i5OSQEDCR+DlxDwuILSSwg1Hix65giLikxLSLR5m7
        GDmAbGGJw4eLuxi5gEreMkocWLKMGaRGWCBG4s3efmaQhIjAfWaJ5XevsoE4zAITmSTOta9g
        g2g5yyjxu+cbI0gLm4CWxP4XN9hAbH4BRYmrPx6DxXkF7CQeHtzODmKzCKhKbL32BcwWFQiT
        2LnkMRNEjaDEyZlPwE7lFHCSeH9iBpjNLKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LS
        PgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iRGcBrS0djDuWfVB
        7xAjEwfjIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzFKc7AoifN+nbUwTkggPbEkNTs1
        tSC1CCbLxMEp1cCUKbaeRcBHo4Lr9ba01mevOJfWL59cdlz3VVzvySVSie41x7PerHmr8WSL
        UGqbwqx+TukI9x/uGy02Tub5ePDNR0Uu178lO/pPLjz09DLXUsMbi5odg05+/nXvl/u0GRLF
        id3Z3u8/V97fyxC3qCmtjm2q57TZZc2rMlZ+frljm9PTpwWVj/VeV72u4uidufCu0e0g5m2T
        2qO2Xr2Te7Lz3/7vjqe2l7+e+VBao4rnCMd0vYnuqkrV/E84vJb6HDpxj2uFbfMzBfvzMVOu
        fn60JHZZw8aQaU8mqEw7sePhkz8PDzx/vCyn++vb02wnm6wyw8zZtZqfH5fK9fjx69Vvzg85
        cceyw95tsTh2jDtTZrsSS3FGoqEWc1FxIgCYSUnpcgMAAA==
X-CMS-MailID: 20200528045302epcas1p25f00cf42a4ecd907e017f04970ab3566
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520034335epcas1p45a321a1a878fb7cd7b9c9ada0a474ef7
References: <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
        <CGME20200520034335epcas1p45a321a1a878fb7cd7b9c9ada0a474ef7@epcas1p4.samsung.com>
        <20200520034307.20435-7-andrew-sh.cheng@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrew-sh.Cheng,

Thanks for your posting. I like this approach absolutely.
I think that it is necessary. When I developed the embedded product,
I needed this feature always. 

I add the comments on below.

On 5/20/20 12:43 PM, Andrew-sh.Cheng wrote:
> From: Saravana Kannan <skannan@codeaurora.org>
> 
> Many CPU architectures have caches that can scale independent of the
> CPUs. Frequency scaling of the caches is necessary to make sure that the
> cache is not a performance bottleneck that leads to poor performance and
> power. The same idea applies for RAM/DDR.
> 
> To achieve this, this patch adds support for cpu based scaling to the
> passive governor. This is accomplished by taking the current frequency
> of each CPU frequency domain and then adjust the frequency of the cache
> (or any devfreq device) based on the frequency of the CPUs. It listens
> to CPU frequency transition notifiers to keep itself up to date on the
> current CPU frequency.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> * Derives the optimal devfreq device opp from required-opps property of
>   the parent cpu opp_table.
> 
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its
>   max frequency. If the CPUs are running at their min frequency, the
>   device runs at its min frequency. It is interpolated for frequencies
>   in between.
> 
> Andrew-sh.Cheng change
> dev_pm_opp_xlate_opp to dev_pm_opp_xlate_required_opp devfreq->max_freq
> to devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value
> for kernel-5.7
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> [Sibi: Integrated cpu-freqmap governor into passive_governor]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/Kconfig            |   2 +
>  drivers/devfreq/governor_passive.c | 278 ++++++++++++++++++++++++++++++++++---
>  include/linux/devfreq.h            |  40 +++++-
>  3 files changed, 299 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 0b1df12e0f21..d9067950af6a 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -73,6 +73,8 @@ config DEVFREQ_GOV_PASSIVE
>  	  device. This governor does not change the frequency by itself
>  	  through sysfs entries. The passive governor recommends that
>  	  devfreq device uses the OPP table to get the frequency/voltage.
> +	  Alternatively the governor can also be chosen to scale based on
> +	  the online CPUs current frequency.
>  
>  comment "DEVFREQ Drivers"
>  
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 2d67d6c12dce..7dcda02a5bb7 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -8,11 +8,89 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
>  #include <linux/device.h>
>  #include <linux/devfreq.h>
> +#include <linux/slab.h>
>  #include "governor.h"
>  
> -static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> +static unsigned int xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,

Need to change 'unsigned int' to 'unsigned long'.

> +					     unsigned int cpu)
> +{
> +	unsigned int cpu_min, cpu_max, dev_min, dev_max, cpu_percent, max_state;

Better to define them separately as following and then need to rename
the variable. Usually, use the 'min_freq' and 'max_freq' word for
the minimum/maximum frequency.

	unsigned int cpu_min_freq, cpu_max_freq, cpu_curr_freq, cpu_percent;
	unsigned long dev_min_freq, dev_max_freq, dev_max_state,

The devfreq used 'unsigned long'. The cpufreq used 'unsigned long'
and 'unsigned int'. You need to handle them properly.


> +	struct devfreq_cpu_state *cpu_state = data->cpu_state[cpu];
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	unsigned long *freq_table = devfreq->profile->freq_table;

In this function, use 'cpu' work for cpufreq and use 'dev' for devfreq.
So, I think 'dev_freq_table' is proper name instead of 'freq_table'
for the readability.

	freq_table -> dev_freq_table

> +	struct dev_pm_opp *opp = NULL, *cpu_opp = NULL;

In the get_target_freq_with_devfreq(), use 'p_opp' indicating
the OPP of parent device. For the consistency, I think that
use 'p_opp' instead of 'cpu_opp'. 

> +	unsigned long cpu_freq, freq;

Define the 'cpu_freq' on above with cpu_min_freq/cpu_max_freq definition.
	cpu_freq -> cpu_curr_freq.

> +
> +	if (!cpu_state || cpu_state->first_cpu != cpu ||
> +	    !cpu_state->opp_table || !devfreq->opp_table)
> +		return 0;
> +
> +	cpu_freq = cpu_state->freq * 1000;
> +	cpu_opp = devfreq_recommended_opp(cpu_state->dev, &cpu_freq, 0);
> +	if (IS_ERR(cpu_opp))
> +		return 0;
> +
> +	opp = dev_pm_opp_xlate_required_opp(cpu_state->opp_table,
> +					    devfreq->opp_table, cpu_opp);
> +	dev_pm_opp_put(cpu_opp);
> +
> +	if (!IS_ERR(opp)) {
> +		freq = dev_pm_opp_get_freq(opp);
> +		dev_pm_opp_put(opp);

Better to add the 'out' goto statement.
If you use 'goto out', you can reduce the one indentation
without 'else' statement.
	

> +	} else {

As I commented, when dev_pm_opp_xlate_required_opp() return successfully
, use 'goto out'. We can remove 'else' and then reduce the unneeded indentation.


> +		/* Use Interpolation if required opps is not available */
> +		cpu_min = cpu_state->min_freq;
> +		cpu_max = cpu_state->max_freq;
> +		cpu_freq = cpu_state->freq;
> +
> +		if (freq_table) {
> +			/* Get minimum frequency according to sorting order */
> +			max_state = freq_table[devfreq->profile->max_state - 1];
> +			if (freq_table[0] < max_state) {
> +				dev_min = freq_table[0];
> +				dev_max = max_state;
> +			} else {
> +				dev_min = max_state;
> +				dev_max = freq_table[0];
> +			}
> +		} else {
> +			if (devfreq->user_max_freq_req.data.freq.qos->max_freq.target_value
> +			    <= devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value)
> +				return 0;
> +			dev_min =
> +			devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value;
> +			dev_max =
> +			devfreq->user_max_freq_req.data.freq.qos->max_freq.target_value;

I think it is not proper to access the variable of pm_qos structure directly.
Instead of direct access, you have to use the exported PM QoS function such as
- pm_qos_read_value(devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY);
- pm_qos_read_value(devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY);

> +		}
> +		cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
> +		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
> +	}


I think that you better to add 'out' jump label as following:

out:

> +
> +	return freq;
> +}
> +
> +static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
> +					unsigned long *freq)
> +{
> +	struct devfreq_passive_data *p_data =
> +				(struct devfreq_passive_data *)devfreq->data;
> +	unsigned int cpu, target_freq = 0;

Need to define 'target_freq' with 'unsigned long' type.

> +
> +	for_each_online_cpu(cpu)
> +		target_freq = max(target_freq,
> +				  xlate_cpufreq_to_devfreq(p_data, cpu));
> +
> +	*freq = target_freq;
> +
> +	return 0;
> +}
> +
> +static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>  					unsigned long *freq)
>  {
>  	struct devfreq_passive_data *p_data
> @@ -23,16 +101,6 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	int i, count, ret = 0;
>  
>  	/*
> -	 * If the devfreq device with passive governor has the specific method
> -	 * to determine the next frequency, should use the get_target_freq()
> -	 * of struct devfreq_passive_data.
> -	 */
> -	if (p_data->get_target_freq) {
> -		ret = p_data->get_target_freq(devfreq, freq);
> -		goto out;
> -	}
> -
> -	/*
>  	 * If the parent and passive devfreq device uses the OPP table,
>  	 * get the next frequency by using the OPP table.
>  	 */
> @@ -102,6 +170,37 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	return ret;
>  }
>  
> +static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> +					   unsigned long *freq)
> +{
> +	struct devfreq_passive_data *p_data =
> +				(struct devfreq_passive_data *)devfreq->data;
> +	int ret;
> +
> +	/*
> +	 * If the devfreq device with passive governor has the specific method
> +	 * to determine the next frequency, should use the get_target_freq()
> +	 * of struct devfreq_passive_data.
> +	 */
> +	if (p_data->get_target_freq)
> +		return p_data->get_target_freq(devfreq, freq);
> +
> +	switch (p_data->parent_type) {
> +	case DEVFREQ_PARENT_DEV:
> +		ret = get_target_freq_with_devfreq(devfreq, freq);
> +		break;
> +	case CPUFREQ_PARENT_DEV:
> +		ret = get_target_freq_with_cpufreq(devfreq, freq);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		dev_err(&devfreq->dev, "Invalid parent type\n");
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int ret;
> @@ -156,6 +255,140 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
> +					 unsigned long event, void *ptr)
> +{
> +	struct devfreq_passive_data *data =
> +			container_of(nb, struct devfreq_passive_data, nb);
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	struct devfreq_cpu_state *cpu_state;
> +	struct cpufreq_freqs *freq = ptr;

How about changing 'freq' to 'cpu_freqs'?

In the drivers/cpufreq/cpufreq.c, use 'freqs' name indicating
the instance of 'struct cpufreq_freqs'. And in order to
identfy, how about adding 'cpu_' prefix for variable name?

> +	unsigned int current_freq;

Need to define curr_freq with 'unsigned long' type
and better to use 'curr_freq' variable name.

> +	int ret;
> +
> +	if (event != CPUFREQ_POSTCHANGE || !freq ||
> +	    !data->cpu_state[freq->policy->cpu])
> +		return 0;
> +
> +	cpu_state = data->cpu_state[freq->policy->cpu];
> +	if (cpu_state->freq == freq->new)
> +		return 0;
> +
> +	/* Backup current freq and pre-update cpu state freq*/
> +	current_freq = cpu_state->freq;
> +	cpu_state->freq = freq->new;
> +
> +	mutex_lock(&devfreq->lock);
> +	ret = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +	if (ret) {
> +		cpu_state->freq = current_freq;
> +		dev_err(&devfreq->dev, "Couldn't update the frequency.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
> +{
> +	struct devfreq_passive_data *data = *p_data;
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	struct device *dev = devfreq->dev.parent;
> +	struct opp_table *opp_table = NULL;
> +	struct devfreq_cpu_state *state;

For the readability, I thinkt 'cpu_state' is proper instead of 'state'.

> +	struct cpufreq_policy *policy;
> +	struct device *cpu_dev;
> +	unsigned int cpu;
> +	int ret;
> +
> +	get_online_cpus();

Add blank line.

> +	data->nb.notifier_call = cpufreq_passive_notifier_call;
> +	ret = cpufreq_register_notifier(&data->nb,
> +					CPUFREQ_TRANSITION_NOTIFIER);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register cpufreq notifier.\n");
> +		data->nb.notifier_call = NULL;
> +		goto out;
> +	}
> +
> +	/* Populate devfreq_cpu_state */
> +	for_each_online_cpu(cpu) {
> +		if (data->cpu_state[cpu])
> +			continue;
> +
> +		policy = cpufreq_cpu_get(cpu);

cpufreq_cpu_get() might return 'NULL'. I think you need to handle
return value as following:

		if (!policy) {
			ret = -EINVAL;
			goto out;
		} else if (PTR_ERR(policy) == -EPROBE_DEFER) {
			goto out;
		} else if (IS_ERR(policy) {
			ret = PTR_ERR(policy);
			dev_err(dev, "Couldn't get the cpufreq_poliy.\n");
			goto out;
		}

If cpufreq_cpu_get() return successfully, to do next.
It reduces the one indentaion.



> +		if (policy) {
> +			state = kzalloc(sizeof(*state), GFP_KERNEL);
> +			if (!state) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			cpu_dev = get_cpu_device(cpu);
> +			if (!cpu_dev) {
> +				dev_err(dev, "Couldn't get cpu device.\n");
> +				ret = -ENODEV;
> +				goto out;
> +			}
> +
> +			opp_table = dev_pm_opp_get_opp_table(cpu_dev);
> +			if (IS_ERR(devfreq->opp_table)) {
> +				ret = PTR_ERR(opp_table);
> +				goto out;
> +			}
> +
> +			state->dev = cpu_dev;
> +			state->opp_table = opp_table;
> +			state->first_cpu = cpumask_first(policy->related_cpus);
> +			state->freq = policy->cur;
> +			state->min_freq = policy->cpuinfo.min_freq;
> +			state->max_freq = policy->cpuinfo.max_freq;
> +			data->cpu_state[cpu] = state;

Add blank line.

> +			cpufreq_cpu_put(policy);
> +		} else {
> +			ret = -EPROBE_DEFER;
> +			goto out;
> +		}
> +	}

Add blank line.

> +out:
> +	put_online_cpus();
> +	if (ret)
> +		return ret;
> +
> +	/* Update devfreq */
> +	mutex_lock(&devfreq->lock);
> +	ret = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +	if (ret)
> +		dev_err(dev, "Couldn't update the frequency.\n");
> +
> +	return ret;
> +}
> +
> +static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
> +{
> +	struct devfreq_passive_data *data = *p_data;
> +	struct devfreq_cpu_state *cpu_state;
> +	int cpu;
> +
> +	if (data->nb.notifier_call)
> +		cpufreq_unregister_notifier(&data->nb,
> +					    CPUFREQ_TRANSITION_NOTIFIER);
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_state = data->cpu_state[cpu];
> +		if (cpu_state) {
> +			if (cpu_state->opp_table)
> +				dev_pm_opp_put_opp_table(cpu_state->opp_table);
> +			kfree(cpu_state);
> +			cpu_state = NULL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  				unsigned int event, void *data)
>  {
> @@ -165,7 +398,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  	struct notifier_block *nb = &p_data->nb;
>  	int ret = 0;
>  
> -	if (!parent)
> +	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>  		return -EPROBE_DEFER;

If you modify the devfreq_passive_event_handler() as following,
you can move this condition for DEVFREQ_PARENT_DEV into 
(register|unregister)_parent_dev_notifier.

	switch (event) {                                                                                  
	case DEVFREQ_GOV_START:                                               
		ret = register_parent_dev_notifier(p_data);
		break;
	case DEVFREQ_GOV_STOP:                                             
		ret = unregister_parent_dev_notifier(p_data);
		break;
	default: 
		ret = -EINVAL;
		break;
	}
                                                                                              
	return ret;

>  
>  	switch (event) {
> @@ -173,13 +406,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  		if (!p_data->this)
>  			p_data->this = devfreq;
>  
> -		nb->notifier_call = devfreq_passive_notifier_call;
> -		ret = devfreq_register_notifier(parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER);
> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
> +			nb->notifier_call = devfreq_passive_notifier_call;
> +			ret = devfreq_register_notifier(parent, nb,
> +						DEVFREQ_TRANSITION_NOTIFIER);
> +		} else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
> +			ret = cpufreq_passive_register(&p_data);

I think that we better to collect the code related to notifier registration
into one function like devfreq_pass_register_notifier() instead of
cpufreq_passive_register() as following: I think it is more simple and readable.

If you have more proper function name of register_parent_dev_notifier,
please give your opinion.


	int register_parent_dev_notifier(struct devfreq_passive_data **p_data)
		switch (p_data->parent_type) {
		case DEVFREQ_PARENT_DEV:
			nb->notifier_call = devfreq_passive_notifier_call;
			ret = devfreq_register_notifier(parent, nb,
			break;
		case CPUFREQ_PARENT_DEV:
			cpufreq_register_notifier(...)
			...
			break;
		}
		

> +		} else {
> +			ret = -EINVAL;
> +		}
>  		break;
>  	case DEVFREQ_GOV_STOP:
> -		WARN_ON(devfreq_unregister_notifier(parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER));
> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
> +			WARN_ON(devfreq_unregister_notifier(parent, nb,
> +						DEVFREQ_TRANSITION_NOTIFIER));
> +		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
> +			cpufreq_passive_unregister(&p_data);
> +		else
> +			ret = -EINVAL;

ditto. unregister_parent_dev_notifier(struct devfreq_passive_data **p_data)

>  		break;
>  	default:
>  		break;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index a4b19d593151..04ce576fd6f1 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -278,6 +278,32 @@ struct devfreq_simple_ondemand_data {
>  
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>  /**
> + * struct devfreq_cpu_state - holds the per-cpu state
> + * @freq:	the current frequency of the cpu.
> + * @min_freq:	the min frequency of the cpu.
> + * @max_freq:	the max frequency of the cpu.
> + * @first_cpu:	the cpumask of the first cpu of a policy.
> + * @dev:	reference to cpu device.
> + * @opp_table:	reference to cpu opp table.
> + *
> + * This structure stores the required cpu_state of a cpu.
> + * This is auto-populated by the governor.
> + */
> +struct devfreq_cpu_state {> +	unsigned int freq;

It is better to change from 'freq' to 'curr_freq'
for more correct expression.

> +	unsigned int min_freq;
> +	unsigned int max_freq;
> +	unsigned int first_cpu;
> +	struct device *dev;

How about changing the name 'dev' to 'cpu_dev'?


> +	struct opp_table *opp_table;
> +};

devfreq_cpu_state is only handled by within driver/devfreq/governor_passive.c.

So, you can move it into drivers/devfreq/governor_passive.c
and just add the definition into include/linux/devfreq.h as following:
It is able to prevent the access of variable of 'struct devfreq_cpu_state'
outside.

	struct devfreq_cpu_state;

> +
> +enum devfreq_parent_dev_type {
> +	DEVFREQ_PARENT_DEV,
> +	CPUFREQ_PARENT_DEV,
> +};
> +
> +/**
>   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>   *	and devfreq_add_device
>   * @parent:	the devfreq instance of parent device.
> @@ -288,13 +314,15 @@ struct devfreq_simple_ondemand_data {
>   *			using governors except for passive governor.
>   *			If the devfreq device has the specific method to decide
>   *			the next frequency, should use this callback.
> - * @this:	the devfreq instance of own device.
> - * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> + * @parent_type		parent type of the device

Need to add ':' at the end of word. -> "parent_type:".

> + * @this:		the devfreq instance of own device.
> + * @nb:			the notifier block for DEVFREQ_TRANSITION_NOTIFIER list

I knew that you make them with same indentation.
But, actually, it is not related to this patch like clean-up code.
Even if it is not pretty, you better to don't touch 'this' and 'nb' indentaion.

> + * @cpu_state:		the state min/max/current frequency of all online cpu's
>   *
>   * The devfreq_passive_data have to set the devfreq instance of parent
>   * device with governors except for the passive governor. But, don't need to
> - * initialize the 'this' and 'nb' field because the devfreq core will handle
> - * them.
> + * initialize the 'this', 'nb' and 'cpu_state' field because the devfreq core
> + * will handle them.
>   */
>  struct devfreq_passive_data {
>  	/* Should set the devfreq instance of parent device */
> @@ -303,9 +331,13 @@ struct devfreq_passive_data {
>  	/* Optional callback to decide the next frequency of passvice device */
>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>  
> +	/* Should set the type of parent device */
> +	enum devfreq_parent_dev_type parent_type;
> +
>  	/* For passive governor's internal use. Don't need to set them */
>  	struct devfreq *this;
>  	struct notifier_block nb;
> +	struct devfreq_cpu_state *cpu_state[NR_CPUS];
>  };
>  #endif
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
