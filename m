Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA086CC1C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfGRJoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:44:06 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47647 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRJoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:44:06 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190718094403epoutp035d02c50be7d18962cee3e790cdddb0cc~ydyo3KEvU1135211352epoutp03I
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:44:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190718094403epoutp035d02c50be7d18962cee3e790cdddb0cc~ydyo3KEvU1135211352epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563443043;
        bh=YSL5yKEP9EwGOhrB6Xc1FHRbPp1eEqaxJe0hPuyLF7M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZqfauW9oA7hEGJ+HQjQV8QQwEZBEsRVwSJ+7FTULKM9auRrzHVpMyOoPofoS8H1FT
         mrFCfDMfQdzxUJWYE+ysyagQCM2YyMzlVh8f6E3AjIVQciTiSbEjtZj6gKoxRX+HiK
         EtdNA31hlVcNLh6dpBP5j0qkmwL9ZMtlwbndycPw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190718094403epcas1p40679e867128a1a9f03940d8a56bfb113~ydyoXFD2E1964619646epcas1p41;
        Thu, 18 Jul 2019 09:44:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45q8NK0jzCzMqYkd; Thu, 18 Jul
        2019 09:44:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.48.04085.06F303D5; Thu, 18 Jul 2019 18:44:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190718094400epcas1p4ee3099a605cd7345181215bc02a6ac0c~ydyly1P0L1440814408epcas1p4h;
        Thu, 18 Jul 2019 09:44:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718094400epsmtrp2bf7a1eca8b66b2e426c9492fb82ef4c7~ydylyG3To0651806518epsmtrp2U;
        Thu, 18 Jul 2019 09:44:00 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-f0-5d303f602a65
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.1C.03638.06F303D5; Thu, 18 Jul 2019 18:44:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718094400epsmtip1851c65f0b6bf173971eea9deab645e1a~ydylmuTgI1996219962epsmtip1O;
        Thu, 18 Jul 2019 09:44:00 +0000 (GMT)
Subject: Re: [PATCH v4 17/24] PM / devfreq: tegra30: Use tracepoints for
 debugging
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <209220ec-b677-3500-0e55-6cad57e97f88@samsung.com>
Date:   Thu, 18 Jul 2019 18:47:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-18-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzmbHd3V2t1XFm/DGreiFAwd9XZtVJ7WA0sEDN6IXabN2fu1e4m
        PaGyh0qLIpJcPnpYliFRWKhRCx+9rJRWES0jsGBpKWn2Mqrd3SL/+34f33d+33fOoeTqejKC
        yrc4eLuFM9FkKHG9NUobw6Vqs7XvaPbSpx7E7nOfIdhHez8oWW9zBckOudoQW/LZTbK+PRdI
        9ntzFcEern9CLgjRN3bXIH2Tu1updxX1k/rDDXVIP3R1WoZiXcF8I8/l8nYNbzFYc/Mtecl0
        +sqcxTm6RC0TwySxc2iNhTPzyXTa8oyYpfmmQB5aU8iZnAEqgxMEOjZlvt3qdPAao1VwJNO8
        LddkS7LNFjiz4LTkzTZYzXMZrTZOFxBuKDB2/qwkbMeXbD2/Z5DcjZ6zpSiEApwAV8r7FKUo
        lFLjRgSny14R0jAYGH54SWn4gqD64Xnin6WvrBOJWI1vInjiS5dEAwge9g0qSxFFTcBZcKNs
        mchPxL8QlHwvIkWDHK+F1qZLMhGTOBo8/hdBfjyOhGffepDoVeEU8NdPEWkCz4SPd9qCu8Lx
        GnjQVhXMoMJhcL/8bRCH4ES45Xopl46fDC/fVsskPB2Krp2UixkA/yah1/dbIRVIg6eek3/x
        BOi926CUcAQM9d8kJbwDLt5vIyVzMYIGT9dfQzx4zh2TiUHlOAouN8dKdCQ0jVQiafE46B8+
        pBAlgFVQfEAtSWaA9023TMJT4OzBEvIIot2j6rhHVXCPquD+v+wUIurQJN4mmPN4gbHpRj/2
        VRT8qtFJjejO4+UtCFOIHqt6QcdmqxVcobDN3IKAktMTVb73AUqVy23bztutOXaniRdakC5w
        20flEeEGa+DjWxw5jC4uPj6eTWASdQxDT1ZV/YzKVuM8zsEX8LyNt//zyaiQiN3IWTvi88aM
        kaWc6d3ylekZ8DRFpu2r8N/WPLoX6Xq9cFwYGrv2QlpXe+aK9TWV9bMKjfOKaytW+UOTUsM7
        Li/qbtfop2b2DO8f7hg64eVSOzaxezOMI61zE/wdYbsMm1cf2JjvPWibNKBcVl7NtLs6a3f+
        MuwsTd6+tdqU9f4Dl76FJgQjx0TL7QL3B5zIqnrAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG6CvUGswZ6HMharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ5//MZSmY6lqxrPETWwPjNYsuRk4OCQETidfT
        zjN2MXJxCAnsZpT4uOQQM0RCUmLaxaNANgeQLSxx+HAxRM1bRon7H7awgMSFBUIkdk9zB4mL
        CDQxSWzqvcAO0sssECnRM3cLG0TDFkaJU49bGEESbAJaEvtf3GADsfkFFCWu/njMCDKIV8BO
        4sVaSZAwi4CqxNtjR8DKRQUiJCZd28kCYvMKCEqcnPkEzOYUMJPY13uLGWKXusSfeZegbHGJ
        W0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
        L10vOT93EyM4wrS0djCeOBF/iFGAg1GJh/eGkn6sEGtiWXFl7iFGCQ5mJRHe2y+BQrwpiZVV
        qUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhgnfRKL3tn90eTyqZD8
        3YdZnv93sVT8+2Imj+a3V5c+z2k5Krtb75CsetpHSZeWrz1TJtTMfn46aIfIqu0GVxRPJDl3
        Ws/5Y+n2bOrt6OKlib+7F7858mS5bORsjgnqHybImkte4TbYVLV4zWaJe3mn4h95TzpXrS65
        XD3v9/fDNT2Ogioq2mHzlFiKMxINtZiLihMBHsOxxqwCAAA=
X-CMS-MailID: 20190718094400epcas1p4ee3099a605cd7345181215bc02a6ac0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223623epcas4p13d01a60ae2b88dde4c4f7fdba04da170
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223623epcas4p13d01a60ae2b88dde4c4f7fdba04da170@epcas4p1.samsung.com>
        <20190707223303.6755-18-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> Debug messages create too much CPU and memory activity by themselves,
> so it's difficult to debug lower rates and catch unwanted interrupts
> that happen rarely. Tracepoints are ideal in that regards because they
> do not contribute to the sampled date at all. This allowed me to catch
> few problems which are fixed by the followup patches, without tracepoints
> it would be much harder to do.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c      |  43 +++-------
>  include/trace/events/tegra30_devfreq.h | 105 +++++++++++++++++++++++++
>  2 files changed, 117 insertions(+), 31 deletions(-)
>  create mode 100644 include/trace/events/tegra30_devfreq.h

As I knew, 'include/trace/events' don't include the header file
for only one device driver. Usually, the trace event is provided
by framework instead of each devic driver.

> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 6ebf0f505767..43c9c5fbfe91 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -19,6 +19,9 @@
>  #include <linux/reset.h>
>  #include <linux/workqueue.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/tegra30_devfreq.h>
> +
>  #include "governor.h"
>  
>  #define ACTMON_GLB_STATUS					0x0
> @@ -283,9 +286,6 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  					 unsigned long *lower,
>  					 unsigned long *upper)
>  {
> -	struct device *ddev = tegra->devfreq->dev.parent;
> -	u32 offset = dev->config->offset;
> -
>  	/*
>  	 * Memory frequencies are guaranteed to have 1MHz granularity
>  	 * and thus we need this rounding down to get a proper watermarks
> @@ -298,8 +298,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  	*lower = tegra_actmon_lower_freq(tegra, target_freq);
>  	*upper = tegra_actmon_upper_freq(tegra, target_freq);
>  
> -	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper freq %lu\n",
> -		offset, target_freq, *lower, *upper);
> +	trace_device_lower_upper(dev->config->offset, target_freq,
> +				 *lower, *upper);
>  
>  	/*
>  	 * The upper watermark should take into account CPU's frequency
> @@ -377,30 +377,13 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
>  }
>  
> -static void actmon_device_debug(struct tegra_devfreq *tegra,
> -				struct tegra_devfreq_device *dev,
> -				const char *prefix)
> -{
> -	dev_dbg(tegra->devfreq->dev.parent,
> -		"%03x: %s: 0x%08x 0x%08x a %u %u %u c %u %u %u b %lu cpu %u\n",
> -		dev->config->offset, prefix,
> -		device_readl(dev, ACTMON_DEV_INTR_STATUS),
> -		device_readl(dev, ACTMON_DEV_CTRL),
> -		device_readl(dev, ACTMON_DEV_AVG_COUNT),
> -		device_readl(dev, ACTMON_DEV_AVG_LOWER_WMARK),
> -		device_readl(dev, ACTMON_DEV_AVG_UPPER_WMARK),
> -		device_readl(dev, ACTMON_DEV_COUNT),
> -		device_readl(dev, ACTMON_DEV_LOWER_WMARK),
> -		device_readl(dev, ACTMON_DEV_UPPER_WMARK),
> -		dev->boost_freq, cpufreq_get(0));
> -}
> -
>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev)
>  {
>  	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
>  
> -	actmon_device_debug(tegra, dev, "isr+");
> +	trace_device_isr_enter(tegra->regs, dev->config->offset,
> +			       dev->boost_freq, cpufreq_get(0));
>  
>  	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
>  	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
> @@ -455,7 +438,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>  
> -	actmon_device_debug(tegra, dev, "isr-");
> +	trace_device_isr_exit(tegra->regs, dev->config->offset,
> +			      dev->boost_freq, cpufreq_get(0));
>  }
>  
>  static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
> @@ -749,7 +733,6 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
>  static int tegra_governor_get_target(struct devfreq *devfreq,
>  				     unsigned long *freq)
>  {
> -	struct device *ddev = devfreq->dev.parent;
>  	struct devfreq_dev_status *stat;
>  	struct tegra_devfreq *tegra;
>  	struct tegra_devfreq_device *dev;
> @@ -770,13 +753,11 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>  		dev = &tegra->devices[i];
>  
>  		dev_target_freq = actmon_update_target(tegra, dev);
> -
>  		target_freq = max(target_freq, dev_target_freq);
>  
> -		dev_dbg(ddev, "%03x: upd: dev_target_freq %lu\n",
> -			dev->config->offset, dev_target_freq);
> -
> -		actmon_device_debug(tegra, dev, "upd");
> +		trace_device_target_freq(dev->config->offset, dev_target_freq);
> +		trace_device_target_update(tegra->regs, dev->config->offset,
> +					   dev->boost_freq, cpufreq_get(0));
>  	}
>  
>  	*freq = target_freq;
> diff --git a/include/trace/events/tegra30_devfreq.h b/include/trace/events/tegra30_devfreq.h
> new file mode 100644
> index 000000000000..8f264a489daf
> --- /dev/null
> +++ b/include/trace/events/tegra30_devfreq.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM tegra30_devfreq
> +
> +#if !defined(_TRACE_TEGRA30_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_TEGRA30_DEVFREQ_H
> +
> +#include <linux/io.h>
> +#include <linux/tracepoint.h>
> +#include <linux/types.h>
> +
> +DECLARE_EVENT_CLASS(device_state,
> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
> +	TP_ARGS(base, offset, boost, cpufreq),
> +	TP_STRUCT__entry(
> +		__field(u32, offset)
> +		__field(u32, intr_status)
> +		__field(u32, ctrl)
> +		__field(u32, avg_count)
> +		__field(u32, avg_lower)
> +		__field(u32, avg_upper)
> +		__field(u32, count)
> +		__field(u32, lower)
> +		__field(u32, upper)
> +		__field(u32, boost_freq)
> +		__field(u32, cpu_freq)
> +	),
> +	TP_fast_assign(
> +		__entry->offset		= offset;
> +		__entry->intr_status	= readl_relaxed(base + offset + 0x24);
> +		__entry->ctrl		= readl_relaxed(base + offset + 0x0);
> +		__entry->avg_count	= readl_relaxed(base + offset + 0x20);
> +		__entry->avg_lower	= readl_relaxed(base + offset + 0x14);
> +		__entry->avg_upper	= readl_relaxed(base + offset + 0x10);
> +		__entry->count		= readl_relaxed(base + offset + 0x1c);
> +		__entry->lower		= readl_relaxed(base + offset + 0x8);
> +		__entry->upper		= readl_relaxed(base + offset + 0x4);
> +		__entry->boost_freq	= boost;
> +		__entry->cpu_freq	= cpufreq;
> +	),
> +	TP_printk("%03x: intr 0x%08x ctrl 0x%08x avg %010u %010u %010u cnt %010u %010u %010u boost %010u cpu %u",
> +		__entry->offset,
> +		__entry->intr_status,
> +		__entry->ctrl,
> +		__entry->avg_count,
> +		__entry->avg_lower,
> +		__entry->avg_upper,
> +		__entry->count,
> +		__entry->lower,
> +		__entry->upper,
> +		__entry->boost_freq,
> +		__entry->cpu_freq)
> +);
> +
> +DEFINE_EVENT(device_state, device_isr_enter,
> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
> +	TP_ARGS(base, offset, boost, cpufreq));
> +
> +DEFINE_EVENT(device_state, device_isr_exit,
> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
> +	TP_ARGS(base, offset, boost, cpufreq));
> +
> +DEFINE_EVENT(device_state, device_target_update,
> +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
> +	TP_ARGS(base, offset, boost, cpufreq));
> +
> +TRACE_EVENT(device_lower_upper,
> +	TP_PROTO(u32 offset, u32 target, u32 lower, u32 upper),
> +	TP_ARGS(offset, target, lower, upper),
> +	TP_STRUCT__entry(
> +		__field(u32, offset)
> +		__field(u32, target)
> +		__field(u32, lower)
> +		__field(u32, upper)
> +	),
> +	TP_fast_assign(
> +		__entry->offset = offset;
> +		__entry->target = target;
> +		__entry->lower = lower;
> +		__entry->upper = upper;
> +	),
> +	TP_printk("%03x: freq %010u lower freq %010u upper freq %010u",
> +		__entry->offset,
> +		__entry->target,
> +		__entry->lower,
> +		__entry->upper)
> +);
> +
> +TRACE_EVENT(device_target_freq,
> +	TP_PROTO(u32 offset, u32 target),
> +	TP_ARGS(offset, target),
> +	TP_STRUCT__entry(
> +		__field(u32, offset)
> +		__field(u32, target)
> +	),
> +	TP_fast_assign(
> +		__entry->offset = offset;
> +		__entry->target = target;
> +	),
> +	TP_printk("%03x: freq %010u", __entry->offset, __entry->target)
> +);
> +#endif /* _TRACE_TEGRA30_DEVFREQ_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
