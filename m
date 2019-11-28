Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9285410CE44
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK1SEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 13:04:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39571 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfK1SEp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 13:04:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so13450602pfo.6
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7WR19E/C6KkUqMFZAvG+Z+zuBVe2Xi4AcMl38HlB4k0=;
        b=hSLENg5/FkDiRrhdvVHDRrVgbmdL6RFAttfMpXc+ucFawGeUXpNTsX7FYgcpDEXzTe
         IZxTdPMWhPunxAS8xVO4HD980ktimPe9JlH0Q+OItw7e2H7nOTiHjCms3/xaAkKJClVb
         +aax3AkSYi5Fl62rXhHbOHOcD+9A8vyv9vcuRE+F+nJu1DacwmE2+YmYYXov17e+M1bG
         fxdQOICNNWkF8dXK29LQ5nqtBOaj/IAC9xkzpGTCC6Uq0I54BmbkJzXM5tasFQn7jIij
         CsNUxgA4xaUfGGm2rpKLoqNGO/0OJ1VPwo3Rs7jvwqBW8twgBRjjL5z+NR1FtVxJNG03
         4xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7WR19E/C6KkUqMFZAvG+Z+zuBVe2Xi4AcMl38HlB4k0=;
        b=nL45pLuplKBWCt4M906WgTGvZvEEH675PYS9TkJBv3RVHxp7Mrp0ypdSJQ/vZKOKap
         WCtS19ipVxr7M5lgpd048An2uTj/hF9XEGzo08WzfymfPMoog9Sjjdmsq9umHwIH1E4G
         89XxgAjVxcuDI8P9PqQ3cZpH9yfsJr1r0FHqPtyVUmb3XnngPiC+2A2j025KZIskScax
         qO+xzhQQW8Wp/PkxziwcL6NW3tk3OoDbzP0CIXEiNeQAMVmeMyd0BANPrdBvgeBSPHz8
         0huUNnl1X+ujo+HCEvUIGOdtqyfhd2k4KjqLWY+0xLZC3/hlX4DcuK2OQynUr9yw/fWY
         uURA==
X-Gm-Message-State: APjAAAVjou7Gusoe5pqx4xrZFa+IhM7H17DP1rODEiuJ2haUVw/AwU8j
        CKGiPLP4c6sGM+egTiSXc+qVa6OWH6I=
X-Google-Smtp-Source: APXvYqzXcW+Yzboa1LhzXrpgCHm/FdBtEFq/0jb8aDUd3iLEpVOwa1rAvLUx2r8f8BJhsogfIYHK8w==
X-Received: by 2002:a63:c0a:: with SMTP id b10mr12875299pgl.168.1574964284236;
        Thu, 28 Nov 2019 10:04:44 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b24sm20967113pfi.148.2019.11.28.10.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 10:04:43 -0800 (PST)
Date:   Thu, 28 Nov 2019 10:04:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] interconnect: Add a name to struct icc_path
Message-ID: <20191128180441.GF82109@yoga>
References: <20191128141818.32168-1-georgi.djakov@linaro.org>
 <20191128141818.32168-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128141818.32168-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 28 Nov 06:18 PST 2019, Georgi Djakov wrote:

> When debugging interconnect things, it turned out that saving the path
> name and including it in the traces is quite useful, especially for
> devices with multiple paths.
> 
> For the path name we use the one specified in DT, or if we use platform
> data, the name is based on the source and destination node names.
> 
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c     | 18 +++++++++++++++---
>  drivers/interconnect/internal.h |  2 ++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index f30a326dc7ce..c9e16bc1331e 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -356,9 +356,17 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  
>  	mutex_lock(&icc_lock);
>  	path = path_find(dev, src_node, dst_node);
> -	if (IS_ERR(path))
> -		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>  	mutex_unlock(&icc_lock);
> +	if (IS_ERR(path)) {
> +		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +		return path;
> +	}
> +
> +	if (name)
> +		path->name = kstrdup(name, GFP_KERNEL);

path->name is declared as const and name is likely to be rodata, so
using kstrdup_const() here instead have a good chance of avoiding an
unnecessary allocation.

> +	else
> +		path->name = kasprintf(GFP_KERNEL, "%s-%s",
> +				       src_node->name, dst_node->name);
>  
>  	return path;
>  }
> @@ -481,9 +489,12 @@ struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
>  		goto out;
>  
>  	path = path_find(dev, src, dst);
> -	if (IS_ERR(path))
> +	if (IS_ERR(path)) {
>  		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +		goto out;
> +	}
>  
> +	path->name = kasprintf(GFP_KERNEL, "%s-%s", src->name, dst->name);
>  out:
>  	mutex_unlock(&icc_lock);
>  	return path;
> @@ -519,6 +530,7 @@ void icc_put(struct icc_path *path)
>  	}
>  	mutex_unlock(&icc_lock);
>  
> +	kfree(path->name);

And then kfree_const() here (which will handle both the rodata and
dynamically allocated case).


Apart from this I think the patch looks good.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  	kfree(path);
>  }
>  EXPORT_SYMBOL_GPL(icc_put);
> diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
> index 5853e8faf223..bf18cb7239df 100644
> --- a/drivers/interconnect/internal.h
> +++ b/drivers/interconnect/internal.h
> @@ -29,10 +29,12 @@ struct icc_req {
>  
>  /**
>   * struct icc_path - interconnect path structure
> + * @name: a string name of the path (useful for ftrace)
>   * @num_nodes: number of hops (nodes)
>   * @reqs: array of the requests applicable to this path of nodes
>   */
>  struct icc_path {
> +	const char *name;
>  	size_t num_nodes;
>  	struct icc_req reqs[];
>  };
