Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B1110358D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 08:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfKTHrw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 02:47:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46474 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKTHrw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 02:47:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so21619697oie.13;
        Tue, 19 Nov 2019 23:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffMHHkKuM7aK5/Oq1kFH9EAsHvJDvPT92qTXM1nw77g=;
        b=tmv0VYaQ1Qk72wZHwuguvlm9BrxthyeLsJMqlGFMB0UhcrF5nKQ4XWvaOZg6niX5yf
         fgesfYkibb/Gu8IGgDOR6eGakyVr73u2GNBDVP+cTrxJ4iPipQXmkI1hqjdd++nNarQz
         /EgNioobM+qWF2JI+hnKMlf+pt2i/ni2RX54YBLDaMLwXaLM+Hoc9bsiMUZIAfPJq6Jf
         vdX8SaCdq4Tr4H052XSTMLuSAMDu/47HSyog/49KoIhJjfqCO5YtstBidK+r4H1IUX6z
         QvJoVZSTmBNr+hnLFCEJFn5wRpkZbKhA6r2auHNtri/2lof5YzPneoztlYPV332hPFNq
         7Vyg==
X-Gm-Message-State: APjAAAXWr28c0eFVJnPPy+I/SNBBJafnPqFfBJ2WK3CptvJC6sM5cCHQ
        GQxJVHpwGu73+ND65zGu+DmHvaPV0qPr3GwntJS7Ww==
X-Google-Smtp-Source: APXvYqzvF/0pYU1dCjuj4xbH2SazKwF0GZd4EOxeh2E7Y2CIjsuhNguE7QjizVM0W7bNc0dzXv4gUPkbpCILXWIXeH4=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr1488187oia.131.1574236069584;
 Tue, 19 Nov 2019 23:47:49 -0800 (PST)
MIME-Version: 1.0
References: <1574213719-20766-1-git-send-email-krzk@kernel.org>
 <CAMuHMdWe3vBzO9Nw6PX+kn9RDO+3q4zYSiFDF=4rsqnSux-caw@mail.gmail.com> <CAJKOXPe+Qmj57sUMOJdzin30CAKqBBEH93UuRCBnhybMGjOJYg@mail.gmail.com>
In-Reply-To: <CAJKOXPe+Qmj57sUMOJdzin30CAKqBBEH93UuRCBnhybMGjOJYg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Nov 2019 08:47:38 +0100
Message-ID: <CAMuHMdVcHQikSLFFZVUUbbWg8UWg+FX24i3sRACW4Kc9Zo3PtQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: power: Rename back power_domain.txt
 bindings to fix references
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

Hi Krzysztof,

On Wed, Nov 20, 2019 at 8:26 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, 20 Nov 2019 at 15:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Nov 20, 2019 at 2:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > With split of power domain controller bindings to power-domain.yaml,
> > > the consumer part was renamed to power-domain.txt breaking the
> > > references.  Undo the renaming.
> > >
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > One suggestion below...
> >
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6953,7 +6953,8 @@ L:        linux-pm@vger.kernel.org
> > >  S:     Supported
> > >  F:     drivers/base/power/domain*.c
> > >  F:     include/linux/pm_domain.h
> > > -F:     Documentation/devicetree/bindings/power/power-domain*
> > > +F:     Documentation/devicetree/bindings/power/power_domain.txt
> > > +F:     Documentation/devicetree/bindings/power/power-domain.yaml
> >
> > Looks like scripts/get_maintainer.pl does handle the "?" wildcard, so
> >
> > +F:     Documentation/devicetree/bindings/power/power?domain*
> >
>
> Thanks! I'll send a v3. Shall I use @glider.be for your reported-by
> email as well?

Yes please. That makes things consistent.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
