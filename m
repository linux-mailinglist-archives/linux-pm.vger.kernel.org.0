Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18101E4D3B
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgE0Sqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 14:46:44 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37089 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726095AbgE0Sqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 14:46:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590605203; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6t2pkQsbSECmtGTXOY98W5BwhT1648xPdDFse8Y3ryY=;
 b=JxZeAB1D+lkulp1c0MgxSTemj3xfbS6TObNf5u44ZaIoNyzv/JnPjTKsn3KXGY5tieF7e3KO
 yZPmdkeBcZfDJ5ZjnN4ue2Q6c5sg1nZOnc+o+ZXBOiRrNwa5YIcf4pcBEYSkfJuljzZaBmZk
 NahhPWuFoDMUdL+d0TkWL+oM3xA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5eceb1f93131442d95b1b437 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 18:31:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51C03C433C9; Wed, 27 May 2020 18:31:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76523C433CB;
        Wed, 27 May 2020 18:31:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 May 2020 00:01:19 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, georgi.djakov@linaro.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH V2] opp: Remove bandwidth votes when target_freq is zero
In-Reply-To: <3aa3870d71b536127bb6af88c1dbfb4672ba4173.1590552778.git.viresh.kumar@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <3aa3870d71b536127bb6af88c1dbfb4672ba4173.1590552778.git.viresh.kumar@linaro.org>
Message-ID: <8bcec7186a4fc0d291d834a5964dab2f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-27 09:43, Viresh Kumar wrote:
> We already drop several votes when target_freq is set to zero, drop
> bandwidth votes as well.
> 
> Reported-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Some changes left uncommited in my tree by mistake.

Viresh,
Thanks for the patch :)

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> 
>  drivers/opp/core.c | 49 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 56d3022c1ca2..df12c3804533 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -725,6 +725,34 @@ static int _generic_set_opp_regulator(struct
> opp_table *opp_table,
>  	return ret;
>  }
> 
> +static int _set_opp_bw(const struct opp_table *opp_table,
> +		       struct dev_pm_opp *opp, struct device *dev, bool remove)
> +{
> +	u32 avg, peak;
> +	int i, ret;
> +
> +	if (!opp_table->paths)
> +		return 0;
> +
> +	for (i = 0; i < opp_table->path_count; i++) {
> +		if (remove) {
> +			avg = 0;
> +			peak = 0;
> +		} else {
> +			avg = opp->bandwidth[i].avg;
> +			peak = opp->bandwidth[i].peak;
> +		}
> +		ret = icc_set_bw(opp_table->paths[i], avg, peak);
> +		if (ret) {
> +			dev_err(dev, "Failed to %s bandwidth[%d]: %d\n",
> +				remove ? "remove" : "set", i, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int _set_opp_custom(const struct opp_table *opp_table,
>  			   struct device *dev, unsigned long old_freq,
>  			   unsigned long freq,
> @@ -820,7 +848,7 @@ int dev_pm_opp_set_rate(struct device *dev,
> unsigned long target_freq)
>  	unsigned long freq, old_freq, temp_freq;
>  	struct dev_pm_opp *old_opp, *opp;
>  	struct clk *clk;
> -	int ret, i;
> +	int ret;
> 
>  	opp_table = _find_opp_table(dev);
>  	if (IS_ERR(opp_table)) {
> @@ -837,12 +865,17 @@ int dev_pm_opp_set_rate(struct device *dev,
> unsigned long target_freq)
>  		if (!_get_opp_count(opp_table))
>  			return 0;
> 
> -		if (!opp_table->required_opp_tables && !opp_table->regulators) {
> +		if (!opp_table->required_opp_tables && !opp_table->regulators &&
> +		    !opp_table->paths) {
>  			dev_err(dev, "target frequency can't be 0\n");
>  			ret = -EINVAL;
>  			goto put_opp_table;
>  		}
> 
> +		ret = _set_opp_bw(opp_table, opp, dev, true);
> +		if (ret)
> +			return ret;
> +
>  		if (opp_table->regulator_enabled) {
>  			regulator_disable(opp_table->regulators[0]);
>  			opp_table->regulator_enabled = false;
> @@ -932,16 +965,8 @@ int dev_pm_opp_set_rate(struct device *dev,
> unsigned long target_freq)
>  			dev_err(dev, "Failed to set required opps: %d\n", ret);
>  	}
> 
> -	if (!ret && opp_table->paths) {
> -		for (i = 0; i < opp_table->path_count; i++) {
> -			ret = icc_set_bw(opp_table->paths[i],
> -					 opp->bandwidth[i].avg,
> -					 opp->bandwidth[i].peak);
> -			if (ret)
> -				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
> -					i, ret);
> -		}
> -	}
> +	if (!ret)
> +		ret = _set_opp_bw(opp_table, opp, dev, false);
> 
>  put_opp:
>  	dev_pm_opp_put(opp);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
