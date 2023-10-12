Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB09C7C635F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjJLDo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 23:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJLDoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 23:44:25 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80EB6
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 20:44:23 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e10507a4d6so351251fac.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 20:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697082263; x=1697687063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0BxKHUdCNcLP6r7RcXc4pSH0oFUe83JsYgb7jzHk4Q=;
        b=pRQQcFoKOyA3VFFk6Ath5NWduIB7hnct2SqbzSmhl9SC5eaxWmOODHYK8UdO0PbtEq
         YYbvLeLH+B42oi12bSi2jVg0cDbxuxbZYZcABznPnEP9HZ8T8djU5wI8MgKeMsY0j5HC
         Mql3PqZZ47EW5bRlP04UsofkTmJ2qOWR6Wudi/wfnss1K3P95xRdJqJn7ffHpcC3DP3K
         h0uUgdbvyTTh3fMBB5BxFjAOYFb4wP+iBQWkRC4Pj8/CiE3TT8e+bUIWMznxBt4fB9mi
         FqZ+UTrhaAUh3hL6pgWrkF/JeVINgTnagU8H2h4tp5MhpB4Wv89MfBKsk6eqtH3eH6WF
         9nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082263; x=1697687063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0BxKHUdCNcLP6r7RcXc4pSH0oFUe83JsYgb7jzHk4Q=;
        b=mZgyYDUdmPi0H2cQBltFBb2yYFYeMpvqXuqo/om8yBKbrQM2fJkAIk4LqBPBD8Jmtk
         A14bq2EQL5UMkbZrKxIxRVT9B8se+JKWbVmwm5i3x1hyd7LyTTCFC5EiKn5txBBc8HoL
         8PAnQ6EY5uATyBLVLOPunmoMkRuZ1eOiKsrBkjw3dmv7CDnu1R0UG3kO5fR85ZNWR+2m
         KC+AvJ7fg8c/tBlxFjG3z+PpAYTwR8DYiyT5ACXJ7It41GOKzSJqMbfnL4NlNeFEXteu
         44fb5kjVJQ1DGmeZkWVcjcmmB9ijaZqXk61LyRUD3Z6816CZWCdXWVBsnKWG+b+loJXr
         YgHg==
X-Gm-Message-State: AOJu0Yy4GzRmX/LOJ/z1nr7Kg2rUVA3zgCXbNX3FWp/qJJW6p+ZTyeRm
        oBCPONoEqroYvtT1tonZ4GsMig==
X-Google-Smtp-Source: AGHT+IGxCfcSWd7e1MtC/Sqvo7w/H83R9ET23iTyAYY86GtouCR46ST5urax6XwXyPecQJJuPCt13A==
X-Received: by 2002:a05:6870:b604:b0:1d7:1ad1:3f8c with SMTP id cm4-20020a056870b60400b001d71ad13f8cmr25675866oab.49.1697082262743;
        Wed, 11 Oct 2023 20:44:22 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id o20-20020a639214000000b0059cc2f1b7basm645907pgd.11.2023.10.11.20.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:44:22 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:14:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, mmayer@broadcom.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: ARM_BRCMSTB_AVS_CPUFREQ cannot be used with
 ARM_SCMI_CPUFREQ
Message-ID: <20231012034420.ik34htzw2wkiwimp@vireshk-i7>
References: <20231011164654.3671490-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011164654.3671490-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-10-23, 09:46, Florian Fainelli wrote:
> The brcmstb-avs-cpufreq driver is considered a legacy driver and since
> 2018, ARCH_BRCMSTB systems have been using scmi-cpufreq. As a matter of
> fact, when SCMI is in use, brcmstb-avs-cpufreq is unusable since the
> SCMI firmware takes over, this can result in various problems, including
> external synchronous aborts.
> 
> Express those constraints such that the driver is not enabled by default
> when SCMI CPU frequency scaling is in use.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
> 
> - address Viresh's feedback and reduce the depdendency to
>   !ARM_SCMI_CPUFREQ
> 
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 123b4bbfcfee..207618043ee0 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -90,7 +90,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ
>  
>  config ARM_BRCMSTB_AVS_CPUFREQ
>  	tristate "Broadcom STB AVS CPUfreq driver"
> -	depends on ARCH_BRCMSTB || COMPILE_TEST
> +	depends on (ARCH_BRCMSTB && !ARM_SCMI_CPUFREQ) || COMPILE_TEST
>  	default y
>  	help
>  	  Some Broadcom STB SoCs use a co-processor running proprietary firmware

Applied. Thanks.

-- 
viresh
