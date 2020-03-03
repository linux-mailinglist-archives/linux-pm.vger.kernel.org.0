Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8B176A04
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 02:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCCB2u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 20:28:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46776 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCCB2u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 20:28:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id g96so1349051otb.13;
        Mon, 02 Mar 2020 17:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eet9lZNdchN33q+dEpaXmuVlgsvcHvBcNPBCflfSjxo=;
        b=f8mwstks/wkvSrxETMQDFJhZ+G7HdALKjPZlig4vEiHnVktAJiSdsd3OJbT+3SRleb
         eGSuHz/hPQ2CLOlae37xYRo1PFAHUegsjyRHFb2XhaI518ynOi5mNc8YwTrZEubjQanS
         OJ2YcaOCREdRz9v5Pj7gD+TogSMo6KCQK2yK7fzdtrSuaEVQr82piWHOlvMfRCc7wej8
         DGDotukOv2BfJiCHT7rqmwJjwFonx57xGXWA3lrXOaRiwLuTi1tbicXhi1/4sgH8Qqla
         2nV4l4wZvou82kppJMWEq6W9Ny67I5TK5fGTdFEU0j/62wCR76A1/1swV/Mx3Wx/WUg8
         Vvgg==
X-Gm-Message-State: ANhLgQ0nFU6MCjvGYQJs9Hedg1/QhbtYDTSX1jUC6cWpOvXTiRjxErRv
        dx1dxmnGicDmqycrU4IOiQ==
X-Google-Smtp-Source: ADFU+vvoin64lIvmLgeV8610QkmyYB0ZPZYEy2jhHQOrLVViftZhZeuOjY2eOqe7Pu/6/ZOSTijj1w==
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr1531326otp.242.1583198929345;
        Mon, 02 Mar 2020 17:28:49 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k16sm712675otp.52.2020.03.02.17.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:28:48 -0800 (PST)
Received: (nullmailer pid 8615 invoked by uid 1000);
        Tue, 03 Mar 2020 01:28:47 -0000
Date:   Mon, 2 Mar 2020 19:28:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: tsens: Add entry for sc7180
 tsens to binding
Message-ID: <20200303012847.GA8556@bogus>
References: <cover.1582871139.git.amit.kucheria@linaro.org>
 <8309e39737c480b0835454cbc6db345c5a27ecd4.1582871139.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8309e39737c480b0835454cbc6db345c5a27ecd4.1582871139.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 28 Feb 2020 12:02:40 +0530, Amit Kucheria wrote:
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
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
