Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABFDF251F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbfKGCQj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:16:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37012 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732993AbfKGCQi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:16:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id p13so372882pll.4
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AI+gOwu1aF+3wMT+S8NoxHwlmqoW9zMH8lPYLClUpPk=;
        b=gP7dFUEnFihI25GGxa8lsykD8HeDcyiUUL6WzOBIVMtjJSfZf5mSEt4eDVgkyX5CoH
         HtWoQ6zG9C31Z+W9YUiXd0KvhEiIbu6bFbS3MlCaEXcFoeYZBQeCj5wU5kV9YJNEB13r
         0OLNv8un2qeVJHWSjMJYcnreQdsi9zFqNp2MqbsKecLyqILhhZV4ydvF8zTgQlk3DXhM
         dg+B2ViHdjrZxi4/FmRLkL09YmyLcZ24xAVwQMjEbQzRrXcVptebZQXy+9jA62BlwWlX
         lp4rziFmOACU4w8Up7bUUq9/4xmv66ASIhYBSAOm/GQ+fyK47TilloBPtiJWzfBhTYuI
         cjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AI+gOwu1aF+3wMT+S8NoxHwlmqoW9zMH8lPYLClUpPk=;
        b=DZHIMVXYWS2MAcOuJhr4hKUlI70ZHKMsWEL2E5VhUXECmVvDrWJIcTi5fIKgEDpaDV
         bI5QDF/MzDBXiRxlzA+0EnvwbiYi0KW2K4q9NpkEtJbkmmogBsTbZLyyXLdC+TEMGyeg
         krMdvx7YNpPjeICcsAGmv7uydjMOr43R13undhS1YvGUfX0SdAD8FXyo5KzGyWq3BFfv
         FEt/B49EFZu4rPHKe4TI59t3C8/bC7mgLdmvJjYP1myi0Tz9ll4YNJcStEZvrCuKiMEw
         XX5bbZEms8+BZIxzMhXPnxcp1ZxtVf0V0ym8xnBv+sqpk7jYp0v6u0Kw8YQTBjgwlfXU
         sGQg==
X-Gm-Message-State: APjAAAXzdYH/syKljamsY/UaPo91xv8G9+jzHt/W1ixTRAnzVslY1W04
        0z93Kjl7HSy4vJ9Frd1ePylK7w==
X-Google-Smtp-Source: APXvYqwiYAepICA9XmaVPKja22U7qJx9Tfo/GSQ06nwMynGCQAhxmAR45aY2J+N3PZrrC1+wAoXupw==
X-Received: by 2002:a17:902:a510:: with SMTP id s16mr994637plq.332.1573092997605;
        Wed, 06 Nov 2019 18:16:37 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id w7sm323241pfb.101.2019.11.06.18.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:16:36 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:46:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/11] thermal: step_wise: Appease the kernel-doc deity
Message-ID: <20191107021633.6c4h2u4c4vl4ebln@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <fe3fc4028189d45f8a20da48501e0ea09f2b5236.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3fc4028189d45f8a20da48501e0ea09f2b5236.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Replace - with : to appease the kernel-doc gods and fix warnings such as
> the following when compiled with make W=1:
> 
> linux-amit.git/drivers/thermal/step_wise.c:187: warning: Function
> parameter or member 'tz' not described in 'step_wise_throttle'
> linux-amit.git/drivers/thermal/step_wise.c:187: warning: Function
> parameter or member 'trip' not described in 'step_wise_throttle'
> 
> linux.git/drivers/thermal/fair_share.c:79: warning: Function parameter
> or member 'tz' not described in 'fair_share_throttle'
> linux.git/drivers/thermal/fair_share.c:79: warning: Function parameter
> or member 'trip' not described in 'fair_share_throttle'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/fair_share.c    | 4 ++--
>  drivers/thermal/gov_bang_bang.c | 4 ++--
>  drivers/thermal/step_wise.c     | 4 ++--
>  drivers/thermal/user_space.c    | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> index afd99f668c65d..aaa07180ab482 100644
> --- a/drivers/thermal/fair_share.c
> +++ b/drivers/thermal/fair_share.c
> @@ -58,8 +58,8 @@ static long get_target_state(struct thermal_zone_device *tz,
>  
>  /**
>   * fair_share_throttle - throttles devices associated with the given zone
> - * @tz - thermal_zone_device
> - * @trip - trip point index
> + * @tz: thermal_zone_device
> + * @trip: trip point index
>   *
>   * Throttling Logic: This uses three parameters to calculate the new
>   * throttle state of the cooling devices associated with the given zone.
> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
> index b831fc77cf64a..991a1c54296de 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -71,8 +71,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  
>  /**
>   * bang_bang_control - controls devices associated with the given zone
> - * @tz - thermal_zone_device
> - * @trip - the trip point
> + * @tz: thermal_zone_device
> + * @trip: the trip point
>   *
>   * Regulation Logic: a two point regulation, deliver cooling state depending
>   * on the previous state shown in this diagram:
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 6e051cbd824ff..2ae7198d3067c 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -174,8 +174,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  
>  /**
>   * step_wise_throttle - throttles devices associated with the given zone
> - * @tz - thermal_zone_device
> - * @trip - trip point index
> + * @tz: thermal_zone_device
> + * @trip: trip point index
>   *
>   * Throttling Logic: This uses the trend of the thermal zone to throttle.
>   * If the thermal zone is 'heating up' this throttles all the cooling
> diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
> index 962873fd92425..293cffd9c8adb 100644
> --- a/drivers/thermal/user_space.c
> +++ b/drivers/thermal/user_space.c
> @@ -17,8 +17,8 @@
>  
>  /**
>   * notify_user_space - Notifies user space about thermal events
> - * @tz - thermal_zone_device
> - * @trip - trip point index
> + * @tz: thermal_zone_device
> + * @trip: trip point index
>   *
>   * This function notifies the user space through UEvents.
>   */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
