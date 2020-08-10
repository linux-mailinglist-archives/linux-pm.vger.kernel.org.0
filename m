Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFEE2404E2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHJKlX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 06:41:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29238 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgHJKlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 06:41:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597056081; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bOfrWCltEVI8DM/7pKEvaC9vrWo0+jptX7+Cco4h2KM=;
 b=UgBxCujiKv66KOoYmW5Xr7nJ8xwtzXOP3E+hT+A8NoYVyIsyYwaZO88G0X0s/8OPwbc8fB4R
 9mlIbSRNQZq5YgRA+KfN0i5NmKyksPgvKVxocvDr16ipjyAjjnZd+H7BqCjWNnnt/vsAcuiX
 w+G3R6OZ9FAF28MsXvjRP7quU3o=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f31243d1e4d3989d43ac09f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 10:41:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36E27C433CA; Mon, 10 Aug 2020 10:41:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80FD0C433C6;
        Mon, 10 Aug 2020 10:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Aug 2020 16:11:00 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] opp: Fix dev_pm_opp_set_rate() to not return early
In-Reply-To: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <6b35716fbf56b2a37ed2a7e4e5bbec87@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-08-10 12:36, Rajendra Nayak wrote:
> dev_pm_opp_set_rate() can now be called with freq = 0 inorder
> to either drop performance or bandwidth votes or to disable
> regulators on platforms which support them.
> In such cases, a subsequent call to dev_pm_opp_set_rate() with
> the same frequency ends up returning early because 'old_freq == freq'
> Instead make it fall through and put back the dropped performance
> and bandwidth votes and/or enable back the regulators.
> 
> Fixes: cd7ea582 ("opp: Make dev_pm_opp_set_rate() handle freq = 0 to
> drop performance votes")
> Reported-by: Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> ---
>  drivers/opp/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0c8c74a..a994f30 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -901,6 +901,9 @@ int dev_pm_opp_set_rate(struct device *dev,
> unsigned long target_freq)
> 
>  	/* Return early if nothing to do */
>  	if (old_freq == freq) {
> +		if (opp_table->required_opp_tables || opp_table->regulators ||
> +		    opp_table->paths)
> +			goto skip_clk_only;
>  		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to 
> do\n",
>  			__func__, freq);
>  		ret = 0;
> @@ -919,6 +922,7 @@ int dev_pm_opp_set_rate(struct device *dev,
> unsigned long target_freq)
>  		goto put_opp_table;
>  	}
> 
> +skip_clk_only:
>  	temp_freq = old_freq;
>  	old_opp = _find_freq_ceil(opp_table, &temp_freq);
>  	if (IS_ERR(old_opp)) {
> @@ -954,8 +958,10 @@ int dev_pm_opp_set_rate(struct device *dev,
> unsigned long target_freq)
>  						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
>  						 opp->supplies);
>  	} else {
> +		ret = 0;
>  		/* Only frequency scaling */
> -		ret = _generic_set_opp_clk_only(dev, clk, freq);
> +		if (freq != old_freq)
> +			ret = _generic_set_opp_clk_only(dev, clk, freq);
>  	}
> 
>  	/* Scaling down? Configure required OPPs after frequency */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
