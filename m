Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3823AAB72
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 07:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQF5A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 01:57:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34772 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhFQF5A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 01:57:00 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210617055451epoutp0140f5a37ab14bb5f0c409f43341c24ffa~JSOWfPySh2284722847epoutp01F
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 05:54:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210617055451epoutp0140f5a37ab14bb5f0c409f43341c24ffa~JSOWfPySh2284722847epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623909291;
        bh=wcLBZoPp19KWIv+7gHUcAa+hal9sOYH3w3Mi3pUtulg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rrQDnZc1V0G4+7gelUqn2BPYp5+zLhE/Vt5N4JIv6tOzgp8CAtzqCcQgGmgjiwnVB
         bBhh7eRWZH6o6OtbEsRcWM+Z8q7pKy1MDDfcQldx3E417ISVUls/1dKWwFudXkSvfd
         j/SzeuhFG7LFNhIoftT6DF6yKzryRr53WlU8J8To=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210617055451epcas1p34a8b56fb29bf61ce1f231c9335045643~JSOV307FS2733327333epcas1p3M;
        Thu, 17 Jun 2021 05:54:51 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G5B8m2v6wz4x9QG; Thu, 17 Jun
        2021 05:54:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.33.10258.6A3EAC06; Thu, 17 Jun 2021 14:54:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210617055445epcas1p4c8d136d940624897f5383ca502ca1024~JSOQudZSj2418024180epcas1p4k;
        Thu, 17 Jun 2021 05:54:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210617055445epsmtrp15f4879ed38c5f83645b07619d3cfbce6~JSOQtnBmH2282422824epsmtrp1W;
        Thu, 17 Jun 2021 05:54:45 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-ab-60cae3a6afe5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.9E.08637.5A3EAC06; Thu, 17 Jun 2021 14:54:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210617055445epsmtip11430ea10c571ba5327c38dc9fc991e44~JSOQbxl1g1940119401epsmtip1E;
        Thu, 17 Jun 2021 05:54:45 +0000 (GMT)
Subject: Re: [PATCH 3/4] PM / devfreq: Add cpu based scaling support to
 passive governor
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, chanwoo@kernel.org,
        cwchoi00@gmail.com, Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cdab8d60-b6af-704c-0f36-4bc6395e0832@samsung.com>
Date:   Thu, 17 Jun 2021 15:13:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAJMQK-i+VnmNybe+0fKJJkEb5gmKyo59pvAoKvH5det1fJ0UBQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmnu6yx6cSDFZ8YrXYvv4Fq8XEG1dY
        LJ4d1baY0Lqd2eJs0xt2i8u75rBZfO49wmhxu3EFm0XXob9sFtcWvme1OHBxIpsDt8fshoss
        Hpf7epk8ds66y+6xYFOpx6ZVnWweLSf3s3j0bVnF6PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QnUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iy53/+xF2zoY6z48mYxWwPj
        tLguRk4OCQETiRunn7N3MXJxCAnsYJR48eIgG4TziVHi4ZU1TBDON0aJx2uWsMC0LL60nwUi
        sZdRYnHncaj+94wSJ19uYwKpEhaIkthwfj0biC0ioCYx9dJfsA5mgV9MEv+WzwMbxSagJbH/
        xQ2wIn4BRYmrPx4zdjFycPAK2EnM7SgECbMIqErcWrWeEcQWFQiTOLmtBczmFRCUODnzCdgY
        ToFAiWV3tzKD2MwC4hK3nsxngrDlJba/ncMMsldC4AKHxP6Hy5khXnCRmLBqMhOELSzx6vgW
        dghbSuJlfxuUXS2x8uQRNojmDkaJLfsvsEIkjCX2LwVp5gDaoCmxfpc+RFhRYufvuYwQi/kk
        3n3tYQUpkRDglehoE4IoUZa4/OAu1FpJicXtnWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVIL
        inPTU4sNC0yQ43sTIzgVa1nsYJz79oPeIUYmDsZDjBIczEoivLrFJxKEeFMSK6tSi/Lji0pz
        UosPMZoCA3gis5Rocj4wG+SVxBuaGhkbG1uYGJqZGhoqifPuZDuUICSQnliSmp2aWpBaBNPH
        xMEp1cAUO7M5/1poqTxb8b5j/mc8Ha7I6miukzi5SXmS4KRdiubfPyjO41qytt1jsQKDeGD9
        vFlFRauk3Nq8GS7Ir/G8yCiy7HbN9jP8HB4124VzjlbdNWS7VbTCOF5q11HWhcpFdTEnjf6a
        MKQGbxTdHaH96tmSN8sS9lkv+t+063Lu+baqL5nTV855pfbZ93dWn5z4VZN52/5Gbb0vMEep
        1MVr/kX7pLfnF0rbRO6Rslp+7fOkyNnyBtvZpL3ebOZaeTXp0ZOWeUsTdnLzKTD9OD77Qu5V
        y2n53yJVme51TP5tfO+u+pP/7A43r+lrpXztTHbZ9snKba7awgP5iTHGtxIrPta/2czJuuCk
        6NvLqpERSizFGYmGWsxFxYkAoj44VE4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSnO7Sx6cSDG68FrPYvv4Fq8XEG1dY
        LJ4d1baY0Lqd2eJs0xt2i8u75rBZfO49wmhxu3EFm0XXob9sFtcWvme1OHBxIpsDt8fshoss
        Hpf7epk8ds66y+6xYFOpx6ZVnWweLSf3s3j0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxtzv
        /9gLNvQxVnx5s5itgXFaXBcjJ4eEgInE4kv7WboYuTiEBHYzStxuvMcMkZCUmHbxKJDNAWQL
        Sxw+XAxR85ZRYsHzuWA1wgJREhvOr2cDsUUE1CSmXvoLNohZ4BeTxKUFl5ghOtqYJP4tXgFW
        xSagJbH/xQ0wm19AUeLqj8eMIBt4Bewk5nYUgoRZBFQlbq1azwhiiwqESexc8pgJxOYVEJQ4
        OfMJC4jNKRAosezuVrAjmAXUJf7MuwRli0vcejKfCcKWl9j+dg7zBEbhWUjaZyFpmYWkZRaS
        lgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJjUktzB+P2VR/0DjEycTAeYpTg
        YFYS4dUtPpEgxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dU
        A5PQ5bTFm5exXZ38d1Z2XOO6vUu6gl8x/bmXxrDDfmZGNaOtk1m8Xvj1BeH/g3bbXNE8Vvc9
        /ODkdOF/EeJrDF6s+tat4jiNmTvxyIb6FAXNnD1eLsuaPq+Nl356hrXii7hwxfcF52arsaV/
        tt1YelNyy9+N33kf8QtavTHa9c7z6wVz281X/oVUdYg7sR78v5XxeMc/b7/3yZumbdS+OtWq
        TmbqvF/XJovztzvPYohtjjU6qh1YMDGdm2uy0ZrbXuzGM5c7OC459ukv97tgtcCdxl/SU2xu
        53FmXbwuNClcssB33XO7c+93atgUTayscPVy62F+bhvH9F/hVNh62RWMngL5H2W8rs9zdu1u
        cFJiKc5INNRiLipOBAC8cUhtOAMAAA==
X-CMS-MailID: 20210617055445epcas1p4c8d136d940624897f5383ca502ca1024
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae
References: <CGME20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae@epcas1p4.samsung.com>
        <20210617060546.26933-1-cw00.choi@samsung.com>
        <20210617060546.26933-4-cw00.choi@samsung.com>
        <CAJMQK-i+VnmNybe+0fKJJkEb5gmKyo59pvAoKvH5det1fJ0UBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/17/21 2:51 PM, Hsin-Yi Wang wrote:
> On Thu, Jun 17, 2021 at 1:46 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
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
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> [Sibi: Integrated cpu-freqmap governor into passive_governor]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> [Chanwoo: Fix conflict with latest code and clean code up]
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/governor.h         |  22 +++
>>  drivers/devfreq/governor_passive.c | 264 ++++++++++++++++++++++++++++-
>>  include/linux/devfreq.h            |  16 +-
>>  3 files changed, 293 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index 9a9495f94ac6..3c36c92c89a9 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>> @@ -47,6 +47,28 @@
>>  #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL              BIT(0)
>>  #define DEVFREQ_GOV_ATTR_TIMER                         BIT(1)
>>
>> +/**
>> + * struct devfreq_cpu_data - Hold the per-cpu data
>> + * @dev:       reference to cpu device.
>> + * @first_cpu: the cpumask of the first cpu of a policy.
>> + * @opp_table: reference to cpu opp table.
>> + * @cur_freq:  the current frequency of the cpu.
>> + * @min_freq:  the min frequency of the cpu.
>> + * @max_freq:  the max frequency of the cpu.
>> + *
>> + * This structure stores the required cpu_data of a cpu.
>> + * This is auto-populated by the governor.
>> + */
>> +struct devfreq_cpu_data {
>> +       struct device *dev;
>> +       unsigned int first_cpu;
>> +
>> +       struct opp_table *opp_table;
>> +       unsigned int cur_freq;
>> +       unsigned int min_freq;
>> +       unsigned int max_freq;
>> +};
>> +
>>  /**
>>   * struct devfreq_governor - Devfreq policy governor
>>   * @node:              list node - contains registered devfreq governors
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> index fc09324a03e0..07e864509b7e 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -8,11 +8,84 @@
>>   */
>>
>>  #include <linux/module.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/slab.h>
>>  #include <linux/device.h>
>>  #include <linux/devfreq.h>
>>  #include "governor.h"
>>
>> -static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>> +#define HZ_PER_KHZ     1000
>> +
>> +static unsigned long get_taget_freq_by_required_opp(struct device *p_dev,
>> +                                               struct opp_table *p_opp_table,
>> +                                               struct opp_table *opp_table,
>> +                                               unsigned long freq)
>> +{
>> +       struct dev_pm_opp *opp = NULL, *p_opp = NULL;
>> +
>> +       if (!p_dev || !p_opp_table || !opp_table || !freq)
>> +               return 0;
>> +
>> +       p_opp = devfreq_recommended_opp(p_dev, &freq, 0);
>> +       if (IS_ERR(p_opp))
>> +               return 0;
>> +
>> +       opp = dev_pm_opp_xlate_required_opp(p_opp_table, opp_table, p_opp);
>> +       dev_pm_opp_put(p_opp);
>> +
>> +       if (IS_ERR(opp))
>> +               return 0;
>> +
>> +       freq = dev_pm_opp_get_freq(opp);
>> +       dev_pm_opp_put(opp);
>> +
>> +       return freq;
>> +}
>> +
>> +static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
>> +                                       unsigned long *target_freq)
>> +{
>> +       struct devfreq_passive_data *p_data =
>> +                               (struct devfreq_passive_data *)devfreq->data;
>> +       struct devfreq_cpu_data *cpu_data;
> We might have to rename the cpu_data variable.
> 
> For some architectures, cpu_data is defined as macro. This results in
> errors such as
> 
> include/linux/devfreq.h:331:27: note: in expansion of macro 'cpu_data'
>      331 |  struct devfreq_cpu_data *cpu_data[NR_CPUS];
>          |                           ^~~~~~~~
>    In file included from include/linux/devfreq_cooling.h:13,
>                     from drivers/devfreq/devfreq.c:14:
>    include/linux/devfreq.h:332:1: warning: no semicolon at end of
> struct or union

OK. I'll rename. 

> 
>> +       unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
>> +       unsigned long dev_min, dev_max;
>> +       unsigned long freq = 0;
>> +
>> +       for_each_online_cpu(cpu) {
>> +               cpu_data = p_data->cpu_data[cpu];
>> +               if (!cpu_data || cpu_data->first_cpu != cpu)
>> +                       continue;
>> +
>> +               /* Get target freq via required opps */
>> +               cpu_cur = cpu_data->cur_freq * HZ_PER_KHZ;
>> +               freq = get_taget_freq_by_required_opp(cpu_data->dev,
>> +                                       cpu_data->opp_table,
>> +                                       devfreq->opp_table, cpu_cur);
>> +               if (freq) {
>> +                       *target_freq = max(freq, *target_freq);
>> +                       continue;
>> +               }
>> +
>> +               /* Use Interpolation if required opps is not available */
>> +               devfreq_get_freq_range(devfreq, &dev_min, &dev_max);
>> +
>> +               cpu_min = cpu_data->min_freq;
>> +               cpu_max = cpu_data->max_freq;
>> +               cpu_cur = cpu_data->cur_freq;
>> +
>> +               cpu_percent = ((cpu_cur - cpu_min) * 100) / (cpu_max - cpu_min);
>> +               freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
>> +
>> +               *target_freq = max(freq, *target_freq);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>>                                         unsigned long *freq)
>>  {
>>         struct devfreq_passive_data *p_data
>> @@ -99,6 +172,172 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>         return 0;
>>  }
>>
>> +static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>> +                                          unsigned long *freq)
>> +{
>> +       struct devfreq_passive_data *p_data =
>> +                               (struct devfreq_passive_data *)devfreq->data;
>> +       int ret;
>> +
>> +       if (!p_data)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * If the devfreq device with passive governor has the specific method
>> +        * to determine the next frequency, should use the get_target_freq()
>> +        * of struct devfreq_passive_data.
>> +        */
>> +       if (p_data->get_target_freq)
>> +               return p_data->get_target_freq(devfreq, freq);
>> +
>> +       switch (p_data->parent_type) {
>> +       case DEVFREQ_PARENT_DEV:
>> +               ret = get_target_freq_with_devfreq(devfreq, freq);
>> +               break;
>> +       case CPUFREQ_PARENT_DEV:
>> +               ret = get_target_freq_with_cpufreq(devfreq, freq);
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               dev_err(&devfreq->dev, "Invalid parent type\n");
>> +               break;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
>> +                                        unsigned long event, void *ptr)
>> +{
>> +       struct devfreq_passive_data *data =
>> +                       container_of(nb, struct devfreq_passive_data, nb);
>> +       struct devfreq *devfreq = (struct devfreq *)data->this;
>> +       struct devfreq_cpu_data *cpu_data;
>> +       struct cpufreq_freqs *freqs = ptr;
>> +       unsigned int cur_freq;
>> +       int ret;
>> +
>> +       if (event != CPUFREQ_POSTCHANGE || !freqs ||
>> +               !data->cpu_data[freqs->policy->cpu])
>> +               return 0;
>> +
>> +       cpu_data = data->cpu_data[freqs->policy->cpu];
>> +       if (cpu_data->cur_freq == freqs->new)
>> +               return 0;
>> +
>> +       cur_freq = cpu_data->cur_freq;
>> +       cpu_data->cur_freq = freqs->new;
>> +
>> +       mutex_lock(&devfreq->lock);
>> +       ret = devfreq_update_target(devfreq, freqs->new);
>> +       mutex_unlock(&devfreq->lock);
>> +       if (ret) {
>> +               cpu_data->cur_freq = cur_freq;
>> +               dev_err(&devfreq->dev, "failed to update the frequency.\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>> +{
>> +       struct devfreq_passive_data *p_data
>> +                       = (struct devfreq_passive_data *)devfreq->data;
>> +       struct device *dev = devfreq->dev.parent;
>> +       struct opp_table *opp_table = NULL;
>> +       struct devfreq_cpu_data *cpu_data;
>> +       struct cpufreq_policy *policy;
>> +       struct device *cpu_dev;
>> +       unsigned int cpu;
>> +       int ret;
>> +
>> +       get_online_cpus();
>> +
>> +       p_data->nb.notifier_call = cpufreq_passive_notifier_call;
>> +       ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
>> +       if (ret) {
>> +               dev_err(dev, "failed to register cpufreq notifier\n");
>> +               p_data->nb.notifier_call = NULL;
>> +               goto out;
>> +       }
>> +
>> +       for_each_online_cpu(cpu) {
>> +               if (p_data->cpu_data[cpu])
>> +                       continue;
>> +
>> +               policy = cpufreq_cpu_get(cpu);
>> +               if (policy) {
>> +                       cpu_data = kzalloc(sizeof(*cpu_data), GFP_KERNEL);
>> +                       if (!cpu_data) {
>> +                               ret = -ENOMEM;
>> +                               goto out;
>> +                       }
>> +
>> +                       cpu_dev = get_cpu_device(cpu);
>> +                       if (!cpu_dev) {
>> +                               dev_err(dev, "failed to get cpu device\n");
>> +                               ret = -ENODEV;
>> +                               goto out;
>> +                       }
>> +
>> +                       opp_table = dev_pm_opp_get_opp_table(cpu_dev);
>> +                       if (IS_ERR(opp_table)) {
>> +                               ret = PTR_ERR(opp_table);
>> +                               goto out;
>> +                       }
>> +
>> +                       cpu_data->dev = cpu_dev;
>> +                       cpu_data->opp_table = opp_table;
>> +                       cpu_data->first_cpu = cpumask_first(policy->related_cpus);
>> +                       cpu_data->cur_freq = policy->cur;
>> +                       cpu_data->min_freq = policy->cpuinfo.min_freq;
>> +                       cpu_data->max_freq = policy->cpuinfo.max_freq;
>> +
>> +                       p_data->cpu_data[cpu] = cpu_data;
>> +                       cpufreq_cpu_put(policy);
>> +               } else {
>> +                       ret = -EPROBE_DEFER;
>> +                       goto out;
>> +               }
>> +       }
>> +out:
>> +       put_online_cpus();
>> +       if (ret)
>> +               return ret;
>> +
>> +       mutex_lock(&devfreq->lock);
>> +       ret = devfreq_update_target(devfreq, 0L);
>> +       mutex_unlock(&devfreq->lock);
>> +       if (ret)
>> +               dev_err(dev, "failed to update the frequency\n");
>> +
>> +       return ret;
>> +}
>> +
>> +static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
>> +{
>> +       struct devfreq_passive_data *p_data
>> +                       = (struct devfreq_passive_data *)devfreq->data;
>> +       struct devfreq_cpu_data *cpu_data;
>> +       int cpu;
>> +
>> +       if (p_data->nb.notifier_call)
>> +               cpufreq_unregister_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               cpu_data = p_data->cpu_data[cpu];
>> +               if (cpu_data) {
>> +                       if (cpu_data->opp_table)
>> +                               dev_pm_opp_put_opp_table(cpu_data->opp_table);
>> +                       kfree(cpu_data);
>> +                       cpu_data = NULL;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int devfreq_passive_notifier_call(struct notifier_block *nb,
>>                                 unsigned long event, void *ptr)
>>  {
>> @@ -140,7 +379,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>         struct notifier_block *nb = &p_data->nb;
>>         int ret = 0;
>>
>> -       if (!parent)
>> +       if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>>                 return -EPROBE_DEFER;
>>
>>         switch (event) {
>> @@ -148,13 +387,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>                 if (!p_data->this)
>>                         p_data->this = devfreq;
>>
>> -               nb->notifier_call = devfreq_passive_notifier_call;
>> -               ret = devfreq_register_notifier(parent, nb,
>> -                                       DEVFREQ_TRANSITION_NOTIFIER);
>> +               if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
>> +                       nb->notifier_call = devfreq_passive_notifier_call;
>> +                       ret = devfreq_register_notifier(parent, nb,
>> +                                               DEVFREQ_TRANSITION_NOTIFIER);
>> +               } else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
>> +                       ret = cpufreq_passive_register_notifier(devfreq);
>> +               } else {
>> +                       ret = -EINVAL;
>> +               }
>>                 break;
>>         case DEVFREQ_GOV_STOP:
>> -               WARN_ON(devfreq_unregister_notifier(parent, nb,
>> -                                       DEVFREQ_TRANSITION_NOTIFIER));
>> +               if (p_data->parent_type == DEVFREQ_PARENT_DEV)
>> +                       WARN_ON(devfreq_unregister_notifier(parent, nb,
>> +                                               DEVFREQ_TRANSITION_NOTIFIER));
>> +               else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
>> +                       WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
>> +               else
>> +                       ret = -EINVAL;
>>                 break;
>>         default:
>>                 break;
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 142474b4af96..cfa0ef54841e 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -38,6 +38,7 @@ enum devfreq_timer {
>>
>>  struct devfreq;
>>  struct devfreq_governor;
>> +struct devfreq_cpu_data;
>>  struct thermal_cooling_device;
>>
>>  /**
>> @@ -288,6 +289,11 @@ struct devfreq_simple_ondemand_data {
>>  #endif
>>
>>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>> +enum devfreq_parent_dev_type {
>> +       DEVFREQ_PARENT_DEV,
>> +       CPUFREQ_PARENT_DEV,
>> +};
>> +
>>  /**
>>   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>>   *     and devfreq_add_device
>> @@ -299,8 +305,10 @@ struct devfreq_simple_ondemand_data {
>>   *                     using governors except for passive governor.
>>   *                     If the devfreq device has the specific method to decide
>>   *                     the next frequency, should use this callback.
>> - * @this:      the devfreq instance of own device.
>> - * @nb:                the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>> + + * @parent_type      parent type of the device
>> + + * @this:            the devfreq instance of own device.
>> + + * @nb:              the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>> + + * @cpu_data:                the state min/max/current frequency of all online cpu's
>>   *
>>   * The devfreq_passive_data have to set the devfreq instance of parent
>>   * device with governors except for the passive governor. But, don't need to
>> @@ -314,9 +322,13 @@ struct devfreq_passive_data {
>>         /* Optional callback to decide the next frequency of passvice device */
>>         int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>>
>> +       /* Should set the type of parent device */
>> +       enum devfreq_parent_dev_type parent_type;
>> +
>>         /* For passive governor's internal use. Don't need to set them */
>>         struct devfreq *this;
>>         struct notifier_block nb;
>> +       struct devfreq_cpu_data *cpu_data[NR_CPUS];
>>  };
>>  #endif
>>
>> --
>> 2.17.1
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
