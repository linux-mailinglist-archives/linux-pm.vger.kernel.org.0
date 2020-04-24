Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20DB1B7D71
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgDXSCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 14:02:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0BC09B04A
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 11:02:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so4174011pjb.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pOk/kzhlhPwNaetCm8gHWGwhQXlpl0JHUkFF0oAV7cs=;
        b=Fnz1wUCcpiV9Sbd1YePKv3AoJZbAFcFu1weCKyJf/l35GLl+RBs2PnSoBgMsTXAbpN
         hSkWcBmxyu1B3ASUzbyGpxWEYa9ByJRR0sL+EH0O7kGCxr9A9Pz/8cy6RBWvF9FPasIb
         nyxWc4sgKXi4zzCu32UhYeVxmxIDJ535rbkn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pOk/kzhlhPwNaetCm8gHWGwhQXlpl0JHUkFF0oAV7cs=;
        b=M4jjrZ5WejRWsKH8kYmPAKVGi5X1m6AaqCl+XPDA1MwK406pD0cuQups0RR2n43nf6
         FGyBXcP1vpt13g3cZjMp2R7fdl5cHGfWvJv/WYyD3RXwypt7JFvNx4MjxbpsK6+eGMk9
         PUUXdQUhWsFk/5Hx+wESwlQiPPVkWnAjapbmENAglxyMNF/RZGHYm+Ednf7XB1ZxNdA+
         5bQ5o7gOrjxABBSu3z1w9wBlXyIige/g7S/BKOFqoolGFRZmgPq1LVbPh2U0Bi6+2kc0
         T6VAdcQAuPUCVoo9w0d2UMVpAbZJ/kRh8WOzdyb/lYevE5z7xDD3YvNXZYt2hGBee+CJ
         I1Cw==
X-Gm-Message-State: AGi0PubWqn9ZWuIKPDiZJiIoiHEgIxnkC0zbvNlSQU5H68nn4zEvv0NP
        B0GggFMZc86zPEtkavDZchqOkg==
X-Google-Smtp-Source: APiQypIyNcuFloIZ3Kpb1PoSspwoVMlg7ujNFsD0/3jv7Pkd7waV6IPMavxHd+yj90Bqk0Htn6n38g==
X-Received: by 2002:a17:90b:297:: with SMTP id az23mr7357140pjb.85.1587751353096;
        Fri, 24 Apr 2020 11:02:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w30sm6418630pfj.25.2020.04.24.11.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:02:32 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:02:31 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] interconnect: Add of_icc_get_by_index() helper
 function
Message-ID: <20200424180231.GN199755@google.com>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-4-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424155404.10746-4-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 06:54:00PM +0300, Georgi Djakov wrote:
> This is the same as the traditional of_icc_get() function, but the
> difference is that it takes index as an argument, instead of name.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Addressed review comments from Sibi.
> * Re-based patch.
> 
> v2: https://lore.kernel.org/r/20190423132823.7915-3-georgi.djakov@linaro.org
> 
>  drivers/interconnect/core.c  | 68 +++++++++++++++++++++++++++---------
>  include/linux/interconnect.h |  6 ++++
>  2 files changed, 58 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 2c6515e3ecf1..648237f4de49 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -351,9 +351,9 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>  }
>  
>  /**
> - * of_icc_get() - get a path handle from a DT node based on name
> + * of_icc_get_by_index() - get a path handle from a DT node based on index
>   * @dev: device pointer for the consumer device
> - * @name: interconnect path name
> + * @idx: interconnect path index
>   *
>   * This function will search for a path between two endpoints and return an
>   * icc_path handle on success. Use icc_put() to release constraints when they
> @@ -365,13 +365,12 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>   * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
>   * when the API is disabled or the "interconnects" DT property is missing.
>   */
> -struct icc_path *of_icc_get(struct device *dev, const char *name)
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>  {
>  	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);

nit: initialization is not needed. According to the diff this is existing
code, but since we are adding a new function we can as well 'fix' it :)

>  	struct icc_node *src_node, *dst_node;
>  	struct device_node *np = NULL;

ditto

>  	struct of_phandle_args src_args, dst_args;
> -	int idx = 0;
>  	int ret;
>  
>  	if (!dev || !dev->of_node)
> @@ -391,12 +390,6 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  	 * lets support only global ids and extend this in the future if needed
>  	 * without breaking DT compatibility.
>  	 */
> -	if (name) {
> -		idx = of_property_match_string(np, "interconnect-names", name);
> -		if (idx < 0)
> -			return ERR_PTR(idx);
> -	}
> -
>  	ret = of_parse_phandle_with_args(np, "interconnects",
>  					 "#interconnect-cells", idx * 2,
>  					 &src_args);
> @@ -439,12 +432,8 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  		return path;
>  	}
>  
> -	if (name)
> -		path->name = kstrdup_const(name, GFP_KERNEL);
> -	else
> -		path->name = kasprintf(GFP_KERNEL, "%s-%s",
> -				       src_node->name, dst_node->name);
> -
> +	path->name = kasprintf(GFP_KERNEL, "%s-%s",
> +			       src_node->name, dst_node->name);
>  	if (!path->name) {
>  		kfree(path);
>  		return ERR_PTR(-ENOMEM);
> @@ -452,6 +441,53 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  
>  	return path;
>  }
> +EXPORT_SYMBOL_GPL(of_icc_get_by_index);
> +
> +/**
> + * of_icc_get() - get a path handle from a DT node based on name
> + * @dev: device pointer for the consumer device
> + * @name: interconnect path name
> + *
> + * This function will search for a path between two endpoints and return an
> + * icc_path handle on success. Use icc_put() to release constraints when they
> + * are not needed anymore.
> + * If the interconnect API is disabled, NULL is returned and the consumer
> + * drivers will still build. Drivers are free to handle this specifically,
> + * but they don't have to.
> + *
> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
> + * when the API is disabled or the "interconnects" DT property is missing.
> + */
> +struct icc_path *of_icc_get(struct device *dev, const char *name)
> +{
> +	struct device_node *np = NULL;

nit: initialization is not needed

> +	int idx = 0;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	np = dev->of_node;
> +
> +	/*
> +	 * When the consumer DT node do not have "interconnects" property
> +	 * return a NULL path to skip setting constraints.
> +	 */
> +	if (!of_find_property(np, "interconnects", NULL))
> +		return NULL;
> +
> +	/*
> +	 * We use a combination of phandle and specifier for endpoint. For now
> +	 * lets support only global ids and extend this in the future if needed
> +	 * without breaking DT compatibility.
> +	 */
> +	if (name) {
> +		idx = of_property_match_string(np, "interconnect-names", name);
> +		if (idx < 0)
> +			return ERR_PTR(idx);
> +	}
> +
> +	return of_icc_get_by_index(dev, idx);
> +}
>  EXPORT_SYMBOL_GPL(of_icc_get);
>  
>  /**
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index d70a914cba11..34e97231a6ab 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -28,6 +28,7 @@ struct device;
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>  			 const int dst_id);
>  struct icc_path *of_icc_get(struct device *dev, const char *name);
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
>  void icc_put(struct icc_path *path);
>  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>  void icc_set_tag(struct icc_path *path, u32 tag);
> @@ -46,6 +47,11 @@ static inline struct icc_path *of_icc_get(struct device *dev,
>  	return NULL;
>  }
>  
> +static inline struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
> +{
> +	return NULL;
> +}
> +
>  static inline void icc_put(struct icc_path *path)
>  {
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
