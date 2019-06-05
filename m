Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DD35C3F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfFEMEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 08:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEMEO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 08:04:14 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B21420874;
        Wed,  5 Jun 2019 12:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559736253;
        bh=Q4I3OkixRElnCphLLigiroJyKLLP7sxM9Ti74vtXU9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lNzKx7eu7ovbPkGHOGYaq9WLcs1+7RfPwD5bkpFJrfpIDl7nN3r9gmIDwNsAQkjkI
         7JWUfJiz1PBiG9GhgEn/xpFjzd3Ova3+1/2rQS3O+o8sTZMD3Iyl/mpeKlRetMPCPA
         RdfM6dDBePzxoa2bip5qri3s7nntbwymfpkoPZA0=
Received: by mail-lj1-f175.google.com with SMTP id j24so22910015ljg.1;
        Wed, 05 Jun 2019 05:04:13 -0700 (PDT)
X-Gm-Message-State: APjAAAW/Ny556OIjFGPcUTVy/L97s2y6uD6fww+pB6Df0s8iYOQ5QJWK
        KI5pjFPWt/1+xx5LMcXwuCvTANX58FSu2nI/qNE=
X-Google-Smtp-Source: APXvYqw69BGxAUXlLNZiQohe1mQKEk1/sUuI61aHpBWprCisadKCJZLOINlyBJyK7mSKiYiH+wU6moSJ+FfKB5EV0vU=
X-Received: by 2002:a2e:424c:: with SMTP id p73mr3438602lja.216.1559736251748;
 Wed, 05 Jun 2019 05:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br> <20190527022258.32748-3-matheus@castello.eng.br>
 <CAJKOXPdtsyY_GhniBAb0yV=HOhGx+x4xRPqNgdO+d0MDZRZ_7w@mail.gmail.com> <71c4f6b6-fbbb-14ba-0cf0-2377498fdfbc@castello.eng.br>
In-Reply-To: <71c4f6b6-fbbb-14ba-0cf0-2377498fdfbc@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Jun 2019 14:04:00 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdoip-pc=qGxaxV_FAV8n7taXHuP59ve=YAMi-QibVyfQ@mail.gmail.com>
Message-ID: <CAJKOXPdoip-pc=qGxaxV_FAV8n7taXHuP59ve=YAMi-QibVyfQ@mail.gmail.com>
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

On Sun, 2 Jun 2019 at 23:42, Matheus Castello <matheus@castello.eng.br> wrote:
>
> > On Mon, 27 May 2019 at 04:45, Matheus Castello <matheus@castello.eng.br> wrote:
> >>
> >> For configure low level state of charge threshold alert signaled from
> >> max17040 we add "maxim,alert-low-soc-level" property.
> >>
> >> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> >> ---
> >>   .../power/supply/max17040_battery.txt         | 28 +++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> new file mode 100644
> >> index 000000000000..a13e8d50ff7b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> >> @@ -0,0 +1,28 @@
> >> +max17040_battery
> >> +~~~~~~~~~~~~~~~~
> >> +
> >> +Required properties :
> >> + - compatible : "maxim,max17040" or "maxim,max77836-battery"
> >
> > One more comment. The datasheet for max17040 says that there is on
> > ALERT pin and ALERT bits in RCOMP register. Which device are you
> > using? If it turns out that max17040 does not support it, then the
> > driver and bindings should reflect this - interrupts should not be set
> > on max17040.
> >
>
> Yes you are right, max17040 have no ALERT pin. I am using max17043. Let
> me know what you think would be best, put a note about it in the
> description, add a compatibles like "maxim,max17043" and
> "maxim,max17044"? What do you think?

Usually in such case driver should behave differently for different
devices. This difference is chosen by compatible. Since there is
already max77836 compatible - which has the ALERT pin (probably it
just includes 17043 fuel gauge) - you can customize it. No need for
new compatible, unless it stops working on max77836...

Anyway, configuring interrupts on max17040 would be probably harmless
but still it is not really correct. The registers should not be
touched in such case.

Best regards,
Krzysztof
