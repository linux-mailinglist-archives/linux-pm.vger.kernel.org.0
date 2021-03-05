Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEF32E0AE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 05:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCEEYF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 23:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhCEEYF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 23:24:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07596C061574
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 20:24:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s16so723934plr.9
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 20:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HtxKgLnDbZmtVO4z48HYTdMJ972OxE6DOGqpFiyH4e0=;
        b=E2ydhqrgD+aOyLA/U6w68roveyJRay0UKbw2XKoCd4QzSTG3/5J5+wvhS3l6uGcS/0
         8fZRZUTzIfLdL3SIbfoAhyrCDbypUkm3tyKKnRpy1zPnkSY+2oZhC2UEprBIimMX9X41
         iXyQgKbIXRe18LIy3YRzo8T7XL/nBB1GcS0KLMQmX5V9T0i7FSz1Inzri3ba46su3RCW
         j2ZCTLvmhQ47Bj+KGfc1t5h8dyYojwU6rB36KFI9jVohrguKknTqXVJa5tG8WKCQCAgI
         8AajB9aaYIhWAhXy1WE+e9Y04cxOe18iPW6TNX0c2IUIqXoBMNV0wpcasvqmJFaMnDq/
         2dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HtxKgLnDbZmtVO4z48HYTdMJ972OxE6DOGqpFiyH4e0=;
        b=Ul4Htlf2ONoBaW1U+aMhgcbtNrkerG49tccYbOsgx6ovNbPhX+XjzCVRjnRmxMYojM
         0xINe+XfcXXQLuyxVhrvNVx/6/4T5R0VUnoVRjv0N9CO3bKCQZfMJ7pmdgUUmnA/VP+w
         931BidRMJA/7KCqtBO/IGT8jGAYT31PTIqRunXJ464527ruRDHg9ncF9fU+S7P9CV+1R
         6+Wrf5+jjYcPAaK1npiIoHX4zDdUGCp/0bf9HoXTCkZnrSIdhs7pXKVEp/cDJeHECa7A
         xctDyJIK0lb4MQsIcQ+K0hIo6D8TWd+rhwhL3EIPe3D6Ndo4Xb8thqM8qAs1xNLh6rMs
         tP8w==
X-Gm-Message-State: AOAM533PYneZPBWLAtWq2NUkcQHgl1lyR0I+cfmqSVH+4rOzaaJVEC4L
        MEBPAWLj7OaNpZTrax3PkHVEnA==
X-Google-Smtp-Source: ABdhPJzKpidnV8/JWdBNV7owG/V8CyaTrTVt46bwWXNeOp+FG3g/+iue92wHTArhSXHln1eaea7V8g==
X-Received: by 2002:a17:90a:f0cf:: with SMTP id fa15mr8393500pjb.20.1614918244488;
        Thu, 04 Mar 2021 20:24:04 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id 1sm872919pfh.90.2021.03.04.20.24.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 20:24:03 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:54:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210305042401.gktrgach4dzxp7on@vireshk-i7>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-03-21, 15:07, Beata Michalska wrote:
> The current_opp when set, grabs additional reference on the opp,
> which is then supposed to be dropped upon releasing the opp table.
> Still both dev_pm_opp_remove_table and dev_pm_opp_remove_all_dynamic
> will completely drain the OPPs list, including dropping the additional
> reference on current_opp. This may lead to an attempt to access
> memory that has already been released. Make sure that while draining
> the list (in both dynamic and static cases) the current_opp gets
> actually invalidated.
> 
> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  drivers/opp/core.c | 49 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c268938..10e65c4 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1502,10 +1502,39 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
>  	return opp;
>  }
>  
> -bool _opp_remove_all_static(struct opp_table *opp_table)
> +static int __opp_drain_list(struct opp_table *opp_table, bool dynamic)
>  {
>  	struct dev_pm_opp *opp;
> +	int count = 0;
> +
> +	/*
> +	 * Can't remove the OPP from under the lock, debugfs removal needs to
> +	 * happen lock less to avoid circular dependency issues.
> +	 */
> +	while ((opp = _opp_get_next(opp_table, dynamic))) {
> +		/*
> +		 * The current_opp has extra hold on the ref count,
> +		 * still the draining here will result in all of them
> +		 * being dropped completely, so make
> +		 * sure no one will try to access the current_opp
> +		 * afterwords
> +		 */
> +		if (opp_table->current_opp == opp &&
> +		    !(kref_read(&opp->kref) - 1))
> +			opp_table->current_opp = NULL;

Did you miss looking at:

static void _opp_table_kref_release(struct kref *kref)
{
        ...

	if (opp_table->current_opp)
		dev_pm_opp_put(opp_table->current_opp);

        ...
}

?

This is the place where the last reference to the current_opp is released and so
we shouldn't have any invalid access to it anywhere else.

Or am I missing some context here ?

-- 
viresh
