Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5135510CCCB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfK1QZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:25:14 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35149 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfK1QZO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:25:14 -0500
Received: by mail-ot1-f46.google.com with SMTP id o9so1533383ote.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 08:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbKcS5nX0OzcSGYavRtvBzlsW68ZVjtxgaajveQ8KOo=;
        b=WEB4BiBcWfq33hIqJWTs6Zp9oVIdu6x1+iKbXFo082bJllodMyrMAV9fjJ6Tvhgkuf
         9v6UY1+A2NixfxFjdOcN3cglThw0sx79Kuewl4bmdELOIdBgxbKaWVs1RcctPBSRcLXV
         AVPLWMzdMwZgKBk2cLUnIvUcIY2ZhQEQ/nAQnUrxENxy0d0H2BXyrLrJsO5tNjFqxDCj
         zhwsExORt2am7knjAZeJJO2KMmHm2gxakRJwPY7AD+q8MURKQmlL7Sz2MuPdqYaa6Uu2
         /lJTCBIlNjyxWCthH5zbn2RF+BBSsH67NQgW81yz1LvoduZqBNfUxhaowtFJeKhNM9F5
         wo2Q==
X-Gm-Message-State: APjAAAUv0ta313+vefaqbQ7VDKgfq+zDw0FKoHZqiF9r7OnkjFjoIljY
        WQkAXnuFjgC89pt4i2Pfky8VADZjmeB/ts8L+L0=
X-Google-Smtp-Source: APXvYqyf/CsS8OQxxHLhMjO6Mt3Mk7/ZMjU7jf4Oxl0siNGnLX/ktsUyKCOeXMN7jyRHyjBm+HO95aptG6PoMBYEi70=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr7606667otn.167.1574958313389;
 Thu, 28 Nov 2019 08:25:13 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com>
 <alpine.DEB.2.21.1911260833250.2714@hp-x360n> <12933162.9b7K5rSXZx@kreacher>
 <alpine.DEB.2.21.1911261102180.2714@hp-x360n> <CAJZ5v0jOmhe74rMLcMMNqtWZNuxrLPvjMsnQ3ka299VNbcSRtg@mail.gmail.com>
 <alpine.DEB.2.21.1911261542430.2523@hp-x360n> <alpine.DEB.2.21.1911261819510.2523@hp-x360n>
 <CAJZ5v0gY2ebW7X+PbqL-Sr4Xe0i3x9c=DCyFH3Q9g49kxY7iKA@mail.gmail.com> <alpine.DEB.2.21.1911271424160.2366@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911271424160.2366@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Nov 2019 17:25:01 +0100
Message-ID: <CAJZ5v0h1Ro75++4xuCznkx6GNYd+G5NpMGP96z1jdh=dm9uZbw@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 11:30 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> > > If all "ec_no_wakeup=1" actually does is silently ignore EC wakeup events,
> > > then I'll stick with it.
>
> > Yes, that's all it does.
>
> Thanks.
>
> BTW, I'm calling it on that patch- it's been working all day long. And with
> ec_no_wakeup=1 no spurious wakeups, either:
>
> ----
> $ fgrep "suspend e" /var/log/syslog
> ...
> Nov 26 19:36:46 hp-x360n kernel: [  995.519483] PM: suspend entry (s2idle)
> Nov 27 06:56:44 hp-x360n kernel: [41793.786663] PM: suspend exit
> ----
>
> Sadly I lost ~9% battery over that period due to "modern" suspend, but at least
> it's been cool the last few times I've taken it out of the bag. Wish I could
> find out what's left powered up, though.
>
> And finally, last questions about the EC:
>
> - Is it possible to query it once it's awakened the system to find out exactly why?

That's what the current code does, but it also processes everything
the EC wants it to process at that time in case there are real system
wakeup events hidden in that (which is the case on some systems).

> - Is it possible to have the EC mask/ignore certain of those reasons?

Yes, it is, at least in principle, but some extra information is
necessary for that, like for example which Notify() targets to ignore,
and that's rather system-specific.

BTW, it should be possible to enable dynamic debug in ec.c and collect
some extra output from it to see what the EC is doing, for example,
when spurious wakeups occur.

> Thanks for all your hard work,

YW

BTW2, I have a real (non-debug) patch for the $subject issue in the
works, will post it later today or tomorrow, most likely.
