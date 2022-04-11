Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC84FB20F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 04:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244440AbiDKCzr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Apr 2022 22:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiDKCzq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2022 22:55:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50834BA4
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 19:53:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so15346687pjk.4
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 19:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mwYIjlJt8zbN56INdAix21qgimZ3+ODm37YcFq9UmAU=;
        b=p6ilP60cadhsOoFS3+EMGPtfazxAC1eFmqnVF08ggj518PBEd12kRbqaZ8knXIXW/J
         BzhgcZ7wIpaZUju56TfIhybWt5b0KtTtQux4iazdwEkAn5AL0dysAzh1p9A43PEYUBmp
         V49SEnJBLVlCX7qypUqbjsQUsW+L/BFERs4g0mGmOxc/DrJysnS8VCYUeChLbzKdG6Pu
         8mJPF25Kzoxt+Aw3tiZ8WKVZjmbyv5fDkzgQBfkSK6u2k3djz1SeP/yz4c/ljulp85tb
         FYHQuOYwRVJXuR2iscaO9pPztBrAFtr86sFJ8KtD5aRRM6Ya76CYz6S1X3I1v4siI/ZN
         l/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mwYIjlJt8zbN56INdAix21qgimZ3+ODm37YcFq9UmAU=;
        b=bnq/gP4y5T2KEBag/dEgDE2xwMZZcnVHcqyUr+QSwhnEQyA5VHiztTIL9TZWuDNZ2k
         EC01kLqBc9BZyO+0sec8ajcELnBjDeX24HgCMbTzWABe5Ofli20eCIPlMuvPpGcLsQPo
         SZ9cpIOJgBTYnNVLB9Y8eIb6UfcZIKXyyzFOUgRZkep8DIeAEa6k7c2WlSAnHM5f8j0C
         braFMqOYTXIrpqME361QYP+imEF556N37g4ioPzNo7tjbvrQh7FEgFP0/Cm69/VNOlDL
         xj/XC2MfvungGyp+UCOO5h6Qhz3jY/UCOTnT9ekBzNQHl7EkhvO5sW1zdzBBq5+ZPSwH
         yLcQ==
X-Gm-Message-State: AOAM533qLoWYFym6/sCn4N4l8dc2XiRDRkj0/E19fhef69dzPqXZhlCL
        J69GCvZwPbG6HcDyVN/Yr63NhQ==
X-Google-Smtp-Source: ABdhPJwEQQIubFxoIGWk2V8I9cAgfxjQheMjhYPv/nFlI5GwVfXYSu+RtST1yuQq6FuNUSCto9E3ew==
X-Received: by 2002:a17:90b:4b84:b0:1cb:6cf5:d2ff with SMTP id lr4-20020a17090b4b8400b001cb6cf5d2ffmr9051371pjb.41.1649645613281;
        Sun, 10 Apr 2022 19:53:33 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79f98000000b0050564c90916sm13339084pfr.200.2022.04.10.19.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 19:53:32 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:23:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: opp: simplify with dev_err_probe()
Message-ID: <20220411025331.pog2flqxicrnz7jv@vireshk-i7>
References: <20220408111052.381603-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408111052.381603-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-04-22, 13:10, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/opp/core.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0b5357b9d342..ed72df835f8c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2030,10 +2030,9 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>  	for (i = 0; i < count; i++) {
>  		reg = regulator_get_optional(dev, names[i]);
>  		if (IS_ERR(reg)) {
> -			ret = PTR_ERR(reg);
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(dev, "%s: no regulator (%s) found: %d\n",
> -					__func__, names[i], ret);
> +			ret = dev_err_probe(dev, PTR_ERR(reg),
> +					    "%s: no regulator (%s) found\n",
> +					    __func__, names[i]);
>  			goto free_regulators;
>  		}
>  
> @@ -2179,11 +2178,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
>  	/* Find clk for the device */
>  	opp_table->clk = clk_get(dev, name);
>  	if (IS_ERR(opp_table->clk)) {
> -		ret = PTR_ERR(opp_table->clk);
> -		if (ret != -EPROBE_DEFER) {
> -			dev_err(dev, "%s: Couldn't find clock: %d\n", __func__,
> -				ret);
> -		}
> +		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
> +				    "%s: Couldn't find clock\n", __func__);
>  		goto err;
>  	}

Applied. Thanks.

-- 
viresh
