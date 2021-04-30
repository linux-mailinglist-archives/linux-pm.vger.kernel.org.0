Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6975C37032A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Apr 2021 23:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhD3Vro (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Apr 2021 17:47:44 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35387 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhD3Vro (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Apr 2021 17:47:44 -0400
Received: by mail-ot1-f54.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso2414691oti.2;
        Fri, 30 Apr 2021 14:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k5kmXfi6wS0LsDCeqnGbubfxQdvywaGfWylg+z/ACgY=;
        b=rpQNwyIfCznFsYBIWdz2ChpJy96ggdXncB3uDeiiJRXL4JVfgS1rlurZt28Q57KRQJ
         uYyc34lygPd2f9r3VmHlS7yzx66fbi9SYCaefZWwAftJlm+Vz/xyi+48boNW4hwuJQIs
         M/oH7mTXM14/gtSNl0j4KNupVkomuoWP/N3cW4Fbp3HPdNHvEhUXCxPhj9jSoaY5Kqa/
         ldht0gI0esWDB8naUzL68axxCi2Tm573zVQTtPKeG/V22pHDADVowu5HbIApEMEUAU3f
         zqqMyg06sRywTN4OruxceUeB+unTh4nYnkutohH8DVctCmWHMVO38E/5yzH/46DVPp2T
         gacQ==
X-Gm-Message-State: AOAM530sU5dpQ1jcJUyHZFn/ecVbPpK3o1DGnpKiAGRnYilbUsLsWOqh
        Ye0iNRFmXDwB6kSWZd/1Eg==
X-Google-Smtp-Source: ABdhPJwKtFBJD2trSsc1PUC+PlbrdkflmhMc8z5zMaI7tTFlTGq8MJAqXla/kw0olV4yL4+Kr0sHpw==
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr5219815otp.39.1619819214229;
        Fri, 30 Apr 2021 14:46:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 16sm272196otu.79.2021.04.30.14.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:46:53 -0700 (PDT)
Received: (nullmailer pid 3957362 invoked by uid 1000);
        Fri, 30 Apr 2021 21:46:52 -0000
Date:   Fri, 30 Apr 2021 16:46:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanm@codeaurora.org,
        manafm@codeaurora.org
Subject: Re: [PATCH V3 1/3] dt-bindings: thermal: tsens: Add compatible
 string to TSENS binding for SC7280
Message-ID: <20210430214652.GA3956278@robh.at.kernel.org>
References: <1619778592-8112-1-git-send-email-rkambl@codeaurora.org>
 <1619778592-8112-2-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619778592-8112-2-git-send-email-rkambl@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 30, 2021 at 03:59:50PM +0530, Rajeshwari wrote:
> Adding compatible string in TSENS dt-bindings for SC7280.
> 
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Is this your full name?

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index b7a832f..23cf265 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -46,6 +46,7 @@ properties:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
>                - qcom,sc7180-tsens
> +              - qcom,sc7280-tsens
>                - qcom,sdm845-tsens
>                - qcom,sm8150-tsens
>                - qcom,sm8250-tsens
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
