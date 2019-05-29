Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F92E052
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfE2O5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 10:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2O5h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 10:57:37 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89EE23B3D;
        Wed, 29 May 2019 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559141857;
        bh=2MoQ/9VJSoMM91O20PGB4ivHrG38q1xe5mQzrD6t5u4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z8rQXb4doZm6pmJlbN5cIaka5qDTgBcJUIrtSaBiuMVoEQ3F2z0sm7M5+GSwqmQh9
         MWyU/cJV6ZU7Wzw0Wxqd5t66DziNeA3KCfXs+caIbv3+IYpHXwL2KBOYEI7aMmB1sG
         1EOUEsTYwtVtq62mGC2Ttmw2HCeTUvldL93x6Q6Q=
Received: by mail-lj1-f178.google.com with SMTP id z5so2766533lji.10;
        Wed, 29 May 2019 07:57:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUnI8jboP7u6NtIXMNtvCeiOaMMVkLs3b8Qe+ZmPx4icZO5c4fs
        zmwEIirTwpHtK2wavNNk6yyhFoI765XUQbt0fbA=
X-Google-Smtp-Source: APXvYqzkAqGwLKzbKAnsKsG2Y7Ep/sgbV/2n7wYZZVclmQvLpywZUeB/D8r3hLefKeJGrJDwfAiDkd8IQ9GPjiSYc1E=
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr4214188lji.64.1559141855017;
 Wed, 29 May 2019 07:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br> <20190527022258.32748-3-matheus@castello.eng.br>
In-Reply-To: <20190527022258.32748-3-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 16:57:23 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdtsyY_GhniBAb0yV=HOhGx+x4xRPqNgdO+d0MDZRZ_7w@mail.gmail.com>
Message-ID: <CAJKOXPdtsyY_GhniBAb0yV=HOhGx+x4xRPqNgdO+d0MDZRZ_7w@mail.gmail.com>
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

One more comment. The datasheet for max17040 says that there is on
ALERT pin and ALERT bits in RCOMP register. Which device are you
using? If it turns out that max17040 does not support it, then the
driver and bindings should reflect this - interrupts should not be set
on max17040.

Best regards,
Krzysztof
