Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33130FB9B0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKMUXV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 15:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfKMUXV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 15:23:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19FA206EC;
        Wed, 13 Nov 2019 20:23:19 +0000 (UTC)
Date:   Wed, 13 Nov 2019 15:23:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] interconnect: Add basic tracepoints
Message-ID: <20191113152317.00318ad8@gandalf.local.home>
In-Reply-To: <20191101130031.27996-4-georgi.djakov@linaro.org>
References: <20191101130031.27996-1-georgi.djakov@linaro.org>
        <20191101130031.27996-4-georgi.djakov@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  1 Nov 2019 15:00:31 +0200
Georgi Djakov <georgi.djakov@linaro.org> wrote:

> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index df44ef713db5..15e11e22ddf7 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -26,6 +26,9 @@ static LIST_HEAD(icc_providers);
>  static DEFINE_MUTEX(icc_lock);
>  static struct dentry *icc_debugfs_dir;
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/interconnect.h>
> +
>  static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
>  {
>  	if (!n)
> @@ -435,6 +438,8 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  
>  		/* aggregate requests for this node */
>  		aggregate_requests(node);
> +
> +		trace_icc_set_bw(path, node, i, avg_bw, peak_bw);
>  	}
>  
>  	ret = apply_constraints(path);
> @@ -453,6 +458,8 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  
>  	mutex_unlock(&icc_lock);
>  
> +	trace_icc_set_bw_end(path, ret);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(icc_set_bw);
> diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
> new file mode 100644
> index 000000000000..64b646aa7bd3
> --- /dev/null
> +++ b/include/trace/events/interconnect.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_INTERCONNECT_H
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM interconnect
> +
> +#include "../../../drivers/interconnect/internal.h"

Ug.

I would recommend placing this file in with drivers/interconnect, and
call it simply trace.h, or interconnect_trace.h. Then you can include
"internal.h" nicely.

To do so, you need to add to drivers/interconnect/Makefile:

 CFLAGS_core.o := -I$(src)

To have core.c include this file.

Rest looks fine.

-- Steve


> +
> +TRACE_EVENT(icc_set_bw,
> +
> +	TP_PROTO(struct icc_path *p, struct icc_node *n, int i,
> +		 u32 avg_bw, u32 peak_bw),
> +
> +	TP_ARGS(p, n, i, avg_bw, peak_bw),
> +
> +	TP_STRUCT__entry(
> +		__string(path_name, p->name)
> +		__string(dev, dev_name(p->reqs[i].dev))
> +		__string(node_name, n->name)
> +		__field(u32, avg_bw)
> +		__field(u32, peak_bw)
> +		__field(u32, node_avg_bw)
> +		__field(u32, node_peak_bw)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(path_name, p->name);
> +		__assign_str(dev, dev_name(p->reqs[i].dev));
> +		__assign_str(node_name, n->name);
> +		__entry->avg_bw = avg_bw;
> +		__entry->peak_bw = peak_bw;
> +		__entry->node_avg_bw = n->avg_bw;
> +		__entry->node_peak_bw = n->peak_bw;
> +	),
> +
> +	TP_printk("path=%s dev=%s node=%s avg_bw=%u peak_bw=%u agg_avg=%u agg_peak=%u",
> +		  __get_str(path_name),
> +		  __get_str(dev),
> +		  __get_str(node_name),
> +		  __entry->avg_bw,
> +		  __entry->peak_bw,
> +		  __entry->node_avg_bw,
> +		  __entry->node_peak_bw)
> +);
> +
> +TRACE_EVENT(icc_set_bw_end,
> +
> +	TP_PROTO(struct icc_path *p, int ret),
> +
> +	TP_ARGS(p, ret),
> +
> +	TP_STRUCT__entry(
> +		__string(path_name, p->name)
> +		__string(dev, dev_name(p->reqs[0].dev))
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(path_name, p->name);
> +		__assign_str(dev, dev_name(p->reqs[0].dev));
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("path=%s dev=%s ret=%d",
> +		  __get_str(path_name),
> +		  __get_str(dev),
> +		  __entry->ret)
> +);
> +
> +#endif /* _TRACE_INTERCONNECT_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

