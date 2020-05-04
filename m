Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917371C4877
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEDUkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:40:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49218 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgEDUkj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:40:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588624837; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fLYIM9kqqwdLGMsIsdcSwPKcC0oxxXbjzB2POxGFLMk=;
 b=NMhdK6K3GZsMg27eE5aZeBwe2AlaPuaHuKAZRFfFpVGBWtCxvrMVdbDbYDXsnYmX7vX621fX
 iMWLu6vLRYta8ETaePjUk97oxZ6TdkxWpn9kGav3kz3Qubvl0ER9r9tA+5KFQP2t9rAOvI3S
 reNvgz3aQ6xob5DgOCZ0rYMXzxU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb07db5.7f04b837b650-smtp-out-n04;
 Mon, 04 May 2020 20:40:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E25CFC433F2; Mon,  4 May 2020 20:40:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38301C433BA;
        Mon,  4 May 2020 20:40:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 02:10:18 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v7 2/7] OPP: Add helpers for reading the binding
 properties
In-Reply-To: <20200424155404.10746-3-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-3-georgi.djakov@linaro.org>
Message-ID: <cbba1156b96e2cef39a2ea596fd5b911@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-24 21:23, Georgi Djakov wrote:
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
> * Extracted just the helpers from patch v6, as Viresh advised to split 
> it.
> 
> v6: 
> https://lore.kernel.org/r/20191207002424.201796-3-saravanak@google.com
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
> @@ -1272,11 +1272,21 @@ static bool
> _opp_supported_by_regulators(struct dev_pm_opp *opp,
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
>  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp 
> *new_opp,
>  			     struct opp_table *opp_table,
>  			     struct list_head **head)
>  {
>  	struct dev_pm_opp *opp;
> +	int opp_cmp;
> 
>  	/*
>  	 * Insert new OPP in order of increasing frequency and discard if
> @@ -1287,12 +1297,13 @@ static int _opp_is_duplicate(struct device
> *dev, struct dev_pm_opp *new_opp,
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
> @@ -521,6 +521,28 @@ void dev_pm_opp_of_remove_table(struct device 
> *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> 
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct 
> device_node *np,
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
> +	*rate_not_available = !!ret;
> +
> +	of_property_read_u32(np, "opp-level", &new_opp->level);
> +
> +	return ret;
> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT 
> bindings)
>   * @opp_table:	OPP table
> @@ -558,26 +580,14 @@ static struct dev_pm_opp
> *_opp_add_static_v2(struct opp_table *opp_table,
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

With ^^ regression fixed

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

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
>  	/* Check if the OPP supports hardware's hierarchy of versions or not 
> */
>  	if (!_opp_is_supported(dev, opp_table, np)) {
>  		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index d14e27102730..bcadb1e328a4 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -211,6 +211,7 @@ struct opp_device *_add_opp_dev(const struct
> device *dev, struct opp_table *opp_
>  void _dev_pm_opp_find_and_remove_table(struct device *dev);
>  struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
>  void _opp_free(struct dev_pm_opp *opp);
> +int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp 
> *opp2);
>  int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct
> opp_table *opp_table, bool rate_not_available);
>  int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
> unsigned long freq, long u_volt, bool dynamic);
>  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask,
> int last_cpu);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
