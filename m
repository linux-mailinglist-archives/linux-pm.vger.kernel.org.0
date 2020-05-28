Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79BC1E5735
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 08:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgE1GEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 02:04:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44126 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgE1GEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 02:04:25 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200528060417epoutp01d5e518fc1f901db490d3b7d6e40e1aa1~TG-rbWI302406824068epoutp013
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 06:04:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200528060417epoutp01d5e518fc1f901db490d3b7d6e40e1aa1~TG-rbWI302406824068epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590645857;
        bh=bsWWGBc7XFv7+O4U9b6YFrCFo8z9ka4wANPexUZ1KK0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NS75LoYzmyGS61GA+UbhhOYNgd2ksapOo8dAXEMDAioeg5Yz3omt/7eGG2r6ze5nA
         ow8vbFVSJYIlVISn7ZGMH87CTEPWmP3GnXDqXEVjmna1uKlBbueBfQDhOlNo9DJeVi
         xaCus364AMorsSsSMgS6KWapD7ch6OOlImVY90Nc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200528060416epcas1p1b8d0948a3b164930d2ace585e6992758~TG-qnSoPu0417904179epcas1p1h;
        Thu, 28 May 2020 06:04:16 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49XcbL0PZFzMqYkf; Thu, 28 May
        2020 06:04:14 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.3D.04395.D545FCE5; Thu, 28 May 2020 15:04:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200528060413epcas1p4567f813b4524d36985cd4862c36f2347~TG-niNbI71578115781epcas1p4W;
        Thu, 28 May 2020 06:04:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200528060413epsmtrp2160ad869cc83b4215c4a4a1afe529840~TG-ng47Rn3138131381epsmtrp2L;
        Thu, 28 May 2020 06:04:13 +0000 (GMT)
X-AuditID: b6c32a39-46b9a9e00000112b-27-5ecf545d28f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.4D.08382.D545FCE5; Thu, 28 May 2020 15:04:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200528060413epsmtip1ec9a316f45ef34a1be0805bd46df56d8~TG-nKCf7o2629926299epsmtip1I;
        Thu, 28 May 2020 06:04:13 +0000 (GMT)
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
        srv_heupstream@mediatek.com, Sibi Sankar <sibis@codeaurora.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <64b81eea-641c-811d-9830-718b28db4188@samsung.com>
Date:   Thu, 28 May 2020 15:14:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200520034307.20435-7-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJsWRmVeSWpSXmKPExsWy7bCmnm5syPk4g2tvbSy2r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbXFr5ntZh+V8hi41cPB2GPNfPWMHpc7utl8tg56y67x6ZV
        nWwed67tYfPYvKTeo+XkfhaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHcUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDPKSmUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM05u0ijYtJixYt+OCcwN
        jCsaGLsYOTkkBEwkdjV/Y+1i5OIQEtjBKHF/2Rs2COcTo0TzjmOMEM43Rolnqw6yw7Ssmnyf
        BSKxl1Fi9sWjzBDOe0aJNXvOglUJC8RIvNnbzwxiiwjcZpaYMDsEpIhZ4DmjxKemNSwgCTYB
        LYn9L26wgdj8AooSV388BruKV8BOovnpAbBmFgFVifn/F4PFRQXCJE5ua4GqEZQ4OfMJ2BxO
        ASeJ9ydmgNnMAuISt57MZ4Kw5SW2v53DDHH2fE6J9iUCXYwcQLaLxNJ5ohBhYYlXx7dAfSYl
        8fndXjYIu1pi5ckj4LCQEOhglNiy/wIrRMJYYv/SyUwgc5gFNCXW79KHCCtK7Pw9lxFiLZ/E
        u689rBCreCU62oQgSpQlLj+4ywRhS0osbu9km8CoNAvJM7OQPDALyQOzEJYtYGRZxSiWWlCc
        m55abFhgihzdmxjBKV/LcgfjsXM+hxgFOBiVeHgNPM7FCbEmlhVX5h5ilOBgVhLhdTp7Ok6I
        NyWxsiq1KD++qDQntfgQoykwrCcyS4km5wPzUV5JvKGpkbGxsYWJoZmpoaGSOO/8H2fihATS
        E0tSs1NTC1KLYPqYODilGhi3/9zvaDFfvfnrptDHD7ivKN24NOW9eKan56U9gpk8F59NzvWP
        Fe8pad0tsDr9zKx3myc8t5zREV8x1XjVq+t3EtS7FhbbSZkGWUZETrm0voKvx3jC1UeZuekv
        dRqE9kwT/+EV+r/J9Z5D6jafPaaLzq7kbOGrZLSe6KVyNiQvvOvlMnsGvnYlluKMREMt5qLi
        RACDlyTIDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSnG5syPk4g2+r+C22r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbXFr5ntZh+V8hi41cPB2GPNfPWMHpc7utl8tg56y67x6ZV
        nWwed67tYfPYvKTeo+XkfhaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHcUVw2Kak5mWWpRfp2CVwZ
        JzdpFGxazFixb8cE5gbGFQ2MXYycHBICJhKrJt9n6WLk4hAS2M0ocevIDiaIhKTEtItHmbsY
        OYBsYYnDh4shat4ySjRc2Q/WLCwQI/Fmbz8zSEJE4D6zxPK7V9lAHGaB54wSS5uPskG0nGWU
        +N3zDayFTUBLYv+LG2wgNr+AosTVH4/B4rwCdhLNTw8wg9gsAqoS8/8vBouLCoRJ7FzymAmi
        RlDi5MwnLCA2p4CTxPsTM8BsZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYh
        aZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgBKCluYNx+6oPeocYmTgY
        DzFKcDArifA6nT0dJ8SbklhZlVqUH19UmpNafIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILUIpgs
        EwenVAPT6ky9yO8uUinuLgwZt9Sfm75Lf7lPe2fHVpH7B54q7J2Veujszk/f/xi0pzdbv5nf
        +vt/0a6PVee/Wqk8k209fi7wmvuC42VTu5lXLTY+tf50THfKO80HP7Q3PL407aNH1uZu73qz
        8JlvHj84a/9L5pP0vZ4qy7LOcMtPu2e/fJaXfbN0m+fL82KzguMu+PqE3N1gb9j5Iql0SRiv
        d42O9Hdpi2m8E8Jja8JVZvlbclk3Xp8Yfktvfu3dtx2cQkdnTK58qzbxxuSrSfNLD+Qcvm8x
        7UPgZaEl8es0Q1QmVZ7Tl9vz7jjntl8Lb3892hqRIBfvv/JfxyP+Lasyg2b/T1lt/L3EiveL
        5Dnx8ski0UosxRmJhlrMRcWJAKveo6FvAwAA
X-CMS-MailID: 20200528060413epcas1p4567f813b4524d36985cd4862c36f2347
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


And the following email is not valid. So, I dropped this email
from Cc list.
Saravana Kannan <skannan@codeaurora.org>


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
