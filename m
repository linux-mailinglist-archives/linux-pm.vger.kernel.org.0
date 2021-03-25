Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD402348AE6
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 08:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYH5w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 03:57:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:32633 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCYH51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 03:57:27 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210325075725epoutp02cee56e77e2afcd7f609adec935dc67c1~vhtYdrhnJ0536005360epoutp02I
        for <linux-pm@vger.kernel.org>; Thu, 25 Mar 2021 07:57:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210325075725epoutp02cee56e77e2afcd7f609adec935dc67c1~vhtYdrhnJ0536005360epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616659045;
        bh=h5hAakrRZG/HRjuzp7d/ZaPiA2ZDcXCqefRAVKXAF0A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B2a+z4Bk+EpcFzQst68XH+xKJzInDHAJdm1rUFeWNmKEXAaZeDb2couv/oXMw4ig1
         RFJNKO7rrwGTB7/IDJ9m72Fv8spAIBOz2YfubauJSnXsHrLUl4wwGTUwgTkc8Q4wZt
         QRDgvBm5HeyF8RXXih6Vs/hFYG+Zoh7AVkflZTk8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210325075724epcas1p35121a408ab3e1e15e4e702cead03721d~vhtXlxBSu2445524455epcas1p3B;
        Thu, 25 Mar 2021 07:57:24 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F5crw3dBXz4x9Q8; Thu, 25 Mar
        2021 07:57:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.53.50768.D524C506; Thu, 25 Mar 2021 16:57:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210325075717epcas1p25572937cd2b9db2fd81be6e6343998f3~vhtQwJlG60569705697epcas1p2D;
        Thu, 25 Mar 2021 07:57:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210325075717epsmtrp217e76e817564f4f1b19b95aea0093993~vhtQvJ-Lq0697906979epsmtrp2y;
        Thu, 25 Mar 2021 07:57:17 +0000 (GMT)
X-AuditID: b6c32a37-fc3ff7000000c650-9c-605c425db47b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.60.33967.C524C506; Thu, 25 Mar 2021 16:57:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210325075716epsmtip1a784954d8125e9fcb3b8bdf239326c28~vhtQVgvVe3055230552epsmtip1Q;
        Thu, 25 Mar 2021 07:57:16 +0000 (GMT)
Subject: Re: [PATCH V8 1/8] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Sibi Sankar <sibis@codeaurora.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <233a3bd6-7ab1-5da2-9184-a745eb253d86@samsung.com>
Date:   Thu, 25 Mar 2021 17:14:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxj17iabhZK6DShXpsW4jD+ggsQQXKg4INqu4lQKjo/6gIXsEAZI
        YjZ0+vhRpFEwlUdbKDSIaJGOMkwRRCJQjEWGl/igYGR4iSOKQxEpFMqz0ySrU/6d73znm3PP
        d+/FUckU5oEnqvWsTs0kk5izoPa2t5/vsR1HY/3LO6WUufKFkMp/MoJRJc33hNTd9HERNduT
        iVDVT61Cqrv+HEZ1f9MFqOmsZkCVPepCqHSDnOo/eRmjxufuIlTnnT+E1KnGZhH1r7VKQFkv
        vhJSBYMSqmqGDnWlK85XALo7Owuh60yDIrq6/AxGD1h/w+hrl76mDe0WAV3zMENAZ9eUA7q1
        14zQ09WekW99mrRNxTJKVidl1fEaZaI6IYSMiI4Jj1EE+st8ZUHUVlKqZlLYEHLn3kjfDxOT
        beFI6WdMcqqNimQ4jty8fZtOk6pnpSoNpw8hWa0yWRuk9eOYFC5VneAXr0kJlvn7b1HYhLFJ
        qlxTIdCOXgOfP5toQdPAt0ZgBE44JAJgw/yvqBE44xLiBoDdj58BvpgCsKznexFfzAJYa34g
        ejOSXzQt5BuNABqWcgV88QrA+6eNiF3lShyDC/eHHA03og+FN2+VOFxQYhTAqfQKgV2FET7Q
        8qIXs+PVxAb4cO6p41hiYjtsMOY6NAJiI+woHHLgNcQB2F5reK15B7b/NGLjcdyJ2Asr/zlk
        p1HCHfaNlCA8Xg/NL885fCFR6gTbahZQPsNO+LjO9HoFrnCsteZ1Ng84PdGI8fgreKW9GeOH
        MwGssTwQ8g05tJT9gNiNUcIbVtZv5ukNsG6xGPDGb8OJmbNCuwQSYph5WsJLvGD38CDC43Ww
        NOMMlgtI04o0phURTCsimP43uwAE5WAtq+VSElhOppWvvPFq4Hj8PltvgB9fTvo1AQQHTQDi
        KOkmNhw8FCsRK5kvvmR1mhhdajLLNQGFbb/foR5r4jW236PWx8gUW+RyORUgC1TIZKS7OM5/
        OEZCJDB6NolltazuzRyCO3mkISevHzCgLmW9bvoW75wBPXb277mu1rGAoV3jwdF5pybyn8Qd
        KVRNTvlJvTXBn3C3wwP7AbceL/D6uCdUvsflkc8FHL0XuCqswLko5VKcyrznqm9fTmvA8yxn
        i4Q5EbFph8or0wT2F08q2P6w/b834YYTszOHnydFdGKXc4qOd1yUuyhBvzgnD+twaZna3bxI
        C97N9LySGHXEFF5PTOMjXstKWXGS75DpanmoJso6z+R9cD1o9Z22iLWtDQGL5w//tU6zEc+N
        +sitamDfaIZ+3v3o2KpNZX/KlvSWsOO/KMy3DsLJqH0LaaJlz2HjsvS9n5fqheqb0bvbSkW9
        4P1sKyngVIzMB9VxzH9RBwI9hQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSnG6sU0yCwfc7jBbb179gtZj68Amb
        xfwj51gtzja9Ybf4dqWDyWLT42usFpd3zWGzuNx8kdHic+8RRoul1y8yWTS1GFvcblzBZvHm
        x1kmizOnL7FatO49wm7x79pGFotrC9+zWky/K2Sx8auHg7DHmnlrGD0u9/UyeeycdZfdY9Oq
        TjaPO9f2sHlsXlLv0XJyP4vHlqvtLB59W1Yxehy/sZ3J4/MmuQDuKC6blNSczLLUIn27BK6M
        CbNmMBY838xY8fTdMeYGxu4uxi5GTg4JAROJqbM/s3YxcnEICexmlOhvWMsCkZCUmHbxKHMX
        IweQLSxx+HAxRM1bRomn/xqZQWqEBWIlfp2/xwKSEBG4xyzxbspvZhCHWeA5o8TS5qNsEC0P
        GSUu3D0Lto9NQEti/4sbbCA2v4CixNUfj8HivAJ2Eru7JoCtZhFQlTg14x6YLSoQJrFzyWMm
        iBpBiZMzn7CAnMQp4COx/nsESJhZQF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSehaR7FpKW
        WUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzgBaGnuYNy+6oPeIUYm
        DsZDjBIczEoivC3hEQlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2C
        yTJxcEo1MHX1sMu85WQT+li8K6Xm/tvFIa8bjx1e7PfmZd7b/YdOcHLM+L36yuILV1a36VWl
        TA63XXzdssY1/PtFftXoprPaF97IbXrOuq0kzy617/jbpblOv/8eXW/LmvDGSf57oH6++nwH
        m401sWUT9Q/+23h9qUd43rOsDRF7xZKbBewaGTpmm941uKpgVi5k5/fRoSKIKYvt3PPlmyL2
        H3xX+rJk63pWrUBv1Sl2Ls95mI89LfS57u5m+87g/a2XkS/N1TQ/WfL/a9wr2shvH3/rw5X1
        OWZn5mj/Z14lpO2cPmGd+bm6ZyL/q9aJvmB4Gx01eYXyxs3Ljtn1bv6ivFrZqb2kU7ZG7Vys
        1PRDF04E3FZiKc5INNRiLipOBAD0IH4vbwMAAA==
X-CMS-MailID: 20210325075717epcas1p25572937cd2b9db2fd81be6e6343998f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210323113411epcas1p3b4367563007ca91c30201d7fc225bb67
References: <1616499241-4906-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20210323113411epcas1p3b4367563007ca91c30201d7fc225bb67@epcas1p3.samsung.com>
        <1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

You are missing to add these patches to linux-pm mailing list.
Need to send them to linu-pm ML.

Also, before received this series, I tried to clean-up these patches
on testing branch[1]. So that I add my comment with my clean-up case.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov

And 'Saravana Kannan <skannan@codeaurora.org>' is wrong email address.
Please update the email or drop this email.


On 3/23/21 8:33 PM, Andrew-sh.Cheng wrote:
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
> after kernel-5.7
> Don't return -EINVAL in devfreq_passive_event_handler()
> since it doesn't handle DEVFREQ_GOV_SUSPEND DEVFREQ_GOV_RESUME cases.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> [Sibi: Integrated cpu-freqmap governor into passive_governor]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/Kconfig            |   2 +
>  drivers/devfreq/governor_passive.c | 329 +++++++++++++++++++++++++++++++++++--
>  include/linux/devfreq.h            |  29 +++-
>  3 files changed, 342 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 00704efe6398..f56132b0ae64 100644
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
> index b094132bd20b..9cc57b083839 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -8,11 +8,103 @@
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
> +struct devfreq_cpu_state {
> +	unsigned int curr_freq;
> +	unsigned int min_freq;
> +	unsigned int max_freq;
> +	unsigned int first_cpu;
> +	struct device *cpu_dev;
> +	struct opp_table *opp_table;
> +};

As I knew, the previous version has the description of structure
as following:  I wan to add the description like below.

And if you have no any objection, I'd like you to order
the variables as following and use 'dev' instead of 'cpu_dev'
because this patch use the 'cpu_state->cpu_dev' at the multiple points.
I think that 'cpu_state->dev' is better than 'cpu_state->cpu_dev'.
Also, I prefer to use 'cur_freq' instead of 'curr_freq'
because devfreq subsystem uses 'cur_freq' for expressing the 'current frequency'.

/**                                                                             
 * struct devfreq_cpu_state - Hold the per-cpu data                              
 * @dev:        reference to cpu device.                                        
 * @first_cpu:  the cpumask of the first cpu of a policy.                       
 * @opp_table:  reference to cpu opp table.                                     
 * @cur_freq:   the current frequency of the cpu.                               
 * @min_freq:   the min frequency of the cpu.                                   
 * @max_freq:   the max frequency of the cpu.                                   
 *                                                                              
 * This structure stores the required cpu_data of a cpu.                        
 * This is auto-populated by the governor.                                      
 */                                                                             
struct devfreq_cpu_state {                                                       
         struct device *dev;                                                     
         unsigned int first_cpu;                                                 

         struct opp_table *opp_table;                                            
         unsigned int cur_freq;                                                  
         unsigned int min_freq;                                                  
         unsigned int max_freq;                                                  
};               


> +
> +static unsigned long xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
> +					      unsigned int cpu)
> +{
> +	unsigned int cpu_min_freq, cpu_max_freq, cpu_curr_freq_khz, cpu_percent;
> +	unsigned long dev_min_freq, dev_max_freq, dev_max_state;
> +
> +	struct devfreq_cpu_state *cpu_state = data->cpu_state[cpu];
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	unsigned long *dev_freq_table = devfreq->profile->freq_table;
> +	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
> +	unsigned long cpu_curr_freq, freq;
> +
> +	if (!cpu_state || cpu_state->first_cpu != cpu ||
> +	    !cpu_state->opp_table || !devfreq->opp_table)
> +		return 0;
> +
> +	cpu_curr_freq = cpu_state->curr_freq * 1000;
> +	p_opp = devfreq_recommended_opp(cpu_state->cpu_dev, &cpu_curr_freq, 0);
> +	if (IS_ERR(p_opp))
> +		return 0;
> +
> +	opp = dev_pm_opp_xlate_required_opp(cpu_state->opp_table,
> +					    devfreq->opp_table, p_opp);
> +	dev_pm_opp_put(p_opp);
> +
> +	if (!IS_ERR(opp)) {
> +		freq = dev_pm_opp_get_freq(opp);
> +		dev_pm_opp_put(opp);
> +		goto out;
> +	}
> +
> +	/* Use Interpolation if required opps is not available */
> +	cpu_min_freq = cpu_state->min_freq;
> +	cpu_max_freq = cpu_state->max_freq;
> +	cpu_curr_freq_khz = cpu_state->curr_freq;
> +
> +	if (dev_freq_table) {
> +		/* Get minimum frequency according to sorting order */
> +		dev_max_state = dev_freq_table[devfreq->profile->max_state - 1];
> +		if (dev_freq_table[0] < dev_max_state) {
> +			dev_min_freq = dev_freq_table[0];
> +			dev_max_freq = dev_max_state;
> +		} else {
> +			dev_min_freq = dev_max_state;
> +			dev_max_freq = dev_freq_table[0];
> +		}
> +	} else {
> +		dev_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +						     DEV_PM_QOS_MIN_FREQUENCY);
> +		dev_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +						     DEV_PM_QOS_MAX_FREQUENCY);
> +
> +		if (dev_max_freq <= dev_min_freq)
> +			return 0;
> +	}
> +	cpu_percent = ((cpu_curr_freq_khz - cpu_min_freq) * 100) / cpu_max_freq - cpu_min_freq;
> +	freq = dev_min_freq + mult_frac(dev_max_freq - dev_min_freq, cpu_percent, 100);
> +
> +out:
> +	return freq;
> +}
> +
> +static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
> +					unsigned long *freq)
> +{
> +	struct devfreq_passive_data *p_data =
> +				(struct devfreq_passive_data *)devfreq->data;
> +	unsigned int cpu;
> +	unsigned long target_freq = 0;
> +
> +	for_each_online_cpu(cpu)
> +		target_freq = max(target_freq,
> +				  xlate_cpufreq_to_devfreq(p_data, cpu));
> +
> +	*freq = target_freq;
> +
> +	return 0;
> +}

As you knew, governor_passive.c was already used 
both 'dev_pm_opp_xlate_required_opp' and 'devfreq_recommended_opp'
to get the target from OPP. So, I wan to make the common function
like 'get_taget_freq_by_required_opp' as following:
If define 'get_taget_freq_by_required_opp' as following,
it will be used for get_target_freq_with_devfreq().
After finisied the review of this patch, I'll send the patch[2].
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing-passive-gov&id=101c5a087586ab2b5cf3370166a7e39227ca83cf

For example but this code is not tested,
static unsigned long get_taget_freq_by_required_opp(struct device *p_dev,
						struct opp_table *p_opp_table,
						struct opp_table *opp_table,
						unsigned long freq)
{
	struct dev_pm_opp *opp = NULL, *p_opp = NULL;

	if (!p_dev || !p_opp_table || !opp_table || !freq)
		return 0;

	p_opp = devfreq_recommended_opp(p_dev, &freq, 0);
	if (IS_ERR(p_opp))
		return 0;

	opp = dev_pm_opp_xlate_required_opp(p_opp_table, opp_table, p_opp);
	dev_pm_opp_put(p_opp);

	if (IS_ERR(opp))
		return 0;

	freq = dev_pm_opp_get_freq(opp);
	dev_pm_opp_put(opp);

	return freq;
}

static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
					unsigned long *target_freq)
{
	struct devfreq_passive_data *p_data =
				(struct devfreq_passive_data *)devfreq->data;
	struct devfreq_cpu_data *cpu_data;
	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
	unsigned long dev_min, dev_max;
	unsigned long freq = 0;

	for_each_online_cpu(cpu) {
		cpu_data = p_data->cpu_data[cpu];
		if (!cpu_data || cpu_data->first_cpu != cpu)
			continue;

		/* Get target freq via required opps */
		cpu_cur = cpu_data->cur_freq * HZ_PER_KHZ;
		freq = get_taget_freq_by_required_opp(cpu_data->dev,
					cpu_data->opp_table,
					devfreq->opp_table, cpu_cur);
		if (freq) {
			*target_freq = max(freq, *target_freq);
			continue;
		}

		/* Use Interpolation if required opps is not available */
		devfreq_get_freq_range(devfreq, &dev_min, &dev_max);

		cpu_min = cpu_data->min_freq;
		cpu_max = cpu_data->max_freq;
		cpu_cur = cpu_data->cur_freq;

		cpu_percent = ((cpu_cur - cpu_min) * 100) / cpu_max - cpu_min;
		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);

		*target_freq = max(freq, *target_freq);
	}

	return 0;
}

> +
> +static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>  					unsigned long *freq)
>  {
>  	struct devfreq_passive_data *p_data
> @@ -23,14 +115,6 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	int i, count;
>  
>  	/*
> -	 * If the devfreq device with passive governor has the specific method
> -	 * to determine the next frequency, should use the get_target_freq()
> -	 * of struct devfreq_passive_data.
> -	 */
> -	if (p_data->get_target_freq)
> -		return p_data->get_target_freq(devfreq, freq);
> -
> -	/*
>  	 * If the parent and passive devfreq device uses the OPP table,
>  	 * get the next frequency by using the OPP table.
>  	 */
> @@ -98,6 +182,37 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	return 0;
>  }
>  
> +static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> +					   unsigned long *freq)
> +{
> +	struct devfreq_passive_data *p_data =
> +		(struct devfreq_passive_data *)devfreq->data;
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
>  static int devfreq_passive_notifier_call(struct notifier_block *nb,
>  				unsigned long event, void *ptr)
>  {
> @@ -130,16 +245,200 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
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
> +	struct cpufreq_freqs *cpu_freq = ptr;

Use 'freqs' variable name.  I prefer to use the same variable name
for both devfreq_freqs and cpufreq_freqs instance.

> +	unsigned int curr_freq;

As I commented above, better to use 'cur_frq' instead of 'curr_freq'
if there is no any special reason.

> +	int ret;
> +
> +	if (event != CPUFREQ_POSTCHANGE || !cpu_freq ||
> +	    !data->cpu_state[cpu_freq->policy->cpu])
> +		return 0;
> +
> +	cpu_state = data->cpu_state[cpu_freq->policy->cpu];
> +	if (cpu_state->curr_freq == cpu_freq->new)
> +		return 0;
> +
> +	/* Backup current freq and pre-update cpu state freq*/

I think that this commnet is not critial. So, please drop this comment.

> +	curr_freq = cpu_state->curr_freq;
> +	cpu_state->curr_freq = cpu_freq->new;
> +
> +	mutex_lock(&devfreq->lock);
> +	ret = update_devfreq(devfreq);

I recommend to use 'devfreq_update_target' instead of 'update_devfreq'
as following:
	devfreq_update_target(devfreq, freqs->new);

> +	mutex_unlock(&devfreq->lock);
> +	if (ret) {
> +		cpu_state->curr_freq = curr_freq;
> +		dev_err(&devfreq->dev, "Couldn't update the frequency.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cpufreq_passive_register(struct devfreq_passive_data **p_data)

In order to keep the consistent style of function name,
please change the name as following because devfreq defines
the function name as 'devfreq_regiter_notifier'
- cpufreq_passive_register -> cpufreq_passive_register_notifier

> +{
> +	struct devfreq_passive_data *data = *p_data;
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	struct device *dev = devfreq->dev.parent;
> +	struct opp_table *opp_table = NULL;
> +	struct devfreq_cpu_state *cpu_state;
> +	struct cpufreq_policy *policy;
> +	struct device *cpu_dev;
> +	unsigned int cpu;
> +	int ret;
> +
> +	get_online_cpus();
> +
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

Don't need this comment. Please drop it.

> +	for_each_online_cpu(cpu) {
> +		if (data->cpu_state[cpu])
> +			continue;
> +
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy) {
> +			ret = -EINVAL;
> +			goto out;
> +		} else if (PTR_ERR(policy) == -EPROBE_DEFER) {
> +			ret = -EPROBE_DEFER;
> +			goto out;
> +		} else if (IS_ERR(policy)) {
> +			ret = PTR_ERR(policy);
> +			dev_err(dev, "Couldn't get the cpufreq_poliy.\n");
> +			goto out;
> +		}

Use dev_err_probe() funciotn to handle hte EPROBE_DEFER.
It make code more simple.

> +
> +		cpu_state = kzalloc(sizeof(*cpu_state), GFP_KERNEL);
> +		if (!cpu_state) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev) {
> +			dev_err(dev, "Couldn't get cpu device.\n");
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +
> +		opp_table = dev_pm_opp_get_opp_table(cpu_dev);
> +		if (IS_ERR(devfreq->opp_table)) {
> +			ret = PTR_ERR(opp_table);
> +			goto out;
> +		}
> +
> +		cpu_state->cpu_dev = cpu_dev;
> +		cpu_state->opp_table = opp_table;
> +		cpu_state->first_cpu = cpumask_first(policy->related_cpus);
> +		cpu_state->curr_freq = policy->cur;
> +		cpu_state->min_freq = policy->cpuinfo.min_freq;
> +		cpu_state->max_freq = policy->cpuinfo.max_freq;
> +		data->cpu_state[cpu] = cpu_state;
> +
> +		cpufreq_cpu_put(policy);
> +	}
> +
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

As I commented above, please change the name as following:
- cpufreq_passive_unregister -> cpufreq_passive_unregister_notifier

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
> +int register_parent_dev_notifier(struct devfreq_passive_data **p_data)
> +{
> +	struct notifier_block *nb = &(*p_data)->nb;
> +	int ret = 0;
> +
> +	switch ((*p_data)->parent_type) {
> +	case DEVFREQ_PARENT_DEV:
> +		nb->notifier_call = devfreq_passive_notifier_call;
> +		ret = devfreq_register_notifier((struct devfreq *)(*p_data)->parent, nb,
> +						DEVFREQ_TRANSITION_NOTIFIER);
> +		break;
> +	case CPUFREQ_PARENT_DEV:
> +		ret = cpufreq_passive_register(p_data);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +int unregister_parent_dev_notifier(struct devfreq_passive_data **p_data)
> +{
> +	int ret = 0;
> +
> +	switch ((*p_data)->parent_type) {
> +	case DEVFREQ_PARENT_DEV:
> +		WARN_ON(devfreq_unregister_notifier((struct devfreq *)(*p_data)->parent,
> +						    &(*p_data)->nb,
> +						    DEVFREQ_TRANSITION_NOTIFIER));
> +		break;
> +	case CPUFREQ_PARENT_DEV:
> +		cpufreq_passive_unregister(p_data);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}

I think that you don't need to define register_parent_dev_notifier
and unregister_parent_dev_notifier as the separate functions.

Instead of the separate functions, just add the code
into devfreq_passive_event_handler.


> +
>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  				unsigned int event, void *data)
>  {
>  	struct devfreq_passive_data *p_data
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent = (struct devfreq *)p_data->parent;
> -	struct notifier_block *nb = &p_data->nb;
>  	int ret = 0;
>  
> -	if (!parent)
> +	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>  		return -EPROBE_DEFER;
>  
>  	switch (event) {
> @@ -147,13 +446,11 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  		if (!p_data->this)
>  			p_data->this = devfreq;
>  
> -		nb->notifier_call = devfreq_passive_notifier_call;
> -		ret = devfreq_register_notifier(parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER);
> +		ret = register_parent_dev_notifier(&p_data);
>  		break;
> +
>  	case DEVFREQ_GOV_STOP:
> -		WARN_ON(devfreq_unregister_notifier(parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER));
> +		ret = unregister_parent_dev_notifier(&p_data);
>  		break;
>  	default:
>  		break;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..e0093b7c805c 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -280,6 +280,25 @@ struct devfreq_simple_ondemand_data {
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
> +struct devfreq_cpu_state;
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
> @@ -290,13 +309,15 @@ struct devfreq_simple_ondemand_data {
>   *			using governors except for passive governor.
>   *			If the devfreq device has the specific method to decide
>   *			the next frequency, should use this callback.
> + * @parent_type:	parent type of the device
>   * @this:	the devfreq instance of own device.
>   * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
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
> @@ -305,9 +326,13 @@ struct devfreq_passive_data {
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

