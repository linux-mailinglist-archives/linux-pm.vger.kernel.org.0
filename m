Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63B821FED9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGNUrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 16:47:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34650 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgGNUrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 16:47:46 -0400
Received: by mail-io1-f68.google.com with SMTP id q74so18824404iod.1;
        Tue, 14 Jul 2020 13:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KG4OgRdU2mgzhB9c1XHH0PH62T4x9g/GNwBwywUmXPk=;
        b=EfsXmsgYq2DI/OjuPdrFy6SgKe3M4OrdiX4/Xnt9PL4EKvr/bfHtoXp+oybm051TLR
         VOChWFhIUXK1i7HXOEgZ+cuuzEqxhRJoQc05pk689/YjlEqP1hqm7Erj8SiYGj5+sKaz
         /SP9NMglsVTefBUi6/MhJ7bMB/5YnjHoH64yJl+uVfhdtfXd2NmIramU7cN7lOJKWj7/
         MpHWrcqNFRof3ppqmfg+vMEinA0bXZP5CJR7YMz+go5kGg83333tI6d+RPZGxi1hVVF4
         xAy631DW9DoSSJJvhDtAnpLLvfqOy+jfVv1mUOpFLePq9IWnE2zgPSOL7uSX5AWVHERg
         RPAQ==
X-Gm-Message-State: AOAM533ufI0RmJygyoHQEllGzdIC+B3rajcIUyjYX6kcGxBkueNHNEc3
        xoRrdE4wiXmdKSHXGPEERg==
X-Google-Smtp-Source: ABdhPJwBvSm4L20FyQCifD/KPEdkGKZCsERW6o55KIcz2jTL8cDAUwFn53ULauO3Ul3/93YJXFV7aw==
X-Received: by 2002:a5d:9c44:: with SMTP id 4mr6874108iof.15.1594759664552;
        Tue, 14 Jul 2020 13:47:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j19sm28502ile.36.2020.07.14.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:47:43 -0700 (PDT)
Received: (nullmailer pid 2891643 invoked by uid 1000);
        Tue, 14 Jul 2020 20:47:42 -0000
Date:   Tue, 14 Jul 2020 14:47:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        mirq-linux@rere.qmqm.pl, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 1/4] dt-bindings: arm: Add NVIDIA
 Tegra194 CPU Complex binding
Message-ID: <20200714204742.GA2875540@bogus>
References: <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
 <1594742870-19957-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594742870-19957-1-git-send-email-sumitg@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 09:37:50PM +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent Tegra194
> CPU Complex with compatible string under 'cpus' node. This
> can be used by drivers like cpufreq which don't have their
> node or CPU Complex node to bind to. Also, documenting
> 'nvidia,bpmp' property which points to BPMP device.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../bindings/arm/nvidia,tegra194-ccplex.yaml       | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
> new file mode 100644
> index 0000000..06dbdaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please.

> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/nvidia,tegra194-ccplex.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra194 CPU Complex device tree bindings
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +  - Sumit Gupta <sumitg@nvidia.com>
> +
> +description: |+
> +  Tegra194 SOC has homogeneous architecture where each cluster has two
> +  symmetric cores. Compatible string in "cpus" node represents the CPU
> +  Complex having all clusters.
> +
> +properties:

$nodename:
  const: cpus

> +  compatible:
> +    enum:
> +      - nvidia,tegra194-ccplex
> +
> +  nvidia,bpmp:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Specifies the bpmp node that needs to be queried to get
> +      operating point data for all CPUs.
> +
> +      Optional for systems that have a "compatible"
> +      property value of "nvidia,tegra194-ccplex".

The schema says this already.

> +
> +  "#address-cells":
> +    const: 1

This is wrong. The binding says it's 2 cells on aarch64 cpus though we 
don't enforce that.

> +
> +  "#size-cells":
> +    const: 0
> +
> +dependencies:
> +  nvidia,bpmp: [compatible]

This is kind of redundant as 'compatible' is required in order to apply 
the schema.

> +
> +examples:
> +  - |
> +    cpus {
> +      compatible = "nvidia,tegra194-ccplex";
> +      nvidia,bpmp = <&bpmp>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cpu0_0: cpu@0 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x0>;
> +        enable-method = "psci";
> +      };
> +
> +      cpu0_1: cpu@1 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x001>;
> +        enable-method = "psci";
> +      };
> +
> +      cpu1_0: cpu@100 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x100>;
> +        enable-method = "psci";
> +      };
> +
> +      cpu1_1: cpu@101 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x101>;
> +        enable-method = "psci";
> +      };
> +
> +      cpu2_0: cpu@200 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x200>;
> +        enable-method = "psci";
> +      };
> +
> +      cpu2_1: cpu@201 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x201>;
> +        enable-method = "psci";
> +      };
> +
> +      cpu3_0: cpu@300 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x300>;
> +        enable-method = "psci";
> +      };
> +
> +      cpu3_1: cpu@301 {
> +        compatible = "nvidia,tegra194-carmel";
> +        device_type = "cpu";
> +        reg = <0x301>;
> +        enable-method = "psci";
> +       };

Not really that useful describing all these cpus.

> +    };
> +...
> -- 
> 2.7.4
> 
