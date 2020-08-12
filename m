Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15D242535
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLGK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 02:10:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53940 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgHLGK0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Aug 2020 02:10:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597212625; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=w7DFpPJTUNfnqStvwlCVQRQJO4go+5/iJnCBBavzYZs=; b=OROHmqYUdVJAMoxEb0xXF2ce3nKzxvgjHWOED8eT1dV5V/tzlXSzkM0ta+AJKoub3GwcLOCk
 yx+CeK1JRy6vlITL4s675Gol9lTUWwndnyGc2R5UtboKkUuQTSDqEZKMvFJzpYp/Q39oqO/j
 mEMSWXCScaB5yGUQP0xLRkow7aM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f3387ced78a2e583357db19 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 06:10:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C748C433C9; Wed, 12 Aug 2020 06:10:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.15] (unknown [61.1.229.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99A5FC433C6;
        Wed, 12 Aug 2020 06:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99A5FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] OPP: Put opp table in dev_pm_opp_set_rate() all the time
To:     Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200811212836.2531613-1-swboyd@chromium.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <006c62c2-e946-954b-6f11-2c5ab131d93d@codeaurora.org>
Date:   Wed, 12 Aug 2020 11:40:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811212836.2531613-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/12/2020 2:58 AM, Stephen Boyd wrote:
> We get the opp_table pointer at the top of the function and so we should
> put the pointer at the end of the function like all other exit paths
> from this function do.
> 
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Fixes: aca48b61f963 ("opp: Manage empty OPP tables with clk handle")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Thanks for the fix.
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

> ---
>   drivers/opp/core.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9d7fb45b1786..bdb028c7793d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -893,8 +893,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   		 * have OPP table for the device, while others don't and
>   		 * opp_set_rate() just needs to behave like clk_set_rate().
>   		 */
> -		if (!_get_opp_count(opp_table))
> -			return 0;
> +		if (!_get_opp_count(opp_table)) {
> +			ret = 0;
> +			goto put_opp_table;
> +		}
>   
>   		if (!opp_table->required_opp_tables && !opp_table->regulators &&
>   		    !opp_table->paths) {
> @@ -905,7 +907,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>   
>   		ret = _set_opp_bw(opp_table, NULL, dev, true);
>   		if (ret)
> -			return ret;
> +			goto put_opp_table;
>   
>   		if (opp_table->regulator_enabled) {
>   			regulator_disable(opp_table->regulators[0]);
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
