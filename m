Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5281A0EE9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgDGOKK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 10:10:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45445 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGOKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 10:10:10 -0400
Received: by mail-vs1-f65.google.com with SMTP id x82so2220053vsc.12
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79+nDZOIuLbZa1VTI8selCuNZ0XnINqdR9GKi1iIKkc=;
        b=ZXx1i4nNzmqsyK3v/Nwm4L+LlvTL7TDN6g03H79BMB/zO78o76UJYEWnQoJBCw6sSg
         EfQvFQohi1GecvhFdwEVdL9/CFGhY/6OB8OegYOo9sjVEYCFWYjGdaSf3NpzQPxCINPn
         XV5mc1CZEkPx1rM0oyMOXleDxfpnYCNRSZMkK81An1Sx3rLwTPXnQ+Rq3oD+YqLZA/5E
         ExUQpEddgCRPE4FI4gGn8bO0XZFb0KmhMqNKQlKWwYaB0YDU0jBLhFlIdqBsFqzh9jBB
         Irbx783Zm5pne5C0Cd6kfNVshlUZwG4uJXK/HKPJtR66ldf28iIjkQRp9n2OLjubtIS5
         eSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79+nDZOIuLbZa1VTI8selCuNZ0XnINqdR9GKi1iIKkc=;
        b=DNYOodUVBadQ8ABcHt0BcCT26SUF1CYkP2mSKKv07W4qMCZxUqcLLvntk44VIUUDAl
         r4gg938V6UZ6mPKrkv336JhNzu+VAa9PwUSQhXPb3vu+9p2f61cjGerBtrUAqV+cUjEE
         6luID57Sylywf6j/9+dYB4x2FqzP2Frjcb/VA8bBBPj4wnrhj08yILfzpWQpKrTT7nQv
         5F9IeO+mQPpgmfXftZw2zvhwsvw0jHILUPvSs/eCo/oE0k/GONO2Im/ZomvpMYwCZeUb
         D4xsDac+xEDfGF/5qd6Z4snZWmtt7wIvtGlhMf6s21Tk2dL3wcMZaE0yIKwJ59GLx2ew
         5bKw==
X-Gm-Message-State: AGi0PuZDCT8f0VU2Gark0reGQE9peetu88uIJi6QAoLyOyVMHKQuZCPl
        fDXdrGzoj2xBSVZJND0wjfZu5sQ8BJcRSDtxNtqfUQ==
X-Google-Smtp-Source: APiQypIFEOVcAbgdQZgWZ34s1xvjOFu+BBAukDayLct4eCO3UmJWQZwoxMaCFMsAFdAXxqi0hDH6qKqImsRL4bdZaIo=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr171963vsq.27.1586268608265;
 Tue, 07 Apr 2020 07:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200329220324.8785-1-daniel.lezcano@linaro.org> <20200329220324.8785-2-daniel.lezcano@linaro.org>
In-Reply-To: <20200329220324.8785-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 7 Apr 2020 19:39:56 +0530
Message-ID: <CAHLCerMTcRo34jFkP+ZTt6BAwDPOQo9sf7Yws4Tja7_gikvvKQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add the idle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 3:37 AM Daniel Lezcano
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
> together as showed in the example.

typo: shown

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

s/begins to /should/?

> +
> +   latency:
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +      description: |
> +         The exit latency constraint in microsecond for the injected
> +         idle state for the device.

I haven't yet checked this entire series, but what does this property
mean? Is it the latency constraint to apply when selecting an idle
state from among all the states described to cpuidle?

Shouldn't we just name the property exit-latency?

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

thermal-idle?

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

thermal-idle?

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
