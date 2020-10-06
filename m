Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9C28522B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJFTOI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 15:14:08 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:35154 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgJFTOI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 15:14:08 -0400
Received: by mail-oo1-f65.google.com with SMTP id k13so3481703oor.2;
        Tue, 06 Oct 2020 12:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YBRxc4Kl5euYsrW5ldPYtXnE2JqSKHbO7VHU7IS1NW8=;
        b=P3yRFIowIfzYurTuDdZ8w8Z6zWsaWG7FviN70CUdAdN3gqZzfNirB6VpRCvJHW5Eu8
         mEqAkKzmjlQ6MKc9ACD7WEhEyj2B1wm3sUAvRTE+qiMkKkwGOUfhYqrnIMnv31ss9Zga
         lyocj+vsrOhKLYrOHB2Pr/ROcwly+NXQ7Cmc6Nb9UfmWzjy2oKP+hSMjkpoaMvmgRo+p
         ebzarh+4ol1h3FSmwkRFf9S1cmpqb2By/yVhnRQDDvQoXSJC1IGwXX6DH9vZhS8Q70Fe
         swcHFEU46InJmwmyrMfjjRG5eXD3vDwpllOgWdXNu/hUTbJfu99909KKY5wVjCESyTAP
         1AQA==
X-Gm-Message-State: AOAM531Uw9q1iorm/1Qhzj6oy6HhEhLzlah9rgwsScDlu0F33pRasszF
        96Lleb7t6GkZlifFv4zvJw==
X-Google-Smtp-Source: ABdhPJyO60XXGdD91dbKp8H85ouCBk/vtG+KxND8yp1CWYyYSTN7O0rpOmPpAErTBWuQWDvekynJuA==
X-Received: by 2002:a4a:e3d3:: with SMTP id m19mr4134545oov.55.1602011647048;
        Tue, 06 Oct 2020 12:14:07 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s124sm1556045oig.6.2020.10.06.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:14:06 -0700 (PDT)
Received: (nullmailer pid 2663111 invoked by uid 1000);
        Tue, 06 Oct 2020 19:14:05 -0000
Date:   Tue, 6 Oct 2020 14:14:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org
Subject: Re: [PATCH 3/5] dt-bindings: interconnect: single yaml file for RPM
 interconnect drivers
Message-ID: <20201006191405.GB2659485@bogus>
References: <20200930081645.3434-1-jun.nie@linaro.org>
 <20200930081645.3434-4-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930081645.3434-4-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 30, 2020 at 04:16:43PM +0800, Jun Nie wrote:
> MSM8916 and QCS404 bindings are almost identical, so combine them into one.
> This will make it easier to add interconnect bindings for more SoC with RPM.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcs404.yaml    | 77 -------------------
>  .../{qcom,msm8916.yaml => qcom,rpm.yaml}      | 24 +++---
>  2 files changed, 14 insertions(+), 87 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
>  rename Documentation/devicetree/bindings/interconnect/{qcom,msm8916.yaml => qcom,rpm.yaml} (76%)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
> deleted file mode 100644
> index 3fbb8785fbc9..000000000000
> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/interconnect/qcom,qcs404.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Qualcomm QCS404 Network-On-Chip interconnect
> -
> -maintainers:
> -  - Georgi Djakov <georgi.djakov@linaro.org>
> -
> -description: |
> -  The Qualcomm QCS404 interconnect providers support adjusting the
> -  bandwidth requirements between the various NoC fabrics.
> -
> -properties:
> -  reg:
> -    maxItems: 1
> -
> -  compatible:
> -    enum:
> -      - qcom,qcs404-bimc
> -      - qcom,qcs404-pcnoc
> -      - qcom,qcs404-snoc
> -
> -  '#interconnect-cells':
> -    const: 1
> -
> -  clock-names:
> -    items:
> -      - const: bus
> -      - const: bus_a
> -
> -  clocks:
> -    items:
> -      - description: Bus Clock
> -      - description: Bus A Clock
> -
> -required:
> -  - compatible
> -  - reg
> -  - '#interconnect-cells'
> -  - clock-names
> -  - clocks
> -
> -additionalProperties: false
> -
> -examples:
> -  - |
> -      #include <dt-bindings/clock/qcom,rpmcc.h>
> -
> -      bimc: interconnect@400000 {
> -              reg = <0x00400000 0x80000>;
> -              compatible = "qcom,qcs404-bimc";
> -              #interconnect-cells = <1>;
> -              clock-names = "bus", "bus_a";
> -              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> -                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
> -      };
> -
> -      pnoc: interconnect@500000 {
> -             reg = <0x00500000 0x15080>;
> -             compatible = "qcom,qcs404-pcnoc";
> -             #interconnect-cells = <1>;
> -             clock-names = "bus", "bus_a";
> -             clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> -                      <&rpmcc RPM_SMD_PNOC_A_CLK>;
> -      };
> -
> -      snoc: interconnect@580000 {
> -            reg = <0x00580000 0x23080>;
> -            compatible = "qcom,qcs404-snoc";
> -            #interconnect-cells = <1>;
> -            clock-names = "bus", "bus_a";
> -            clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> -                     <&rpmcc RPM_SMD_SNOC_A_CLK>;
> -      };
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> similarity index 76%
> rename from Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
> rename to Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> index e1009ae4e8f7..e9f856357822 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> @@ -1,28 +1,32 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/interconnect/qcom,msm8916.yaml#
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpm.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm MSM8916 Network-On-Chip interconnect
> +title: Qualcomm RPM Network-On-Chip Interconnect
>  
>  maintainers:
>    - Georgi Djakov <georgi.djakov@linaro.org>
>  
>  description: |
> -  The Qualcomm MSM8916 interconnect providers support adjusting the
> -  bandwidth requirements between the various NoC fabrics.
> +   RPM interconnect providers support system bandwidth requirements through
> +   RPM processor. The provider is able to communicate with the RPM through
> +   the RPM shared memory device.

And here the indentation is wrong too.

>  
>  properties:
> -  compatible:
> -    enum:
> -      - qcom,msm8916-bimc
> -      - qcom,msm8916-pcnoc
> -      - qcom,msm8916-snoc
> -
>    reg:
>      maxItems: 1
>  
> +  compatible:
> +        enum:
> +          - qcom,msm8916-bimc
> +          - qcom,msm8916-pcnoc
> +          - qcom,msm8916-snoc
> +          - qcom,qcs404-bimc
> +          - qcom,qcs404-pcnoc
> +          - qcom,qcs404-snoc
> +
>    '#interconnect-cells':
>      const: 1
>  
> -- 
> 2.17.1
> 
