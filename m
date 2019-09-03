Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8F4A6257
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfICHO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 03:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfICHO4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Sep 2019 03:14:56 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74981217D7;
        Tue,  3 Sep 2019 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567494895;
        bh=rmcusr+wX8XSoyTKS/POm0d6XCyEv2vtg7TEOgrvejY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJPxAl2yzJI+3FIKE1T1OUwMcHqsYY+kv+DlJu92XYT6S/sz5ectt4g4SN98sH9hf
         Az089OpQh3UZnaPX3g6S34Vf8t8Ud0K2rqxOKSz9aAY926Ddu2RpV6i2BIBq30H3MO
         yFdQSh83KrRQ3FjSidynESJWedug5HIiZrPrsq/c=
Received: by mail-qt1-f179.google.com with SMTP id r5so13211326qtd.0;
        Tue, 03 Sep 2019 00:14:55 -0700 (PDT)
X-Gm-Message-State: APjAAAVX3xwR6VxZ62aSr4mD3qiBFDvhWfsC03vELukiJ93MG8m/BUcq
        FRRLgKiGSxBrvuBMHdJ+Ag9dGjw2ASwCEAbWYg==
X-Google-Smtp-Source: APXvYqz5XsmuqNHJeQd9JXH675NAbzJ/857uySOgwZxnQXo+VM/m8JVVJovCqZIOtCBeOhAnCvckhUeip7egvh2w+c0=
X-Received: by 2002:ac8:31b3:: with SMTP id h48mr32610749qte.300.1567494894631;
 Tue, 03 Sep 2019 00:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190902150336.3600-1-krzk@kernel.org>
In-Reply-To: <20190902150336.3600-1-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Sep 2019 08:14:43 +0100
X-Gmail-Original-Message-ID: <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
Message-ID: <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: syscon-reboot: Convert bindings
 to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 2, 2019 at 4:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Convert the Syscon reboot bindings to DT schema format using
> json-schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/power/reset/syscon-reboot.txt    | 30 --------
>  .../bindings/power/reset/syscon-reboot.yaml   | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml

> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> new file mode 100644
> index 000000000000..a583f3dc8ef4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/syscon-reboot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic SYSCON mapped register reset driver
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |+
> +  This is a generic reset driver using syscon to map the reset register.
> +  The reset is generally performed with a write to the reset register
> +  defined by the register map pointed by syscon reference plus the offset
> +  with the value and mask defined in the reboot node.
> +  Default will be little endian mode, 32 bit access only.
> +
> +properties:
> +  compatible:
> +    const: syscon-reboot
> +
> +  mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Update only the register bits defined by the mask (32 bit).
> +    maxItems: 1

Drop this as that is already defined for uint32.

It also doesn't actually work. The $ref has to be under an 'allOf' if
you have additional schemas. A quirk of json-schema...

> +
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the reboot register (in bytes).
> +    maxItems: 1
> +
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the register map node.
> +    maxItems: 1
> +
> +  value:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The reset value written to the reboot register (32 bit access).
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - regmap
> +  - offset
> +
> +allOf:
> +  - if:
> +      properties:
> +        value:
> +          not:
> +            type: array

I think you could make this a bit more readable with:

if:
  not:
    required:
      - value

However, if the tree is free of legacy usage, then you could just drop all this.

Rob
