Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9843B0874
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhFVPRT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 11:17:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:23131 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhFVPRQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 11:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624374893;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=pIaO9XRWMpnTvjW1hbLK0CdVK6Xi7RjV4nJP8pS9kkE=;
    b=iOFNM7fEA1HuXoJ7U0YdoIarmFUdvJBNzSCIeGZBo8ke/UKCGkBSL9kMcwYRCCSKst
    nZ/ecihVduKaHNnMRj2bqS+TcEpUWppKwIMafQivog26Lc2d4hoMCpDE+AslIFBoTQrA
    N5IektOmO+YhkfF3mSMqNNZK2jY56UrseqQopOp8aarFAQjvhSv41LVl62ha3jqIXvJz
    6HnhKWgBK18RBrgawdD79sY4R8pLhzQsnN8BSwkbzn7yXZCE2SYMHpK31RgsuNFT2agj
    gbPNbqsqUKAR5Rn7Svy0TJL5Va9Y7iXnawpJWpnMo7tKyNdRkKuxeBp6Plwusqiu6DKp
    0RwQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f6Ic3CBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5MFErSro
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 22 Jun 2021 17:14:53 +0200 (CEST)
Date:   Tue, 22 Jun 2021 17:14:51 +0200
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
Subject: Re: [PATCH v7 3/5] soc: qcom: spm: Implement support for SAWv4.1,
 SDM630/660 L2 AVS
Message-ID: <YNH+a/DNHochSdOq@gerhold.net>
References: <20210622141117.358893-1-angelogioacchino.delregno@somainline.org>
 <20210622141117.358893-4-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622141117.358893-4-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 04:11:15PM +0200, AngeloGioacchino Del Regno wrote:
> Implement the support for SAW v4.1, used in at least MSM8998,
> SDM630, SDM660 and APQ variants and, while at it, also add the
> configuration for the SDM630/660 Silver and Gold cluster L2
> Adaptive Voltage Scaler: this is also one of the prerequisites
> to allow the OSM controller to perform DCVS.
> 
> Please note that despite there are various "versions" of these
> values downstream, these are the only ones that are perfectly
> stable on the entire set of tested devices.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

I can't say much about this platform but I trust that Angelo
knows what he is doing. :) I found the values used here in

https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-pm.dtsi?h=LA.UM.8.2.r2-04600-sdm660.0&id=c2c950b468079a41c31d819051ffb8d9ad9eac8f

So I think it's okay to provide a (somewhat limited)
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/soc/qcom/spm.c | 32 +++++++++++++++++++++++++++++---
>  include/soc/qcom/spm.h |  4 +++-
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index 9b6f649c9a10..1401db8373dd 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -32,10 +32,29 @@ enum spm_reg {
>  	SPM_REG_SEQ_ENTRY,
>  	SPM_REG_SPM_STS,
>  	SPM_REG_PMIC_STS,
> +	SPM_REG_AVS_CTL,
> +	SPM_REG_AVS_LIMIT,
>  	SPM_REG_NR,
>  };
>  
> -static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
> +static const u16 spm_reg_offset_v4_1[SPM_REG_NR] = {
> +	[SPM_REG_AVS_CTL]	= 0x904,
> +	[SPM_REG_AVS_LIMIT]	= 0x908,
> +};
> +
> +static const struct spm_reg_data spm_reg_660_gold_l2  = {
> +	.reg_offset = spm_reg_offset_v4_1,
> +	.avs_ctl = 0x1010031,
> +	.avs_limit = 0x4580458,
> +};
> +
> +static const struct spm_reg_data spm_reg_660_silver_l2  = {
> +	.reg_offset = spm_reg_offset_v4_1,
> +	.avs_ctl = 0x101c031,
> +	.avs_limit = 0x4580458,
> +};
> +
> +static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
>  	[SPM_REG_SPM_CTL]	= 0x30,
>  	[SPM_REG_DLY]		= 0x34,
> @@ -54,7 +73,7 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
>  	.start_index[PM_SLEEP_MODE_SPC] = 3,
>  };
>  
> -static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
> +static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
>  	[SPM_REG_SPM_CTL]	= 0x20,
>  	[SPM_REG_PMIC_DLY]	= 0x24,
> @@ -126,6 +145,10 @@ void spm_set_low_power_mode(struct spm_driver_data *drv,
>  }
>  
>  static const struct of_device_id spm_match_table[] = {
> +	{ .compatible = "qcom,sdm660-gold-saw2-v4.1-l2",
> +	  .data = &spm_reg_660_gold_l2 },
> +	{ .compatible = "qcom,sdm660-silver-saw2-v4.1-l2",
> +	  .data = &spm_reg_660_silver_l2 },
>  	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
>  	  .data = &spm_reg_8974_8084_cpu },
>  	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> @@ -169,6 +192,8 @@ static int spm_dev_probe(struct platform_device *pdev)
>  	 * CPU was held in reset, the reset signal could trigger the SPM state
>  	 * machine, before the sequences are completely written.
>  	 */
> +	spm_register_write(drv, SPM_REG_AVS_CTL, drv->reg_data->avs_ctl);
> +	spm_register_write(drv, SPM_REG_AVS_LIMIT, drv->reg_data->avs_limit);
>  	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>  	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>  	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
> @@ -178,7 +203,8 @@ static int spm_dev_probe(struct platform_device *pdev)
>  				drv->reg_data->pmic_data[1]);
>  
>  	/* Set up Standby as the default low power mode */
> -	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
> +	if (drv->reg_data->reg_offset[SPM_REG_SPM_CTL])
> +		spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
>  
>  	return 0;
>  }
> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> index 4c7e5ac2583d..4951f9d8b0bd 100644
> --- a/include/soc/qcom/spm.h
> +++ b/include/soc/qcom/spm.h
> @@ -21,11 +21,13 @@ enum pm_sleep_mode {
>  };
>  
>  struct spm_reg_data {
> -	const u8 *reg_offset;
> +	const u16 *reg_offset;
>  	u32 spm_cfg;
>  	u32 spm_dly;
>  	u32 pmic_dly;
>  	u32 pmic_data[MAX_PMIC_DATA];
> +	u32 avs_ctl;
> +	u32 avs_limit;
>  	u8 seq[MAX_SEQ_DATA];
>  	u8 start_index[PM_SLEEP_MODE_NR];
>  };
> -- 
> 2.32.0
> 
