Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A013FF3FC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbhIBTRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 15:17:45 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46007 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhIBTRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 15:17:44 -0400
Received: by mail-ot1-f44.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso3850669otv.12;
        Thu, 02 Sep 2021 12:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ovK23jw31tHHzYJHygiQckfwChmChzppFMTDWeKXBRI=;
        b=oweKH9fzSv6DGrYI0T65IAym4s6vQZV/n/30Y3vnGD613t7RC7FOLes9MnNs80hTOq
         TquhcS/AFJE3lmsAWFpcJYlZAUsVwI985dMi5umLUsjInu6oBNR9cpXoEHjuI1Ye9KKG
         7Z2jLNHD3sbZIRX0Vdnw+RuEWlyRhy8s0H7y5rawfC0Ocg6YRAg0oWBtOfx4iV56JC0C
         pjmtYcRdkFijPMbNC5X4KMIbYcznLjDrMaOWWXreMQQqZmfO8a7FX71LAK1mfwvFknCm
         204Ssi6IIXXowJKdyU7POaV5Pwch7SNf3tK1RdJEWZ4zc1Hi1PeDSIsPzna+Tyzfo9rf
         8+gg==
X-Gm-Message-State: AOAM531XLp4HqPeM8edtkrLl+2e+GpO9RqdyyE1rttZOjPhWU/PI5k3v
        PXEgRxIjPikv4oudwHESYg==
X-Google-Smtp-Source: ABdhPJwL9T1ZSpeCfgUmexDbaoohVcg3Vhw3JPmY6MVMZVQDu1uIq6BQ4K5WGv8rH9Y07O0IMyc41Q==
X-Received: by 2002:a05:6830:20c2:: with SMTP id z2mr3957625otq.285.1630610204847;
        Thu, 02 Sep 2021 12:16:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z18sm558960oib.27.2021.09.02.12.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 12:16:43 -0700 (PDT)
Received: (nullmailer pid 1233714 invoked by uid 1000);
        Thu, 02 Sep 2021 19:16:42 -0000
Date:   Thu, 2 Sep 2021 14:16:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        agross@kernel.org, nm@ti.com, ilia.lin@kernel.org,
        niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] dt-bindings: opp: Add binding for qcom-cpu-opp
Message-ID: <YTEjGv/NVj4Jm/fh@robh.at.kernel.org>
References: <20210901155559.627491-1-angelogioacchino.delregno@somainline.org>
 <20210901155559.627491-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901155559.627491-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 01, 2021 at 05:55:59PM +0200, AngeloGioacchino Del Regno wrote:
> This adds a binding documenting operating-points-v2-kryo-cpu in a
> qcom-cpu-opp.yaml file. Logic is to add any new Qualcomm SoCs CPU
> related OPP compatibles in here.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../devicetree/bindings/opp/qcom-cpu-opp.yaml | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml b/Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml
> new file mode 100644
> index 000000000000..b4d83b64228c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0

As checkpatch says, dual license.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/qcom-cpu-opp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. CPU OPP bindings
> +
> +maintainers:
> +  - Ilia Lin <ilia.lin@kernel.org>
> +
> +allOf:
> +  - $ref: opp-v2-base.yaml#
> +
> +properties:
> +  compatible:
> +    const: operating-points-v2-kryo-cpu
> +
> +  nvmem-cells:
> +    description: |
> +      A phandle pointing to a nvmem-cells node representing the efuse
> +      registers that has information about the speedbin that is used
> +      to select the right frequency/voltage value pair.
> +    maxItems: 1
> +
> +  opp-shared: true
> +
> +required:
> +  - compatible
> +
> +patternProperties:
> +  '^opp-?[0-9]+$':
> +    type: object
> +
> +    properties:
> +      clock-latency-ns: true
> +      opp-hz: true
> +      opp-microvolt: true
> +      opp-supported-hw: true
> +      required-opps: true
> +
> +    required:
> +      - opp-hz
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpu_opp_table: opp-table-cpu {
> +        compatible = "operating-points-v2-kryo-cpu";
> +        opp-shared;
> +
> +        opp-1094400000 {
> +            opp-hz = /bits/ 64 <1094400000>;
> +            required-opps = <&cpr_opp1>;
> +        };
> +        opp-1248000000 {
> +            opp-hz = /bits/ 64 <1248000000>;
> +            required-opps = <&cpr_opp2>;
> +        };
> +        opp-1401600000 {
> +            opp-hz = /bits/ 64 <1401600000>;
> +            required-opps = <&cpr_opp3>;
> +        };
> +    };
> +...
> -- 
> 2.32.0
> 
> 
