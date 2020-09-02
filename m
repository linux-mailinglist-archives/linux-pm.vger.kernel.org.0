Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8199325B01B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgIBPvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 11:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBPvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 11:51:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448FBC061244;
        Wed,  2 Sep 2020 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Cp8V1GrvtzU2e2MKh6LDdEUvlY5amNpoEKJcdKTXSzM=; b=mn3AxcQK4BhdnyEMYYGtUjMIiY
        QkMmw9VVvPzaLN9XveOgC0yZOKJa0YqqlmzQvNEiRJ+HoaVZM7FIgF0rdG85CBRszucfKs7h7NDwy
        LWaqLRVXcqaJkV54gdvBoqXpnRpFDf03qK1yjgntKi1cygvlWn/83nH/Jost0AnUvVCdemcTuaN7H
        uFb6geM4lcmLy7uIukt/KeaxHHcrgoajRAJr7M/vmz6cxpUT4jo9xX0RMxeVsLwxkxRg1dJSZsvGR
        CK9sDe2o3wDARuPLkqofQJJsTHnucYU9Yk15ydklpKBkrOi/qZGxcvrEe1IbVQUacSOjPdNnyxyeZ
        9Vnc/htQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDV2I-0004JD-Ug; Wed, 02 Sep 2020 15:50:59 +0000
Subject: Re: [PATCH][next] charger-manager: fix incorrect check on
 charging_duration_ms
To:     Colin King <colin.king@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20200902133117.108025-1-colin.king@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42cb421a-286e-65db-36b1-4fa794758279@infradead.org>
Date:   Wed, 2 Sep 2020 08:50:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902133117.108025-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/2/20 6:31 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the duration check on the discharging duration setting is
> checking the charging duration rather than the discharging duration
> due to a cut-n-paste coding error. Fix this by checking the value
> desc->charging_max_duration_ms.
> 
> Addresses-Coverity: ("Copy-paste-error")
> Fixes: 8fcfe088e21a ("charger-manager: Support limit of maximum possible")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Gustavo has a different patch:
https://lore.kernel.org/lkml/20200902153846.GA10327@embeddedor/

> ---
>  drivers/power/supply/charger-manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index 07992821e252..44d919954e9e 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -471,7 +471,7 @@ static int check_charging_duration(struct charger_manager *cm)
>  	} else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
>  		duration = curr - cm->charging_end_time;
>  
> -		if (duration > desc->charging_max_duration_ms) {
> +		if (duration > desc->discharging_max_duration_ms) {
>  			dev_info(cm->dev, "Discharging duration exceed %ums\n",

preferably change:	                                        exceeds


>  				 desc->discharging_max_duration_ms);
>  			ret = true;
> 


-- 
~Randy

