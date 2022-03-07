Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FEC4CF121
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 06:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiCGF2l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 00:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCGF2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 00:28:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F5A1FA62
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 21:27:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m22so12323440pja.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 21:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8/7RqUDbBvkcKrvkMx+8/f1EbXxbw2ANcs0FhA/Hi8Q=;
        b=c8sv0sHzNIegotqovgxtmem5mZxrITTXtkOPZoO5n9qBoAwgfHjebvCysLnMyDBsab
         +7p48moCE+Wbw9JUcyxCULHk6PpOPPo60Upd55fu27mdvGPHotjzZ+YKHVrDXn+Nxeea
         4HUGFTT88J8DTxsHRrgSqyWYK7k5QplQmfpB0Qs1Ph79Upr9I+TkrVOgEUMFvepYQ1so
         rfB90K3SwfmVm9vO52+GzOAYnOAszE+jJSuLkX5Uio3kkY8gIapGET46I4UjsrkhbALX
         C0aB/09NOZff480xoV9O62FUDJhNiKYVac8devwk/ZprBkHqpeMtWdSPKIMgwPdx4FJF
         1ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8/7RqUDbBvkcKrvkMx+8/f1EbXxbw2ANcs0FhA/Hi8Q=;
        b=B6EX+P1H/pxO69qUTHkUNfaaMxejwPWti1D8dBSzrjniRzidnqjyBXAMKB15dFabNY
         4IYajNc/a+pd1X4v5w76kFO0sCDNCmFNLEuao002/BrY87ZjgE/5bRO/i/dn7ACDPxia
         5qirKkWnjDbWhKbXABqGUi3AUzoySiLSMxQJJfIROzgArduDysLtWGGa20lQYHVICrmu
         Ypw4vqibmQs3GDFjYh5SFR9CTMlCuEUEEZVI2SeEtaael9di0Naes3wrUyCBhD00eC7M
         l5jPvNqPYVz7eObDrDnJurTn/UzjxQm1LDPJEfNFK0KS78uxs3KpnIFdLb96uiu5q9Bd
         Zmvg==
X-Gm-Message-State: AOAM533Z/oQOkp8SGdqODD6IobcUopI7aomEqLRNTX/ku3Ls1y3Eodgg
        ycwtz8p2HN8PgLXUhfYmE8QlSA==
X-Google-Smtp-Source: ABdhPJxbu+Rdv7+IwbG4bwBry82DczhbBPsEbSCO1AL5s9L40k2ooBzCYz+peNHV9i+vLYh1i4GRrg==
X-Received: by 2002:a17:903:110d:b0:14f:72a1:7b18 with SMTP id n13-20020a170903110d00b0014f72a17b18mr10573418plh.111.1646630867103;
        Sun, 06 Mar 2022 21:27:47 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a551500b001b90ef40301sm11843637pji.22.2022.03.06.21.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:27:46 -0800 (PST)
Date:   Mon, 7 Mar 2022 10:57:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] opp: Don't print error message if getting optional
 regulator fails
Message-ID: <20220307052744.s4ed3vinz5umbtlm@vireshk-i7>
References: <91e37a12-b393-8ae9-996b-6cbb63ea9255@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e37a12-b393-8ae9-996b-6cbb63ea9255@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-03-22, 22:46, Heiner Kallweit wrote:
> The regulators are optional, therefore I see no need to bother users
> with an error level message if -ENODEV is returned.
> 
> Inspiration was the following error on my system:
> lima d00c0000.gpu: dev_pm_opp_set_regulators: no regulator (mali) found: -19
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/opp/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 740407252..8af5979cc 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2020,7 +2020,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,

If this API is called by the platform specific code, then the
regulator should be compulsory. Isn't it ?

Maybe we shouldn't use regulator_get_optional() here.

>  		reg = regulator_get_optional(dev, names[i]);
>  		if (IS_ERR(reg)) {
>  			ret = PTR_ERR(reg);
> -			if (ret != -EPROBE_DEFER)
> +			if (ret == -ENODEV)
> +				dev_info(dev, "%s: no regulator (%s) found\n",
> +					 __func__, names[i]);
> +			else if (ret != -EPROBE_DEFER)
>  				dev_err(dev, "%s: no regulator (%s) found: %d\n",
>  					__func__, names[i], ret);
>  			goto free_regulators;

-- 
viresh
