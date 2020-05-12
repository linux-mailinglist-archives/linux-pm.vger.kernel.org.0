Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAAA1D0176
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 00:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgELWAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 18:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELWAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 18:00:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA8AC061A0E
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 15:00:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so7038050pfb.10
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ddE82/gNSNp4A/gKz3+NrCd0gdVAPuOemEUxiIBW/OQ=;
        b=K9gJNy9fjti0A6468uJpUTKSWwglc3ucBlRAKSfhako2ebKTZl/n1ksMJ/s4RjOlZK
         LhJV5amDlFSHc7SL8VyqRUPXH9AUmwslY+bBtd6YhwsxUc17UgPKrWfD7Qs8/vDv4Y2i
         L612f453UM427YXGrYwF+xXa8J2wWeGbS9nMzh1y0elHqRv7vx5zKonOLyXwO08/ajqo
         vGwXjZfRKkLOFYbq2L3+vAOqNq6NsV+VvMwefddwKjRlSeTDUvDnFppxUjvo/sLF4Cys
         rx06EVJ0aZy3JWaYcwmwv+tT6b5ZyYA6FLI3K0bj90WMTRtYaAveeGOkU3QEM2igBBgu
         rMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddE82/gNSNp4A/gKz3+NrCd0gdVAPuOemEUxiIBW/OQ=;
        b=Gsaq32+UkkhiTo0w+Wul8TXUhkdp74KPAYFdzDw2/Vqz7/SMo5jDYmw3iV15zxh/yg
         lDe+BI+c3wd3qNAlCKbg0q9G7ir2FtQkExISYCJLpyNrXYp6LSr/4SxOrbXvK2oblsgN
         32HQpiycQ/vYKtgEUvrcviGDhP+UB/MwdRJeqf5pl4j6Jv0U1+mc/01Ay8Y0S/AVxZtO
         BRGfILXxFeFNctyUpJqhynkRlxCTnQOXjCO8OH+P1ExtRpyMFrLtWW8vuKM2Ky84uux0
         sw67aesc5se85Ejun7r3GuA0/jNd78QcecHUeQ9+IBhjGASvWdXWLwStCJLJKoLXN8kH
         g30w==
X-Gm-Message-State: AGi0PuZirlQBTedkWwHst6pvCRSfrXuW0BCVkQcuVq3+0OX3VrNOx0pI
        F7buD8kaMMb/H4r4NqRHzuLKSg==
X-Google-Smtp-Source: APiQypIMfdb0+fcMj9TDpn2dvSQKBqSJtstGJU7yN/HLaXZ3pFGFn7vRtBXipHuHeQtsHuxMUtb5iw==
X-Received: by 2002:aa7:8b0d:: with SMTP id f13mr22921440pfd.270.1589320848502;
        Tue, 12 May 2020 15:00:48 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 184sm13200508pfy.144.2020.05.12.15.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:00:47 -0700 (PDT)
Date:   Tue, 12 May 2020 14:59:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org, mka@chromium.org,
        akashast@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: Add helpers for enabling/disabling a
 path
Message-ID: <20200512215915.GL2165@builder.lan>
References: <20200507120846.8354-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507120846.8354-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 07 May 05:08 PDT 2020, Georgi Djakov wrote:

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

Nice

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
