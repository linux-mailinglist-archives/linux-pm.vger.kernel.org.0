Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A670610CE56
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1SIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 13:08:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46446 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1SIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 13:08:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id z21so598592pjq.13
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PMb7msgM/KgUZx+DS3SiT+HNxE2QfX/HDteHbmagxxg=;
        b=efuE+W82oPAKiAQRtGuSm0SyOFpgxpAg710iEoe0e/XdrEF2uvohmjHK+ENghr7mMp
         SPvzq2ylz3sgvpfmK7/wNU1dXgzecAt+SouJEX0BfAGGnOWPdd0AzdQEhQUdn4hBa8pD
         MJNB/ZP2IkWFYCXEGZPzfEGMySpUZvnXDnzgBzZteMhfjbDwgr+OiWVe6skrbIIXoMbt
         KbryDx71utoUiNAMgm+sKZsRI407F50qs+EZ7os2HWVaTTeCBusCJ9oYdMpFN/06dGwv
         +fDNiMjjXEF/zdzrK7BE5p2QzYGJTGnXoqV+8Z4etw4gGcUHEaZHeKQj/Pdf7wVT3z5W
         S4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PMb7msgM/KgUZx+DS3SiT+HNxE2QfX/HDteHbmagxxg=;
        b=bdYvKWHdzVYzzIbh5Ye73NtDYWmmjbrUpB0jsLMIxU61Xb7BOd2Frz9p5HsQT5uLR1
         7rZOHPHlMTHAH8WSPnmWzSOYvMw9Z6m4mUjCVl+zNL9MSHdKZ3tdpproSOdhBSxVK7w/
         nODCUA/0UzVPjcoZkCIRY2vUhgqoDC8l+DqTQBciTKvP9+hVHo1IUJMfFmGL1UYpWWww
         Be3cEqwYk22snmVdp9W+WEhKUL0Xthm+IdFCjc/xrxhwrTjknQGg1gxIh4l75iVregRv
         l2ERd4NnaXiJnIgNR9BimRBqH3kAD/PVtSOjlr0oArx5oaHNjCuq8jrhmjQrRtWw7xVJ
         DFtA==
X-Gm-Message-State: APjAAAVnS/3tyUeigUFCSfv6D8SRKcxyLagalX7A1GxUEGdGDGohpShQ
        76nDr7C3okBC8XU2O3YON1wOQA==
X-Google-Smtp-Source: APXvYqyRBiFkI2aJmevSNycv72yKbehZlGDXVZUbUwhetzeH8Zjsgn2IyJQldx0ZFyXg++8/4Y/Frw==
X-Received: by 2002:a17:90a:ca0e:: with SMTP id x14mr13956543pjt.95.1574964492722;
        Thu, 28 Nov 2019 10:08:12 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm21539713pfz.135.2019.11.28.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 10:08:12 -0800 (PST)
Date:   Thu, 28 Nov 2019 10:08:09 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] interconnect: Add basic tracepoints
Message-ID: <20191128180809.GG82109@yoga>
References: <20191128141818.32168-1-georgi.djakov@linaro.org>
 <20191128141818.32168-4-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128141818.32168-4-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 28 Nov 06:18 PST 2019, Georgi Djakov wrote:

> The tracepoints can help with understanding the system behavior of a
> given interconnect path when the consumer drivers change their bandwidth
> demands. This might be interesting when we want to monitor the requested
> interconnect bandwidth for each client driver. The paths may share the
> same nodes and this will help to understand "who and when is requesting
> what". All this is useful for subsystem drivers developers and may also
> provide hints when optimizing the power and performance profile of the
> system.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/interconnect/Makefile |  1 +
>  drivers/interconnect/core.c   |  7 +++
>  drivers/interconnect/trace.h  | 88 +++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 drivers/interconnect/trace.h
> 
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
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
> index c9e16bc1331e..0e4852feb395 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -21,6 +21,9 @@
>  
>  #include "internal.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> +
>  static DEFINE_IDR(icc_idr);
>  static LIST_HEAD(icc_providers);
>  static DEFINE_MUTEX(icc_lock);
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
> index 000000000000..3d668ff566bf
> --- /dev/null
> +++ b/drivers/interconnect/trace.h
> @@ -0,0 +1,88 @@
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
