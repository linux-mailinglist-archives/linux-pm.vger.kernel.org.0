Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD73C7990
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 00:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhGMWYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 18:24:06 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39639 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhGMWYF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 18:24:05 -0400
Received: by mail-io1-f51.google.com with SMTP id h6so29238832iok.6;
        Tue, 13 Jul 2021 15:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hLVdUN1UwvH0UN4Bs5MAda7vt/GR42DmdAJ7QT+a24k=;
        b=gkNfCBTkKw+QQYdO/LceAsoaw8mQzPCQGtt1jZlG7LGRkUQeqJvnZUcgYJanAEu7yG
         Gii+v/cIcsTl7D42PemIwWLr/tzl87CXc8EVk3rdk54DaOZ/W/lGxkPueUeI18MpILcL
         zLAZ6sjBpfX3eEiOfXyGwh9o2mF6oWSatcT48V+CSYzS1iF1B+LlAVk4L16R4MV1M/dK
         cjo1OS8Y1+WG5apcjrHtyFllCp7O1kfAhQy0M66jO5HJmTM5fBNEQlse8+zSp4kHGNb6
         0Fg8Z9yED/tOsJXeAJ66aT/Qv4lSK+x6vuAvIn14Wh5XHObNURVHWfk7Pu+FwKNMn7BT
         va/A==
X-Gm-Message-State: AOAM530/iZzMG2TakbZfijhx2jKX7tLrAupN+bAGYQQB91VdMvKChtsX
        2LxSJvpse5PIwMGVirMeiA==
X-Google-Smtp-Source: ABdhPJwlGEofuNLKzJJJWZcUrXO565dIqlFSdBmCx0qO0Hr6vT2Mc5VtlurgxXzBD1cGX1NdoOw7iw==
X-Received: by 2002:a02:90cb:: with SMTP id c11mr6084280jag.53.1626214873978;
        Tue, 13 Jul 2021 15:21:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e17sm152176ilr.51.2021.07.13.15.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:21:13 -0700 (PDT)
Received: (nullmailer pid 952126 invoked by uid 1000);
        Tue, 13 Jul 2021 22:21:11 -0000
Date:   Tue, 13 Jul 2021 16:21:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        stephan@gerhold.net
Subject: Re: [PATCH v7 5/5] dt-bindings: soc: qcom: spm: Document SDM660 and
 MSM8998 compatibles
Message-ID: <20210713222111.GA944952@robh.at.kernel.org>
References: <20210622141117.358893-1-angelogioacchino.delregno@somainline.org>
 <20210622141117.358893-6-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622141117.358893-6-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 04:11:17PM +0200, AngeloGioacchino Del Regno wrote:
> The driver was updated to add SAW2 v4.1 support for new SoCs: document
> the new compatibles.

Can't take patches without a S-o-b. Run checkpatch.pl, it points this 
out for you.

> ---
>  .../bindings/soc/qcom/qcom,spm.yaml           | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
> index 4aaa319b2932..0faf52700dec 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
> @@ -17,6 +17,10 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - qcom,sdm660-gold-saw2-v4.1-l2
> +      - qcom,sdm660-silver-saw2-v4.1-l2
> +      - qcom,msm8998-gold-saw2-v4.1-l2
> +      - qcom,msm8998-silver-saw2-v4.1-l2

What's the difference between gold and silver? Are the h/w instances 
different (I realize the CPUs are) in some way? How does the OS use the 
different compatible strings?

>        - qcom,msm8974-saw2-v2.1-cpu
>        - qcom,apq8084-saw2-v2.1-cpu
>        - qcom,apq8064-saw2-v1.1-cpu
> @@ -33,6 +37,8 @@ additionalProperties: false
>  
>  examples:
>    - |
> +
> +    /* Example 1: SoC using SAW2 and kpss-acc-v2 CPUIdle */
>      cpus {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -52,4 +58,19 @@ examples:
>          reg = <0xf9089000 0x1000>;
>      };
>  
> +  - |
> +
> +    /* Example 2: New-gen multi cluster SoC using SAW only for L2;
> +     * This does not require any cpuidle driver, nor any cpu phandle.
> +     */
> +    power-controller@17812000 {
> +        compatible = "qcom,msm8998-gold-saw2-v4.1-l2", "qcom,saw2";
> +        reg = <0x17812000 0x1000>;
> +    };
> +
> +    power-controller@17912000 {
> +        compatible = "qcom,msm8998-silver-saw2-v4.1-l2", "qcom,saw2";
> +        reg = <0x17912000 0x1000>;
> +    };
> +
>  ...
> -- 
> 2.32.0
> 
> 
