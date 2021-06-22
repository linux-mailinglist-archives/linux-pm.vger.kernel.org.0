Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2A3B088E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhFVPU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 11:20:27 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:31004 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVPU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 11:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624375087;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wOC9VDfBrCSExkPhJ90oEqNmTHI7WSS64pU4XiCEAh4=;
    b=PynXijrYaj1nzA71DBptg/QANm0T64hxKbDZOIT0PdwxdK4IpbsBb5Vr+vByJzTou+
    gJFLDBoYutk8MOpBlrdWD3sMG7f2T6CyE4DVVK98idm8YomXrO4yFRfANSRuVT0m4Ulc
    9DAthZIORO93X8VZZsOj0Lh2H15/u8mx/cLR+GEst2cQOwI+pGQ06JL1OyfjA9N+xii2
    DD0nhRK7YwllV3c70wXbytjLWbcaBiDYFFga0z43K8f6NPqGzJLrckGvFDtQDlkPzqiI
    4fWmRhYChAMUBpzUYgGE63EjbiSUeVRGm+ib44Q7ebqfUWZ4+Kq7BEqUhIq5mRsXAiyw
    8WQQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f6Ic3CBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5MFI6SsX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 22 Jun 2021 17:18:06 +0200 (CEST)
Date:   Tue, 22 Jun 2021 17:18:05 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v7 4/5] soc: qcom: spm: Add compatible for MSM8998
 SAWv4.1 L2
Message-ID: <YNH/LREbpP4ycT7l@gerhold.net>
References: <20210622141117.358893-1-angelogioacchino.delregno@somainline.org>
 <20210622141117.358893-5-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622141117.358893-5-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 04:11:16PM +0200, AngeloGioacchino Del Regno wrote:
> Add the SAWv4.1 parameters for MSM8998's Gold and Silver clusters.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

I can't say much about this platform but I trust that Angelo
knows what he is doing. :) I found the values used here in

https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998-pm.dtsi?h=994e5922a0c225b877a4b3790830b7edc7b7807b
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998-v2.dtsi?h=994e5922a0c225b877a4b3790830b7edc7b7807b#n1186

(From what I heard from other people only msm8998-v2 is used in
 production devices?)

So I think it's okay to provide a (somewhat limited)
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/soc/qcom/spm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index 1401db8373dd..8077e337ee7e 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -54,6 +54,18 @@ static const struct spm_reg_data spm_reg_660_silver_l2  = {
>  	.avs_limit = 0x4580458,
>  };
>  
> +static const struct spm_reg_data spm_reg_8998_gold_l2  = {
> +	.reg_offset = spm_reg_offset_v4_1,
> +	.avs_ctl = 0x1010031,
> +	.avs_limit = 0x4700470,
> +};
> +
> +static const struct spm_reg_data spm_reg_8998_silver_l2  = {
> +	.reg_offset = spm_reg_offset_v4_1,
> +	.avs_ctl = 0x1010031,
> +	.avs_limit = 0x4200420,
> +};
> +
>  static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
>  	[SPM_REG_SPM_CTL]	= 0x30,
> @@ -149,6 +161,10 @@ static const struct of_device_id spm_match_table[] = {
>  	  .data = &spm_reg_660_gold_l2 },
>  	{ .compatible = "qcom,sdm660-silver-saw2-v4.1-l2",
>  	  .data = &spm_reg_660_silver_l2 },
> +	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
> +	  .data = &spm_reg_8998_gold_l2 },
> +	{ .compatible = "qcom,msm8998-silver-saw2-v4.1-l2",
> +	  .data = &spm_reg_8998_silver_l2 },
>  	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
>  	  .data = &spm_reg_8974_8084_cpu },
>  	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> -- 
> 2.32.0
> 
