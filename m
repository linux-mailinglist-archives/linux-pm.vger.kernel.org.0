Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B33113DC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 22:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhBEVrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 16:47:37 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33278 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhBEVrY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 16:47:24 -0500
Received: by mail-oi1-f182.google.com with SMTP id j25so9100626oii.0;
        Fri, 05 Feb 2021 13:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qsoj6U+YiZqoTqMhu74W85NjJOLqUQBpVRXjPRbvOF8=;
        b=oM/xsdfJ2N8dUC3VoqTq/nZ7mo8KN8ydn/mrYwK5DHwO4AjeM2LoQPpnxpRsPvQQ4d
         6foOAGJl2znCykAimoH0qSKr3N2VSkLpVe6ZnIRrAL+xPByollUeVmauerg3xnxhmMP0
         CIm7CgXIC7GsuzijAiPrMGyraJC5pVg7U6aH3MMlcms4HjX3RQJPYvZ/GgnXvnwzSC6R
         /tepXOHCW9daxwGNzLCq3HXrQP2uuFBGPdQNaKxnwLvU4dtyZW2ncOxgZn40w3vt7SNR
         dc1weIT4wxq9YF9zIcKDsLd4zVc9mrxPbWi9XoIdtc61o7R852t17yHhIhir3ZzW1LaQ
         2i4w==
X-Gm-Message-State: AOAM532XJJkphh2dImJWYbGwBe/bP55DcBu+CThQSySEqb05ac2Jlfba
        0gMV4QchoITRqzIy1B2coQ==
X-Google-Smtp-Source: ABdhPJxbmsGmAL7Fd48aKU/yFzJDlkiLGzd5K6v8LR4YrR6Ly7RTvpD0SmKpUWimZM3wizqZHHV6Cw==
X-Received: by 2002:aca:aac9:: with SMTP id t192mr4277226oie.111.1612561603682;
        Fri, 05 Feb 2021 13:46:43 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s127sm2055587oib.33.2021.02.05.13.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:46:42 -0800 (PST)
Received: (nullmailer pid 3805895 invoked by uid 1000);
        Fri, 05 Feb 2021 21:46:41 -0000
Date:   Fri, 5 Feb 2021 15:46:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5 3/7] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
Message-ID: <20210205214641.GA3802952@robh.at.kernel.org>
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
 <20210121195250.492500-4-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121195250.492500-4-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 21, 2021 at 08:52:46PM +0100, AngeloGioacchino Del Regno wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Add devicetree documentation for 'qcom,freq-domain' property specific
> to Qualcomm CPUs. This property is used to reference the CPUFREQ node
> along with Domain ID (0/1).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 14cd727d3c4b..1d60975df23a 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -290,6 +290,12 @@ properties:
>  
>        * arm/msm/qcom,kpss-acc.txt
>  
> +  qcom,freq-domain:

What happened to having a standard property here? There were 1 or 2 
other cases of doing the same thing.

> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description: |
> +      CPUs supporting freq-domain must set their "qcom,freq-domain" property
> +      with phandle to a cpufreq_hw node followed by the Domain ID(0/1).
> +
>    rockchip,pmu:
>      $ref: '/schemas/types.yaml#/definitions/phandle'
>      description: |
> -- 
> 2.30.0
> 
