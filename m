Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF9247F0A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRHKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 03:10:25 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31361 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgHRHKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 03:10:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597734618; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mEEeTVMCmm28X/TonqAKjwo9yxTQLd+qrEsl7KAFN88=; b=c4DM5T7YOpZAInYdENApaOrYWFeoIr7ZmNlP45jKuifPl/tR9ZO4qHMLOJrU+fCcjxbQFDiZ
 Mgvf2jeB+Su/XeJHSlzSUuZiBo7aafogpMTD180gFByaVCbpe00xeB6boiDfud0uRApSBvRv
 wi+FoLbW9pTH11xKNIHuD9vwEBQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f3b7edaf2b697637afba1d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 07:10:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 490BFC4339C; Tue, 18 Aug 2020 07:10:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.16] (unknown [61.3.19.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE156C433C6;
        Tue, 18 Aug 2020 07:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE156C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 3/4] opp: Reused enabled flag and remove regulator_enabled
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
 <359b588928b7e58b009f786b17ddc088c6a7d18b.1597292833.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <e232d06c-f19f-a806-637b-8f0ffed19594@codeaurora.org>
Date:   Tue, 18 Aug 2020 12:40:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <359b588928b7e58b009f786b17ddc088c6a7d18b.1597292833.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/13/2020 9:59 AM, Viresh Kumar wrote:
> The common "enabled" flag can be used here instead of
> "regulator_enabled" now.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/opp/core.c | 13 +++----------
>   drivers/opp/opp.h  |  2 --
>   2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e8882e7fd8a5..5f5da257f58a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -703,12 +703,10 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
>   	 * Enable the regulator after setting its voltages, otherwise it breaks
>   	 * some boot-enabled regulators.
>   	 */
> -	if (unlikely(!opp_table->regulator_enabled)) {
> +	if (unlikely(!opp_table->enabled)) {
>   		ret = regulator_enable(reg);
>   		if (ret < 0)
>   			dev_warn(dev, "Failed to enable regulator: %d", ret);
> -		else
> -			opp_table->regulator_enabled = true;
>   	}
>   
>   	return 0;
> @@ -905,10 +903,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   		if (ret)
>   			goto put_opp_table;
>   
> -		if (opp_table->regulator_enabled) {
> -			regulator_disable(opp_table->regulators[0]);
> -			opp_table->regulator_enabled = false;
> -		}
> +		regulator_disable(opp_table->regulators[0]);

unconditionally calling regulator_disable() here based on the common
'enabled' flag results in a crash on platforms without regulators
associated with the opp table.

>   
>   		ret = _set_required_opps(dev, opp_table, NULL);
>   		if (!ret)
> @@ -1795,11 +1790,9 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>   	/* Make sure there are no concurrent readers while updating opp_table */
>   	WARN_ON(!list_empty(&opp_table->opp_list));
>   
> -	if (opp_table->regulator_enabled) {
> +	if (opp_table->enabled) {
>   		for (i = opp_table->regulator_count - 1; i >= 0; i--)
>   			regulator_disable(opp_table->regulators[i]);
> -
> -		opp_table->regulator_enabled = false;
>   	}
>   
>   	for (i = opp_table->regulator_count - 1; i >= 0; i--)
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index bd35802acc6e..0c3de3f6db5c 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -147,7 +147,6 @@ enum opp_table_access {
>    * @clk: Device's clock handle
>    * @regulators: Supply regulators
>    * @regulator_count: Number of power supply regulators. Its value can be -1
> - * @regulator_enabled: Set to true if regulators were previously enabled.
>    * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
>    * property).
>    * @paths: Interconnect path handles
> @@ -196,7 +195,6 @@ struct opp_table {
>   	struct clk *clk;
>   	struct regulator **regulators;
>   	int regulator_count;
> -	bool regulator_enabled;
>   	struct icc_path **paths;
>   	unsigned int path_count;
>   	bool enabled;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
