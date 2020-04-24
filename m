Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17771B7CCF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDXRa4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXRaz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 13:30:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D348C09B047
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:30:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o15so4946220pgi.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jxQ8elL9oTsA1NUkcs5HG5rFNzWtMf8feEeEKLroBpM=;
        b=TCtJAgMQT95iFkEQPw1m6S4q/wKXR+ESPYHJlQBF4aMLDIdDPB1bFDtxQzydu2xn1E
         8X3C1VwUl0ArjSYo4yVp4Ik6KDGjnzDIZnagt/qGFAyzE2oz2gmZYaQE5hwiwQDISuM8
         kSsKH2sYASdgah/mc7ioQVEnr/0tctnDaKEJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxQ8elL9oTsA1NUkcs5HG5rFNzWtMf8feEeEKLroBpM=;
        b=HoNcuQ9ibGsPiRfresFgjXOzqwYrjXK6MskbvAgNou/vJ+LjCVngvBOd+hL3G74sY+
         Ni4Pz4ZsPRJEzYF9PlB/+E9xbB0f8s5qD85Sm8c4USqSb1NYIJbX5MIdF60/CF5lpkPR
         gwaP3Xk/p/7fkDBb7N8gFl6Valrl7M4kjsoyBUY5DYctE5aN7X51rKQQRSnHUqT40KKn
         SKMR5t8HE9qSrRdQuKrhjj7gbCh+BMdE3k70oQqCxKqnYqxJNzVtqD3xHZXaUrrqQrbM
         ZOypYD4aTy8KP67l92b1a4Mg2jj+Z6bPI8uJBCwXGH6yuPTfP1a7HCYZDijJxi9WGoyA
         /xJA==
X-Gm-Message-State: AGi0PuYDAu17NOt7P/PpIVVoNMY+N6fp/+klrK4goc5fjXSQN/jIvobL
        m8aIWEeilz3qhPUabnzg0D0CMw==
X-Google-Smtp-Source: APiQypKMaJvLwe6n1BNgpS64mzJBMrKpe2R9tf6Zzhojfpo6LdCmdkttps3QolrVaPtlZd5sHByWcA==
X-Received: by 2002:a63:602:: with SMTP id 2mr10234391pgg.383.1587749453988;
        Fri, 24 Apr 2020 10:30:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w3sm6176961pfn.115.2020.04.24.10.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:30:53 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:30:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] OPP: Add helpers for reading the binding
 properties
Message-ID: <20200424173052.GM199755@google.com>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424155404.10746-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On Fri, Apr 24, 2020 at 06:53:59PM +0300, Georgi Djakov wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> The opp-hz DT property is not mandatory and we may use another property
> as a key in the OPP table. Add helper functions to simplify the reading
> and comparing the keys.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Extracted just the helpers from patch v6, as Viresh advised to split it.
> 
> v6: https://lore.kernel.org/r/20191207002424.201796-3-saravanak@google.com
> 
>  drivers/opp/core.c | 15 +++++++++++++--
>  drivers/opp/of.c   | 42 ++++++++++++++++++++++++++----------------
>  drivers/opp/opp.h  |  1 +
>  3 files changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index ba43e6a3dc0a..c9c1bbe6ae27 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1272,11 +1272,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
>  	return true;
>  }
>  
> +int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> +{
> +	if (opp1->rate != opp2->rate)
> +		return opp1->rate < opp2->rate ? -1 : 1;
> +	if (opp1->level != opp2->level)
> +		return opp1->level < opp2->level ? -1 : 1;
> +	return 0;
> +}
> +
>  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
>  			     struct opp_table *opp_table,
>  			     struct list_head **head)
>  {
>  	struct dev_pm_opp *opp;
> +	int opp_cmp;
>  
>  	/*
>  	 * Insert new OPP in order of increasing frequency and discard if
> @@ -1287,12 +1297,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
>  	 * loop.
>  	 */
>  	list_for_each_entry(opp, &opp_table->opp_list, node) {
> -		if (new_opp->rate > opp->rate) {
> +		opp_cmp = _opp_compare_key(new_opp, opp);
> +		if (opp_cmp > 0) {
>  			*head = &opp->node;
>  			continue;
>  		}
>  
> -		if (new_opp->rate < opp->rate)
> +		if (opp_cmp < 0)
>  			return 0;
>  
>  		/* Duplicate OPPs */
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 9cd8f0adacae..e33169c7e045 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -521,6 +521,28 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
> +			 bool *rate_not_available)
> +{
> +	u64 rate;
> +	int ret;
> +
> +	ret = of_property_read_u64(np, "opp-hz", &rate);
> +	if (!ret) {
> +		/*
> +		 * Rate is defined as an unsigned long in clk API, and so
> +		 * casting explicitly to its type. Must be fixed once rate is 64
> +		 * bit guaranteed in clk API.
> +		 */
> +		new_opp->rate = (unsigned long)rate;
> +	}

nit: curly braces are not needed

> +	*rate_not_available = !!ret;
> +
> +	of_property_read_u32(np, "opp-level", &new_opp->level);
> +
> +	return ret;
> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
>   * @opp_table:	OPP table
> @@ -558,26 +580,14 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (!new_opp)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = of_property_read_u64(np, "opp-hz", &rate);
> +	ret = _read_opp_key(new_opp, np, &rate_not_available);
>  	if (ret < 0) {
> -		/* "opp-hz" is optional for devices like power domains. */
> -		if (!opp_table->is_genpd) {
> -			dev_err(dev, "%s: opp-hz not found\n", __func__);
> -			goto free_opp;
> -		}
> +		if (!opp_table->is_genpd)
> +			dev_err(dev, "%s: opp key field not found\n", __func__);
>  
> -		rate_not_available = true;
> -	} else {
> -		/*
> -		 * Rate is defined as an unsigned long in clk API, and so
> -		 * casting explicitly to its type. Must be fixed once rate is 64
> -		 * bit guaranteed in clk API.
> -		 */
> -		new_opp->rate = (unsigned long)rate;
> +		goto free_opp;
>  	}
>  
> -	of_property_read_u32(np, "opp-level", &new_opp->level);
> -
>  	/* Check if the OPP supports hardware's hierarchy of versions or not */
>  	if (!_opp_is_supported(dev, opp_table, np)) {
>  		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index d14e27102730..bcadb1e328a4 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -211,6 +211,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
>  void _dev_pm_opp_find_and_remove_table(struct device *dev);
>  struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
>  void _opp_free(struct dev_pm_opp *opp);
> +int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
>  int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
>  int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
>  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
