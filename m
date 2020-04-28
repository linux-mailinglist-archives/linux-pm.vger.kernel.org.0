Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24B31BC3A6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgD1P2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727917AbgD1P2o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 11:28:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DDC03C1AB
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 08:28:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n24so8484377plp.13
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bupX4Xeuiln/DjuxcvV53YK6vLVjuUky6WkzRYhlMcY=;
        b=ls38140qhFqIHiH1VWhQV1JjlPCTVDhgEiCQJeqzoj10IuX4Fxh+KT8CSglGlmQZGy
         wFYXg9ksMB0mkoRh+tgrSf0EcKN8EuBtdqwMLali2VFuB7fAD4OWBw6PhSLEXq9trlzI
         zcw8B9j9FwmZWgLgIJrSDOnVQgeQVwNFWMdZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bupX4Xeuiln/DjuxcvV53YK6vLVjuUky6WkzRYhlMcY=;
        b=ofBIEzxzNAYCbxpEHSwWx7+0A8VD8WAi4GWHOMw9xO0Lo4N//yunRykh1HjXp99omO
         Vp+AYnJXL9oC8bkAsR7y0P++y7pbYGYlznV2dRi9dWAiu8GL7MWbXL8k2bz0OgGRC9Nw
         kaG13KKx7rHpJt6o4QXy4znq3I2kp/F0Qq4NcMK6FGVFtMpnnPZab7/l7GHoovFtt/Qx
         TT2Xbz21uintLkxMfji6VTuUjYsZ5TVOF8gcB1X/g11aAvtjpAhV6eBm/iwiNLUR9g3z
         MdkFs27kIb6LUEuIc5cYDHiEQRQa/zXS2/jFtZgBLoVdL3I3zXpSRcCGM7o3w0wQz6dV
         ql/Q==
X-Gm-Message-State: AGi0PuZRcswrgCf+ZKxgaK8eovna1N65CIsiszjKv4TgAbzN2WDOc1GI
        7uNe2nM6+PcPnyFHNey/JYdOnA==
X-Google-Smtp-Source: APiQypK5LNxibTTwgAnq1UH8tV7/wQW/2P5QfBgYpRZBViEZoKjLdkXzCRxvwiChnIc7+fV8LD1RvQ==
X-Received: by 2002:a17:902:82c6:: with SMTP id u6mr30286582plz.146.1588087723981;
        Tue, 28 Apr 2020 08:28:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id o1sm2387369pjs.35.2020.04.28.08.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 08:28:43 -0700 (PDT)
Date:   Tue, 28 Apr 2020 08:28:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add helpers for enabling/disabling a path
Message-ID: <20200428152842.GG4525@google.com>
References: <20200428091650.27669-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428091650.27669-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On Tue, Apr 28, 2020 at 12:16:50PM +0300, Georgi Djakov wrote:
> There is a repeated pattern in multiple drivers where they want to switch
> the bandwidth between zero and some other value. This is happening often
> in the suspend/resume callbacks. Let's add helper functions to enable and
> disable the path, so that callers don't have to take care of remembering
> the bandwidth values and handle this in the framework instead.
> 
> With this patch the users can call icc_disable() and icc_enable() to lower
> their bandwidth request to zero and then restore it back to it's previous
> value.
> 
> Suggested-by: Evan Green <evgreen@chromium.org>
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c     | 50 ++++++++++++++++++++++++++++++++-
>  drivers/interconnect/internal.h |  2 ++
>  include/linux/interconnect.h    | 12 ++++++++
>  3 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 2c6515e3ecf1..6af68e506ac2 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -158,6 +158,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
>  		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
>  		path->reqs[i].node = node;
>  		path->reqs[i].dev = dev;
> +		path->reqs[i].enabled = true;
>  		/* reference to previous node was saved during path traversal */
>  		node = node->reverse;
>  	}
> @@ -249,9 +250,12 @@ static int aggregate_requests(struct icc_node *node)
>  	if (p->pre_aggregate)
>  		p->pre_aggregate(node);
>  
> -	hlist_for_each_entry(r, &node->req_list, req_node)
> +	hlist_for_each_entry(r, &node->req_list, req_node) {
> +		if (!r->enabled)
> +			continue;
>  		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
>  			     &node->avg_bw, &node->peak_bw);
> +	}
>  
>  	return 0;
>  }
> @@ -546,6 +550,50 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  }
>  EXPORT_SYMBOL_GPL(icc_set_bw);
>  
> +int icc_disable(struct icc_path *path)
> +{
> +	int i;
> +
> +	if (!path)
> +		return 0;
> +
> +	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
> +		return -EINVAL;
> +
> +	mutex_lock(&icc_lock);
> +
> +	for (i = 0; i < path->num_nodes; i++)
> +		path->reqs[i].enabled = false;
> +
> +	mutex_unlock(&icc_lock);
> +
> +	return icc_set_bw(path, path->reqs[0].avg_bw,
> +			  path->reqs[0].peak_bw);
> +}
> +EXPORT_SYMBOL_GPL(icc_disable);
> +
> +int icc_enable(struct icc_path *path)
> +{
> +	int i;
> +
> +	if (!path)
> +		return 0;
> +
> +	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
> +		return -EINVAL;
> +
> +	mutex_lock(&icc_lock);
> +
> +	for (i = 0; i < path->num_nodes; i++)
> +		path->reqs[i].enabled = true;
> +
> +	mutex_unlock(&icc_lock);
> +
> +	return icc_set_bw(path, path->reqs[0].avg_bw,
> +			  path->reqs[0].peak_bw);
> +}

The two functions are identical except for the assignment of the 'enabled'
flags. You could add a helper _icc_enable(struct icc_path *path, bool enable)
and call it from icc_enable/disable().
