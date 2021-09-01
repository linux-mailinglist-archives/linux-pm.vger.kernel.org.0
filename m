Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18B3FDE0A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhIAOw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhIAOwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 10:52:55 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B82C061575
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 07:51:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0B1621F8BE;
        Wed,  1 Sep 2021 16:51:57 +0200 (CEST)
Subject: Re: [PATCH] interconnect: qcom: sdm660: Correct NOC_QOS_PRIORITY
 shift and mask
To:     Shawn Guo <shawn.guo@linaro.org>, Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210823075405.382-1-shawn.guo@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <841c00e2-4adc-ab3c-fba3-8d36d0280e4d@somainline.org>
Date:   Wed, 1 Sep 2021 16:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210823075405.382-1-shawn.guo@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 23/08/21 09:54, Shawn Guo ha scritto:
> The NOC_QOS_PRIORITY shift and mask do not match what vendor kernel
> defines [1].  Correct them per vendor kernel.
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/soc/qcom/msm_bus/msm_bus_noc_adhoc.c?h=LA.UM.8.2.r1-04800-sdm660.0#n37
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Hello Shawn,
the patch looks great and I'm sorry for getting it wrong in the first place; 
luckily there was no regression due to this mistake.

However, a few considerations:

> ---
>   drivers/interconnect/qcom/sdm660.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index ac13046537e8..c89c991a80a0 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -44,9 +44,10 @@
>   #define NOC_PERM_MODE_BYPASS		(1 << NOC_QOS_MODE_BYPASS)
>   
>   #define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
> -#define NOC_QOS_PRIORITY_MASK		0xf
> +#define NOC_QOS_PRIORITY_P1_MASK	0xc
> +#define NOC_QOS_PRIORITY_P0_MASK	0x3
>   #define NOC_QOS_PRIORITY_P1_SHIFT	0x2
> -#define NOC_QOS_PRIORITY_P0_SHIFT	0x3
> +#define NOC_QOS_PRIORITY_P0_SHIFT	0x0

Defining NOC_QOS_PRIORITY_P0_SHIFT as 0x0 means that there's no shifting action,
which means that we can avoid defining this at all.

>   
>   #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
>   #define NOC_QOS_MODEn_MASK		0x3
> @@ -624,13 +625,13 @@ static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
>   	/* Must be updated one at a time, P1 first, P0 last */
>   	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
>   	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> -				NOC_QOS_PRIORITY_MASK, val);
> +				NOC_QOS_PRIORITY_P1_MASK, val);
>   	if (rc)
>   		return rc;
>   
>   	val = qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;

... so this would be `qos->prio_level << 0`, so if we simply not define any 
NOC_QOS_PRIORITY_P0_SHIFT, this can be simplified as:

val = qos->prio_level;

...but that would also eliminate the need to assign it to `val`, so...

>   	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> -				  NOC_QOS_PRIORITY_MASK, val);
> +				  NOC_QOS_PRIORITY_P0_MASK, val);

Here we can instead do:
	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),

				  NOC_QOS_PRIORITY_MASK, qos->prio_level);

				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);

Cheers,
- Angelo

>   }
>   
>   static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
> 

