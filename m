Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC12BCDF
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 03:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfE1BZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 21:25:41 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52731 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfE1BZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 21:25:40 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190528012535epoutp0472fe0011537050560c9497c3c2f488fa~itF2elbSo1949819498epoutp046
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2019 01:25:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190528012535epoutp0472fe0011537050560c9497c3c2f488fa~itF2elbSo1949819498epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559006735;
        bh=eV9SGi440QDId+8MzsACV0pvR33jzAyYGgq6h5CcnTg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Uq3jfVn9QFyPbeML17jlUxQ76cccqi+VjEF+qQWRZievjLAuLKRP+Jxbgj185nxLV
         L3mXCrEJMp+jyZBoA29Y7XhrUEkhxtOK57UEgsUGztpwSFnA8rXoOJA9cZznyNRIUJ
         2r0rD1fnVpY+nCKDpl5EkUj1Zmwav+UbCJolJ2qA=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190528012532epcas1p2f98a8d413fa56c0ed7ba1fe0adb4aa86~itFzm-R1Z1005510055epcas1p2f;
        Tue, 28 May 2019 01:25:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.45.04139.C0E8CEC5; Tue, 28 May 2019 10:25:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190528012531epcas1p4dc98453939e3f1c4c1fdf31cad4c54df~itFzSMggD0899508995epcas1p41;
        Tue, 28 May 2019 01:25:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190528012531epsmtrp1fee18fd0f8680246137a5ce4b12f13ab~itFzQ6fWp2808228082epsmtrp1i;
        Tue, 28 May 2019 01:25:31 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-b4-5cec8e0c3223
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.7E.03662.B0E8CEC5; Tue, 28 May 2019 10:25:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190528012531epsmtip2bfa5ee94cd3706aceb68b08683268920~itFy__Mgm1928619286epsmtip2Z;
        Tue, 28 May 2019 01:25:31 +0000 (GMT)
Subject: Re: [PATCH RFC 3/9] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org, Saravana Kannan <skannan@codeaurora.org>,
        linux-kernel-owner@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <624af369-87b2-38d2-ee62-7a1864e31713@samsung.com>
Date:   Tue, 28 May 2019 10:27:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3a2ad1bc744f85804c5f0dc9a74b69ff@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjl+LIzCtJLcpLzFFi42LZdljTQJen702MQeN/Fov/J40tTu9/x2Kx
        /udZJovXC3oZLeYfOcdqcXbZQTaL1vvTmSym793EZnG26Q27xe/FE9gtljWIWVzeNYfN4nPv
        EUaLpdcvMlncblzBZvHmB1D/mdOXWC2WXdnMatG69wi7xb9rG1ksri18z2px4OJENouNXz0c
        xD3WzFvD6DG74SKLx+W+XiaPTas62TzuXNvD5rHlajuLR9+WVYwex29sZ/L4vEkugDMq2yYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6E8lhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnZG362T
        jAVvzzNW/FqS18A4cQNjFyMHh4SAicTdk65djFwcQgI7GCW6ZjxhgnA+MUrs+9vJDuF8Y5S4
        0H2OFabjWLsRRHwvo0Tn4ylQHe8ZJY6ungPUwckhLBAnMW/5G2YQW0RATeLYufmMIEXMAodY
        JHZumQiWYBPQktj/4gYbiM0voChx9cdjRhCbV8BO4sbbdrA4i4CqxJozn8BsUYEIifvHNrBC
        1AhKnJz5hAXE5gSq37zqNxOIzSwgLnHryXwoW16ieetsZpDFEgJ/2SV2/14B9bSLxIsz+iA1
        EgLCEq+Ob2GHsKUkXva3QdnVEitPHmGD6O1glNiy/wIrRMJYYv/SyUwgc5gFNCXW74Kaoyix
        8/dcRoi9fBLvvvZAQ4tXoqNNCKJEWeLyg7tMELakxOL2TrYJjEqzkHwzC8kHs5B8MAth2QJG
        llWMYqkFxbnpqcWGBYbIsb2JEZwHtEx3ME4553OIUYCDUYmH1+LU6xgh1sSy4srcQ4wSHMxK
        IrymW17FCPGmJFZWpRblxxeV5qQWH2I0BQb2RGYp0eR8YI7KK4k3NDUyNja2MDE0MzU0VBLn
        jee+GSMkkJ5YkpqdmlqQWgTTx8TBKdXAGKHJKq457b9nTKvxk6K+ysXm+dsEwj+mWU282aOY
        0Zf+4aHE2myODEcW02/nhPNWW13p4u17q7Fg7UKN859mCYZvmHt58qXYwD9hS6SWfvVSeflx
        6/mj24TeZU+7/zDH/FSanaem33+V2afeF9yTEZly/fPFZU2JnWUiD7oyvj2bvfKB6/sD7Uos
        xRmJhlrMRcWJAPbYFXQZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCSvC5335sYg09PtCz+nzS2OL3/HYvF
        +p9nmSxeL+hltJh/5ByrxdllB9ksWu9PZ7KYvncTm8XZpjfsFr8XT2C3WNYgZnF51xw2i8+9
        Rxgtll6/yGRxu3EFm8WbH0D9Z05fYrVYdmUzq0Xr3iPsFv+ubWSxuLbwPavFgYsT2Sw2fvVw
        EPdYM28No8fshossHpf7epk8Nq3qZPO4c20Pm8eWq+0sHn1bVjF6HL+xncnj8ya5AM4oLpuU
        1JzMstQifbsEroy+WycZC96eZ6z4tSSvgXHiBsYuRg4OCQETiWPtRl2MXBxCArsZJTZO+Mfe
        xcgJFJeUmHbxKDNEjbDE4cPFEDVvGSXavk1lBqkRFoiTmLf8DZgtIqAmcezcfEYQm1ngEIvE
        3F1WEA2LmCTeXj/HBJJgE9CS2P/iBhuIzS+gKHH1x2OwBl4BO4kbb9vB4iwCqhJrznwCs0UF
        IiTOvF/BAlEjKHFy5hMwmxOofvOq30wQy9Ql/sy7xAxhi0vcejIfKi4v0bx1NvMERuFZSNpn
        IWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxghOCltYOxhMn4g8x
        CnAwKvHwWpx6HSPEmlhWXJl7iFGCg1lJhNd0y6sYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy
        +ccihQTSE0tSs1NTC1KLYLJMHJxSDYztkhFBXeHJ89NbHBh5Gpqlt8g/OuN5qu6k+dn5ldbX
        PuieDzz4OEWsd4VrUck7rvQnzzqNm05nPfJY16myr3JS35Qlb3ti572c/HrHSTYVm1qbIyt+
        3DTtvnfm5bfZPVu0C/st8i4djF5v8PLs9P0rwznuVVVPXXJm4pXnIoHHyhNqt9z/xxOvxFKc
        kWioxVxUnAgAzunwUwQDAAA=
X-CMS-MailID: 20190528012531epcas1p4dc98453939e3f1c4c1fdf31cad4c54df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190328152906epcas1p15eb7c52740986df90a44ce265bef7d7c
References: <20190328152822.532-1-sibis@codeaurora.org>
        <CGME20190328152906epcas1p15eb7c52740986df90a44ce265bef7d7c@epcas1p1.samsung.com>
        <20190328152822.532-4-sibis@codeaurora.org>
        <6e639c37-c231-f0b5-a280-9a69f2211ccc@samsung.com>
        <3a2ad1bc744f85804c5f0dc9a74b69ff@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sibi,

On 19. 5. 27. 오후 5:23, Sibi Sankar wrote:
> Hey Chanwoo,
> 
> Thanks a lot for reviewing the patch. Like I
> had indicated earlier we decided to go with
> a simpler approach instead on qualcomm SoCs.
> I am happy to re-spin this patch with your
> comments addressed if we do find other users
> for this feature.

Actually, I think that this approach is necessary.
On many real released product like smartphone
have the dependency between cpufreq and devfreq
for memory bus bandwidth. For example, when playing
the video or get the 60fps without loss.

If possible, this patch should be ongoing on either
now or future. Thanks.

> 
> On 2019-04-12 13:09, Chanwoo Choi wrote:
>> Hi,
>>
>> I agree this approach absolutely.
>> Just I add some comments. Please check it.
>>
>> On 19. 3. 29. 오전 12:28, Sibi Sankar wrote:
>>> From: Saravana Kannan <skannan@codeaurora.org>
>>>
>>> Many CPU architectures have caches that can scale independent of the
>>> CPUs. Frequency scaling of the caches is necessary to make sure the cache
>>> is not a performance bottleneck that leads to poor performance and
>>> power. The same idea applies for RAM/DDR.
>>>
>>> To achieve this, this patch add support for cpu based scaling to the
>>> passive governor. This is accomplished by taking the current frequency
>>> of each CPU frequency domain and then adjusts the frequency of the cache
>>> (or any devfreq device) based on the frequency of the CPUs. It listens
>>> to CPU frequency transition notifiers to keep itself up to date on the
>>> current CPU frequency.
>>>
>>> To decide the frequency of the device, the governor does one of the
>>> following:
>>> * Constructs a CPU frequency to device frequency mapping table from
>>>   required-opps property of the devfreq device's opp_table
>>>
>>> * Scales the device frequency in proportion to the CPU frequency. So, if
>>>   the CPUs are running at their max frequency, the device runs at its
>>>   max frequency. If the CPUs are running at their min frequency, the
>>>   device runs at its min frequency. It is interpolated for frequencies
>>>   in between.
>>>
>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>> [Sibi: Integrated cpu-freqmap governor into passive_governor]
>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>> ---
>>>  drivers/devfreq/Kconfig            |   4 +
>>>  drivers/devfreq/governor_passive.c | 276 ++++++++++++++++++++++++++++-
>>>  include/linux/devfreq.h            |  43 ++++-
>>>  3 files changed, 315 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 6a172d338f6d..9a45f464a56b 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -72,6 +72,10 @@ config DEVFREQ_GOV_PASSIVE
>>>        device. This governor does not change the frequency by itself
>>>        through sysfs entries. The passive governor recommends that
>>>        devfreq device uses the OPP table to get the frequency/voltage.
>>> +      Alternatively the governor can also be chosen to scale based on
>>> +      the online CPUs current frequency. A CPU frequency to device
>>> +      frequency mapping table(s) is auto-populated by the governor
>>> +      for this purpose.
>>>
>>>  comment "DEVFREQ Drivers"
>>>
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index 3bc29acbd54e..2506682b233b 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -11,10 +11,63 @@
>>>   */
>>>
>>>  #include <linux/module.h>
>>> +#include <linux/cpu.h>
>>> +#include <linux/cpufreq.h>
>>> +#include <linux/cpumask.h>
>>>  #include <linux/device.h>
>>>  #include <linux/devfreq.h>
>>> +#include <linux/of.h>
>>> +#include <linux/slab.h>
>>>  #include "governor.h"
>>>
>>> +static unsigned int xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
>>> +                         unsigned int cpu)
>>> +{
>>> +    unsigned int cpu_min, cpu_max;
>>> +    struct devfreq *devfreq = (struct devfreq *)data->this;
>>> +    unsigned int dev_min, dev_max, cpu_percent, cpu_freq = 0, freq = 0;
>>> +    unsigned long *freq_table = devfreq->profile->freq_table;
>>> +    struct device *dev = devfreq->dev.parent;
>>> +    struct devfreq_map *map;
>>> +    int opp_cnt, i;
>>> +
>>> +    if (!data->state[cpu] || data->state[cpu]->first_cpu != cpu) {
>>> +        freq = 0;
>>> +        goto out;
>>
>> goto out -> return 0;
>>
>>> +    }
>>> +
>>> +    /* Use Interpolation if map is not available */
>>> +    cpu_freq = data->state[cpu]->freq;
>>> +    if (!data->map) {
>>> +        cpu_min = data->state[cpu]->min_freq;
>>> +        cpu_max = data->state[cpu]->max_freq;
>>> +        if (freq_table) {
>>> +            dev_min = freq_table[0];
>>> +            dev_max = freq_table[devfreq->profile->max_state - 1];
>>
>> Actually, it is not always true. The devfreq recommend the ascending order for
>> 'freq_table'. But, it is not mandatory. Also, some devfreq device uses the
>> decending order for 'freq_table'. So, a patch[1] was considering the order
>> when getting the minimum/maximum frequency from freq_table.
>>
>> If you want to get the minimum/maximum frequency, you have to consider the order
>> of 'freq_table' as the patch[1].
>>
>> [1] df5cf4a36178 ("PM / devfreq: Fix handling of min/max_freq == 0")
>>
>>              /* Get minimum frequency according to sorting order */
>> +               if (freq_table[0] < freq_table[df->profile->max_state - 1])
>> +                       value = freq_table[0];
>> +               else
>> +                       value = freq_table[df->profile->max_state - 1];
>>
>>
>>> +        } else {
>>> +            if (devfreq->max_freq <= devfreq->min_freq)
>>> +                return 0;
>>> +            dev_min = devfreq->min_freq;
>>> +            dev_max = devfreq->max_freq;
>>> +        }
>>> +
>>> +        cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
>>> +        freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
>>> +        goto out;
>>
>> You don't need to jump 'out'. Instead, you better to use the 'else' statement
>> for if data->map is not NULL. I think that almost case when using this patch
>> will be available of data->map. In order to skip the likely 'false' statement,
>> I recommend the following sequence.
>>
>>     if (data->map) {
>>         map = data->map[cpu];
>>         ...
>>     } else {
>>         /* Use Interpolation if map is not available */
>>     }
>>
>>
>>> +    }
>>> +
>>> +    map = data->map[cpu];
>>> +    opp_cnt = dev_pm_opp_get_opp_count(dev);
>>> +    for (i = 0; i < opp_cnt; i++) {
>>> +        freq = max(freq, map[i].dev_hz);
>>> +        if (map[i].cpu_khz >= cpu_freq)
>>> +            break;
>>> +    }
>>> +out:
>>> +    dev_dbg(dev, "CPU%u: %d -> dev: %u\n", cpu, cpu_freq, freq);
>>
>> IMO, I think it is not necessary. If you want to print log, you better to print
>> it on device driver instead of governor.
>>
>>> +    return freq;
>>> +}
>>> +
>>>  static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>                      unsigned long *freq)
>>>  {
>>> @@ -23,6 +76,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>      struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>>>      unsigned long child_freq = ULONG_MAX;
>>>      struct dev_pm_opp *opp;
>>> +    unsigned int cpu, tgt_freq = 0;
>>
>> tgt means 'target'? If right, just use target_freq intead of 'tgt_freq'
>> for the readability.
>>
>>>      int i, count, ret = 0;
>>>
>>>      /*
>>> @@ -35,6 +89,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>          goto out;
>>>      }
>>>
>>> +    if (p_data->cpufreq_type) {
>>> +        for_each_possible_cpu(cpu)
>>> +            tgt_freq = max(tgt_freq,
>>> +                       xlate_cpufreq_to_devfreq(p_data, cpu));
>>> +        *freq = tgt_freq;
>>
>> You better to change from 'tgt_freq' to 'target_freq' for the readability.
>>
>>> +        goto out;
>>> +    }
>>
>> I think that 'goto out' using is not proper for supporting two case.
>> Instead, you better to split out as following according to the type
>> of parent device (devfreq device or cpufreq device).
>>
>>     switch (p_data->parent_type) {
>>     case DEVFREQ_PARENT_DEV:
>>         ret = get_target_freq_with_devfreq()
>>         break;
>>     case CPUFREQ_PARENT_DEV:
>>         ret = get_target_freq_with_cpufreq()
>>         break;
>>     default:
>>         dev_err(...)
>>         ret = -EINVAL;
>>         goto out;
>>     }
>>
>>     if (ret < 0) {
>>         /* exception handling for 'ret' value */
>>     }
>>
>>> +
>>>      /*
>>>       * If the parent and passive devfreq device uses the OPP table,
>>>       * get the next frequency by using the OPP table.
>>> @@ -149,6 +211,200 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>>>      return NOTIFY_DONE;
>>>  }
>>>
>>> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
>>> +                     unsigned long event, void *ptr)
>>> +{
>>> +    struct devfreq_passive_data *data =
>>> +            container_of(nb, struct devfreq_passive_data, nb);
>>> +    struct devfreq *devfreq = (struct devfreq *)data->this;
>>> +    struct cpufreq_freqs *freq = ptr;
>>> +    struct devfreq_cpu_state *state;
>>
>> nitpick. how about using 'cpu_state' instead of 'state'?
>> in order to get the meaning from just variable name.
>>
>>> +    int ret = 0;
>>> +
>>> +    if (event != CPUFREQ_POSTCHANGE)
>>> +        goto out;
>>
>> just 'return' is simple instead of 'goto out' because this case
>> don't need to treat the any restoring code. And also, you have
>> to check whether freq is NULL or not as following:
>>
>>     if (event != CPUFREQ_POSTCHANGE || !freq || data->state[freq->cpu])
>>         return ret;
>>     state = data->state[freq->cpu];
>>
>>> +
>>> +    state = data->state[freq->cpu];
>>> +    if (!state)
>>> +        goto out;
>>> +
>>> +    if (state->freq != freq->new) {
>>> +        state->freq = freq->new;
>>
>> You have to update the frequency after update_devfreq() is completed
>> without error.
>>
>>> +        mutex_lock(&devfreq->lock);
>>> +        ret = update_devfreq(devfreq);
>>> +        mutex_unlock(&devfreq->lock);
>>> +        if (ret)
>>> +            dev_err(&devfreq->dev, "Frequency update failed.\n");
>>
>> Almost devfreq error used the following format: "Couldn't ..." .
>> If there is no any specific reason to change the format for error log,
>>     "Couldnt update the frequency.\n"
>>
>>> +    }> +out:
>>> +    return ret;
>>
>> Also, we can reduce the unneeded indentation as following:
>>
>>     if (state->freq == freq->new)
>>         return ret;
>>
>>     mutex_lock(&devfreq->lock);
>>     ret = update_devfreq(devfreq);
>>     mutex_unlock(&devfreq->lock);
>>     if (ret) {
>>         dev_err(&devfreq->dev, "Couldnt update the frequency.\n");
>>         return ret;
>>     }
>>     state->freq = freq->new;
>>
>>     return 0;
>>
>>> +}
>>> +
>>> +static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
>>> +{
>>> +    unsigned int cpu;
>>> +    struct devfreq_map **cpu_map;
>>> +    struct devfreq_map *map, *per_cpu_map;
>>> +    struct devfreq_passive_data *data = *p_data;
>>> +    struct devfreq *devfreq = (struct devfreq *)data->this;
>>> +    int i, count = 0, opp_cnt = 0, ret = 0, iter_val = 0;
>>> +    struct device_node *np, *opp_table_np, *cpu_np;
>>> +    struct opp_table *opp_table, *cpu_opp_tbl;
>>> +    struct device *dev = devfreq->dev.parent;
>>> +    struct devfreq_cpu_state *state;
>>> +    struct dev_pm_opp *opp, *cpu_opp;
>>> +    struct cpufreq_policy *policy;
>>> +    struct device *cpu_dev;
>>> +    u64 cpu_khz, dev_hz;
>>> +
>>> +    get_online_cpus();
>>> +    data->nb.notifier_call = cpufreq_passive_notifier_call;
>>> +    ret = cpufreq_register_notifier(&data->nb,
>>> +                    CPUFREQ_TRANSITION_NOTIFIER);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    /* Populate devfreq_cpu_state */
>>> +    for_each_online_cpu(cpu) {
>>> +        if (data->state[cpu])
>>> +            continue;
>>> +
>>> +        policy = cpufreq_cpu_get(cpu);
>>> +        if (policy) {
>>> +            state = kzalloc(sizeof(*state), GFP_KERNEL);
>>> +            if (!state)
>>> +                return -ENOMEM;
>>> +
>>> +            state->first_cpu = cpumask_first(policy->related_cpus);
>>> +            state->freq = policy->cur;
>>> +            state->min_freq = policy->cpuinfo.min_freq;
>>> +            state->max_freq = policy->cpuinfo.max_freq;
>>> +            data->state[cpu] = state;
>>> +            cpufreq_cpu_put(policy);
>>> +        } else {
>>> +            return -EPROBE_DEFER;
>>> +        }
>>> +    }
>>> +
>>> +    opp_table_np = dev_pm_opp_of_get_opp_desc_node(dev);
>>> +    if (!opp_table_np)
>>> +        goto out;
>>> +
>>> +    opp_cnt = dev_pm_opp_get_opp_count(dev);
>>> +    if (opp_cnt <= 0)
>>> +        goto put_opp_table;
>>> +
>>> +    /* Allocate memory for devfreq_map*/
>>> +    cpu_map = kcalloc(num_possible_cpus(), sizeof(*cpu_map), GFP_KERNEL);
>>> +    if (!cpu_map)
>>> +        return -ENOMEM;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        per_cpu_map = kcalloc(opp_cnt, sizeof(*per_cpu_map),
>>> +                      GFP_KERNEL);
>>> +        if (!per_cpu_map)
>>> +            return -ENOMEM;
>>> +        cpu_map[cpu] = per_cpu_map;
>>> +    }
>>> +    data->map = cpu_map;
>>> +
>>> +    /* Populate devfreq_map */
>>> +    opp_table = dev_pm_opp_get_opp_table(dev);
>>> +    if (!opp_table)
>>> +        return -ENOMEM;
>>> +
>>> +    for_each_available_child_of_node(opp_table_np, np) {
>>> +        opp = dev_pm_opp_find_opp_of_np(opp_table, np);
>>> +        if (IS_ERR(opp))
>>> +            continue;
>>> +
>>> +        dev_hz = dev_pm_opp_get_freq(opp);
>>> +        dev_pm_opp_put(opp);
>>> +
>>> +        count = of_count_phandle_with_args(np, "required-opps", NULL);
>>> +        for (i = 0; i < count; i++) {
>>> +            for_each_possible_cpu(cpu) {
>>> +                cpu_dev = get_cpu_device(cpu);
>>> +                if (!cpu_dev) {
>>> +                    dev_err(dev, "CPU get device failed.\n");
>>> +                    continue;
>>> +                }
>>> +
>>> +                cpu_np = of_parse_required_opp(np, i);
>>> +                if (!cpu_np) {
>>> +                    dev_err(dev, "Parsing required opp failed.\n");
>>> +                    continue;
>>> +                }
>>> +
>>> +                /* Get cpu opp-table */
>>> +                cpu_opp_tbl = dev_pm_opp_get_opp_table(cpu_dev);
>>> +                if (!cpu_opp_tbl) {
>>> +                    dev_err(dev, "CPU opp table get failed.\n");
>>> +                    goto put_cpu_node;
>>> +                }
>>> +
>>> +                /* Match the cpu opp node from required-opp with
>>> +                 * the cpu-opp table */
>>> +                cpu_opp = dev_pm_opp_find_opp_of_np(cpu_opp_tbl,
>>> +                                    cpu_np);
>>> +                if (!cpu_opp) {
>>> +                    dev_dbg(dev, "CPU opp get failed.\n");
>>> +                    goto put_cpu_opp_table;
>>> +                }
>>> +
>>> +                cpu_khz = dev_pm_opp_get_freq(cpu_opp);
>>> +                if (cpu_opp && cpu_khz) {
>>> +                    /* Update freq-map if not already set */
>>> +                    map = cpu_map[cpu];
>>> +                    map[iter_val].cpu_khz = cpu_khz / 1000;
>>> +                    map[iter_val].dev_hz = dev_hz;
>>> +                }
>>> +                dev_pm_opp_put(cpu_opp);
>>> +put_cpu_opp_table:
>>> +                dev_pm_opp_put_opp_table(cpu_opp_tbl);
>>> +put_cpu_node:
>>> +                of_node_put(cpu_np);
>>> +            }
>>> +        }
>>> +        iter_val++;
>>> +    }
>>> +    dev_pm_opp_put_opp_table(opp_table);
>>> +put_opp_table:
>>> +    of_node_put(opp_table_np);
>>> +out:
>>> +    put_online_cpus();
>>> +
>>> +    /* Update devfreq */
>>> +    mutex_lock(&devfreq->lock);
>>> +    ret = update_devfreq(devfreq);
>>> +    mutex_unlock(&devfreq->lock);
>>> +    if (ret)
>>> +        dev_err(dev, "Frequency update failed.\n");
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
>>> +{
>>> +    int cpu;
>>> +    struct devfreq_passive_data *data = *p_data;
>>> +
>>> +    cpufreq_unregister_notifier(&data->nb,
>>> +                    CPUFREQ_TRANSITION_NOTIFIER);
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        kfree(data->state[cpu]);
>>> +        kfree(data->map[cpu]);
>>> +        data->state[cpu] = NULL;
>>> +        data->map[cpu] = NULL;
>>> +    }
>>> +
>>> +    kfree(data->map);
>>> +    data->map = NULL;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>                  unsigned int event, void *data)
>>>  {
>>> @@ -159,7 +415,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>      struct notifier_block *nb = &p_data->nb;
>>>      int ret = 0;
>>>
>>> -    if (!parent)
>>> +    if (!parent && !p_data->cpufreq_type)
>>>          return -EPROBE_DEFER;
>>
>> It makes the fault for the existing devfreq devices with passive governor.
>> Please remove '!p_data->cpufreq_type' condition.
>>
>>>
>>>      switch (event) {
>>> @@ -167,13 +423,21 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>>          if (!p_data->this)
>>>              p_data->this = devfreq;
>>>
>>> -        nb->notifier_call = devfreq_passive_notifier_call;
>>> -        ret = devm_devfreq_register_notifier(dev, parent, nb,
>>> -                    DEVFREQ_TRANSITION_NOTIFIER);
>>> +        if (p_data->cpufreq_type) {
>>> +            ret = cpufreq_passive_register(&p_data);
>>> +        } else {
>>> +            nb->notifier_call = devfreq_passive_notifier_call;
>>> +            ret = devm_devfreq_register_notifier(dev, parent, nb,
>>> +                        DEVFREQ_TRANSITION_NOTIFIER);
>>> +        }
>>
>> I suggested the my opinion aboyt 'cpufreq_type' variable below.
>> You can separte it for more clready with using parent device type.
>>
>>         if (p_data->parent_type == DEVFREQ_PARENT_DEV)
>>             ...
>>         else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
>>             ...
>>         else
>>             // error handling
>>
>>>          break;
>>>      case DEVFREQ_GOV_STOP:
>>> -        devm_devfreq_unregister_notifier(dev, parent, nb,
>>> -                    DEVFREQ_TRANSITION_NOTIFIER);
>>> +        if (p_data->cpufreq_type) {
>>> +            cpufreq_passive_unregister(&p_data);
>>> +        } else {
>>> +            devm_devfreq_unregister_notifier(dev, parent, nb,
>>> +                        DEVFREQ_TRANSITION_NOTIFIER);
>>> +        }
>>
>> ditto.
>>
>>>          break;
>>>      default:
>>>          break;
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index fbffa74bfc1b..e8235fbe49e6 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -265,6 +265,38 @@ struct devfreq_simple_ondemand_data {
>>>  #endif
>>>
>>>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>>> +/**
>>> + * struct devfreq_cpu_state - holds the per-cpu state
>>> + * @freq:    holds the current frequency of the cpu.
>>> + * @min_freq:    holds the min frequency of the cpu.
>>> + * @max_freq:    holds the max frequency of the cpu.
>>> + * @first_cpu:    holds the cpumask of the first cpu of a policy.
>>> + *
>>> + * This structure stores the required cpu_state of a cpu.
>>> + * This is auto-populated by the governor.
>>> + */
>>> +struct devfreq_cpu_state {
>>> +    unsigned int freq;
>>> +    unsigned int min_freq;
>>> +    unsigned int max_freq;
>>> +    unsigned int first_cpu;
>>> +};
>>> +
>>> +/**
>>> + * struct devfreq_map - holds mapping from cpu frequency
>>> + * to devfreq frequency
>>> + * @cpu_khz:    holds the cpu frequency in Khz
>>> + * @dev_hz:    holds the devfreq device frequency in Hz
>>> + *
>>> + * This structure stores the lookup table between cpu
>>> + * and the devfreq device. This is auto-populated by the
>>> + * governor.
>>> + */
>>> +struct devfreq_map {
>>
>> How about changing the structure name as following or others?
>> - devfreq_freq_map or devfreq_cpufreq_map or others.
>>
>> Because this structure name guessing the meaning of mapping
>> between devfreq frequency and cpufreq frequency.
>>
>>> +    unsigned int cpu_khz;
>>> +    unsigned int dev_hz;
>>> +};
>>> +
>>>  /**
>>>   * struct devfreq_passive_data - void *data fed to struct devfreq
>>>   *    and devfreq_add_device
>>> @@ -278,11 +310,13 @@ struct devfreq_simple_ondemand_data {
>>>   *            the next frequency, should use this callback.
>>>   * @this:    the devfreq instance of own device.
>>>   * @nb:        the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>>> + * @state:    holds the state min/max/current frequency of all online cpu's
>>
>> As I commented above, how about using 'cpu_state' instead of 'state'?
>> in order to get the meaning from just variable name.
>>
>> nitpick. Also,  I think that you can skip 'holds' from the description
>> of 'state' variable.
>>
>>
>>> + * @map:    holds the maps between cpu frequency and device frequency
>>
>> How about using 'cpufreq_map' instead of 'map' for the readability?
>> IMHO, Because this variable is only used when parent device is cpu.
>> I think that if you add to specify the meaningful prefix about cpu to
>> variable name,
>> it is easy to catch the meaning of variable.
>> - map -> cpufreq_map.
>>
>> nitpick. Also,  I think that you can skip 'holds' from the description
>> of 'map' variable.
>>
>>>   *
>>>   * The devfreq_passive_data have to set the devfreq instance of parent
>>>   * device with governors except for the passive governor. But, don't need to
>>> - * initialize the 'this' and 'nb' field because the devfreq core will handle
>>> - * them.
>>> + * initialize the 'this', 'nb', 'state' and 'map' field because the devfreq
>>
>> If you agree my opinion above,
>> - state -> cpu_state.
>> - map -> cpufreq_map
>>
>>> + * core will handle them.
>>>   */
>>>  struct devfreq_passive_data {
>>>      /* Should set the devfreq instance of parent device */
>>> @@ -291,9 +325,14 @@ struct devfreq_passive_data {
>>>      /* Optional callback to decide the next frequency of passvice device */
>>>      int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>>>
>>> +    /* Should be set if the devfreq device wants to be scaled with cpu*/
>>> +    u8 cpufreq_type;
>>
>> The devfreq devices with passive governor have always parent
>> either devfreq device or cpufreq device. So, you better to specify
>> the parent type as following: I think that it is more clear to check
>> the type of parent device.
>>
>>     enum devfreq_parent_dev_type {
>>         DEVFREQ_PARENT_DEV,
>>         CPUFREQ_PARENT_DEV,
>>     };
>>
>>     enum devfreq_parent_dev_type parent_type;
>>
>>> +
>>>      /* For passive governor's internal use. Don't need to set them */
>>>      struct devfreq *this;
>>>      struct notifier_block nb;
>>> +    struct devfreq_cpu_state *state[NR_CPUS];
>>> +    struct devfreq_map **map;
>>
>> ditto.
>>
>>>  };
>>>  #endif
>>>
>>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
