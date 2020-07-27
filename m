Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6022F6E0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 19:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgG0Rlx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgG0Rlx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 13:41:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25DC0619D2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 10:41:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e22so2847003pjt.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=anIhz+sUWSZj2LLbB+V68VzBj1HjbcN4RzXAFjEj7pk=;
        b=A53/TAW3iJzAqM3UVSdj8n8yLACsMpMkFdUpHx7hdCQwG5BdtaS1xgwPMV27wBQGBX
         ezA9FGjP8KpBIMFbq6O1w6hZ5uE9zlro/tDge9V3CGS8LA+F3KYOrKBXfNOBqsZ0N4op
         Pnnt/7hiVk3as30/qnaqFkpxDj/Jth8sa2E98wzqaMrUnSHN6g9WHuFTrpjPorz0dF1w
         uUZh5BYXRB6CQu8wdCgc/AYY1B+S4ZZSoz2LbWiJPBXSOxpMlGafLRIqQfP+VdgdMYgM
         LufmOjVkc9jvN82+yXkl2ir4gO2HOOlSAWkfzpkioWoj8YS+kQePQp3n+03q9SMhyNE/
         Qesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anIhz+sUWSZj2LLbB+V68VzBj1HjbcN4RzXAFjEj7pk=;
        b=nsp8hNRAaTcNZaQsG7bnUR4jiIEYNb3bg8A5nFaQOOkT5k+eSQkz29AhRTXfYFA7uh
         r1hwePc9STVoqAm/rHmKvLCNYp2kbppmNiQErOZuOUL25GWL5c6G9S+hgouzIrzHUt1k
         gtQ0xBDa02og/rtOceHICDyXPaCjZkUXTpKBrRR3aeP5+wAn9CHQAtVkEborFftsYyOP
         lFAJ5Efb4lM97oal1tFfCa7JffOJRjitmaxwnOow63QE9OJs3GskIFoR7lFAz03gISgs
         PDcDLCXvcPdnkczFNQnk5ZGMmrRVORECqosqPcO0niN4AB3MbHjCWoxC79mXiVbJlh43
         5TpQ==
X-Gm-Message-State: AOAM533Nvba6xhseXcyLBFJNTF2AqnUng7A1qv5zVLTsdSyxq+LLxPrI
        bTaud2dyPY3U360nkvXG5947Lw==
X-Google-Smtp-Source: ABdhPJxonNO7C1s8c7dsZ01iiSbx7OWhiK4Kk7C7FePc4SZXpL20+c+k2aEeLh7w9nx+KMSqOYL4mg==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr19649190pls.61.1595871712379;
        Mon, 27 Jul 2020 10:41:52 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u13sm201376pjy.40.2020.07.27.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:41:51 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:38:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        akashast@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add bulk API helpers
Message-ID: <20200727173818.GE63496@builder.lan>
References: <20200528162542.30158-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528162542.30158-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 28 May 09:25 PDT 2020, Georgi Djakov wrote:
> diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
> new file mode 100644
> index 000000000000..9bd418594665
> --- /dev/null
> +++ b/drivers/interconnect/bulk.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/interconnect-provider.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +
> +/**
> + * of_icc_bulk_get - get interconnect paths

Parenthesis on the function name here, and on the other functions below.

> + * @dev: the device requesting the path
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the table with the paths we want to get
> + *
> + * Returns 0 on success or -EERROR otherwise.

s/-EERROR/negative errno/

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
> +			dev_err(dev, "of_icc_get() failed on path %s (%d)\n",
> +				paths[i].name, ret);

I think you only should print this error if ret != -EPROBE_DEFER.

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
> + * icc_bulk_put - put a list of interconnect paths
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
> + * icc_bulk_set - set bandwidth to a set of paths
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the icc_bulk_data table containing the paths and bandwidth
> + *
> + * Returns 0 on success or -EERROR otherwise.
> + */
> +int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths)
> +{
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		ret = icc_set_bw(paths[i].path, paths[i].avg_bw,
> +				 paths[i].peak_bw);

You can unwrap this line.

Regards,
Bjorn
