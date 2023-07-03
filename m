Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C62745404
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 05:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjGCDB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 23:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGCDBy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 23:01:54 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA5E40
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 20:01:52 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76754b9eac0so176361585a.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688353311; x=1690945311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjyh3GtK+R5C3rMXx/WtR6Q6tk1qQkvOCfKCK4nSvD8=;
        b=oeF7X0/s6rjJdfuF75CMy22fbngqq3qO98CdvpfG+vKUl5BhnE5dUjCSlGfi0LK2cT
         kK/H+YCAaeK0Wt4QxrKBiMeFYltEArekjRV68QzQ/kp20VMp2w8hiLv5nYfM4wd2rk/q
         dGMsYrSWRPQJ7Opd/KT105MDGh8n4thPW20fl3GAhmLeQQSVD/plo09vhct92Oud/eFr
         00HsIb+4mNowfw9k9e02nBmcJPsZzlIJreVSBY/gyhjsiG6JHQiGYJQ3NEniFFEhROkR
         +Xjd7apYDWAhaFSZIqwyzkvL6xab8WvvKmJbMDDhgvISkwBQtC4U8DNiYhiMR3x2rnel
         QhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688353311; x=1690945311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjyh3GtK+R5C3rMXx/WtR6Q6tk1qQkvOCfKCK4nSvD8=;
        b=iZRMBuomSdthLzEbP8wUC5B7Gd9x1wO8E8CBLRn5GTKqgqsqDALbyzl031vncTSF9p
         cLiIyzgTnSp9DS47AoR25oqftRsKqwDzDFmPRSJwpfXPyA7akkOb3+7fNBTjU8ry2Ez6
         bToTpq3Mm0vJwTl5UqKwMMGSanyRpLyez0+d/eUvwPtAlhg1WrKOVmtOpCifNvfqHnSj
         tIrv2qeczgXXziDYWvbUnrnkpl2crOCw8PRN/TBJ5axpNwynHCovE6VV7cwAe2q5gSDt
         bU1d4t/ZidyQlK2JbuKF/v+E/ESeSiEjKNJD0VKeK4wIFOMCC9XSHsRITELFp7kd/1TC
         bYVQ==
X-Gm-Message-State: AC+VfDyStyC9mcDaWS95Ccy2znM+pIvJ3f41ofvW6SlhLAtB0dAfQIlg
        0H0XofW6W30cMvuDTn72SSXiSA==
X-Google-Smtp-Source: ACHHUZ7zEWBGw11hn9CutuzNOAsF/ItUVATKgr/3z9aXor3X5TI0VMp4nfcy31WyWtPRQ+2gigyc4g==
X-Received: by 2002:a05:620a:22ea:b0:763:e407:4eec with SMTP id p10-20020a05620a22ea00b00763e4074eecmr8718582qki.50.1688353311183;
        Sun, 02 Jul 2023 20:01:51 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79183000000b006828e49c04csm1026365pfa.75.2023.07.02.20.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 20:01:50 -0700 (PDT)
Date:   Mon, 3 Jul 2023 08:31:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pmac32: Use of_property_read_reg() to parse
 "reg"
Message-ID: <20230703030148.qqszljkgnyzt52da@vireshk-i7>
References: <20230609183111.1765507-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609183111.1765507-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-06-23, 12:31, Rob Herring wrote:
> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index ec75e79659ac..f53635ba16c1 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -378,10 +378,9 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  static u32 read_gpio(struct device_node *np)
>  {
> -	const u32 *reg = of_get_property(np, "reg", NULL);
> -	u32 offset;
> +	u64 offset;
>  
> -	if (reg == NULL)
> +	if (of_property_read_reg(np, 0, &offset, NULL) < 0)
>  		return 0;
>  	/* That works for all keylargos but shall be fixed properly
>  	 * some day... The problem is that it seems we can't rely

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
