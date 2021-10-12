Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7088C42A04C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhJLIuT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 04:50:19 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54820
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234870AbhJLIuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 04:50:17 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 476183FFEF
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634028495;
        bh=/bLYqEWiuu93v2dUYStYjMMSSjdwzn3CWIi0Is9xJUs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=oyxGPQzswBCJEnFBHOiXYbhTiU69N8i9+CFfDb0pEsC8jm2NIbFzYl/Orvsalu1Uj
         Q6ManNSz915YEQiZdOE2x8XDCIuvlYhtD7q9VExwmM1wlm2346MN/yrQNU1ZZgrt0I
         80v1CYOeO9tS3AqFNijdwfaK3UR4wfyiStAXvDXVL31XN7CPuUE8gPwMeKDt/bbFd+
         pq1xK7ni2jSdlQbV6imrYOoR5CTQpYI6JMlzAvceCYbbBCQgZ1BFRaaCcaHoeM40M7
         5UpQSjplHY5LL6o7x2lxxFQuqZyw0DXZyELSnYFL+/341QOoPIUd6mxEhk0WGMTiXE
         LspTs9gRm4+lg==
Received: by mail-lf1-f71.google.com with SMTP id f17-20020a0565123b1100b003fda40b659aso321419lfv.23
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 01:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bLYqEWiuu93v2dUYStYjMMSSjdwzn3CWIi0Is9xJUs=;
        b=5qnaLwfS/3gfai3vWCTvd8SjCL+lUOR+pl0m4vLlka6OIw5oi/v4pMDeeT0HgzstZW
         KIMMIvZ9AMJ+TNLl6h8aFkClzAx2ZCALIe8UzJ0ljLS+0thbLpTTZL5BYl+7G8KnhiuS
         NV0DBwn4YSq6L25Y6fReobGzh1b6LbydvWQ3/NXsOITfLQ1FLUKqJSZwdlVTey3dy8FR
         i5yg6EBzHfAG9HpeA/v6QSN0eLwk9A8IKWBqqliqT9vx5xKIQmAWXR4Pj93lNnpOTVez
         ne+u1keHhN7hjjxUaa8BXD/j6jGd1YIj7hEbr46aKUrfADoZ6FT+T6QaDj6uKm7kyJpD
         TAdw==
X-Gm-Message-State: AOAM530TScui/cAXRB/z3sKLwWG7cCb5nmIwYgr3IAK8Xa1z+X1/Keoy
        PFsAF4KfIn8aNT08jIMyQ4WKovkBXQ9Da8DtiqE3REN3EgwxTT1BXTpSohzGqo9UgGFQNlIsRno
        7/eLIGSMEff/HL3TcmkbqRUAdLQTo5TENvN9j
X-Received: by 2002:a2e:bd02:: with SMTP id n2mr29708329ljq.412.1634028494380;
        Tue, 12 Oct 2021 01:48:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/KrA+FVuHKQaPlIEozCQYVijMCeVw0Gj89uGifpd5rxNy42hNDpCiwoLy0Hg/ZwsEICaIzw==
X-Received: by 2002:a2e:bd02:: with SMTP id n2mr29708314ljq.412.1634028494178;
        Tue, 12 Oct 2021 01:48:14 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h23sm651216ljl.35.2021.10.12.01.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 01:48:13 -0700 (PDT)
Subject: Re: [RFC PATCH 2/9] dt-bindings: memory-controller: Add apple,mcc
 binding
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-3-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6999f3f4-338c-f1ba-2360-40fa50ecd45d@canonical.com>
Date:   Tue, 12 Oct 2021 10:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011165707.138157-3-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/10/2021 18:57, Hector Martin wrote:
> This device represents the memory controller in Apple SoCs, and is
> chiefly in charge of adjusting performance characteristics according to
> system demand.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../memory-controllers/apple,mcc.yaml         | 80 +++++++++++++++++++
>  .../opp/apple,mcc-operating-points.yaml       | 62 ++++++++++++++
>  2 files changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml b/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
> new file mode 100644
> index 000000000000..0774f10e65ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/apple,mcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC MCC memory controller performance controls
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs contain a multichannel memory controller that can have its
> +  configuration changed to adjust to changing performance requirements from
> +  the rest of the SoC. This node represents the controller and provides a
> +  power domain provider that downstream devices can use to adjust the memory
> +  controller performance level.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-mcc
> +      - const: apple,mcc
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 0
> +
> +  operating-points-v2:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A reference to the OPP table describing the memory controller performance
> +      levels. Each OPP node should contain an `apple,memory-perf-config`
> +      property that contains the configuration values for that performance
> +      level.
> +
> +  apple,num-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The number of memory channels in use.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +  - operating-points-v2
> +  - apple,num-channels
> +
> +additionalProperties: false
> +
> +examples:
> +  # See clock/apple,cluster-clock.yaml for an example of downstream usage.
> +  - |
> +    mcc_opp: opp-table-2 {
> +        compatible = "operating-points-v2";

apple,mcc-operating-points?

> +
> +        mcc_lowperf: opp0 {
> +            opp-level = <0>;
> +            apple,memory-perf-config = <0x813057f 0x1800180>;
> +        };
> +        mcc_highperf: opp1 {
> +            opp-level = <1>;
> +            apple,memory-perf-config = <0x133 0x55555340>;
> +        };
> +    };
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mcc: memory-controller@200200000 {
> +            compatible = "apple,t8103-mcc", "apple,mcc";
> +            #power-domain-cells = <0>;
> +            reg = <0x2 0x200000 0x0 0x200000>;
> +            operating-points-v2 = <&mcc_opp>;
> +            apple,num-channels = <8>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml b/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
> new file mode 100644
> index 000000000000..babf27841bb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/apple,mcc-operating-points.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC memory controller OPP bindings
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs can have their memory controller performance adjusted depending on
> +  system requirements. These performance states are represented by specific
> +  memory controller register values. The apple-mcc driver uses these values
> +  to change the MCC performance.
> +
> +allOf:
> +  - $ref: opp-v2-base.yaml#
> +
> +properties:
> +  compatible:
> +    const: apple,mcc-operating-points
> +
> +required:
> +  - compatible
> +
> +patternProperties:
> +  "opp[0-9]+":
> +    type: object
> +
> +    properties:
> +      opp-level: true

You don't need to mention it.

> +      apple,memory-perf-config:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: |
> +          A pair of register values used to configure this performance state.
> +        minItems: 2
> +        maxItems: 2
> +
> +    required:
> +      - opp-level
> +      - apple,memory-perf-config
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mcc_opp: opp-table-2 {
> +        compatible = "operating-points-v2";

Different compatible.

> +
> +        mcc_lowperf: opp0 {
> +            opp-level = <0>;
> +            apple,memory-perf-config = <0x813057f 0x1800180>;
> +        };
> +        mcc_highperf: opp1 {
> +            opp-level = <1>;
> +            apple,memory-perf-config = <0x133 0x55555340>;
> +        };
> +    };
> 


Best regards,
Krzysztof
