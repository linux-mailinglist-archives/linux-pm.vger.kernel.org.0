Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC803AD4E8
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 00:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhFRWTm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 18:19:42 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:20205 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhFRWTk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 18:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624054644;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZqDCqETDBFGz+d3VQti31fhKicXVgO3dR3oNmU+TOI8=;
    b=icaRvk5PANS0C3UX28i9YIPFBnzr8HLe6gxwsACjNdDDCUYyd2FYuqwmCLdhwXSG39
    IgNHt5eJ6Z2hjqZC1ysNUoXXeVwx4Z1mMVNyUsQn+f4hGGFXJ3LspSvownfU1EKMOOim
    KNl2L0QX0+L6ZDpWWkRDoDAHjIsaZv1rgErv+iG/UaClg6ZZssvyNsqe2tco2NLvgNGf
    Qz2hBNBsgP8Wcq3JlFW1zj4Lj+qgWm4GJ56vajT2Nv+zkXZA1cDC16v9CdSSYqHeputv
    50ZYG/5x7L+APXhileG0loPczNQ2Mh0oUd2OiKyRmAknAn2tyZ/wdEzwNcPyRK6dIhG+
    wAgw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f7IcfABg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5IMHO7EW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 19 Jun 2021 00:17:24 +0200 (CEST)
Date:   Sat, 19 Jun 2021 00:17:19 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RESEND PATCH v4 2/3] soc: qcom: spm: Implement support for
 SAWv4.1, SDM630/660 L2 AVS
Message-ID: <YM0bM60FNof8d6ki@gerhold.net>
References: <20210618180907.258149-1-angelogioacchino.delregno@somainline.org>
 <20210618180907.258149-3-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618180907.258149-3-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 18, 2021 at 08:09:06PM +0200, AngeloGioacchino Del Regno wrote:
> Implement the support for SAW v4.1, used in at least MSM8998,
> SDM630, SDM660 and APQ variants and, while at it, also add the
> configuration for the SDM630/660 Silver and Gold cluster L2
> Adaptive Voltage Scaler: this is also one of the prerequisites
> to allow the OSM controller to perform DCVS.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/soc/qcom/spm.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index 0c8aa9240c41..843732d12c54 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -32,9 +32,28 @@ enum spm_reg {
>  	SPM_REG_SEQ_ENTRY,
>  	SPM_REG_SPM_STS,
>  	SPM_REG_PMIC_STS,
> +	SPM_REG_AVS_CTL,
> +	SPM_REG_AVS_LIMIT,
>  	SPM_REG_NR,
>  };
>  
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

I was just randomly looking for the same value in downstream and it
looks like Qualcomm reverted something here to the same value as for
the gold cluster, claiming "stability issues":

https://source.codeaurora.org/quic/la/kernel/msm-4.4/commit/?h=LA.UM.8.2.r2-04600-sdm660.0&id=5a07b7336a1b3fa6a3ac67470805259c5026206e

The commit seems still present in recent qcom tags. I cannot say
anything about this, but could you confirm if you are intentionally
not also doing the same as qcom did in that commit?

Thanks,
Stephan
