Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D601B7ED5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 21:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDXT0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgDXT0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 15:26:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C7C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 12:26:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so4097633plt.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ak3wRUTbhX3b+AZt5O65BJGsm25sMRWic48F76A9hM=;
        b=aaVLBGt9xNHi+hCZ8vzCgEF7XWOZEZmPr0Phaz77zFbq5WMywT6yHSh9e8GCu8ociu
         aGr7G3Cchq8usek7UA7iq6OS8pshLesDZoZqje7Aui6a8mp1OHLDByvI9C73O1SqdDiZ
         mx0zwH44LI86AaesZXFM2Ajhmo0vIU9IhlS4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ak3wRUTbhX3b+AZt5O65BJGsm25sMRWic48F76A9hM=;
        b=fk/StH7J0+nCyJvIAVrDU6VF6J7zzqQS+luE3BHRliPPbcPCd0JNz5RBrpvK/RGMc5
         f2W8JpcQbP1+lnZbUNGu4jQd40B5iJ0YTCe+NOxkQEvqV+2uB5PZ+Wz6scOTq18yhTMb
         Sbjg2uj215wg2uvHgJLLQ17d4SY9sXgsii+KXrjYtzOVoG6j5/8DTlqf1reAsXWXZqWB
         7u8eKEYPXI1cTzEA1QvZKBE7nm7l3m5C8iXFSvUmazUHg4QXtHyBfXQc7a+6BpeYHypx
         iQ8U34/QGb/Sh6tHcp7jQbpYJ5cNzXFm1HkCIGLOviNjgJvj23o7qmv+SFzaVefm0gWa
         NRSA==
X-Gm-Message-State: AGi0Pua/0HnpFEyv5q67ZDwDXiEO+6FefaInpHe5pAzeeHI3RgVkAhIo
        9rFa8Uc4S981sthJpz7X/wd3Cg==
X-Google-Smtp-Source: APiQypL6ZHQVIk0jDGsuJs8ztATvWT/HuDC1iXb3RFCHlfbimDatC7NnMcHjF8PcL7UjBVc67o/vfw==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr11186391plb.285.1587756369143;
        Fri, 24 Apr 2020 12:26:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id g6sm5227594pjx.48.2020.04.24.12.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 12:26:08 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:26:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] OPP: Add sanity checks in _read_opp_key()
Message-ID: <20200424192607.GB4525@google.com>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-6-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424155404.10746-6-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 24, 2020 at 06:54:02PM +0300, Georgi Djakov wrote:
> When we read the OPP keys, it would be nice to do some sanity checks
> of the values we get from DT and see if they match with the information
> that is populated in the OPP table. Let's pass a pointer of the table,
> so that we can do some validation.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> New patch.
> 
>  drivers/opp/of.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 978e445b0cdb..2b590fe2e69a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -574,8 +574,8 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
> -static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
> -			 bool *rate_not_available)
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *table,
> +			 struct device_node *np, bool *rate_not_available)
>  {
>  	struct property *peak, *avg;
>  	u32 *peak_bw, *avg_bw;
> @@ -603,6 +603,12 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
>  		 * opp-avg-kBps = <path1_value path2_value>;
>  		 */
>  		count = peak->length / sizeof(u32);
> +		if (table->path_count != count) {
> +			pr_err("%s: Mismatch between opp-peak-kBps and paths (%d %d)\n",
> +			       __func__, count, table->path_count);
> +			return -EINVAL;
> +		}
> +
>  		peak_bw = kmalloc_array(count, sizeof(*peak_bw), GFP_KERNEL);
>  		if (!peak_bw)
>  			return -ENOMEM;
> @@ -624,6 +630,13 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
>  	avg = of_find_property(np, "opp-avg-kBps", NULL);
>  	if (peak && avg) {
>  		count = avg->length / sizeof(u32);
> +		if (table->path_count != count) {
> +			pr_err("%s: Mismatch between opp-avg-kBps and paths (%d %d)\n",
> +			       __func__, count, table->path_count);
> +			ret = -EINVAL;
> +			goto free_peak_bw;
> +		}
> +
>  		avg_bw = kmalloc_array(count, sizeof(*avg_bw), GFP_KERNEL);
>  		if (!avg_bw) {
>  			ret = -ENOMEM;
> @@ -695,7 +708,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (!new_opp)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = _read_opp_key(new_opp, np, &rate_not_available);
> +	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
>  	if (ret < 0) {
>  		if (!opp_table->is_genpd)
>  			dev_err(dev, "%s: opp key field not found\n", __func__);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
