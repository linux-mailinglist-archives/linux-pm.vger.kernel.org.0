Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE313E8AF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 18:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404833AbgAPRdl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 12:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387875AbgAPRdl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 12:33:41 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45613246D8;
        Thu, 16 Jan 2020 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196020;
        bh=2G0Ng8OaQXY0myuwsXjYgysTnAkfNx4yCUXz8txEl2Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vd/D2dqhVkk/59pyEhm3YzDslAjdxWxnY8HVcflYPu9BYi5M2fluN/7qGED+/2x3q
         FEqZtepLYPcur1TFx9cTTrpOQa+XAOiY74agLTBgaVPlHxKEc6VLGwSnfUWyzBngsS
         F0k9PXMbe2fYpxERpAz/dVRnYfE/ibbxVX1YntZ8=
Received: by mail-qk1-f169.google.com with SMTP id c16so19884519qko.6;
        Thu, 16 Jan 2020 09:33:40 -0800 (PST)
X-Gm-Message-State: APjAAAUNxCmxqLox94WRRfH/E86xRM0pSnahAV7aZPnShduhjumT/Wlp
        QHvV2DP36Mt2igFg2cUNIBEyOcduN1K1WlvP1g==
X-Google-Smtp-Source: APXvYqzp8zTCERQIV+x1zdU2FH8qa9LdLhrgMgX7M1lyS8XHlvveUMh4kI3m0RFeC5HMz+WfbUraLiUXsMQZdBiBvTg=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr31335279qkl.119.1579196019371;
 Thu, 16 Jan 2020 09:33:39 -0800 (PST)
MIME-Version: 1.0
References: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com> <1578941778-23321-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1578941778-23321-2-git-send-email-stefan.wahren@i2se.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Jan 2020 11:33:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+w0KGE-=XkAwpdqh67pH=V34ETCy8X92L_u1=_8xuKCg@mail.gmail.com>
Message-ID: <CAL_Jsq+w0KGE-=XkAwpdqh67pH=V34ETCy8X92L_u1=_8xuKCg@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] dt-bindings: Add Broadcom AVS RO thermal
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 12:56 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Since the BCM2711 doesn't have a AVS TMON block, the thermal information
> must be retrieved from the AVS ring oscillator block. This block is part
> of the AVS monitor which contains a bunch of raw sensors.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml

The example fails 'make dt_binding_check':

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dt.yaml:
thermal: 'reg' is a required property

> diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> new file mode 100644
> index 0000000..98e7b57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/brcm,avs-ro-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom AVS ring oscillator thermal
> +
> +maintainers:
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +description: |+
> +  The thermal node should be the child of a syscon node with the
> +  required property:
> +
> +  - compatible: Should be one of the following:
> +                "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
> +
> +  Refer to the the bindings described in
> +  Documentation/devicetree/bindings/mfd/syscon.txt
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2711-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +        avs-monitor@7d5d2000 {
> +                compatible = "brcm,bcm2711-avs-monitor",
> +                             "syscon", "simple-mfd";
> +                reg = <0x7d5d2000 0xf00>;
> +
> +                thermal: thermal {
> +                        compatible = "brcm,bcm2711-thermal";
> +                        #thermal-sensor-cells = <0>;

Also this is not documented. That's not caught because
'additionalProperties: false' is also needed.

Rob
