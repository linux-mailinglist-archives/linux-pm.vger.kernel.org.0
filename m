Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116BA25B1AC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIBQ3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 12:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIBQ3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 12:29:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE739C061244;
        Wed,  2 Sep 2020 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=25QsOL265VHtUBdduJ+zlcY70CKuPcRt2m3aDgcyCWk=; b=sLKhXXk3/7ER8cRlVAmG+XXxqR
        KHNqfAhW+ZZMezc3X8zfNz+epkDm2HdaUsWngYX7z6+Y48MPNykweecueQSTXYqoeKxAOWhWRF077
        ELtDplozK0eSATq6vOPLRHLgjuyGeRHjGYNR3yOYCFpx5jaUhNUGfUXH/ENv85yeULk3du2OxnvLD
        0IBVExgSAzN7+Ig8n6h2QibiQUCXhzplyOajPSA0g3uyZwzZykv282j4Y6H5TaiG1C53f8pKiXT+T
        ++etcs8zv880XErLxos5q02X09uGkqFwF9oEEM6S5BzX/v/M2hvKSZPOULW3EGhNLhxKAF8J5Qf4h
        seib7S3g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDVdf-0007GT-0p; Wed, 02 Sep 2020 16:29:35 +0000
Subject: Re: [PATCH v2] power: supply: charger-manager: Fix info message in
 check_charging_duration()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
References: <20200902162315.GA11384@embeddedor>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f93c0fa0-51a1-291f-feda-fbd8d7397e88@infradead.org>
Date:   Wed, 2 Sep 2020 09:29:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902162315.GA11384@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/2/20 9:23 AM, Gustavo A. R. Silva wrote:
> A few months ago, commit e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
> changed the expression in the if statement from "duration > desc->discharging_max_duration_ms"
> to "duration > desc->charging_max_duration_ms", but the arguments for dev_info() were left unchanged.
> Apparently, due to a copy-paste error.
> 
> Fix this by using the proper arguments for dev_info().
> 
> Also, while there, replace "exceed" with "exceeds", for both messages.
> 
> Addresses-Coverity-ID: 1496803 ("Copy-paste error")
> Fixes: e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  -  Replace "exceed" with "exceeds"
> 
>  drivers/power/supply/charger-manager.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index 07992821e252..a6d5dbd55e37 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -464,7 +464,7 @@ static int check_charging_duration(struct charger_manager *cm)
>  		duration = curr - cm->charging_start_time;
>  
>  		if (duration > desc->charging_max_duration_ms) {
> -			dev_info(cm->dev, "Charging duration exceed %ums\n",
> +			dev_info(cm->dev, "Charging duration exceeds %ums\n",
>  				 desc->charging_max_duration_ms);
>  			ret = true;
>  		}
> @@ -472,8 +472,8 @@ static int check_charging_duration(struct charger_manager *cm)
>  		duration = curr - cm->charging_end_time;
>  
>  		if (duration > desc->charging_max_duration_ms) {
> -			dev_info(cm->dev, "Discharging duration exceed %ums\n",
> -				 desc->discharging_max_duration_ms);
> +			dev_info(cm->dev, "Charging duration exceeds %ums\n",
> +				 desc->charging_max_duration_ms);
>  			ret = true;
>  		}
>  	}
> 

Hi,

It looks to me like the second block (else if) should be about discharging,
not charging, more like Colin King's patch had it:

  https://lore.kernel.org/lkml/20200902133117.108025-1-colin.king@canonical.com/

but I don't know this code.

-- 
~Randy

