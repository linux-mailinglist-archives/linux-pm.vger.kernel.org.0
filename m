Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BE1EC81E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 05:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCD5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 23:57:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16462 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgFCD5J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 23:57:09 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200603035700epoutp0148b86ece1fb47cb26d350baf83677b9d~U7IQkOgqy0104901049epoutp011
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 03:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200603035700epoutp0148b86ece1fb47cb26d350baf83677b9d~U7IQkOgqy0104901049epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591156620;
        bh=8mbrRZ+aKoiBm6wNE73H4aQyF8Ea+3953BH8mvDBFtY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=o3lGh33AgVg2vRfb13AiA1EEel7HaLwpUzTqQNo7ha9iVlfqfIu99J08S7fzlq39t
         toQF5ZRklYFiR+osjfAluULrw6a6v8SMlh6MPGQ7nznjkbvCNRLCbkBEfawUPwOdWI
         iEtzyZkd6NxyLHAicXZHuK/xrA6wDVu21PRUIbSQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200603035700epcas1p3b9a32324cdc1c3e83f2e2d9651d0aa6b~U7IQDmA4a1249512495epcas1p3i;
        Wed,  3 Jun 2020 03:57:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49cFTj6WlXzMqYkb; Wed,  3 Jun
        2020 03:56:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.67.28581.98F17DE5; Wed,  3 Jun 2020 12:56:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200603035657epcas1p42d49b2423e6089bb3c98705bb0ef59b2~U7INhIgyC0233302333epcas1p4m;
        Wed,  3 Jun 2020 03:56:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200603035657epsmtrp24489a0c5231150876e479735b6c985d5~U7INgSTDj3104631046epsmtrp2J;
        Wed,  3 Jun 2020 03:56:57 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-af-5ed71f899d37
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.A1.08303.98F17DE5; Wed,  3 Jun 2020 12:56:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200603035656epsmtip134f9842b83ad55649061982208625e8d~U7INIeOdi2502325023epsmtip1Q;
        Wed,  3 Jun 2020 03:56:56 +0000 (GMT)
Subject: Re: [PATCH 06/12] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d0bc8877-6d41-f54e-1c4c-2fadbb9dcd0b@samsung.com>
Date:   Wed, 3 Jun 2020 13:07:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1591098190.30729.15.camel@mtksdaap41>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmnm6n/PU4g5vvjSy2r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbXFr5ntZh+V8hi41cPB2GPNfPWMHpc7utl8tg56y67x6ZV
        nWwed67tYfPYvKTeo+XkfhaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHcUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDPKSmUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM17MjSrYdICx4t70pawN
        jMdnMHYxcnJICJhITFm5ir2LkYtDSGAHo8TdaxehnE+MEqevf4VyPjNK7H15mBWm5eOR5UwQ
        iV2MEmubJrGAJIQE3jNKPL8mBWILC8RIvNnbzwxiiwA17Jg5mxGkgVmgj1Xi+po3YJPYBLQk
        9r+4wQZi8wsoSlz98RjsKF4BO4mLJ6exg9gsAioSpy/9AbNFBcIkTm5rgaoRlDg58wnYYk4B
        Y4kZpzeAxZkFxCVuPZnPBGHLS2x/O4cZ4ur5nBJ/W7ghbBeJnjMLob4Rlnh1fAs7hC0l8fnd
        XjYIu1pi5ckjbCBHSwh0MEps2X8BqsFYYv/SyUALOIAWaEqs36UPEVaU2Pl7LtQNfBLvvvaw
        gpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeyTaBUWkWkm9mIflgFpIPZiEsW8DIsopRLLWgODc9
        tdiwwAQ5ujcxglO+lsUOxrlvP+gdYmTiYDzEKMHBrCTCayV7LU6INyWxsiq1KD++qDQntfgQ
        oykwfCcyS4km5wOzTl5JvKGpkbGxsYWJoZmpoaGSOO9JqwtxQgLpiSWp2ampBalFMH1MHJxS
        DUyarKd/i8r0hJxkehXI8bM5POQzj/91yxOnNBZO25zjedsn8TiH2p1FJm3tOxYtVXh7Xlhq
        +SqRAP2Wa189pdQl90/qkOC+3PShjjtE55DBHl3FaTHfr/qeE3dKnRYidIiRy9Qm7qWd6Cnn
        WasE8/juiVW8UWuo4jJfz9IcET033FonhVXVS2hWwGYJzWdfGYImyrvcLznyL256wubrlrkX
        JP0T2Truih/Kuf/yAJ9fh3p5r06z6U93s0uxr27VaVw6fp1/5oJea5G2FRxvdGR9DqQFfzOp
        ln2d4b5cfXrFLl+NrZNezJyn9uJlw43ZP/rD895s2G+6Zs0dpQQL5981R5P6vF7wLV+tusHm
        lxJLcUaioRZzUXEiAOjbrwyCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSnG6n/PU4gz+veC22r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbXFr5ntZh+V8hi41cPB2GPNfPWMHpc7utl8tg56y67x6ZV
        nWwed67tYfPYvKTeo+XkfhaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHcUVw2Kak5mWWpRfp2CVwZ
        L+ZGFWw6wFhxb/pS1gbG4zMYuxg5OSQETCQ+HlnO1MXIxSEksINRYuP5SUwQCUmJaRePMncx
        cgDZwhKHDxdD1LxllHi6awdYjbBAjMSbvf3MILYI0KAdM2czghQxC0xgleg58JQNomM1k8SL
        V1tYQarYBLQk9r+4wQZi8wsoSlz98RjsDF4BO4mLJ6exg9gsAioSpy/9AbNFBcIkdi55zARR
        IyhxcuYTFhCbU8BYYsbpDWC9zALqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj8Cwk7bOQtMxC
        0jILScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB8a+ltYNxz6oPeocYmTgY
        DzFKcDArifBayV6LE+JNSaysSi3Kjy8qzUktPsQozcGiJM77ddbCOCGB9MSS1OzU1ILUIpgs
        EwenVAOT02KFpKgAmZVFYv2zPn8pv8nEXGquk9CifuXPIUbv5mSmWbmsjFPV/8y6brqu0W77
        523rHzRee/69LyNSpfSa6MoKaTHrJsMFn/qY32+dZVXclvXARKN2zYW6i9Ff+T7tD/rCFl2w
        UfSw1Czu98J2TCGrp76dY/r5YnBU07bLXlqLXmZ/fRFtmBrKr9H2LfNXYKy3p7fgvU7xCSvF
        1su9PKszMbTT29jva2bgju/sa4UD/sZcOXPbvWW7lmDLjgYezvmMIvY3RJT33XtsP+/+CVWL
        e69POr7kzNas7CthWvXa39JUiMMx7/G6vLTo96YF227KSuUciFGaen5jmvB1EabbHpOL5hj5
        7pLYdUOJpTgj0VCLuag4EQCKQHbCbgMAAA==
X-CMS-MailID: 20200603035657epcas1p42d49b2423e6089bb3c98705bb0ef59b2
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
        <1591098190.30729.15.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrew-sh.Cheng,

Do you know that why cannot show the patches sent from you on mailing list?

Even if you sent them to linux-pm mailing list, I cannot find
your patches on linux-pm's patchwork[1] and others.
[1] https://patchwork.kernel.org/project/linux-pm/list/

Could you find you patch on mailing list?
Do you use git send-email when you send these patches?

I used the thunderbird tool and gmail for reading the patches.
When I tried to read the original source of this patch,
it looks like that the body of patch is encoded.
I cannot read the plain text of patch body.
- When gmail, use 'Show original'
- When thunderbird, use 'More -> View Source'

If I'm missing something to check this patch,
please let me know. I'll fix my environment.
It is strange situation on my case.


On 6/2/20 8:43 PM, andrew-sh.cheng wrote:
> On Thu, 2020-05-28 at 15:14 +0900, Chanwoo Choi wrote:
>> Hi Andrew-sh.Cheng,
>>
>> Thanks for your posting. I like this approach absolutely.
>> I think that it is necessary. When I developed the embedded product,
>> I needed this feature always. 
>>
>> I add the comments on below.
>>
>>
>> And the following email is not valid. So, I dropped this email
>> from Cc list.
>> Saravana Kannan <skannan@codeaurora.org>
>>
>>
>> On 5/20/20 12:43 PM, Andrew-sh.Cheng wrote:
>>> From: Saravana Kannan <skannan@codeaurora.org>
>>>
>>> Many CPU architectures have caches that can scale independent of the
>>> CPUs. Frequency scaling of the caches is necessary to make sure that the
>>> cache is not a performance bottleneck that leads to poor performance and
>>> power. The same idea applies for RAM/DDR.
>>>
>>> To achieve this, this patch adds support for cpu based scaling to the
>>> passive governor. This is accomplished by taking the current frequency
>>> of each CPU frequency domain and then adjust the frequency of the cache
>>> (or any devfreq device) based on the frequency of the CPUs. It listens
>>> to CPU frequency transition notifiers to keep itself up to date on the
>>> current CPU frequency.
>>>
>>> To decide the frequency of the device, the governor does one of the
>>> following:
>>> * Derives the optimal devfreq device opp from required-opps property of
>>>   the parent cpu opp_table.
>>>
>>> * Scales the device frequency in proportion to the CPU frequency. So, if
>>>   the CPUs are running at their max frequency, the device runs at its
>>>   max frequency. If the CPUs are running at their min frequency, the
>>>   device runs at its min frequency. It is interpolated for frequencies
>>>   in between.
>>>
>>> Andrew-sh.Cheng change
>>> dev_pm_opp_xlate_opp to dev_pm_opp_xlate_required_opp devfreq->max_freq
>>> to devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value
>>> for kernel-5.7
>>>
>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>> [Sibi: Integrated cpu-freqmap governor into passive_governor]
>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
>>> ---
>>>  drivers/devfreq/Kconfig            |   2 +
>>>  drivers/devfreq/governor_passive.c | 278 ++++++++++++++++++++++++++++++++++---
>>>  include/linux/devfreq.h            |  40 +++++-
>>>  3 files changed, 299 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 0b1df12e0f21..d9067950af6a 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -73,6 +73,8 @@ config DEVFREQ_GOV_PASSIVE
>>>  	  device. This governor does not change the frequency by itself
>>>  	  through sysfs entries. The passive governor recommends that
>>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>>> +	  Alternatively the governor can also be chosen to scale based on
>>> +	  the online CPUs current frequency.
>>>  
>>>  comment "DEVFREQ Drivers"
>>>  
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index 2d67d6c12dce..7dcda02a5bb7 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -8,11 +8,89 @@
>>>   */
>>>  
>>>  #include <linux/module.h>
>>> +#include <linux/cpu.h>
>>> +#include <linux/cpufreq.h>
>>> +#include <linux/cpumask.h>
>>>  #include <linux/device.h>
>>>  #include <linux/devfreq.h>
>>> +#include <linux/slab.h>
>>>  #include "governor.h"
>>>  
>>> -static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>> +static unsigned int xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
>>
>> Need to change 'unsigned int' to 'unsigned long'
> Get it.

If you add the blank line before/after of your reply,
it is better to catch your reply. Please add the blank line for me.

>> .
>>
>>> +					     unsigned int cpu)
>>> +{
>>> +	unsigned int cpu_min, cpu_max, dev_min, dev_max, cpu_percent, max_state;
>>
>> Better to define them separately as following and then need to rename
>> the variable. Usually, use the 'min_freq' and 'max_freq' word for
>> the minimum/maximum frequency.
>>
>> 	unsigned int cpu_min_freq, cpu_max_freq, cpu_curr_freq, cpu_percent;
>> 	unsigned long dev_min_freq, dev_max_freq, dev_max_state,
>>
>> The devfreq used 'unsigned long'. The cpufreq used 'unsigned long'
>> and 'unsigned int'. You need to handle them properly.
> Get it.
> For cpu_freq, I separate it into "unsigned long cpu_curr_freq" and
> "unsigned int cpu_curr_freq_khz"
>>
>>
>>> +	struct devfreq_cpu_state *cpu_state = data->cpu_state[cpu];
>>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>>> +	unsigned long *freq_table = devfreq->profile->freq_table;
>>
>> In this function, use 'cpu' work for cpufreq and use 'dev' for devfreq.
>> So, I think 'dev_freq_table' is proper name instead of 'freq_table'
>> for the readability.
>>
>> 	freq_table -> dev_freq_table
>>
>>> +	struct dev_pm_opp *opp = NULL, *cpu_opp = NULL;
>>
>> In the get_target_freq_with_devfreq(), use 'p_opp' indicating
>> the OPP of parent device. For the consistency, I think that
>> use 'p_opp' instead of 'cpu_opp'. 
>>
>>> +	unsigned long cpu_freq, freq;
>>
>> Define the 'cpu_freq' on above with cpu_min_freq/cpu_max_freq definition.
>> 	cpu_freq -> cpu_curr_freq.
> Get it.
> Will modify them for readability.
>>
>>> +
>>> +	if (!cpu_state || cpu_state->first_cpu != cpu ||
>>> +	    !cpu_state->opp_table || !devfreq->opp_table)
>>> +		return 0;
>>> +
>>> +	cpu_freq = cpu_state->freq * 1000;
>>> +	cpu_opp = devfreq_recommended_opp(cpu_state->dev, &cpu_freq, 0);
>>> +	if (IS_ERR(cpu_opp))
>>> +		return 0;
>>> +
>>> +	opp = dev_pm_opp_xlate_required_opp(cpu_state->opp_table,
>>> +					    devfreq->opp_table, cpu_opp);
>>> +	dev_pm_opp_put(cpu_opp);
>>> +
>>> +	if (!IS_ERR(opp)) {
>>> +		freq = dev_pm_opp_get_freq(opp);
>>> +		dev_pm_opp_put(opp);
>>
>> Better to add the 'out' goto statement.
>> If you use 'goto out', you can reduce the one indentation
>> without 'else' statement.
> Get it.
>> 	
>>
>>> +	} else {
>>
>> As I commented, when dev_pm_opp_xlate_required_opp() return successfully
>> , use 'goto out'. We can remove 'else' and then reduce the unneeded indentation.
>>
>>
>>> +		/* Use Interpolation if required opps is not available */
>>> +		cpu_min = cpu_state->min_freq;
>>> +		cpu_max = cpu_state->max_freq;
>>> +		cpu_freq = cpu_state->freq;
>>> +
>>> +		if (freq_table) {
>>> +			/* Get minimum frequency according to sorting order */
>>> +			max_state = freq_table[devfreq->profile->max_state - 1];
>>> +			if (freq_table[0] < max_state) {
>>> +				dev_min = freq_table[0];
>>> +				dev_max = max_state;
>>> +			} else {
>>> +				dev_min = max_state;
>>> +				dev_max = freq_table[0];
>>> +			}
>>> +		} else {
>>> +			if (devfreq->user_max_freq_req.data.freq.qos->max_freq.target_value
>>> +			    <= devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value)
>>> +				return 0;
>>> +			dev_min =
>>> +			devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value;
>>> +			dev_max =
>>> +			devfreq->user_max_freq_req.data.freq.qos->max_freq.target_value;
>>
>> I think it is not proper to access the variable of pm_qos structure directly.
>> Instead of direct access, you have to use the exported PM QoS function such as
>> - pm_qos_read_value(devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY);
>> - pm_qos_read_value(devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY);
> Get it.
>>
>>> +		}
>>> +		cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
>>> +		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
>>> +	}
>>
>>
>> I think that you better to add 'out' jump label as following:
>>
>> out:
>>
>>> +
>>> +	return freq;
>>> +}
>>> +
>>> +static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
>>> +					unsigned long *freq)
>>> +{
>>> +	struct devfreq_passive_data *p_data =
>>> +				(struct devfreq_passive_data *)devfreq->data;
>>> +	unsigned int cpu, target_freq = 0;
>>
>> Need to define 'target_freq' with 'unsigned long' type.
> Get it.
>>
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		target_freq = max(target_freq,
>>> +				  xlate_cpufreq_to_devfreq(p_data, cpu));
>>> +
>>> +	*freq = target_freq;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>>>  					unsigned long *freq)
>>>  {
>>>  	struct devfreq_passive_data *p_data
>>> @@ -23,16 +101,6 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>  	int i, count, ret = 0;
>>>  
>>>  	/*
>>> -	 * If the devfreq device with passive governor has the specific method
>>> -	 * to determine the next frequency, should use the get_target_freq()
>>> -	 * of struct devfreq_passive_data.
>>> -	 */
>>> -	if (p_data->get_target_freq) {
>>> -		ret = p_data->get_target_freq(devfreq, freq);
>>> -		goto out;
>>> -	}
>>> -
>>> -	/*
>>>  	 * If the parent and passive devfreq device uses the OPP table,
>>>  	 * get the next frequency by using the OPP table.
>>>  	 */
>>> @@ -102,6 +170,37 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>  	return ret;
>>>  }
>>>  
>>> +static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>> +					   unsigned long *freq)
>>> +{
>>> +	struct devfreq_passive_data *p_data =
>>> +				(struct devfreq_passive_data *)devfreq->data;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * If the devfreq device with passive governor has the specific method
>>> +	 * to determine the next frequency, should use the get_target_freq()
>>> +	 * of struct devfreq_passive_data.
>>> +	 */
>>> +	if (p_data->get_target_freq)
>>> +		return p_data->get_target_freq(devfreq, freq);
>>> +
>>> +	switch (p_data->parent_type) {
>>> +	case DEVFREQ_PARENT_DEV:
>>> +		ret = get_target_freq_with_devfreq(devfreq, freq);
>>> +		break;
>>> +	case CPUFREQ_PARENT_DEV:
>>> +		ret = get_target_freq_with_cpufreq(devfreq, freq);
>>> +		break;
>>> +	default:
>>> +		ret = -EINVAL;
>>> +		dev_err(&devfreq->dev, "Invalid parent type\n");
>>> +		break;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>>  {
>>>  	int ret;
>>> @@ -156,6 +255,140 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>>>  	return NOTIFY_DONE;
>>>  }
>>>  
>>> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
>>> +					 unsigned long event, void *ptr)
>>> +{
>>> +	struct devfreq_passive_data *data =
>>> +			container_of(nb, struct devfreq_passive_data, nb);
>>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>>> +	struct devfreq_cpu_state *cpu_state;
>>> +	struct cpufreq_freqs *freq = ptr;
>>
>> How about changing 'freq' to 'cpu_freqs'?
>>
>> In the drivers/cpufreq/cpufreq.c, use 'freqs' name indicating
>> the instance of 'struct cpufreq_freqs'. And in order to
>> identfy, how about adding 'cpu_' prefix for variable name?
>>
>>> +	unsigned int current_freq;
>>
>> Need to define curr_freq with 'unsigned long' type
>> and better to use 'curr_freq' variable name.
> It is good to change current_freq to curr_freq, but why should it us
> 'unsigned long'?
> I think it is 'unsigned int'.

I think that 'curr_freq' is proper. Yes, it is 'unsigned int'.
When you changing the cpu frequency to device frequency,
recommend to handle them between unsigned int and unsigned long.

>>
>>> +	int ret;
>>> +
>>> +	if (event != CPUFREQ_POSTCHANGE || !freq ||
>>> +	    !data->cpu_state[freq->policy->cpu])
>>> +		return 0;
>>> +
>>> +	cpu_state = data->cpu_state[freq->policy->cpu];
>>> +	if (cpu_state->freq == freq->new)
>>> +		return 0;
>>> +
>>> +	/* Backup current freq and pre-update cpu state freq*/
>>> +	current_freq = cpu_state->freq;
>>> +	cpu_state->freq = freq->new;
>>> +
>>> +	mutex_lock(&devfreq->lock);
>>> +	ret = update_devfreq(devfreq);
>>> +	mutex_unlock(&devfreq->lock);
>>> +	if (ret) {
>>> +		cpu_state->freq = current_freq;
>>> +		dev_err(&devfreq->dev, "Couldn't update the frequency.\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
>>> +{
>>> +	struct devfreq_passive_data *data = *p_data;
>>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>>> +	struct device *dev = devfreq->dev.parent;
>>> +	struct opp_table *opp_table = NULL;
>>> +	struct devfreq_cpu_state *state;
>>
>> For the readability, I thinkt 'cpu_state' is proper instead of 'state'.
> Get it.
>>
>>> +	struct cpufreq_policy *policy;
>>> +	struct device *cpu_dev;
>>> +	unsigned int cpu;
>>> +	int ret;
>>> +
>>> +	get_online_cpus();
>>
>> Add blank line.
> Get it.
>>
>>> +	data->nb.notifier_call = cpufreq_passive_notifier_call;
>>> +	ret = cpufreq_register_notifier(&data->nb,
>>> +					CPUFREQ_TRANSITION_NOTIFIER);
>>> +	if (ret) {
>>> +		dev_err(dev, "Couldn't register cpufreq notifier.\n");
>>> +		data->nb.notifier_call = NULL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* Populate devfreq_cpu_state */
>>> +	for_each_online_cpu(cpu) {
>>> +		if (data->cpu_state[cpu])
>>> +			continue;
>>> +
>>> +		policy = cpufreq_cpu_get(cpu);
>>
>> cpufreq_cpu_get() might return 'NULL'. I think you need to handle
>> return value as following:
>>
>> 		if (!policy) {
>> 			ret = -EINVAL;
>> 			goto out;
>> 		} else if (PTR_ERR(policy) == -EPROBE_DEFER) {
>> 			goto out;
>> 		} else if (IS_ERR(policy) {
>> 			ret = PTR_ERR(policy);
>> 			dev_err(dev, "Couldn't get the cpufreq_poliy.\n");
>> 			goto out;
>> 		}
>>
>> If cpufreq_cpu_get() return successfully, to do next.
>> It reduces the one indentaion.
>>
>>
> Get it.
>>
>>> +		if (policy) {
>>> +			state = kzalloc(sizeof(*state), GFP_KERNEL);
>>> +			if (!state) {
>>> +				ret = -ENOMEM;
>>> +				goto out;
>>> +			}
>>> +
>>> +			cpu_dev = get_cpu_device(cpu);
>>> +			if (!cpu_dev) {
>>> +				dev_err(dev, "Couldn't get cpu device.\n");
>>> +				ret = -ENODEV;
>>> +				goto out;
>>> +			}
>>> +
>>> +			opp_table = dev_pm_opp_get_opp_table(cpu_dev);
>>> +			if (IS_ERR(devfreq->opp_table)) {
>>> +				ret = PTR_ERR(opp_table);
>>> +				goto out;
>>> +			}
>>> +
>>> +			state->dev = cpu_dev;
>>> +			state->opp_table = opp_table;
>>> +			state->first_cpu = cpumask_first(policy->related_cpus);
>>> +			state->freq = policy->cur;
>>> +			state->min_freq = policy->cpuinfo.min_freq;
>>> +			state->max_freq = policy->cpuinfo.max_freq;
>>> +			data->cpu_state[cpu] = state;
>>
>> Add blank line.
>>
>>> +			cpufreq_cpu_put(policy);
>>> +		} else {
>>> +			ret = -EPROBE_DEFER;
>>> +			goto out;
>>> +		}
>>> +	}
>>
>> Add blank line.
> Get it.
>>> +out:
>>> +	put_online_cpus();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Update devfreq */
>>> +	mutex_lock(&devfreq->lock);
>>> +	ret = update_devfreq(devfreq);
>>> +	mutex_unlock(&devfreq->lock);
>>> +	if (ret)
>>> +		dev_err(dev, "Couldn't update the frequency.\n");
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
>>> +{
>>> +	struct devfreq_passive_data *data = *p_data;
>>> +	struct devfreq_cpu_state *cpu_state;
>>> +	int cpu;
>>> +
>>> +	if (data->nb.notifier_call)
>>> +		cpufreq_unregister_notifier(&data->nb,
>>> +					    CPUFREQ_TRANSITION_NOTIFIER);
>>> +
>>> +	for_each_possible_cpu(cpu) {
>>> +		cpu_state = data->cpu_state[cpu];
>>> +		if (cpu_state) {
>>> +			if (cpu_state->opp_table)
>>> +				dev_pm_opp_put_opp_table(cpu_state->opp_table);
>>> +			kfree(cpu_state);
>>> +			cpu_state = NULL;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>  				unsigned int event, void *data)
>>>  {
>>> @@ -165,7 +398,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>  	struct notifier_block *nb = &p_data->nb;
>>>  	int ret = 0;
>>>  
>>> -	if (!parent)
>>> +	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>>>  		return -EPROBE_DEFER;
>>
>> If you modify the devfreq_passive_event_handler() as following,
>> you can move this condition for DEVFREQ_PARENT_DEV into 
>> (register|unregister)_parent_dev_notifier.
>>
>> 	switch (event) {                                                                                  
>> 	case DEVFREQ_GOV_START:                                               
>> 		ret = register_parent_dev_notifier(p_data);
>> 		break;
>> 	case DEVFREQ_GOV_STOP:                                             
>> 		ret = unregister_parent_dev_notifier(p_data);
>> 		break;
>> 	default: 
>> 		ret = -EINVAL;
>> 		break;
>> 	}
>>                                                                                               
>> 	return ret;
>>
> Get it.
>>>  
>>>  	switch (event) {
>>> @@ -173,13 +406,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>  		if (!p_data->this)
>>>  			p_data->this = devfreq;
>>>  
>>> -		nb->notifier_call = devfreq_passive_notifier_call;
>>> -		ret = devfreq_register_notifier(parent, nb,
>>> -					DEVFREQ_TRANSITION_NOTIFIER);
>>> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
>>> +			nb->notifier_call = devfreq_passive_notifier_call;
>>> +			ret = devfreq_register_notifier(parent, nb,
>>> +						DEVFREQ_TRANSITION_NOTIFIER);
>>> +		} else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
>>> +			ret = cpufreq_passive_register(&p_data);
>>
>> I think that we better to collect the code related to notifier registration
>> into one function like devfreq_pass_register_notifier() instead of
>> cpufreq_passive_register() as following: I think it is more simple and readable.
>>
>> If you have more proper function name of register_parent_dev_notifier,
>> please give your opinion.
>>
>> 	int register_parent_dev_notifier(struct devfreq_passive_data **p_data)
>> 		switch (p_data->parent_type) {
>> 		case DEVFREQ_PARENT_DEV:
>> 			nb->notifier_call = devfreq_passive_notifier_call;
>> 			ret = devfreq_register_notifier(parent, nb,
>> 			break;
>> 		case CPUFREQ_PARENT_DEV:
>> 			cpufreq_register_notifier(...)
>> 			...
>> 			break;
>> 		}
> Not fully understanding.
> Do you mean expanding cpufreq_passive_register()?

Yes and rename it for both cpufreq and devfreq.

> I think leave it in function will be with clean for this code segment.

I want that one function handle the notifier register
for both cpufreq and devfreq so that we make it more simply as following:
On the step hanling the governor event, don't need to consider
the type of parent device of devfreq deivce with this style.

	case DEVFREQ_GOV_START:
		ret = register_notifier(...);
		break;
	case DEVFREQ_GOV_STOP:
		ret = unregister_notifier(...);
		break;

> 
>> 		
>>
>>> +		} else {
>>> +			ret = -EINVAL;
>>> +		}
>>>  		break;
>>>  	case DEVFREQ_GOV_STOP:
>>> -		WARN_ON(devfreq_unregister_notifier(parent, nb,
>>> -					DEVFREQ_TRANSITION_NOTIFIER));
>>> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
>>> +			WARN_ON(devfreq_unregister_notifier(parent, nb,
>>> +						DEVFREQ_TRANSITION_NOTIFIER));
>>> +		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
>>> +			cpufreq_passive_unregister(&p_data);
>>> +		else
>>> +			ret = -EINVAL;
>>
>> ditto. unregister_parent_dev_notifier(struct devfreq_passive_data **p_data)
> Get it.

ditto. As I aboved commented.

>>
>>>  		break;
>>>  	default:
>>>  		break;
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index a4b19d593151..04ce576fd6f1 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -278,6 +278,32 @@ struct devfreq_simple_ondemand_data {
>>>  
>>>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>>>  /**
>>> + * struct devfreq_cpu_state - holds the per-cpu state
>>> + * @freq:	the current frequency of the cpu.
>>> + * @min_freq:	the min frequency of the cpu.
>>> + * @max_freq:	the max frequency of the cpu.
>>> + * @first_cpu:	the cpumask of the first cpu of a policy.
>>> + * @dev:	reference to cpu device.
>>> + * @opp_table:	reference to cpu opp table.
>>> + *
>>> + * This structure stores the required cpu_state of a cpu.
>>> + * This is auto-populated by the governor.
>>> + */
>>> +struct devfreq_cpu_state {> +	unsigned int freq;
>>
>> It is better to change from 'freq' to 'curr_freq'
>> for more correct expression.
> Get it.
>>
>>> +	unsigned int min_freq;
>>> +	unsigned int max_freq;
>>> +	unsigned int first_cpu;
>>> +	struct device *dev;
>>
>> How about changing the name 'dev' to 'cpu_dev'?
> Okay.
>>
>>
>>> +	struct opp_table *opp_table;
>>> +};
>>
>> devfreq_cpu_state is only handled by within driver/devfreq/governor_passive.c.
>>
>> So, you can move it into drivers/devfreq/governor_passive.c
>> and just add the definition into include/linux/devfreq.h as following:
>> It is able to prevent the access of variable of 'struct devfreq_cpu_state'
>> outside.
>>
>> 	struct devfreq_cpu_state;
> Get it.
>>
>>> +
>>> +enum devfreq_parent_dev_type {
>>> +	DEVFREQ_PARENT_DEV,
>>> +	CPUFREQ_PARENT_DEV,
>>> +};
>>> +
>>> +/**
>>>   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>>>   *	and devfreq_add_device
>>>   * @parent:	the devfreq instance of parent device.
>>> @@ -288,13 +314,15 @@ struct devfreq_simple_ondemand_data {
>>>   *			using governors except for passive governor.
>>>   *			If the devfreq device has the specific method to decide
>>>   *			the next frequency, should use this callback.
>>> - * @this:	the devfreq instance of own device.
>>> - * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>>> + * @parent_type		parent type of the device
>>
>> Need to add ':' at the end of word. -> "parent_type:".
>>
>>> + * @this:		the devfreq instance of own device.
>>> + * @nb:			the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>>
>> I knew that you make them with same indentation.
>> But, actually, it is not related to this patch like clean-up code.
>> Even if it is not pretty, you better to don't touch 'this' and 'nb' indentaion.
> Get it.
>>
>>> + * @cpu_state:		the state min/max/current frequency of all online cpu's
>>>   *
>>>   * The devfreq_passive_data have to set the devfreq instance of parent
>>>   * device with governors except for the passive governor. But, don't need to
>>> - * initialize the 'this' and 'nb' field because the devfreq core will handle
>>> - * them.
>>> + * initialize the 'this', 'nb' and 'cpu_state' field because the devfreq core
>>> + * will handle them.
>>>   */
>>>  struct devfreq_passive_data {
>>>  	/* Should set the devfreq instance of parent device */
>>> @@ -303,9 +331,13 @@ struct devfreq_passive_data {
>>>  	/* Optional callback to decide the next frequency of passvice device */
>>>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>>>  
>>> +	/* Should set the type of parent device */
>>> +	enum devfreq_parent_dev_type parent_type;
>>> +
>>>  	/* For passive governor's internal use. Don't need to set them */
>>>  	struct devfreq *this;
>>>  	struct notifier_block nb;
>>> +	struct devfreq_cpu_state *cpu_state[NR_CPUS];
>>>  };
>>>  #endif
>>>  
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
