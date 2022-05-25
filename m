Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506475336E2
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiEYGrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiEYGrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 02:47:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7D5FF1C
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 23:47:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d22so17770437plr.9
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hfJguTb36qQ34TuQiZ2VTczu2o5QLaoj2zZp1ypyNzk=;
        b=YEKDGyY2ZmnANjlQKMn1Irwn0CfGR63M2n3Jpmonkkx1AQco+5V0Sb0KZb5o9yO3Yl
         4WrEkjoSr3VtTg0iiudJTL6uqNCVndy5HRWofK/sBbQAHpS7U/kCKVzAZ0tFTZevnQaF
         oJRe/O0iPq9hqk+uthzPVglaweZR7YWtfKuj3UvwjCs9afaEmuMFPu2zCxkAZElMNpQY
         QczibTDTOSEWfCdzaPalz3cMyTg5RXXsTRU5kT/HmlbgvqFP+orEy37dpBTQGV8Hi6kK
         lyb/8VpM82o+PmBNz8EP9wVny5u5Rn99Vw8B9sGlI4xyvZMC1XkT4Dphb5IgPqk/WWVK
         l8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfJguTb36qQ34TuQiZ2VTczu2o5QLaoj2zZp1ypyNzk=;
        b=D0ybi5pWT4uG29Ll4tBMSaqQ+QCPZ5ykug1Vdfa76VZgMjXIyAD9xlAM4LDW0sGtWI
         z5PaVJ9GCJG9+qLNDGxvgo0WzHyPcqFEMYmk/5O4iyjPD/k6I7Dsz8FZjNaGU8VwQx2p
         hs99vQ52JxTf5k/036UyqbRA8lbUI89OPmk5cp1hkV0mpsymnJRCKj/qF0KhjgYalL2E
         GT0bJTaeChLqkhVG8QFEr1gi4hmorTQSmFFY+y2c+ny/gRTHTYBFmNfILNMKlkKYerD7
         mBVzKp2SWsfwn4CXm7idXys2da3mwCZhm5mpxfz12KTOVEzlemWgLfI83JgxZGf+RnFX
         osSw==
X-Gm-Message-State: AOAM532Y2j8pfvH0mgw/7aNeX4TEuXUJfcpJBAqRkk4Q4kgwpkKCerxc
        b7Rg6JpwtvSekMF2G+wP3jzInQ==
X-Google-Smtp-Source: ABdhPJw7CqgkWOzwbw0mfwNHpJMV0qT5ZJw6yUuKKXGEqjx6xFrzaYoNSP5vX8FpNzpadqNsQhyttw==
X-Received: by 2002:a17:90a:bf10:b0:1e0:89b0:7baa with SMTP id c16-20020a17090abf1000b001e089b07baamr5688858pjs.208.1653461254712;
        Tue, 24 May 2022 23:47:34 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id cw25-20020a056a00451900b0050dc76281d3sm10581798pfb.173.2022.05.24.23.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 23:47:34 -0700 (PDT)
Date:   Wed, 25 May 2022 12:17:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Fix error check in dev_pm_opp_attach_genpd()
Message-ID: <20220525064731.k4lgjrcu355b73q6@vireshk-i7>
References: <20220524123151.1416-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524123151.1416-1-tangbin@cmss.chinamobile.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-05-22, 20:31, Tang Bin wrote:
> dev_pm_domain_attach_by_name() may return NULL in some cases,
> so IS_ERR() doesn't meet the requirements. Thus fix it.
> 
> Fixes: 6319aee10e53 ("opp: Attach genpds to devices from within OPP core")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/opp/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2945f3c1c..56cae6ee2 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2409,8 +2409,8 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>  		}
>  
>  		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
> -		if (IS_ERR(virt_dev)) {
> -			ret = PTR_ERR(virt_dev);
> +		if (IS_ERR_OR_NULL(virt_dev)) {
> +			ret = PTR_ERR(virt_dev) ? : -ENODATA;

I have changed this to ENODEV instead.

>  			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
>  			goto err;
>  		}

Applied. Thanks.

-- 
viresh
