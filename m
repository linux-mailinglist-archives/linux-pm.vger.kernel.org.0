Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9B30EC33
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 06:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhBDFrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 00:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhBDFrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 00:47:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D61AC0613D6
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 21:47:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gx20so1141022pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 21:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KyojcS0OuJamrwyKsNSmnu2upiRPh0xOegZncnEILlM=;
        b=Rps3pL2i1mnueKuQdus5KbOfSZ48aSMWFXDPs/Lm8FDW42pAdWx2J+RlEODeCuoPl6
         XUnAECdOyiInABbGe6jy2qhTW8zBJWo3xk3G97wMzGER5JsimF3g9GNtz2OQ0H+M93Z+
         oQ/OalyZF76Nx2n8+hC2mO5xieOYo3uWIOEpuoB1cDz89sPeuUKDWEhPE9M8TRMwzqCx
         zAamPPHk2C0+6XJ2B22uI4InfP2rLNHt5ljw9DIk35K64jVozhRo7oeT7k9plAtfWaPP
         Pu+e6dK6V7oVuDqKZzDiZdTKbgj9YpI5599Wj8SOwgQ+wENig6y2+k/WUvKeVVJ0bub7
         Ee3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KyojcS0OuJamrwyKsNSmnu2upiRPh0xOegZncnEILlM=;
        b=gJ0E+LLStkRJkaEh7nzYT0L34gHkczrpkxHYVXTE8NHXPAjS3fOI0rckhfbh5i7q4d
         2WYDU3fP/3Z99Ce/fk7DcNEr3mEx7IVUFCkqe+icNh6zOR4xfIHnTaHlLGZEQsjEWAQp
         4q2MX0gFEwPd1PK1m5+63er56nx4cT3odGdgjiXsV9f05ZCnB6BNHYQGbi4AqLVYP3Sa
         FSTfhKUmUAfnh86vSJZ6VWXCUasbKWNIDZ9v/oRvC9MFiOJeVllLCAwTkPuaX/PdjDvy
         9tJIIEJV9Wiwr04+Uk8biooEvcMY4f03yAbR9gf7XkBW7cVd1lc4IyhX7InFQm027m3r
         Zqlw==
X-Gm-Message-State: AOAM533cBx3/O+CpgaMAf9INQn5AcbwHSWlKOKrWxgJiZrY8ZdVE4fEG
        PCVBsbucZ1qsb5lzRu/F8NhE0Q==
X-Google-Smtp-Source: ABdhPJxEz9ldCJgsznq5Y6JcqW64A2UI/RgTpTn5aXnweesuyk54aeQVELxDSPgngm59yrngRCn/kQ==
X-Received: by 2002:a17:902:b190:b029:df:fff2:c345 with SMTP id s16-20020a170902b190b02900dffff2c345mr6402458plr.17.1612417621764;
        Wed, 03 Feb 2021 21:47:01 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id z11sm4270598pfk.97.2021.02.03.21.47.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 21:47:00 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:16:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v5 1/3] OPP: Add function to look up required OPP's for a
 given OPP
Message-ID: <20210204054658.aujpukq657ziabde@vireshk-i7>
References: <20210203092400.1791884-1-hsinyi@chromium.org>
 <20210203092400.1791884-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203092400.1791884-2-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-02-21, 17:23, Hsin-Yi Wang wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> Add a function that allows looking up required OPPs given a source OPP
> table, destination OPP table and the source OPP.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/opp/core.c     | 58 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 11 ++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index dc95d29e94c1b..878f066b972cc 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2398,6 +2398,64 @@ devm_pm_opp_attach_genpd(struct device *dev, const char **names,
>  }
>  EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
>  
> +/**
> + * dev_pm_opp_xlate_required_opp() - Find required OPP for @src_table OPP.
> + * @src_table: OPP table which has @dst_table as one of its required OPP table.
> + * @dst_table: Required OPP table of the @src_table.
> + *
> + * This function returns the OPP (present in @dst_table) pointed out by the
> + * "required-opps" property of the OPP (present in @src_table).
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
> + *
> + * Return: destination table OPP on success, otherwise NULL on errors.
> + */
> +struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
> +						 struct opp_table *dst_table,
> +						 struct dev_pm_opp *src_opp)
> +{
> +	struct dev_pm_opp *opp, *dest_opp = NULL;
> +	int i;
> +
> +	if (!src_table || !dst_table || !src_opp ||
> +	    !src_table->required_opp_tables)
> +		return NULL;
> +
> +	/* required-opps not fully initialized yet */
> +	if (lazy_linking_pending(src_table))
> +		return NULL;
> +
> +	for (i = 0; i < src_table->required_opp_count; i++) {
> +		if (src_table->required_opp_tables[i] == dst_table)
> +			break;
> +	}
> +
> +	if (unlikely(i == src_table->required_opp_count)) {
> +		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> +		       __func__, src_table, dst_table);
> +		return NULL;
> +	}
> +
> +	mutex_lock(&src_table->lock);
> +
> +	list_for_each_entry(opp, &src_table->opp_list, node) {
> +		if (opp == src_opp) {
> +			dest_opp = opp->required_opps[i];
> +			dev_pm_opp_get(dest_opp);
> +			goto unlock;
> +		}
> +	}
> +
> +	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
> +	       dst_table);
> +
> +unlock:
> +	mutex_unlock(&src_table->lock);
> +
> +	return dest_opp;
> +}
> +
>  /**
>   * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
>   * @src_table: OPP table which has dst_table as one of its required OPP table.
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index ab1d15ce559db..6f5f72a7f601c 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -156,6 +156,9 @@ struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*
>  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
>  void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
>  struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
> +struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
> +						 struct opp_table *dst_table,
> +						 struct dev_pm_opp *src_opp);
>  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp);
> @@ -367,6 +370,14 @@ static inline struct opp_table *devm_pm_opp_attach_genpd(struct device *dev,
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> +static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(
> +						struct opp_table *src_table,
> +						struct opp_table *dst_table,
> +						struct dev_pm_opp *src_opp)
> +{
> +	return NULL;
> +}

Like other routines that return opp *, don't return NULL on errors but
a valid error number instead. And follow the declaration format of
other routines from this file, don't break lines etc.. 

> +
>  static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
>  {
>  	return -EOPNOTSUPP;
> -- 
> 2.30.0.365.g02bc693789-goog

-- 
viresh
