Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EAE1A351D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDINtM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 09:49:12 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36647 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDINtJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 09:49:09 -0400
Received: by mail-ua1-f65.google.com with SMTP id m15so3943068uao.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dJ2iz6mYeufR/3a819TAwvmat0FG6WlCPrzsZs/LR0=;
        b=amKfqnd8WQyQUAwi4cZoNrTICQeFaNVJPH28XmKBDQXacysYodktIyiN2ndQx+TQcv
         bE1YQidGEZu1EqGjm0MH4mmpq5nA+42ldSSrTL99PS28PvRiy5Hu36Cw1+BHd0Q73auH
         i7MxRDbVc1bfVrS2iATOcjNUHRMwaGOf7ARFElgadRaI+Se1QV8mAOs2BNZiqLtpCn8c
         oTRo6ATdFF9BsWVB81GBQe4ny1no9JSpdhqD2Z9AjhLDI+EVj/kkJjI4KioULc4bTIrU
         53JZXLEI3Y9kZK43il6Z+a7GkDur/yKP+teUqIU/+86Cx0fcoAj2NCUItb1asfK4YGnz
         WjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dJ2iz6mYeufR/3a819TAwvmat0FG6WlCPrzsZs/LR0=;
        b=m6QSCqpKricO5HofDbOTVhuNJwl6wKU0duSN/EyU4ry0cdxyc+Aw2QwYGxkOCUF4M+
         aOl3elB6/5Xa624hi6f/Qxd0BsxwFpKWv4k5br5+lkJsBMJJJGYS2T8hXr0wLQV795bF
         7uXkEJ9jd76QEL5L6Wcps21aKFy4iujFw9VOkoS2BcWWemuI3MCc89s8aTZ2sIac/7MB
         ikom8FDp4nZS0M+frmNVNLax3bwoPkNMQE4pPRU94K15jwZeT38eZiPNx3NuvcyipB9t
         /u6GZjhUnGFdMvUn9XEl9Neq5TayoUfgBoAH8kvIWOw5FV+eTGH6VQ1STfZRIFnW6LYK
         bjPw==
X-Gm-Message-State: AGi0PubmE0JTSXQ0txeHvLC9u+bkiYrrA+Sg0VBcrUrTfWKmy+DVx8y6
        jztb6g14muSZAz/CgsF2/WfQYzHGAezb8hI3UQPYeA==
X-Google-Smtp-Source: APiQypJeghsuGIyn0WvqoYX5wxkTIWjxtH/G1Qe+Ftm6KAYOlTTo2AJGBIWDmRQ2iRf8Hp4GTBdezU70qfNWPExhJhA=
X-Received: by 2002:ab0:654c:: with SMTP id x12mr9506156uap.48.1586440147159;
 Thu, 09 Apr 2020 06:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <1586407908-27139-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1586407908-27139-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 9 Apr 2020 19:18:56 +0530
Message-ID: <CAHLCerPi36z4z4DLmP9czEp8aw8yQq7EHAtHdCFLO2ZVYBZsRA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Convert i.MX to json-schema
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,

On Thu, Apr 9, 2020 at 10:29 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Convert the i.MX thermal binding to DT schema format using json-schema
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    | 61 --------------
>  .../devicetree/bindings/thermal/imx-thermal.yaml   | 97 ++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> deleted file mode 100644
> index 823e417..0000000
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
> -
> -Required properties:
> -- compatible : must be one of following:
> -  - "fsl,imx6q-tempmon" for i.MX6Q,
> -  - "fsl,imx6sx-tempmon" for i.MX6SX,
> -  - "fsl,imx7d-tempmon" for i.MX7S/D.
> -- interrupts : the interrupt output of the controller:
> -  i.MX6Q has one IRQ which will be triggered when temperature is higher than high threshold,
> -  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
> -  when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
> -  is higher than panic threshold, system will auto reboot by SRC module.
> -- fsl,tempmon : phandle pointer to system controller that contains TEMPMON
> -  control registers, e.g. ANATOP on imx6q.
> -- nvmem-cells: A phandle to the calibration cells provided by ocotp.
> -- nvmem-cell-names: Should be "calib", "temp_grade".
> -
> -Deprecated properties:
> -- fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
> -  calibration data, e.g. OCOTP on imx6q.  The details about calibration data
> -  can be found in SoC Reference Manual.
> -
> -Direct access to OCOTP via fsl,tempmon-data is incorrect on some newer chips
> -because it does not handle OCOTP clock requirements.
> -
> -Optional properties:
> -- clocks : thermal sensor's clock source.
> -
> -Example:
> -ocotp: ocotp@21bc000 {
> -       #address-cells = <1>;
> -       #size-cells = <1>;
> -       compatible = "fsl,imx6sx-ocotp", "syscon";
> -       reg = <0x021bc000 0x4000>;
> -       clocks = <&clks IMX6SX_CLK_OCOTP>;
> -
> -       tempmon_calib: calib@38 {
> -               reg = <0x38 4>;
> -       };
> -
> -       tempmon_temp_grade: temp-grade@20 {
> -               reg = <0x20 4>;
> -       };
> -};
> -
> -tempmon: tempmon {
> -       compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
> -       interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> -       fsl,tempmon = <&anatop>;
> -       nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> -       nvmem-cell-names = "calib", "temp_grade";
> -       clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> -};
> -
> -Legacy method (Deprecated):
> -tempmon {
> -       compatible = "fsl,imx6q-tempmon";
> -       fsl,tempmon = <&anatop>;
> -       fsl,tempmon-data = <&ocotp>;
> -       clocks = <&clks 172>;
> -};
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> new file mode 100644
> index 0000000..ad12622
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/imx-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX Thermal Binding
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx6q-tempmon
> +              - fsl,imx6sx-tempmon
> +              - fsl,imx7d-tempmon
> +

> +  interrupts:
> +    description: |
> +      The interrupt output of the controller, the IRQ will be triggered
> +      when temperature is higher than high threshold.
> +    maxItems: 1
> +

imx6sx and imx7d have 3 interrupts each. So you need an if clause to
change the interrupt number based on what compatible is provided. See
qcom-tsens.yaml for an example.

> +  nvmem-cells:
> +    description: |
> +      Phandle to the calibration cells provided by ocotp for calibration
> +      data and temperature grade.
> +    maxItems: 2
> +
> +  nvmem-cell-names:
> +    maxItems: 2
> +    items:
> +      - const: calib
> +      - const: temp_grade
> +
> +  fsl,tempmon:
> +    description: |
> +      Phandle pointer to system controller that contains TEMPMON control
> +      registers, e.g. ANATOP on imx6q.
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Nit: move $ref line above description. IMO it makes the binding easier to read.

> +
> +  fsl,tempmon-data:
> +    description: |
> +      Deprecated property, phandle pointer to fuse controller that contains
> +      TEMPMON calibration data, e.g. OCOTP on imx6q. The details about
> +      calibration data can be found in SoC Reference Manual.
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Nit: move $ref line above description. IMO it makes the binding easier to read.

> +
> +  clocks:
> +    description: |
> +      Thermal sensor's clock source.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - fsl,tempmon
> +  - clocks

Clocks was an optional property before, are you sure?

> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6sx-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ocotp: ocotp@21bc000 {
> +         #address-cells = <1>;
> +         #size-cells = <1>;
> +         compatible = "fsl,imx6sx-ocotp", "syscon";
> +         reg = <0x021bc000 0x4000>;
> +         clocks = <&clks IMX6SX_CLK_OCOTP>;
> +
> +         tempmon_calib: calib@38 {
> +             reg = <0x38 4>;
> +         };
> +
> +         tempmon_temp_grade: temp-grade@20 {
> +             reg = <0x20 4>;
> +         };
> +    };
> +
> +    tempmon: tempmon {
> +         compatible = "fsl,imx6sx-tempmon";
> +         interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +         fsl,tempmon = <&anatop>;
> +         nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> +         nvmem-cell-names = "calib", "temp_grade";
> +         clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> +    };
> +
> +...
> --
> 2.7.4
>
