Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4066AF4F
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jan 2023 05:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjAOEQK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Jan 2023 23:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjAOEQI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Jan 2023 23:16:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C597293;
        Sat, 14 Jan 2023 20:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EDDBCE0989;
        Sun, 15 Jan 2023 04:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C3C433D2;
        Sun, 15 Jan 2023 04:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673756163;
        bh=2CFAsLsTP5x4IK8ZGcAB8dUH203PMxT+nYUzjSe8obE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAfx1LH0tf/YgSQhr2ps6HTLeE6pal6HwIuB5v3bAYIs9Qp+DChzmkY1tQ9de0JHR
         29oN5+PbshH1iADDSq+RsmmxlhLrTWU3dvWjHovSGca6B3CSRFVKH6C1ZkESmIZ/Ub
         BEjnIiwNkR81J66Gt3prAJHq9Yi5tBRGPKQQIcatdMg8U1KvKX7AZYO0ew5BikOEGa
         hzg/+DObD+ZXHAdxlPskceOmI8Gm/PDysQHww0FVV65QJxxYQHJDgUPStHWkSt7+pi
         f6/RMOeo+MGV4o0LRGk2imPz5MDwewQoVpgc6kYkTx8Tll2tGC7Hguvg8sSiSsDZDg
         qVcsmW3QKBfug==
Date:   Sun, 15 Jan 2023 09:45:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/12] interconnect: qcom: sdx55: drop IP0 remnants
Message-ID: <20230115041555.GF6568@thinkpad>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
 <20230109002935.244320-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109002935.244320-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 09, 2023 at 02:29:24AM +0200, Dmitry Baryshkov wrote:
> Drop two defines leftover from the commit 2fb251c26560 ("interconnect:
> qcom: sdx55: Drop IP0 interconnects"), which dropped handling of the IP0
> resource in favour of handling it in the clk-rpmh driver.
> 
> Fixes: 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0 interconnects")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/interconnect/qcom/sdx55.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdx55.h b/drivers/interconnect/qcom/sdx55.h
> index deff8afe0631..46cbabec8aa1 100644
> --- a/drivers/interconnect/qcom/sdx55.h
> +++ b/drivers/interconnect/qcom/sdx55.h
> @@ -6,7 +6,7 @@
>  #ifndef __DRIVERS_INTERCONNECT_QCOM_SDX55_H
>  #define __DRIVERS_INTERCONNECT_QCOM_SDX55_H
>  
> -#define SDX55_MASTER_IPA_CORE			0
> +/* 0 was used by MASTER_IPA_CORE, now represented as RPMh clock */
>  #define SDX55_MASTER_LLCC			1
>  #define SDX55_MASTER_TCU_0			2
>  #define SDX55_MASTER_SNOC_GC_MEM_NOC		3
> @@ -28,7 +28,7 @@
>  #define SDX55_MASTER_QDSS_ETR			19
>  #define SDX55_MASTER_SDCC_1			20
>  #define SDX55_MASTER_USB3			21
> -#define SDX55_SLAVE_IPA_CORE			22
> +/* 22 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SDX55_SLAVE_EBI_CH0			23
>  #define SDX55_SLAVE_LLCC			24
>  #define SDX55_SLAVE_MEM_NOC_SNOC		25
> -- 
> 2.39.0
> 

-- 
மணிவண்ணன் சதாசிவம்
