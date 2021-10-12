Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE042A05B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhJLIxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 04:53:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40834
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234998AbhJLIxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 04:53:15 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0226840015
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634028672;
        bh=T8ZOZOr5Y4GlENUxX/f29gdurL3ZGpNumPUv/2Px4/g=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=gnXXXVijaqXvQJFih4dE1eDBYUrOGdDVaa4Hg1XcddHYLDIiD6awSrwCsCgj+I3xF
         kQJLGVnT83ACgcAdL5PAX7pcrM2X1NkagqS7yZaKww0pjDjqtMUEaf8kRBoDsoGti0
         g42StT0QFz7lqq0gTqW7QhYiDc6cG2nqvpJCqGOk47p1db7+bIgwsy4q+/BkJ1muR8
         05R9gzdO7ylhTVwpUf9DIC5XqAifnNjAAX8T+wq88nC/sBm06nqDjfOmsIRlmFORR4
         hWSx5L6TofaXbJ+bEHqRHgbx7edgRnieIphhwljcVAxzK6+WIJg47RKUXOhelPdnzz
         o5Ays3xqvdd+g==
Received: by mail-lf1-f69.google.com with SMTP id v2-20020ac25582000000b003fd1c161a31so14541722lfg.15
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 01:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8ZOZOr5Y4GlENUxX/f29gdurL3ZGpNumPUv/2Px4/g=;
        b=T/10ZHcYz8WzKoej5C18eKxuLD55XtXBKPitfI9BBYqWBf0BlQrjjGbwMNkm3LQ/hh
         honI2LxLen3nEIcgWA4x2NNxC4L7OGsgbVVfBNzBOetONXtK/6PELcjC7VAgj0Tkl4n+
         XETUmiDNjl7e4/jiN9kHNPhKSVosEP02D69AImwTcyRGjdI7qUmobVAXtLGUQf5HMpi2
         RVf2FKCM4+qsLgUPAeGCK+uDCfJl+B7q9E0H3IkXB9FPWeHik3Et3p9nwEONpeohUTKe
         mJPNJcQWqlBnwnDTAVe2CpQYAiqz0L+orLUIYLVdohXhj0G+Rqvs+iQ4uaS8jF4q7q1n
         iAIw==
X-Gm-Message-State: AOAM531x7D+Ul9VtgvmKdETfx0JDh4QRw3WZfX12vYxt1Wv4c5TkqmSn
        BUG/qD5y4YkJu8poK78PyPOcqjsYY7AVnuVvncp8EfLVA7WOvS9hyHVOZGPrVmLf8PVEWUh2Njv
        gYzszLjAC0HFiJKHdMbtmtw4Sj0Jke5gtSMHh
X-Received: by 2002:ac2:51cd:: with SMTP id u13mr3993650lfm.200.1634028671233;
        Tue, 12 Oct 2021 01:51:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztoea6HkNHM9Wjs5q7o+UVJ+H5Botof8Mx0a9li4apYYpZeNNCRerrFp6ZBW53kj/fYfSWfg==
X-Received: by 2002:ac2:51cd:: with SMTP id u13mr3993612lfm.200.1634028670990;
        Tue, 12 Oct 2021 01:51:10 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c3sm344820lfr.187.2021.10.12.01.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 01:51:10 -0700 (PDT)
Subject: Re: [RFC PATCH 3/9] dt-bindings: clock: Add apple,cluster-clk binding
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
 <20211011165707.138157-4-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0fe602f6-3adc-dfac-beee-2854b01cec5c@canonical.com>
Date:   Tue, 12 Oct 2021 10:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011165707.138157-4-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/10/2021 18:57, Hector Martin wrote:
> This device represents the CPU performance state switching mechanism as
> a clock controller, to be used with the standard cpufreq-dt
> infrastructure.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/clock/apple,cluster-clk.yaml     | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml b/Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml
> new file mode 100644
> index 000000000000..9a8b863dadc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/apple,cluster-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CPU cluster frequency scaling for Apple SoCs
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs control CPU cluster frequencies by using a performance state
> +  index. This node represents the feature as a clock controller, and uses
> +  a reference to the CPU OPP table to translate clock frequencies into
> +  performance states. This allows the CPUs to use the standard cpufreq-dt
> +  mechanism for frequency scaling.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-cluster-clk
> +      - const: apple,cluster-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  operating-points-v2:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A reference to the OPP table used for the CPU cluster controlled by this
> +      device instance. The table should contain an `opp-level` property for
> +      every OPP, which represents the p-state index used by the hardware to
> +      represent this performance level.
> +
> +      OPPs may also have a `required-opps` property (see power-domains).
> +
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      An optional reference to a power domain provider that links its
> +      performance state to the CPU cluster performance state. This is typically
> +      a memory controller. If set, the `required-opps` property in the CPU
> +      frequency OPP nodes will be used to change the performance state of this
> +      provider state in tandem with CPU frequency changes.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - operating-points-v2
> +
> +additionalProperties: false
> +
> +

One line break.

> +examples:
> +  - |
> +    pcluster_opp: opp-table-1 {
> +        compatible = "operating-points-v2";
> +        opp-shared;
> +
> +        opp01 {
> +            opp-hz = /bits/ 64 <600000000>;
> +            opp-microvolt = <781000>;
> +            opp-level = <1>;
> +            clock-latency-ns = <8000>;
> +            required-opps = <&mcc_lowperf>;
> +        };
> +        /* intermediate p-states omitted */
> +        opp15 {
> +            opp-hz = /bits/ 64 <3204000000>;
> +            opp-microvolt = <1081000>;
> +            opp-level = <15>;
> +            clock-latency-ns = <56000>;
> +            required-opps = <&mcc_highperf>;
> +        };
> +    };
> +
> +    mcc_opp: opp-table-2 {
> +        compatible = "operating-points-v2";

Wrong compatible.

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
> +
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
> +
> +        clk_pcluster: clock-controller@211e20000 {
> +            compatible = "apple,t8103-cluster-clk", "apple,cluster-clk";
> +            #clock-cells = <0>;
> +            reg = <0x2 0x11e20000 0x0 0x4000>;
> +            operating-points-v2 = <&pcluster_opp>;
> +            power-domains = <&mcc>;
> +        };
> +    };
> 


Best regards,
Krzysztof
