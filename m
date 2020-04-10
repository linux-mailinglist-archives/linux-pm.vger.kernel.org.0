Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DD1A4920
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgDJRhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:37:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43418 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJRhZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:37:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id n25so2482814otr.10;
        Fri, 10 Apr 2020 10:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IKIGQg5IB7jY2yhSBUU/mNdMXcGYQV34ZHgFgy9p1/U=;
        b=KHf1ca+3FzkmgIxALeGoKUoTd7GfoVT0Bg2tR3D4+gy+e01LWJeN9P+SeRROqk3hCi
         CWZZzS7xObUaqgBa2KyJ+e2sT+EBmvOP1DjgtJ5NXQ2NZG8CGCRhbwSKO+6ngU1YWvL+
         N9vL/HI/Qdc7bcnZXI+5Zx4hoJE2dS0RP3k7j11Yu+EeWdQ/4XP/GQxZIbDzR4O6TAec
         bLf4snN5hWESgb2dMezOUs9R5FpoIJNOXXaK4x45w8D9GnP8q7xotWVKyVc4G6MsjPwL
         U0LZvjwGd5RuIAXs/wHISffzTMNKfAH5Ho6otTiTvf1IUwAUYvaH3sC3bbGocz9IlR0y
         7v2A==
X-Gm-Message-State: AGi0PubA68C5S2zvZ2PSnhaMdXVNBLxumUB3o5fZKVsmWO5LSQNdUa32
        kJ2dRv+xs0vBshz84DAyfg==
X-Google-Smtp-Source: APiQypKH2qK7SEAVFycM8zXG3BjPfuwwwLP6dGhClR2Rd11CShp1SRXfJrGuF2ugxsp1IBglCNzGSA==
X-Received: by 2002:a9d:2002:: with SMTP id n2mr5277908ota.127.1586540244705;
        Fri, 10 Apr 2020 10:37:24 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id 202sm1552502oie.38.2020.04.10.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:24 -0700 (PDT)
Received: (nullmailer pid 22356 invoked by uid 1000);
        Fri, 10 Apr 2020 16:59:15 -0000
Date:   Fri, 10 Apr 2020 11:59:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add the idle cooling device
Message-ID: <20200410165915.GA12708@bogus>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
 <20200329220324.8785-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329220324.8785-2-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 12:03:18AM +0200, Daniel Lezcano wrote:
> Some devices are not able to cool down by reducing their voltage /
> frequency because it could be not available or the system does not
> allow voltage scaling. In this configuration, it is not possible to
> use this strategy and the idle injection cooling device can be used
> instead.
> 
> One idle cooling device is now present for the CPU as implemented by
> the combination of the idle injection framework belonging to the power
> capping framework and the thermal cooling device. The missing part is
> the DT binding providing a way to describe how the cooling device will
> work on the system.
> 
> A first iteration was done by making the cooling device to point to
> the idle state. Unfortunately it does not make sense because it would
> need to duplicate the idle state description for each CPU in order to
> have a different phandle and make the thermal internal framework
> happy.
> 
> It was proposed to add an cooling-cells to <3>, unfortunately the
> thermal framework is expecting a value of <2> as stated by the
> documentation and it is not possible from the cooling device generic
> code to loop this third value to the back end cooling device.
> 
> Another proposal was to add a child 'thermal-idle' node as the SCMI
> does. This approach allows to have a self-contained configuration for
> the idle cooling device without colliding with the cpufreq cooling
> device which is based on the CPU node. In addition, it allows to have
> the cpufreq cooling device and the idle cooling device to co-exist
> together as showed in the example.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/thermal/thermal-idle.yaml        | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> new file mode 100644
> index 000000000000..f9f59cfa3c36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0)

Dual license please.

> +# Copyright 2020 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/thermal-idle.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal idle cooling device binding
> +
> +maintainers:
> +  - Daniel Lezcano <daniel.lezcano@linaro.org>
> +
> +description: |
> +  The thermal idle cooling device allows the system to passively
> +  mitigate the temperature on the device by injecting idle cycles,
> +  forcing it to cool down.
> +
> +  This binding describes the thermal idle node.
> +
> +properties:
> +   $nodename:
> +     const: thermal-idle
> +     description: |
> +        A /thermal-idle node describes the idle cooling device properties to

/thermal-idle would be at the root node.

> +        cool down efficiently the attached thermal zone.
> +
> +   '#cooling-cells':
> +      const: 2
> +      description: |
> +         Must be 2, in order to specify minimum and maximum cooling state used in
> +         the cooling-maps reference. The first cell is the minimum cooling state
> +         and the second cell is the maximum cooling state requested.
> +
> +   duration:
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +      description: |
> +         The idle duration in microsecond the device begins to cool down.
> +
> +   latency:
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +      description: |
> +         The exit latency constraint in microsecond for the injected
> +         idle state for the device.

Both of these should have unit suffix. And then they don't need a type 
def.

> +
> +required:
> +  - '#cooling-cells'
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/thermal.h>
> +
> +    // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
> +    cpus {
> +            #address-cells = <2>;
> +            #size-cells = <0>;
> +
> +            /* ... */
> +
> +                 cpu_b0: cpu@100 {
> +                         device_type = "cpu";
> +                         compatible = "arm,cortex-a72";
> +                         reg = <0x0 0x100>;
> +                         enable-method = "psci";
> +                         capacity-dmips-mhz = <1024>;
> +                         dynamic-power-coefficient = <436>;
> +                         #cooling-cells = <2>; /* min followed by max */
> +                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                         idle-thermal {

thermal-idle...

> +                                 #cooling-cells = <2>;
> +                                 duration = <10000>;
> +                                 latency = <500>;
> +                         };
> +                };
> +
> +                cpu_b1: cpu@101 {
> +                        device_type = "cpu";
> +                        compatible = "arm,cortex-a72";
> +                        reg = <0x0 0x101>;
> +                        enable-method = "psci";
> +                        capacity-dmips-mhz = <1024>;
> +                        dynamic-power-coefficient = <436>;
> +                        #cooling-cells = <2>; /* min followed by max */
> +                        cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                        idle-thermal {
> +                                #cooling-cells = <2>;
> +                                duration = <10000>;
> +                                latency = <500>;
> +                        };
> +                 };
> +
> +          /* ... */
> +
> +    };
> +
> +    /* ... */
> +
> +    thermal_zones {
> +         cpu_thermal: cpu {
> +                polling-delay-passive = <100>;
> +                polling-delay = <1000>;
> +
> +                /* ... */
> +
> +                trips {
> +                        cpu_alert0: cpu_alert0 {
> +                                    temperature = <65000>;
> +                                    hysteresis = <2000>;
> +                                    type = "passive";
> +                        };
> +
> +                        cpu_alert1: cpu_alert1 {
> +                                    temperature = <70000>;
> +                                    hysteresis = <2000>;
> +                                    type = "passive";
> +                        };
> +
> +                        cpu_alert2: cpu_alert2 {
> +                                    temperature = <75000>;
> +                                    hysteresis = <2000>;
> +                                    type = "passive";
> +                        };
> +
> +                        cpu_crit: cpu_crit {
> +                                    temperature = <95000>;
> +                                    hysteresis = <2000>;
> +                                    type = "critical";
> +                        };
> +                };
> +
> +                cooling-maps {
> +                        map0 {
> +                             trip = <&cpu_alert1>;
> +                             cooling-device = <&{/cpus/cpu@100/idle-thermal} 0 15 >,
> +                                              <&{/cpus/cpu@101/idle-thermal} 0 15>;
> +                        };
> +
> +                        map1 {
> +                             trip = <&cpu_alert2>;
> +                             cooling-device =
> +                                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                       };
> +                };
> +          };
> +    };
> -- 
> 2.17.1
> 
