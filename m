Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FB6D7EC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 02:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfGSAqF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 20:46:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45003 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSAqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 20:46:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so29091884ljc.11;
        Thu, 18 Jul 2019 17:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9/8BM1EbkCfcTYslMjaB4iQnJ1hDAgXxAZzUNNM5qs=;
        b=PcfDCaoWtXvw5gwM9zyn5x86JQ2TU5UI70jF91F2fAcABkSF2ru2+qfnyYqlJn2KC4
         Ew4o+HTdZ5AqRVQeNdzhtbRXnkp798Ngx53paHazWICs63+ZhxFoJKQUw+RzrWyqdkJG
         EvsHM9zCxy37xoiMnO0R2dkJHoSkQhBNJCi20FRGlPjpfan+PZYQjel78hNeqZUNNWmG
         HXOKBqkTHHtcmMoOO+WfhjN+c+dV0jw93dyFq615oVPXIZXnhhQP58FL5urqy07ZByaI
         KW9OduvW1jvsyplcUla9jCIOgSIsvjVd5mMKYfPRBrksX1zt+pzbFYNHPE2alkVKH5IW
         itgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9/8BM1EbkCfcTYslMjaB4iQnJ1hDAgXxAZzUNNM5qs=;
        b=ZlfzRKG0nF46R/CWpR/6RNp6vil4dn1t9HXHlt+KT13memGs+WBwpKhw4wyS53vchc
         ZeRq0rWiF9FJzlfxbgLJQKRhI7J2jI5QXy3i2s83CKSOenFbLgXO+MDCGqkliv7a4Q1j
         JywPQ05xCRmIy0W43Nys084a3JOpKRViL0bnxN4D4HOc4uwLsuBwrgvbwd+tdS6d7JQI
         KK85z9QbC6duuzf1rRT+q8zJwT4/SZBkm/5c31rM7SNjD7eLk1blWeoRqxSKo+asTJuV
         W9PD/p2sN9+LPvSUCge2s0IvQch02i1wER6aEXeCy/57gv6UE4FTlJsXjlEMcTQJj+Nb
         HY3A==
X-Gm-Message-State: APjAAAV8wkaGew+/AoiKlb+WrqN9IasXZvAuWO+fZNrizl4MkC9cGx4K
        Ef1iUs2QGTfj38GSRWybFvE=
X-Google-Smtp-Source: APXvYqzHJ3Em9lx4Q5WCpgGSs+oPJPEgl5W1G/v8D00gNOvx8otvGkadVqPK8AWxNKB6K6DqNvKPZQ==
X-Received: by 2002:a2e:870f:: with SMTP id m15mr25941408lji.223.1563497161661;
        Thu, 18 Jul 2019 17:46:01 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p12sm5337698lja.23.2019.07.18.17.46.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:46:01 -0700 (PDT)
Date:   Fri, 19 Jul 2019 03:49:38 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/24] PM / devfreq: tegra30: Use tracepoints for
 debugging
Message-ID: <20190719034938.6382f989@dimatab>
In-Reply-To: <209220ec-b677-3500-0e55-6cad57e97f88@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223623epcas4p13d01a60ae2b88dde4c4f7fdba04da170@epcas4p1.samsung.com>
        <20190707223303.6755-18-digetx@gmail.com>
        <209220ec-b677-3500-0e55-6cad57e97f88@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Thu, 18 Jul 2019 18:47:09 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:32, Dmitry Osipenko wrote:
> > Debug messages create too much CPU and memory activity by
> > themselves, so it's difficult to debug lower rates and catch
> > unwanted interrupts that happen rarely. Tracepoints are ideal in
> > that regards because they do not contribute to the sampled date at
> > all. This allowed me to catch few problems which are fixed by the
> > followup patches, without tracepoints it would be much harder to do.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c      |  43 +++-------
> >  include/trace/events/tegra30_devfreq.h | 105
> > +++++++++++++++++++++++++ 2 files changed, 117 insertions(+), 31
> > deletions(-) create mode 100644
> > include/trace/events/tegra30_devfreq.h =20
>=20
> As I knew, 'include/trace/events' don't include the header file
> for only one device driver. Usually, the trace event is provided
> by framework instead of each devic driver.

There are at least trace headers there for the tegra-apbdma,
tegra-host1x, intel-sst and intel-ish devices. I don't think that there
is a strict rule for the trace headers placement.

> >=20
> > diff --git a/drivers/devfreq/tegra30-devfreq.c
> > b/drivers/devfreq/tegra30-devfreq.c index
> > 6ebf0f505767..43c9c5fbfe91 100644 ---
> > a/drivers/devfreq/tegra30-devfreq.c +++
> > b/drivers/devfreq/tegra30-devfreq.c @@ -19,6 +19,9 @@
> >  #include <linux/reset.h>
> >  #include <linux/workqueue.h>
> > =20
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/tegra30_devfreq.h>
> > +
> >  #include "governor.h"
> > =20
> >  #define ACTMON_GLB_STATUS
> > 0x0 @@ -283,9 +286,6 @@ static void
> > tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, unsigned
> > long *lower, unsigned long *upper)
> >  {
> > -	struct device *ddev =3D tegra->devfreq->dev.parent;
> > -	u32 offset =3D dev->config->offset;
> > -
> >  	/*
> >  	 * Memory frequencies are guaranteed to have 1MHz
> > granularity
> >  	 * and thus we need this rounding down to get a proper
> > watermarks @@ -298,8 +298,8 @@ static void
> > tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra, *lower =3D
> > tegra_actmon_lower_freq(tegra, target_freq); *upper =3D
> > tegra_actmon_upper_freq(tegra, target_freq);=20
> > -	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper
> > freq %lu\n",
> > -		offset, target_freq, *lower, *upper);
> > +	trace_device_lower_upper(dev->config->offset, target_freq,
> > +				 *lower, *upper);
> > =20
> >  	/*
> >  	 * The upper watermark should take into account CPU's
> > frequency @@ -377,30 +377,13 @@ static void
> > tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
> > device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK); }
> > =20
> > -static void actmon_device_debug(struct tegra_devfreq *tegra,
> > -				struct tegra_devfreq_device *dev,
> > -				const char *prefix)
> > -{
> > -	dev_dbg(tegra->devfreq->dev.parent,
> > -		"%03x: %s: 0x%08x 0x%08x a %u %u %u c %u %u %u b
> > %lu cpu %u\n",
> > -		dev->config->offset, prefix,
> > -		device_readl(dev, ACTMON_DEV_INTR_STATUS),
> > -		device_readl(dev, ACTMON_DEV_CTRL),
> > -		device_readl(dev, ACTMON_DEV_AVG_COUNT),
> > -		device_readl(dev, ACTMON_DEV_AVG_LOWER_WMARK),
> > -		device_readl(dev, ACTMON_DEV_AVG_UPPER_WMARK),
> > -		device_readl(dev, ACTMON_DEV_COUNT),
> > -		device_readl(dev, ACTMON_DEV_LOWER_WMARK),
> > -		device_readl(dev, ACTMON_DEV_UPPER_WMARK),
> > -		dev->boost_freq, cpufreq_get(0));
> > -}
> > -
> >  static void actmon_isr_device(struct tegra_devfreq *tegra,
> >  			      struct tegra_devfreq_device *dev)
> >  {
> >  	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
> > =20
> > -	actmon_device_debug(tegra, dev, "isr+");
> > +	trace_device_isr_enter(tegra->regs, dev->config->offset,
> > +			       dev->boost_freq, cpufreq_get(0));
> > =20
> >  	intr_status =3D device_readl(dev, ACTMON_DEV_INTR_STATUS);
> >  	avg_count =3D device_readl(dev, ACTMON_DEV_AVG_COUNT);
> > @@ -455,7 +438,8 @@ static void actmon_isr_device(struct
> > tegra_devfreq *tegra, device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
> >  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> > ACTMON_DEV_INTR_STATUS);=20
> > -	actmon_device_debug(tegra, dev, "isr-");
> > +	trace_device_isr_exit(tegra->regs, dev->config->offset,
> > +			      dev->boost_freq, cpufreq_get(0));
> >  }
> > =20
> >  static unsigned long actmon_update_target(struct tegra_devfreq
> > *tegra, @@ -749,7 +733,6 @@ static struct devfreq_dev_profile
> > tegra_devfreq_profile =3D { static int
> > tegra_governor_get_target(struct devfreq *devfreq, unsigned long
> > *freq) {
> > -	struct device *ddev =3D devfreq->dev.parent;
> >  	struct devfreq_dev_status *stat;
> >  	struct tegra_devfreq *tegra;
> >  	struct tegra_devfreq_device *dev;
> > @@ -770,13 +753,11 @@ static int tegra_governor_get_target(struct
> > devfreq *devfreq, dev =3D &tegra->devices[i];
> > =20
> >  		dev_target_freq =3D actmon_update_target(tegra, dev);
> > -
> >  		target_freq =3D max(target_freq, dev_target_freq);
> > =20
> > -		dev_dbg(ddev, "%03x: upd: dev_target_freq %lu\n",
> > -			dev->config->offset, dev_target_freq);
> > -
> > -		actmon_device_debug(tegra, dev, "upd");
> > +		trace_device_target_freq(dev->config->offset,
> > dev_target_freq);
> > +		trace_device_target_update(tegra->regs,
> > dev->config->offset,
> > +					   dev->boost_freq,
> > cpufreq_get(0)); }
> > =20
> >  	*freq =3D target_freq;
> > diff --git a/include/trace/events/tegra30_devfreq.h
> > b/include/trace/events/tegra30_devfreq.h new file mode 100644
> > index 000000000000..8f264a489daf
> > --- /dev/null
> > +++ b/include/trace/events/tegra30_devfreq.h
> > @@ -0,0 +1,105 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM tegra30_devfreq
> > +
> > +#if !defined(_TRACE_TEGRA30_DEVFREQ_H) ||
> > defined(TRACE_HEADER_MULTI_READ) +#define _TRACE_TEGRA30_DEVFREQ_H
> > +
> > +#include <linux/io.h>
> > +#include <linux/tracepoint.h>
> > +#include <linux/types.h>
> > +
> > +DECLARE_EVENT_CLASS(device_state,
> > +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
> > cpufreq),
> > +	TP_ARGS(base, offset, boost, cpufreq),
> > +	TP_STRUCT__entry(
> > +		__field(u32, offset)
> > +		__field(u32, intr_status)
> > +		__field(u32, ctrl)
> > +		__field(u32, avg_count)
> > +		__field(u32, avg_lower)
> > +		__field(u32, avg_upper)
> > +		__field(u32, count)
> > +		__field(u32, lower)
> > +		__field(u32, upper)
> > +		__field(u32, boost_freq)
> > +		__field(u32, cpu_freq)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->offset		=3D offset;
> > +		__entry->intr_status	=3D readl_relaxed(base +
> > offset + 0x24);
> > +		__entry->ctrl		=3D readl_relaxed(base
> > + offset + 0x0);
> > +		__entry->avg_count	=3D readl_relaxed(base +
> > offset + 0x20);
> > +		__entry->avg_lower	=3D readl_relaxed(base +
> > offset + 0x14);
> > +		__entry->avg_upper	=3D readl_relaxed(base +
> > offset + 0x10);
> > +		__entry->count		=3D readl_relaxed(base
> > + offset + 0x1c);
> > +		__entry->lower		=3D readl_relaxed(base
> > + offset + 0x8);
> > +		__entry->upper		=3D readl_relaxed(base
> > + offset + 0x4);
> > +		__entry->boost_freq	=3D boost;
> > +		__entry->cpu_freq	=3D cpufreq;
> > +	),
> > +	TP_printk("%03x: intr 0x%08x ctrl 0x%08x avg %010u %010u
> > %010u cnt %010u %010u %010u boost %010u cpu %u",
> > +		__entry->offset,
> > +		__entry->intr_status,
> > +		__entry->ctrl,
> > +		__entry->avg_count,
> > +		__entry->avg_lower,
> > +		__entry->avg_upper,
> > +		__entry->count,
> > +		__entry->lower,
> > +		__entry->upper,
> > +		__entry->boost_freq,
> > +		__entry->cpu_freq)
> > +);
> > +
> > +DEFINE_EVENT(device_state, device_isr_enter,
> > +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
> > cpufreq),
> > +	TP_ARGS(base, offset, boost, cpufreq));
> > +
> > +DEFINE_EVENT(device_state, device_isr_exit,
> > +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
> > cpufreq),
> > +	TP_ARGS(base, offset, boost, cpufreq));
> > +
> > +DEFINE_EVENT(device_state, device_target_update,
> > +	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32
> > cpufreq),
> > +	TP_ARGS(base, offset, boost, cpufreq));
> > +
> > +TRACE_EVENT(device_lower_upper,
> > +	TP_PROTO(u32 offset, u32 target, u32 lower, u32 upper),
> > +	TP_ARGS(offset, target, lower, upper),
> > +	TP_STRUCT__entry(
> > +		__field(u32, offset)
> > +		__field(u32, target)
> > +		__field(u32, lower)
> > +		__field(u32, upper)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->offset =3D offset;
> > +		__entry->target =3D target;
> > +		__entry->lower =3D lower;
> > +		__entry->upper =3D upper;
> > +	),
> > +	TP_printk("%03x: freq %010u lower freq %010u upper freq
> > %010u",
> > +		__entry->offset,
> > +		__entry->target,
> > +		__entry->lower,
> > +		__entry->upper)
> > +);
> > +
> > +TRACE_EVENT(device_target_freq,
> > +	TP_PROTO(u32 offset, u32 target),
> > +	TP_ARGS(offset, target),
> > +	TP_STRUCT__entry(
> > +		__field(u32, offset)
> > +		__field(u32, target)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->offset =3D offset;
> > +		__entry->target =3D target;
> > +	),
> > +	TP_printk("%03x: freq %010u", __entry->offset,
> > __entry->target) +);
> > +#endif /* _TRACE_TEGRA30_DEVFREQ_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> >  =20
>=20
>=20

