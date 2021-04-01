Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59FB350B06
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 02:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhCaX7b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 19:59:31 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:13205 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCaX7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 19:59:14 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210331235912epoutp0356de1833a6bc1b0a438d1de5af19678c~xks2DIOVz1140811408epoutp03M
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 23:59:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210331235912epoutp0356de1833a6bc1b0a438d1de5af19678c~xks2DIOVz1140811408epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617235152;
        bh=C+XJfuVDxjkwuLYiYX20Go1EBCgk9DDm0T568pF7O9A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=se9ZTaySBl58WvY+8GjcJIBIhmi8hZ0AF3QQT63zUCaw9mYZKENf6tOXpQXcZL3lC
         rqj2GrS0VGR8SFgnEkkgx11XiYKxOeiBE8oHzHhz3M9XM37j4Dsd43YNQqb0T9ZpcU
         L15sQbfTgdgGaKXyeEq8vRukkzuo4iTgP23fpT7M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210331235911epcas1p4143bcbc01328888898a35e1049b7a783~xks1RkWMZ1886218862epcas1p4n;
        Wed, 31 Mar 2021 23:59:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F9jvx37gKz4x9Q3; Wed, 31 Mar
        2021 23:59:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.F1.10347.DCC05606; Thu,  1 Apr 2021 08:59:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210331235908epcas1p31f128e2071e7c2b4650deb7f18f09bf2~xksyOX1CF1297512975epcas1p3B;
        Wed, 31 Mar 2021 23:59:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210331235908epsmtrp21c2d7e7db37ed9fbbe3e46a0d8c46680~xksyNQ9rT1645716457epsmtrp2n;
        Wed, 31 Mar 2021 23:59:08 +0000 (GMT)
X-AuditID: b6c32a39-15dff7000002286b-aa-60650ccde34d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.E8.08745.CCC05606; Thu,  1 Apr 2021 08:59:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210331235907epsmtip2f861b6f8be7f87345621e34ecbd1f605~xksxrUdPX1946119461epsmtip2W;
        Wed, 31 Mar 2021 23:59:07 +0000 (GMT)
Subject: Re: [PATCH V8 1/8] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Sibi Sankar <sibis@codeaurora.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fbb6c44b-eb77-14ce-9175-3f06030e6e0c@samsung.com>
Date:   Thu, 1 Apr 2021 09:16:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1617195800.18432.3.camel@mtksdaap41>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHd9rbS0HQawvbEXXCRRepgbWwsoOBRRxz100znLCoi5Yr3FEC
        faS36GCawewc66CwIUMYAw0PXYOZMB6FwVi6ZkhGtwKjgMAypVkQeSxizUQhll4W+e9zzvl+
        f7/zPQ8hX7SABwsz1XpGp6azSdwPa78RLo2w+zOp0mWTGHVcnhGg8l9cOKq13RYg+4k5H/TX
        3UIeapl2CtBwVzWOhr8YBGip2AZQw+ggD50wRKOJgu9xNPfIzkMDt4YE6GSPzQetOpsx5Px2
        UYAqpkSo2U29JqaaapoANWwq5lGdVVM+VIv5NE5NOrtx6kr9ccrQ34tRrSOnMMrUagZU31gH
        j1pq2Zr0xAdZcUqGTmd0IYw6TZOeqc6IJ/e/q9itkMdIZRGyWLSTDFHTKiaeTHwrKeKNzGxP
        ODLkEzo7xzOVRLMsuX1XnE6To2dClBpWH08y2vRsbaw2kqVVbI46IzJNo3pVJpVGyT3C1Cxl
        nWmP1jwNjpZMLmL5YLwNGIGvEBI7YJmhRLDGIsICoL1fYgR+Hv4DQMPNLj43WALwQeMs/tjR
        Pvr1+kIXgH8bXICzLwI4eEa7xmLiQ7h85x62xoEeg6XyglfDJ4oFsNIausY4IYG9M2Peok8R
        oXDk0bRXE0Dsgo1GbnsY8SI01Ru8miDiEOxvN6xrnob9lS5vfV8iCt67WYtz9bfAn121PI5f
        gB3z1d6NQuKCL6y/e1bAJUiEptVmPsdiONvX6sNxMFxa6FlPeQxe6rfhnLkQwNZex7o5GvY2
        lHk6CD0dwuHlru3cdCjs/Ofiesgn4YK7SLAmgUQALPxSxEnC4PD9KR7Hz8C6U6fxUkBWbYhT
        tSFC1YYIVf83+wZgZrCZ0bKqDIaVaeUbb7sFeB++JNYCKuYfRloBTwisAAr5ZGCA+DqdKgpI
        p3PzGJ1GocvJZlgrkHsO+Cw/OChN4/k5ar1CJo+Kjo5GO2QxcpmM3BLwsfS+QkRk0Homi2G0
        jO6xjyf0Dc7nnds06dh7cLl085i/Y2/557HJ70yo7S8p3XlXMsM0kRNF2xIPzB8qbT56yVK0
        9FOG9Ssi7sa85WqgdchV5zz/L0nAg79/FJYAe686HFNvd3ePYe7FVX5l3jXblCRhVDKzklRu
        dz07fjGZnHS3Jc9+6owcshIPbx3YtlWXVOZmVo4MsCuSPuPr7IyfURyjyn3+/bnbbXFndptc
        JTU5x6tFRz7b+dymqF8T7gSmWFZ+aCwvqYkf9M8CA6lKvNrhFFp/7FQd7sl3I/+GtjezHrT6
        vZyimUy8tg8z7/mursCdGX4seTyd/wqY+O296+fPjVSchAUTf87O5MYWpDQN1wYdzvUlMVZJ
        yyR8HUv/B9qGK8mBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSvO4ZntQEg30r+S22r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbXFr5ntZh+V8hi41cPB2GPNfPWMHpc7utl8tg56y67x6ZV
        nWwed67tYfPYvKTeo+XkfhaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHcUVw2Kak5mWWpRfp2CVwZ
        i/tcC1Y9Zqzov/OepYHx5lbGLkZODgkBE4lt12cwdzFycQgJ7GCUWPStiQUiISkx7eJRoAQH
        kC0scfhwMUTNW0aJ9T/Ws4PUCAvESvw6fw+sXgRo0I6ZsxlBipgF+lklXv7oYoLouMAs0Tjv
        GxtIFZuAlsT+FzfAbH4BRYmrPx6DncErYCexrAviJBYBFYm+JS1gNaICYRI7lzxmgqgRlDg5
        8wnYNk4BI4l7x+aD1TALqEv8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjMKzkLTPQtIyC0nLLCQt
        CxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMe/ltYOxj2rPugdYmTiYDzEKMHB
        rCTCK3wgMUGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkG
        Jn+vO9nHgywZb6V4WhjfcVSc2JU9I3Dfm2vzDqxfZNJcbThtvnxMlvnvvGdXHyQHP9Ke4OK8
        1Hs5n4pN+K3tupL5jIdWKzPOSWYQVLRS1NoiffdJw4VDWufSlkl8k5l19Kr9zRefni/mLlg2
        c4oOd9aPybf5P+aW68/n+zDLi5vRTeb7qgsB/9bETra9l28gzHRBRb7D4of4z3u/4m/vvFl/
        itul9SXrsXPtrZdDtHdHz9+nn3vcyFsruq9uY5ZfXbKmashJ23f1X7WmT1wXyR2+4fOURfuf
        1DIt3r3WN7hx2R++XsnUk4uVeV0jntRs1a4zv5W65f7q+IP+PvfOrTjdfeq4c8p3mVUMj7ec
        ZFRiKc5INNRiLipOBABsaYNxbgMAAA==
X-CMS-MailID: 20210331235908epcas1p31f128e2071e7c2b4650deb7f18f09bf2
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
        <233a3bd6-7ab1-5da2-9184-a745eb253d86@samsung.com>
        <1617177820.15067.1.camel@mtksdaap41>
        <2ae8604d-0da6-4243-1b92-81b3917d7d48@samsung.com>
        <cad52436-b291-05bf-236f-7b7cb1fdbbff@samsung.com>
        <1617195800.18432.3.camel@mtksdaap41>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/31/21 10:03 PM, andrew-sh.cheng wrote:
> On Wed, 2021-03-31 at 17:35 +0900, Chanwoo Choi wrote:
>> On 3/31/21 5:27 PM, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 3/31/21 5:03 PM, andrew-sh.cheng wrote:
>>>> On Thu, 2021-03-25 at 17:14 +0900, Chanwoo Choi wrote:
>>>>> Hi,
>>>>>
>>>>> You are missing to add these patches to linux-pm mailing list.
>>>>> Need to send them to linu-pm ML.
>>>>>
>>>>> Also, before received this series, I tried to clean-up these patches
>>>>> on testing branch[1]. So that I add my comment with my clean-up case.
>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!zIrzeDp9vPnm1_SDzVPuzqdHn3zWie9DnfBXaA-j9-CSrVc6aR9_rJQQiw81_CgAPh9XRRs$ 
>>>>>
>>>>> And 'Saravana Kannan <skannan@codeaurora.org>' is wrong email address.
>>>>> Please update the email or drop this email.
>>>>
>>>> Hi Chanwoo,
>>>>
>>>> Thank you for the advices.
>>>> I will resend patch v9 (add to linux-pm ML), remove this patch, and note
>>>> that my patch set base on
>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>>
>>> I has not yet test this patch[1] on devfreq-testing-passive-gov branch.
>>> So that if possible, I'd like you to test your patches with this patch[1] 
>>> and then if there is no problem, could you send the next patches with patch[1]?
>>>
>>> [1]https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing-passive-gov&id=39c80d11a8f42dd63ecea1e0df595a0ceb83b454__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJR2cQqZs$ 
>>
>>
>> Sorry for the confusion. I make the devfreq-testing-passive-gov[1]
>> branch based on latest devfreq-next branch.
>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>
>> First of all, if possible, I want to test them[1] with your patches in this series.
>> And then if there are no any problem, please let me know. After confirmed from you,
>> I'll send the patches of devfreq-testing-passive-gov[1] branch.
>> How about that?
>>
> Hi Chanwoo~
> 
> We will use this on Google Chrome project.
> Google Hsin-Yi has test your patch + my patch set v8 [2~8]
> 
>     make sure cci devfreqs runs with cpufreq.
>     suspend resume
>     speedometer2 benchmark
> It is okay.
> 
> Please send the patches of devfreq-testing-passive-gov[1] branch.
> 
> I will send patch v9 base on yours latter.

Thanks for your test. I'll send the patches today.

> 
> 
>>
>>>
>>>>
>>>>
>>>>>
>>>>>
>>>>> On 3/23/21 8:33 PM, Andrew-sh.Cheng wrote:
>>>>>> From: Saravana Kannan <skannan@codeaurora.org>
>>>>>>
>>>>>> Many CPU architectures have caches that can scale independent of the
>>>>>> CPUs. Frequency scaling of the caches is necessary to make sure that the
>>>>>> cache is not a performance bottleneck that leads to poor performance and
>>>>>> power. The same idea applies for RAM/DDR.
>>>>>>
>>>>>> To achieve this, this patch adds support for cpu based scaling to the
>>>>>> passive governor. This is accomplished by taking the current frequency
>>>>>> of each CPU frequency domain and then adjust the frequency of the cache
>>>>>> (or any devfreq device) based on the frequency of the CPUs. It listens
>>>>>> to CPU frequency transition notifiers to keep itself up to date on the
>>>>>> current CPU frequency.
>>>>>>
>>>>>> To decide the frequency of the device, the governor does one of the
>>>>>> following:
>>>>>> * Derives the optimal devfreq device opp from required-opps property of
>>>>>>   the parent cpu opp_table.
>>>>>>
>>>>>> * Scales the device frequency in proportion to the CPU frequency. So, if
>>>>>>   the CPUs are running at their max frequency, the device runs at its
>>>>>>   max frequency. If the CPUs are running at their min frequency, the
>>>>>>   device runs at its min frequency. It is interpolated for frequencies
>>>>>>   in between.
>>>>>>
>>>>>> Andrew-sh.Cheng change
>>>>>> dev_pm_opp_xlate_opp to dev_pm_opp_xlate_required_opp devfreq->max_freq
>>>>>> to devfreq->user_min_freq_req.data.freq.qos->min_freq.target_value
>>>>>> after kernel-5.7
>>>>>> Don't return -EINVAL in devfreq_passive_event_handler()
>>>>>> since it doesn't handle DEVFREQ_GOV_SUSPEND DEVFREQ_GOV_RESUME cases.
>>>>>>
>>>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>>>> [Sibi: Integrated cpu-freqmap governor into passive_governor]
>>>>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>>>>> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
>>>>>> ---
>>>>>>  drivers/devfreq/Kconfig            |   2 +
>>>>>>  drivers/devfreq/governor_passive.c | 329 +++++++++++++++++++++++++++++++++++--
>>>>>>  include/linux/devfreq.h            |  29 +++-
>>>>>>  3 files changed, 342 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>>>> index 00704efe6398..f56132b0ae64 100644
>>>>>> --- a/drivers/devfreq/Kconfig
>>>>>> +++ b/drivers/devfreq/Kconfig
>>>>>> @@ -73,6 +73,8 @@ config DEVFREQ_GOV_PASSIVE
>>>>>>  	  device. This governor does not change the frequency by itself
>>>>>>  	  through sysfs entries. The passive governor recommends that
>>>>>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>>>>>> +	  Alternatively the governor can also be chosen to scale based on
>>>>>> +	  the online CPUs current frequency.
>>>>>>  
>>>>>>  comment "DEVFREQ Drivers"
>>>>>>  
>>>>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>>>>> index b094132bd20b..9cc57b083839 100644
>>>>>> --- a/drivers/devfreq/governor_passive.c
>>>>>> +++ b/drivers/devfreq/governor_passive.c
>>>>>> @@ -8,11 +8,103 @@
>>>>>>   */
>>>>>>  
>>>>>>  #include <linux/module.h>
>>>>>> +#include <linux/cpu.h>
>>>>>> +#include <linux/cpufreq.h>
>>>>>> +#include <linux/cpumask.h>
>>>>>>  #include <linux/device.h>
>>>>>>  #include <linux/devfreq.h>
>>>>>> +#include <linux/slab.h>
>>>>>>  #include "governor.h"
>>>>>>  
>>>>>> -static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>>>> +struct devfreq_cpu_state {
>>>>>> +	unsigned int curr_freq;
>>>>>> +	unsigned int min_freq;
>>>>>> +	unsigned int max_freq;
>>>>>> +	unsigned int first_cpu;
>>>>>> +	struct device *cpu_dev;
>>>>>> +	struct opp_table *opp_table;
>>>>>> +};
>>>>>
>>>>> As I knew, the previous version has the description of structure
>>>>> as following:  I wan to add the description like below.
>>>>>
>>>>> And if you have no any objection, I'd like you to order
>>>>> the variables as following and use 'dev' instead of 'cpu_dev'
>>>>> because this patch use the 'cpu_state->cpu_dev' at the multiple points.
>>>>> I think that 'cpu_state->dev' is better than 'cpu_state->cpu_dev'.
>>>>> Also, I prefer to use 'cur_freq' instead of 'curr_freq'
>>>>> because devfreq subsystem uses 'cur_freq' for expressing the 'current frequency'.
>>>>>
>>>>> /**                                                                             
>>>>>  * struct devfreq_cpu_state - Hold the per-cpu data                              
>>>>>  * @dev:        reference to cpu device.                                        
>>>>>  * @first_cpu:  the cpumask of the first cpu of a policy.                       
>>>>>  * @opp_table:  reference to cpu opp table.                                     
>>>>>  * @cur_freq:   the current frequency of the cpu.                               
>>>>>  * @min_freq:   the min frequency of the cpu.                                   
>>>>>  * @max_freq:   the max frequency of the cpu.                                   
>>>>>  *                                                                              
>>>>>  * This structure stores the required cpu_data of a cpu.                        
>>>>>  * This is auto-populated by the governor.                                      
>>>>>  */                                                                             
>>>>> struct devfreq_cpu_state {                                                       
>>>>>          struct device *dev;                                                     
>>>>>          unsigned int first_cpu;                                                 
>>>>>
>>>>>          struct opp_table *opp_table;                                            
>>>>>          unsigned int cur_freq;                                                  
>>>>>          unsigned int min_freq;                                                  
>>>>>          unsigned int max_freq;                                                  
>>>>> };               
>>>>>
>>>>>
>>>>>> +
>>>>>> +static unsigned long xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
>>>>>> +					      unsigned int cpu)
>>>>>> +{
>>>>>> +	unsigned int cpu_min_freq, cpu_max_freq, cpu_curr_freq_khz, cpu_percent;
>>>>>> +	unsigned long dev_min_freq, dev_max_freq, dev_max_state;
>>>>>> +
>>>>>> +	struct devfreq_cpu_state *cpu_state = data->cpu_state[cpu];
>>>>>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>>>>>> +	unsigned long *dev_freq_table = devfreq->profile->freq_table;
>>>>>> +	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
>>>>>> +	unsigned long cpu_curr_freq, freq;
>>>>>> +
>>>>>> +	if (!cpu_state || cpu_state->first_cpu != cpu ||
>>>>>> +	    !cpu_state->opp_table || !devfreq->opp_table)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	cpu_curr_freq = cpu_state->curr_freq * 1000;
>>>>>> +	p_opp = devfreq_recommended_opp(cpu_state->cpu_dev, &cpu_curr_freq, 0);
>>>>>> +	if (IS_ERR(p_opp))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	opp = dev_pm_opp_xlate_required_opp(cpu_state->opp_table,
>>>>>> +					    devfreq->opp_table, p_opp);
>>>>>> +	dev_pm_opp_put(p_opp);
>>>>>> +
>>>>>> +	if (!IS_ERR(opp)) {
>>>>>> +		freq = dev_pm_opp_get_freq(opp);
>>>>>> +		dev_pm_opp_put(opp);
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* Use Interpolation if required opps is not available */
>>>>>> +	cpu_min_freq = cpu_state->min_freq;
>>>>>> +	cpu_max_freq = cpu_state->max_freq;
>>>>>> +	cpu_curr_freq_khz = cpu_state->curr_freq;
>>>>>> +
>>>>>> +	if (dev_freq_table) {
>>>>>> +		/* Get minimum frequency according to sorting order */
>>>>>> +		dev_max_state = dev_freq_table[devfreq->profile->max_state - 1];
>>>>>> +		if (dev_freq_table[0] < dev_max_state) {
>>>>>> +			dev_min_freq = dev_freq_table[0];
>>>>>> +			dev_max_freq = dev_max_state;
>>>>>> +		} else {
>>>>>> +			dev_min_freq = dev_max_state;
>>>>>> +			dev_max_freq = dev_freq_table[0];
>>>>>> +		}
>>>>>> +	} else {
>>>>>> +		dev_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>>> +						     DEV_PM_QOS_MIN_FREQUENCY);
>>>>>> +		dev_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>>> +						     DEV_PM_QOS_MAX_FREQUENCY);
>>>>>> +
>>>>>> +		if (dev_max_freq <= dev_min_freq)
>>>>>> +			return 0;
>>>>>> +	}
>>>>>> +	cpu_percent = ((cpu_curr_freq_khz - cpu_min_freq) * 100) / cpu_max_freq - cpu_min_freq;
>>>>>> +	freq = dev_min_freq + mult_frac(dev_max_freq - dev_min_freq, cpu_percent, 100);
>>>>>> +
>>>>>> +out:
>>>>>> +	return freq;
>>>>>> +}
>>>>>> +
>>>>>> +static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
>>>>>> +					unsigned long *freq)
>>>>>> +{
>>>>>> +	struct devfreq_passive_data *p_data =
>>>>>> +				(struct devfreq_passive_data *)devfreq->data;
>>>>>> +	unsigned int cpu;
>>>>>> +	unsigned long target_freq = 0;
>>>>>> +
>>>>>> +	for_each_online_cpu(cpu)
>>>>>> +		target_freq = max(target_freq,
>>>>>> +				  xlate_cpufreq_to_devfreq(p_data, cpu));
>>>>>> +
>>>>>> +	*freq = target_freq;
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>
>>>>> As you knew, governor_passive.c was already used 
>>>>> both 'dev_pm_opp_xlate_required_opp' and 'devfreq_recommended_opp'
>>>>> to get the target from OPP. So, I wan to make the common function
>>>>> like 'get_taget_freq_by_required_opp' as following:
>>>>> If define 'get_taget_freq_by_required_opp' as following,
>>>>> it will be used for get_target_freq_with_devfreq().
>>>>> After finisied the review of this patch, I'll send the patch[2].
>>>>> [2] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing-passive-gov&id=101c5a087586ab2b5cf3370166a7e39227ca83cf__;!!CTRNKA9wMg0ARbw!zIrzeDp9vPnm1_SDzVPuzqdHn3zWie9DnfBXaA-j9-CSrVc6aR9_rJQQiw81_CgA6mp3Yqo$ 
>>>>>
>>>>> For example but this code is not tested,
>>>>> static unsigned long get_taget_freq_by_required_opp(struct device *p_dev,
>>>>> 						struct opp_table *p_opp_table,
>>>>> 						struct opp_table *opp_table,
>>>>> 						unsigned long freq)
>>>>> {
>>>>> 	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
>>>>>
>>>>> 	if (!p_dev || !p_opp_table || !opp_table || !freq)
>>>>> 		return 0;
>>>>>
>>>>> 	p_opp = devfreq_recommended_opp(p_dev, &freq, 0);
>>>>> 	if (IS_ERR(p_opp))
>>>>> 		return 0;
>>>>>
>>>>> 	opp = dev_pm_opp_xlate_required_opp(p_opp_table, opp_table, p_opp);
>>>>> 	dev_pm_opp_put(p_opp);
>>>>>
>>>>> 	if (IS_ERR(opp))
>>>>> 		return 0;
>>>>>
>>>>> 	freq = dev_pm_opp_get_freq(opp);
>>>>> 	dev_pm_opp_put(opp);
>>>>>
>>>>> 	return freq;
>>>>> }
>>>>>
>>>>> static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
>>>>> 					unsigned long *target_freq)
>>>>> {
>>>>> 	struct devfreq_passive_data *p_data =
>>>>> 				(struct devfreq_passive_data *)devfreq->data;
>>>>> 	struct devfreq_cpu_data *cpu_data;
>>>>> 	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
>>>>> 	unsigned long dev_min, dev_max;
>>>>> 	unsigned long freq = 0;
>>>>>
>>>>> 	for_each_online_cpu(cpu) {
>>>>> 		cpu_data = p_data->cpu_data[cpu];
>>>>> 		if (!cpu_data || cpu_data->first_cpu != cpu)
>>>>> 			continue;
>>>>>
>>>>> 		/* Get target freq via required opps */
>>>>> 		cpu_cur = cpu_data->cur_freq * HZ_PER_KHZ;
>>>>> 		freq = get_taget_freq_by_required_opp(cpu_data->dev,
>>>>> 					cpu_data->opp_table,
>>>>> 					devfreq->opp_table, cpu_cur);
>>>>> 		if (freq) {
>>>>> 			*target_freq = max(freq, *target_freq);
>>>>> 			continue;
>>>>> 		}
>>>>>
>>>>> 		/* Use Interpolation if required opps is not available */
>>>>> 		devfreq_get_freq_range(devfreq, &dev_min, &dev_max);
>>>>>
>>>>> 		cpu_min = cpu_data->min_freq;
>>>>> 		cpu_max = cpu_data->max_freq;
>>>>> 		cpu_cur = cpu_data->cur_freq;
>>>>>
>>>>> 		cpu_percent = ((cpu_cur - cpu_min) * 100) / cpu_max - cpu_min;
>>>>> 		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
>>>>>
>>>>> 		*target_freq = max(freq, *target_freq);
>>>>> 	}
>>>>>
>>>>> 	return 0;
>>>>> }
>>>>>
>>>>>> +
>>>>>> +static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>>>>>>  					unsigned long *freq)
>>>>>>  {
>>>>>>  	struct devfreq_passive_data *p_data
>>>>>> @@ -23,14 +115,6 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>>>>  	int i, count;
>>>>>>  
>>>>>>  	/*
>>>>>> -	 * If the devfreq device with passive governor has the specific method
>>>>>> -	 * to determine the next frequency, should use the get_target_freq()
>>>>>> -	 * of struct devfreq_passive_data.
>>>>>> -	 */
>>>>>> -	if (p_data->get_target_freq)
>>>>>> -		return p_data->get_target_freq(devfreq, freq);
>>>>>> -
>>>>>> -	/*
>>>>>>  	 * If the parent and passive devfreq device uses the OPP table,
>>>>>>  	 * get the next frequency by using the OPP table.
>>>>>>  	 */
>>>>>> @@ -98,6 +182,37 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> +static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>>>> +					   unsigned long *freq)
>>>>>> +{
>>>>>> +	struct devfreq_passive_data *p_data =
>>>>>> +		(struct devfreq_passive_data *)devfreq->data;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * If the devfreq device with passive governor has the specific method
>>>>>> +	 * to determine the next frequency, should use the get_target_freq()
>>>>>> +	 * of struct devfreq_passive_data.
>>>>>> +	 */
>>>>>> +	if (p_data->get_target_freq)
>>>>>> +		return p_data->get_target_freq(devfreq, freq);
>>>>>> +
>>>>>> +	switch (p_data->parent_type) {
>>>>>> +	case DEVFREQ_PARENT_DEV:
>>>>>> +		ret = get_target_freq_with_devfreq(devfreq, freq);
>>>>>> +		break;
>>>>>> +	case CPUFREQ_PARENT_DEV:
>>>>>> +		ret = get_target_freq_with_cpufreq(devfreq, freq);
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		ret = -EINVAL;
>>>>>> +		dev_err(&devfreq->dev, "Invalid parent type\n");
>>>>>> +		break;
>>>>>> +	}
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>>  static int devfreq_passive_notifier_call(struct notifier_block *nb,
>>>>>>  				unsigned long event, void *ptr)
>>>>>>  {
>>>>>> @@ -130,16 +245,200 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>>>>>>  	return NOTIFY_DONE;
>>>>>>  }
>>>>>>  
>>>>>> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
>>>>>> +					 unsigned long event, void *ptr)
>>>>>> +{
>>>>>> +	struct devfreq_passive_data *data =
>>>>>> +			container_of(nb, struct devfreq_passive_data, nb);
>>>>>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>>>>>> +	struct devfreq_cpu_state *cpu_state;
>>>>>> +	struct cpufreq_freqs *cpu_freq = ptr;
>>>>>
>>>>> Use 'freqs' variable name.  I prefer to use the same variable name
>>>>> for both devfreq_freqs and cpufreq_freqs instance.
>>>>>
>>>>>> +	unsigned int curr_freq;
>>>>>
>>>>> As I commented above, better to use 'cur_frq' instead of 'curr_freq'
>>>>> if there is no any special reason.
>>>>>
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (event != CPUFREQ_POSTCHANGE || !cpu_freq ||
>>>>>> +	    !data->cpu_state[cpu_freq->policy->cpu])
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	cpu_state = data->cpu_state[cpu_freq->policy->cpu];
>>>>>> +	if (cpu_state->curr_freq == cpu_freq->new)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	/* Backup current freq and pre-update cpu state freq*/
>>>>>
>>>>> I think that this commnet is not critial. So, please drop this comment.
>>>>>
>>>>>> +	curr_freq = cpu_state->curr_freq;
>>>>>> +	cpu_state->curr_freq = cpu_freq->new;
>>>>>> +
>>>>>> +	mutex_lock(&devfreq->lock);
>>>>>> +	ret = update_devfreq(devfreq);
>>>>>
>>>>> I recommend to use 'devfreq_update_target' instead of 'update_devfreq'
>>>>> as following:
>>>>> 	devfreq_update_target(devfreq, freqs->new);
>>>>>
>>>>>> +	mutex_unlock(&devfreq->lock);
>>>>>> +	if (ret) {
>>>>>> +		cpu_state->curr_freq = curr_freq;
>>>>>> +		dev_err(&devfreq->dev, "Couldn't update the frequency.\n");
>>>>>> +		return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
>>>>>
>>>>> In order to keep the consistent style of function name,
>>>>> please change the name as following because devfreq defines
>>>>> the function name as 'devfreq_regiter_notifier'
>>>>> - cpufreq_passive_register -> cpufreq_passive_register_notifier
>>>>>
>>>>>> +{
>>>>>> +	struct devfreq_passive_data *data = *p_data;
>>>>>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>>>>>> +	struct device *dev = devfreq->dev.parent;
>>>>>> +	struct opp_table *opp_table = NULL;
>>>>>> +	struct devfreq_cpu_state *cpu_state;
>>>>>> +	struct cpufreq_policy *policy;
>>>>>> +	struct device *cpu_dev;
>>>>>> +	unsigned int cpu;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	get_online_cpus();
>>>>>> +
>>>>>> +	data->nb.notifier_call = cpufreq_passive_notifier_call;
>>>>>> +	ret = cpufreq_register_notifier(&data->nb,
>>>>>> +					CPUFREQ_TRANSITION_NOTIFIER);
>>>>>> +	if (ret) {
>>>>>> +		dev_err(dev, "Couldn't register cpufreq notifier.\n");
>>>>>> +		data->nb.notifier_call = NULL;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* Populate devfreq_cpu_state */
>>>>>
>>>>> Don't need this comment. Please drop it.
>>>>>
>>>>>> +	for_each_online_cpu(cpu) {
>>>>>> +		if (data->cpu_state[cpu])
>>>>>> +			continue;
>>>>>> +
>>>>>> +		policy = cpufreq_cpu_get(cpu);
>>>>>> +		if (!policy) {
>>>>>> +			ret = -EINVAL;
>>>>>> +			goto out;
>>>>>> +		} else if (PTR_ERR(policy) == -EPROBE_DEFER) {
>>>>>> +			ret = -EPROBE_DEFER;
>>>>>> +			goto out;
>>>>>> +		} else if (IS_ERR(policy)) {
>>>>>> +			ret = PTR_ERR(policy);
>>>>>> +			dev_err(dev, "Couldn't get the cpufreq_poliy.\n");
>>>>>> +			goto out;
>>>>>> +		}
>>>>>
>>>>> Use dev_err_probe() funciotn to handle hte EPROBE_DEFER.
>>>>> It make code more simple.
>>>>>
>>>>>> +
>>>>>> +		cpu_state = kzalloc(sizeof(*cpu_state), GFP_KERNEL);
>>>>>> +		if (!cpu_state) {
>>>>>> +			ret = -ENOMEM;
>>>>>> +			goto out;
>>>>>> +		}
>>>>>> +
>>>>>> +		cpu_dev = get_cpu_device(cpu);
>>>>>> +		if (!cpu_dev) {
>>>>>> +			dev_err(dev, "Couldn't get cpu device.\n");
>>>>>> +			ret = -ENODEV;
>>>>>> +			goto out;
>>>>>> +		}
>>>>>> +
>>>>>> +		opp_table = dev_pm_opp_get_opp_table(cpu_dev);
>>>>>> +		if (IS_ERR(devfreq->opp_table)) {
>>>>>> +			ret = PTR_ERR(opp_table);
>>>>>> +			goto out;
>>>>>> +		}
>>>>>> +
>>>>>> +		cpu_state->cpu_dev = cpu_dev;
>>>>>> +		cpu_state->opp_table = opp_table;
>>>>>> +		cpu_state->first_cpu = cpumask_first(policy->related_cpus);
>>>>>> +		cpu_state->curr_freq = policy->cur;
>>>>>> +		cpu_state->min_freq = policy->cpuinfo.min_freq;
>>>>>> +		cpu_state->max_freq = policy->cpuinfo.max_freq;
>>>>>> +		data->cpu_state[cpu] = cpu_state;
>>>>>> +
>>>>>> +		cpufreq_cpu_put(policy);
>>>>>> +	}
>>>>>> +
>>>>>> +out:
>>>>>> +	put_online_cpus();
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	/* Update devfreq */
>>>>>> +	mutex_lock(&devfreq->lock);
>>>>>> +	ret = update_devfreq(devfreq);
>>>>>
>>>>>> +	mutex_unlock(&devfreq->lock);
>>>>>> +	if (ret)
>>>>>> +		dev_err(dev, "Couldn't update the frequency.\n");
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
>>>>>
>>>>> As I commented above, please change the name as following:
>>>>> - cpufreq_passive_unregister -> cpufreq_passive_unregister_notifier
>>>>>
>>>>>> +{
>>>>>> +	struct devfreq_passive_data *data = *p_data;
>>>>>> +	struct devfreq_cpu_state *cpu_state;
>>>>>> +	int cpu;
>>>>>> +
>>>>>> +	if (data->nb.notifier_call)
>>>>>> +		cpufreq_unregister_notifier(&data->nb,
>>>>>> +					    CPUFREQ_TRANSITION_NOTIFIER);
>>>>>> +
>>>>>> +	for_each_possible_cpu(cpu) {
>>>>>> +		cpu_state = data->cpu_state[cpu];
>>>>>> +		if (cpu_state) {
>>>>>> +			if (cpu_state->opp_table)
>>>>>> +				dev_pm_opp_put_opp_table(cpu_state->opp_table);
>>>>>> +			kfree(cpu_state);
>>>>>> +			cpu_state = NULL;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +int register_parent_dev_notifier(struct devfreq_passive_data **p_data)
>>>>>> +{
>>>>>> +	struct notifier_block *nb = &(*p_data)->nb;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	switch ((*p_data)->parent_type) {
>>>>>> +	case DEVFREQ_PARENT_DEV:
>>>>>> +		nb->notifier_call = devfreq_passive_notifier_call;
>>>>>> +		ret = devfreq_register_notifier((struct devfreq *)(*p_data)->parent, nb,
>>>>>> +						DEVFREQ_TRANSITION_NOTIFIER);
>>>>>> +		break;
>>>>>> +	case CPUFREQ_PARENT_DEV:
>>>>>> +		ret = cpufreq_passive_register(p_data);
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		ret = -EINVAL;
>>>>>> +		break;
>>>>>> +	}
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +int unregister_parent_dev_notifier(struct devfreq_passive_data **p_data)
>>>>>> +{
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	switch ((*p_data)->parent_type) {
>>>>>> +	case DEVFREQ_PARENT_DEV:
>>>>>> +		WARN_ON(devfreq_unregister_notifier((struct devfreq *)(*p_data)->parent,
>>>>>> +						    &(*p_data)->nb,
>>>>>> +						    DEVFREQ_TRANSITION_NOTIFIER));
>>>>>> +		break;
>>>>>> +	case CPUFREQ_PARENT_DEV:
>>>>>> +		cpufreq_passive_unregister(p_data);
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		ret = -EINVAL;
>>>>>> +		break;
>>>>>> +	}
>>>>>> +	return ret;
>>>>>> +}
>>>>>
>>>>> I think that you don't need to define register_parent_dev_notifier
>>>>> and unregister_parent_dev_notifier as the separate functions.
>>>>>
>>>>> Instead of the separate functions, just add the code
>>>>> into devfreq_passive_event_handler.
>>>>>
>>>>>
>>>>>> +
>>>>>>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>>>>  				unsigned int event, void *data)
>>>>>>  {
>>>>>>  	struct devfreq_passive_data *p_data
>>>>>>  			= (struct devfreq_passive_data *)devfreq->data;
>>>>>>  	struct devfreq *parent = (struct devfreq *)p_data->parent;
>>>>>> -	struct notifier_block *nb = &p_data->nb;
>>>>>>  	int ret = 0;
>>>>>>  
>>>>>> -	if (!parent)
>>>>>> +	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>>>>>>  		return -EPROBE_DEFER;
>>>>>>  
>>>>>>  	switch (event) {
>>>>>> @@ -147,13 +446,11 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>>>>  		if (!p_data->this)
>>>>>>  			p_data->this = devfreq;
>>>>>>  
>>>>>> -		nb->notifier_call = devfreq_passive_notifier_call;
>>>>>> -		ret = devfreq_register_notifier(parent, nb,
>>>>>> -					DEVFREQ_TRANSITION_NOTIFIER);
>>>>>> +		ret = register_parent_dev_notifier(&p_data);
>>>>>>  		break;
>>>>>> +
>>>>>>  	case DEVFREQ_GOV_STOP:
>>>>>> -		WARN_ON(devfreq_unregister_notifier(parent, nb,
>>>>>> -					DEVFREQ_TRANSITION_NOTIFIER));
>>>>>> +		ret = unregister_parent_dev_notifier(&p_data);
>>>>>>  		break;
>>>>>>  	default:
>>>>>>  		break;
>>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>>> index 26ea0850be9b..e0093b7c805c 100644
>>>>>> --- a/include/linux/devfreq.h
>>>>>> +++ b/include/linux/devfreq.h
>>>>>> @@ -280,6 +280,25 @@ struct devfreq_simple_ondemand_data {
>>>>>>  
>>>>>>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>>>>>>  /**
>>>>>> + * struct devfreq_cpu_state - holds the per-cpu state
>>>>>> + * @freq:	the current frequency of the cpu.
>>>>>> + * @min_freq:	the min frequency of the cpu.
>>>>>> + * @max_freq:	the max frequency of the cpu.
>>>>>> + * @first_cpu:	the cpumask of the first cpu of a policy.
>>>>>> + * @dev:	reference to cpu device.
>>>>>> + * @opp_table:	reference to cpu opp table.
>>>>>> + *
>>>>>> + * This structure stores the required cpu_state of a cpu.
>>>>>> + * This is auto-populated by the governor.
>>>>>> + */
>>>>>> +struct devfreq_cpu_state;
>>>>>> +
>>>>>> +enum devfreq_parent_dev_type {
>>>>>> +	DEVFREQ_PARENT_DEV,
>>>>>> +	CPUFREQ_PARENT_DEV,
>>>>>> +};
>>>>>> +
>>>>>> +/**
>>>>>>   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>>>>>>   *	and devfreq_add_device
>>>>>>   * @parent:	the devfreq instance of parent device.
>>>>>> @@ -290,13 +309,15 @@ struct devfreq_simple_ondemand_data {
>>>>>>   *			using governors except for passive governor.
>>>>>>   *			If the devfreq device has the specific method to decide
>>>>>>   *			the next frequency, should use this callback.
>>>>>> + * @parent_type:	parent type of the device
>>>>>>   * @this:	the devfreq instance of own device.
>>>>>>   * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>>>>>> + * @cpu_state:		the state min/max/current frequency of all online cpu's
>>>>>>   *
>>>>>>   * The devfreq_passive_data have to set the devfreq instance of parent
>>>>>>   * device with governors except for the passive governor. But, don't need to
>>>>>> - * initialize the 'this' and 'nb' field because the devfreq core will handle
>>>>>> - * them.
>>>>>> + * initialize the 'this', 'nb' and 'cpu_state' field because the devfreq core
>>>>>> + * will handle them.
>>>>>>   */
>>>>>>  struct devfreq_passive_data {
>>>>>>  	/* Should set the devfreq instance of parent device */
>>>>>> @@ -305,9 +326,13 @@ struct devfreq_passive_data {
>>>>>>  	/* Optional callback to decide the next frequency of passvice device */
>>>>>>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>>>>>>  
>>>>>> +	/* Should set the type of parent device */
>>>>>> +	enum devfreq_parent_dev_type parent_type;
>>>>>> +
>>>>>>  	/* For passive governor's internal use. Don't need to set them */
>>>>>>  	struct devfreq *this;
>>>>>>  	struct notifier_block nb;
>>>>>> +	struct devfreq_cpu_state *cpu_state[NR_CPUS];
>>>>>>  };
>>>>>>  #endif
>>>>>>  
>>>>>>
>>>>>
>>>>
>>>
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
