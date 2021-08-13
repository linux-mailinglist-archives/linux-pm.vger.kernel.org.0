Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E040D3EAF1A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 06:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhHMEMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 00:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhHMEMy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 00:12:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E358C0617A8
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 21:12:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so9945740pje.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 21:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NSKiSP+VuZbySQVbJIy2ItyhUu8xuFfwgMBa7ttLiU=;
        b=V368k3JFhLvKxY7VE7ceRV1/PU3gL14wHNRNZ65yR30XkuqzGfLUiiUj9iLXkrRHZJ
         IQBRcbNcmzqC97b251H0Zma9wj9VfltAZfQLhPppM43TTXMToMJ9GjH9E8L3DmhYA6SZ
         vwgmgWLUD5YiyJ5tsf8sqMdyWaU+u74KnoWAWk/YiVCvMoERPYbFL2P8rNTGIstZthu+
         VQZ0uePHUpjpfKDZpOfSqarA57OlxD8KXsBzwjPJXca8vjUmirpAdBWppYYQE26EmqoS
         4JCK9Xu0fgb01903HF3eW2uxT8tDMNycAbu/IyLSXjjLbOmKYjtFCpgg2v4qUYw2za+8
         NJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NSKiSP+VuZbySQVbJIy2ItyhUu8xuFfwgMBa7ttLiU=;
        b=cz+wTtlzOjwsoVTxaVSMt7DH2SRnxZ1iiOjuy1rtVOlGrGX1ks3bb48PNo5XBKEwGw
         ATp1qAvuD/PiBUF/6DlXvDD5hz/tNRCJ8ghXZBLNRxtxWErcLHEPlxUSVACMKHIeLwEd
         Ziz4Rh9//tKsLMCEQN9YOzWSFK5UQ3+LixUlYW7ajf7Z0l2LoeviHsrH46l8Y5SiqejX
         Wzg2OBtbfL8eDniuqTjrXNHChZNTtHUBuAjqJ2bWFOHWWaiBo8uXu1V8pSVn2izdVw+g
         8W9qkdyRbPM65rg7t6r77C5R6Wa6uj5XbGOnJZwJCj9AiRzvECHmCrzMG+A1jhIgM0pf
         3+3w==
X-Gm-Message-State: AOAM532qWTxbid9yP0aXUeE+vvOoeO9A71k7riePh9tnMEQKKkBiTLOL
        MUNdc9C6oYdkP1LLrgTNFNMcJw==
X-Google-Smtp-Source: ABdhPJxSMEu76XmMWmPEJXM16ZkzDqGuwMxS8zWmY94EFDKPPEN3ik1qhjYxbxqoRqEA1Q+P4Bit4w==
X-Received: by 2002:a65:680d:: with SMTP id l13mr468254pgt.307.1628827947656;
        Thu, 12 Aug 2021 21:12:27 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id 125sm359239pfy.17.2021.08.12.21.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 21:12:27 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:42:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] opp: Release current OPP properly
Message-ID: <20210813041224.dqz3kbynr5ffjclj@vireshk-i7>
References: <20210812101353.14318-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812101353.14318-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-08-21, 13:13, Dmitry Osipenko wrote:
> The current_opp is released only when whole OPP table is released,
> otherwise it's only marked as removed by dev_pm_opp_remove_table().
> Functions like dev_pm_opp_put_clkname() and dev_pm_opp_put_supported_hw()
> are checking whether OPP table is empty and it's not if current_opp is
> set since it holds the refcount of OPP, this produces a noisy warning
> from these functions about busy OPP table. Release current_opp when
> OPP table is removed to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index b335c077f215..73da968b5c86 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1378,9 +1378,6 @@ static void _opp_table_kref_release(struct kref *kref)
>  	list_del(&opp_table->node);
>  	mutex_unlock(&opp_table_lock);
>  
> -	if (opp_table->current_opp)
> -		dev_pm_opp_put(opp_table->current_opp);
> -
>  	_of_clear_opp_table(opp_table);
>  
>  	/* Release clk */
> @@ -2901,6 +2898,12 @@ void dev_pm_opp_remove_table(struct device *dev)
>  	if (_opp_remove_all_static(opp_table))
>  		dev_pm_opp_put_opp_table(opp_table);
>  
> +	/* Drop reference taken by _find_current_opp() */
> +	if (opp_table->current_opp) {
> +		dev_pm_opp_put(opp_table->current_opp);
> +		opp_table->current_opp = NULL;
> +	}
> +

It is better to drop the reference when the OPP table is really
getting removed.

I think the WARN_ON() in the put_* functions can be dropped. It is
important to check this when the stuff is getting set, like in
dev_pm_opp_set_supported_hw(), but removal is just fine.

-- 
viresh
