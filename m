Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01F25AF32
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgIBPfB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 11:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgIBPez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 11:34:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92216C061244;
        Wed,  2 Sep 2020 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cq7bXXRcLzbBq/NxnwB+6LP/PEJbfLvvVskEHmvDFfw=; b=joGcDM7PwydTjV3jNF6ZNuYqy3
        idZOQCy8FTBjrOxeVSjYgjnErqBoWPc10FGKem/5RZ1k3SVfAvHIm2Vdi/HGZkA/ePUlZ4rWrhoYl
        m8hd5stiW+6Rzw7VfhxuvxRhZ0YLCosoRTvDz0LxtWaGU1H4d0UVksCXz7PdD2jf/hnDpyU9LqtsM
        WdDvZDY6MLOd6IpOIbxi+dMTdaUzxfPgCG2LM3LuIDTye9dzLMrom7B69PFfv1oeTISGpcf1gGgF1
        fMH31FUtrAWKDtuVBYAVLxfJKGzgdEsp6qC8vuxER4at/A5SP88enk71tPFYx025NngwjrYkdebSm
        yN0HFQtw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDUmg-0002me-MA; Wed, 02 Sep 2020 15:34:50 +0000
Subject: Re: [PATCH] power: supply: charger-manager: Fix info message in
 check_charging_duration()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200902153846.GA10327@embeddedor>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8d7be08f-fa20-d217-a606-738d79e36259@infradead.org>
Date:   Wed, 2 Sep 2020 08:34:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902153846.GA10327@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/2/20 8:38 AM, Gustavo A. R. Silva wrote:
> A few months ago, commit e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
> changed the expression in the if statement from "duration > desc->discharging_max_duration_ms"
> to "duration > desc->charging_max_duration_ms", but the arguments for dev_info() were left unchanged.
> Apparently, due to a copy-paste error.
> 
> Fix this by using the proper arguments for dev_info().
> 
> Addresses-Coverity-ID: 1496803 ("Copy-paste error")
> Fixes: e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/power/supply/charger-manager.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index 07992821e252..6117018e89df 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -472,8 +472,8 @@ static int check_charging_duration(struct charger_manager *cm)
>  		duration = curr - cm->charging_end_time;
>  
>  		if (duration > desc->charging_max_duration_ms) {
> -			dev_info(cm->dev, "Discharging duration exceed %ums\n",
> -				 desc->discharging_max_duration_ms);
> +			dev_info(cm->dev, "Charging duration exceed %ums\n",

preferably		                                     exceeds

> +				 desc->charging_max_duration_ms);
>  			ret = true;
>  		}
>  	}
> 

thanks.
-- 
~Randy

