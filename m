Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957FF1E753F
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 07:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2FUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 01:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2FUe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 01:20:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95ACC08C5C6
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 22:20:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so594007plv.9
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 22:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9yAtHKZIr9aOByyuI66DPzP7Py6j0XSgzrFMqDdxTU=;
        b=OOrORhJkpf8Mp7z+oqNxR9xu5seNIbKXOzZyEI/8AAwCWwBYwSCti5MilBVhNulAtS
         U0wks5EBu8WnaOEwNukcF4Xsu/XJIO32WBqs8FAYpv6x02oZn2dVDDAc3/rcPOMQWY8f
         Vda3wNSPK1ZT+SsGbPD9L4lZEb3t7cRo4zzRu0FbzHKy2MY5Hg4swSc3quqJ2Aqg6qvx
         V3n/N7KW9lLlXfJj8WfNAjQbcFotigP9gLyq45SQKz9petsVnEnLv2KXjlOZM8vOWYbg
         76LiFY2T5cfBnV+RNhdvlxbzVVSSs5SuupGq2RgFLREsTSjfrprDhgBS1cC92VY+HdBh
         TTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9yAtHKZIr9aOByyuI66DPzP7Py6j0XSgzrFMqDdxTU=;
        b=IjGw6k+/gPYhaxwUV7olP5Zt+0NWaUnxg8AI1rWevazU/Xfc3VZXVLQR6J7kbg0wGU
         95ElPwC9swldZ8EokGqGWRQMxv1GNWgMGtKInh1Nd34O+CtHKZ2ZcolybR7pPkGTtsn9
         gScjB9KjNtMWDzaukkNJx9674ta5bg08eT7LWZkaa4JTdBtf7AHf+XERqDvWbJl1JfPU
         UnodlQtcfF1TFyBcaQYvXAYnXuebed+89JAT/ItdRxqyhaYY/t5kZhv9hnLjKZcHSCH+
         NqNOI30Wamc39PD6juXQZmp5ndzOWYUnXHq8Tbn3Sukm9qghsflAdFX708GO3f9RSO6A
         s4PQ==
X-Gm-Message-State: AOAM531Rvq0x4+VVDw/MM54lKarRPz6aV9ZcflIY0d86r7si78Kp7FXK
        P65te1SdmYU7+pOhx5DWdP3qeg==
X-Google-Smtp-Source: ABdhPJwLHxiF5TCadAYY6aE6dCZnGwiEO4jsHRimGs/GMFoHDgf8qs7IhqpPo7PUWxDQUmdCXb+sGQ==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr7547666pjb.131.1590729634252;
        Thu, 28 May 2020 22:20:34 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id d15sm8570637pjc.0.2020.05.28.22.20.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 22:20:33 -0700 (PDT)
Date:   Fri, 29 May 2020 10:50:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, nm@ti.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, saravanak@google.com, mka@chromium.org,
        smasetty@codeaurora.org
Subject: Re: [PATCH] OPP: Check for bandwidth values before creating icc paths
Message-ID: <20200529052031.n2nvzxdsifwmthfv@vireshk-i7>
References: <20200527192418.20169-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527192418.20169-1-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-05-20, 00:54, Sibi Sankar wrote:
> Prevent the core from creating and voting on icc paths when the
> opp-table does not have the bandwidth values populated. Currently
> this check is performed on the first OPP node.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/opp/of.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 61fce1284f012..95cf6f1312765 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -338,6 +338,21 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
>  	struct device_node *np;
>  	int ret = 0, i, count, num_paths;
>  	struct icc_path **paths;
> +	struct property *prop;
> +
> +	/* Check for bandwidth values on the first OPP node */
> +	if (opp_table && opp_table->np) {
> +		np = of_get_next_available_child(opp_table->np, NULL);
> +		if (!np) {
> +			dev_err(dev, "Empty OPP table\n");
> +			return 0;
> +		}
> +
> +		prop = of_find_property(np, "opp-peak-kBps", NULL);
> +		of_node_put(np);
> +		if (!prop || !prop->length)
> +			return 0;
> +	}

This doesn't support the call made from cpufreq-dt driver. Pushed
this, please give this a try:

From: Sibi Sankar <sibis@codeaurora.org>
Date: Thu, 28 May 2020 00:54:18 +0530
Subject: [PATCH] opp: Don't parse icc paths unnecessarily

The DT node of the device may contain interconnect paths while the OPP
table doesn't have the bandwidth values. There is no need to parse the
paths in such cases.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
[ Viresh: Support the case of !opp_table and massaged changelog ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 61fce1284f01..8c1bf01f0e50 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -332,13 +332,56 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 	return ret;
 }
 
+static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
+{
+	struct device_node *np, *opp_np;
+	struct property *prop;
+
+	if (!opp_table) {
+		np = of_node_get(dev->of_node);
+		if (!np)
+			return -ENODEV;
+
+		opp_np = _opp_of_get_opp_desc_node(np, 0);
+		of_node_put(np);
+
+		/* Lets not fail in case we are parsing opp-v1 bindings */
+		if (!opp_np)
+			return 0;
+	} else {
+		opp_np = of_node_get(opp_table->np);
+	}
+
+	/* Checking only first OPP is sufficient */
+	np = of_get_next_available_child(opp_np, NULL);
+	if (!np) {
+		dev_err(dev, "OPP table empty\n");
+		return -EINVAL;
+	}
+	of_node_put(opp_np);
+
+	prop = of_find_property(np, "opp-peak-kBps", NULL);
+	of_node_put(np);
+
+	if (!prop || !prop->length)
+		return 0;
+
+	return 1;
+}
+
 int dev_pm_opp_of_find_icc_paths(struct device *dev,
 				 struct opp_table *opp_table)
 {
 	struct device_node *np;
-	int ret = 0, i, count, num_paths;
+	int ret, i, count, num_paths;
 	struct icc_path **paths;
 
+	ret = _bandwidth_supported(dev, opp_table);
+	if (ret <= 0)
+		return ret;
+
+	ret = 0;
+
 	np = of_node_get(dev->of_node);
 	if (!np)
 		return 0;

-- 
viresh
