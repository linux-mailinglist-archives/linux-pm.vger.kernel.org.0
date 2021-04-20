Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502B13660A3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhDTULP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 16:11:15 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:41539 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhDTULO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 16:11:14 -0400
Received: by mail-oo1-f42.google.com with SMTP id d16-20020a4a3c100000b02901f0590a614eso917209ooa.8;
        Tue, 20 Apr 2021 13:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yFnMPwqi1a5XbptUdOe1ztLdOj6x8Kb8XSOYTB9IP1g=;
        b=OPKFtCLPQNRK/GkB7dVtv3wnYQ0dxv09eBKd61IxW34tnAGojZmvP1rGBwSCxoIBl0
         Mvn6M7exEgTft36r8XyUJe57rq73ZKxLk3OfO5gRIByukug6F6mgWlKh/yFMUNSDzowf
         m6H2430JBJTSSuetscpCGQZK9v/SX9vGQo8UMDjQe86uk4dY+vw+4vAmLubJlWIcQ+nV
         sCF6VtIencHtcI+/OiMyii+Fw/BaIYy8qYDwFZNas9mXNhCS4Ypnb0dU/Ttvb4vRlRh2
         4GxVRcJlgSvabE6PHKcHSFoSJf2J+EZC4j1FzZyIZ3m2Do6L0Hz/Yp2qEgZ9VZP0EJR4
         zVOA==
X-Gm-Message-State: AOAM531zgb1P10QXV/tyXUrgl1tNwDGAsZr0YdlWSGxsn8oAqeLyfom2
        Rp/yNnDUDeFXbx5u2qxc1g==
X-Google-Smtp-Source: ABdhPJwpRNExjTMUw9k8mzXiv4vDbm33vGU2QbaRC+xI3C5Cwi9nQu7nZpcMLoVRTJ53+UqhcTt4rw==
X-Received: by 2002:a05:6820:232:: with SMTP id j18mr10639533oob.86.1618949442217;
        Tue, 20 Apr 2021 13:10:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o20sm23944oos.19.2021.04.20.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 13:10:41 -0700 (PDT)
Received: (nullmailer pid 3728102 invoked by uid 1000);
        Tue, 20 Apr 2021 20:08:39 -0000
Date:   Tue, 20 Apr 2021 15:08:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: thermal: brcm,ns-thermal: convert to the
 json-schema
Message-ID: <20210420200839.GA3724916@robh.at.kernel.org>
References: <20210415111655.4273-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415111655.4273-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 15, 2021 at 01:16:55PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/thermal/brcm,ns-thermal.txt      | 37 ------------
>  .../bindings/thermal/brcm,ns-thermal.yaml     | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
> deleted file mode 100644
> index 68e047170039..000000000000
> --- a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -* Broadcom Northstar Thermal
> -
> -This binding describes thermal sensor that is part of Northstar's DMU (Device
> -Management Unit).
> -
> -Required properties:
> -- compatible : Must be "brcm,ns-thermal"
> -- reg : iomem address range of PVTMON registers
> -- #thermal-sensor-cells : Should be <0>
> -
> -Example:
> -
> -thermal: thermal@1800c2c0 {
> -	compatible = "brcm,ns-thermal";
> -	reg = <0x1800c2c0 0x10>;
> -	#thermal-sensor-cells = <0>;
> -};
> -
> -thermal-zones {
> -	cpu_thermal: cpu-thermal {
> -		polling-delay-passive = <0>;
> -		polling-delay = <1000>;
> -		coefficients = <(-556) 418000>;
> -		thermal-sensors = <&thermal>;
> -
> -		trips {
> -			cpu-crit {
> -				temperature	= <125000>;
> -				hysteresis	= <0>;
> -				type		= "critical";
> -			};
> -		};
> -
> -		cooling-maps {
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
> new file mode 100644
> index 000000000000..50143e2f6bcb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/brcm,ns-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Northstar Thermal
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +description:
> +  Thermal sensor that is part of Northstar's DMU (Device Management Unit).
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    const: brcm,ns-thermal
> +
> +  reg:
> +    description: PVTMON registers range

How many?

> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - reg
> +
> +examples:
> +  - |
> +    thermal: thermal@1800c2c0 {
> +        compatible = "brcm,ns-thermal";
> +        reg = <0x1800c2c0 0x10>;
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +    thermal-zones {
> +        cpu-thermal {
> +            polling-delay-passive = <0>;
> +            polling-delay = <1000>;
> +            coefficients = <(-556) 418000>;
> +            thermal-sensors = <&thermal>;
> +
> +            trips {
> +                cpu-crit {
> +                    temperature = <125000>;
> +                    hysteresis = <0>;
> +                    type = "critical";
> +                };
> +            };
> +
> +            cooling-maps {
> +            };
> +        };
> +    };
> -- 
> 2.26.2
> 
