Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857123AE7FA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFULTv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 07:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFULTu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 07:19:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A0C061760
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 04:17:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e22so15632303wrc.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vIId8K2X0cg04va2SpbcSoJb2/1oMnQwPdbB65aNKlU=;
        b=EDo7uTCSwYO6tXzuq8jJ+QbGzLI4DK6DECBy0vtHTBWcb9rPTimZFEiBqHhkHQT2L0
         rFhgFtqJddKzYplsMRuZqDMRQppdcaZf0PGnXxQiV1dC0eWkapEnteGK4Ln/WO4YQTMW
         ryk2OAi8NqxXcHNkJA94p2Yar3eCIPi/4xYr+JBUANL0PynflWaXPGfBGxvt8E7oxk/I
         QwgBcZFIidPc3JfSZlSBJ/0nvsObacHhfYZJ56/hGtJ/Ji+d0AIF13jt0Nr3/oKy67UG
         86OJVK21NZGh+xU+rZ0S/XITBU/hACliGamMweEEUtnkyzMYSoziEE803l/EP4RPHAdK
         SxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vIId8K2X0cg04va2SpbcSoJb2/1oMnQwPdbB65aNKlU=;
        b=MExbZSYDzNKyziC74I3thFiHfANnn/KgaWTuR2BFmgbt+UD5n+811n8feDNOUxys7s
         O9Hfc784XEXFtDqHhQaUDzEcqJFglPDhrXDKYXZDP3IJpJFAGpsarWFaL1iuYiv6LOQI
         D54TigF9lLEmphczCY9qzO8mBBlT0CuTMn+vNdpiZDauEIKUaHIYAB0q2zklVr9HE/P+
         kljochTm2cF+Fy8WJHeg+Qvf2Xx1Lu78uKHJmm0x/ZDrCFqTHFH5gm8A4r9l/Gw6Jglu
         sbfslfvnIqGubfFyWRGELs4i7tpsR6lmcQxxQCdqyZW1ktxDWyWWCgUTgt1e93pAcctP
         TU6g==
X-Gm-Message-State: AOAM533hS8FmQ9Y7meBm6wdCPjOAwYDibJKN+t5Xd5on1i3Qd0ZULbzE
        c7929lw3t0h1atzvodKd7yAf+Q==
X-Google-Smtp-Source: ABdhPJykG3GgJZt4zAIgBQXMeH/COPGhCNvEyfqZmxNGqdOdbRQqkjoDnd7dGcpS5E2lZu+Z2IMDng==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr6891104wrw.240.1624274254528;
        Mon, 21 Jun 2021 04:17:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id e15sm3183114wrm.60.2021.06.21.04.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 04:17:33 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 2/2] cpuidle: qcom: Add SPM register data for
 MSM8226
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>
References: <20210612205335.9730-1-bartosz.dudziak@snejp.pl>
 <20210612205335.9730-3-bartosz.dudziak@snejp.pl>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8d23a3b3-61ad-fabb-fa95-e0bebac2e0ee@linaro.org>
Date:   Mon, 21 Jun 2021 13:17:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210612205335.9730-3-bartosz.dudziak@snejp.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/06/2021 22:53, Bartosz Dudziak wrote:
> Add MSM8226 register data to SPM AVS Wrapper 2 (SAW2) power controller
> driver.
> 
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>

Bjorn ? Andy ?

> ---
>  drivers/cpuidle/cpuidle-qcom-spm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index adf91a6e4d..c0e7971da2 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -87,6 +87,18 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
>  	.start_index[PM_SLEEP_MODE_SPC] = 3,
>  };
>  
> +/* SPM register data for 8226 */
> +static const struct spm_reg_data spm_reg_8226_cpu  = {
> +	.reg_offset = spm_reg_offset_v2_1,
> +	.spm_cfg = 0x0,
> +	.spm_dly = 0x3C102800,
> +	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x10, 0x80, 0x30, 0x90,
> +		0x5B, 0x60, 0x03, 0x60, 0x3B, 0x76, 0x76, 0x0B, 0x94, 0x5B,
> +		0x80, 0x10, 0x26, 0x30, 0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 5,
> +};
> +
>  static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
>  	[SPM_REG_SPM_CTL]	= 0x20,
> @@ -259,6 +271,8 @@ static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
>  }
>  
>  static const struct of_device_id spm_match_table[] = {
> +	{ .compatible = "qcom,msm8226-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8226_cpu },
>  	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
>  	  .data = &spm_reg_8974_8084_cpu },
>  	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
