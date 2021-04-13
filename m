Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1435D588
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 05:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbhDMDBV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 23:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243151AbhDMDBU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 23:01:20 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFFDC06138C
        for <linux-pm@vger.kernel.org>; Mon, 12 Apr 2021 20:01:01 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so3597682otl.11
        for <linux-pm@vger.kernel.org>; Mon, 12 Apr 2021 20:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dmc0hZXmCrSXdyT5/+BGkfJc60KHiV2RT1PtaXLe5Bw=;
        b=T6q6GhuwqN7A3KdhOF5AVGdnpPx5ePtwoQwax4QGqKNPuqCnCzmWx7Xc2zvZNLA4zw
         vaWVs++vP4Y53aCeGS59FgjYf6jwZi5+tAcH6e2KCfepjvaujEFByGLFXodeBCAHms15
         n06Fyqmo51EYaXN2AMozzYPIv3u0gm5xk7Wrk/de4TUjLuYJVEQ1hRSebmqFC1PbcU2C
         dpgg9KSCjBCjOOpgtSH3DCQvQnRmvvEPrnNXmVgDcFXtNKHJH5Hz60BoLhbpL3RMfTgr
         UHPE8N/nPoGFHpjQDVhAg0SrmPqDCGNs9uWSJbLWykuqskkUoTsYsLin9g8VznANsrY9
         wlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dmc0hZXmCrSXdyT5/+BGkfJc60KHiV2RT1PtaXLe5Bw=;
        b=uhdvp0qBYNOz2nq8tWsu3143vC+cQS1dWbisZNc0MskGCN+JUbL6bZ+jJvDA+i/67U
         qLwhTh0tYcIVi0nT8miQ0jfBVPW1M8uFQVxV2fFPIk3uhje/mMGgOAzwDBZbcY+SWNBI
         +PM1veIdTANAp9E4Q2RttWXUj2dYybrEskATOnr0nGHqzL0/tVuhi5MoEzIXSp0PM3Fs
         KymQvVP/nSPyJ24Xsmes9QRhPG5bu+VlklYur+j3dXNjF9j98HaX98BkAN9nmaJO+EWS
         4ViEjwd/ukGjfTd4O8IFdM4b78CjBr0KX2jPMYK8Isbk3Z/7m/IRY8uMYEZARG+cVraI
         LOqw==
X-Gm-Message-State: AOAM530bHTdaBhQTesdnkCEISKFVcBt6qduG9hIfmOOKtdnTbKWDkEC7
        6COjvDUJAyu0j8o4aIbn0XAiVQ==
X-Google-Smtp-Source: ABdhPJzLEu/ne59rxKLrYKwS39IEy24zduSSC5TNViBz5Wb5iDoKEYf/g3Cma7Q3wf5RooKPWOn1uw==
X-Received: by 2002:a9d:1a1:: with SMTP id e30mr2371575ote.283.1618282860923;
        Mon, 12 Apr 2021 20:01:00 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h59sm3115213otb.29.2021.04.12.20.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:01:00 -0700 (PDT)
Date:   Mon, 12 Apr 2021 22:00:58 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 1/4] input: pm8941-pwrkey: add support for PMK8350
 PON_HLOS PMIC peripheral
Message-ID: <20210413030058.GK1538589@yoga>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617881469-31965-2-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 08 Apr 06:31 CDT 2021, satya priya wrote:

> From: David Collins <collinsd@codeaurora.org>
> 
> On Qualcomm Technologies, Inc. PMIC PMK8350, the PON peripheral
> is split into two peripherals: PON_HLOS and PON_PBS.  The
> application processor only has write access to PON_HLOS which
> limits it to only receiving PON interrupts.
> 
> Add support for the PMK8350 PON_HLOS peripheral so that its
> KPDPWR_N and RESIN_N interrupts can be used to detect key
> presses.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - No change.
> 
>  drivers/input/misc/pm8941-pwrkey.c | 103 ++++++++++++++++++++++++++-----------
>  1 file changed, 72 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index cf81044..10e3fc0 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + * Copyright (c) 2010-2011, 2020-2021, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2014, Sony Mobile Communications Inc.
>   */
>  
> @@ -22,6 +22,8 @@
>  #define PON_RT_STS			0x10
>  #define  PON_KPDPWR_N_SET		BIT(0)
>  #define  PON_RESIN_N_SET		BIT(1)
> +#define  PON_GEN3_RESIN_N_SET		BIT(6)
> +#define  PON_GEN3_KPDPWR_N_SET		BIT(7)
>  
>  #define PON_PS_HOLD_RST_CTL		0x5a
>  #define PON_PS_HOLD_RST_CTL2		0x5b
> @@ -38,8 +40,12 @@
>  #define  PON_DBC_DELAY_MASK		0x7
>  
>  struct pm8941_data {
> -	unsigned int pull_up_bit;
> -	unsigned int status_bit;
> +	unsigned int	pull_up_bit;
> +	unsigned int	status_bit;
> +	bool		supports_ps_hold_poff_config;
> +	bool		supports_debounce_config;
> +	const char	*name;
> +	const char	*phys;
>  };
>  
>  struct pm8941_pwrkey {
> @@ -231,34 +237,40 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>  
>  	input_set_capability(pwrkey->input, EV_KEY, pwrkey->code);
>  
> -	pwrkey->input->name = "pm8941_pwrkey";
> -	pwrkey->input->phys = "pm8941_pwrkey/input0";
> -
> -	req_delay = (req_delay << 6) / USEC_PER_SEC;
> -	req_delay = ilog2(req_delay);
> -
> -	error = regmap_update_bits(pwrkey->regmap,
> -				   pwrkey->baseaddr + PON_DBC_CTL,
> -				   PON_DBC_DELAY_MASK,
> -				   req_delay);
> -	if (error) {
> -		dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
> -		return error;
> +	pwrkey->input->name = pwrkey->data->name;
> +	pwrkey->input->phys = pwrkey->data->phys;
> +
> +	if (pwrkey->data->supports_debounce_config) {
> +		req_delay = (req_delay << 6) / USEC_PER_SEC;
> +		req_delay = ilog2(req_delay);
> +
> +		error = regmap_update_bits(pwrkey->regmap,
> +					   pwrkey->baseaddr + PON_DBC_CTL,
> +					   PON_DBC_DELAY_MASK,
> +					   req_delay);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed to set debounce: %d\n",
> +				error);
> +			return error;
> +		}
>  	}
>  
> -	error = regmap_update_bits(pwrkey->regmap,
> -				   pwrkey->baseaddr + PON_PULL_CTL,
> -				   pwrkey->data->pull_up_bit,
> -				   pull_up ? pwrkey->data->pull_up_bit : 0);
> -	if (error) {
> -		dev_err(&pdev->dev, "failed to set pull: %d\n", error);
> -		return error;
> +	if (pwrkey->data->pull_up_bit) {
> +		error = regmap_update_bits(pwrkey->regmap,
> +					   pwrkey->baseaddr + PON_PULL_CTL,
> +					   pwrkey->data->pull_up_bit,
> +					   pull_up ? pwrkey->data->pull_up_bit :
> +						     0);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed to set pull: %d\n", error);
> +			return error;
> +		}
>  	}
>  
>  	error = devm_request_threaded_irq(&pdev->dev, pwrkey->irq,
>  					  NULL, pm8941_pwrkey_irq,
>  					  IRQF_ONESHOT,
> -					  "pm8941_pwrkey", pwrkey);
> +					  pwrkey->data->name, pwrkey);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed requesting IRQ: %d\n", error);
>  		return error;
> @@ -271,12 +283,14 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> -	pwrkey->reboot_notifier.notifier_call = pm8941_reboot_notify,
> -	error = register_reboot_notifier(&pwrkey->reboot_notifier);
> -	if (error) {
> -		dev_err(&pdev->dev, "failed to register reboot notifier: %d\n",
> -			error);
> -		return error;
> +	if (pwrkey->data->supports_ps_hold_poff_config) {
> +		pwrkey->reboot_notifier.notifier_call = pm8941_reboot_notify,
> +		error = register_reboot_notifier(&pwrkey->reboot_notifier);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed to register reboot notifier: %d\n",
> +				error);
> +			return error;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, pwrkey);
> @@ -289,7 +303,8 @@ static int pm8941_pwrkey_remove(struct platform_device *pdev)
>  {
>  	struct pm8941_pwrkey *pwrkey = platform_get_drvdata(pdev);
>  
> -	unregister_reboot_notifier(&pwrkey->reboot_notifier);
> +	if (pwrkey->data->supports_ps_hold_poff_config)
> +		unregister_reboot_notifier(&pwrkey->reboot_notifier);
>  
>  	return 0;
>  }
> @@ -297,16 +312,42 @@ static int pm8941_pwrkey_remove(struct platform_device *pdev)
>  static const struct pm8941_data pwrkey_data = {
>  	.pull_up_bit = PON_KPDPWR_PULL_UP,
>  	.status_bit = PON_KPDPWR_N_SET,
> +	.name = "pm8941_pwrkey",
> +	.phys = "pm8941_pwrkey/input0",
> +	.supports_ps_hold_poff_config = true,
> +	.supports_debounce_config = true,
>  };
>  
>  static const struct pm8941_data resin_data = {
>  	.pull_up_bit = PON_RESIN_PULL_UP,
>  	.status_bit = PON_RESIN_N_SET,
> +	.name = "pm8941_resin",
> +	.phys = "pm8941_resin/input0",
> +	.supports_ps_hold_poff_config = true,
> +	.supports_debounce_config = true,
> +};
> +
> +static const struct pm8941_data pon_gen3_pwrkey_data = {
> +	.status_bit = PON_GEN3_KPDPWR_N_SET,
> +	.name = "pmic_pwrkey",
> +	.phys = "pmic_pwrkey/input0",
> +	.supports_ps_hold_poff_config = false,
> +	.supports_debounce_config = false,
> +};
> +
> +static const struct pm8941_data pon_gen3_resin_data = {
> +	.status_bit = PON_GEN3_RESIN_N_SET,
> +	.name = "pmic_resin",
> +	.phys = "pmic_resin/input0",
> +	.supports_ps_hold_poff_config = false,
> +	.supports_debounce_config = false,
>  };
>  
>  static const struct of_device_id pm8941_pwr_key_id_table[] = {
>  	{ .compatible = "qcom,pm8941-pwrkey", .data = &pwrkey_data },
>  	{ .compatible = "qcom,pm8941-resin", .data = &resin_data },
> +	{ .compatible = "qcom,pmk8350-pwrkey", .data = &pon_gen3_pwrkey_data },
> +	{ .compatible = "qcom,pmk8350-resin", .data = &pon_gen3_resin_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8941_pwr_key_id_table);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
