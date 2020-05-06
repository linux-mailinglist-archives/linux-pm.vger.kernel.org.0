Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4111C6DCB
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgEFJ5i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729278AbgEFJ5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 05:57:37 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F3C061A0F
        for <linux-pm@vger.kernel.org>; Wed,  6 May 2020 02:57:37 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id y10so261930uao.8
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2020 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEL91UsQkus4klguPQa562vRpJ+uIdXm90Hm4ZfBR84=;
        b=O+gyeJTYFhQr/KtUZAfqVIH0WTAfmhlRyJcG9PzPBNo88vGrQJkdDr16BZvo7jyPu6
         Ed7lGKTv6JjIJgAHiuffQ7zdt91Y7/YwK/C8H6PH81YbSDMaT7Zv8rcWBXYJkOALegJF
         rJAY9Uyo59++eoiXdinzNuqzYLgXNLvkVZtWvMPJ2yilZdRuOhJSlemOTUXdzkAEV0Kk
         8fV7a+IT2ZsCs7zOiXWgyXMbAqEBeFCd+Lqp1gZqUnNKNY6v8f4O6sQA1KNL/GVBDIfQ
         Rm1yfvMggC0xl+3HYZ1Wt/wLjsEnN3tLnvF9C9GxeW5yq0n9gU9hG60xnMk7zOyQHHBQ
         89MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEL91UsQkus4klguPQa562vRpJ+uIdXm90Hm4ZfBR84=;
        b=MM5c0aI8IL1KUfF1QWJjDQ/Q16SgsKCCKVc4N5BYh2kNds9zoXy1FkRhP2N85gPuFt
         eMYmCbT0dPz9p6+zPIaXH6JBaFcWDOcIv826bfSMO5Ne0ZNXcXtKfUC/n5t71E2I82no
         /UxZjdeCpRSdq2whpJE5wIp/ZYhVoRVPPRBpSKN4uWOCJfwCUKs6V8kL91rNmDjFfTFx
         bSfX0rQID9gmnbO/tzsS0iAZu3HzWELfXpHnVYCbLUsLmCjyHO0ecsOHJKLrsDjtQY97
         9khk0PI5n12o5vctwbZRJgc28cCpNoiMUytlkIdY7JUhguLU208wVkd/u2VAPJeEP9OQ
         4xWA==
X-Gm-Message-State: AGi0PuamfqHuEW9Zv/GCJZ/5cq04RcErQetNYCT3DQQ8o07SRYIyXlSi
        kNv4V/K6KgmleItCA5x2Bz/M6Fek3U37axWN9Ez7kQ==
X-Google-Smtp-Source: APiQypIB5U2qPB5OSGV7qIRCOai6i1EXBaGaXL0Sbf11IKfGkPyP77p/vRNyWCA4qxTcW0PmeYsPujgapi4K9umVGpQ=
X-Received: by 2002:ab0:20aa:: with SMTP id y10mr5935962ual.60.1588759056227;
 Wed, 06 May 2020 02:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200429103644.5492-1-daniel.lezcano@linaro.org> <20200429103644.5492-2-daniel.lezcano@linaro.org>
In-Reply-To: <20200429103644.5492-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 6 May 2020 15:27:02 +0530
Message-ID: <CAHLCerMYLLU6LDEgvq_t=NOzXa00npsjv5K+Z=24Lvh2XZVxgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: thermal: Add the idle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 4:07 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
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
> together as shown in the example.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  - V4:
>    - Added Rob Herring reviewed-by
>  - V3:
>    - Removed extra line with tab inside
>  - V2:
>    - Fixed comment type
>    - Added dual license
>    - Fixed description s/begins to/should/
>    - Changed name s/duration/duration-us/
>    - Changed name s/latency/exit-latency-us/
>    - Removed types for latency / duration
>    - Fixed s/idle-thermal/thermal-idle/
> ---
>  .../bindings/thermal/thermal-idle.yaml        | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-idle.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> new file mode 100644
> index 000000000000..7a922f540934
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +        A thermal-idle node describes the idle cooling device properties to
> +        cool down efficiently the attached thermal zone.
> +
> +   '#cooling-cells':
> +      const: 2
> +      description: |
> +         Must be 2, in order to specify minimum and maximum cooling state used in
> +         the cooling-maps reference. The first cell is the minimum cooling state
> +         and the second cell is the maximum cooling state requested.
> +
> +   duration-us:
> +      description: |
> +         The idle duration in microsecond the device should cool down.
> +
> +   exit-latency-us:
> +      description: |
> +         The exit latency constraint in microsecond for the injected
> +         idle state for the device. It is the latency constraint to
> +         apply when selecting an idle state from among all the present
> +         ones.
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
> +                         thermal-idle {
> +                                 #cooling-cells = <2>;
> +                                 duration-us = <10000>;
> +                                 exit-latency-us = <500>;
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
> +                        thermal-idle {
> +                                #cooling-cells = <2>;
> +                                duration-us = <10000>;
> +                                exit-latency-us = <500>;
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
> +                             cooling-device = <&{/cpus/cpu@100/thermal-idle} 0 15 >,
> +                                              <&{/cpus/cpu@101/thermal-idle} 0 15>;
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
