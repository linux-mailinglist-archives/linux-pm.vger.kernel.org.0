Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF322F9F1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgG0UT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgG0UT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 16:19:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90CC0619D4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:19:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so10571557pgq.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9vwww9/H9z0XVuIaPzgOzhMhWfDAZBEc6TFuy96OSf0=;
        b=KbbUV9FnKtOtEDcaY4l9nsErpo99ysUh7wjDRRb3BXPd7mtIwE4up4DbvPalNNaOng
         8b8r8PEI3aTiAQAVxCbTtWA+0NnFBKZupRHD5YxZLKy4ENjHNE2cymYH5BcogsjLTWWt
         pA1vf1Hv7Ai/loLQscjcKMO9lXfEolWE8Bsi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9vwww9/H9z0XVuIaPzgOzhMhWfDAZBEc6TFuy96OSf0=;
        b=CBImdUmr/qUtOBLYkKUqrjJ925Okk74E8w0x/JTONLj1bkNhoYRFVwG++b7cwqHAxC
         a907pqWV9E5brnHKSRSLcKZ8HH/1ovbv8wnTZuGPfJ4pKeGcJ3yoUIlSCnVC+iytlPGM
         lQTKL/c0SttghuBnIjSjfxP1S+DY1mJETstE8X//AFUzyFLgxL9wgbs+oTMLzw5SDPUF
         aZPWsHWftnC8em08TonPtyjg4AM3BYwvvl+vRslrdpN/JlTi7s8bMge5+6+hGL4DVF5D
         f2SeQ4+d3AUB++MAOjzNHOKFZLfCENLTz7eKtpisN0jkY9ssVt50UiGMVkS1LBB/Iqra
         d+8Q==
X-Gm-Message-State: AOAM5322aDB0qhLc15naJKfFioYPqaHnH4ku7pgOJ6+l+Qt2zaACN4AS
        xnfDxP4VPqLtHRQEOoHvkc+bFA==
X-Google-Smtp-Source: ABdhPJyJqlkAhUctdPxcxoCe8OZDXiJej7r/04cQ49MMlVxsNnANvzYpwWGdMLA/W5RogTUuuZ1xPg==
X-Received: by 2002:a63:8c4f:: with SMTP id q15mr21001301pgn.373.1595881196932;
        Mon, 27 Jul 2020 13:19:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 15sm465075pjs.8.2020.07.27.13.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:19:56 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:19:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] interconnect: qcom: Implement xlate_extended() to
 parse tags
Message-ID: <20200727201955.GF3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723130942.28491-3-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 23, 2020 at 04:09:38PM +0300, Georgi Djakov wrote:
> Implement a function to parse the arguments of the "interconnects" DT
> property and populate the interconnect path tags if this information
> is available.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 27 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/icc-rpmh.h |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 3ac5182c9ab2..44144fabec32 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -6,6 +6,8 @@
>  #include <linux/interconnect.h>
>  #include <linux/interconnect-provider.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
>  
>  #include "bcm-voter.h"
>  #include "icc-rpmh.h"
> @@ -92,6 +94,31 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_set);
>  
> +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
> +{
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	if (!spec)
> +		return ERR_PTR(-EINVAL);
> +
> +	node = of_icc_xlate_onecell(spec, data);
> +	if (IS_ERR(node))
> +		return ERR_CAST(node);
> +
> +	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> +	if (!ndata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ndata->node = node;
> +
> +	if (spec->args_count == 2)
> +		ndata->tag = spec->args[1];

Would a higher number of arguments (currently) be an error? Is so,
should it be reported?
