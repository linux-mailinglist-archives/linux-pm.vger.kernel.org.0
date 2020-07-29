Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D07232684
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2U4s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 16:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2U4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 16:56:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D2C061794
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 13:56:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so12499640pld.12
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=90mSVVj5S3skG4373m0mLWuJOCRc1yCkz2RoXhQeF5Y=;
        b=VudFFn9I3paWVLXuRcojwE/SXEoux1fjrNyTljAzwFmlC4xWbDVdaDAvk34TLdvHc8
         OEbhyqEedGXcr5jvjjpjuFGpv2+lymK+kNg9fQJmoGbLNN5kACqKZCkvKfPy39egPKyp
         KWKVoeyhLeq5pBDQoyUZIgfECZ2A9CRfzi+i2ZGe0gvH72tqSrbrfkZv8Qp5p0AJMFqB
         ZvDgZbehi8HR1liORgQuzCKgjjc0Otjs2vRvCz33G3g0poUjOiFLNeFOGHG+EyJ4rukw
         MzwSomN8GKE88X6GUVWfsthe09iBWSu+97K3dmXxBeBBWQqTfb6PcqwqTMNKi1KUfBfJ
         bMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90mSVVj5S3skG4373m0mLWuJOCRc1yCkz2RoXhQeF5Y=;
        b=T4kYt7tJs9GZI73B3jhPUq3hXKyicCgNxq5J7D4X9edxOC1m9KWodF4VWsAHvL5d1y
         c0FY00Fo8E9aorgX36jKaqFBh3bDH/LtzmmYiCJGAbgtTSWv4JjwMhyAoWDQWPZgKGXx
         OuzUFfb9no8YWoYRSNKxD575A5n3dyE2qQ/GvCpOfy4tTnrxKQKoyS/VU4PHd4D518PQ
         2oH1zA/jzcfn7wPu2N3Uso14Z25Hy2aHkWVUU79KMwVhumgZ+1QayGbYObzyh2KoEw4W
         QubSDpE6T6Dee7kvJfDOEDZzUd7tpyxFilrgC1ZgVIpNtirxCgjnhBDOMnJYe0o/h8+i
         jofw==
X-Gm-Message-State: AOAM533KUWRjfSYCjSCr2alsG3SdXNluCxcL4O+SC4HYTcQZiukT0zii
        XKPQpwhYHbC1zSl6lK/9mR8PBUr2c+k=
X-Google-Smtp-Source: ABdhPJwSf6Rw50Rz2Hf74uRDyPmfI0JiwHpSfirDdgUXiUSuOWyU+hZvyRYp4AfdbO61dwcXdFBLRA==
X-Received: by 2002:a17:902:9f82:: with SMTP id g2mr19162076plq.254.1596056207634;
        Wed, 29 Jul 2020 13:56:47 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b22sm3014939pju.26.2020.07.29.13.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 13:56:46 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:53:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        akashast@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: Add bulk API helpers
Message-ID: <20200729205318.GN229995@builder.lan>
References: <20200729123439.9961-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729123439.9961-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 29 Jul 05:34 PDT 2020, Georgi Djakov wrote:

> There are drivers which just need to get multiple interconnect paths,
> request some predefined amounts of bandwidth and then just toggle the
> paths between enabled/disabled state.
> 
> The aim of this patch is simplify the above and to allow drivers to put
> all the path names and bandwidth data into a single static icc_bulk_data
> table and call the icc_bulk_* functions on that table in order to scale
> all the interconnect paths in parallel.
> 
> Suggested-by: Evan Green <evgreen@chromium.org>
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v2:
> * Fix kernel-doc. (Bjorn)
> * Do not print EPROBE_DEFER errors. (Bjorn)
> 
> v1: https://lore.kernel.org/r/20200528162542.30158-1-georgi.djakov@linaro.org/
> 
>  drivers/interconnect/Makefile |   2 +-
>  drivers/interconnect/bulk.c   | 117 ++++++++++++++++++++++++++++++++++
>  include/linux/interconnect.h  |  22 +++++++
>  3 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/interconnect/bulk.c
> 
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 4825c287ca13..d203520b0a56 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS_core.o				:= -I$(src)
> -icc-core-objs				:= core.o
> +icc-core-objs				:= core.o bulk.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>  obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
> diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
> new file mode 100644
> index 000000000000..73e2c8d0a412
> --- /dev/null
> +++ b/drivers/interconnect/bulk.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/interconnect-provider.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +
> +/**
> + * of_icc_bulk_get() - get interconnect paths
> + * @dev: the device requesting the path
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the table with the paths we want to get
> + *
> + * Returns 0 on success or negative errno otherwise.
> + */
> +int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
> +				 struct icc_bulk_data *paths)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		paths[i].path = of_icc_get(dev, paths[i].name);
> +		if (IS_ERR(paths[i].path)) {
> +			ret = PTR_ERR(paths[i].path);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "of_icc_get() failed on path %s (%d)\n",
> +					paths[i].name, ret);
> +			paths[i].path = NULL;
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	icc_bulk_put(i, paths);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(of_icc_bulk_get);
> +
> +/**
> + * icc_bulk_put() - put a list of interconnect paths
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the icc_bulk_data table with the paths being put
> + */
> +void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
> +{
> +	while (--num_paths >= 0) {
> +		icc_put(paths[num_paths].path);
> +		paths[num_paths].path = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(icc_bulk_put);
> +
> +/**
> + * icc_bulk_set() - set bandwidth to a set of paths
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the icc_bulk_data table containing the paths and bandwidth
> + *
> + * Returns 0 on success or negative errno otherwise.
> + */
> +int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths)
> +{
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		ret = icc_set_bw(paths[i].path, paths[i].avg_bw, paths[i].peak_bw);
> +		if (ret) {
> +			pr_err("icc_set_bw() failed on path %s (%d)\n", paths[i].name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(icc_bulk_set_bw);
> +
> +/**
> + * icc_bulk_enable() - enable a previously disabled set of paths
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the icc_bulk_data table containing the paths and bandwidth
> + *
> + * Returns 0 on success or negative errno otherwise.
> + */
> +int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		ret = icc_enable(paths[i].path);
> +		if (ret) {
> +			pr_err("icc_enable() failed on path %s (%d)\n", paths[i].name, ret);
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	icc_bulk_disable(i, paths);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(icc_bulk_enable);
> +
> +/**
> + * icc_bulk_disable() - disable a set of interconnect paths
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the icc_bulk_data table containing the paths and bandwidth
> + */
> +void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
> +{
> +	while (--num_paths >= 0)
> +		icc_disable(paths[num_paths].path);
> +}
> +EXPORT_SYMBOL_GPL(icc_bulk_disable);
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 3a63d98613fc..f2dd2fc8d3cd 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -23,6 +23,28 @@
>  struct icc_path;
>  struct device;
>  
> +/**
> + * struct icc_bulk_data - Data used for bulk icc operations.
> + *
> + * @path: reference to the interconnect path (internal use)
> + * @name: the name from the "interconnect-names" DT property
> + * @avg_bw: average bandwidth in icc units
> + * @peak_bw: peak bandwidth in icc units
> + */
> +struct icc_bulk_data {
> +	struct icc_path	*path;
> +	const char *name;
> +	u32 avg_bw;
> +	u32 peak_bw;
> +};
> +
> +int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
> +				 struct icc_bulk_data *paths);
> +void icc_bulk_put(int num_paths, struct icc_bulk_data *paths);
> +int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths);
> +int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths);
> +void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
> +
>  #if IS_ENABLED(CONFIG_INTERCONNECT)
>  
>  struct icc_path *icc_get(struct device *dev, const int src_id,
