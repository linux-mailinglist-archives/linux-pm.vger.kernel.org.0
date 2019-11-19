Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088F31027D6
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfKSPQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 10:16:30 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43030 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfKSPQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 10:16:30 -0500
Received: by mail-vk1-f196.google.com with SMTP id k19so5130376vke.10
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2019 07:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5L2A8QO6Lknhw02yoV5/M3MO1trwIEwEqsWv1aYEh90=;
        b=H8M8a84P2al3EOggvXui0Musem1r5oC9q7bgEi+ILCQ2gZx8gVwugbWW+ymWUNoxEU
         zcGL50yVB9UHPE8gZgcWf05jpMP1snUW2yi0a9zTRJBYvlPLo4C7wGfkvLk8qI6M6iER
         yHEeO7u1q5cY5ood5p2proqV45Wfo+GMx9Eglk1F15C9dKVmHKBEdxxYRwS4qoeziF6E
         Kr0tjZifHYyKf7FNb1xKQBXiasYhmacmj84uRY68JWcWHwpMKUdrxhZ99AXNsKDsQYrP
         4S/DCH/UnuhL9zYO6iiYNnmZAwBghM+2Zoi2CV1LTVmc7mD92VQa4J+018MYFyHy3Pad
         C+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5L2A8QO6Lknhw02yoV5/M3MO1trwIEwEqsWv1aYEh90=;
        b=APpaUFBeKwTA6xjW3IOnX4AENMCpuWcQAb6f8t2T/ZRxmeGOXkFFFsIo9+5m0x1d9t
         YcwYMJAgrtR7SaKput7cqo/7GVykFm3qWA/ySMmv54DqJ2GqeWZs76SeUtUh8gkRJMUs
         qC4Sfin8VysZ68GXt+YqeNPf4RYbF8NBD+Wh4JhYTWt91C/FUfiIPkGWmW3EtGWNy3aj
         sc46FYydK+agMkf7MTwy7OkMIOSV+LNZ7odG5sgu4/sIYxF4pb30NY6gBw5KWGHji9S0
         uHynyqkeKixymf6xMP7M2R909SwW0yNFQBlugg9Jo7Vl9TjE1cI0U4TZj2yCCCB51cXY
         ifww==
X-Gm-Message-State: APjAAAX/QFY8kEt2ljSWBAeIXIzI7XoQ9O68lUAUYwQWXmNYe7lf8aUm
        2gmhpS3STPNvVsbtopqHjWBBBOaX+f/qt9UhrOTwvA==
X-Google-Smtp-Source: APXvYqxuKUxvO/3z2gC0NLyjswtAsKo05ZVpznPLq86jWCuNXwTk4k201eeS30Me8LoUIKhKDpTZWEv4yzTBZwVt90E=
X-Received: by 2002:a1f:7381:: with SMTP id o123mr20880364vkc.53.1574176588225;
 Tue, 19 Nov 2019 07:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org> <20191029164438.17012-3-ulf.hansson@linaro.org>
In-Reply-To: <20191029164438.17012-3-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Nov 2019 16:15:52 +0100
Message-ID: <CAPDyKFpg+T=FiA03O=OFq2G33AcKG6198MUGP1BxJ0t4E5dGtA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] dt: psci: Update DT bindings to support
 hierarchical PSCI states
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Tue, 29 Oct 2019 at 17:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Update PSCI DT bindings to allow to represent idle states for CPUs and the
> CPU topology, by using a hierarchical layout. Primarily this is done by
> re-using the existing DT bindings for PM domains [1] and for PM domain idle
> states [2].
>
> Let's also add an example into the document for the PSCI DT bindings, to
> clearly show the new hierarchical based layout. The currently supported
> flattened layout, is already described in the ARM idle states bindings [3],
> so let's leave that as is.
>
> [1] Documentation/devicetree/bindings/power/power_domain.txt
> [2] Documentation/devicetree/bindings/power/domain-idle-state.txt
> [3] Documentation/devicetree/bindings/arm/idle-states.txt
>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Clarifications and also added updates cpus.yaml, to descrive that CPUs
>         may be attached to PM domains.
>
> ---
>  .../devicetree/bindings/arm/cpus.yaml         |  15 +++
>  .../devicetree/bindings/arm/psci.yaml         | 102 ++++++++++++++++++
>  2 files changed, 117 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index cb30895e3b67..92a775d6fc0e 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -241,6 +241,21 @@ properties:
>
>        where voltage is in V, frequency is in MHz.
>
> +  power-domains:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description:
> +      List of phandles and PM domain specifiers, as defined by bindings of the
> +      PM domain provider (see also ../power_domain.txt).
> +
> +  power-domain-names:
> +    $ref: '/schemas/types.yaml#/definitions/string-array'
> +    description:
> +      A list of power domain name strings sorted in the same order as the
> +      power-domains property.
> +
> +      For PSCI based platforms, the name corresponding to the index of the PSCI
> +      PM domain provider, must be "psci".
> +
>    qcom,saw:
>      $ref: '/schemas/types.yaml#/definitions/phandle'
>      description: |
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 7abdf58b335e..9fed255cc92d 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -102,6 +102,34 @@ properties:
>        [1] Kernel documentation - ARM idle states bindings
>          Documentation/devicetree/bindings/arm/idle-states.txt
>
> +  "#power-domain-cells":
> +    description:
> +      The number of cells in a PM domain specifier as per binding in [3].
> +      Must be 0 as to represent a single PM domain.
> +
> +      ARM systems can have multiple cores, sometimes in an hierarchical
> +      arrangement. This often, but not always, maps directly to the processor
> +      power topology of the system. Individual nodes in a topology have their
> +      own specific power states and can be better represented hierarchically.
> +
> +      For these cases, the definitions of the idle states for the CPUs and the
> +      CPU topology, must conform to the binding in [3]. The idle states
> +      themselves must conform to the binding in [4] and must specify the
> +      arm,psci-suspend-param property.
> +
> +      It should also be noted that, in PSCI firmware v1.0 the OS-Initiated
> +      (OSI) CPU suspend mode is introduced. Using a hierarchical representation
> +      helps to implement support for OSI mode and OS implementations may choose
> +      to mandate it.
> +
> +      [3] Documentation/devicetree/bindings/power/power_domain.txt
> +      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
> +
> +  power-domains:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description:
> +      List of phandles and PM domain specifiers, as defined by bindings of the
> +      PM domain provider.
>
>  required:
>    - compatible
> @@ -160,4 +188,78 @@ examples:
>        cpu_on = <0x95c10002>;
>        cpu_off = <0x95c10001>;
>      };
> +
> +  - |+
> +
> +    // Case 4: CPUs and CPU idle states described using the hierarchical model.
> +
> +    cpus {
> +

I noticed that I got a compiler warning from "make dt_binding_check".
I have fixed that by adding the below for the next version.

#size-cells = <0>;
#address-cells = <1>;

Other than that, are you okay with these bindings?

Note that, these bindings have been discussed and acked by you
earlier. Although since your acked back then, they have been converted
to the yaml format, hence why I wanted to double check that I managed
to get this right.

> +      CPU0: cpu@0 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a53", "arm,armv8";
> +        reg = <0x0>;
> +        enable-method = "psci";
> +        power-domains = <&CPU_PD0>;
> +        power-domain-names = "psci";
> +      };
> +
> +      CPU1: cpu@1 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57", "arm,armv8";
> +        reg = <0x100>;
> +        enable-method = "psci";
> +        power-domains = <&CPU_PD1>;
> +        power-domain-names = "psci";
> +      };
> +
> +      idle-states {
> +
> +        CPU_PWRDN: cpu-power-down {
> +          compatible = "arm,idle-state";
> +          arm,psci-suspend-param = <0x0000001>;
> +          entry-latency-us = <10>;
> +          exit-latency-us = <10>;
> +          min-residency-us = <100>;
> +        };
> +
> +        CLUSTER_RET: cluster-retention {
> +          compatible = "domain-idle-state";
> +          arm,psci-suspend-param = <0x1000011>;
> +          entry-latency-us = <500>;
> +          exit-latency-us = <500>;
> +          min-residency-us = <2000>;
> +        };
> +
> +        CLUSTER_PWRDN: cluster-power-down {
> +          compatible = "domain-idle-state";
> +          arm,psci-suspend-param = <0x1000031>;
> +          entry-latency-us = <2000>;
> +          exit-latency-us = <2000>;
> +          min-residency-us = <6000>;
> +        };
> +      };
> +    };
> +
> +    psci {
> +      compatible = "arm,psci-1.0";
> +      method = "smc";
> +
> +      CPU_PD0: cpu-pd0 {
> +        #power-domain-cells = <0>;
> +        domain-idle-states = <&CPU_PWRDN>;
> +        power-domains = <&CLUSTER_PD>;
> +      };
> +
> +      CPU_PD1: cpu-pd1 {
> +        #power-domain-cells = <0>;
> +        domain-idle-states =  <&CPU_PWRDN>;
> +        power-domains = <&CLUSTER_PD>;
> +      };
> +
> +      CLUSTER_PD: cluster-pd {
> +        #power-domain-cells = <0>;
> +        domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
> +      };
> +    };
>  ...
> --
> 2.17.1
>

Kind regards
Uffe
