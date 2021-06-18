Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B778A3AC160
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 05:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhFRDel (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 23:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhFRDek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 23:34:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07B3C061760
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 20:32:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i34so1028761pgl.9
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 20:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1IR2Jtwu8aWSfR50DxaFiQcomIN7MP6Klsy7f1btCzI=;
        b=TtMv60lza7lNizDysWmmBY57vOoGikPqFdk0B+a5JlDmUhvJPek2Y+q9Omq+R3+B2w
         ytlzcFCqwdBfo8K8WT4sR399ZKqYlmspHEk3mXH7Ne69p66UX+1Qr0GrnZkPb66BN/Lv
         9t6SOXBbI15cJrifYX03qatIhO7ieAAPs6mD+Gv1nanvG5OmS0+xzBkOgNvoREYNYxEZ
         LIP8yp6/O/8ULcITglX0svfJzbg0wcST6jc6nLLWuemQbjazFo2TPy2vsAnU+i8vvVZ6
         Mgmv3uFgwrhVlHcZpFoluSG0vF8ip10pkMuLm3IcM9u3aPRveQTiw1l8tYK2AEg7MSb2
         Lx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1IR2Jtwu8aWSfR50DxaFiQcomIN7MP6Klsy7f1btCzI=;
        b=WegL9CIMJhmlq5ovbhUki55aBr+We2CnTpBmcDp8BP0Pku8WN7md+OAz1jhqJAME02
         j/sfUEqim9XwbDu2EEsLpptl4I8dzJD4eBw640XxHXlr0gZAMFY1lOhsawJKdCu0aV1k
         tB28kfAY5AwTv3SUZ818nhrdHXzJ2mADrVcTB5wrEbO3CW6KCVMT2mYpwcmABUXHfpo0
         NkAJv7IxpPfBgN0peZMg3O/QIcGtoOQ9xiq5bOuNeu/XULvUQ4lpR9+d2IVXiYj/d7Yl
         5W394bb8/FQBXYL8HrTaLps+kFTvvFreApNT3HyGDYSWzxf4S9zQ9TqioQZ3OHuqCZrP
         jQOg==
X-Gm-Message-State: AOAM530Svo9weY6iYNWr6oYM+KmMvWBhcKl3RuQagJ/IPfbs/KNoJF4Y
        GrrdRSamwN+t7qpEhNg8aMetkQ==
X-Google-Smtp-Source: ABdhPJyZujAfTBJoBP8IoVxzcmnKXOahTuBWcxxJtVS8tTuDE26rzuzY5dgIrUd7sosptn/B+2loYg==
X-Received: by 2002:a63:1011:: with SMTP id f17mr8066798pgl.274.1623987151163;
        Thu, 17 Jun 2021 20:32:31 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id r14sm6072661pgm.28.2021.06.17.20.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 20:32:30 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:02:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] opp: remove redundant continue statement
Message-ID: <20210618033228.mork47zl3xydwb34@vireshk-i7>
References: <20210617135020.16415-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617135020.16415-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-21, 14:50, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement at the end of a for-loop has no effect,
> remove it.
> 
> Addresses-Coverity: ("Continue has no effect")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/opp/of.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 9573facce53a..d298e38aaf7e 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -197,10 +197,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  		required_opp_tables[i] = _find_table_of_opp_np(required_np);
>  		of_node_put(required_np);
>  
> -		if (IS_ERR(required_opp_tables[i])) {
> +		if (IS_ERR(required_opp_tables[i]))
>  			lazy = true;
> -			continue;
> -		}
>  	}

I had to merge this with:

"opp: Allow required-opps to be used for non genpd use cases"

Thanks for the report anyway :)

-- 
viresh
