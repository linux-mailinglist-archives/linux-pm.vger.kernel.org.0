Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F715E98F0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 07:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiIZFpv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 01:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIZFpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 01:45:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6B12ABC
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2022 22:45:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so12101319pjb.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2022 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=q1MkQ8ILhoEBa3u1R8RbxKh8BDLbaCvY9GtJu4Q7z6E=;
        b=pH3stremd391//HLMBQ6qdN1AET98BpBGv3XILzIY/Hl/oZflhErlSKsjuR9byiu9o
         cEBtihHrT/fG5C46XWwABpAjX9X6ixT7n5lpNFsZkTC+cJoynrySf7VrH6/gyTg3xV/m
         XZ3u2aL4TndEo1Qi72ouHsK8qrwPJ8KzMHyTolDhA/nBIi1zp6i/RIixclo14k2XeLUK
         Od11mvdChBk2ufHxXixPx+OAKz2V7FBkmGZjbcWpJNqoWn0jXGMPPRcFXqxhPGje5ucH
         xjyrvwe6JYxVDMkseDWQq3OFMJvBE0jeKPhp3M6+4GOG1avixqNyuYcwBeU9BeEatcOt
         w+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q1MkQ8ILhoEBa3u1R8RbxKh8BDLbaCvY9GtJu4Q7z6E=;
        b=oDjxgSxbYbSEzPV8UZgPp9XG3RnsR5fcBuBzeB+3suy+v5YVfb8ijF6gWJhczSvBKL
         WsOPr69sfP8h5wn6NM7+YQPLlWDIDUMrFTSLuK0YThWK8DgNncdg0QQhrvoPdUrB2UPm
         4ZQNS9ZCOIrt068Xy7kLPRd1pkkbo3eJOJl6NRAY076YUew0zizrfuqNKGTgbXlyLdoP
         CA0PrUzNICRlMX1wBGTMEnalmsIK5+K0iDBv/trLcpVjJoDGctAZzBVPqzG7DuhcpNb+
         FBr3+uyRoeGdfRKBhjYajmmiSmFqyw1iPivGM7twuM2LpslSldv70xcy5nSAmivWoOV0
         TQFw==
X-Gm-Message-State: ACrzQf135yy2sVvSGMTwonaKWBECfo1oStoxLLk2mXmheGdxQLaEcsE+
        Z554KwbatXZOE8AjswwBuVuAEw==
X-Google-Smtp-Source: AMsMyM7jNgN+M3Y6uOG2CZwy4tq7fVnAS5x8F1fF+IwsiWhduBp2jm8ADVQIVrG+l1FDBWbIYYwTIQ==
X-Received: by 2002:a17:903:120d:b0:178:ab0a:19a1 with SMTP id l13-20020a170903120d00b00178ab0a19a1mr20382501plh.11.1664171145698;
        Sun, 25 Sep 2022 22:45:45 -0700 (PDT)
Received: from localhost ([122.172.85.153])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b002026423d79asm5762961pjb.46.2022.09.25.22.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:45:45 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:15:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     rafael@kernel.org, patrice.chotard@foss.st.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add __init annotation to module init funcs
Message-ID: <20220926054542.7lioabuunsdoeqqy@vireshk-i7>
References: <20220924092159.56594-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924092159.56594-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-09-22, 17:21, Xiu Jianfeng wrote:
> Add missing __init annotation to module init funcs.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/cpufreq/highbank-cpufreq.c | 2 +-
>  drivers/cpufreq/sti-cpufreq.c      | 2 +-
>  drivers/cpufreq/ti-cpufreq.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
> index ac57cddc5f2f..a45864701143 100644
> --- a/drivers/cpufreq/highbank-cpufreq.c
> +++ b/drivers/cpufreq/highbank-cpufreq.c
> @@ -55,7 +55,7 @@ static struct notifier_block hb_cpufreq_clk_nb = {
>  	.notifier_call = hb_cpufreq_clk_notify,
>  };
>  
> -static int hb_cpufreq_driver_init(void)
> +static int __init hb_cpufreq_driver_init(void)
>  {
>  	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
>  	struct device *cpu_dev;
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index a67df90848c2..1a63aeea8711 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -252,7 +252,7 @@ static int sti_cpufreq_fetch_syscon_registers(void)
>  	return 0;
>  }
>  
> -static int sti_cpufreq_init(void)
> +static int __init sti_cpufreq_init(void)
>  {
>  	int ret;
>  
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index df85a77d476b..f64180dd2005 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -398,7 +398,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int ti_cpufreq_init(void)
> +static int __init ti_cpufreq_init(void)
>  {
>  	const struct of_device_id *match;

Applied. Thanks.

-- 
viresh
