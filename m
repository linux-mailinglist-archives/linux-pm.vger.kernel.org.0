Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63F356401
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFZIJ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 04:09:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17359 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFZIJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 04:09:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190626080952epoutp02ac3aca8ad0b56ba8668155b7e04956ee~rsUHxAABB2621026210epoutp02X
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 08:09:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190626080952epoutp02ac3aca8ad0b56ba8668155b7e04956ee~rsUHxAABB2621026210epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561536592;
        bh=hwvzKux7nSoIBOUroXhjMa8F4uRoM+fnis1PGiReeQU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XUT++bpNoHEwVQTy88F5qwr4PUAPOpEXTDRIJU+NwOHMWWNJYpp4SjMZg5cM7atGU
         4fGgMgmhyXBoxDs1OcS0AkVsTVCJOuejL0NEtA1BQOU41vl8Jz6h8U/a8FgG7gzUUS
         zb17f72YM7l5Ix93IXmUI4HjXZ/VgUAEeEs3uuXI=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190626080949epcas1p3a52b3db1ae388308edaa9f075048f00a~rsUE7js501930719307epcas1p3T;
        Wed, 26 Jun 2019 08:09:49 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.D7.04142.D48231D5; Wed, 26 Jun 2019 17:09:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190626080948epcas1p329a2e1e68fbe15cbeb31c2f49dee95f0~rsUEIC6s41202312023epcas1p3B;
        Wed, 26 Jun 2019 08:09:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626080948epsmtrp13d16caf5a513307c186304fcebe3e279~rsUEG9PXB0308803088epsmtrp1n;
        Wed, 26 Jun 2019 08:09:48 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-00-5d13284dfc1f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.36.03662.C48231D5; Wed, 26 Jun 2019 17:09:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190626080948epsmtip2a2b03c84482e91e4aaeba14293821820~rsUDw1iYn1405114051epsmtip26;
        Wed, 26 Jun 2019 08:09:48 +0000 (GMT)
Subject: Re: [PATCH RFC 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
To:     Sibi Sankar <sibis@codeaurora.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>,
        linux-kernel-owner@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <17b27bc6-5dc7-8ffa-2022-93c526bdf1d1@samsung.com>
Date:   Wed, 26 Jun 2019 17:12:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <04bbd518efef8296e450e984e6afdba2@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmnq6vhnCswcsVchbb179gtZjQup3Z
        4mzTG3aLTY+vsVosaxCzuLxrDpvF5eaLjBafe48wWjS1GFvcblzBZnFt4XtWiwMXJ7I58HjM
        brjI4nG5r5fJY+esu+wem5fUe7Sc3M/i0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2
        St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcqKZQl5pQChQISi4uV9O1sivJLS1IV
        MvKLS2yVUgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7IznnzlKbg9iamiufkUawPj/xeM
        XYycHBICJhIPlvxi72Lk4hAS2MEosfDpL2YI5xOjxN8T96Ccb4wSE1c3MsG0XDx3nA0isZdR
        YseX2UwQzntGibtfJ7KBVAkLpEscO/4XyObgEBHwkti6Ow6khlngCrPExm+XWEBq2AS0JPa/
        uAFWzy+gKHH1x2Owo3gF7CTaW6eB2SwCqhLrbl9kBbFFBSIkLm/ZBVUjKHFy5hOwOZxA9Wfm
        /2MHsZkFxCVuPZnPBGHLSzRvnQ32goTAInaJ7r8XoF5wkVixeyMbhC0s8er4FnYIW0riZX8b
        lF0tsfLkETaI5g5GiS37L7BCJIwl9i+dzATyGbOApsT6XfoQYUWJnb/nMkIs5pN497WHFaRE
        QoBXoqNNCKJEWeLyg7tQJ0hKLG7vZJvAqDQLyTuzkLwwC8kLsxCWLWBkWcUollpQnJueWmxY
        YIQc35sYwYlYy2wH46JzPocYBTgYlXh4G+SFYoVYE8uKK3MPMUpwMCuJ8C5NFIgV4k1JrKxK
        LcqPLyrNSS0+xGgKDO2JzFKiyfnALJFXEm9oamRsbGxhYmhmamioJM4bz30zRkggPbEkNTs1
        tSC1CKaPiYNTqoGRTyknPqfZ4uGT+/t8+3cqd17Yq/HsvKfTZWfOxwb3ZH9Or4upWKlpL1JQ
        X/r3tHnb1mNB11Yuc9gRJnORPWbxpZcKvxVOVVY1G1zOnstknZAR837OOwvV+5NuzhG505do
        xvHcKexExgNfhrjO/28mzI+J5PoqyFr14ZoGW3Fg2Cw9+eincs1KLMUZiYZazEXFiQC5hnX7
        2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSvK6PhnCswb3ZChbb179gtZjQup3Z
        4mzTG3aLTY+vsVosaxCzuLxrDpvF5eaLjBafe48wWjS1GFvcblzBZnFt4XtWiwMXJ7I58HjM
        brjI4nG5r5fJY+esu+wem5fUe7Sc3M/i0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlPvvIU
        3J7EVNHcfIq1gfH/C8YuRk4OCQETiYvnjrN1MXJxCAnsZpR40fWMFSIhKTHt4lHmLkYOIFtY
        4vDhYoiat4wSu09+ZgKpERZIlzh2/C8bSI2IgJfE1t1xIDXMAjeYJf4df8IE1cAksf/YJ7Ch
        bAJaEvtf3GADsfkFFCWu/ngMdgWvgJ1Ee+s0MJtFQFVi3e2LYPWiAhESfW2z2SBqBCVOznzC
        AmJzAtWfmf+PHcRmFlCX+DPvEjOELS5x68l8JghbXqJ562zmCYzCs5C0z0LSMgtJyywkLQsY
        WVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHpJbWDsYTJ+IPMQpwMCrx8DbIC8UK
        sSaWFVfmHmKU4GBWEuFdmigQK8SbklhZlVqUH19UmpNafIhRmoNFSZxXPv9YpJBAemJJanZq
        akFqEUyWiYNTqoExZt7t0FO3HaK+r1XxbdBOiHNfrhwQKbGwhet2ZKr/sxP7DeNUU69+2Dk7
        dW79lnWV+sJeF/euW7Gt9GLTUinWQ1Ulz/YYTNwY8pjheRnj7Wpmoz/xbGez0qf9ba8OLakt
        OB2164Omua2RbuP1C1OfHd549Y5umUb5c4WK5+6pDwRu5Cbob25UYinOSDTUYi4qTgQAWfuR
        YsQCAAA=
X-CMS-MailID: 20190626080948epcas1p329a2e1e68fbe15cbeb31c2f49dee95f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190618041513epcas5p1bc626114804cb68bbf857f0a826c7599
References: <20190618041433.245629-1-hsinyi@chromium.org>
        <CGME20190618041513epcas5p1bc626114804cb68bbf857f0a826c7599@epcas5p1.samsung.com>
        <20190618041433.245629-2-hsinyi@chromium.org>
        <958b27ff-6e64-b4e2-44e6-bc342e3606bc@samsung.com>
        <CAJMQK-jELbhCUb5LYOnGMsBHjhZHnXMYQYDxWyEmriJf8OSpSQ@mail.gmail.com>
        <04bbd518efef8296e450e984e6afdba2@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Sibi and Hsin-Yi,

On 19. 6. 20. 오후 6:41, Sibi Sankar wrote:
> Hey Hsin-Yi, Chanwoo
> 
> On 2019-06-20 15:02, Hsin-Yi Wang wrote:
>> Hi Chanwoo Choi, Saravana Kannan and Sibi Sankar,
>>
>> I've also tested Sibi Sankar's patch[1] locally with mt8183-cci, and
>> it works fine too!
>> It'd be great if Sibi Sankar or anyone who is familiar with the
>> original design can finish this implementation. But if no one has time
>> to do that, I think I can also help on address the comments. Thanks!
> 
> Now that we have a user :) I am happy
> to repost the patch with the comments
> addressed.
> 
> https://lkml.org/lkml/2019/6/14/4
> Also with ^^ patch and few more in the
> series the dt parsing of required-opps
> should get further simplified.

Even if patch[1] suggested by Saravana is merged,
the patch[2] is necessary. Because, until now,
the child devfreq device cannot catch the timing
of CPU frequency without CPUFREQ notification.

The existing passive governor only supports between
devfreq device and other devfreq device.

[1] https://lkml.org/lkml/2019/6/14/4

[2]
[PATCH RFC 0/9] Add CPU based scaling support to Passive governor
- https://lore.kernel.org/lkml/08c3cff8c39e3d82e044db93e992da72@codeaurora.org/T/
[PATCH RFC 3/9] PM / devfreq: Add cpu based scaling support to passive_governor
- https://lore.kernel.org/lkml/08c3cff8c39e3d82e044db93e992da72@codeaurora.org/T/#m1cafb7baf687d2a680d39c85d3ec7d1b590b68fc



> 
>>
>>
>> [1]
>> [RFC,2/9] OPP: Export a number of helpers to prevent code duplication
>> - https://patchwork.kernel.org/patch/10875199/
>> [RFC,3/9] PM / devfreq: Add cpu based scaling support to passive_governor
>> - https://patchwork.kernel.org/patch/10875195/
>>
>> Hsin-Yi
>>
>> On Thu, Jun 20, 2019 at 2:56 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>
>>> + Sibi Sankar
>>>
>>> Hi, Hsin-Yi Wang, Saravana Kannan and Sibi Sankar
>>>
>>> I summarized the history of the related patch about this title.
>>>
>>> Firstly,
>>> As I knew, Saravana sent the patch[1] which contains
>>> 'governor_cpufreq_map.c' last year. According to the Myungoo's comment,
>>>
>>> Secondly,
>>> Sibi Sankar modified the 'governor_passive.c'[2] in order to support
>>> the mapping between cpu frequency and device frequency.
>>> Unfortunately, Sibi Sankar stopped the development about this
>>> because he had found the other method to get his purpose as I knew.
>>>
>>> Thirdly,
>>> Hsin-Yi Wang send the original patch of Saravana without modification.
>>>
>>>
>>> Sincerely, I think that the mapping between cpu frequency and device
>>> frequency is necessary. And I prefer the Sibi's approach which implements
>>> stuff to the existing 'passive' governor.
>>>
>>> We need to discuss about how to implement them by whom.
>>>
>>>
>>> [1] [v3,1/2] PM / devfreq: Generic CPU frequency to device frequency mapping governor
>>> - https://patchwork.kernel.org/patch/10553171/
>>>
>>> [2]
>>> [PATCH RFC 0/9] Add CPU based scaling support to Passive governor
>>> - https://lore.kernel.org/lkml/08c3cff8c39e3d82e044db93e992da72@codeaurora.org/T/
>>> [PATCH RFC 3/9] PM / devfreq: Add cpu based scaling support to passive_governor
>>> - https://lore.kernel.org/lkml/08c3cff8c39e3d82e044db93e992da72@codeaurora.org/T/#m1cafb7baf687d2a680d39c85d3ec7d1b590b68fc
>>>
>>>
>>> Best Regards,
>>> Chanwoo Choi
>>>
>>> On 19. 6. 18. 오후 1:14, Hsin-Yi Wang wrote:
>>> > From: Saravana Kannan <skannan@codeaurora.org>
>>> >
>>> > From: Saravana Kannan <skannan@codeaurora.org>
>>> >
>>> > Many CPU architectures have caches that can scale independent of the CPUs.
>>> > Frequency scaling of the caches is necessary to make sure the cache is not
>>> > a performance bottleneck that leads to poor performance and power. The same
>>> > idea applies for RAM/DDR.
>>> >
>>> > To achieve this, this patch adds a generic devfreq governor that takes the
>>> > current frequency of each CPU frequency domain and then adjusts the
>>> > frequency of the cache (or any devfreq device) based on the frequency of
>>> > the CPUs. It listens to CPU frequency transition notifiers to keep itself
>>> > up to date on the current CPU frequency.
>>> >
>>> > To decide the frequency of the device, the governor does one of the
>>> > following:
>>> >
>>> > * Uses a CPU frequency to device frequency mapping table
>>> >   - Either one mapping table used for all CPU freq policies (typically used
>>> >     for system with homogeneous cores/clusters that have the same OPPs).
>>> >   - One mapping table per CPU freq policy (typically used for ASMP systems
>>> >     with heterogeneous CPUs with different OPPs)
>>> >
>>> > OR
>>> >
>>> > * Scales the device frequency in proportion to the CPU frequency. So, if
>>> >   the CPUs are running at their max frequency, the device runs at its max
>>> >   frequency.  If the CPUs are running at their min frequency, the device
>>> >   runs at its min frequency. And interpolated for frequencies in between.
>>> >
>>> > Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>> > ---
>>> >  .../bindings/devfreq/devfreq-cpufreq-map.txt  |  53 ++
>>> >  drivers/devfreq/Kconfig                       |   8 +
>>> >  drivers/devfreq/Makefile                      |   1 +
>>> >  drivers/devfreq/governor_cpufreq_map.c        | 583 ++++++++++++++++++
>>> >  4 files changed, 645 insertions(+)
>>> >  create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>>> >  create mode 100644 drivers/devfreq/governor_cpufreq_map.c
>>> >
>>> > diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>>> > new file mode 100644
>>> > index 000000000000..982a30bcfc86
>>> > --- /dev/null
>>> > +++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>>> > @@ -0,0 +1,53 @@
>>> > +Devfreq CPUfreq governor
>>> > +
>>> > +devfreq-cpufreq-map is a parent device that contains one or more child devices.
>>> > +Each child device provides CPU frequency to device frequency mapping for a
>>> > +specific device. Examples of devices that could use this are: DDR, cache and
>>> > +CCI.
>>> > +
>>> > +Parent device name shall be "devfreq-cpufreq-map".
>>> > +
>>> > +Required child device properties:
>>> > +- cpu-to-dev-map, or cpu-to-dev-map-<X>:
>>> > +                     A list of tuples where each tuple consists of a
>>> > +                     CPU frequency (KHz) and the corresponding device
>>> > +                     frequency. CPU frequencies not listed in the table
>>> > +                     will use the device frequency that corresponds to the
>>> > +                     next rounded up CPU frequency.
>>> > +                     Use "cpu-to-dev-map" if all CPUs in the system should
>>> > +                     share same mapping.
>>> > +                     Use cpu-to-dev-map-<cpuid> to describe different
>>> > +                     mappings for different CPUs. The property should be
>>> > +                     listed only for the first CPU if multiple CPUs are
>>> > +                     synchronous.
>>> > +- target-dev:                Phandle to device that this mapping applies to.
>>> > +
>>> > +Example:
>>> > +     devfreq-cpufreq-map {
>>> > +             cpubw-cpufreq {
>>> > +                     target-dev = <&cpubw>;
>>> > +                     cpu-to-dev-map =
>>> > +                             <  300000  1144000 >,
>>> > +                             <  422400  2288000 >,
>>> > +                             <  652800  3051000 >,
>>> > +                             <  883200  5996000 >,
>>> > +                             < 1190400  8056000 >,
>>> > +                             < 1497600 10101000 >,
>>> > +                             < 1728000 12145000 >,
>>> > +                             < 2649600 16250000 >;
>>> > +             };
>>> > +
>>> > +             cache-cpufreq {
>>> > +                     target-dev = <&cache>;
>>> > +                     cpu-to-dev-map =
>>> > +                             <  300000  300000 >,
>>> > +                             <  422400  422400 >,
>>> > +                             <  652800  499200 >,
>>> > +                             <  883200  576000 >,
>>> > +                             <  960000  960000 >,
>>> > +                             < 1497600 1036800 >,
>>> > +                             < 1574400 1574400 >,
>>> > +                             < 1728000 1651200 >,
>>> > +                             < 2649600 1728000 >;
>>> > +             };
>>> > +     };
>>> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> > index 0c8204d6b78a..0303f5a400b6 100644
>>> > --- a/drivers/devfreq/Kconfig
>>> > +++ b/drivers/devfreq/Kconfig
>>> > @@ -74,6 +74,14 @@ config DEVFREQ_GOV_PASSIVE
>>> >         through sysfs entries. The passive governor recommends that
>>> >         devfreq device uses the OPP table to get the frequency/voltage.
>>> >
>>> > +config DEVFREQ_GOV_CPUFREQ_MAP
>>> > +     tristate "CPUfreq Map"
>>> > +     depends on CPU_FREQ
>>> > +     help
>>> > +       Chooses frequency based on the online CPUs' current frequency and a
>>> > +       CPU frequency to device frequency mapping table(s). This governor
>>> > +       can be useful for controlling devices such as DDR, cache, CCI, etc.
>>> > +
>>> >  comment "DEVFREQ Drivers"
>>> >
>>> >  config ARM_EXYNOS_BUS_DEVFREQ
>>> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>> > index 817dde779f16..81141e2c784f 100644
>>> > --- a/drivers/devfreq/Makefile
>>> > +++ b/drivers/devfreq/Makefile
>>> > @@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE) += governor_performance.o
>>> >  obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)  += governor_powersave.o
>>> >  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)  += governor_userspace.o
>>> >  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)    += governor_passive.o
>>> > +obj-$(CONFIG_DEVFREQ_GOV_CPUFREQ_MAP)        += governor_cpufreq_map.o
>>> >
>>> >  # DEVFREQ Drivers
>>> >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ) += exynos-bus.o
>>> > diff --git a/drivers/devfreq/governor_cpufreq_map.c b/drivers/devfreq/governor_cpufreq_map.c
>>> > new file mode 100644
>>> > index 000000000000..084a3ffb8f54
>>> > --- /dev/null
>>> > +++ b/drivers/devfreq/governor_cpufreq_map.c
>>> > @@ -0,0 +1,583 @@
>>> > +// SPDX-License-Identifier: GPL-2.0
>>> > +/*
>>> > + * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
>>> > + */
>>> > +
>>> > +#define pr_fmt(fmt) "dev-cpufreq-map: " fmt
>>> > +
>>> > +#include <linux/devfreq.h>
>>> > +#include <linux/cpu.h>
>>> > +#include <linux/cpufreq.h>
>>> > +#include <linux/cpumask.h>
>>> > +#include <linux/slab.h>
>>> > +#include <linux/platform_device.h>
>>> > +#include <linux/of.h>
>>> > +#include <linux/module.h>
>>> > +#include "governor.h"
>>> > +
>>> > +struct cpu_state {
>>> > +     unsigned int freq;
>>> > +     unsigned int min_freq;
>>> > +     unsigned int max_freq;
>>> > +     unsigned int first_cpu;
>>> > +};
>>> > +static struct cpu_state *state[NR_CPUS];
>>> > +static int cpufreq_cnt;
>>> > +
>>> > +struct freq_map {
>>> > +     unsigned int cpu_khz;
>>> > +     unsigned int target_freq;
>>> > +};
>>> > +
>>> > +struct devfreq_node {
>>> > +     struct devfreq *df;
>>> > +     void *orig_data;
>>> > +     struct device *dev;
>>> > +     struct device_node *of_node;
>>> > +     struct list_head list;
>>> > +     struct freq_map **map;
>>> > +     struct freq_map *common_map;
>>> > +};
>>> > +static LIST_HEAD(devfreq_list);
>>> > +static DEFINE_MUTEX(state_lock);
>>> > +static DEFINE_MUTEX(cpufreq_reg_lock);
>>> > +
>>> > +static void update_all_devfreqs(void)
>>> > +{
>>> > +     struct devfreq_node *node;
>>> > +
>>> > +     list_for_each_entry(node, &devfreq_list, list) {
>>> > +             struct devfreq *df = node->df;
>>> > +
>>> > +             if (!node->df)
>>> > +                     continue;
>>> > +             mutex_lock(&df->lock);
>>> > +             update_devfreq(df);
>>> > +             mutex_unlock(&df->lock);
>>> > +
>>> > +     }
>>> > +}
>>> > +
>>> > +static struct devfreq_node *find_devfreq_node(struct device *dev)
>>> > +{
>>> > +     struct devfreq_node *node;
>>> > +
>>> > +     list_for_each_entry(node, &devfreq_list, list)
>>> > +             if (node->dev == dev || node->of_node == dev->of_node)
>>> > +                     return node;
>>> > +
>>> > +     return NULL;
>>> > +}
>>> > +
>>> > +/* ==================== cpufreq part ==================== */
>>> > +static struct cpu_state *add_policy(struct cpufreq_policy *policy)
>>> > +{
>>> > +     struct cpu_state *new_state;
>>> > +     unsigned int cpu, first_cpu;
>>> > +
>>> > +     new_state = kzalloc(sizeof(struct cpu_state), GFP_KERNEL);
>>> > +     if (!new_state)
>>> > +             return NULL;
>>> > +
>>> > +     first_cpu = cpumask_first(policy->related_cpus);
>>> > +     new_state->first_cpu = first_cpu;
>>> > +     new_state->freq = policy->cur;
>>> > +     new_state->min_freq = policy->cpuinfo.min_freq;
>>> > +     new_state->max_freq = policy->cpuinfo.max_freq;
>>> > +
>>> > +     for_each_cpu(cpu, policy->related_cpus)
>>> > +             state[cpu] = new_state;
>>> > +
>>> > +     return new_state;
>>> > +}
>>> > +
>>> > +static int cpufreq_trans_notifier(struct notifier_block *nb,
>>> > +             unsigned long event, void *data)
>>> > +{
>>> > +     struct cpufreq_freqs *freq = data;
>>> > +     struct cpu_state *s;
>>> > +     struct cpufreq_policy *policy = NULL;
>>> > +
>>> > +     if (event != CPUFREQ_POSTCHANGE)
>>> > +             return 0;
>>> > +
>>> > +     mutex_lock(&state_lock);
>>> > +
>>> > +     s = state[freq->cpu];
>>> > +     if (!s) {
>>> > +             policy = cpufreq_cpu_get(freq->cpu);
>>> > +             if (policy) {
>>> > +                     s = add_policy(policy);
>>> > +                     cpufreq_cpu_put(policy);
>>> > +             }
>>> > +     }
>>> > +     if (!s)
>>> > +             goto out;
>>> > +
>>> > +     if (s->freq != freq->new || policy) {
>>> > +             s->freq = freq->new;
>>> > +             update_all_devfreqs();
>>> > +     }
>>> > +
>>> > +out:
>>> > +     mutex_unlock(&state_lock);
>>> > +     return 0;
>>> > +}
>>> > +
>>> > +static struct notifier_block cpufreq_trans_nb = {
>>> > +     .notifier_call = cpufreq_trans_notifier
>>> > +};
>>> > +
>>> > +static int register_cpufreq(void)
>>> > +{
>>> > +     int ret = 0;
>>> > +     unsigned int cpu;
>>> > +     struct cpufreq_policy *policy;
>>> > +
>>> > +     mutex_lock(&cpufreq_reg_lock);
>>> > +
>>> > +     if (cpufreq_cnt)
>>> > +             goto cnt_not_zero;
>>> > +
>>> > +     get_online_cpus();
>>> > +     ret = cpufreq_register_notifier(&cpufreq_trans_nb,
>>> > +                             CPUFREQ_TRANSITION_NOTIFIER);
>>> > +     if (ret)
>>> > +             goto out;
>>> > +
>>> > +     for_each_online_cpu(cpu) {
>>> > +             policy = cpufreq_cpu_get(cpu);
>>> > +             if (policy) {
>>> > +                     add_policy(policy);
>>> > +                     cpufreq_cpu_put(policy);
>>> > +             }
>>> > +     }
>>> > +out:
>>> > +     put_online_cpus();
>>> > +cnt_not_zero:
>>> > +     if (!ret)
>>> > +             cpufreq_cnt++;
>>> > +     mutex_unlock(&cpufreq_reg_lock);
>>> > +     return ret;
>>> > +}
>>> > +
>>> > +static int unregister_cpufreq(void)
>>> > +{
>>> > +     int ret = 0;
>>> > +     int cpu;
>>> > +
>>> > +     mutex_lock(&cpufreq_reg_lock);
>>> > +
>>> > +     if (cpufreq_cnt > 1)
>>> > +             goto out;
>>> > +
>>> > +     cpufreq_unregister_notifier(&cpufreq_trans_nb,
>>> > +                             CPUFREQ_TRANSITION_NOTIFIER);
>>> > +
>>> > +     for (cpu = ARRAY_SIZE(state) - 1; cpu >= 0; cpu--) {
>>> > +             if (!state[cpu])
>>> > +                     continue;
>>> > +             if (state[cpu]->first_cpu == cpu)
>>> > +                     kfree(state[cpu]);
>>> > +             state[cpu] = NULL;
>>> > +     }
>>> > +
>>> > +out:
>>> > +     cpufreq_cnt--;
>>> > +     mutex_unlock(&cpufreq_reg_lock);
>>> > +     return ret;
>>> > +}
>>> > +
>>> > +/* ==================== devfreq part ==================== */
>>> > +
>>> > +static unsigned int interpolate_freq(struct devfreq *df, unsigned int cpu)
>>> > +{
>>> > +     unsigned long *freq_table = df->profile->freq_table;
>>> > +     unsigned int cpu_min = state[cpu]->min_freq;
>>> > +     unsigned int cpu_max = state[cpu]->max_freq;
>>> > +     unsigned int cpu_freq = state[cpu]->freq;
>>> > +     unsigned int dev_min, dev_max, cpu_percent;
>>> > +
>>> > +     if (freq_table) {
>>> > +             dev_min = freq_table[0];
>>> > +             dev_max = freq_table[df->profile->max_state - 1];
>>> > +     } else {
>>> > +             if (df->max_freq <= df->min_freq)
>>> > +                     return 0;
>>> > +             dev_min = df->min_freq;
>>> > +             dev_max = df->max_freq;
>>> > +     }
>>> > +
>>> > +     cpu_percent = ((cpu_freq - cpu_min) * 100) / (cpu_max - cpu_min);
>>> > +     return dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
>>> > +}
>>> > +
>>> > +static unsigned int cpu_to_dev_freq(struct devfreq *df, unsigned int cpu)
>>> > +{
>>> > +     struct freq_map *map = NULL;
>>> > +     unsigned int cpu_khz = 0, freq;
>>> > +     struct devfreq_node *n = df->data;
>>> > +
>>> > +     if (!state[cpu] || state[cpu]->first_cpu != cpu) {
>>> > +             freq = 0;
>>> > +             goto out;
>>> > +     }
>>> > +
>>> > +     if (n->common_map)
>>> > +             map = n->common_map;
>>> > +     else if (n->map)
>>> > +             map = n->map[cpu];
>>> > +
>>> > +     cpu_khz = state[cpu]->freq;
>>> > +
>>> > +     if (!map) {
>>> > +             freq = interpolate_freq(df, cpu);
>>> > +             goto out;
>>> > +     }
>>> > +
>>> > +     while (map->cpu_khz && map->cpu_khz < cpu_khz)
>>> > +             map++;
>>> > +     if (!map->cpu_khz)
>>> > +             map--;
>>> > +     freq = map->target_freq;
>>> > +
>>> > +out:
>>> > +     dev_dbg(df->dev.parent, "CPU%u: %d -> dev: %u\n", cpu, cpu_khz, freq);
>>> > +     return freq;
>>> > +}
>>> > +
>>> > +static int devfreq_cpufreq_get_freq(struct devfreq *df,
>>> > +                                     unsigned long *freq)
>>> > +{
>>> > +     unsigned int cpu, tgt_freq = 0;
>>> > +     struct devfreq_node *node;
>>> > +
>>> > +     node = df->data;
>>> > +     if (!node) {
>>> > +             pr_err("Unable to find devfreq node!\n");
>>> > +             return -ENODEV;
>>> > +     }
>>> > +
>>> > +     for_each_possible_cpu(cpu)
>>> > +             tgt_freq = max(tgt_freq, cpu_to_dev_freq(df, cpu));
>>> > +
>>> > +     *freq = tgt_freq;
>>> > +     return 0;
>>> > +}
>>> > +
>>> > +static unsigned int show_table(char *buf, unsigned int len,
>>> > +                             struct freq_map *map)
>>> > +{
>>> > +     unsigned int cnt = 0;
>>> > +
>>> > +     cnt += snprintf(buf + cnt, len - cnt, "CPU freq\tDevice freq\n");
>>> > +
>>> > +     while (map->cpu_khz && cnt < len) {
>>> > +             cnt += snprintf(buf + cnt, len - cnt, "%8u\t%11u\n",
>>> > +                             map->cpu_khz, map->target_freq);
>>> > +             map++;
>>> > +     }
>>> > +     if (cnt < len)
>>> > +             cnt += snprintf(buf + cnt, len - cnt, "\n");
>>> > +
>>> > +     return cnt;
>>> > +}
>>> > +
>>> > +static ssize_t freq_map_show(struct device *dev, struct device_attribute *attr,
>>> > +                     char *buf)
>>> > +{
>>> > +     struct devfreq *df = to_devfreq(dev);
>>> > +     struct devfreq_node *n = df->data;
>>> > +     struct freq_map *map;
>>> > +     unsigned int cnt = 0, cpu;
>>> > +
>>> > +     mutex_lock(&state_lock);
>>> > +     if (n->common_map) {
>>> > +             map = n->common_map;
>>> > +             cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
>>> > +                             "Common table for all CPUs:\n");
>>> > +             cnt += show_table(buf + cnt, PAGE_SIZE - cnt, map);
>>> > +     } else if (n->map) {
>>> > +             for_each_possible_cpu(cpu) {
>>> > +                     map = n->map[cpu];
>>> > +                     if (!map)
>>> > +                             continue;
>>> > +                     cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
>>> > +                                     "CPU %u:\n", cpu);
>>> > +                     if (cnt >= PAGE_SIZE)
>>> > +                             break;
>>> > +                     cnt += show_table(buf + cnt, PAGE_SIZE - cnt, map);
>>> > +                     if (cnt >= PAGE_SIZE)
>>> > +                             break;
>>> > +             }
>>> > +     } else {
>>> > +             cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
>>> > +                             "Device freq interpolated based on CPU freq\n");
>>> > +     }
>>> > +     mutex_unlock(&state_lock);
>>> > +
>>> > +     return cnt;
>>> > +}
>>> > +
>>> > +static DEVICE_ATTR_RO(freq_map);
>>> > +static struct attribute *dev_attr[] = {
>>> > +     &dev_attr_freq_map.attr,
>>> > +     NULL,
>>> > +};
>>> > +
>>> > +static struct attribute_group dev_attr_group = {
>>> > +     .name = "cpufreq-map",
>>> > +     .attrs = dev_attr,
>>> > +};
>>> > +
>>> > +static int devfreq_cpufreq_gov_start(struct devfreq *devfreq)
>>> > +{
>>> > +     int ret = 0;
>>> > +     struct devfreq_node *node;
>>> > +     bool alloc = false;
>>> > +
>>> > +     ret = register_cpufreq();
>>> > +     if (ret)
>>> > +             return ret;
>>> > +
>>> > +     ret = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
>>> > +     if (ret) {
>>> > +             unregister_cpufreq();
>>> > +             return ret;
>>> > +     }
>>> > +
>>> > +     mutex_lock(&state_lock);
>>> > +
>>> > +     node = find_devfreq_node(devfreq->dev.parent);
>>> > +     if (node == NULL) {
>>> > +             node = kzalloc(sizeof(struct devfreq_node), GFP_KERNEL);
>>> > +             if (!node) {
>>> > +                     ret = -ENOMEM;
>>> > +                     goto alloc_fail;
>>> > +             }
>>> > +             alloc = true;
>>> > +             node->dev = devfreq->dev.parent;
>>> > +             list_add_tail(&node->list, &devfreq_list);
>>> > +     }
>>> > +     node->df = devfreq;
>>> > +     node->orig_data = devfreq->data;
>>> > +     devfreq->data = node;
>>> > +
>>> > +     mutex_lock(&devfreq->lock);
>>> > +     ret = update_devfreq(devfreq);
>>> > +     mutex_unlock(&devfreq->lock);
>>> > +     if (ret) {
>>> > +             pr_err("Freq update failed!\n");
>>> > +             goto update_fail;
>>> > +     }
>>> > +
>>> > +     mutex_unlock(&state_lock);
>>> > +     return 0;
>>> > +
>>> > +update_fail:
>>> > +     devfreq->data = node->orig_data;
>>> > +     if (alloc) {
>>> > +             list_del(&node->list);
>>> > +             kfree(node);
>>> > +     }
>>> > +alloc_fail:
>>> > +     mutex_unlock(&state_lock);
>>> > +     sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>>> > +     unregister_cpufreq();
>>> > +     return ret;
>>> > +}
>>> > +
>>> > +static void devfreq_cpufreq_gov_stop(struct devfreq *devfreq)
>>> > +{
>>> > +     struct devfreq_node *node = devfreq->data;
>>> > +
>>> > +     mutex_lock(&state_lock);
>>> > +     devfreq->data = node->orig_data;
>>> > +     if (node->map || node->common_map) {
>>> > +             node->df = NULL;
>>> > +     } else {
>>> > +             list_del(&node->list);
>>> > +             kfree(node);
>>> > +     }
>>> > +     mutex_unlock(&state_lock);
>>> > +
>>> > +     sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>>> > +     unregister_cpufreq();
>>> > +}
>>> > +
>>> > +static int devfreq_cpufreq_ev_handler(struct devfreq *devfreq,
>>> > +                                     unsigned int event, void *data)
>>> > +{
>>> > +     int ret;
>>> > +
>>> > +     switch (event) {
>>> > +     case DEVFREQ_GOV_START:
>>> > +
>>> > +             ret = devfreq_cpufreq_gov_start(devfreq);
>>> > +             if (ret) {
>>> > +                     pr_err("Governor start failed!\n");
>>> > +                     return ret;
>>> > +             }
>>> > +             pr_debug("Enabled CPUfreq-map governor\n");
>>> > +             break;
>>> > +
>>> > +     case DEVFREQ_GOV_STOP:
>>> > +
>>> > +             devfreq_cpufreq_gov_stop(devfreq);
>>> > +             pr_debug("Disabled dev CPUfreq-map governor\n");
>>> > +             break;
>>> > +     }
>>> > +
>>> > +     return 0;
>>> > +}
>>> > +
>>> > +static struct devfreq_governor devfreq_cpufreq = {
>>> > +     .name = "cpufreq-map",
>>> > +     .get_target_freq = devfreq_cpufreq_get_freq,
>>> > +     .event_handler = devfreq_cpufreq_ev_handler,
>>> > +};
>>> > +
>>> > +#define NUM_COLS     2
>>> > +static struct freq_map *read_tbl(struct device_node *of_node, char *prop_name)
>>> > +{
>>> > +     int len, nf, i, j;
>>> > +     u32 data;
>>> > +     struct freq_map *tbl;
>>> > +
>>> > +     if (!of_find_property(of_node, prop_name, &len))
>>> > +             return NULL;
>>> > +     len /= sizeof(data);
>>> > +
>>> > +     if (len % NUM_COLS || len == 0)
>>> > +             return NULL;
>>> > +     nf = len / NUM_COLS;
>>> > +
>>> > +     tbl = kzalloc((nf + 1) * sizeof(*tbl), GFP_KERNEL);
>>> > +     if (!tbl)
>>> > +             return NULL;
>>> > +
>>> > +     for (i = 0, j = 0; i < nf; i++, j += 2) {
>>> > +             of_property_read_u32_index(of_node, prop_name, j, &data);
>>> > +             tbl[i].cpu_khz = data;
>>> > +
>>> > +             of_property_read_u32_index(of_node, prop_name, j + 1, &data);
>>> > +             tbl[i].target_freq = data;
>>> > +     }
>>> > +     tbl[i].cpu_khz = 0;
>>> > +
>>> > +     return tbl;
>>> > +}
>>> > +
>>> > +#define PROP_TARGET "target-dev"
>>> > +#define PROP_TABLE "cpu-to-dev-map"
>>> > +static int add_table_from_of(struct device_node *of_node)
>>> > +{
>>> > +     struct device_node *target_of_node;
>>> > +     struct devfreq_node *node;
>>> > +     struct freq_map *common_tbl;
>>> > +     struct freq_map **tbl_list = NULL;
>>> > +     static char prop_name[] = PROP_TABLE "-999999";
>>> > +     int cpu, ret, cnt = 0, prop_sz = ARRAY_SIZE(prop_name);
>>> > +
>>> > +     target_of_node = of_parse_phandle(of_node, PROP_TARGET, 0);
>>> > +     if (!target_of_node)
>>> > +             return -EINVAL;
>>> > +
>>> > +     node = kzalloc(sizeof(struct devfreq_node), GFP_KERNEL);
>>> > +     if (!node)
>>> > +             return -ENOMEM;
>>> > +
>>> > +     common_tbl = read_tbl(of_node, PROP_TABLE);
>>> > +     if (!common_tbl) {
>>> > +             tbl_list = kzalloc(sizeof(*tbl_list) * NR_CPUS, GFP_KERNEL);
>>> > +             if (!tbl_list) {
>>> > +                     ret = -ENOMEM;
>>> > +                     goto err_list;
>>> > +             }
>>> > +
>>> > +             for_each_possible_cpu(cpu) {
>>> > +                     ret = snprintf(prop_name, prop_sz, "%s-%d",
>>> > +                                     PROP_TABLE, cpu);
>>> > +                     if (ret >= prop_sz) {
>>> > +                             pr_warn("More CPUs than I can handle!\n");
>>> > +                             pr_warn("Skipping rest of the tables!\n");
>>> > +                             break;
>>> > +                     }
>>> > +                     tbl_list[cpu] = read_tbl(of_node, prop_name);
>>> > +                     if (tbl_list[cpu])
>>> > +                             cnt++;
>>> > +             }
>>> > +     }
>>> > +     if (!common_tbl && !cnt) {
>>> > +             ret = -EINVAL;
>>> > +             goto err_tbl;
>>> > +     }
>>> > +
>>> > +     mutex_lock(&state_lock);
>>> > +     node->of_node = target_of_node;
>>> > +     node->map = tbl_list;
>>> > +     node->common_map = common_tbl;
>>> > +     list_add_tail(&node->list, &devfreq_list);
>>> > +     mutex_unlock(&state_lock);
>>> > +
>>> > +     return 0;
>>> > +err_tbl:
>>> > +     kfree(tbl_list);
>>> > +err_list:
>>> > +     kfree(node);
>>> > +     return ret;
>>> > +}
>>> > +
>>> > +static int __init devfreq_cpufreq_init(void)
>>> > +{
>>> > +     int ret;
>>> > +     struct device_node *of_par, *of_child;
>>> > +
>>> > +     of_par = of_find_node_by_name(NULL, "devfreq-cpufreq-map");
>>> > +     if (of_par) {
>>> > +             for_each_child_of_node(of_par, of_child) {
>>> > +                     ret = add_table_from_of(of_child);
>>> > +                     if (ret)
>>> > +                             pr_err("Parsing %s failed!\n", of_child->name);
>>> > +                     else
>>> > +                             pr_debug("Parsed %s.\n", of_child->name);
>>> > +             }
>>> > +             of_node_put(of_par);
>>> > +     } else {
>>> > +             pr_info("No tables parsed from DT.\n");
>>> > +     }
>>> > +
>>> > +     ret = devfreq_add_governor(&devfreq_cpufreq);
>>> > +     if (ret) {
>>> > +             pr_err("cpufreq-map governor add failed!\n");
>>> > +             return ret;
>>> > +     }
>>> > +
>>> > +     return 0;
>>> > +}
>>> > +subsys_initcall(devfreq_cpufreq_init);
>>> > +
>>> > +static void __exit devfreq_cpufreq_exit(void)
>>> > +{
>>> > +     int ret, cpu;
>>> > +     struct devfreq_node *node, *tmp;
>>> > +
>>> > +     ret = devfreq_remove_governor(&devfreq_cpufreq);
>>> > +     if (ret)
>>> > +             pr_err("cpufreq-map governor remove failed!\n");
>>> > +
>>> > +     mutex_lock(&state_lock);
>>> > +     list_for_each_entry_safe(node, tmp, &devfreq_list, list) {
>>> > +             kfree(node->common_map);
>>> > +             for_each_possible_cpu(cpu)
>>> > +                     kfree(node->map[cpu]);
>>> > +             kfree(node->map);
>>> > +             list_del(&node->list);
>>> > +             kfree(node);
>>> > +     }
>>> > +     mutex_unlock(&state_lock);
>>> > +}
>>> > +module_exit(devfreq_cpufreq_exit);
>>> > +
>>> > +MODULE_DESCRIPTION("devfreq gov that sets dev freq based on current CPU freq");
>>> > +MODULE_LICENSE("GPL v2");
>>> >
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
