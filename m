Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1418503
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 08:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfEIGAb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 02:00:31 -0400
Received: from shell.v3.sk ([90.176.6.54]:42741 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfEIGAb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 02:00:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7BEEA103F1D;
        Thu,  9 May 2019 08:00:25 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b9a4ApfXUWPC; Thu,  9 May 2019 08:00:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 24B8F103F83;
        Thu,  9 May 2019 08:00:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ca1YT6Fkg_LU; Thu,  9 May 2019 08:00:14 +0200 (CEST)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5DB71103F1D;
        Thu,  9 May 2019 08:00:13 +0200 (CEST)
Message-ID: <267d992479dcdf8c0425407e131f112ece53f5c6.camel@v3.sk>
Subject: Re: [PATCH v6 0/10] Add support for OLPC XO 1.75 Embedded Controller
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Date:   Thu, 09 May 2019 08:00:10 +0200
In-Reply-To: <CAHp75VcXteqg200aB6w_6ngR7=cj3S7HQOELOTV4rYUmCe+dLw@mail.gmail.com>
References: <20190424074353.458446-1-lkundrak@v3.sk>
         <CAHp75VcXteqg200aB6w_6ngR7=cj3S7HQOELOTV4rYUmCe+dLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-05-08 at 18:07 +0300, Andy Shevchenko wrote:
> On Wed, Apr 24, 2019 at 10:44 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Hello!
> > 
> > This is a sixth spin of the patch set that adds support for the Embedded
> > Controller on an OLPC XO 1.75 machine.
> > 
> > Compared to the previous version there are only some trivial-ish changes to
> > [06/10] and addition of Reviewd-by tags; as indicated in changelogs of
> > individual patches.
> > 
> > In my opinion the first seven patches are ready for merge as they are:
> > 
> >   [01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
> >   [02/10] Platform: OLPC: Remove an unused include
> >   [03/10] Platform: OLPC: Move EC-specific functionality out from
> >   [04/10] Platform: OLPC: Avoid a warning if the EC didn't
> >   [05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
> >   [06/10] Platform: OLPC: Add XO-1.75 EC driver
> >   [07/10] Platform: OLPC: Add a regulator for the DCON
> > 
> > The patch [08/10] relies on changes to the OLPC battery driver that have
> > recently landed in the power-supply tree (without them enabling
> > CONFIG_BATTERY_OLPC on ARM would break build):
> > 
> >   [08/10] power: supply: olpc_battery: Allow building the driver
> > 
> > Sebastian Reichel provided an signed tag of an immutable branch that has
> > the necessary bits and was merged into the power-supply tree for 5.2:
> > 
> >   git pull git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git psy-olpc-1.75-battery-signed
> > 
> > The patch [10/10] was split of from the rest because Russell King found the
> > patch [09/10] it depends on possibly objectionable. They should not be
> > applied without further input from Russell:
> > 
> >   [09/10] ARM: export arm_pm_restart
> >   [10/10] Platform: OLPC: Add restart support to XO-1.75 EC
> > 
> > Tested to work on an OLPC XO 1.75 and also tested not to break x86
> > support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> > unlikely this breaks it when XO 1 works.
> 
> Pushed first 8 to my review and testing queue, thanks!

Thank you.

Looking at kbuild bot errors, it seems I managed to somehow mess up
again. It is not true that just the [08/10] patch relies on the
psy-olpc-1.75-battery-signed branch of power-supply tree (see above);
in fact [03/10] also does on x86.

Would it be possible to include that branch in your testing as well? It
is going to be included in the power-supply pull for 5.2.

Also, it seems patches [09/10] and [10/10] landed in your queue; they
are not ready.

Lubo

