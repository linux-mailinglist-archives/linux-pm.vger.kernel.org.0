Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29E10A20D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfKZQ1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 11:27:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38847 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfKZQ1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 11:27:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so17193346oid.5
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 08:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6LR021fH99skgKDKYfs0PkkT5wXbiUPObW4bLOkX30=;
        b=ClbqO7GTdjmmCB2G8q4zUCNUhuyiia1NgWfb0g90Z4mp4qBdikf8f8I5ebWlgqAWG7
         lV52JqRhQI8+IP8Dez1XsiBph86kKnli+73Ud+gDhK/GiFkoZ1AQRKl+gcR0b1HRkb2O
         G+La18f3cQobEKoztmB4PGgQiWpvBiSwvlo/wW9F5zqo4nVTpuOj7AalEspxY8G8CDVF
         r2Q9mXCdbQ3B2D/mqRpevNyAqgLo6IRMk/R7yIDAjH/Jm47XipEn+JlSG+2j7SItvi9u
         y/70cz/pCXLiG/5VL9hMYBBcgUpEcfyZciPQJDPQwqb/zAOMomOMLkQowIorKRKs9Z/w
         CGkg==
X-Gm-Message-State: APjAAAWvQN1LWZAup41FiXLPHCJ8EjHoZVuevlfQnb/niM40VpWgg9hq
        Oebu6n9n1ao4/9xxwx00AKq3n6YLNttGAwg7AfU=
X-Google-Smtp-Source: APXvYqwX0521n/C/toBmU/zTs22nRWIe1oZq8C9jDvbRdJViEUU7Pu8syjzxm0dGY+EDT2ZVP+WH8lNumDteEtil3Gs=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr2289677oig.68.1574785653103;
 Tue, 26 Nov 2019 08:27:33 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n>
 <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
 <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
 <alpine.DEB.2.21.1911251155440.2817@hp-x360n> <CAJZ5v0hMR8_i=oA1ovX0-xfa_w1x7nHhTwmmKRPu27ceFxpFow@mail.gmail.com>
 <alpine.DEB.2.21.1911251502490.13123@hp-x360n> <CAJZ5v0jR8OQVOniR++NJeDukDn9Bgp+DZtvmSCF_d0pH1LDr6w@mail.gmail.com>
 <alpine.DEB.2.21.1911260759220.6292@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911260759220.6292@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 17:27:21 +0100
Message-ID: <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com>
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

On Tue, Nov 26, 2019 at 5:15 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Tue, 26 Nov 2019, Rafael J. Wysocki wrote:
>
> > > BTW, I've got breaking it down to a science now:
>
> > > - Let the battery drain pretty well down (< ~80%)
> > > - Boot the kernel I wish to test, while still on battery
> > > - Intiate a suspend/resume, which will come back OK
> > > - Initiate another suspend
> > > - Plug in the charger. If I have my power meter in, I see it do the PD
> > >   negotiation (it'll start off at 20V/150mA, then it'll PD ramp up to
> > >   a full 2.5-2.75A @20v to charge the battery)
> > > - Try to resume. It'll be totally dead and I have to long-power-button
> > >   to get it back
>
> Huh. So ... I run bleeding edge and grab Linus' tip as it's pushed; I'd
> seen some changes to workqueues in last night's merge. Personally, I feel
> that if workqueues were AFU the kernel would be a hot mess, but at this
> point since there's one in the path of acpi_ec_flush_work() called from
> acpi_s2idle_sync() and I'm kinda desperate at this point for at least
> something to help fix this, I put your 2nd patch back in earnest (uncommented
> out acpi_ec_flush_work() from acpi_s2idle_sync()) and added a pair of
> WARN_ON(1)s (which should dump to pstore- or is that "BUG_ON()"?) around
> the spin_lock/unlock in acpi_ec_query_flushed().

OK, so just to double check if I understand you correctly, you are
running the Linus' tip with this patch on top

https://lore.kernel.org/linux-pm/alpine.DEB.2.21.1911220920500.24730@hp-x360n/T/#m199e175157c9cddf48fdee16681f6c2f0549a364

and with two extra WARN_ON(1) statements in acpi_ec_query_flushed()?
