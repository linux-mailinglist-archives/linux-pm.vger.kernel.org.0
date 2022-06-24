Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC234558C85
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jun 2022 02:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiFXA5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jun 2022 20:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiFXA5F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2022 20:57:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B045D10A
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 17:57:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so4224349pjl.5
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxVvB/m7x0pgtjlNYBhWurxvqaAULbnSfJFRHQ6dHo4=;
        b=LMOQw6GJtSJ54E9LC8aXS8JjU9Xiug7/qsvW5QpPNmC0/MUnxPZkcpO1Kb8rHGenmc
         lzbcmdRhC0vjEKRRF4+bOY4vbkzgMM9VmvQwGETZ+0v11g31c8Qsl1WyIoHK+XAl0pH8
         wjYyASMIZDd9LL3/pPH5ZqxwgTBtIZ1YV/51WxozXcXv+PEAxXA4Yrz3HrhdLsPvrZ2v
         j7rmSzSxDBqageafcUNeyQqx1gTt9yLe8/ujf7aHo2CY0Pq4vK1G30e7UKaohGd5bYGZ
         nY+t942ghnZQJA6KYZDoryFEFXUk71S5ZMSF8DiMFo8YbTY6rJFGWF8oxaspQ5YaclkS
         HTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxVvB/m7x0pgtjlNYBhWurxvqaAULbnSfJFRHQ6dHo4=;
        b=E5gYQGkQ5HnxuAladFLip64y2IZuxVmXwEh3qCQzRRKavsss6wf8QU2SFdJ9vSktUh
         ILP93Y/SG+Tl6qwsgXcnxxC6B9e8CKQcW/4SpR3rEbMNNerlSbj8ntGszGV6dgP1PtJc
         6RmA94Gr0A3TmG43aF/m8NwkvPUqI2/Myy/GnCwMiw6rnWLbRJeAbRX3sw5+HIAYRf/i
         kMXXzxldpUfDaUdx50X3B9VdzyygkQbg6RVy2oX8ZGGnITMSOVojT+jhUZZZ6I6wAk27
         byij3VV/fCd9J5yO3Isi1J+IVSOxLWu0R90wdloCJxL/pJp5gSv6H7rAH8HkDO7cnQ7n
         dd7A==
X-Gm-Message-State: AJIora/otdSv00BeyHyMsEBLt7LXI24s3Xytqn5LsGPRxbEfztO11BL9
        3JqJdrrNU167mhYPwYwEV9eFqg==
X-Google-Smtp-Source: AGRyM1u/rQOGJQmJ3cvPtnGI8BOb90GaJ9FhnlhNwV1scpb7V7CBR/z3hC4vp9WD7hspkr0FrliEYw==
X-Received: by 2002:a17:90b:4c48:b0:1ec:a20e:a9bf with SMTP id np8-20020a17090b4c4800b001eca20ea9bfmr790585pjb.209.1656032222483;
        Thu, 23 Jun 2022 17:57:02 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709028d9400b001690a6394b6sm390283plo.247.2022.06.23.17.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 17:57:01 -0700 (PDT)
Date:   Fri, 24 Jun 2022 06:27:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Message-ID: <20220624005700.oj4etaajbutvsym7@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624004831.po35sowzfo4c47b3@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-06-22, 06:18, Viresh Kumar wrote:
> +       struct dev_pm_opp_config config = {
> +               /*
> +                * For some devices we don't have any OPP table in the DT, and
> +                * in order to use the same code path for all the devices, we
> +                * create a dummy OPP table for them via this. The dummy OPP
> +                * table is only capable of doing clk_set_rate() on invocation
> +                * of dev_pm_opp_set_rate() and doesn't provide any other
> +                * functionality.
> +                */
> +               .clk_names = NULL,
> +               .clk_count = 1,
> +       };

Slight modification here, sorry about that. We just need to set the
name as NULL and not the array itself.

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd53e46c4058..6a099d764cce 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -116,7 +116,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
                 * of dev_pm_opp_set_rate() and doesn't provide any other
                 * functionality.
                 */
-               .clk_names = NULL,
+               .clk_names = (const char *[]){ NULL },
                .clk_count = 1,
        };

-- 
viresh
