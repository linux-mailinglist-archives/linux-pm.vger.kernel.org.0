Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6954B35A623
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhDISvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 14:51:01 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44606 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhDISvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 14:51:00 -0400
Received: by mail-oi1-f171.google.com with SMTP id a8so6751595oic.11;
        Fri, 09 Apr 2021 11:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i8GbqRQEHeP2EqgmGjEjIt2ox7NZUNUdFG+++1UPJcw=;
        b=m9hjZ3wRay9VqknNqtpNOIlmlYxO8lwJN45VvC6UFy4UmrZM0+F70ecuXeBrGG3lta
         DevPZSuXSLO9gWorS1R2lh5uMps6Qzen7vTAOtSmx9v6TnTP1Cm6afCruTeJsN4Jvp+5
         U2JE6PG+61zBDWE4/LvdRUYidFPqS5LPR7jViZuV5KUvYEDTFxQ37X1TBdBw1ar+1yIl
         S7xY/4+85nf2LyUtQ+5b8Tgi9U6COYyiHWKUc5h3oHQiyASmiNHWziOkfepnAbcaGoqG
         iU+m1usvzqiSuKxGtsR5bxUOdEjEIIYYsN7qLitnuLQaekwa9Rbx2j1xDSDLvbTcYCn3
         VPvQ==
X-Gm-Message-State: AOAM530c8GaBZInKjmonJ6gHynj2jE9AYUODU4AFKKrfUqDdmucf5vJV
        8K6ipeUfL8kCouOSkaqisg==
X-Google-Smtp-Source: ABdhPJxOgsx3W5p0J/SDAcjcLj5PyF88Mg/SrjGRlhpKG8oigPtomU39Q41f5SfM333pLvW2+yHg5Q==
X-Received: by 2002:aca:3f87:: with SMTP id m129mr10867257oia.82.1617994245972;
        Fri, 09 Apr 2021 11:50:45 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m129sm670785oif.34.2021.04.09.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:50:45 -0700 (PDT)
Received: (nullmailer pid 3949822 invoked by uid 1000);
        Fri, 09 Apr 2021 18:50:44 -0000
Date:   Fri, 9 Apr 2021 13:50:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 4/4] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
Message-ID: <20210409185044.GA3946207@robh.at.kernel.org>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-5-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617881469-31965-5-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 08, 2021 at 05:01:09PM +0530, satya priya wrote:
> Convert qcom pm8941 power key binding from .txt to .yaml format.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - Fixed bot errors, took reference from input.yaml for "linux,code"
>  - Added one complete example for powerkey and resin, and referenced it
>    in main PON binding.
>  - Moved this patch to the end of the series.
> 
>  .../bindings/input/qcom,pm8941-pwrkey.txt          | 55 --------------
>  .../bindings/input/qcom,pm8941-pwrkey.yaml         | 88 ++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>  create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml


> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
> new file mode 100644
> index 0000000..fb6cbe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/qcom,pm8941-pwrkey.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PM8941 PMIC Power Key
> +
> +maintainers:
> +  - Courtney Cavin <courtney.cavin@sonymobile.com>
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8941-pwrkey
> +      - qcom,pm8941-resin
> +      - qcom,pmk8350-pwrkey
> +      - qcom,pmk8350-resin
> +
> +  interrupts:

How many?

> +    description: |
> +          Key change interrupt; The format of the specifier is
> +          defined by the binding document describing the node's
> +          interrupt parent.

The 2nd sentence is every 'interrupts' property. Drop.

> +
> +  debounce:
> +    description: |
> +          Time in microseconds that key must be pressed or
> +          released for state change interrupt to trigger.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  bias-pull-up:
> +    description: |
> +           Presence of this property indicates that the KPDPWR_N
> +           pin should be configured for pull up.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  linux,code:
> +    description: |
> +           The input key-code associated with the power key.
> +           Use the linux event codes defined in
> +           include/dt-bindings/input/linux-event-codes.h
> +           When property is omitted KEY_POWER is assumed.
> +    $ref: "input.yaml#"

You've just defined that 'linux,code' is a node with properties defined 
in input.yaml. Need to move this up to the top level.

> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/interrupt-controller/irq.h>
> +   #include <dt-bindings/input/linux-event-codes.h>
> +   #include <dt-bindings/spmi/spmi.h>
> +   spmi_bus: spmi@c440000 {
> +     reg = <0x0c440000 0x1100>;
> +     #address-cells = <2>;
> +     #size-cells = <0>;
> +     pmk8350: pmic@0 {
> +       reg = <0x0 SPMI_USID>;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       pmk8350_pon: pon_hlos@1300 {
> +         reg = <0x1300>;
> +         compatible = "qcom,pm8998-pon";
> +
> +         pwrkey {
> +            compatible = "qcom,pm8941-pwrkey";
> +            interrupts = < 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH >;
> +            debounce = <15625>;
> +            bias-pull-up;
> +            linux,code = <KEY_POWER>;
> +         };
> +
> +         resin {
> +            compatible = "qcom,pm8941-resin";
> +            interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +            debounce = <15625>;
> +            bias-pull-up;
> +            linux,code = <KEY_VOLUMEDOWN>;
> +         };
> +       };
> +     };
> +   };
> +...
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
