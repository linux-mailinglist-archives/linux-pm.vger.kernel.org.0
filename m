Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40C83466AB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhCWRsc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhCWRsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 13:48:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D0C061574;
        Tue, 23 Mar 2021 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=WAaAPdguDLLP2yVKPdLWr0ZxkEKHN3J+rUw3FYzZDXo=; b=aPsyQ8nH70OWaOsS4KSMB28jwu
        fINSBkOnYLyEwJy8So6O83yVEfVFmrZOB3n+0quresGKpXUua1pPeMBbUqmCq+4t4jUlUQTtGK4r3
        LZU/1JfDRXSJqyKoDYOPhoM7BoeYsjDp4CRBRVkyHfbqE5ejt939m2tpFPeLeBY84g3USjTBVAYJS
        EexI2KFzeEvGUB2chekrq9QyBG1C6kdcxjlyQn/9/zGNR87wes9nM8yGo7paHg2TWfl9IJeLPaa7H
        PNaxN87c9MIDt3CnqhEmnCheX6stEch3PqwjJO78pnfOyjtqqgs1uhWflsMCrSKq16zc0IwodZeMA
        VfHTkg3A==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOl7v-00AMZz-LG; Tue, 23 Mar 2021 17:47:46 +0000
Subject: Re: [PATCH] power: supply: Trivial spelling fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323124206.24813-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f35f9ff-ae16-443c-b18e-40f32013ccdb@infradead.org>
Date:   Tue, 23 Mar 2021 10:47:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323124206.24813-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/23/21 5:42 AM, Bhaskar Chowdhury wrote:
> Few trivial spelling fixes .
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/power/supply/max17042_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 79d4b5988360..1d7326cd8fc6 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -131,7 +131,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
>  	 *
>  	 * When this cycle the battery gets charged to a higher (calculated)
>  	 * capacity then the previous cycle then FullCAP will get updated
> -	 * contineously once end-of-charge detection kicks in, so allow the
> +	 * continuously once end-of-charge detection kicks in, so allow the
>  	 * 2 to differ a bit.
>  	 */
> 
> @@ -739,7 +739,7 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)
> 
>  /*
>   * Block write all the override values coming from platform data.
> - * This function MUST be called before the POR initialization proceedure
> + * This function MUST be called before the POR initialization procedure
>   * specified by maxim.
>   */
>  static inline void max17042_override_por_values(struct max17042_chip *chip)
> @@ -811,7 +811,7 @@ static int max17042_init_chip(struct max17042_chip *chip)
>  	 */
>  	msleep(500);
> 
> -	/* Initialize configaration */
> +	/* Initialize configuration */
>  	max17042_write_config_regs(chip);
> 
>  	/* write cell characterization data */
> @@ -855,7 +855,7 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
>  	struct regmap *map = chip->regmap;
>  	u32 soc, soc_tr;
> 
> -	/* program interrupt thesholds such that we should
> +	/* program interrupt thresholds such that we should
>  	 * get interrupt for every 'off' perc change in the soc
>  	 */
>  	regmap_read(map, MAX17042_RepSOC, &soc);
> --


-- 
~Randy

