Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5432716C2DD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgBYN4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 08:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgBYN4e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 08:56:34 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BBC218AC;
        Tue, 25 Feb 2020 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582638992;
        bh=HsjJvbTH+q59fYeim5ErNffTAszwiuMCgtA22AZPS8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyufZEX6mJzQQ2vyo28R4iOHwTgc0pv8EAHYQTNtjGO44+qp3Nxhoa+Ku9yap4mA9
         SQyzxEqPclvtceqUOlyz3nWTCs8/6LkNvYArUGMMe//cvZIvTHDSzYFUuP4rGm2zxD
         tvvcHlC5eYRKSusIbkPuSzIfwIdXtSbSF1pQbaao=
Date:   Tue, 25 Feb 2020 19:26:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: tsens: Add entry for sc7180
 tsens to binding
Message-ID: <20200225135628.GP2618@vkoul-mobl>
References: <cover.1582632110.git.amit.kucheria@linaro.org>
 <3e760279e7152825d56f8b35160a9a55a5083ce1.1582632110.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e760279e7152825d56f8b35160a9a55a5083ce1.1582632110.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-02-20, 17:38, Amit Kucheria wrote:
> The qcom-tsens binding requires a SoC-specific and a TSENS
> family-specific binding to be specified in the compatible string.
> 
> Since qcom,sc7180-tsens is not listed in the YAML binding, we see the
> following warnings in 'make dtbs_check'. Fix them.
> 
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

Reviewed-by: Vinod Koul <vkoul@kernel.org>

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
