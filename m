Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED43A22EA6A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgG0Kv7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 06:51:59 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:18501 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728332AbgG0Kv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 06:51:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595847118; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ot+sszGgKz5/ItpDLIHFFfApINZtJ7SHjN4haXIg1Js=;
 b=u6C/4tIJnTrB2+sYXZo0NbuxvjG2bXdu8EElBrgvf855vtQ7IA8SUYotDULpf5qRfmw+tFb/
 zqMo84Z+dFo8N+wg74onPYXO+JgExV5k2II/aBsnANwhNDQR0mVZkR1Lq8QxpNUeloGSDRMI
 A+RDCHjW8TinQ8udYH8HUc/gHmQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f1eb1cda19b5f4b113100c4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 10:51:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 737BDC43391; Mon, 27 Jul 2020 10:51:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E6F1C433C6;
        Mon, 27 Jul 2020 10:51:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jul 2020 16:21:56 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] interconnect: Introduce xlate_extended() callback
In-Reply-To: <20200723130942.28491-2-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-2-georgi.djakov@linaro.org>
Message-ID: <62ffca1e81c59131ba5e5c040e6b3cbc@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Georgi,

Thanks for the patch!

On 2020-07-23 18:39, Georgi Djakov wrote:
> Currently there is the xlate() callback, which is provider-specific is

nit: currently xlate callback isn't
provider specific.

> used for mapping the nodes from phandle arguments. This is fine for 
> simple
> mappings, but the phandle arguments could contain an additional data, 
> such
> as tag information. Let's create another callback xlate_extended() for 
> the
> cases where providers want also populate the tagging data.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> ---
>  drivers/interconnect/core.c           | 73 ++++++++++++++++++---------
>  include/linux/interconnect-provider.h | 17 ++++++-
>  2 files changed, 65 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index befd111049c0..6ccf55818e68 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -336,12 +336,13 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
>   * Looks for interconnect provider under the node specified by @spec 
> and if
>   * found, uses xlate function of the provider to map phandle args to 
> node.
>   *
> - * Returns a valid pointer to struct icc_node on success or ERR_PTR()
> + * Returns a valid pointer to struct icc_node_data on success or 
> ERR_PTR()
>   * on failure.
>   */
> -struct icc_node *of_icc_get_from_provider(struct of_phandle_args 
> *spec)
> +struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args 
> *spec)
>  {
>  	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
> +	struct icc_node_data *data = NULL;
>  	struct icc_provider *provider;
> 
>  	if (!spec)
> @@ -349,14 +350,33 @@ struct icc_node *of_icc_get_from_provider(struct
> of_phandle_args *spec)
> 
>  	mutex_lock(&icc_lock);
>  	list_for_each_entry(provider, &icc_providers, provider_list) {
> -		if (provider->dev->of_node == spec->np)
> -			node = provider->xlate(spec, provider->data);
> -		if (!IS_ERR(node))
> -			break;
> +		if (provider->dev->of_node == spec->np) {
> +			if (provider->xlate_extended) {
> +				data = provider->xlate_extended(spec, provider->data);
> +				if (!IS_ERR(data)) {
> +					node = data->node;
> +					break;
> +				}
> +			} else {
> +				node = provider->xlate(spec, provider->data);
> +				if (!IS_ERR(node))
> +					break;
> +			}
> +		}
>  	}
>  	mutex_unlock(&icc_lock);
> 
> -	return node;
> +	if (IS_ERR(node))
> +		return ERR_CAST(node);
> +
> +	if (!data) {
> +		data = kzalloc(sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			return ERR_PTR(-ENOMEM);
> +		data->node = node;
> +	}
> +
> +	return data;
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
> 
> @@ -403,7 +423,7 @@ EXPORT_SYMBOL_GPL(devm_of_icc_get);
>  struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>  {
>  	struct icc_path *path;
> -	struct icc_node *src_node, *dst_node;
> +	struct icc_node_data *src_data, *dst_data;
>  	struct device_node *np;
>  	struct of_phandle_args src_args, dst_args;
>  	int ret;
> @@ -441,39 +461,46 @@ struct icc_path *of_icc_get_by_index(struct
> device *dev, int idx)
> 
>  	of_node_put(dst_args.np);
> 
> -	src_node = of_icc_get_from_provider(&src_args);
> +	src_data = of_icc_get_from_provider(&src_args);
> 
> -	if (IS_ERR(src_node)) {
> -		if (PTR_ERR(src_node) != -EPROBE_DEFER)
> +	if (IS_ERR(src_data)) {
> +		if (PTR_ERR(src_data) != -EPROBE_DEFER)
>  			dev_err(dev, "error finding src node: %ld\n",
> -				PTR_ERR(src_node));
> -		return ERR_CAST(src_node);
> +				PTR_ERR(src_data));
> +		return ERR_CAST(src_data);
>  	}
> 
> -	dst_node = of_icc_get_from_provider(&dst_args);
> +	dst_data = of_icc_get_from_provider(&dst_args);
> 
> -	if (IS_ERR(dst_node)) {
> -		if (PTR_ERR(dst_node) != -EPROBE_DEFER)
> +	if (IS_ERR(dst_data)) {
> +		if (PTR_ERR(dst_data) != -EPROBE_DEFER)
>  			dev_err(dev, "error finding dst node: %ld\n",
> -				PTR_ERR(dst_node));
> -		return ERR_CAST(dst_node);
> +				PTR_ERR(dst_data));
> +		kfree(src_data);
> +		return ERR_CAST(dst_data);
>  	}
> 
>  	mutex_lock(&icc_lock);
> -	path = path_find(dev, src_node, dst_node);
> +	path = path_find(dev, src_data->node, dst_data->node);
>  	mutex_unlock(&icc_lock);
>  	if (IS_ERR(path)) {
>  		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> -		return path;
> +		goto free_icc_data;
>  	}
> 
> +	if (src_data->tag && src_data->tag == dst_data->tag)
> +		icc_set_tag(path, src_data->tag);
> +
>  	path->name = kasprintf(GFP_KERNEL, "%s-%s",
> -			       src_node->name, dst_node->name);
> +			       src_data->node->name, dst_data->node->name);
>  	if (!path->name) {
>  		kfree(path);
> -		return ERR_PTR(-ENOMEM);
> +		path = ERR_PTR(-ENOMEM);
>  	}
> 
> +free_icc_data:
> +	kfree(src_data);
> +	kfree(dst_data);
>  	return path;
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get_by_index);
> @@ -975,7 +1002,7 @@ int icc_provider_add(struct icc_provider 
> *provider)
>  {
>  	if (WARN_ON(!provider->set))
>  		return -EINVAL;
> -	if (WARN_ON(!provider->xlate))
> +	if (WARN_ON(!provider->xlate && !provider->xlate_extended))
>  		return -EINVAL;
> 
>  	mutex_lock(&icc_lock);
> diff --git a/include/linux/interconnect-provider.h
> b/include/linux/interconnect-provider.h
> index 4735518de515..4d535fddd5d3 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -14,6 +14,17 @@
>  struct icc_node;
>  struct of_phandle_args;
> 
> +/**
> + * struct icc_node_data - icc node data
> + *
> + * @node: icc node
> + * @tag: tag
> + */
> +struct icc_node_data {
> +	struct icc_node *node;
> +	u32 tag;
> +};
> +
>  /**
>   * struct icc_onecell_data - driver data for onecell interconnect 
> providers
>   *
> @@ -39,6 +50,7 @@ struct icc_node *of_icc_xlate_onecell(struct
> of_phandle_args *spec,
>   * @pre_aggregate: pointer to device specific function that is called
>   *		   before the aggregation begins (optional)
>   * @xlate: provider-specific callback for mapping nodes from phandle 
> arguments
> + * @xlate_extended: vendor-specific callback for mapping node data
> from phandle arguments
>   * @dev: the device this interconnect provider belongs to
>   * @users: count of active users
>   * @inter_set: whether inter-provider pairs will be configured with 
> @set
> @@ -52,6 +64,7 @@ struct icc_provider {
>  			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>  	void (*pre_aggregate)(struct icc_node *node);
>  	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
> +	struct icc_node_data* (*xlate_extended)(struct of_phandle_args
> *spec, void *data);
>  	struct device		*dev;
>  	int			users;
>  	bool			inter_set;
> @@ -105,7 +118,7 @@ void icc_node_del(struct icc_node *node);
>  int icc_nodes_remove(struct icc_provider *provider);
>  int icc_provider_add(struct icc_provider *provider);
>  int icc_provider_del(struct icc_provider *provider);
> -struct icc_node *of_icc_get_from_provider(struct of_phandle_args 
> *spec);
> +struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args 
> *spec);
> 
>  #else
> 
> @@ -157,7 +170,7 @@ static inline int icc_provider_del(struct
> icc_provider *provider)
>  	return -ENOTSUPP;
>  }
> 
> -static inline struct icc_node *of_icc_get_from_provider(struct
> of_phandle_args *spec)
> +static inline struct icc_node_data *of_icc_get_from_provider(struct
> of_phandle_args *spec)
>  {
>  	return ERR_PTR(-ENOTSUPP);
>  }

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
