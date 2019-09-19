Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA766B7F3D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbfISQgC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 12:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388442AbfISQgC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 12:36:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1863420640;
        Thu, 19 Sep 2019 16:36:01 +0000 (UTC)
Date:   Thu, 19 Sep 2019 12:35:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] devfreq: Add tracepoint for frequency changes
Message-ID: <20190919123559.2931e0ef@gandalf.local.home>
In-Reply-To: <20190918191537.48837-1-mka@chromium.org>
References: <20190918191537.48837-1-mka@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 18 Sep 2019 12:15:37 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> Add a tracepoint for frequency changes of devfreq devices and
> use it.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c      |  3 +++
>  include/trace/events/devfreq.h | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index ab22bf8a12d6..32de1f6ac776 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  
>  	devfreq->previous_freq = new_freq;
>  
> +	if (new_freq != cur_freq)

I would make this:

	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)

Because this would place the second check into the "nop" portion of the
code, keeping the test from being performed if the devfreq_frequency
trace point is not enabled. Slight micro optimization, but still enough
to add it.

-- Steve


> +		trace_devfreq_frequency(devfreq, new_freq);
> +
>  	if (devfreq->suspend_freq)
>  		devfreq->resume_freq = cur_freq;
>  
> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
> index cf5b8772175d..a62d32fe3c33 100644
> --- a/include/trace/events/devfreq.h
> +++ b/include/trace/events/devfreq.h
> @@ -8,6 +8,24 @@
>  #include <linux/devfreq.h>
>  #include <linux/tracepoint.h>
>  
> +TRACE_EVENT(devfreq_frequency,
> +	TP_PROTO(struct devfreq *devfreq, unsigned long freq),
> +
> +	TP_ARGS(devfreq, freq),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(&devfreq->dev))
> +		__field(unsigned long, freq)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(&devfreq->dev));
> +		__entry->freq = freq;
> +	),
> +
> +	TP_printk("dev_name=%s freq=%lu", __get_str(dev_name), __entry->freq)
> +);
> +
>  TRACE_EVENT(devfreq_monitor,
>  	TP_PROTO(struct devfreq *devfreq),
>  

