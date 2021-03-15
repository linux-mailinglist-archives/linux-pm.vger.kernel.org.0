Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0433C57C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhCOSYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 14:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231673AbhCOSYX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 14:24:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 796F364F42;
        Mon, 15 Mar 2021 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615832662;
        bh=IV0bAkeJaGcIEwdhxf9utetH1kbkq+bzuMqhnbT6NVc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qCjpCzFs8GdT/ZJwVi45AiS0fFJ1Ig884mwvJWclXcAdzhkMB4SxYwmxvFqyxt+NB
         sMVG2QW6tfIYZEnSxy6M2kpK3b/VSauHXqQ4j6+ZQNv0JKR2KsTNIXdv8KFqhj3nYS
         Lp3/NgNnOiDpLriY06aZoQ4SW30gTaIhXhcM2nNUqJJBMGru3fWjPopyxmo5Qwm4Fe
         CBVJ5C31F3eoJpkl2DIcL5Y2pgKNJ4Hwcv1XjvIXxmyljDUTbvI+G5WMpSaWLV+egw
         D9GOZxfl1jGaZy+dchhMA5PIEK4HqbuP9IMYhfQfiRFPvY2WW+qTiZ5BZJ/1H8QBMR
         FHkFZcK5uYAzw==
Received: by mail-ej1-f51.google.com with SMTP id jt13so67995116ejb.0;
        Mon, 15 Mar 2021 11:24:22 -0700 (PDT)
X-Gm-Message-State: AOAM532jwJcEAhR9M7KqRUM8xoYhytsOBrR59HndDz8cOPC4BQbmAEV6
        PnHgPD3JaSQxpAZPpl2DoA6UCH89efR3oOVlMA==
X-Google-Smtp-Source: ABdhPJy7sfPHsRK5luRVH+hfXvKweuaExpTxUT2ZIeWDSTiEYf+0NROToXyrQljKrbzTWKa8rVzIMe8RmtENELT+0mo=
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr4837571ejm.130.1615832661038;
 Mon, 15 Mar 2021 11:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com> <20210312154357.1561730-9-sebastian.reichel@collabora.com>
In-Reply-To: <20210312154357.1561730-9-sebastian.reichel@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Mar 2021 12:24:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+i=sB7nDzBeF3nRa8FuM_8v=P2SMXQ5XNmuP3b615CKg@mail.gmail.com>
Message-ID: <CAL_Jsq+i=sB7nDzBeF3nRa8FuM_8v=P2SMXQ5XNmuP3b615CKg@mail.gmail.com>
Subject: Re: [PATCH 08/38] dt-bindings: power: supply: bq24735: Convert to DT
 schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Convert the binding to DT schema format.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/bq24735.yaml        | 88 +++++++++++++++++++
>  .../bindings/power/supply/ti,bq24735.txt      | 39 --------
>  2 files changed, 88 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq24735.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yaml b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> new file mode 100644
> index 000000000000..8a3a31ada128
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 Sebastian Reichel
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq24735.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Binding for TI BQ24735 Li-Ion Battery Charger
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,bq24735
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: AC adapter plug event interrupt
> +    maxItems: 1
> +
> +  ti,ac-detect-gpios:
> +    maxItems: 1
> +    description: |
> +      This GPIO is optionally used to read the AC adapter status. This is a Host GPIO
> +      that is configured as an input and connected to the ACOK pin on the bq24735.
> +      Note: for backwards compatibility reasons, the GPIO must be active on AC adapter
> +      absence despite ACOK being active (high) on AC adapter presence.
> +
> +  ti,charge-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Used to control and set the charging current.
> +      This value must be between 128mA and 8.128A with a 64mA step resolution.
> +      The POR value is 0x0000h. This number is in mA (e.g. 8192).
> +      See spec for more information about the ChargeCurrent (0x14h) register.
> +
> +  ti,charge-voltage:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Used to control and set the charging voltage.
> +      This value must be between 1.024V and 19.2V with a 16mV step resolution.
> +      The POR value is 0x0000h. This number is in mV (e.g. 19200).
> +      See spec for more information about the ChargeVoltage (0x15h) register.
> +
> +  ti,input-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Used to control and set the charger input current.
> +      This value must be between 128mA and 8.064A with a 128mA step resolution.
> +      The POR value is 0x1000h. This number is in mA (e.g. 8064).
> +      See the spec for more information about the InputCurrent (0x3fh) register.
> +
> +  ti,external-control:
> +    type: boolean
> +    description: |
> +      Indicates that the charger is configured externally and that the host should not
> +      attempt to enable/disable charging or set the charge voltage/current.
> +
> +  poll-interval:
> +    description: |
> +      If 'interrupts' is not specified, poll AC adapter presence with this interval (milliseconds).

Needs a type.
