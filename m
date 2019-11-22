Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE5107636
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 18:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKVRHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 12:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRHt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Nov 2019 12:07:49 -0500
Received: from oasis.local.home (unknown [66.170.99.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D2E20658;
        Fri, 22 Nov 2019 17:07:47 +0000 (UTC)
Date:   Fri, 22 Nov 2019 12:07:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] interconnect: Add basic tracepoints
Message-ID: <20191122120746.62027203@oasis.local.home>
In-Reply-To: <20191122152712.19105-4-georgi.djakov@linaro.org>
References: <20191122152712.19105-1-georgi.djakov@linaro.org>
        <20191122152712.19105-4-georgi.djakov@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 Nov 2019 17:27:12 +0200
Georgi Djakov <georgi.djakov@linaro.org> wrote:
> index 28f2ab0824d5..725029ae7a2c 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +CFLAGS_core.o				:= -I$(src)
>  icc-core-objs				:= core.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 1ddad8ef3cf0..b218a2609f6b 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -19,6 +19,9 @@
>  #include <linux/of.h>
>  #include <linux/overflow.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> +

You may want to move this below the include of internal.h, as you don't
want CREATE_TRACE_POINTS defined when including any other header, or it
can cause issues if that header has some tracepoint header inside it.

It may not be the case now, but could cause for headaches in the
future, if other headers get included in internal.h.

>  #include "internal.h"
>  
>  static DEFINE_IDR(icc_idr);
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
> diff --git a/drivers/interconnect/trace.h b/drivers/interconnect/trace.h
> new file mode 100644
> index 000000000000..d2421bf7b389
> --- /dev/null
> +++ b/drivers/interconnect/trace.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Interconnect framework tracepoints
> + * Copyright (c) 2019, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM interconnect
> +
> +#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_INTERCONNECT_H
> +
> +#include <linux/interconnect.h>
> +#include <linux/tracepoint.h>
> +
> +#include "internal.h"

And you include it here too, perhaps it is best not to have it here,
and then just have it before trace.h is called?

The rest looks good. Besides the comments above:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

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
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace
> +
> +#include <trace/define_trace.h>

