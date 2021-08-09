Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5F3E4596
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 14:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhHIM2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 08:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233445AbhHIM2v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Aug 2021 08:28:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FA2D60F35;
        Mon,  9 Aug 2021 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628512110;
        bh=JGSvrCfKRW/1RSWBpEUr4Y07/7eMV0KoLH44cKquAlw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hckv4uIKArYhNLFa1L8Le/ghZAxLW8TUJDZ/QjBn0Jn8SPqfcNR4J541QvqDxyPzA
         n5AlygZ9kH/q+9s5xGZuEK90R6k34pMG2EG7sp5dxy6bzO+0ltK/pOrUrqCsaD9zsc
         gS0yzVw5aszJ7Vh9DNDEhP18CiumiK04NA8au8MvgntwbxmkzYNAqgcj8qAiYRDLzl
         UG5mWLNbLLSxv4RynAhW+EY7JKG1aeGHydqDkc+NmDB1/aRPqUbN4aeqMovS/SMptd
         Xib/cro1painKGu1/6J+Gxji7eeCEqemnkd/KcnP3IC7es4k393vKvDjmRNh0BZezM
         2cC2+xDfE5TNw==
Subject: Re: [PATCH] drivers: interconnect: sdm660: Fix up erroneous paths
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210728222033.52500-1-konrad.dybcio@somainline.org>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <7844e0fc-3cb7-6653-217b-e615ef7a15ac@kernel.org>
Date:   Mon, 9 Aug 2021 15:28:26 +0300
MIME-Version: 1.0
In-Reply-To: <20210728222033.52500-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Konrad,

Thanks for the patch!

On 29.07.21 1:20, Konrad Dybcio wrote:
> Fix the earlier porting mistakes to make interconnect work properly.

Could you be more specific, please? Do we need a fixes tag?

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>   drivers/interconnect/qcom/sdm660.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index 632dbdd21915..93856dd6730b 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -264,10 +264,10 @@ DEFINE_QNODE(mas_sdcc_1, SDM660_MASTER_SDCC_1, 8, 33, -1, false, -1, 0, -1, SDM6
>   DEFINE_QNODE(mas_sdcc_2, SDM660_MASTER_SDCC_2, 8, 35, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
>   DEFINE_QNODE(mas_blsp_1, SDM660_MASTER_BLSP_1, 4, 41, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
>   DEFINE_QNODE(mas_blsp_2, SDM660_MASTER_BLSP_2, 4, 39, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
> -DEFINE_QNODE(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, true, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_A2NOC_SNOC);
> -DEFINE_QNODE(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, true, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, true, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, true, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
>   DEFINE_QNODE(mas_usb3, SDM660_MASTER_USB3, 8, 32, -1, true, NOC_QOS_MODE_FIXED, 1, 2, SDM660_SLAVE_A2NOC_SNOC);
> -DEFINE_QNODE(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, true, NOC_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, false, NOC_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
>   DEFINE_QNODE(mas_gnoc_bimc, SDM660_MASTER_GNOC_BIMC, 4, 144, -1, true, NOC_QOS_MODE_FIXED, 0, 0, SDM660_SLAVE_EBI);
>   DEFINE_QNODE(mas_oxili, SDM660_MASTER_OXILI, 4, 6, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
>   DEFINE_QNODE(mas_mnoc_bimc, SDM660_MASTER_MNOC_BIMC, 4, 2, -1, true, NOC_QOS_MODE_BYPASS, 0, 2, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
> @@ -596,7 +596,8 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
>   	if (qn->qos.qos_mode != -1)
>   		mode = qn->qos.qos_mode;
>   
> -	/* QoS Priority: The QoS Health parameters are getting considered
> +	/*
> +	 * QoS Priority: The QoS Health parameters are getting considered

Nit: Unrelated change

>   	 * only if we are NOT in Bypass Mode.
>   	 */
>   	if (mode != NOC_QOS_MODE_BYPASS) {
> @@ -916,6 +917,7 @@ static struct platform_driver sdm660_noc_driver = {
>   	.driver = {
>   		.name = "qnoc-sdm660",
>   		.of_match_table = sdm660_noc_of_match,
> +		.sync_state = icc_sync_state,

Enabling sync_state should be a separate patch.

Thanks,
Georgi

>   	},
>   };
>   module_platform_driver(sdm660_noc_driver);
> 

