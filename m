Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57A33E0ABC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 01:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhHDXME (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 19:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHDXME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 19:12:04 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFCDC061798
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 16:11:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a19so4865822oiw.6
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TaWq51EqywyuKb/DYdfCbIFAEoPpPDGd0uhGmHXUj0A=;
        b=QQOAum8eTzRYtMGTKCUzlhfYrrHG+LFJpDkyNcTh2ZGR2PvgVcwX0msgO9Z+kFAaax
         jrjisKpNSlCdwHTDeH84VeaDyJ0Ar546tPGnwVYGsvnB86KDIH6ofSR/ZNAR89jBM3qs
         KbgRASuSGueGYICoRHoJHg7U/qKKccA2opcHuSfCob6xvsi/72/HeN+ll2gXRzXriMth
         LG/GdxjYrqQGMbD/0Gk83BfuuH0BbWRLbyPPyBpEdu/2I2zlZ4so6aNV9Mvk5TUKEX+k
         4pHiKCRt7fr3/kjFEjbxCyauhU7+0TPZG1bYxK9FozGe/DKk9A9vlQqKpthhd+x67xEW
         Ysbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TaWq51EqywyuKb/DYdfCbIFAEoPpPDGd0uhGmHXUj0A=;
        b=RDxHIJjKsg+52YSZB4h5UoMJpAk+M0Ifaw6UWLTtPGi9VWQt7q1eK6ZckKWPr5NB9G
         51JvmLS9fv2xkkhmPhcT/7/WR54eELVmz7rTpfRvj5/uL4hkn88XKrekBEGHzv7gR9Zr
         AFNbNLJZw4sM2eNBgG4tPhvGF908nPJ1w08flm2d0fILMqzt5eTNgSjVUmr/CE+xF6Qj
         esXTkjP5eCTiLv9GdofHDkILEg2aWu5nF2Fqiip6soRsaacMF3+wC6uVawpdRmJljOhF
         h4t3DPGPsVwEOdbWCRs+Ep7BHvYAP8yXQOKiRDTGfxtjShlDosV/1aTeXj2UsZYku8ji
         97ZQ==
X-Gm-Message-State: AOAM533ksthDcocryAK2yu+b0Ho5ie65VTvAPt0u5jSwNNw0bhs7FZfb
        baixYm0AA8AJv3uG217p+T2SQw==
X-Google-Smtp-Source: ABdhPJwUZLe2IQMgeO//fmZvAc15YbwcKsnB78yHqFio6xKY3oH/0UdbPuQfHF9jaAiV2v6HEloYoA==
X-Received: by 2002:a05:6808:4d0:: with SMTP id a16mr1240203oie.166.1628118710409;
        Wed, 04 Aug 2021 16:11:50 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u18sm748726oif.9.2021.08.04.16.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:11:49 -0700 (PDT)
Date:   Wed, 4 Aug 2021 18:11:48 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mka@chromium.org,
        viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Subject: Re: [PATCH 2/4] cpufreq: qcom: Re-arrange register offsets to
 support per core L3 DCVS
Message-ID: <YQsetKGjlmQRxytX@builder.lan>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-3-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627581885-32165-3-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 29 Jul 13:04 CDT 2021, Sibi Sankar wrote:

> Qualcomm SoCs (starting with SM8350) support per core voting for L3 cache
> frequency. So, re-arrange the cpufreq register offsets to allow access for
> the L3 interconnect to implement per core control. Also prevent binding
> breakage caused by register offset shuffling by using the SM8250/SM8350
> EPSS compatible.
> 
> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859bf76f1..74ef3b38343b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -28,6 +28,7 @@ struct qcom_cpufreq_soc_data {
>  	u32 reg_volt_lut;
>  	u32 reg_perf_state;
>  	u8 lut_row_size;
> +	bool skip_enable;

This should probably be called "skip_enable_check".

>  };
>  
>  struct qcom_cpufreq_data {
> @@ -257,19 +258,31 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>  	.reg_volt_lut = 0x114,
>  	.reg_perf_state = 0x920,
>  	.lut_row_size = 32,
> +	.skip_enable = false,
>  };
>  
>  static const struct qcom_cpufreq_soc_data epss_soc_data = {
> +	.reg_freq_lut = 0x0,
> +	.reg_volt_lut = 0x100,
> +	.reg_perf_state = 0x220,
> +	.lut_row_size = 4,
> +	.skip_enable = true,

This change is not compatible with existing DTBs.

Regards,
Bjorn

> +};
> +
> +static const struct qcom_cpufreq_soc_data epss_sm8250_soc_data = {
>  	.reg_enable = 0x0,
>  	.reg_freq_lut = 0x100,
>  	.reg_volt_lut = 0x200,
>  	.reg_perf_state = 0x320,
>  	.lut_row_size = 4,
> +	.skip_enable = false,
>  };
>  
>  static const struct of_device_id qcom_cpufreq_hw_match[] = {
>  	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
>  	{ .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
> +	{ .compatible = "qcom,sm8250-cpufreq-epss", .data = &epss_sm8250_soc_data },
> +	{ .compatible = "qcom,sm8350-cpufreq-epss", .data = &epss_sm8250_soc_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> @@ -334,10 +347,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	data->res = res;
>  
>  	/* HW should be in enabled state to proceed */
> -	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> -		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> -		ret = -ENODEV;
> -		goto error;
> +	if (!data->soc_data->skip_enable) {
> +		if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> +			dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> +			ret = -ENODEV;
> +			goto error;
> +		}
>  	}
>  
>  	qcom_get_related_cpus(index, policy->cpus);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
