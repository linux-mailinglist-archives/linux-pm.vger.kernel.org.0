Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3519C34DF91
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 05:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhC3DtB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 23:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC3Dsj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 23:48:39 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE12C061765
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 20:48:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso14304092ott.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZaWpeqY25MeDhtAts3m3c7ZDqv8GKc5eM14JLBJ3UhM=;
        b=aria6U2aOK6GNQcIMqfIxcq4rDTxMTjlMu8p5Gj0XcnZDv6UluWjUciozLsMrU6ilw
         U0HikIaK3NQMBUMW2/fCPa22dSCeaj/KcZcvtJrrzr/wzbj/KLS6Y+EFEXuOgX4YdmRA
         W/B9dGHzbRfo+bIYqx7XluDewImcQRnP44+uPb/sUcYm1+yhiLzRlS1a/SP/xFzBVgMV
         OtWLSXViZyg6VOX4f2rxhInfbe8ohYLkH0W2NjJVcveY85UaUbf+Bp7ZaBvFpPRRD6DM
         JwZFPCWY2XNXrET4EUcAt/5+faX6oJDyHe65d/wNbwkkGLuszr1ZRFVf0McjW3NSQpUu
         jVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZaWpeqY25MeDhtAts3m3c7ZDqv8GKc5eM14JLBJ3UhM=;
        b=i6wTZYce/7nJpPJkmrsv0w9u/fSapzs0BGM/89/PFD9SIwn5kCvkuGyzlijHQ2IUPu
         eTTHq2JcZ1sn2bZCtEuw0G7jCtleJzWrwhuycbURau7M5YbxmUoG0FhrbFBcU9BkLH3Y
         BIPYtyGMuBufCtdLJl3UDg0xGXrIO3ApZUJSSd4BRFPkHkpx92Cs5H44+DKJH7OTOKLH
         jXgeo/BRiMhabMLHDrMcxy0lmloY1jV8dbSFhPF5teqkq6m0SaWFIAmKeMQB2C1puZhR
         TGXMxxkBnNrldkWLzVfb2/DJqtLD6Bu8gSd8WZyj2IlFfH+qW+mOoqjfwCR15Vd5tpdv
         s+jw==
X-Gm-Message-State: AOAM5335eHjM8gzF9EMxJuTCeiGQ8/Ehp/x5/fawexvVBUtCRZZyy9cG
        jbXV+M4x1vRslzbaIET9iHlnDQ==
X-Google-Smtp-Source: ABdhPJxSE5litT1P7lJr0s8y9tEBHQh2kQ64l0iMcjvplDaeF9Eb9bMTzeSINA+qu1qZDc4bknkFkg==
X-Received: by 2002:a9d:6e09:: with SMTP id e9mr25522900otr.195.1617076118577;
        Mon, 29 Mar 2021 20:48:38 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w10sm4791878oth.7.2021.03.29.20.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 20:48:37 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:48:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>, daniel.lezcano@linaro.org
Cc:     agross@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: qcom-tsens: Add compatible
 for sm8350
Message-ID: <YGKflK/Ey16UDYT7@builder.lan>
References: <20210324124308.1265626-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324124308.1265626-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 24 Mar 07:43 CDT 2021, Robert Foss wrote:

> Add tsens bindings for sm8350.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Daniel, I presume it's better that you take this patch (1/2) through
your tree. I've picked patch 2.

Regards,
Bjorn

> ---
> 
> Changes since v1:
>  - Vinod: Remove comment
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 95462e071ab4..e788378eff8d 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -43,6 +43,7 @@ properties:
>                - qcom,sdm845-tsens
>                - qcom,sm8150-tsens
>                - qcom,sm8250-tsens
> +              - qcom,sm8350-tsens
>            - const: qcom,tsens-v2
>  
>    reg:
> -- 
> 2.31.0.30.g398dba342d.dirty
> 
