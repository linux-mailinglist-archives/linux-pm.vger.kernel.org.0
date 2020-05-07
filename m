Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C11C95A8
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgEGP5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728028AbgEGP5Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 11:57:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD8C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 08:57:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so3192876pfv.8
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D4EacoqLrks03Ge0RCzM6pu9iVWZ73tmsSunwf83CvA=;
        b=AoTz5sGmagbHHvj2Ukx2Xn0z5zI4ieVjR3BuWxfMXVqkIDVqRpfZzMZ3lr/cT1UCdB
         Rlr9fsxa01PQZrNoTl088lbebcpciyfdWkOi2/JDtNBm1YhZF3Dxl/gx02be7INEG+oA
         6qlGHMwDEbY79blf2uKO+a5CXvf4KdjgtNQJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D4EacoqLrks03Ge0RCzM6pu9iVWZ73tmsSunwf83CvA=;
        b=LmbBzkVSbkIJrPi2bP2NNlZv18WLxpFAzgIh3tfIq4BLLfMFNqXfJKWTBFIa9ZbH3q
         mXgTmUt544o0QMUlBp4BxJX8+8zN7N9t3UrY9nBR63QmAZ8YQ/5kPTw+CT8LIfJQeox7
         95wvUOuPq/TTnGvDHFue0K+Qq/322A0xOCVLVVuepbHTFU4oacCvhjcK6quBmXYOVMn2
         OghwuQJ/qNJgt8uWfitqp8Xm/gx53WFifEQZlDD9A5hjw4M9/bLEA4s6taHoPm80BhmG
         iwthuKVjyiCzkeSjmLgCW+dzqX2YIMazEXLs3apkNls+VPNj5D2XxVbaCmtGYPrVn2E1
         ZANQ==
X-Gm-Message-State: AGi0PuYbpZVs92/xD67C7Z829RmJ1q5domG4A7ns7P4Oanupg05D30qG
        zYq+V8rLRrNn2IIg76d4POCmug==
X-Google-Smtp-Source: APiQypKpyD0a/6T6VXGV5Q0+j/KBuiI/K33HfPtiUjfj2T9KrCHbp9VRrfnx8mQILJgdSpJFU/m6zQ==
X-Received: by 2002:a62:16cb:: with SMTP id 194mr14822510pfw.78.1588867033537;
        Thu, 07 May 2020 08:57:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id gd17sm234805pjb.21.2020.05.07.08.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 08:57:12 -0700 (PDT)
Date:   Thu, 7 May 2020 08:57:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: Add helpers for enabling/disabling a
 path
Message-ID: <20200507155711.GZ4525@google.com>
References: <20200507120846.8354-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507120846.8354-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 03:08:46PM +0300, Georgi Djakov wrote:
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
> v2: https://lore.kernel.org/r/20200428091650.27669-1-georgi.djakov@linaro.org/
> * Extract the common code into __icc_enable() (Matthias)
> 
> 
>  drivers/interconnect/core.c     | 39 ++++++++++++++++++++++++++++++++-
>  drivers/interconnect/internal.h |  2 ++
>  include/linux/interconnect.h    | 12 ++++++++++
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index f5699ed34e43..d5e0f93c942d 100644
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
> @@ -571,6 +575,39 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  }
>  EXPORT_SYMBOL_GPL(icc_set_bw);
>  
> +static int __icc_enable(struct icc_path *path, bool enable)
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
> +		path->reqs[i].enabled = enable;
> +
> +	mutex_unlock(&icc_lock);
> +
> +	return icc_set_bw(path, path->reqs[0].avg_bw,
> +			  path->reqs[0].peak_bw);
> +}
> +
> +int icc_disable(struct icc_path *path)
> +{
> +	return __icc_enable(path, false);
> +}
> +EXPORT_SYMBOL_GPL(icc_disable);
> +
> +int icc_enable(struct icc_path *path)
> +{
> +	return __icc_enable(path, true);
> +}
> +EXPORT_SYMBOL_GPL(icc_enable);
> +

uber-nit: my brain expects the order enable/disable, just like lock/unlock
or true/false instead of vice-versa, but it's certainly not really
important :)

>  /**
>   * icc_get() - return a handle for path between two endpoints
>   * @dev: the device requesting the path
> diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
> index bf18cb7239df..f5f82a5c939e 100644
> --- a/drivers/interconnect/internal.h
> +++ b/drivers/interconnect/internal.h
> @@ -14,6 +14,7 @@
>   * @req_node: entry in list of requests for the particular @node
>   * @node: the interconnect node to which this constraint applies
>   * @dev: reference to the device that sets the constraints
> + * @enabled: indicates whether the path with this request is enabled
>   * @tag: path tag (optional)
>   * @avg_bw: an integer describing the average bandwidth in kBps
>   * @peak_bw: an integer describing the peak bandwidth in kBps
> @@ -22,6 +23,7 @@ struct icc_req {
>  	struct hlist_node req_node;
>  	struct icc_node *node;
>  	struct device *dev;
> +	bool enabled;
>  	u32 tag;
>  	u32 avg_bw;
>  	u32 peak_bw;
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 770692421f4c..2b7b331c9354 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -30,6 +30,8 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
>  struct icc_path *of_icc_get(struct device *dev, const char *name);
>  struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
>  void icc_put(struct icc_path *path);
> +int icc_disable(struct icc_path *path);
> +int icc_enable(struct icc_path *path);
>  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>  void icc_set_tag(struct icc_path *path, u32 tag);
>  
> @@ -57,6 +59,16 @@ static inline void icc_put(struct icc_path *path)
>  {
>  }
>  
> +static inline int icc_disable(struct icc_path *path)
> +{
> +	return 0;
> +}
> +
> +static inline int icc_enable(struct icc_path *path)
> +{
> +	return 0;
> +}
> +
>  static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  {
>  	return 0;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
