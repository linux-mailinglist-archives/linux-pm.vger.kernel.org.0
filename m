Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D4741716
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjF1RS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjF1RSu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 13:18:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D81BF2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 10:18:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so5315092e87.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687972727; x=1690564727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ow7tRjEnsCjS1GIOssymNS7x0t0R+j0hS5b7Ebpa1p0=;
        b=ehYR155YzFx895QNHg9wHaaw+3kIP/EM7R6ld82ulDdVzKb3XAIzpizTnaiGaNnc46
         YFOFtA23bJFNXeAN+td6RvEsX46tCTiCZz7wnj0D4oaPbUP8YN/iyKGFYiK/pmXz7yXC
         KWmQNT1q+/RRZxr1tMFiZpubGU5T5NtVqJiI6ScmrVaG2druj0A4j6eyTPX1xinwmFEL
         ZMmCMAbXULkJrFPS0+e7ULq6xTFqSub1DKt2o1utNYZmwjtBza2h2tw+ilQvrz7YvLev
         HfBbnoFeEJOuwyrlyMeia5dpchManwelJAUd+kdDkWJIC9gQnwFciCzHzTWAR4rd09Ox
         7y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972727; x=1690564727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow7tRjEnsCjS1GIOssymNS7x0t0R+j0hS5b7Ebpa1p0=;
        b=PkYF2L6FSoaZRCuMiqW/XzhZjFBhIZ4cDO76y0vjoc9d77mEFUWFXGKwOh7zRMG6HH
         4SWMai0damX2nyl8BlDIj92fVuT9VEzLWKlikTFG3HY3bwPS3SX4O+BOB5BGgJ0N/FH4
         2F0gDnJOHpt69i5Cv8voJ+UKAFDpw+fHoKKupvXWbXjgu9peoJag9g4ogVbtLCsYkpXU
         /9bEPnFWvlWw3SKsnmvx5dC977xz+Uk0jGKBDoXCfj+IFVpC+4/Un5D9J8JcDX7TTcpu
         lci4nHgMEVhh4vGcxYiN+/dtuJ0+9PPYLCL+GaR4VhGiS0uG1Joiz4C8bN5ByhGWSTiR
         HEUg==
X-Gm-Message-State: AC+VfDy202BzRnTbpCuYkNLzivq1lKjhDThgG0+8wNI8kf0zw5B0y7nm
        nq96JihRk06kWCc/+NIeuQT5qQ==
X-Google-Smtp-Source: ACHHUZ77YJXHqmFGoChqgG3trHPveAapS5Nb3B+LNq40EJ1Bf0lssdrfxIgIeP0QaAx96K4CoERoaw==
X-Received: by 2002:a19:6704:0:b0:4f9:547c:a3cc with SMTP id b4-20020a196704000000b004f9547ca3ccmr14580392lfc.14.1687972727147;
        Wed, 28 Jun 2023 10:18:47 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id d27-20020ac244db000000b004f27471e0aesm2006371lfm.79.2023.06.28.10.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 10:18:46 -0700 (PDT)
Message-ID: <42b1167d-da60-f6c3-67b6-3f6857327396@linaro.org>
Date:   Wed, 28 Jun 2023 19:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] clk: qcom: gdsc: Add support for set_hwmode_dev
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20230628105652.1670316-1-abel.vesa@linaro.org>
 <20230628105652.1670316-3-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230628105652.1670316-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28.06.2023 12:56, Abel Vesa wrote:
> Implement the GDSC specific genpd set_hwmode_dev callback in order to
> switch the HW control on or off. For any GDSC that supports HW control
> set this callback in order to allow its consumers to control it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
This still does nothing to prevent the HW_CTRL state being changed in
init, enable and disable functions.

Konrad
>  drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..9a04bf2e4379 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -314,6 +314,26 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> +static int gdsc_set_hwmode_dev(struct generic_pm_domain *domain,
> +			       struct device *dev, bool enable)
> +{
> +	int ret = gdsc_hwctrl(domain_to_gdsc(domain), enable);
> +
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Wait for the GDSC to go through a power down and
> +	 * up cycle.  In case there is a status polling going on
> +	 * before the power cycle is completed it might read an
> +	 * wrong status value.
> +	 */
> +	udelay(1);
> +
> +out:
> +	return ret;
> +}
> +
>  static int gdsc_disable(struct generic_pm_domain *domain)
>  {
>  	struct gdsc *sc = domain_to_gdsc(domain);
> @@ -451,6 +471,8 @@ static int gdsc_init(struct gdsc *sc)
>  		sc->pd.power_off = gdsc_disable;
>  	if (!sc->pd.power_on)
>  		sc->pd.power_on = gdsc_enable;
> +	if (sc->flags & HW_CTRL)
> +		sc->pd.set_hwmode_dev = gdsc_set_hwmode_dev;
>  
>  	ret = pm_genpd_init(&sc->pd, NULL, !on);
>  	if (ret)
