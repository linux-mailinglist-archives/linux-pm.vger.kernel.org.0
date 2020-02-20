Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0778165EC0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBTN15 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 08:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTN14 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 08:27:56 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD720222C4;
        Thu, 20 Feb 2020 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582205275;
        bh=LRERjOY5swhgYq3TNDFqarey7d7DB+nwUJMGhi6oW7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ETWCB9au7GNELIvo2IGphOuMC7YLOuI9PCos8dfJeskBQpqRE9gfhSM/3dYm1hNfQ
         2+spmMhLjQy3O803GwZkQTSPkJ/g6oQqkLq/GAlXUOKsIRrlaqsih03lVpecyg5ceO
         j/kEiaLM42UzlHx+s3/fjdb6NH2uMpau8TVCPWH8=
Received: by mail-qk1-f175.google.com with SMTP id a141so3490257qkg.6;
        Thu, 20 Feb 2020 05:27:55 -0800 (PST)
X-Gm-Message-State: APjAAAU5VN/68yT5A8b4H5dbRWFBnXY/ikAo3Cd0y05KAxgUxwkzjSGF
        VImFrswwT63uTmoCc5MGXDmeSIVwTMTqqd3fMg==
X-Google-Smtp-Source: APXvYqxZVZomqdZk3IaaKKbZU5jEWBttIla8w6bWDNkZ/rJVdlHm/dja7DRh0sdZhj/Rpu1qHX+SAaGxb8OtZWG18r4=
X-Received: by 2002:a37:6457:: with SMTP id y84mr28648400qkb.254.1582205274941;
 Thu, 20 Feb 2020 05:27:54 -0800 (PST)
MIME-Version: 1.0
References: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com> <1579087831-94965-3-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1579087831-94965-3-git-send-email-jianxin.pan@amlogic.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Feb 2020 07:27:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJwYChw_S4anOPGhH4r3uwD9SVCnRqa_5BwRvwVicjwrg@mail.gmail.com>
Message-ID: <CAL_JsqJwYChw_S4anOPGhH4r3uwD9SVCnRqa_5BwRvwVicjwrg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: power: add Amlogic secure power
 domains bindings
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 5:30 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
>
> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
> power domain registers are in secure world.
>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 40 ++++++++++++++++++++++
>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
>
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> new file mode 100644
> index 00000000..af32209
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +# Copyright (c) 2019 Amlogic, Inc
> +# Author: Jianxin Pan <jianxin.pan@amlogic.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson Secure Power Domains
> +
> +maintainers:
> +  - Jianxin Pan <jianxin.pan@amlogic.com>
> +
> +description: |+
> +  Secure Power Domains used in Meson A1/C1 SoCs, and should be the child node
> +  of secure-monitor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-a1-pwrc
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#power-domain-cells"
> +
> +examples:
> +  - |
> +    secure-monitor {
> +        compatible = "amlogic,meson-gxbb-sm";
> +
> +        pwrc: power-controller {
> +            compatible = "amlogic,meson-a1-pwrc";
> +            #power-domain-cells = <1>;
> +        };
> +    }

Missing ';':

Error: Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.example.dts:27.5-6
syntax error
FATAL ERROR: Unable to parse input tree

Please fix this as linux-next is now failing dt_binding_check.

Rob
