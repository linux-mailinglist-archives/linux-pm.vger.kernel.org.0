Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90E776EFC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfGZQZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 12:25:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39349 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGZQZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 12:25:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so37434035lfa.6
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jJr+mv+3Bku2kcxf6e7N0HYCTZd2RY5/zWLci9WVBdY=;
        b=FMr7HUFndh/+mlDCOhrYAubF+h/5Wh04nOfHpjDKkgiz7k+J82TnFn/DYzZJooHjQK
         Y8GOVxxSt61fAe4fGOSexE7oS3DDozGg7r/3YxG7QVqtlBf/sm3FvNbtHQjcYN0ioi+P
         seUeVr3PsyvcFU1IhqG0dGtpx2L9/lRkU/jFJuVaCNADmPB5PUjTd0uyfpwxCjR9c2XB
         R/CP2v9+fC8b9yK7DsRN0K1omvxBnipsLsaQhu5YN1Zvxn4aDM593UxnLhMrIruCn2gu
         MS722OBFU+z0BwbnCK+ab8XxDLFLBZm1mPLtC0pH/aZxci26KUfkNxFqDPfpOAJR2SU3
         KnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jJr+mv+3Bku2kcxf6e7N0HYCTZd2RY5/zWLci9WVBdY=;
        b=Fp5ThqGFZY+5dAz+0q6IW57QzyYMpDRCrh4GjUtemofwWPEtfWALXQvQkdYl/TtGRv
         2DbsWYqMlj9OMr7zIsIZSxxZ/OUbELqs4BpNCpf/VRkj31yVenAf35Gkggxnd8SY1cp2
         yK6EXdXwRwfAxgv/hfoMaGWYKyUSJLZ1sc2VIj/536UkfIoWNjVg4v0TV/5BtwqPayYq
         SZbLOYn9VtVaa4Y9YeGNNwRwqLwssmmyx1w6/ICcO9FcijFtp7ooGGXVeo34z8jz7Icy
         1kFNjqc2sRB6k4hvwuJrf/teuV4XZxmdIXpUa0auda3FrRgBzSGWQcqD0YSQ/1mz6T9c
         uP9w==
X-Gm-Message-State: APjAAAWGI2PGs4IYSBFGdJ+9Ed39QImwpVCqeacucL1+kVxl/ZYxyg//
        dZe38cHEBGmutqSBTLlf1EbcXg==
X-Google-Smtp-Source: APXvYqwAOv7nMvSXK7zBLGzWO2lkM4lXZ2foX0Ydk01HBVMN7bP2yVrDQqjXAjBtpwThlj+DgA8dSA==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr43881045lff.95.1564158309555;
        Fri, 26 Jul 2019 09:25:09 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm8563026lfl.10.2019.07.26.09.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 09:25:09 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] interconnect: Add OPP table support for
 interconnects
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-7-saravanak@google.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <fde02417-dc72-acad-727d-452a3ae3cbd0@linaro.org>
Date:   Fri, 26 Jul 2019 19:25:06 +0300
MIME-Version: 1.0
In-Reply-To: <20190703011020.151615-7-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On 7/3/19 04:10, Saravana Kannan wrote:
> Interconnect paths can have different performance points. Now that OPP
> framework supports bandwidth OPP tables, add OPP table support for
> interconnects.
> 
> Devices can use the interconnect-opp-table DT property to specify OPP
> tables for interconnect paths. And the driver can obtain the OPP table for
> an interconnect path by calling icc_get_opp_table().
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
>  include/linux/interconnect.h |  7 +++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 871eb4bc4efc..881bac80bc1e 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -47,6 +47,7 @@ struct icc_req {
>   */
>  struct icc_path {
>  	size_t num_nodes;
> +	struct opp_table *opp_table;

I am a bit worried that these tables might be abused and size of the DT will
grow with many OPP tables of all existing paths.

>  	struct icc_req reqs[];
>  };
>  
> @@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  {
>  	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>  	struct icc_node *src_node, *dst_node;
> -	struct device_node *np = NULL;
> +	struct device_node *np = NULL, *opp_node;
>  	struct of_phandle_args src_args, dst_args;
>  	int idx = 0;
>  	int ret;
> @@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>  	mutex_unlock(&icc_lock);
>  
> +	opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);

Can't we figure out if the device OPP table contains bandwidth even without this
property?

Thanks,
Georgi

> +	if (opp_node) {
> +		path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
> +		of_node_put(opp_node);
> +	}
> +
> +
>  	return path;
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get);
>  
> +/**
> + * icc_get_opp_table() - Get the OPP table that corresponds to a path
> + * @path: reference to the path returned by icc_get()
> + *
> + * This function will return the OPP table that corresponds to a path handle.
> + * If the interconnect API is disabled, NULL is returned and the consumer
> + * drivers will still build. Drivers are free to handle this specifically, but
> + * they don't have to.
> + *
> + * Return: opp_table pointer on success. NULL is returned when the API is
> + * disabled or the OPP table is missing.
> + */
> +struct opp_table *icc_get_opp_table(struct icc_path *path)
> +{
> +	return path->opp_table;
> +}
> +
>  /**
>   * icc_set_bw() - set bandwidth constraints on an interconnect path
>   * @path: reference to the path returned by icc_get()
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index dc25864755ba..0c0bc55f0e89 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> +#include <linux/pm_opp.h>
>  
>  /* macros for converting to icc units */
>  #define Bps_to_icc(x)	((x) / 1000)
> @@ -28,6 +29,7 @@ struct device;
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>  			 const int dst_id);
>  struct icc_path *of_icc_get(struct device *dev, const char *name);
> +struct opp_table *icc_get_opp_table(struct icc_path *path);
>  void icc_put(struct icc_path *path);
>  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>  
> @@ -49,6 +51,11 @@ static inline void icc_put(struct icc_path *path)
>  {
>  }
>  
> +static inline struct opp_table *icc_get_opp_table(struct icc_path *path)
> +{
> +	return NULL;
> +}
> +
>  static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  {
>  	return 0;
> 
