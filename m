Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370CA2D2E71
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 16:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgLHPkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 10:40:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43498 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgLHPkD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 10:40:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id q25so11708746oij.10;
        Tue, 08 Dec 2020 07:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r4At2JRTffPDhNlHKCVUhQQs+9lnibYf2nVgEDOu8xg=;
        b=q4NWxmBf5Guvi2CJOdvbPR6DY5dCm1ApGuDmwcR5MbFCo88m9w8MwjVX+Pu/vwjoD9
         5UptPQ7/P7MA8AgfdT551I92G3skLA9l4za5lJ+Hvw9hWBb1UQsFzSt/LlbELUMIeSYB
         +7GVYuqBEtKyx4tsmBoi9ZxtT1JqZ0mUNFUJx2gsudGQusGUfXtDRXFPwbjiH2RZN8tz
         UW9ifby6Lf8NX0ipwrq8bzxFcUWl9vHLyyRWknJ2HTGpRu7KuIL9ln32oHPxFRewSTN/
         dLzLIxtycZgRjd74fko8hFW4yfbIOvRzkIhaRjCBlhdffK1fQMDm4oUKJVc6KdI2GJeh
         PrGA==
X-Gm-Message-State: AOAM532rZRT0nGMWBj6UeJ91cOLxnscGeMSP7YK0gHkdzQiZRobGhVWV
        0FRsoHGr09sEQudYnwg6lA==
X-Google-Smtp-Source: ABdhPJyKnbmKSDVPybWvTW80k+sHigOw9XIDTe2qJfgfN84Dh9l8C8fNgU9Lngc/r258HaY/1gYj1Q==
X-Received: by 2002:aca:d706:: with SMTP id o6mr3184121oig.28.1607441961968;
        Tue, 08 Dec 2020 07:39:21 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm2727665ooo.2.2020.12.08.07.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 07:39:20 -0800 (PST)
Received: (nullmailer pid 2567594 invoked by uid 1000);
        Tue, 08 Dec 2020 15:39:19 -0000
Date:   Tue, 8 Dec 2020 09:39:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201208153919.GB2539955@robh.at.kernel.org>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
 <20201207142756.17819-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207142756.17819-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 07, 2020 at 03:27:55PM +0100, Michael Klein wrote:
> Add devicetree binding documentation for regulator-poweroff driver.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  .../power/reset/regulator-poweroff.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
> new file mode 100644
> index 000000000000..8c8ce6bb031a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/regulator-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Force-disable power regulators to turn the power off.
> +
> +maintainers:
> +  - Michael Klein <michael@fossekall.de>
> +
> +description: |
> +  When the power-off handler is called, one more regulators are disabled
> +  by calling regulator_force_disable(). If the power is still on and the
> +  CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.

WARN_ON is a Linux thing. Bindings are independent from Linux.

> +
> +properties:
> +  compatible:
> +    const: "regulator-poweroff"
> +
> +  regulator-names:

We already have 'regulator-name' which is something different, and 
*-names already has a defined usage as a companion to other properties 
('foo-names' goes with 'foos'). More on this below...

> +    description:
> +      Array of regulator names
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  REGULATOR-supply:
> +    description:
> +      For any REGULATOR listed in regulator-names, a phandle
> +      to the corresponding regulator node
> +    $ref: /schemas/types.yaml#/definitions/phandle

*-supply already has a type.

> +
> +  timeout-ms:
> +    description:
> +      Time to wait before asserting a WARN_ON(1). If nothing is
> +      specified, 3000 ms is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Do we really need to tune the timeout just for an error message?

> +
> +required:
> +  - compatible
> +  - regulator-names
> +  - REGULATOR-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    regulator-poweroff {
> +        compatible = "regulator-poweroff";
> +        regulator-names = "vcc1v2", "vcc-dram";
> +        vcc1v2-supply = <&reg_vcc1v2>;
> +        vcc-dram-supply = <&reg_vcc_dram>;

-supply names are supposed to be named based on the consumer names (e.g. 
LDO1 regulator supplies vcc-supply). To avoid 'regulator-names' and 
simplifier the driver, I'd just define fixed, known names. Something 
like:

power1-supply
power2-supply
...

Rob
