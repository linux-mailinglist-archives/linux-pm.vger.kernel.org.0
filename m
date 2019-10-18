Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F10DCBC3
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408923AbfJRQoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 12:44:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35944 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408906AbfJRQoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 12:44:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so4236569pfr.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZwMcOsbGZZ8f6uWMLDj+pQEnHD4UiXo77mMaA+m9Cec=;
        b=MaoAVrEWrYmStM42VmjkhM+yBqW5nmFdZUdMgNJxJxHlLHKaZFNCxq6OBgTpGLhKGc
         OWdO81hilPq/aXDzQ9k9l5FMpOwQTtX9aSf/gh8k9HJLlpNNhyBbwzQztVt7Ln578bg2
         TxoaQzzeexqQEm2Me70b+h7c69cdFw+yNHFPR4P/kCRWUaXTKxvLuxWPHHcZhBKMXmRa
         haUzz/7Z5U1iMglzLf+T+vfBOWLIzKGazC+M4utXX8Q/+VWjHY0wZMILMMrJmlC5rYMY
         hO4NiYtRo41y6gSO5oLkynBW3PZH36X124Jp7D/tax93FnMXCzAKfFehw6NNhZxlFywY
         tqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZwMcOsbGZZ8f6uWMLDj+pQEnHD4UiXo77mMaA+m9Cec=;
        b=BCJ3TNjUlWFWCnnScON/2xr0CF5YlFAkflQ+0NCa0/up/rR9C47cI5rvhd5ZpVa7Xa
         U4Lo1IRFDR8dKCoTqXo456WIPXTaL2tgFeQsaUZ4tcrekM+KzFyCrEzEMufLfW7NzWEd
         ybWp9Qk9CxdKjWQ026xZ/u3uTdDEXyywBstXmTRm+TiTZPuNzxmcTlKzN0A9vVpfFaKZ
         x1xry8mqL1psbvWaRyuK9fK8jER3rBx7w/pDqkv9VH+4pTzuzGBNkea0L/pDvkf0XBMC
         pnBykVZupZ61tBevyZuzhmXpjACipwZy9bGGaukILncsfynrD/vUOoysxa6jLqyncH8t
         PchA==
X-Gm-Message-State: APjAAAXkkUc3eZAVaRVN23l5w6TziF9+iNG5yN+rCnj3JBx/pdepDV2U
        25loe6Ngelza2RJFysT1LPq+Xw==
X-Google-Smtp-Source: APXvYqzbk5aRYFgKZCpTVv7zh/wqaJImwgGdmlEdKxg+rLkTLwys+lHKrS40lv4h4mITrIuv7V5cHg==
X-Received: by 2002:a63:f908:: with SMTP id h8mr10900767pgi.244.1571417046622;
        Fri, 18 Oct 2019 09:44:06 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v19sm7230962pff.46.2019.10.18.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:44:05 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:44:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add basic tracepoints
Message-ID: <20191018164403.GB1669@tuxbook-pro>
References: <20191018140224.15087-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018140224.15087-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 18 Oct 07:02 PDT 2019, Georgi Djakov wrote:

> The tracepoints can help with understanding the system behavior of a
> given interconnect path when the consumer drivers change their bandwidth
> demands. This might be interesting when we want to monitor the requested
> interconnect bandwidth for each client driver. The paths may share the
> same nodes and this will help to understand "who and when is requesting
> what". All this is useful for subsystem drivers developers and may also
> provide hints when optimizing the power and performance profile of the
> system.
> 

This is very useful, thanks for writing it up.

> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
[..]
> @@ -449,6 +452,9 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  
>  		/* aggregate requests for this node */
>  		aggregate_requests(node);
> +
> +		trace_icc_set_bw(node, dev_name(path->reqs[i].dev),
> +				 avg_bw, peak_bw);

When I've been debugging interconnect things I've added a
kstrdup_const() of "name" in of_icc_get() and then included that here.

I find including the path name quite useful for devices with multiple
paths.

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

And analog to e.g. the clock traces I would suggest that you trace
device, path and "ret" here.

Regards,
Bjorn
