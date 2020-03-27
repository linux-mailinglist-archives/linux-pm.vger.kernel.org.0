Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E343195277
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 08:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgC0H70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 03:59:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40737 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgC0H7Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 03:59:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so11268427wmf.5
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2020 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A3SXt9hKtlX1+t84Pw/hXlXdpS45L5XvfwgDMGD8Nko=;
        b=PH8Cpe40EpSF7HB9AKeXxzJ1+XtwHVysz14bHbN16e+oAMowvX590ARQroH633UNUx
         f+rXTFoH9FEkJAs7AxlbINo7Io1KUh/QFsEU8hRJ9UckHHvOyK7uT0gnRWIn3lTqIZY4
         VszUzEF1c3iVwZtq8xr/Rt/1h927SDlUfEc3OYlTsKwkk+jjDeGWQGxXLmy6eLqf4h36
         lsPty8cviKyEar+HtlgyOxKTG96MgoiP5Z5fmuckNar2L1b07WKA6JgNmp3TVlz0JHUy
         MrUeIChjLJzTnqWcwr7loYjzbUPin3CRt93ie1JeIhqrWzu9HH6lGKmZfzWobXn9Sobi
         rl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A3SXt9hKtlX1+t84Pw/hXlXdpS45L5XvfwgDMGD8Nko=;
        b=dOPkVEM0gObnA9BLpC2wziGn6hG7MHb3/sAt5YPAb2gowtfgK6nZr2YNt2HuTfSgqY
         5vkDU6NEcDoRTVRaKiByOHHepLPJ/wu00091t5ZWtCkw/pX8tjYW/m78sTQzV1Jvb1wD
         ITm9zKStts1a0aWd0zldHqDFwgXWGUdxrzzw0yJsHMNN8ia8WFNGiCAEBV4/Ttm9l8O8
         NaJFniUQMTgHCq6PCiktoCKHNOAakoYwgrJmdiwR5GTTKvy568eixn8PKczJM6d4THTl
         OMKZCccaPnUm5ldKIDi6/Qc00mD1cSWKeWtBy6msWANl8IpD09epykRnhW3QTj8FmZ/1
         NsFQ==
X-Gm-Message-State: ANhLgQ0TV04kEl+Suk1SnEXa+573Ncl/ApGwK7Lz+TocHQ6WJwbS6M7m
        TGuKUFX8uAFkOY9jv+EqaljZzA==
X-Google-Smtp-Source: ADFU+vtuAAzt17YyAL9hR5KUBg7fm4k5jzYFnkXge0vitnHvBL5WZM5ArdCdYWMQtFG71oW2werRfw==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr3951832wml.156.1585295963787;
        Fri, 27 Mar 2020 00:59:23 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id o9sm7378769wrx.48.2020.03.27.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 00:59:22 -0700 (PDT)
Date:   Fri, 27 Mar 2020 08:00:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: add document bindings for mp2629
Message-ID: <20200327080013.GG603801@dell>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200322224626.13160-2-sravanhome@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 22 Mar 2020, Saravanan Sekar wrote:

> Add device tree binding information for mp2629 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> new file mode 100644
> index 000000000000..314309ea91ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

Are these links supposed to work?

> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +description: |
> +  MP2629 is an PMIC providing battery charging and power supply for smartphones,

s/an/a/

> +  wireless camera and portable devices. Chip is contrlled over I2C.

Spell check!

> +  The MFD device handles battery charger controller and ADC IIO device for
> +  battery, system voltage

MFD isn't a thing.  We made it up.  Please describe it as it is in the datasheet.

> +properties:
> +  compatible:
> +    const: mps,mp2629
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +    description:
> +      The first cell is the IRQ number, the second cell is the trigger type.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +    i2c {

i2c@0x????????

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@4b {
> +            compatible = "mps,mp2629";
> +            reg = <0x4b>;
> +
> +            interrupt-controller;
> +            interrupt-parent = <&gpio2>;
> +            #interrupt-cells = <2>;
> +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
