Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75EB103525
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 08:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfKTH00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 02:26:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfKTH00 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 02:26:26 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4309F22467;
        Wed, 20 Nov 2019 07:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574234785;
        bh=B31Fwc2V+ilL9KsAboJq4+XoNDuDD0hiPWmHvnrsTY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F/6DTKqHEdMnk1OiPvaTEyCTnQ5M9F84lRCGaxNvok2HxwYwwRnG8puDi+/X3SBUU
         JYqjRAiXyaZY+CeHDP+yjJVf93qTj8SKzqkWvPySSlSFT4IrIwKdFizpKiY4Ixy/a6
         WKfV6JZZbln0rNYSEKcICN77h69AY6NPjAytQKLU=
Received: by mail-lf1-f53.google.com with SMTP id l28so9816378lfj.1;
        Tue, 19 Nov 2019 23:26:25 -0800 (PST)
X-Gm-Message-State: APjAAAWWcMD6LObXVwmk98Yvcjtzjr0ICamYbi99WZREY2H+rXAPyrmu
        mcVqMPT1w/sV0yva/GFrKPMfwenLUvru9BRhOkI=
X-Google-Smtp-Source: APXvYqwhKuGEqtzb+23WzcOnSwZt9lRPmPCv1kYBfxT6IjGJZT5BLMP5x0vz5I7fdWikrU1kxY2BtM8Gp6+AtEhWrEc=
X-Received: by 2002:a05:6512:6f:: with SMTP id i15mr1506396lfo.30.1574234783455;
 Tue, 19 Nov 2019 23:26:23 -0800 (PST)
MIME-Version: 1.0
References: <1574213719-20766-1-git-send-email-krzk@kernel.org> <CAMuHMdWe3vBzO9Nw6PX+kn9RDO+3q4zYSiFDF=4rsqnSux-caw@mail.gmail.com>
In-Reply-To: <CAMuHMdWe3vBzO9Nw6PX+kn9RDO+3q4zYSiFDF=4rsqnSux-caw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 20 Nov 2019 15:26:12 +0800
X-Gmail-Original-Message-ID: <CAJKOXPe+Qmj57sUMOJdzin30CAKqBBEH93UuRCBnhybMGjOJYg@mail.gmail.com>
Message-ID: <CAJKOXPe+Qmj57sUMOJdzin30CAKqBBEH93UuRCBnhybMGjOJYg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: power: Rename back power_domain.txt
 bindings to fix references
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Nov 2019 at 15:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Wed, Nov 20, 2019 at 2:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > With split of power domain controller bindings to power-domain.yaml,
> > the consumer part was renamed to power-domain.txt breaking the
> > references.  Undo the renaming.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> One suggestion below...
>
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6953,7 +6953,8 @@ L:        linux-pm@vger.kernel.org
> >  S:     Supported
> >  F:     drivers/base/power/domain*.c
> >  F:     include/linux/pm_domain.h
> > -F:     Documentation/devicetree/bindings/power/power-domain*
> > +F:     Documentation/devicetree/bindings/power/power_domain.txt
> > +F:     Documentation/devicetree/bindings/power/power-domain.yaml
>
> Looks like scripts/get_maintainer.pl does handle the "?" wildcard, so
>
> +F:     Documentation/devicetree/bindings/power/power?domain*
>

Thanks! I'll send a v3. Shall I use @glider.be for your reported-by
email as well?

Best regards,
Krzysztof
