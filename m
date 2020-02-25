Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12E516BE68
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgBYKQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 05:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbgBYKQV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 05:16:21 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9062121556;
        Tue, 25 Feb 2020 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582625780;
        bh=xhugCcXsdvxmy9hj5XGYrT1xM/LDjkFC5Qq8nX+dKIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KwZAkaiSP/Br/sdl4/u9ZJClNk6MnLu9FyxNTiCesQcjS+dpDBmMt3I6zuxlr1gKJ
         GB95oUUG/U90zRpBYQbeDmcvN78yrD752Xux8kUDorEjy0Y6GzkYgyhokB1MwIa1j1
         BGcTW1j2iPmDjPic8M5mNpyfFCKIXhBvQ2Gj+nvw=
Date:   Tue, 25 Feb 2020 15:46:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: thermal: tsens: Make dtbs_check pass
 for sc7180 tsens
Message-ID: <20200225101614.GN2618@vkoul-mobl>
References: <cover.1582615616.git.amit.kucheria@linaro.org>
 <0f506cfdd8eb9d50b5eb43c9dca510284ac8ded1.1582615616.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f506cfdd8eb9d50b5eb43c9dca510284ac8ded1.1582615616.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-02-20, 13:01, Amit Kucheria wrote:
> Fixes the following warnings:
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c263000: compatible: ['qcom,sc7180-tsens',
> 'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
> causes of the failure):
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> ['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> ['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c263000: compatible:1: 'qcom,tsens-v0_1' was expected
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c263000: compatible:1: 'qcom,tsens-v1' was expected

I think the patch title should be "add qcom,sc7180-tsens to  qcom-tsens.yaml"

and it would be great to see explanation on how adding it fixes these
warns.

Relooking at series I think this applies to rest of the series too :)

Thanks


> 
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c265000: compatible: ['qcom,sc7180-tsens',
> 'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
> causes of the failure):
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
> ['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
> ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
> ['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c265000: compatible:1: 'qcom,tsens-v0_1' was expected
> builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> thermal-sensor@c265000: compatible:1: 'qcom,tsens-v1' was expected
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index eef13b9446a8..13e294328932 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -39,6 +39,7 @@ properties:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
>                - qcom,sdm845-tsens
> +              - qcom,sc7180-tsens
>            - const: qcom,tsens-v2
>  
>    reg:
> -- 
> 2.20.1

-- 
~Vinod
