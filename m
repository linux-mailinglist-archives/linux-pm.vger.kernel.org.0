Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3878B486
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjH1PeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjH1Pdw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 11:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A22E1;
        Mon, 28 Aug 2023 08:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BACA61D9E;
        Mon, 28 Aug 2023 15:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6F9C433C8;
        Mon, 28 Aug 2023 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693236828;
        bh=8fTqi3PUJyverYLoU49ckT4M1bhzFmNgEVyoOpQkhm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLJzaMB2SnvqYflXpLrS0Ma6H1s0+/bj1iGWyWkerXAO0cxRg4tA6ObJAcVuxxyfG
         QUmcNOKatsgJidvNGlN7MPZ3a8ugfY+LfDH4mS5uUPbOF6Bla4ioF9tWWBY0aP54i9
         aGGMqil4Ym/MI/SPELgaQoEVeNQ5v5rIQI4im8/7otN055kUZ7HvoMra4kCDCnRs/c
         I0uObMebj7AUScXWazE59BVV9r/pvKBiGcX5EZhZigdXdMHkactjLHZSOuKY3cnhlX
         2giYa6xEgcDSPreBaYUS+CRXG8cVnXD377QSp01b0t60HIOdSYRKo7EdjfnNUDBH+V
         1XPT6B7Ynq+/A==
Received: (nullmailer pid 595471 invoked by uid 1000);
        Mon, 28 Aug 2023 15:33:45 -0000
Date:   Mon, 28 Aug 2023 10:33:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v4 04/23] dt-bindings: cache: describe L2 cache on
 Qualcomm Krait platforms
Message-ID: <20230828153345.GA585617-robh@kernel.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
 <20230827115033.935089-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827115033.935089-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 27, 2023 at 02:50:14PM +0300, Dmitry Baryshkov wrote:
> The L2 cache device on Qualcomm Krait platforms controls the supplying
> voltages and the cache frequency. Add corresponding bindings for this
> device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/cache/qcom,krait-l2-cache.yaml   | 86 +++++++++++++++++++
>  include/dt-bindings/soc/qcom,krait-l2-cache.h | 12 +++
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
>  create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h
> 
> diff --git a/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
> new file mode 100644
> index 000000000000..59ce11dd0a24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)

'only', not 'or-later'

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Krait L2 Cache
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description:
> +  L2 cache on Qualcomm Krait platforms is shared between all CPU cores. L2
> +  cache frequency and voltages should be scaled according to the needs of the
> +  cores.
> +
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,krait-l2-cache
> +
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,krait-l2-cache
> +      - const: cache
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +  vdd-mem-supply:
> +    description: suppling regulator for the memory cells of the cache
> +
> +  vdd-dig-supply:
> +    description: suppling regulator for the digital logic of the cache
> +
> +  operating-points-v2: true
> +  opp-table:
> +    type: object
> +
> +required:
> +  - compatible
> +  - cache-level
> +  - cache-unified
> +  - clocks
> +  - '#interconnect-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/qcom,krait-l2-cache.h>
> +
> +    l2-cache {
> +        compatible = "qcom,krait-l2-cache", "cache";
> +        cache-level = <2>;
> +        cache-unified;
> +        vdd-mem-supply = <&pm8921_l24>;
> +        vdd-dig-supply = <&pm8921_s3>;
> +        clocks = <&kraitcc 4>;
> +        #interconnect-cells = <1>;
> +        operating-points-v2 = <&l2_opp_table>;
> +
> +        l2_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-384000000 {
> +                opp-hz = /bits/ 64 <384000000>;
> +                opp-microvolt = <1050000 1050000 1150000>,
> +                                <950000 950000 1150000>;
> +            };
> +        };
> +    };
> +...
> +
> diff --git a/include/dt-bindings/soc/qcom,krait-l2-cache.h b/include/dt-bindings/soc/qcom,krait-l2-cache.h
> new file mode 100644
> index 000000000000..c9a38d368111
> --- /dev/null
> +++ b/include/dt-bindings/soc/qcom,krait-l2-cache.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2023 Linaro Ltd. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_SOC_QCOM_KRAIT_L2_CACHE_H
> +#define __DT_BINDINGS_SOC_QCOM_KRAIT_L2_CACHE_H
> +
> +#define MASTER_KRAIT_L2		0
> +#define SLAVE_KRAIT_L2		1
> +
> +#endif
> -- 
> 2.39.2
> 
