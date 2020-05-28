Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D21E582D
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 09:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgE1HHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 03:07:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:25678 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgE1HHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 03:07:14 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200528070708epoutp01061c022c00ebfd7a1cb8c6b3207c39e3~TH2jYN_qM1470314703epoutp01X
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 07:07:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200528070708epoutp01061c022c00ebfd7a1cb8c6b3207c39e3~TH2jYN_qM1470314703epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590649628;
        bh=CiG6BB1PuYpGEojCVeeKBD6x3ygZzpcBt7Es2xx2lZs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FLAwhwlV0b932esAkAupnM1SOf26Acex/zXRsWd2VV6ab9C8Wd9LhvdrRzjFeWxkD
         bmt36dN4dyL3EPaVUO1to4J1FDESrgY90bYV7B9LiyD51VefIbnTOYRJGF4aWO/fAN
         TJXkOOBUv64KRchIapA3rkRAooPOPHdf049IjwuI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200528070707epcas1p15255cb8b7c89c47ff9de311c5eec534f~TH2ivV3km3190131901epcas1p1I;
        Thu, 28 May 2020 07:07:07 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49Xdzs416mzMqYl3; Thu, 28 May
        2020 07:07:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.3C.04388.9136FCE5; Thu, 28 May 2020 16:07:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200528070704epcas1p28e7d1b06ef8e9c2e679542eb17941f52~TH2f6sDVO2041720417epcas1p2D;
        Thu, 28 May 2020 07:07:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200528070704epsmtrp22016e4512d7fee9b7704da54eef992e0~TH2f5neu13022430224epsmtrp2i;
        Thu, 28 May 2020 07:07:04 +0000 (GMT)
X-AuditID: b6c32a35-c84b79e000001124-d8-5ecf63192c80
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.C2.08303.8136FCE5; Thu, 28 May 2020 16:07:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200528070704epsmtip24c47dd7d69cb0a2ddff39e51688154c3~TH2fhU0zI0117301173epsmtip2R;
        Thu, 28 May 2020 07:07:04 +0000 (GMT)
Subject: Re: [PATCH 06/12] PM / devfreq: Add cpu based scaling support to
 passive_governor
From:   Chanwoo Choi <cw00.choi@samsung.com>
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
Organization: Samsung Electronics
Message-ID: <7ad35770-9327-084a-d2ca-1646cabd0a4d@samsung.com>
Date:   Thu, 28 May 2020 16:17:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <64b81eea-641c-811d-9830-718b28db4188@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbZRzH8/R614JWz5bJb426cs4loIXeSufDhPnGzEW3SKKZ8SV0l3IC
        oW/plek0cQxxY0S2mY0oBcFF2AtpRLBCQbGxdMFmUMAC25xsElicC25kgKI4tO2xyH/f5/d8
        P/n9vs+LklCvUFplqd0tuOy8laGS5V396Xr9estwoeHr/g24u/0aieumZijcHIqQeKhyVoH/
        GKuW4c7pCRJHexspHH1/FOH52hDCredHZbiyyogv7T9N4dmlIRkePPcjiT/oCynwykSHHE+c
        uEnijyfVuGORe0rDeZu8iIserpVxPZ5JBdfZdojifp74luK+atnHVYUDcs43flDOHfa1IW7g
        QreMm+98qOCu18pySwS+SHDpBLvFUVRqL85jXnjJ/KzZtMXA6tkc/Dijs/M2IY/J31Ggf67U
        GgvH6Pbw1vJYqYAXRSZrW67LUe4WdCUO0Z3HCM4iqzPHmSnyNrHcXpxpcdi2sgbDZlPMuLus
        pPbsOOX0fonebgq1oAo0UoNqUJIS6Gy4EqxTxLWa9iM4HthVg5Jj+haC7yMjlLSYR9DoHaPu
        ENHf/kHSRi+C+q4+QlrcRLAQvSyPuzT0GzDbd4SIa4rOgMC1Cwk6hb5EwNGGl+MAQf+K4Fal
        NwHcS6fB+NJ0YigVvQ2+OH0mAcjpR+CHU2cTA66jd0G4q2rVcx+E62cSbBL9JFxZ8Sf8BJ0K
        P800yyS9Abp/b0xMB3RDEnT4FkgpQz6cP9m8mkcD1wd8CklrYf5G32r9XTgTDlESXI3AFxhZ
        hY0QaD0W66CMdUiH9t4sqZwGPcufIqnxPXBj8UMybgFaBdUH1JLlYYj+MimT9Hr4/OAh6ihi
        PGvieNZE8KyJ4Pm/2WdI3obuF5yirVgQWSe79sI7UeLtZ5j86HhkRxDRSsTcrTJwkUI1ye8R
        99qCCJQEk6J6ZuhcoVpVxO99R3A5zK5yqyAGkSl22h8R2nUWR+wn2d1m1rTZaDTibHaLiWWZ
        VFXz0mChmi7m3UKZIDgF1x1OpkzSVqBXkq8bL29d/ve9zBP1KQuB/Ncvmn0bN+n7X9TRy/4D
        pj+7W9tzT5LpaUdacpavGu2eudtdPZ+MfXebe4DUPDaqiVrmdlMj1u3DF9vqpvypQe2+TRXe
        YNPcqxnbFzXDb07/tfPq8w07H8z6e+Nb+ieetlYey56awwP7wy79N6caByNZjzJysYRnMwiX
        yP8HJ8vIKBEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSvK5E8vk4g/ZZOhbb179gtZj68Amb
        xfwj51gtzja9Ybf4dqWDyWLT42usFpd3zWGzuNx8kdHic+8RRoul1y8yWTS1GFvcblzBZvHm
        x1kmizOnL7FatO49wm7x79pGFotrC9+zWky/K2Sx8auHg7DHmnlrGD0u9/UyeeycdZfdY9Oq
        TjaPO9f2sHlsXlLv0XJyP4vHlqvtLB59W1Yxehy/sZ3J4/MmuQDuKC6blNSczLLUIn27BK6M
        3qNX2QrWbGCsmHdkCWMD44Uuxi5GTg4JAROJyy//ANlcHEICOxglWmefZYZISEpMu3gUyOYA
        soUlDh8uBgkLCbxllNhyNA3EFhaIkXiztx+snE1AS2L/ixtsIHNEBO4zSyy/exXMYRZ4ziix
        tPkoG0R3E5PE2y2yIDa/gKLE1R+Pwa7gFbCTWLdiJVgNi4CqxInlR9lBbFGBMImdSx4zQdQI
        Spyc+YQFxOYUsJe4/28HWD2zgLrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg8C0n7LCQts5C0
        zELSsoCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnD8a2ntYNyz6oPeIUYmDsZD
        jBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/06a2GckEB6YklqdmpqQWoRTJaJ
        g1OqgUmuz2bp70LdzhVinRGlHxMW/xfYlBua6X5zXcbO+do1OkzPJvy34fwje3K5wmH7E9sC
        k0vlNu7ZpRW42ORV8YOlgl4terUznq3YdEPkwB41nQ7xQytMd4QqnzRTE6q5eqj1he2TymPr
        o48J/U+O0TnatFxEJcQhtqrJWpWDjS960bX+hqN3cpwnvZ3vsSDhjEeF25ojkuGhfgfOSD5y
        2//ZY8Fbhb/GVUf4bPqefkoXvfBJeXYuw8qYo/9YpWbc39KT9lqJxeH11elJyf4zS7b+nnX3
        w2nNk/IP22zD5wUrrdD7UOBSJTH1+4H8he6rln9MUqpwl7gh7LjprKk4X3F/W19Da96VP12G
        LUXab5RYijMSDbWYi4oTAZFsXnduAwAA
X-CMS-MailID: 20200528070704epcas1p28e7d1b06ef8e9c2e679542eb17941f52
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
        <64b81eea-641c-811d-9830-718b28db4188@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrew-sh.Cheng,

The exynos-bus.c used the passive governor.
Even if don't make the problem because DEVFREQ_PARENT_DEV is zero,
you need to initialize the parent_type with DEVFREQ_PARENT_DEV as following:

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 8fa8eb541373..1c71c47bc2ac 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -369,6 +369,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
                return -ENOMEM;
 
        passive_data->parent = parent_devfreq;
+       passive_data->parent_type = DEVFREQ_PARENT_DEV;
 
        /* Add devfreq device for exynos bus with passive governor */
        bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,


On 5/28/20 3:14 PM, Chanwoo Choi wrote:
> Hi Andrew-sh.Cheng,
> 
> Thanks for your posting. I like this approach absolutely.
> I think that it is necessary. When I developed the embedded product,
> I needed this feature always. 
> 
> I add the comments on below.
> 
> 
> And the following email is not valid. So, I dropped this email
> from Cc list.
> Saravana Kannan <skannan@codeaurora.org>
> 
> 
> On 5/20/20 12:43 PM, Andrew-sh.Cheng wrote:
>> From: Saravana Kannan <skannan@codeaurora.org>
>>
>> Many CPU architectures have caches that can scale independent of the
>> CPUs. Frequency scaling of the caches is necessary to make sure that the
>> cache is not a performance bottleneck that leads to poor performance and
>> power. The same idea applies for RAM/DDR.
>>
>> To achieve this, this patch adds support for cpu based scaling to the
>> passive governor. This is accomplished by taking the current frequency
>> of each CPU frequency domain and then adjust the frequency of the cache
>> (or any devfreq device) based on the frequency of the CPUs. It listens
>> to CPU frequency transition notifiers to keep itself up to date on the
>> current CPU frequency.
>>
>> To decide the frequency of the device, the governor does one of the
>> following:
>> * Derives the optimal devfreq device opp from required-opps property of
>>   the parent cpu opp_table.
>>
>> * Scales the device frequency in proportion to the CPU frequency. So, if
>>   the CPUs are running at their max frequency, the device runs at its
>>   max frequency. If the CPUs are running at their min frequency, the
>>   device runs at its min frequency. It is interpolated for frequencies
>>   in between.
>>
>> Andrew-sh.Cheng change
>> dev_pm_opp_xlate_opp to dev_pm_opp_xlate_required_opp devfreq->max_freq
>> to devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value
>> for kernel-5.7
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> [Sibi: Integrated cpu-freqmap governor into passive_governor]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
>> ---
>>  drivers/devfreq/Kconfig            |   2 +
>>  drivers/devfreq/governor_passive.c | 278 ++++++++++++++++++++++++++++++++++---
>>  include/linux/devfreq.h            |  40 +++++-
>>  3 files changed, 299 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 0b1df12e0f21..d9067950af6a 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -73,6 +73,8 @@ config DEVFREQ_GOV_PASSIVE
>>  	  device. This governor does not change the frequency by itself
>>  	  through sysfs entries. The passive governor recommends that
>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>> +	  Alternatively the governor can also be chosen to scale based on
>> +	  the online CPUs current frequency.
>>  
>>  comment "DEVFREQ Drivers"
>>  
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> index 2d67d6c12dce..7dcda02a5bb7 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -8,11 +8,89 @@
>>   */
>>  
>>  #include <linux/module.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/cpumask.h>
>>  #include <linux/device.h>
>>  #include <linux/devfreq.h>
>> +#include <linux/slab.h>
>>  #include "governor.h"
>>  
>> -static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>> +static unsigned int xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
> 
> Need to change 'unsigned int' to 'unsigned long'.
> 
>> +					     unsigned int cpu)
>> +{
>> +	unsigned int cpu_min, cpu_max, dev_min, dev_max, cpu_percent, max_state;
> 
> Better to define them separately as following and then need to rename
> the variable. Usually, use the 'min_freq' and 'max_freq' word for
> the minimum/maximum frequency.
> 
> 	unsigned int cpu_min_freq, cpu_max_freq, cpu_curr_freq, cpu_percent;
> 	unsigned long dev_min_freq, dev_max_freq, dev_max_state,
> 
> The devfreq used 'unsigned long'. The cpufreq used 'unsigned long'
> and 'unsigned int'. You need to handle them properly.
> 
> 
>> +	struct devfreq_cpu_state *cpu_state = data->cpu_state[cpu];
>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>> +	unsigned long *freq_table = devfreq->profile->freq_table;
> 
> In this function, use 'cpu' work for cpufreq and use 'dev' for devfreq.
> So, I think 'dev_freq_table' is proper name instead of 'freq_table'
> for the readability.
> 
> 	freq_table -> dev_freq_table
> 
>> +	struct dev_pm_opp *opp = NULL, *cpu_opp = NULL;
> 
> In the get_target_freq_with_devfreq(), use 'p_opp' indicating
> the OPP of parent device. For the consistency, I think that
> use 'p_opp' instead of 'cpu_opp'. 
> 
>> +	unsigned long cpu_freq, freq;
> 
> Define the 'cpu_freq' on above with cpu_min_freq/cpu_max_freq definition.
> 	cpu_freq -> cpu_curr_freq.
> 
>> +
>> +	if (!cpu_state || cpu_state->first_cpu != cpu ||
>> +	    !cpu_state->opp_table || !devfreq->opp_table)
>> +		return 0;
>> +
>> +	cpu_freq = cpu_state->freq * 1000;
>> +	cpu_opp = devfreq_recommended_opp(cpu_state->dev, &cpu_freq, 0);
>> +	if (IS_ERR(cpu_opp))
>> +		return 0;
>> +
>> +	opp = dev_pm_opp_xlate_required_opp(cpu_state->opp_table,
>> +					    devfreq->opp_table, cpu_opp);
>> +	dev_pm_opp_put(cpu_opp);
>> +
>> +	if (!IS_ERR(opp)) {
>> +		freq = dev_pm_opp_get_freq(opp);
>> +		dev_pm_opp_put(opp);
> 
> Better to add the 'out' goto statement.
> If you use 'goto out', you can reduce the one indentation
> without 'else' statement.
> 	
> 
>> +	} else {
> 
> As I commented, when dev_pm_opp_xlate_required_opp() return successfully
> , use 'goto out'. We can remove 'else' and then reduce the unneeded indentation.
> 
> 
>> +		/* Use Interpolation if required opps is not available */
>> +		cpu_min = cpu_state->min_freq;
>> +		cpu_max = cpu_state->max_freq;
>> +		cpu_freq = cpu_state->freq;
>> +
>> +		if (freq_table) {
>> +			/* Get minimum frequency according to sorting order */
>> +			max_state = freq_table[devfreq->profile->max_state - 1];
>> +			if (freq_table[0] < max_state) {
>> +				dev_min = freq_table[0];
>> +				dev_max = max_state;
>> +			} else {
>> +				dev_min = max_state;
>> +				dev_max = freq_table[0];
>> +			}
>> +		} else {
>> +			if (devfreq->user_max_freq_req.data.freq.qos->max_freq.target_value
>> +			    <= devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value)
>> +				return 0;
>> +			dev_min =
>> +			devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value;
>> +			dev_max =
>> +			devfreq->user_max_freq_req.data.freq.qos->max_freq.target_value;
> 
> I think it is not proper to access the variable of pm_qos structure directly.
> Instead of direct access, you have to use the exported PM QoS function such as
> - pm_qos_read_value(devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY);
> - pm_qos_read_value(devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY);
> 
>> +		}
>> +		cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
>> +		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
>> +	}
> 
> 
> I think that you better to add 'out' jump label as following:
> 
> out:
> 
>> +
>> +	return freq;
>> +}
>> +
>> +static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
>> +					unsigned long *freq)
>> +{
>> +	struct devfreq_passive_data *p_data =
>> +				(struct devfreq_passive_data *)devfreq->data;
>> +	unsigned int cpu, target_freq = 0;
> 
> Need to define 'target_freq' with 'unsigned long' type.
> 
>> +
>> +	for_each_online_cpu(cpu)
>> +		target_freq = max(target_freq,
>> +				  xlate_cpufreq_to_devfreq(p_data, cpu));
>> +
>> +	*freq = target_freq;
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>>  					unsigned long *freq)
>>  {
>>  	struct devfreq_passive_data *p_data
>> @@ -23,16 +101,6 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>  	int i, count, ret = 0;
>>  
>>  	/*
>> -	 * If the devfreq device with passive governor has the specific method
>> -	 * to determine the next frequency, should use the get_target_freq()
>> -	 * of struct devfreq_passive_data.
>> -	 */
>> -	if (p_data->get_target_freq) {
>> -		ret = p_data->get_target_freq(devfreq, freq);
>> -		goto out;
>> -	}
>> -
>> -	/*
>>  	 * If the parent and passive devfreq device uses the OPP table,
>>  	 * get the next frequency by using the OPP table.
>>  	 */
>> @@ -102,6 +170,37 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>  	return ret;
>>  }
>>  
>> +static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>> +					   unsigned long *freq)
>> +{
>> +	struct devfreq_passive_data *p_data =
>> +				(struct devfreq_passive_data *)devfreq->data;
>> +	int ret;
>> +
>> +	/*
>> +	 * If the devfreq device with passive governor has the specific method
>> +	 * to determine the next frequency, should use the get_target_freq()
>> +	 * of struct devfreq_passive_data.
>> +	 */
>> +	if (p_data->get_target_freq)
>> +		return p_data->get_target_freq(devfreq, freq);
>> +
>> +	switch (p_data->parent_type) {
>> +	case DEVFREQ_PARENT_DEV:
>> +		ret = get_target_freq_with_devfreq(devfreq, freq);
>> +		break;
>> +	case CPUFREQ_PARENT_DEV:
>> +		ret = get_target_freq_with_cpufreq(devfreq, freq);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		dev_err(&devfreq->dev, "Invalid parent type\n");
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>  {
>>  	int ret;
>> @@ -156,6 +255,140 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>>  	return NOTIFY_DONE;
>>  }
>>  
>> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
>> +					 unsigned long event, void *ptr)
>> +{
>> +	struct devfreq_passive_data *data =
>> +			container_of(nb, struct devfreq_passive_data, nb);
>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>> +	struct devfreq_cpu_state *cpu_state;
>> +	struct cpufreq_freqs *freq = ptr;
> 
> How about changing 'freq' to 'cpu_freqs'?
> 
> In the drivers/cpufreq/cpufreq.c, use 'freqs' name indicating
> the instance of 'struct cpufreq_freqs'. And in order to
> identfy, how about adding 'cpu_' prefix for variable name?
> 
>> +	unsigned int current_freq;
> 
> Need to define curr_freq with 'unsigned long' type
> and better to use 'curr_freq' variable name.
> 
>> +	int ret;
>> +
>> +	if (event != CPUFREQ_POSTCHANGE || !freq ||
>> +	    !data->cpu_state[freq->policy->cpu])
>> +		return 0;
>> +
>> +	cpu_state = data->cpu_state[freq->policy->cpu];
>> +	if (cpu_state->freq == freq->new)
>> +		return 0;
>> +
>> +	/* Backup current freq and pre-update cpu state freq*/
>> +	current_freq = cpu_state->freq;
>> +	cpu_state->freq = freq->new;
>> +
>> +	mutex_lock(&devfreq->lock);
>> +	ret = update_devfreq(devfreq);
>> +	mutex_unlock(&devfreq->lock);
>> +	if (ret) {
>> +		cpu_state->freq = current_freq;
>> +		dev_err(&devfreq->dev, "Couldn't update the frequency.\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
>> +{
>> +	struct devfreq_passive_data *data = *p_data;
>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>> +	struct device *dev = devfreq->dev.parent;
>> +	struct opp_table *opp_table = NULL;
>> +	struct devfreq_cpu_state *state;
> 
> For the readability, I thinkt 'cpu_state' is proper instead of 'state'.
> 
>> +	struct cpufreq_policy *policy;
>> +	struct device *cpu_dev;
>> +	unsigned int cpu;
>> +	int ret;
>> +
>> +	get_online_cpus();
> 
> Add blank line.
> 
>> +	data->nb.notifier_call = cpufreq_passive_notifier_call;
>> +	ret = cpufreq_register_notifier(&data->nb,
>> +					CPUFREQ_TRANSITION_NOTIFIER);
>> +	if (ret) {
>> +		dev_err(dev, "Couldn't register cpufreq notifier.\n");
>> +		data->nb.notifier_call = NULL;
>> +		goto out;
>> +	}
>> +
>> +	/* Populate devfreq_cpu_state */
>> +	for_each_online_cpu(cpu) {
>> +		if (data->cpu_state[cpu])
>> +			continue;
>> +
>> +		policy = cpufreq_cpu_get(cpu);
> 
> cpufreq_cpu_get() might return 'NULL'. I think you need to handle
> return value as following:
> 
> 		if (!policy) {
> 			ret = -EINVAL;
> 			goto out;
> 		} else if (PTR_ERR(policy) == -EPROBE_DEFER) {
> 			goto out;
> 		} else if (IS_ERR(policy) {
> 			ret = PTR_ERR(policy);
> 			dev_err(dev, "Couldn't get the cpufreq_poliy.\n");
> 			goto out;
> 		}
> 
> If cpufreq_cpu_get() return successfully, to do next.
> It reduces the one indentaion.
> 
> 
> 
>> +		if (policy) {
>> +			state = kzalloc(sizeof(*state), GFP_KERNEL);
>> +			if (!state) {
>> +				ret = -ENOMEM;
>> +				goto out;
>> +			}
>> +
>> +			cpu_dev = get_cpu_device(cpu);
>> +			if (!cpu_dev) {
>> +				dev_err(dev, "Couldn't get cpu device.\n");
>> +				ret = -ENODEV;
>> +				goto out;
>> +			}
>> +
>> +			opp_table = dev_pm_opp_get_opp_table(cpu_dev);
>> +			if (IS_ERR(devfreq->opp_table)) {
>> +				ret = PTR_ERR(opp_table);
>> +				goto out;
>> +			}
>> +
>> +			state->dev = cpu_dev;
>> +			state->opp_table = opp_table;
>> +			state->first_cpu = cpumask_first(policy->related_cpus);
>> +			state->freq = policy->cur;
>> +			state->min_freq = policy->cpuinfo.min_freq;
>> +			state->max_freq = policy->cpuinfo.max_freq;
>> +			data->cpu_state[cpu] = state;
> 
> Add blank line.
> 
>> +			cpufreq_cpu_put(policy);
>> +		} else {
>> +			ret = -EPROBE_DEFER;
>> +			goto out;
>> +		}
>> +	}
> 
> Add blank line.
> 
>> +out:
>> +	put_online_cpus();
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Update devfreq */
>> +	mutex_lock(&devfreq->lock);
>> +	ret = update_devfreq(devfreq);
>> +	mutex_unlock(&devfreq->lock);
>> +	if (ret)
>> +		dev_err(dev, "Couldn't update the frequency.\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
>> +{
>> +	struct devfreq_passive_data *data = *p_data;
>> +	struct devfreq_cpu_state *cpu_state;
>> +	int cpu;
>> +
>> +	if (data->nb.notifier_call)
>> +		cpufreq_unregister_notifier(&data->nb,
>> +					    CPUFREQ_TRANSITION_NOTIFIER);
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_state = data->cpu_state[cpu];
>> +		if (cpu_state) {
>> +			if (cpu_state->opp_table)
>> +				dev_pm_opp_put_opp_table(cpu_state->opp_table);
>> +			kfree(cpu_state);
>> +			cpu_state = NULL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>  				unsigned int event, void *data)
>>  {
>> @@ -165,7 +398,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>  	struct notifier_block *nb = &p_data->nb;
>>  	int ret = 0;
>>  
>> -	if (!parent)
>> +	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>>  		return -EPROBE_DEFER;
> 
> If you modify the devfreq_passive_event_handler() as following,
> you can move this condition for DEVFREQ_PARENT_DEV into 
> (register|unregister)_parent_dev_notifier.
> 
> 	switch (event) {                                                                                  
> 	case DEVFREQ_GOV_START:                                               
> 		ret = register_parent_dev_notifier(p_data);
> 		break;
> 	case DEVFREQ_GOV_STOP:                                             
> 		ret = unregister_parent_dev_notifier(p_data);
> 		break;
> 	default: 
> 		ret = -EINVAL;
> 		break;
> 	}
>                                                                                               
> 	return ret;
> 
>>  
>>  	switch (event) {
>> @@ -173,13 +406,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>  		if (!p_data->this)
>>  			p_data->this = devfreq;
>>  
>> -		nb->notifier_call = devfreq_passive_notifier_call;
>> -		ret = devfreq_register_notifier(parent, nb,
>> -					DEVFREQ_TRANSITION_NOTIFIER);
>> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
>> +			nb->notifier_call = devfreq_passive_notifier_call;
>> +			ret = devfreq_register_notifier(parent, nb,
>> +						DEVFREQ_TRANSITION_NOTIFIER);
>> +		} else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
>> +			ret = cpufreq_passive_register(&p_data);
> 
> I think that we better to collect the code related to notifier registration
> into one function like devfreq_pass_register_notifier() instead of
> cpufreq_passive_register() as following: I think it is more simple and readable.
> 
> If you have more proper function name of register_parent_dev_notifier,
> please give your opinion.
> 
> 
> 	int register_parent_dev_notifier(struct devfreq_passive_data **p_data)
> 		switch (p_data->parent_type) {
> 		case DEVFREQ_PARENT_DEV:
> 			nb->notifier_call = devfreq_passive_notifier_call;
> 			ret = devfreq_register_notifier(parent, nb,
> 			break;
> 		case CPUFREQ_PARENT_DEV:
> 			cpufreq_register_notifier(...)
> 			...
> 			break;
> 		}
> 		
> 
>> +		} else {
>> +			ret = -EINVAL;
>> +		}
>>  		break;
>>  	case DEVFREQ_GOV_STOP:
>> -		WARN_ON(devfreq_unregister_notifier(parent, nb,
>> -					DEVFREQ_TRANSITION_NOTIFIER));
>> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
>> +			WARN_ON(devfreq_unregister_notifier(parent, nb,
>> +						DEVFREQ_TRANSITION_NOTIFIER));
>> +		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
>> +			cpufreq_passive_unregister(&p_data);
>> +		else
>> +			ret = -EINVAL;
> 
> ditto. unregister_parent_dev_notifier(struct devfreq_passive_data **p_data)
> 
>>  		break;
>>  	default:
>>  		break;
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index a4b19d593151..04ce576fd6f1 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -278,6 +278,32 @@ struct devfreq_simple_ondemand_data {
>>  
>>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>>  /**
>> + * struct devfreq_cpu_state - holds the per-cpu state
>> + * @freq:	the current frequency of the cpu.
>> + * @min_freq:	the min frequency of the cpu.
>> + * @max_freq:	the max frequency of the cpu.
>> + * @first_cpu:	the cpumask of the first cpu of a policy.
>> + * @dev:	reference to cpu device.
>> + * @opp_table:	reference to cpu opp table.
>> + *
>> + * This structure stores the required cpu_state of a cpu.
>> + * This is auto-populated by the governor.
>> + */
>> +struct devfreq_cpu_state {> +	unsigned int freq;
> 
> It is better to change from 'freq' to 'curr_freq'
> for more correct expression.
> 
>> +	unsigned int min_freq;
>> +	unsigned int max_freq;
>> +	unsigned int first_cpu;
>> +	struct device *dev;
> 
> How about changing the name 'dev' to 'cpu_dev'?
> 
> 
>> +	struct opp_table *opp_table;
>> +};
> 
> devfreq_cpu_state is only handled by within driver/devfreq/governor_passive.c.
> 
> So, you can move it into drivers/devfreq/governor_passive.c
> and just add the definition into include/linux/devfreq.h as following:
> It is able to prevent the access of variable of 'struct devfreq_cpu_state'
> outside.
> 
> 	struct devfreq_cpu_state;
> 
>> +
>> +enum devfreq_parent_dev_type {
>> +	DEVFREQ_PARENT_DEV,
>> +	CPUFREQ_PARENT_DEV,
>> +};
>> +
>> +/**
>>   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>>   *	and devfreq_add_device
>>   * @parent:	the devfreq instance of parent device.
>> @@ -288,13 +314,15 @@ struct devfreq_simple_ondemand_data {
>>   *			using governors except for passive governor.
>>   *			If the devfreq device has the specific method to decide
>>   *			the next frequency, should use this callback.
>> - * @this:	the devfreq instance of own device.
>> - * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>> + * @parent_type		parent type of the device
> 
> Need to add ':' at the end of word. -> "parent_type:".
> 
>> + * @this:		the devfreq instance of own device.
>> + * @nb:			the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> 
> I knew that you make them with same indentation.
> But, actually, it is not related to this patch like clean-up code.
> Even if it is not pretty, you better to don't touch 'this' and 'nb' indentaion.
> 
>> + * @cpu_state:		the state min/max/current frequency of all online cpu's
>>   *
>>   * The devfreq_passive_data have to set the devfreq instance of parent
>>   * device with governors except for the passive governor. But, don't need to
>> - * initialize the 'this' and 'nb' field because the devfreq core will handle
>> - * them.
>> + * initialize the 'this', 'nb' and 'cpu_state' field because the devfreq core
>> + * will handle them.
>>   */
>>  struct devfreq_passive_data {
>>  	/* Should set the devfreq instance of parent device */
>> @@ -303,9 +331,13 @@ struct devfreq_passive_data {
>>  	/* Optional callback to decide the next frequency of passvice device */
>>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>>  
>> +	/* Should set the type of parent device */
>> +	enum devfreq_parent_dev_type parent_type;
>> +
>>  	/* For passive governor's internal use. Don't need to set them */
>>  	struct devfreq *this;
>>  	struct notifier_block nb;
>> +	struct devfreq_cpu_state *cpu_state[NR_CPUS];
>>  };
>>  #endif
>>  
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
