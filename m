Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8981E7C1D
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 13:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgE2LkE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 07:40:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15252 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2LkE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 07:40:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590752403; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ULnHO3lQn35d/Unhx2ItBX6eZJKBINasYWCghlKe0pE=;
 b=Wkaw94XONmcPgx6R/ddgjtjDt01wkP3C7xOiQ0bZEHDPzhdL79k0kC5evoABRW4FU+KEO8A1
 sJejn2EFHO5svDM8VrDFNHdY3yhPQ0OiczLLeCmgcYjmwSFC6lXgn1aBO/QO4j7/dfXaOrqA
 oWzX25nOYiGqqKS5fNZdf2dvDm4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ed0f488ea0dfa490eb3cf14 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 11:39:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CFBD2C43395; Fri, 29 May 2020 11:39:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FF9FC433C9;
        Fri, 29 May 2020 11:39:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 17:09:51 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, mka@chromium.org, robh+dt@kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/10] OPP: Add support for parsing interconnect
 bandwidth
In-Reply-To: <20200529044437.5wmbbews2vn66dia@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-5-georgi.djakov@linaro.org>
 <20200529044437.5wmbbews2vn66dia@vireshk-i7>
Message-ID: <423a76300ccc9a8fa9e825cab56d4d36@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-29 10:14, Viresh Kumar wrote:
> On 12-05-20, 15:53, Georgi Djakov wrote:
>>  struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>>  {
>>  	struct dev_pm_opp *opp;
>> -	int count, supply_size;
>> +	int supply_count, supply_size, icc_size;
>> 
>>  	/* Allocate space for at least one supply */
>> -	count = table->regulator_count > 0 ? table->regulator_count : 1;
>> -	supply_size = sizeof(*opp->supplies) * count;
>> +	supply_count = table->regulator_count > 0 ? table->regulator_count : 
>> 1;
>> +	supply_size = sizeof(*opp->supplies) * supply_count;
>> +	icc_size = sizeof(*opp->bandwidth) * table->path_count;
>> 
>>  	/* allocate new OPP node and supplies structures */
>> -	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
>> +	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
>> +
>>  	if (!opp)
>>  		return NULL;
>> 
>>  	/* Put the supplies at the end of the OPP structure as an empty 
>> array */
>>  	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
>> +	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + 
>> supply_count);
>>  	INIT_LIST_HEAD(&opp->node);
> 
> Added this delta here.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7302f2631f8d..dfbd3d10410c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1330,7 +1330,8 @@ struct dev_pm_opp *_opp_allocate(struct opp_table 
> *table)
> 
>         /* Put the supplies at the end of the OPP structure as an empty 
> array */
>         opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
> -       opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies +
> supply_count);
> +       if (icc_size)
> +               opp->bandwidth = (struct dev_pm_opp_icc_bw
> *)(opp->supplies + supply_count);

nice catch!
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

>         INIT_LIST_HEAD(&opp->node);
> 
>         return opp;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
