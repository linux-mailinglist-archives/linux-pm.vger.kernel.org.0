Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482313F45AD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhHWHQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 03:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbhHWHQX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 03:16:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C31C061756
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:15:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g14so14543063pfm.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FkDzXhaO7yhL5obz+RJLV2+DzBvx1Dzd3oWmGWXLUcE=;
        b=Kw62o/AgkxHphvtBvcWmQh9i8XYMKRL7uFb/SxB/SHuBGwoQaK26/hb2600qCGGaFk
         qMaCi6ndEg63elzWd1yCn4jL33o8Q2+kabo8Cd0EoO5eDcvFTQ8G8+ZG54JA9ryyk7nQ
         UzLfdcinaTFSoPl99LNtGh8E2/E7/7IN9kY7nqpqeR3zi8v7DGCD2MO9nkyGvtO6VGSo
         TTIxfB2tx75IwnaIxryt6eSt1l6Az1mDcv1JzHRGLYlcY/AgcSIcNyvLKRa+758U2B9R
         BrlF5bF0awpFUkGWJ5626yjA+YGbYdARWkFdXBOzWCUZqOKwX4rrlXxT0IIbT3KqLkDO
         G7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FkDzXhaO7yhL5obz+RJLV2+DzBvx1Dzd3oWmGWXLUcE=;
        b=m1ZWOmkJ552JX014LvTgbmhvXUb8sb5uIJoB0atf1iK4zFtqhLU6kbRHCpisxwHAGZ
         QJUSDF6ATRGMYkPuqFwtLbAq4ovS3xj8gWpxtbO0F5kY3N1GBROu7XFIEW6J0wQNwciW
         ctcFsusTQFK/c9isHFt3JxPxAwGr0DhWdhhh9iJhjrR9Hzv5LPzf/CckbSL53JLNDNkW
         bnpt37HYxxx9ZKpN6oEkzICFbD1n5J3jmOKxo6ojtYcheUQ+il0ROdI3AnxoAyeqOECs
         20GlfaN1Tx1naPvHFKIHYXLnD+SIRy6hibkb2zzkJ2Zz/fFm/3F2uQ+uLXrUZOZBfLfe
         1k7g==
X-Gm-Message-State: AOAM532EQk2kfvZGkFQ8VQpw4YHMhT3/X+I7fjurprA17ZAmJLjNj268
        c4Vy0RsJtCqGCneMSJquiJgyGQ==
X-Google-Smtp-Source: ABdhPJxdvJRkKol/3wN7R45JKRsHMgknPHKabVCHvK6WEb8zwrjurwOpUGMFXYuJBFT18T0rdvAh6Q==
X-Received: by 2002:a63:4f51:: with SMTP id p17mr31111296pgl.29.1629702941160;
        Mon, 23 Aug 2021 00:15:41 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id e5sm18331194pjt.15.2021.08.23.00.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:15:40 -0700 (PDT)
Date:   Mon, 23 Aug 2021 12:45:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: core: Check for pending links before reading
 required_opp pointers
Message-ID: <20210823071538.bgfkym7emlq6d7oh@vireshk-i7>
References: <20210822174410.82595-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822174410.82595-1-marijn.suijten@somainline.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-08-21, 19:44, Marijn Suijten wrote:
> Commit 4fa82a87ba55 ("opp: Allow required-opps to be used for non genpd
> use cases") dereferences the pointers in required_opp_tables but these
> might be set to an ERR_PTR if the list still has lazy links pending,
> resulting in segfaults.  Prior to this patch IS_ERR was also checked on
> required_opp_tables[i] before reading ->is_genpd inside
> _opp_table_alloc_required_tables, which is at the same time the
> predicate to add this table to the lazy list.  This segfault is solved
> by reordering the checks to bail on lazy pending tables before reading
> ->is_genpd.
> 
> Fixes: 4fa82a87ba55 ("opp: Allow required-opps to be used for non genpd use cases")
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/opp/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index b335c077f215..4dd26a165c91 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -893,6 +893,10 @@ static int _set_required_opps(struct device *dev,
>  	if (!required_opp_tables)
>  		return 0;
>  
> +	/* required-opps not fully initialized yet */
> +	if (lazy_linking_pending(opp_table))
> +		return -EBUSY;
> +
>  	/*
>  	 * We only support genpd's OPPs in the "required-opps" for now, as we
>  	 * don't know much about other use cases. Error out if the required OPP
> @@ -903,10 +907,6 @@ static int _set_required_opps(struct device *dev,
>  		return -ENOENT;
>  	}
>  
> -	/* required-opps not fully initialized yet */
> -	if (lazy_linking_pending(opp_table))
> -		return -EBUSY;
> -
>  	/* Single genpd case */
>  	if (!genpd_virt_devs)
>  		return _set_required_opp(dev, dev, opp, 0);

Applied. Thanks.

-- 
viresh
