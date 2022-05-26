Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B97534F4C
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiEZMgi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 08:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbiEZMgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 08:36:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECACCE0F
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 05:36:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id wh22so2767521ejb.7
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wl4uFPiTLXhXf4v+vyfxdpd3/HqIgIQQpbstfSoefxg=;
        b=pA4RAyWqdryjNuZQYiOcRsfy1kaLLlydsrhVJxwzL6AzsC/RVJORQyWIRFU/vdFV+t
         AMfd/xFG8qpiRoNQl3hVSjI+6O+gXZNRfkmSTsDt8/A56ff1Gwam6XfCMnwEzkY1fVQY
         nPNksRCVpcN37uQiErPjL6rXTW6ea1zmmzVcPR+jSxfLEKFlp9D+PEFcV52b43ycsqeh
         RBCPUrag1hpeH3SXEDIKIkjKbZOa1UrFdFXho6eRAj7Zx4Xjt/EdUkR8Hvf7jlv1nHoV
         0UFwMXA3NTbp1UZK1o/cXr8tJsKL0DWJxefWhNTYAfB2gnl6oqeBt+FLwQdU6/SssgRs
         3GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wl4uFPiTLXhXf4v+vyfxdpd3/HqIgIQQpbstfSoefxg=;
        b=Xy7CVyTzBZv522pbdwPtBCGEkg1P/QYQ9DF+y6FWkNpUfvaQ5QXXVhaFi0lfBszvB3
         f8bZJcGI98kpxa/uUNanso199mHPKJ5ix0px2yR8q9OH949pV6O0mLlDsBS+r6VH7Pba
         lrTD578OoJz2KazzjE4syeCEP2ibRpb9El2qch12Go/+a5jdaEkfRyctW9ii0pao+ChN
         vIbXn5yDgzEfiHtFWNLBdvZrBqHfpCNZqIo8KszlZt20hpMfbVwyi2r9JeYHrp2/6Bht
         nTRZQHPRKMPWz0P+YpeXrs3iywSs6BBy+BpO7/X3NpON1qAM9CNQPF92HDQuxNcP7lRC
         L01Q==
X-Gm-Message-State: AOAM530QcAzoaJFZCQ126kkj64aqQeCnxZPI2hCKUs7phORAz8WRny0r
        p8/qh+9Gs3mfS3ttWFB40HLEUDTysq0gKs/U
X-Google-Smtp-Source: ABdhPJxSrsIaPyiY3MVFSltc/EMSJtv7+z9qdSSHzK+jCc+pJmp0QJ82aeWqObHLhjuMrioWUvFvHA==
X-Received: by 2002:a17:907:7d91:b0:6fe:efb8:8f97 with SMTP id oz17-20020a1709077d9100b006feefb88f97mr17115923ejc.717.1653568594660;
        Thu, 26 May 2022 05:36:34 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p16-20020a170907911000b006febc1ef61csm471643ejq.106.2022.05.26.05.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:36:34 -0700 (PDT)
Message-ID: <2bef3fda-58ba-98c7-e9bf-d2d3a9dec6e3@linaro.org>
Date:   Thu, 26 May 2022 14:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/5] dt-bindings: interconnect: Add Qualcomm SM6350 NoC
 support
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
 <20220525144404.200390-4-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525144404.200390-4-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/05/2022 16:43, Luca Weiss wrote:
> Add bindings for Qualcomm SM6350 Network-On-Chip interconnect devices.
> 
> As SM6350 has two pairs of NoCs sharing the same reg, allow this in the
> binding documentation, as was done for qcm2290.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes since v2:
> * Put requires and unevaluatedProperties further down
> 
>  .../interconnect/qcom,sm6350-rpmh.yaml        |  82 ++++++++++
>  .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++++++++++++++
>  2 files changed, 230 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
> new file mode 100644
> index 000000000000..3e3ea85b4792
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm6350-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6350 RPMh Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +
> +description: |

No need for |.

> +  Qualcomm RPMh-based interconnect provider on SM6350.
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
