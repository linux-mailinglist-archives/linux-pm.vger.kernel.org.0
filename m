Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286972D0ABB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 07:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLGGeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 01:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLGGeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 01:34:25 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7CC0613D2
        for <linux-pm@vger.kernel.org>; Sun,  6 Dec 2020 22:33:44 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id hk16so6851549pjb.4
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2020 22:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=unfBbNCI0m3ptB2CCZebMmZ2Tw9oIvAqWo/oBXmpaOk=;
        b=c6g8eg9Zquy73mzH0bVNuB3jifwIQLnBnawoOZMdZnDFAOmT2WgFjPn7i7AnxuIRp1
         Oi9QYTQ3JvTx8Gyf6qX3Rno1iiMHDIJW69Lyjv3ZO6lwM7JL+yKhFEZ/oabzPyPa8X5S
         ZHsGAsU6Quctd3SEaaNA0sDbyrCwv7xzfIAcgXH/aDd8sJd9C0mVX90AD9tq1Yg9Ritv
         hw0s9rMX0h3qNFkY7lU18Z24ZY66Vl67pS/c2B4H0KWbgZ7BAy0LuT0yQ9R0Za4/MzUq
         s+a5bLrGXC7U++7OUziNyBFhuqM7yczFutd2yK76KyRXxwNIe9SJO4ofYjoOWXtlT8UD
         Qthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=unfBbNCI0m3ptB2CCZebMmZ2Tw9oIvAqWo/oBXmpaOk=;
        b=Z1zXXeA/KwV7+Dfxyr80vjApS1aIk+zvJN6swERnCyVGhGAupOCCN1TEZhv5TEAhnj
         4Z5nOLHbxnircZT2ii3WHTIdzVLLvl38rmUp1qyiG2L7F3m441vLxs6kWRXVJYp+v42v
         ldnDYEig41aE8mcOEAvoSPPGZUarACFh32Ez8s3ZsoEM0CEh1wJwiUuzFNMNWdl2tPsO
         Pn4zvOgjka06j6Rlrzu16fKxAUpGuxc8QA0gCsw8czrT3HPZc32yF/+oImpcBJdgy+b2
         ICrplwho9oBlI7UfbxlBSXGTfguM6kzFa0S60sbqj9RfQ7he87p31CNKWjG4Lfb6O4RV
         Q+Ag==
X-Gm-Message-State: AOAM530FHsUZnVDGitifU5JWIi2Vq/bABbNdrPl/rpIXwwcDvTfON7CI
        P9fLp15L2Z37/6RJex4qfR8FSQX3YT/2ig==
X-Google-Smtp-Source: ABdhPJxXmYsMI7E+hyqpdvOd5tLHP/tJhmopVByXPoaWhwUHfY20BsFmhK2d9+/88SHFOpRHxyc+uA==
X-Received: by 2002:a17:90a:5b18:: with SMTP id o24mr1636726pji.120.1607322824487;
        Sun, 06 Dec 2020 22:33:44 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id m4sm14207689pfd.203.2020.12.06.22.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 22:33:43 -0800 (PST)
Date:   Mon, 7 Dec 2020 12:03:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: add COMMON_CLK dependency
Message-ID: <20201207063342.fi5ms67wdy4aaqpf@vireshk-i7>
References: <20201203225550.1478195-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203225550.1478195-1-arnd@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-12-20, 23:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Wtihout CONFIG_COMMON_CLK, the scmi driver fails to link:
> 
> arm-linux-gnueabi-ld: drivers/cpufreq/scmi-cpufreq.o: in function `scmi_cpufreq_probe':
> scmi-cpufreq.c:(.text+0x20c): undefined reference to `devm_of_clk_add_hw_provider'
> arm-linux-gnueabi-ld: scmi-cpufreq.c:(.text+0x22c): undefined reference to `of_clk_hw_simple_get'
> 
> Add a Kconfig dependency for it.
> 
> Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dummy clock provider")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1f73fa75b1a0..434ef03d2762 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -264,6 +264,7 @@ config ARM_SA1110_CPUFREQ
>  config ARM_SCMI_CPUFREQ
>  	tristate "SCMI based CPUfreq driver"
>  	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	depends on COMMON_CLK
>  	select PM_OPP
>  	help
>  	  This adds the CPUfreq driver support for ARM platforms using SCMI

This is already fixed by:

commit f943849f7206 ("cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK")

-- 
viresh
