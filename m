Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942164264D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Dec 2022 11:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLEKDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 05:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiLEKDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 05:03:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016D7C0F;
        Mon,  5 Dec 2022 02:03:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A3CC66003EF;
        Mon,  5 Dec 2022 10:03:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670234616;
        bh=3myGzgoCY0AcXvZSkCZnjZ8vlQZf+gbCK1V/oN4UuRk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QM08QN3dE5CltqFKkcy3x9/UUUu1jXqS4Wc783Ombkmf5bSa9wOfp7TNXpHS1P3Cn
         1UWQZbBu5HLHU8xGSH6Q6FfoyVqHfXjXInA5QPw3ZnBFGAWLEpocJdWrB+q7YyuRgg
         kHXByw29h+y5tj7tkOGb5Qf2oqsRx+hSfZaN/U6dVJXiXp7fQAeZxTLtcqcnc82mYY
         MMpnXcUzFDxdtbY3FHyuyLGD8xfFH5a1sJjQEiZG5ul5J2yg1IyJx2UOOwbxELOz5K
         Ld8Qa4L99R1FqjADrzcrWz/Y5pia0sSKfPX2qS4BSPBlvTvrqHbo6FKLuqAFu+qpH/
         TqTyYr9Ft3X6g==
Message-ID: <1196ef87-0be0-6c0c-8851-e58919a81ade@collabora.com>
Date:   Mon, 5 Dec 2022 11:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 06/15] thermal/drivers/tsens: Sort out msm8976 vs
 msm8956 data
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
 <20221204055909.1351895-7-dmitry.baryshkov@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221204055909.1351895-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 04/12/22 06:59, Dmitry Baryshkov ha scritto:
> Tsens driver mentions that msm8976 data should be used for both msm8976
> and msm8956 SoCs. This is not quite correct, as according to the
> vendor kernels, msm8976 should use standard slope values (3200), while
> msm8956 really uses the slope values found in the driver.
> 
> Add separate compatibility string for msm8956, move slope value
> overrides to the corresponding init function and use the standard
> compute_intercept_slope() function for both platforms.
> 
> Fixes: 0e580290170d ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/thermal/qcom/tsens-v1.c | 56 ++++++++++++++++++---------------
>   drivers/thermal/qcom/tsens.c    |  3 ++
>   drivers/thermal/qcom/tsens.h    |  2 +-
>   3 files changed, 34 insertions(+), 27 deletions(-)
> 

..snip..

> @@ -357,6 +333,22 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>   };
>   
> +int __init init_8956(struct tsens_priv *priv) {

That function should be static as it's both defined and used only in here,
plus, brace goes on a new line. Please fix.

static int __init init_8956(struct tsens_priv *priv)
{


....after which....
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo
