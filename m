Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4922DFF8
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2Ok3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 10:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2Ok3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 10:40:29 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3202323A82;
        Wed, 29 May 2019 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559140828;
        bh=EAdtr7sRR0pl/EFHtygZt/Pp3BubgxUN3LjE7D6cOlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ao2UBId6fsrnjUhuVoz6EJkA6GBDiM237jsCkERiAcLuVEJzhicF1ZqGKUx9BeyXo
         BHFsJrCUR/wHqtB+c1ttFIp1jVQIl4sRydzpPaUGpcH9euyaqyF+muzyT5+xw2av5D
         szPdjEW6MCHzJ+gAOzBCeR8nJQ35SKzXf58VWQbo=
Received: by mail-lf1-f43.google.com with SMTP id v18so2312709lfi.1;
        Wed, 29 May 2019 07:40:28 -0700 (PDT)
X-Gm-Message-State: APjAAAX667em/enyT5T9gTnLllqVXaYr1g3CwEr/uks+NIhD2ksjEgve
        mRiWQU97TKDf0rQMfcJXxsAfZDBLfOe6g/Bxjdk=
X-Google-Smtp-Source: APXvYqzGwBFLfzLcIP1wJ+4vix58xGXZlLe1e6Gmb4rGT85Ek2cI7Vkp9JES0OgdOXg8ziQZzIohPTW6iOjEkmCNDlw=
X-Received: by 2002:ac2:4d0d:: with SMTP id r13mr16779577lfi.30.1559140826498;
 Wed, 29 May 2019 07:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br> <20190527022258.32748-3-matheus@castello.eng.br>
In-Reply-To: <20190527022258.32748-3-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 16:40:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcigVQEzR3xQMcc9hcSXn0VVCvNR+U2F0the62orR98qw@mail.gmail.com>
Message-ID: <CAJKOXPcigVQEzR3xQMcc9hcSXn0VVCvNR+U2F0the62orR98qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 May 2019 at 04:45, Matheus Castello <matheus@castello.eng.br> wrote:
>
> For configure low level state of charge threshold alert signaled from
> max17040 we add "maxim,alert-low-soc-level" property.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../power/supply/max17040_battery.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> new file mode 100644
> index 000000000000..a13e8d50ff7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -0,0 +1,28 @@
> +max17040_battery
> +~~~~~~~~~~~~~~~~
> +
> +Required properties :
> + - compatible : "maxim,max17040" or "maxim,max77836-battery"
> +
> +Optional properties :
> +- maxim,alert-low-soc-level :  The alert threshold that sets the state of
> +                               charge level (%) where an interrupt is
> +                               generated. Can be configured from 1 up to 32
> +                               (%). If skipped the power up default value of
> +                               4 (%) will be used.
> +- interrupts :                         Interrupt line see Documentation/devicetree/
> +                               bindings/interrupt-controller/interrupts.txt

Based on driver's behavior, I understand that these two properties
come in pair so maxim,alert-low-soc-level (or its default value) will
be used if and only if interrupts property is present. Maybe mention
this? In general looks fine to me:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> +- wakeup-source :              This device has wakeup capabilities. Use this
> +                               property to use alert low SOC level interrupt
> +                               as wake up source.
> +
> +Example:
> +
> +       battery-fuel-gauge@36 {
> +               compatible = "maxim,max17040";
> +               reg = <0x36>;
> +               maxim,alert-low-soc-level = <10>;
> +               interrupt-parent = <&gpio7>;
> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +               wakeup-source;
> +       };
> --
> 2.20.1
>
