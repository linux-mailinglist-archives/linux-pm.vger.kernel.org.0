Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63521ACF3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 04:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGJCPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 22:15:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35836 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgGJCPA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 22:15:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594347299; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=pZBbWOAImaAXj4ymXtVBbnn0fW0JrVwullPsUepvzus=; b=pyE3wRL/aIHm166hJBcHlc3oWFeACtWEFdjrjxhlwhahcRhuasR0Vzbx/VVkIHa2RJxtE4iF
 r2ko2JbNywpC38YS4qwdo8BgtuyD6Q9i/rM4Frg3Ny6EEIE3oxx5Dt/x0WHV51PHjBMk79PU
 5FZY/AcmhhMB9ndNhaA82ROnMSQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f07cf1919b27ae9cecb4118 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 02:14:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C34F5C433C8; Fri, 10 Jul 2020 02:14:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC953C433C6;
        Fri, 10 Jul 2020 02:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC953C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH] interconnect: msm8916: Fix buswidth of pcnoc_s nodes
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, jun.nie@linaro.org,
        okukatla@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200709130004.12462-1-georgi.djakov@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <320b3577-d7cd-886d-7a39-eafa286a8286@codeaurora.org>
Date:   Thu, 9 Jul 2020 19:14:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709130004.12462-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/9/2020 6:00 AM, Georgi Djakov wrote:
> The buswidth of the pcnoc_s_* nodes is actually not 8, but
> 4 bytes. Let's fix it.
> 
> Reported-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/qcom/msm8916.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Mike Tipton <mdtipton@codeaurora.org>

> 
> diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
> index e94f3c5228b7..42c6c5581662 100644
> --- a/drivers/interconnect/qcom/msm8916.c
> +++ b/drivers/interconnect/qcom/msm8916.c
> @@ -197,13 +197,13 @@ DEFINE_QNODE(pcnoc_int_0, MSM8916_PNOC_INT_0, 8, -1, -1, MSM8916_PNOC_SNOC_MAS,
>   DEFINE_QNODE(pcnoc_int_1, MSM8916_PNOC_INT_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
>   DEFINE_QNODE(pcnoc_m_0, MSM8916_PNOC_MAS_0, 8, -1, -1, MSM8916_PNOC_INT_0);
>   DEFINE_QNODE(pcnoc_m_1, MSM8916_PNOC_MAS_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
> -DEFINE_QNODE(pcnoc_s_0, MSM8916_PNOC_SLV_0, 8, -1, -1, MSM8916_SLAVE_CLK_CTL, MSM8916_SLAVE_TLMM, MSM8916_SLAVE_TCSR, MSM8916_SLAVE_SECURITY, MSM8916_SLAVE_MSS);
> -DEFINE_QNODE(pcnoc_s_1, MSM8916_PNOC_SLV_1, 8, -1, -1, MSM8916_SLAVE_IMEM_CFG, MSM8916_SLAVE_CRYPTO_0_CFG, MSM8916_SLAVE_MSG_RAM, MSM8916_SLAVE_PDM, MSM8916_SLAVE_PRNG);
> -DEFINE_QNODE(pcnoc_s_2, MSM8916_PNOC_SLV_2, 8, -1, -1, MSM8916_SLAVE_SPDM, MSM8916_SLAVE_BOOT_ROM, MSM8916_SLAVE_BIMC_CFG, MSM8916_SLAVE_PNOC_CFG, MSM8916_SLAVE_PMIC_ARB);
> -DEFINE_QNODE(pcnoc_s_3, MSM8916_PNOC_SLV_3, 8, -1, -1, MSM8916_SLAVE_MPM, MSM8916_SLAVE_SNOC_CFG, MSM8916_SLAVE_RBCPR_CFG, MSM8916_SLAVE_QDSS_CFG, MSM8916_SLAVE_DEHR_CFG);
> -DEFINE_QNODE(pcnoc_s_4, MSM8916_PNOC_SLV_4, 8, -1, -1, MSM8916_SLAVE_VENUS_CFG, MSM8916_SLAVE_CAMERA_CFG, MSM8916_SLAVE_DISPLAY_CFG);
> -DEFINE_QNODE(pcnoc_s_8, MSM8916_PNOC_SLV_8, 8, -1, -1, MSM8916_SLAVE_USB_HS, MSM8916_SLAVE_SDCC_1, MSM8916_SLAVE_BLSP_1);
> -DEFINE_QNODE(pcnoc_s_9, MSM8916_PNOC_SLV_9, 8, -1, -1, MSM8916_SLAVE_SDCC_2, MSM8916_SLAVE_LPASS, MSM8916_SLAVE_GRAPHICS_3D_CFG);
> +DEFINE_QNODE(pcnoc_s_0, MSM8916_PNOC_SLV_0, 4, -1, -1, MSM8916_SLAVE_CLK_CTL, MSM8916_SLAVE_TLMM, MSM8916_SLAVE_TCSR, MSM8916_SLAVE_SECURITY, MSM8916_SLAVE_MSS);
> +DEFINE_QNODE(pcnoc_s_1, MSM8916_PNOC_SLV_1, 4, -1, -1, MSM8916_SLAVE_IMEM_CFG, MSM8916_SLAVE_CRYPTO_0_CFG, MSM8916_SLAVE_MSG_RAM, MSM8916_SLAVE_PDM, MSM8916_SLAVE_PRNG);
> +DEFINE_QNODE(pcnoc_s_2, MSM8916_PNOC_SLV_2, 4, -1, -1, MSM8916_SLAVE_SPDM, MSM8916_SLAVE_BOOT_ROM, MSM8916_SLAVE_BIMC_CFG, MSM8916_SLAVE_PNOC_CFG, MSM8916_SLAVE_PMIC_ARB);
> +DEFINE_QNODE(pcnoc_s_3, MSM8916_PNOC_SLV_3, 4, -1, -1, MSM8916_SLAVE_MPM, MSM8916_SLAVE_SNOC_CFG, MSM8916_SLAVE_RBCPR_CFG, MSM8916_SLAVE_QDSS_CFG, MSM8916_SLAVE_DEHR_CFG);
> +DEFINE_QNODE(pcnoc_s_4, MSM8916_PNOC_SLV_4, 4, -1, -1, MSM8916_SLAVE_VENUS_CFG, MSM8916_SLAVE_CAMERA_CFG, MSM8916_SLAVE_DISPLAY_CFG);
> +DEFINE_QNODE(pcnoc_s_8, MSM8916_PNOC_SLV_8, 4, -1, -1, MSM8916_SLAVE_USB_HS, MSM8916_SLAVE_SDCC_1, MSM8916_SLAVE_BLSP_1);
> +DEFINE_QNODE(pcnoc_s_9, MSM8916_PNOC_SLV_9, 4, -1, -1, MSM8916_SLAVE_SDCC_2, MSM8916_SLAVE_LPASS, MSM8916_SLAVE_GRAPHICS_3D_CFG);
>   DEFINE_QNODE(pcnoc_snoc_mas, MSM8916_PNOC_SNOC_MAS, 8, 29, -1, MSM8916_PNOC_SNOC_SLV);
>   DEFINE_QNODE(pcnoc_snoc_slv, MSM8916_PNOC_SNOC_SLV, 8, -1, 45, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC, MSM8916_SNOC_INT_1);
>   DEFINE_QNODE(qdss_int, MSM8916_SNOC_QDSS_INT, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC);
> 
