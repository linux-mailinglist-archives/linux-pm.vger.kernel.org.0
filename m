Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D77262CAF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIJ54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgIIJ5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 05:57:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE37C061755
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 02:57:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so2266395wrm.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:autocrypt:cc:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCELGkhdQ1DsZuxmC7ng1g5IaQ8ROcXZ1BoKqG2QT5o=;
        b=Mqb05xlE3Z1MdVw8LQallvOUekeyaTgXmWspeBDBVV4UZpGXdMIz3aaPAcE2OOVv2r
         rDnmztSgCP2YNM1mHw26NOgwiSYW4yXrxcCMdoXEMhQnAXYJrf+BQj/JcRbMMm7U7XMA
         gnwVGJmymUJIH6vGyK9XoyqrjPiMPmbSJgIelAVubHo9eBmpiO2h/t4ALZM+0W4dG6+h
         xI9YgBJ1CV1HkVGopOkMQi22iUYGC/rriif71Yf/foHw1nDNn6sSeHmk8EZ4LhW36yi4
         kT5ljKJuhIhU/EkDpInzapSy/7zGg9fHTsiRr/JGiJfAUlqcRKOdqfPcGhHM0soQofms
         SVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:cc
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCELGkhdQ1DsZuxmC7ng1g5IaQ8ROcXZ1BoKqG2QT5o=;
        b=iS7AZp0RA8+oT+teSbwaI81dWDtCvHXWWhqbG3awyJZhuTfGFXKzLSCqcw9k7/tFKD
         HGhrHkaSxxQWPLPqI/np1/gt19A/gSJAuGiIVcpjMxjz1Puu+bdPtBlO0/5mv5D4kIl5
         vzd4Fcx2a/CdybDTi+846LaKTMcgckQ1Ta6WOD8yDWOIErcH6n/pZ+1xcPuBxntvRg+5
         TAFHuDO3WK0yw+jGuD8/KbbVnbKbe7nz1bjDuWzKJWGwo5CjmYuYctFaAiUbavTigNAW
         kxuipUoOp0ovgDdxTiQEiH3fk1DrL+9OSkgeDex2gDM4EXyvuBKjrB0b1CATgfRXgdMd
         xlaQ==
X-Gm-Message-State: AOAM5309CSLypcXIJjq1ReIoz193ED0MPbdnZCbwG+0i6HBAB5Rw6xws
        Z1ere4azQe5qvyKLXtgNMEOov83X2ziqgw==
X-Google-Smtp-Source: ABdhPJzDY1lyV2js9QsVmgKoroM45CxgDQhjtIpyeYhR8JJkrn3jpfymUWAGBKYbd2WDQobbCQp1qA==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr3070172wrn.205.1599645469053;
        Wed, 09 Sep 2020 02:57:49 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z83sm3217648wmb.4.2020.09.09.02.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:57:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm MSM8939 DT
 bindings
To:     Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org
References: <20200831075329.30374-1-jun.nie@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Cc:     linux-pm@vger.kernel.org
Message-ID: <6b94b1ac-19e9-2ce7-8930-e7111cc9dea8@linaro.org>
Date:   Wed, 9 Sep 2020 12:57:47 +0300
MIME-Version: 1.0
In-Reply-To: <20200831075329.30374-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jun,

Thank you for the patch!

On 8/31/20 10:53, Jun Nie wrote:
> The Qualcomm MSM8939 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/interconnect/qcom,msm8939.yaml   |  87 +++++++++++++++
>  .../dt-bindings/interconnect/qcom,msm8939.h   | 105 ++++++++++++++++++
>  2 files changed, 192 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8939.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> new file mode 100644
> index 000000000000..99a827143723
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8939.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8939 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Jun Nie <jun.nie@linaro.org>
> +
> +description: |
> +   The Qualcomm MSM8939 interconnect providers support adjusting the
> +   bandwidth requirements between the various NoC fabrics.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8939-bimc
> +      - qcom,msm8939-pcnoc
> +      - qcom,msm8939-snoc
> +      - qcom,msm8939-snoc-mm
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: bus_a
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Bus A Clock
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
> +examples:
> +  - |
> +      #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +      bimc: interconnect@400000 {
> +              compatible = "qcom,msm8939-bimc";
> +              reg = <0x00400000 0x62000>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +      };
> +
> +      pcnoc: interconnect@500000 {
> +              compatible = "qcom,msm8939-pcnoc";
> +              reg = <0x00500000 0x11000>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
> +                       <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +      };
> +
> +      snoc: interconnect@580000 {
> +              compatible = "qcom,msm8939-snoc";
> +              reg = <0x00580000 0x14000>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +      };
> +
> +      snoc_mm: interconnect@580000 {
> +              compatible = "qcom,msm8939-snoc-mm";
> +              reg = <0x00580000 0x14000>;
> +              #interconnect-cells = <1>;
> +              clock-names = "bus", "bus_a";
> +	      clocks = <&rpmcc RPM_SMD_MMSSNOC_AHB_CLK>,
> +		       <&rpmcc RPM_SMD_MMSSNOC_AHB_A_CLK>;
> +      };

The above looks almost identical to what we already have in qcom,msm8916.yaml.
Recently Jonathan sent a patch to merge all rpmh platforms into a single file,
can we do the same thing here and have a common file for all SMD_RPM platforms?

Also don't forget to CC the devicetree mailing list in order to get the binding
reviewed.

Thanks,
Georgi
