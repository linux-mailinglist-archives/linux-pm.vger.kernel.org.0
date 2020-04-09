Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF71A3545
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgDIN7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 09:59:55 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37644 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgDIN7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 09:59:55 -0400
Received: by mail-ua1-f65.google.com with SMTP id 21so1656788uae.4
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jkl82fMmpPtjMZVRujvoQOTRneX3UQjhsTCNuv3S3s=;
        b=FxVC96kMHeavDRhR9NWDUmy5X49gFWh+0HDbaZ+6UAnMrYLIJRBzFUzjIg5nPzxoBt
         5TBgUZVAHEdP1R0TyuZ9lnFvvuIHvJBobOtbitVPPXKY/vCVO3XVZYahbUJoDoTnPZNZ
         yqxmWfG17xufkMVcpF2SWFHvkVpXZk7zp+AM0WYwKew0o4xf3jubzWh/IKVh692yiXTG
         BK/OC78W9NuBBh4XwFtoL0dnoumlFR41FMU//UDE4T5k8Iae0juCPjjByqkCIX5G+Lve
         FjYpYaR8S3OAGW8iSoabqVJmnJk8LaYyh56y27V3s/ThIjWI03x7Dfs5AkWDG1u28hQI
         W+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jkl82fMmpPtjMZVRujvoQOTRneX3UQjhsTCNuv3S3s=;
        b=qKWs/cvZ2RyNJo4jziKwleaWGKZoIT+2ljP2IpSmbKqfIwH6Irp7qHIZQpigaCZStd
         X8xVjRYTLCoNqgqGtxK+ZYnkRQK7S036BgeQyJfIcu1V3eaCX6NZlwHilnUNp7Sn5iVD
         VRKq2Inz6ngut7Mq4RttcdckpX7IMW0xGKuy0XsKwNC1Cq6h+EegME+tCXHNDneCVjqA
         f3J/PBm05sniesOJO9NLVDJyL7YS+0LdDIl/XZu6XzQ8exEQeemfoByEdh3nAC8vlg6E
         d5d8sgtOZKtpetwQiiLyqxc7j2xjTcT6CxSevhoXnkKPhOdqZiXX//563+KRB3Uy+Ada
         CYuA==
X-Gm-Message-State: AGi0PubQqKeeN6L+Cr0TzMd16yy08cyKns8ZddksrPtnwe4FZASbpzsj
        UD56Y7yt4Yl6/9KbAZ+15NNdNQ1IGnAr4XxwEg3zJg==
X-Google-Smtp-Source: APiQypIDFpo4gH1UScb4MbAQVnWTILN06mQONvAjwMuBOpgK2p9AlvbueRBggIkJbzWGyZJKZKNcrD7wzAfLjecKsWE=
X-Received: by 2002:ab0:608b:: with SMTP id i11mr9020160ual.94.1586440794633;
 Thu, 09 Apr 2020 06:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <1586402293-30579-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1586402293-30579-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 9 Apr 2020 19:29:43 +0530
Message-ID: <CAHLCerNonZ7qJi8Qihmj87QteEnxTF0PRS6vw5GPemMurOfS9Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Convert i.MX8MM to json-schema
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

On Thu, Apr 9, 2020 at 8:56 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Convert the i.MX8MM thermal binding to DT schema format using json-schema

Would it be possible to have a single yaml file for all i.MX thermal
sensors by playing with required and optional properties ?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx8mm-thermal.txt | 15 ------
>  .../bindings/thermal/imx8mm-thermal.yaml           | 53 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> deleted file mode 100644
> index 3629d3c..0000000
> --- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
> -
> -Required properties:
> -- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
> -- reg : Address range of TMU registers.
> -- clocks : TMU's clock source.
> -- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
> -
> -Example:
> -tmu: tmu@30260000 {
> -       compatible = "fsl,imx8mm-tmu";
> -       reg = <0x30260000 0x10000>;
> -       clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> -       #thermal-sensor-cells = <0>;
> -};
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> new file mode 100644
> index 0000000..53a42b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/imx8mm-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Mini Thermal Binding
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-tmu
> +              - fsl,imx8mp-tmu
> +  reg:
> +    description: |
> +      Address range of TMU registers.
> +    maxItems: 1
> +  clocks:
> +    description: |
> +      TMU's clock source.
> +    maxItems: 1
> +
> +  # See ./thermal.txt for details

Don't point to thermal.txt anymore. thermal.txt will be replaced by
thermal-*.yaml files at some point soon.

> +  "#thermal-sensor-cells":
> +    enum:
> +      - 0

Don't you have multiple sensors connected to this controller? In that
case, 0 won't be a valid value.

> +      - 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +
> +    tmu: tmu@30260000 {
> +         compatible = "fsl,imx8mm-tmu";
> +         reg = <0x30260000 0x10000>;
> +         clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> +         #thermal-sensor-cells = <0>;
> +    };
> +
> +...
> --
> 2.7.4
>
