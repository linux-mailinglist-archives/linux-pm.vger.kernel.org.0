Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2E429BDD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 05:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhJLDXt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 23:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhJLDXs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 23:23:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF961C06161C
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 20:21:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g5so9553351plg.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 20:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mindqxxsMB6gVGzm2IFNuF4jPvZILQH7yCXhl2T6zNY=;
        b=QZJA/iS3B13DGkdmHHQotUlufTPmZqEGPTk+YGQR9U9cZt52XOM0UkmxMY/C1/lbjo
         J3YW4Msr9PuEL5PUrM/pEs5lIYJBFuufQQruMV5zgAOkX8ePRf5NVRb/5CO9XJ0u1siO
         1tBQkFEmWxax2bPkxeAH7diqEYZO8Kzeruq2cuHv67l3HiGT7x8b+Ug/DRNRnno0T39b
         Q04SyzYt4oTHgnlDHgFq5wZYj7mPmVHjbAMVBQ2OKQWyPw+lKmSm/65N1iaaZH4pNwT1
         kslCi4b8X6bgbbpgMQwptWWKFwkwaepWmMpTUpyxZqwssknfAwBZWmedud53BqzfT5Jj
         PzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mindqxxsMB6gVGzm2IFNuF4jPvZILQH7yCXhl2T6zNY=;
        b=PLuagu85Lu0J4V5yQcXZPrGUAwQPbvOo/zcemUcjRXEQVIwbBvSmuxIjxSWdXnAaEO
         o/YMKZuu9FP36pn66nGmvRVPCMBquErcLl0yki0duQoy5lfVXq1Ujc8d2AjKaw76Ze5M
         04D+YZklciW+OMZQHujJEJLRQ+AtZxlxOvoIsIVv7a0pCVLls3BqlHtxC8lnAIbGTkgG
         48ifNRzy1DZA49KADlllJtpsd7QX3OGbDtIEnAyAKK0eQar52TKQVaWQSCZu/dVFZ48E
         jCRV7L9L4DipzZ6Hyq9+Sfumx2DaPBmPn8PS35riIRgIj1murQdbKERjWZY6ZU/gqcCk
         eYAA==
X-Gm-Message-State: AOAM531TKmHSutxN1XhxlC2qMGYCu5RxZnjegjY5IUABraGByfUGq0yS
        mF1bfee2h1ryOUL8bAwc37zMyA==
X-Google-Smtp-Source: ABdhPJy+1lpNhmLNBJe3RH5BEItdUMqGMbgnXp9vZo25wQRTtyx7yUrY2QLo0Yap+EDx7zbe8I8/hw==
X-Received: by 2002:a17:90a:578e:: with SMTP id g14mr3268069pji.184.1634008907137;
        Mon, 11 Oct 2021 20:21:47 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id u17sm810195pjn.30.2021.10.11.20.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:21:46 -0700 (PDT)
Date:   Tue, 12 Oct 2021 08:51:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device
 does not exist
Message-ID: <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011165707.138157-5-marcan@marcan.st>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-21, 01:57, Hector Martin wrote:
> When required-opps is used in CPU OPP tables, there is no parent power
> domain to drive it. Squelch this error, to allow a clock driver to
> handle this directly instead.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/opp/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 04b4691a8aac..89e616721f70 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -873,12 +873,13 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
>  		return 0;
>  
>  	ret = dev_pm_genpd_set_performance_state(pd_dev, pstate);
> -	if (ret) {
> +	if (ret && ret != -ENODEV) {
>  		dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
>  			dev_name(pd_dev), pstate, ret);
> +		return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /* This is only called for PM domain for now */

I am not sure why you need this, since _set_required_opps() has this check:

	if (unlikely(!required_opp_tables[0]->is_genpd)) {
		dev_err(dev, "required-opps don't belong to a genpd\n");
		return -ENOENT;
	}

-- 
viresh
