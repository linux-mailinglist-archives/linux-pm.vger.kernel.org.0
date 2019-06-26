Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387DD55D3E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFZBMu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZBMu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 21:12:50 -0400
Received: from localhost (unknown [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0CA2086D;
        Wed, 26 Jun 2019 01:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561511569;
        bh=3OlpzYyKa6yLcvXYCQ1PS5dl9yEKICWKqWfnEFaJpGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ta/DyoS/+ara90iiui7dB0fTlGKD2wsGcX+OYcrwO1ylp+rL3xzW6KEr5zT9U8Oeq
         eRfvlueJRFv6yOL04uFq4TvR/MTUXJ/vcNoHQ9rhDGRDGEDqqN6WSewQEA3MIxbkCe
         DT1ZEz5C3MMgkke7aPLNi3+w6w6YguhEQ4xG1XRQ=
Date:   Wed, 26 Jun 2019 09:12:21 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, rafael@kernel.org,
        hridya@google.com, sspatil@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com--annotate
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190626011221.GB22454@kroah.com>
References: <20190626005449.225796-1-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626005449.225796-1-trong@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 25, 2019 at 05:54:49PM -0700, Tri Vo wrote:
> Userspace can use wakeup_sources debugfs node to plot history of suspend
> blocking wakeup sources over device's boot cycle. This information can
> then be used (1) for power-specific bug reporting and (2) towards
> attributing battery consumption to specific processes over a period of
> time.
> 
> However, debugfs doesn't have stable ABI. For this reason, expose wakeup
> sources statistics in sysfs under /sys/power/wakeup_sources/<name>/
> 
> Add following attributes to each wakeup source. These attributes match
> the columns of /sys/kernel/debug/wakeup_sources.
> 
>   active_count
>   event_count
>   wakeup_count
>   expire_count
>   active_time (named "active_since" in debugfs)
>   total_time
>   max_time
>   last_change
>   prevent_suspend_time

Can you also add a Documentation/ABI/ update for your new sysfs files so
that we can properly review this?

> Embedding a struct kobject into struct wakeup_source changes lifetime
> requirements on the latter. To that end, change deallocation of struct
> wakeup_source using kfree to kobject_put().

Ick, are you sure you need a new kobject here?  Why wouldn't a named
attribute group work instead?  That should keep this patch much smaller
and simpler.

> +static ssize_t wakeup_source_count_show(struct wakeup_source *ws,
> +					struct wakeup_source_attribute *attr,
> +					char *buf)
> +{
> +	unsigned long flags;
> +	unsigned long var;
> +
> +	spin_lock_irqsave(&ws->lock, flags);
> +	if (strcmp(attr->attr.name, "active_count") == 0)
> +		var = ws->active_count;
> +	else if (strcmp(attr->attr.name, "event_count") == 0)
> +		var = ws->event_count;
> +	else if (strcmp(attr->attr.name, "wakeup_count") == 0)
> +		var = ws->wakeup_count;
> +	else
> +		var = ws->expire_count;
> +	spin_unlock_irqrestore(&ws->lock, flags);
> +
> +	return sprintf(buf, "%lu\n", var);
> +}

Why is this lock always needed to be grabbed?  You are just reading a
value, who cares if it changes inbetween reading it and returning the
buffer string as it can change at that point in time anyway?

thanks,

greg k-h
