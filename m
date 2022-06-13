Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07734548178
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 10:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiFMIHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 04:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiFMIHK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 04:07:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3EE1DA66
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 01:07:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r1so4443671plo.10
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NAnCKVAsTEhPSq2ToTCbXC57xyJHYe3j2r1i7OIyalw=;
        b=V1UdsmWZvkna5Og+wp9V9OhZ74oPWa3gXSouojsCAYSZvlbWaZLc+V3drwHq1d9aS4
         9ha4nB7o6FF/D6g1xtIDQfME5FR1R/JMy0oPtO5ge1VDZKjOSg0aDoDsTKCVUAHE2XHj
         YpzBrZSf7wC4TWwYMJrzFu+28onHUpIMJOfjxZnTgyXKIANMTi6tfzBYgw9OGnEmPaa1
         Qr51eRrM5ywNHh9SZRCn8xW5KOABQoOZ1uXM/zVMKJ4TxzZ/ZTDQ1rXbzbeKPnkDM8EL
         g2gA3mA7t5wd1ARIhviXJn5+j4Wc/mObKTKJ8WsR/5lWd4skFgxw3s4YL8553cpzcnwR
         347g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAnCKVAsTEhPSq2ToTCbXC57xyJHYe3j2r1i7OIyalw=;
        b=QEaF1UDkVYPSqv/cK8hS08nnaGB+eJg/OdKYe/IkIE6Gek/tSeIhRH+exMRehEwqJd
         kwjH256InrL10VzFyU9HHfSYhgbO/ZUmnUfutsqM+mRk2vTRdtCHVvQ0mJV4zsU2F2o6
         goFqes5aYz16ofdBQLKMYqC0ceRw4/4r/ls/WH8emKhKqeK6JcE4E5Z9oNOZjuFyNEZl
         s6ps+AyKS7JbSiAoZGa4pEWJYNN2ma3xWZ+GN3mOVV1kooIMenx9dG/FxAiZfXD3q4nk
         pOWTnLNgJVpWMVs9p0VkgFDd0EWPBcCqkY6RORhR8vX1SWkpq7qIiVoNRG1C7w+a71Ao
         Bpvg==
X-Gm-Message-State: AOAM531Q3+P3qfwca9JQXEEg1aD8VKh/wAsayMHwLkTOYBa/1GrKXimf
        gj3S8XWlSJgHL3x3ZaKvcNxVsQ==
X-Google-Smtp-Source: ABdhPJzUrwojqHns8Mqu86SJy95KqHGbbVXITBu6/zRUhIZ0SRPlREnaaGmuSW6OAYScSGh9OkHu5Q==
X-Received: by 2002:a17:90a:6284:b0:1df:4595:57af with SMTP id d4-20020a17090a628400b001df459557afmr14316872pjj.188.1655107629257;
        Mon, 13 Jun 2022 01:07:09 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id mi16-20020a17090b4b5000b001e0c1044ceasm4531596pjb.43.2022.06.13.01.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:07:08 -0700 (PDT)
Date:   Mon, 13 Jun 2022 13:37:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220613080706.jqilerx6jc4m2pxh@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-06-22, 13:50, Viresh Kumar wrote:
> @@ -1594,24 +1601,28 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
>  struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table)
>  {
>  	struct dev_pm_opp *opp;
> -	int supply_count, supply_size, icc_size;
> +	int supply_count, supply_size, icc_size, clk_size;
>  
>  	/* Allocate space for at least one supply */
>  	supply_count = opp_table->regulator_count > 0 ?
>  			opp_table->regulator_count : 1;
>  	supply_size = sizeof(*opp->supplies) * supply_count;
> +	clk_size = sizeof(*opp->rates) * opp_table->clk_count;
>  	icc_size = sizeof(*opp->bandwidth) * opp_table->path_count;
>  
>  	/* allocate new OPP node and supplies structures */
>  	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);

The change for this line was lost in rebase I think. I have fixed my branch with
this Krzysztof, so testing over it should be fine. Thanks.

-- 
viresh
