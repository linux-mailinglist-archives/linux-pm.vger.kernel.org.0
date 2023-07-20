Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4C75ABF7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jul 2023 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGTKa4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jul 2023 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGTKa4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2023 06:30:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592AD10F1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 03:30:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso360839b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2023 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689849054; x=1690453854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pX/Ty9NAcT9bYpPnRuDBO1Tp6SxCU3ljG9XRMY4bllE=;
        b=YEjHygSXionVn78E3LIw9gY7VVbzoifbq/0xL4Hy8vefi+FIpQ/OrhbweiqbVZGW2t
         a/Mk5zS1jQUvlYWJQNzdQVBXR2kp29aBK5Cv0JMhaSDLSoRkZcMiEyUixP9M3bo7RTdT
         rVW633peGDgCzxJM7AGqjl6c13L5dRfNlenfMfRkoBeaKK/v59do4NNecBanveHVl0x2
         WesSQ715grtexLTfZQe4aGPs/PWbPzqnv177lvc9ENtemsZkWkTUBgE/iB+806lMu8NI
         Ad6FCd1eCaAgrUHr6GjtDkXJvxdbAXd4jyeV13pPEjL7cNtD3eI6lJprClc7LTszVzhp
         iPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689849054; x=1690453854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX/Ty9NAcT9bYpPnRuDBO1Tp6SxCU3ljG9XRMY4bllE=;
        b=VEehXjgHqI2bzCCpQ7cQCtCVnaxJH6cYpgfQJCpA2obhIg8dPTAc9y2Pud0L7Gn7wi
         H0/WKDf4W1bIOAytnqmSynIDcd4a4c1d7aGTuLgLxybqyPsBS2PEhZhvEb73YtPxSaou
         Su+76wGFJNTXsrJDJhBAS2BSgvjD5WmVmBkoSzd3G96lgRhi2MOweDIAX4NqYt1LqbqD
         fDH+M4HFU/Vck+yqrCs3ol4UvJYwjUu0ZrEKK/8UjqzwbbyAeInPZyVJtffNvnSHQdsq
         KpBMhm0gtsN9mAtg5PTeBPgW0Gd1O/086biifs0k/GlRM/WkzkzfBNbBblj+5POI/7/C
         quPQ==
X-Gm-Message-State: ABy/qLYg8wRSKF6n2bkeuwUQBbYi75ku2jwwv/R82K7NufsNGG5X8OHh
        Dy2+eqXDbRWb8UEqHUdI4OLgfQ==
X-Google-Smtp-Source: APBJJlHQ3TBhJch4+9s7IdsXDe4mP52ispONeRhDFv3IHs7DNJoO/6dUpqV823L+edq5WpNkcQKRmA==
X-Received: by 2002:a05:6a20:54a4:b0:12c:e3c8:8c7 with SMTP id i36-20020a056a2054a400b0012ce3c808c7mr19779825pzk.41.1689849053763;
        Thu, 20 Jul 2023 03:30:53 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902768c00b001b8062c1db3sm977831pll.82.2023.07.20.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:30:52 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:00:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Explicitly include correct DT includes
Message-ID: <20230720103050.325y6n2zqiv5k5ku@vireshk-i7>
References: <20230714174414.4054011-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174414.4054011-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-23, 11:44, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c  | 4 +---
>  drivers/cpufreq/mediatek-cpufreq-hw.c  | 3 ++-
>  drivers/cpufreq/ppc_cbe_cpufreq.c      | 2 +-
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c  | 1 -
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 -
>  drivers/cpufreq/scpi-cpufreq.c         | 2 +-
>  drivers/cpufreq/sti-cpufreq.c          | 2 +-
>  drivers/cpufreq/ti-cpufreq.c           | 2 +-
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
>  9 files changed, 7 insertions(+), 11 deletions(-)

Applied. Thanks.

-- 
viresh
