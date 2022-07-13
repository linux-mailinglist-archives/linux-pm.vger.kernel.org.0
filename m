Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21109572D1B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiGMF3Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 01:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiGMF3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 01:29:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E7EA6
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:29:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q82so9505892pgq.6
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dR8o1Tq91jZw3MLfFu5c8vDuW/4Jm/kOBk1Udw3FPCc=;
        b=wVobnWtioTWzhTkgptNc/fvBk1Z6nRHmsU4jMUhB6MkKOYPjxQiSYFMtZ+9wdBjnEq
         ZRtkx3GsLj4+uegFy8BszHdnfWYDWPixOros1UY3VNtKr7tukMlgnqJm7CCHvDL95Ajv
         EBZce62eSv954MhqOgznf5sBc7ruV2BTyeKdmc9hOPyt2srR7VmdVCwoiu4jkcuRihWa
         UWJ/hbMH5kruYQ89kpuKSKHIpC1i8T3Xal9Y6mr5tOoU1unvsVXilqK8bPvGlXLbcJ7H
         8PBUFXKtOfkDEfhneAWE2ZGfXKqwmNQNPv3bJvGWYiUG/NvyUg0lVV1ORmS0UHvCs9sf
         g9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dR8o1Tq91jZw3MLfFu5c8vDuW/4Jm/kOBk1Udw3FPCc=;
        b=F+2//lBilKu+FVylfIcvCZJokwLk5Jb5n6PG8EGfzcVCvTfKD0BkZKUGag8SGyqg0y
         Tt5VKw9OX25UiVGSMMUK8u0NZJLUDkXuYiwwugV4/yAWvgY6qtbqvXaMwIR037PpYCjN
         ZjK0BlmWtAd99N+p1qFyOHGhbtH2DPNjqd6ZsABRwkAZ3KKEb5tLElGEsa41AT3OIswu
         GRR/nwW4zCCeC7cMYQvrw3hDYEgZlDswaNPsOF19X4boAxMehN1Voh8xw5Gx8wNeJD4U
         /RWa/vmx34AyTBA1UOpuWTQrKilK+1UOQxzBhn3PYUmyK8RKyZgO6Z/zeeJfA38S90En
         f8kA==
X-Gm-Message-State: AJIora95KqKUhdSDODnZjN4zSmD7KZ7e5eI1U1YCndMadtwpue8oQ4p0
        D+RTMn2d1ZFmNnVylXPvzZgXeg==
X-Google-Smtp-Source: AGRyM1tnQrU+Y5Q5QxBJogDJF3nwdH4hqn8kuct8RyCF7wZ1DVA8DHamudeI/KQwnHzH64GQxndF1A==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr1457247pfj.83.1657690143805;
        Tue, 12 Jul 2022 22:29:03 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id d10-20020a621d0a000000b005289f594326sm7732688pfd.69.2022.07.12.22.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:29:03 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:58:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 09/13] cpufreq: amd-pstate: update pstate frequency
 transition delay time
Message-ID: <20220713052859.7h7uaddpyvqaty2v@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <eeb86584fabe92859b9b33c40442bada2e46df2a.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb86584fabe92859b9b33c40442bada2e46df2a.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-07-22, 11:42, Perry Yuan wrote:
> change the default transition latency to be 20ms that is more
> reasonable transition delay for AMD processors in non-EPP driver mode.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 312ccef62f58..1e5ca4897b7e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -41,7 +41,7 @@
>  #include <asm/msr.h>
>  #include "amd-pstate-trace.h"
>  
> -#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
> +#define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	500
>  
>  /*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
