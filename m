Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00788631391
	for <lists+linux-pm@lfdr.de>; Sun, 20 Nov 2022 12:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKTLNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Nov 2022 06:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKTLNK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Nov 2022 06:13:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3813F08
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 03:13:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p8so14951659lfu.11
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 03:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alve7OHoEj+oAIMWnVSIJSVJssYyKDfSkrERnLfRn3c=;
        b=ADlV0sA5wH6pYEVrFxQJp32Ub04pNF9GdIVkruPcdY/FoVnvjqhCGuz8dcRhgFvYTd
         D7G2wHTAJASk4TE3sHuNA26HKx9YkS9DAeVR/LiB6fg3iA/p6trWHuZjBn2V7JqCNuaf
         LzOhXGVhU6eZsR55y6wT//Yy9iv7Q1JPjLOMKalKhlljgCnPRxa8TIxWpYbzsR7L05Xm
         HHxFz9xTmCeJw8/d9n/l7HtUvvi7O0bw9vYD+Guiwn9ZlKdYbsnxTp85+3jN5JDw6eHX
         VpWYhgiKp3zQHFuLVpj7Zm1sU0VSBa7Na9LKgKaZb4LbJj7xn9/0Emopi7LMtimrpAtZ
         YHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alve7OHoEj+oAIMWnVSIJSVJssYyKDfSkrERnLfRn3c=;
        b=qIeUJfjDN77040GkS07dnuV9OYBAcA5JgwvPSZIsW0ZN0Ti95gq2SfjXOJqUFvIIVj
         TejD8qHdS/O/NrQoJD3UGZeSSoSJLlOHWjpUnE+/v0ZHLTyBEjdKBHj2uoCrjg0uqg0/
         uMfwpEJ+3OdQX0lqGn7lYoxWLQgKjrH3s34K1kYVDIXutJ48qxw5NpB00nZZJU0TtRLs
         AypOdUi+n/kQULNiw6NFNwwsjciBrCSSDid39qd9EY/rEwvvOgzRID0nuGKLPs3VNPKf
         CjVa2jrZipuOBdkymkxiKz2rgMHTu3ZOqV9Koimv2j8cKAsxX97bKf8plAwBqx04NRSA
         S/2Q==
X-Gm-Message-State: ANoB5pkpwM2T2trhdv3MzP1lle4ikuEIrSB1gqDhxsU8BvBB5/USMXT0
        LFC/jeaojx/FRyqfEWN/Gzjq5Q==
X-Google-Smtp-Source: AA0mqf5dOp8Lvt6U0ZhaQM6camBPTFlNI5YNFSZRECoY6PEDHeq+qXCKta9lNSc9buiu7nNLJXHtsg==
X-Received: by 2002:a05:6512:25a8:b0:4aa:a6f8:f042 with SMTP id bf40-20020a05651225a800b004aaa6f8f042mr4250057lfb.405.1668942787798;
        Sun, 20 Nov 2022 03:13:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a26-20020ac25e7a000000b004b4930d53b5sm1499616lfr.134.2022.11.20.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:13:07 -0800 (PST)
Message-ID: <536af0d9-aa00-ddf1-753d-670ec2adef91@linaro.org>
Date:   Sun, 20 Nov 2022 12:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182245.31035-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/11/2022 19:22, Melody Olvera wrote:
> Add documentation for virtual rpmh devices. These interconnects
> are not controlled by the application processor and thus
> require separate bindings. Also, move compatibles for sm8450 to
> this document and add them for QDU1000/QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/interconnect/qcom,rpmh-virt.yaml | 55 +++++++++++++++++++
>  .../bindings/interconnect/qcom,rpmh.yaml      |  2 -
>  2 files changed, 55 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
> new file mode 100644
> index 000000000000..5cbaa51df863
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-virt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Virtual Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Georgi Djakov <georgi.djakov@linaro.org>
> +  - Odelu Kukatla <quic_okukatla@quicinc.com>
> +
> +description: |
> +   RPMh interconnect providers support system bandwidth requirements through
> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
> +   associated with each execution environment. Provider nodes must point to at
> +   least one RPMh device child node pertaining to their RSC and each provider
> +   can map to multiple RPMh resources. Virtual interconnect providers are not
> +   controlled by AP and do not support QoS; they should not have associated
> +   register regions.
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qdu1000-clk-virt
> +      - qcom,qdu1000-mc-virt
> +      - qcom,sm8450-clk-virt
> +      - qcom,sm8450-mc-virt

You should also move qcom,sdx65-mc-virt, qcom,sc8280xp-mc-virt,
qcom,sc8280xp-clk-virt and more.

> +
> +  '#interconnect-cells': true
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/interconnect/qcom,sm8450.h>
> +
> +      clk_virt: interconnect-0 {
> +             compatible = "qcom,sm8450-clk-virt";
> +             #interconnect-cells = <2>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      mc_virt: interconnect-1 {
> +             compatible = "qcom,sm8450-mc-virt";
> +             #interconnect-cells = <2>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;

These are exactly the same examples, so just keep one.

Best regards,
Krzysztof

