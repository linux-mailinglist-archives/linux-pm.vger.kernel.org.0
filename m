Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA027D1BE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgI2OrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 10:47:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42728 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgI2OrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 10:47:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id x14so5706560oic.9;
        Tue, 29 Sep 2020 07:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+jkK+PPaaP5z1YbhSNZVLbX0jLjwvJDt+lXO77GaZE=;
        b=AEu/oEMeqFidsv+EunfUEPC7ZSmsVe4pEidQzyjoGttDZYHZHza0+c1eyXcOt0jlTa
         4OBpxtjaCDPoWxlSbx083pPbkbqFCRVa/6+4beGKwMrFhseuPDCXBnpeibti7I5e3r3o
         WSSz19C6qJYo0nhdkDkQdkFPZaRF4kyjYT9ooNjsQv0uRK803nqUwpgBbdwqxczT+aSI
         omkoHU4el+QnZFlX8b7Sev+MDQAS135dh1n2oWcEiRs1eqJhML9M73+C/Q/2fIR3TN/R
         5CtMXgiKD+/x+zDDNMpcSFiGHPzjN1w7AZLieS+zU1WSSHpNtJype/GCq0ao8hGgtA5r
         rgWw==
X-Gm-Message-State: AOAM533EfIX6fQX186PmYc7AbSVql7iKF69gNuQ7kNIj2ASWfDZkRUOW
        MAFaVXLSIjEGZEbtLH8VYQ==
X-Google-Smtp-Source: ABdhPJxTB0sQwV+hE3Pv+aOyjWqdRJQeV7R0c0cGhfEWtJCKxBi7I2TmJx3HvZFdwx9fXCqrdoH7Hg==
X-Received: by 2002:aca:ec53:: with SMTP id k80mr2729308oih.92.1601390837759;
        Tue, 29 Sep 2020 07:47:17 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d17sm1023033oth.73.2020.09.29.07.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:47:17 -0700 (PDT)
Received: (nullmailer pid 565670 invoked by uid 1000);
        Tue, 29 Sep 2020 14:47:16 -0000
Date:   Tue, 29 Sep 2020 09:47:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org, marijns95@gmail.com,
        konradybcio@gmail.com, martin.botka1@gmail.com,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
Message-ID: <20200929144716.GB557822@bogus>
References: <20200928195853.40084-1-kholk11@gmail.com>
 <20200928195853.40084-3-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928195853.40084-3-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 28, 2020 at 09:58:53PM +0200, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add the bindings for the Qualcomm SDM660-class NoC, valid for
> SDM630, SDM636, SDM660 and SDA variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
> new file mode 100644
> index 000000000000..440e9bc1382a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SDM660 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Georgi Djakov <georgi.djakov@linaro.org>
> +
> +description: |
> +  The Qualcomm SDM660 interconnect providers support adjusting the
> +  bandwidth requirements between the various NoC fabrics.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  compatible:
> +    enum:
> +      - qcom,sdm660-a2noc
> +      - qcom,sdm660-bimc
> +      - qcom,sdm660-cnoc
> +      - qcom,sdm660-gnoc
> +      - qcom,sdm660-mnoc
> +      - qcom,sdm660-snoc
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +  clocks:
> +    minItems: 1

Looks like 2 is the min?

> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#interconnect-cells'
> +  - clock-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm660-mnoc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus Clock.
> +            - description: Bus A Clock.
> +            - description: CPU-NoC High-performance Bus Clock.
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: bus_a
> +            - const: iface

Given both cases are the same except the 3rd clock, all this can be 
moved to the main section. Then here you just need to restrict things 
to 2 or 3 clocks.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm660-a2noc
> +              - qcom,sdm660-bimc
> +              - qcom,sdm660-cnoc
> +              - qcom,sdm660-gnoc
> +              - qcom,sdm660-snoc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus Clock.
> +            - description: Bus A Clock.
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: bus_a
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/qcom,rpmcc.h>
> +      #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
> +
> +      bimc: interconnect@1008000 {
> +              compatible = "qcom,sdm660-bimc";
> +              reg = <0x01008000 0x78000>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +      };
> +
> +      cnoc: interconnect@1500000 {
> +              compatible = "qcom,sdm660-cnoc";
> +              reg = <0x01500000 0x10000>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> +                       <&rpmcc RPM_SMD_CNOC_A_CLK>;
> +      };
> +
> +      snoc: interconnect@1626000 {
> +              compatible = "qcom,sdm660-snoc";
> +              reg = <0x01626000 0x7090>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +      };
> +
> +      a2noc: interconnect@1704000 {
> +              compatible = "qcom,sdm660-a2noc";
> +              reg = <0x01704000 0xc100>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
> +                       <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
> +      };
> +
> +      mnoc: interconnect@1745000 {
> +              compatible = "qcom,sdm660-mnoc";
> +              reg = <0x01745000 0xa010>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a", "iface";
> +              clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
> +                       <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
> +                       <&mmcc AHB_CLK_SRC>;
> +      };
> +
> +      gnoc: interconnect@17900000 {
> +              compatible = "qcom,sdm660-gnoc";
> +              reg = <0x17900000 0xe000>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&xo_board>, <&xo_board>;
> +      };
> -- 
> 2.28.0
> 
