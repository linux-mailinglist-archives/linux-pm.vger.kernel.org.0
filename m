Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7A534F45
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiEZMep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 08:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbiEZMen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 08:34:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BB9FCE
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 05:34:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so2772728ejk.5
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kbA/XPfgYe97A871O4yCZGDbLdPICAAC1mz9m3oyjmA=;
        b=AMO1JahtE/L14l9S/DcwHOnZKcrgeHAFI0Djsqo/AOYuaFXBsKpGid7DtC4JVXDXdU
         VJowDrEf6t3TjkmkywcYo/5XeJ4XTsPcnJS668xTSWvXmsBnVzTrx7PTdiZ/OS+2CMzz
         kibCzUxp01EzArbJNCQRtB1UUaZ1S7wSc6McgeKEjimgjMPzJyv7JVCkx/KVCWce0XhH
         EAwKjG4l3qSm6hecM03SDvuD64rTLvl31nIEO4E0g3By19fTWBaOJAXq6Gq551cNqayr
         JFz8WnZiO+3C1pUxmlSZ+hk/H3WzyYua/oVKDdqGloR8A3QSRogH9NEMEDWF7Gz4PMcs
         BcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kbA/XPfgYe97A871O4yCZGDbLdPICAAC1mz9m3oyjmA=;
        b=hH3MIBOK3Tn2ua1y9oo2AvAOYcRGchj/eJcF3cu8cSC6GCVGvvIo378OMoUqMctHTu
         4gGN9xL8SDi+fa1M6RJxASuOnwg8e383guRG7f+9yMUIreMdL558c+yh6F3P5xL82OoU
         Xe5qGj9o3VNoARqb5mZrfPfHux3JUSBQdhudDvkw5Y+Xp+n/Bmx1QraGrsCwtFHzsaZ6
         cGrv9A1MHGVMj6DCL5R4HMArRbop9tBMV2V8DtBuwqf8rK33V2w/rBvseMGHKM5XREQ4
         hQ6ixNWMKARyt6r4fYUS5PayuMtbGOL+Ya7ERdmTMweSWK5L9/FGzI3CokMlKyAtlzPz
         jhCg==
X-Gm-Message-State: AOAM5338feY7LdBYDvSm7EoFkvUtv1iZcZKTY3rSNNQCRWqOxl1LO4QX
        uhxkvL5ugjiEgL2Sn2WCQzVLMg==
X-Google-Smtp-Source: ABdhPJyWg4C2hxWT1lae+nfHCv1cvifH3vY5gxg9JLDqJCByZcz/y0GpLcnXMkmIX3sTzLADzp+qHA==
X-Received: by 2002:a17:907:8a19:b0:6fe:e146:d107 with SMTP id sc25-20020a1709078a1900b006fee146d107mr18328016ejc.763.1653568479848;
        Thu, 26 May 2022 05:34:39 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ia15-20020a170907a06f00b006fee2c743b6sm474096ejc.159.2022.05.26.05.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:34:39 -0700 (PDT)
Message-ID: <219392a2-a873-a1da-b8b4-b3cc83013cf4@linaro.org>
Date:   Thu, 26 May 2022 14:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/5] dt-bindings: interconnect: qcom: Split out
 rpmh-common bindings
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
 <20220525144404.200390-3-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525144404.200390-3-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/05/2022 16:43, Luca Weiss wrote:
> In preparation for the platforms, split out common definitions used in
> rpmh-based interconnects.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes since v2:
> * Reorganize patches so order is more logical
> * Replace bouncing maintainer email with Bjorn
> * maxItems: 2 for qcom,bcm-voters and qcom,bcm-voter-names
> * Remove | from some descriptions
> 
>  .../interconnect/qcom,rpmh-common.yaml        | 43 +++++++++++++++++++
>  .../bindings/interconnect/qcom,rpmh.yaml      | 22 +++-------
>  2 files changed, 48 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
> new file mode 100644
> index 000000000000..e962e8dc9a61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Georgi Djakov <georgi.djakov@linaro.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
> +  associated with each execution environment. Provider nodes must point to at
> +  least one RPMh device child node pertaining to their RSC and each provider
> +  can map to multiple RPMh resources.
> +
> +properties:
> +  '#interconnect-cells':
> +    enum: [ 1, 2 ]
> +
> +  qcom,bcm-voters:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 1
> +    maxItems: 2
> +    description:
> +      List of phandles to qcom,bcm-voter nodes that are required by
> +      this interconnect to send RPMh commands.
> +
> +  qcom,bcm-voter-names:
> +    description:
> +      Names for each of the qcom,bcm-voters specified.
> +    maxItems: 2

Property above has maxItems before description, so let's make it
consistent (also above).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
