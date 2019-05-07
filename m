Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB41634A
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 14:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEGMAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 08:00:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEGMAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 08:00:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ED58A608FC; Tue,  7 May 2019 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557230443;
        bh=7LyD1gBqN0kjp5dHRT6VDikLnE48o7JdS1Yn4I9ZtHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d4OL75wRoVSb6M9pN0nitiKBWtK+cjDuY3gAHX69Gqc+Gq1NUgq5TA2NVEtd07Dbu
         6c9W7iBlO7Zpg4SXTf8DLGn9wtKfB8sxbUwCe5hPLVJn0of9yUlPVVnhhOQtwzk6JB
         /w+hp3Pc2venHHUnAJrglUin98Llgz5yshHngaAc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 107FA60128;
        Tue,  7 May 2019 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557230442;
        bh=7LyD1gBqN0kjp5dHRT6VDikLnE48o7JdS1Yn4I9ZtHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gHRJChjdfN2YS9cDmAfJRoj+16Rw/SmlOOa+CHLl13za3Qz2xq54rb6VIp8hihMnq
         vEed2Js/FrFMbKcW3iyIcHITAfhCh8WqxLDdMIzcVBgTm/v5vGRdo0OOD44ZNz2GL5
         QB08MqmFXUmSvpn0nPV2T9HsBbBAUFm5N+sXpGQA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 107FA60128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 2/5] interconnect: Add of_icc_get_by_index() helper
 function
To:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-3-georgi.djakov@linaro.org>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <e6469e3b-3653-d20b-b27d-242547a777df@codeaurora.org>
Date:   Tue, 7 May 2019 17:29:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423132823.7915-3-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Georgi,

On 4/23/19 6:58 PM, Georgi Djakov wrote:
> This is the same as the traditional of_icc_get() function, but the
> difference is that it takes index as an argument, instead of name.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/core.c  | 45 ++++++++++++++++++++++++++++--------
>   include/linux/interconnect.h |  6 +++++
>   2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 871eb4bc4efc..a7c3c262c974 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -295,9 +295,9 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>   }
>   
>   /**
> - * of_icc_get() - get a path handle from a DT node based on name
> + * of_icc_get_by_index() - get a path handle from a DT node based on index
>    * @dev: device pointer for the consumer device
> - * @name: interconnect path name
> + * @idx: interconnect path index
>    *
>    * This function will search for a path between two endpoints and return an
>    * icc_path handle on success. Use icc_put() to release constraints when they
> @@ -309,13 +309,12 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>    * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
>    * when the API is disabled or the "interconnects" DT property is missing.
>    */
> -struct icc_path *of_icc_get(struct device *dev, const char *name)
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>   {
>   	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>   	struct icc_node *src_node, *dst_node;
>   	struct device_node *np = NULL;
>   	struct of_phandle_args src_args, dst_args;
> -	int idx = 0;
>   	int ret;
>   
>   	if (!dev || !dev->of_node)
> @@ -335,12 +334,6 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>   	 * lets support only global ids and extend this in the future if needed
>   	 * without breaking DT compatibility.
>   	 */
> -	if (name) {
> -		idx = of_property_match_string(np, "interconnect-names", name);
> -		if (idx < 0)
> -			return ERR_PTR(idx);
> -	}
> -
>   	ret = of_parse_phandle_with_args(np, "interconnects",
>   					 "#interconnect-cells", idx * 2,
>   					 &src_args);
> @@ -383,6 +376,38 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>   
>   	return path;
>   }
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
> +	int idx = 0;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (name) {
> +		idx = of_property_match_string(dev->of_node,
> +					       "interconnect-names", name);
> +		if (idx < 0)
> +			return ERR_PTR(idx);
> +	}
> +
> +	return of_icc_get_by_index(dev, idx);
> +}
>   EXPORT_SYMBOL_GPL(of_icc_get);
>   
>   /**
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index dc25864755ba..0e430b3b6519 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -28,6 +28,7 @@ struct device;
>   struct icc_path *icc_get(struct device *dev, const int src_id,
>   			 const int dst_id);
>   struct icc_path *of_icc_get(struct device *dev, const char *name);
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
>   void icc_put(struct icc_path *path);
>   int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>   
> @@ -45,6 +46,11 @@ static inline struct icc_path *of_icc_get(struct device *dev,
>   	return NULL;
>   }
>   
> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx)

This should be static inline instead

> +{
> +	return NULL;
> +}
> +
>   static inline void icc_put(struct icc_path *path)
>   {
>   }
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
