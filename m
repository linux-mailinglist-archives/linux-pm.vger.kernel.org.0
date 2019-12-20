Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADDE128292
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 20:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTTEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 14:04:30 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55645 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfLTTEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 14:04:30 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so4501959pjz.5
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qGjb7eWoCkZSqsMkOMbh0emAlLhfNF+XZ0Dr2/fwtoA=;
        b=TGomQ9fFTiqX2VOyWk437Wi8Jo5ypgF7XDqRU+xa96kpKduPCd6PaJsmUCnNrz/wXX
         FRHkyWn2qIhKM5nIuGM3ctTolrpcNhhMNYuzDl1kzW6UBYupI8DnJVGdEEcAFeDXFtP6
         T1qCJwjEc31LWZWPuiPQJOr/mLInHC+UXSLY7rBWrdZc8eQ1NRIu1Uugog/4KhfwJ58u
         akT5RL2PCWMxASEyobnHn9/hOxXoIn2SLvJR3RMadPTP9QpyQNllsZ/A03FW0fkHqRCu
         SzSihvCIAzAWnH0m3XlMZskEUM+Ced6YWCQSrbrOc6fUva4ICP3C6/z5a+PtTW2By8wr
         KavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qGjb7eWoCkZSqsMkOMbh0emAlLhfNF+XZ0Dr2/fwtoA=;
        b=m71q7QYwLpiGcnTdNKKQH/bi9nyttL1yF63moWHkImjwBLMEcJndwwX0ASwfpuasI7
         ysQZc8RhASHai9+oIc6Y6ZWwB6xVN+7LVMDRB882UeSzY0npU7/+tySiYO1/ijcD8fQn
         6XA0/A8tXskVw7S5ZqZRue5+LQVvyapSB33I4VnGh9UDLakSAnQjPZ0LIZA3oj4eBcRG
         yhwecfAgf78r0LrD1ZxEnGUHV3S1nhpshkBosD15AQw/mnw/dZpHDrBglvxgy2ZWowEd
         GLWcXsEbc+ZCTNVj9ZUFfnn7x1BqtmPFtOQI/rEwSqHpwIXX5/A1FuqsR7jB5uBZYVEJ
         D+cw==
X-Gm-Message-State: APjAAAUpsr5OB7YOgQeGP4WgHFtBU2L5rTMLiu5xHvaCUjdYeN4UXZ9U
        cQwlkpaKlR+O4pJnkJ7ppUil8Q==
X-Google-Smtp-Source: APXvYqzj/ieFQoyLUA0Oa0WPwtOBqCvbXDqpN+HBNirj9Qp2WbSOWzuFCEJ2uvBjwxdDq5q2WV103Q==
X-Received: by 2002:a17:902:7c0d:: with SMTP id x13mr16807903pll.85.1576868669546;
        Fri, 20 Dec 2019 11:04:29 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m22sm13172633pgn.8.2019.12.20.11.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 11:04:28 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:04:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Check for valid path in icc_set_bw()
Message-ID: <20191220190426.GE549437@yoga>
References: <20191220171310.24169-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220171310.24169-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 20 Dec 09:13 PST 2019, Georgi Djakov wrote:

> Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 63c164264b73..14a6f7ade44a 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -498,6 +498,11 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  	if (!path || !path->num_nodes)
>  		return 0;
>  
> +	if (IS_ERR(path)) {

This is a sign of a logical error, and the print is likely to be
ignored/lost in the noise. So I think the response should aid to help
the developer hitting this to resolve the issue.

So I think this is more visible and more useful as:

	if (WARN_ON(IS_ERR(path)))
		return -EINVAL;


PS. Doesn't path->num_nodes == 0 fall in this category as well? When
would you have a path object with no nodes passed to this function?

Regards,
Bjorn

> +		pr_err("%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +		return -EINVAL;
> +	}
> +
>  	mutex_lock(&icc_lock);
>  
>  	old_avg = path->reqs[0].avg_bw;
