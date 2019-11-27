Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4710ABC4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 09:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfK0Ib2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 03:31:28 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35647 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0Ib1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 03:31:27 -0500
Received: by mail-oi1-f173.google.com with SMTP id k196so2976731oib.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 00:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JflAYgH18LGpyCuInG2JHUoQW9JnvUIZaMYidLrqwpI=;
        b=owsL3lUkbPU7Y58ljNmn2RUdo2hiwbUcbpuC6ZUPZLUXzUfdPF2DoCBffxUXzNVzn5
         ycGys7KlfiuqSK5XypGRK8caFAvmmJ41yuKqevidlt2mi2U66F9BghRMy736WvrYvzJP
         wpLDaDUfQhQq/QkPq3jXMO1Tm/glUnJZMzqiJ/CTLrIQme6M6L3jpSIFNwzWRON24WCk
         7lyEQyCB5q4h/YAA8vCaC9rsy31CxjVUDIJAgGsJ4Wa2bW/nlLTg7hcE1y6+ZrKTOm4W
         FVeDLdc2z2YcX+IJpWEmXJC3mbDYKeoAuMTw4tR94hGh/Ck51OVDrKotfvIPDMyBEYlA
         RfDw==
X-Gm-Message-State: APjAAAX2ulebOGi900GOUOVpLsnGtvTBl5RfVJTeFyH7oiMCnPUl7qV3
        3rb9WQ1jN+dhXHIVo51vDEJ6QP4t0BdjD/s8pEY=
X-Google-Smtp-Source: APXvYqy/Q9sYRCLynazZz3nToevvj7G4XlaYjai6/wBo45t8jwBjhWjVEgOE7k3eCFupORXz2X6OrmNeJ+Lt03L6ks8=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr3114446oih.57.1574843487000;
 Wed, 27 Nov 2019 00:31:27 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com>
 <alpine.DEB.2.21.1911260833250.2714@hp-x360n> <12933162.9b7K5rSXZx@kreacher>
 <alpine.DEB.2.21.1911261102180.2714@hp-x360n> <CAJZ5v0jOmhe74rMLcMMNqtWZNuxrLPvjMsnQ3ka299VNbcSRtg@mail.gmail.com>
 <alpine.DEB.2.21.1911261542430.2523@hp-x360n> <alpine.DEB.2.21.1911261819510.2523@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911261819510.2523@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Nov 2019 09:31:15 +0100
Message-ID: <CAJZ5v0gY2ebW7X+PbqL-Sr4Xe0i3x9c=DCyFH3Q9g49kxY7iKA@mail.gmail.com>
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

On Wed, Nov 27, 2019 at 3:35 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Tue, 26 Nov 2019, Kenneth R. Crudup wrote:
>
> > So there were some 5 times where my laptop spontaneously (I'll bet it was
> > that damned accelerometer) woke up, sometimes for minutes at at time, all
> > the while in my laptop bag.
> ...
> > But the great news about this is this maybe explains why I'll try and resume
> > after being mobile; whatever awakening we used to do wouldn't be handled
> > (again, guessing :)) and we'd freeze up.
>
> So I'd just realized something- when you'd first pushed the series of commits
> changing the S2idle flow, I'd sent an E-mail about some issues I'd had:
>
> ----
> Date: Wed, 18 Sep 2019 18:05:53
> From: Kenneth R. Crudup <kenny@panix.com>
> To: rafael.j.wysocki@intel.com
> Cc: linux-pm@vger.kernel.org
> Message-ID: <alpine.DEB.2.21.1909181742470.2771@hp-x360n>
> Subject: Help me help you debug what seems to be an EC resume issue
> ...
> >>> Before these commits, I used to set "acpi.ec_no_wakeup=1" because the
> >>> orientation sensor (at least, and probably other things) would wake up
> >>> the laptop (then immediately suspend), which I'm sure was using up
> >>> battery while I'm just walking around.
> >>> I've turned off "ec_no_wakeup" for testing and the good news is the
> >>> orientation sensor doesn't cause the laptop to draw more power when shaking it.
> ----
>
> Whoops- I guess in the face of everything we now know, that was indeed a
> bug and not a feature, because I'd also posted:
>
> >>>  Randomly, if left suspended, nothing other than a hard power off will get
> >>>  it back (and I can't be sure, but I think current consumption can be normal
> >>>  when it suspends, but this seems to only happen if I've unplugged the
> >>>  charger after suspending (so no power meter))
>
> So now we know.
>
> So, now that apparently (fingers still crossed, but so far, so very good)
> you've squashed that resume bug, do I have any recourse about this thing
> waking up for just by staring at it very hard other than "ec_no_wakeup=1"?
>
> Personally I don't mind at all having the keyboard being the only thing
> that'll take the laptop out of suspend, and the only reason I was looking
> for not having to modify the EC operation was 'cause I thought having that
> set meant we'd short-circuited some other s2idle optimization, and I'm
> constantly trying to minimize s2idle power consumption.
>
> If all "ec_no_wakeup=1" actually does is silently ignore EC wakeup events,
> then I'll stick with it.

Yes, that's all it does.
