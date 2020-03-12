Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225B318391C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 20:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCLTBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 15:01:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46781 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTBj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 15:01:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id 111so7412515oth.13;
        Thu, 12 Mar 2020 12:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=af3K31gbmEa2HSipqb/CVegw26DVeeUMqwIKy4x1Vpc=;
        b=j8Nzoqh46yNFazPSZPOBKkIDviqcSYIufx7a4UEQt6WF7/AZIBhu4nUaANPh02ktT4
         LziQr7V8Y08WJXkhQklC3MvYQvh7zp/hO+LW+c4xtuCrxB6JMb0sLn9mnvWmvqq2j/p2
         y/6oavn+2qr2L935jU0aKFv5wxUqhXIbfzIjTpXmAyIzPjSFkDmVhS1dS9J2nKkjMcXU
         TlwCXBWnlMGrDZccrvuWkMcC0y8h30oHbN069Ed5tiPNMPJS6cXNcBhXCVVG6FPLdLu9
         caUDD1raR0/uKfKGXYwd3RBV18l/mKdrL/kHVbtFYOF5fYMR4ACQg5Q4xS5grdNojELq
         fKaA==
X-Gm-Message-State: ANhLgQ0gP5RqyDFY49cjJoF9OuEMppu2DhSnQsBYGWuod97utvcJRB7i
        CfaJ0DJKpb7+4qsPOYHQvQ==
X-Google-Smtp-Source: ADFU+vv3ZuHu4x1L1sfY2PAUzJV8g1Jh+MrCLTT7IlFPBsGUChTOAm8/09BwXfsWt4P0yLJN/VLj7A==
X-Received: by 2002:a9d:6752:: with SMTP id w18mr7374480otm.123.1584039698352;
        Thu, 12 Mar 2020 12:01:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j132sm4176497oih.1.2020.03.12.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:01:36 -0700 (PDT)
Received: (nullmailer pid 25434 invoked by uid 1000);
        Thu, 12 Mar 2020 19:01:35 -0000
Date:   Thu, 12 Mar 2020 14:01:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: Add yaml bindings for
 thermal cooling-devices
Message-ID: <20200312190135.GA14131@bogus>
References: <cover.1583412540.git.amit.kucheria@linaro.org>
 <9a2052ee2afa43048bd4e2594d015fca6bbf5116.1583412540.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2052ee2afa43048bd4e2594d015fca6bbf5116.1583412540.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 05, 2020 at 06:26:42PM +0530, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The property #cooling-cells is required in each device that acts as a
> cooling device - whether active or passive. So any device that can
> throttle its performance to passively reduce heat dissipation (e.g.
> cpus, gpus) and any device that can actively dissipate heat at different
> levels (e.g. fans) will contain this property.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../thermal/thermal-cooling-devices.yaml      | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> new file mode 100644
> index 0000000000000..4745ea4b41ae7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0)
> +# Copyright 2020 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal cooling device binding
> +
> +maintainers:
> +  - Amit Kucheria <amitk@kernel.org>
> +
> +description: |
> +  Thermal management is achieved in devicetree by describing the sensor hardware
> +  and the software abstraction of cooling devices and thermal zones required to
> +  take appropriate action to mitigate thermal overload.
> +
> +  The following node types are used to completely describe a thermal management
> +  system in devicetree:
> +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> +   - cooling-device: device used to dissipate heat either passively or artively
> +   - thermal-zones: a container of the following node types used to describe all
> +     thermal data for the platform
> +
> +  This binding describes the cooling devices.
> +
> +  There are essentially two ways to provide control on power dissipation:
> +    - Passive cooling: by means of regulating device performance. A typical
> +      passive cooling mechanism is a CPU that has dynamic voltage and frequency
> +      scaling (DVFS), and uses lower frequencies as cooling states.
> +    - Active cooling: by means of activating devices in order to remove the
> +      dissipated heat, e.g. regulating fan speeds.
> +
> +  Any cooling device has a range of cooling states (i.e. different levels of
> +  heat dissipation). They also have a way to determine the state of cooling in
> +  which the device is. For example, a fan's cooling states correspond to the
> +  different fan speeds possible. Cooling states are referred to by single
> +  unsigned integers, where larger numbers mean greater heat dissipation. The
> +  precise set of cooling states associated with a device should be defined in
> +  a particular device's binding.
> +

This and patch 1 should have a 'select: true' so that this schema is 
applied to all nodes (it does nothing if #cooling-cells is not present).

> +properties:
> +  "#cooling-cells":
> +    description:
> +        Must be 2, in order to specify minimum and maximum cooling state used in
> +        the cooling-maps reference. The first cell is the minimum cooling state
> +        and the second cell is the maximum cooling state requested.
> +    const: 2
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/thermal/thermal.h>
> +
> +    // Example 1: Cpufreq cooling device on CPU0
> +    cpus {
> +            #address-cells = <2>;
> +            #size-cells = <0>;
> +
> +            CPU0: cpu@0 {
> +                    device_type = "cpu";
> +                    compatible = "qcom,kryo385";
> +                    reg = <0x0 0x0>;
> +                    enable-method = "psci";
> +                    cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +                                       &LITTLE_CPU_SLEEP_1
> +                                       &CLUSTER_SLEEP_0>;
> +                    capacity-dmips-mhz = <607>;
> +                    dynamic-power-coefficient = <100>;
> +                    qcom,freq-domain = <&cpufreq_hw 0>;
> +                    #cooling-cells = <2>;
> +                    next-level-cache = <&L2_0>;
> +                    L2_0: l2-cache {
> +                            compatible = "cache";
> +                            next-level-cache = <&L3_0>;
> +                            L3_0: l3-cache {
> +                                    compatible = "cache";
> +                            };
> +                    };
> +          };
> +
> +          /* ... */
> +
> +    };
> +
> +    /* ... */
> +
> +    thermal-zones {
> +            cpu0-thermal {
> +                    polling-delay-passive = <250>;
> +                    polling-delay = <1000>;
> +
> +                    thermal-sensors = <&tsens0 1>;
> +
> +                    trips {
> +                            cpu0_alert0: trip-point0 {
> +                                    temperature = <90000>;
> +                                    hysteresis = <2000>;
> +                                    type = "passive";
> +                            };
> +                    };
> +
> +                    cooling-maps {
> +                            map0 {
> +                                    trip = <&cpu0_alert0>;
> +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>;
> +                            };
> +                    };
> +            };
> +
> +            /* ... */
> +    };
> +...
> -- 
> 2.20.1
> 
