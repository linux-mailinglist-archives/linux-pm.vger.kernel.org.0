Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294CB4C4029
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiBYIbU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 03:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiBYIbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 03:31:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF43F23A190
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 00:30:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so4225016pja.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 00:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=umjNYNhgnIxE5VvC0JbQD7toURbbqbp0XwksnmHUrBk=;
        b=u8zHs+9LnkJgCALSy6ds+Yd6X2VPqHpIFdGf8+KEnCsbZxxg2Pymyp5hP6OrRP4WnA
         K4deMddtit22sYeHlSZsYTLsc6QhVn3KQFZYaI/lkgwvtqe4Xs3f1VvYcYSxwSVlY2yz
         sNepcUDim4t4wyRz/RSc4jRwLnIYnRW1LtlU66tMq5LdVOJF/GagbDlpqTpYSMSSXADR
         rmzMKGf+ZeT8iKCoAiHggyfwAtXtHVFdQsy7D0mq4YNyRCR2FWChuN1SR92GWnDDYEL5
         WVG9lheJII5ZkK3uVN/W/9pvHVK+OyaBzEhp8Khn4v/jHWDbUFmYdCpn3AVclfrD9XKC
         Q7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=umjNYNhgnIxE5VvC0JbQD7toURbbqbp0XwksnmHUrBk=;
        b=hnQnuXOeqScUOafTnnyY0/XKO7gOX1cPWturL6kpraBlaDlEexiFZDXEBEEEJAY7p3
         91wEjW+5BqRr6IJ+Lv7geY56f1+ars3fyilyctAkxkumqGa4AG4DVzj63SdHwES3Ytem
         H6V/2Zm7VI6okIhXOGAm/H+mNvarIKR029MWJoC+aMYE8ZdDc+CxAAGaX4auNhnP74yO
         0jWplUnsnrOkFO4Dgglyccz9y7svgksBa1xOKLLY15LS94jG1HYYDN899TzpiDYuRnK5
         PTdNrHJVSqPls2FLyQz6ys2ydNSs3qc79KdkRJgyfAuYS7IIBqZZFr6ddGrro840h7H5
         YvWg==
X-Gm-Message-State: AOAM532MRpbdYepwsUsSq3nsGYujw3z92iKO/UC3ttEiqPoepdKZGkPw
        lKOv9OwgsvEe7UwJCU3BjoMMvg==
X-Google-Smtp-Source: ABdhPJw0uLU4lqngX7/k9zLZXpp650nEStictQd4H3d3J4CHpNkXYKfPxxAYJ70h3fuhgk3W3eB0IQ==
X-Received: by 2002:a17:90a:c296:b0:1bc:7a6e:623b with SMTP id f22-20020a17090ac29600b001bc7a6e623bmr2135245pjt.68.1645777848494;
        Fri, 25 Feb 2022 00:30:48 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004cdccd3da08sm2142663pfl.44.2022.02.25.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 00:30:47 -0800 (PST)
Date:   Fri, 25 Feb 2022 16:30:42 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: psci: Iterate backwards over list in
 psci_pd_remove()
Message-ID: <20220225083042.GC269879@dragon>
References: <20220225082420.450620-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225082420.450620-1-shawn.guo@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 25, 2022 at 04:24:20PM +0800, Shawn Guo wrote:
> In case that psci_pd_init_topology() fails for some reason,
> psci_pd_remove() will be responsible for deleting provider and removing
> genpd from psci_pd_providers list.  There will be a failure when removing
> the cluster PD, because the cpu (child) PDs haven't been removed.
> 
> [    0.050232] CPUidle PSCI: init PM domain cpu0
> [    0.050278] CPUidle PSCI: init PM domain cpu1
> [    0.050329] CPUidle PSCI: init PM domain cpu2
> [    0.050370] CPUidle PSCI: init PM domain cpu3
> [    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
> [    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
> [    0.051412] PM: genpd_remove: removed cpu3
> [    0.051449] PM: genpd_remove: removed cpu2
> [    0.051499] PM: genpd_remove: removed cpu1
> [    0.051546] PM: genpd_remove: removed cpu0
> 
> Fix the problem by iterating the provider list in a reversely order, so

s/reversely/reversed

> that parent PD gets removed before child's PDs.

s/before/after

Essentially, with this change, the PM domains will be removed in the same
order how they were added.

[    0.029052] CPUidle PSCI: init PM domain cpu0
[    0.029076] CPUidle PSCI: init PM domain cpu1
[    0.029103] CPUidle PSCI: init PM domain cpu2
[    0.029124] CPUidle PSCI: init PM domain cpu3
[    0.029151] CPUidle PSCI: init PM domain cpu-cluster0
[    0.029647] PM: genpd_remove: removed cpu0
[    0.029666] PM: genpd_remove: removed cpu1
[    0.029690] PM: genpd_remove: removed cpu2
[    0.029714] PM: genpd_remove: removed cpu3
[    0.029738] PM: genpd_remove: removed cpu-cluster0

Shawn

> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index ff2c3f8e4668..ce5c415fb04d 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -182,7 +182,8 @@ static void psci_pd_remove(void)
>  	struct psci_pd_provider *pd_provider, *it;
>  	struct generic_pm_domain *genpd;
>  
> -	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
> +	list_for_each_entry_safe_reverse(pd_provider, it,
> +					 &psci_pd_providers, link) {
>  		of_genpd_del_provider(pd_provider->node);
>  
>  		genpd = of_genpd_remove_last(pd_provider->node);
> -- 
> 2.25.1
> 
