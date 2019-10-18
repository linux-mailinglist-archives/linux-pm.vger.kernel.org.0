Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF1DCC04
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408819AbfJRQzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 12:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405642AbfJRQzx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 12:55:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FE620854;
        Fri, 18 Oct 2019 16:55:52 +0000 (UTC)
Date:   Fri, 18 Oct 2019 12:55:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add basic tracepoints
Message-ID: <20191018125550.0ad0eefa@gandalf.local.home>
In-Reply-To: <20191018164403.GB1669@tuxbook-pro>
References: <20191018140224.15087-1-georgi.djakov@linaro.org>
        <20191018164403.GB1669@tuxbook-pro>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Oct 2019 09:44:03 -0700
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> > @@ -449,6 +452,9 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> >  
> >  		/* aggregate requests for this node */
> >  		aggregate_requests(node);
> > +
> > +		trace_icc_set_bw(node, dev_name(path->reqs[i].dev),
> > +				 avg_bw, peak_bw);  
> 
> When I've been debugging interconnect things I've added a
> kstrdup_const() of "name" in of_icc_get() and then included that here.
> 
> I find including the path name quite useful for devices with multiple
> paths.
> 
> >  	}
> >  
> >  	ret = apply_constraints(path);
> > @@ -461,6 +467,9 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> >  			path->reqs[i].avg_bw = old_avg;
> >  			path->reqs[i].peak_bw = old_peak;
> >  			aggregate_requests(node);
> > +
> > +			trace_icc_set_bw(node, dev_name(path->reqs[i].dev),
> > +					 old_avg, old_peak);
> >  		}
> >  		apply_constraints(path);  
> 
> And analog to e.g. the clock traces I would suggest that you trace
> device, path and "ret" here.

If you are going to switch to device name and path, please just pass in
the path to the trace point. Then have the TP_fast_assign() do the rest
of the work.

Thanks!

-- Steve
