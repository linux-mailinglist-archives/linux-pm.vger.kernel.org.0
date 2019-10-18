Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61186DC709
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfJRONr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 10:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfJRONq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 10:13:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B35F21925;
        Fri, 18 Oct 2019 14:13:44 +0000 (UTC)
Date:   Fri, 18 Oct 2019 10:13:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add basic tracepoints
Message-ID: <20191018101342.5eb580ed@gandalf.local.home>
In-Reply-To: <20191018140224.15087-1-georgi.djakov@linaro.org>
References: <20191018140224.15087-1-georgi.djakov@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Oct 2019 17:02:24 +0300
Georgi Djakov <georgi.djakov@linaro.org> wrote:

> The tracepoints can help with understanding the system behavior of a
> given interconnect path when the consumer drivers change their bandwidth
> demands. This might be interesting when we want to monitor the requested
> interconnect bandwidth for each client driver. The paths may share the
> same nodes and this will help to understand "who and when is requesting
> what". All this is useful for subsystem drivers developers and may also
> provide hints when optimizing the power and performance profile of the
> system.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  MAINTAINERS                         |  1 +
>  drivers/interconnect/core.c         |  9 +++++
>  include/trace/events/interconnect.h | 52 +++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 include/trace/events/interconnect.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55199ef7fa74..c307c4b8f677 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8526,6 +8526,7 @@ F:	drivers/interconnect/
>  F:	include/dt-bindings/interconnect/
>  F:	include/linux/interconnect-provider.h
>  F:	include/linux/interconnect.h
> +F:	include/trace/events/interconnect.h
>  
>  INVENSENSE MPU-3050 GYROSCOPE DRIVER
>  M:	Linus Walleij <linus.walleij@linaro.org>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 7b971228df38..e24092558c29 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -24,6 +24,9 @@ static LIST_HEAD(icc_providers);
>  static DEFINE_MUTEX(icc_lock);
>  static struct dentry *icc_debugfs_dir;
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/interconnect.h>
> +
>  /**
>   * struct icc_req - constraints that are attached to each node
>   * @req_node: entry in list of requests for the particular @node
> @@ -449,6 +452,9 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  
>  		/* aggregate requests for this node */
>  		aggregate_requests(node);
> +
> +		trace_icc_set_bw(node, dev_name(path->reqs[i].dev),
> +				 avg_bw, peak_bw);

BTW, it's best to do the "dev_name()" from the TP_fast_assign()
portion. It keeps the work out of the inlined code here. Although it
shouldn't be processed within the fast path, it still adds a cache
footprint.

		trace_icc_set_bw(node, path->reqs[i].dev, avg_bw, peak_bw);

>  	}
>  
>  	ret = apply_constraints(path);
> @@ -461,6 +467,9 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  			path->reqs[i].avg_bw = old_avg;
>  			path->reqs[i].peak_bw = old_peak;
>  			aggregate_requests(node);
> +
> +			trace_icc_set_bw(node, dev_name(path->reqs[i].dev),
> +					 old_avg, old_peak);
>  		}
>  		apply_constraints(path);
>  	}
> diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
> new file mode 100644
> index 000000000000..8e001382e9b0
> --- /dev/null
> +++ b/include/trace/events/interconnect.h
> @@ -0,0 +1,52 @@
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
> +struct icc_node;
> +
> +TRACE_EVENT(icc_set_bw,
> +
> +	TP_PROTO(struct icc_node *n, const char *cdev, u32 avg_bw, u32 peak_bw),

	TP_PROTO(struct icc_node *n, const struct device *cdev,

> +
> +	TP_ARGS(n, cdev, avg_bw, peak_bw),
> +
> +	TP_STRUCT__entry(
> +		__string(node_name, n->name)
> +		__field(u32, node_avg_bw)
> +		__field(u32, node_peak_bw)
> +		__string(cdev, cdev)

		__string(cdev, dev_name(cdev))

> +		__field(u32, avg_bw)
> +		__field(u32, peak_bw)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(node_name, n->name);
> +		__entry->node_avg_bw = n->avg_bw;
> +		__entry->node_peak_bw = n->peak_bw;
> +		__assign_str(cdev, cdev);

		__assign_str(cdev, dev_name(cdev));

-- Steve

> +		__entry->avg_bw = avg_bw;
> +		__entry->peak_bw = peak_bw;
> +	),
> +
> +	TP_printk("%s avg_bw=%u peak_bw=%u cdev=%s avg_bw=%u peak_bw=%u",
> +		__get_str(node_name),
> +		__entry->node_avg_bw,
> +		__entry->node_peak_bw,
> +		__get_str(cdev),
> +		__entry->avg_bw,
> +		__entry->peak_bw)
> +);
> +#endif /* _TRACE_INTERCONNECT_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

