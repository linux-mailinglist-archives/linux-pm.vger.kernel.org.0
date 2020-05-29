Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3C1E7FFF
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2OR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 10:17:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12134 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgE2OR2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 10:17:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590761847; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jYeq07K3HGP5zkPkzH4RT8idjqRLLzcKW7iabMhTFgo=;
 b=HQ1KI55j8pqiBN+0bpjmJEtJxXRRTDI0aspVnrer6IdsmYirYsKNZ27F6/9q92lYM1JqXZKV
 Ygi/Qb4njx4BU4R9xKiW/5hfkvDT10Qa6s5lwdmvh58oyUb+enYP9JZF0My65SZ7pocNYdUD
 lh/XVPAyDv61Jge+FgMiyNmA4F8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ed11970b4f0a9ae22d434e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 14:17:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E830C433CA; Fri, 29 May 2020 14:17:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BA83C433C9;
        Fri, 29 May 2020 14:17:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 19:47:18 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, nm@ti.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, saravanak@google.com, mka@chromium.org,
        smasetty@codeaurora.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] OPP: Check for bandwidth values before creating icc paths
In-Reply-To: <20200529052031.n2nvzxdsifwmthfv@vireshk-i7>
References: <20200527192418.20169-1-sibis@codeaurora.org>
 <20200529052031.n2nvzxdsifwmthfv@vireshk-i7>
Message-ID: <0205034b0ece173a7152a43b016985a7@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-29 10:50, Viresh Kumar wrote:
> On 28-05-20, 00:54, Sibi Sankar wrote:
>> Prevent the core from creating and voting on icc paths when the
>> opp-table does not have the bandwidth values populated. Currently
>> this check is performed on the first OPP node.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/opp/of.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index 61fce1284f012..95cf6f1312765 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -338,6 +338,21 @@ int dev_pm_opp_of_find_icc_paths(struct device 
>> *dev,
>>  	struct device_node *np;
>>  	int ret = 0, i, count, num_paths;
>>  	struct icc_path **paths;
>> +	struct property *prop;
>> +
>> +	/* Check for bandwidth values on the first OPP node */
>> +	if (opp_table && opp_table->np) {
>> +		np = of_get_next_available_child(opp_table->np, NULL);
>> +		if (!np) {
>> +			dev_err(dev, "Empty OPP table\n");
>> +			return 0;
>> +		}
>> +
>> +		prop = of_find_property(np, "opp-peak-kBps", NULL);
>> +		of_node_put(np);
>> +		if (!prop || !prop->length)
>> +			return 0;
>> +	}
> 
> This doesn't support the call made from cpufreq-dt driver. Pushed
> this, please give this a try:

Viresh,
Thanks for the patch!

> 
> From: Sibi Sankar <sibis@codeaurora.org>
> Date: Thu, 28 May 2020 00:54:18 +0530
> Subject: [PATCH] opp: Don't parse icc paths unnecessarily
> 
> The DT node of the device may contain interconnect paths while the OPP
> table doesn't have the bandwidth values. There is no need to parse the
> paths in such cases.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> [ Viresh: Support the case of !opp_table and massaged changelog ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/of.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 61fce1284f01..8c1bf01f0e50 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -332,13 +332,56 @@ static int _of_opp_alloc_required_opps(struct
> opp_table *opp_table,
>  	return ret;
>  }
> 
> +static int _bandwidth_supported(struct device *dev, struct opp_table
> *opp_table)
> +{
> +	struct device_node *np, *opp_np;
> +	struct property *prop;
> +
> +	if (!opp_table) {
> +		np = of_node_get(dev->of_node);
> +		if (!np)
> +			return -ENODEV;
> +
> +		opp_np = _opp_of_get_opp_desc_node(np, 0);
> +		of_node_put(np);
> +
> +		/* Lets not fail in case we are parsing opp-v1 bindings */
> +		if (!opp_np)
> +			return 0;
> +	} else {
> +		opp_np = of_node_get(opp_table->np);

opp_np needs to be subjected
to NULL check as well. Lets
move "if (!opp_np)" to outside
the if/else. With the above
change in place:

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> +	}
> +
> +	/* Checking only first OPP is sufficient */
> +	np = of_get_next_available_child(opp_np, NULL);
> +	if (!np) {
> +		dev_err(dev, "OPP table empty\n");
> +		return -EINVAL;
> +	}
> +	of_node_put(opp_np);
> +
> +	prop = of_find_property(np, "opp-peak-kBps", NULL);
> +	of_node_put(np);
> +
> +	if (!prop || !prop->length)
> +		return 0;
> +
> +	return 1;
> +}
> +
>  int dev_pm_opp_of_find_icc_paths(struct device *dev,
>  				 struct opp_table *opp_table)
>  {
>  	struct device_node *np;
> -	int ret = 0, i, count, num_paths;
> +	int ret, i, count, num_paths;
>  	struct icc_path **paths;
> 
> +	ret = _bandwidth_supported(dev, opp_table);
> +	if (ret <= 0)
> +		return ret;
> +
> +	ret = 0;
> +
>  	np = of_node_get(dev->of_node);
>  	if (!np)
>  		return 0;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
