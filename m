Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865D7445DF
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jul 2023 03:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjGABgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jun 2023 21:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGABgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2023 21:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95010C
        for <linux-pm@vger.kernel.org>; Fri, 30 Jun 2023 18:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D13A61807
        for <linux-pm@vger.kernel.org>; Sat,  1 Jul 2023 01:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31383C433C7;
        Sat,  1 Jul 2023 01:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688175382;
        bh=Rur7f3rOM68X18nbdyGzkd9VQL4TpuAsK8Bppn6ZG6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=II2Nf8QHjREegL2uClITdkGa6ec7zlo+TojT+tD1xZ51Y9q723SYeiSr4d/93JsnK
         HPYU4ZpzVn1n2hOFMA98uD5K9jTbiIRd76BSj9FJRSeson4MXAPdDmGID/vGHZJSsU
         U5K7JVveC/USGmoB3IC2gJjoGJrxo3I7wY/jlxhQTepzxEluIFarpMaJRaQ6x1CcUU
         QEDvkvvICr472dTNPox/iP8HNbACU6DxjIRgvN4zWHm0nf+hlSl1XO63HS2kpkSXGh
         FyREoP/KbISVsfRnO8owb99KJOBwpmz1ebibRMiI1SLNfJ0lccHg5bS9mQWIzGBDfi
         6qrNtvpmnnp5Q==
Date:   Fri, 30 Jun 2023 18:36:20 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Eduardo Valentin <eduval@amazon.com>
Subject: [PATCH 0/3] thermal: hook in with reboot and crash
Message-ID: <ZJ+DFLBjZl3x16rL@uf8f119305bce5e.ant.amazon.com>
References: <20230525211655.627415-1-evalenti@kernel.org>
 <fb558491-9906-fb3a-60c5-349cb4210695@linaro.org>
 <ZH5ve2KX/Y0DXQnE@uf8f119305bce5e.ant.amazon.com>
 <ZH5whRBkGCun3Gq+@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0gbwRNrjBOxGfFTNJ2meBU3fncBpeHZSCAjhFRYQ9VkaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gbwRNrjBOxGfFTNJ2meBU3fncBpeHZSCAjhFRYQ9VkaA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Rafael,

On Thu, Jun 29, 2023 at 09:07:36PM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Tue, Jun 6, 2023 at 1:32 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > On Mon, Jun 05, 2023 at 04:27:55PM -0700, Eduardo Valentin wrote:
> > >
> > >
> > >
> > > On Fri, May 26, 2023 at 10:27:39AM +0200, Daniel Lezcano wrote:
> > > >
> > > >
> > > >
> > > > Hi,
> > > >
> > > > On 25/05/2023 23:16, Eduardo Valentin wrote:
> > > > > From: Eduardo Valentin <eduval@amazon.com>
> > > > >
> > > > > Hello,
> > > > >
> > > > > This small series of changes teaches thermal core about
> > > > > reboot and crash callbacks. The intention is to have the core
> > > > > to get notified and the pass in the event to thermal governors
> > > > > that are willing to perform actions during reboot or crash events.
> > > > > The thermal workers will be teared down in the process too.
> > > >
> > > > What problem does it solve?
> > >
> > > This cover letter was not clear enough. In fact, the context for
> > > all patches I am sending now and will be sending in near future
> > > is when the thermal subsystem is configured to control temperature
> > > of a target device. The thermal subsystem is configured to have
> > > cooling devices that will act on the target system, and has
> > > input, temperature sensors, to have visibility to the target system
> > > temperature.  In this case, the problem is when the controlling system
> > > becomes unresponsive upon reboot or crash, therefore losing
> > > control of temperature of the target system. This series solves the
> > > problem by giving knowledge to the governors of such events, allowing
> > > the governors to have opportunity to act before the actual event happens.
> >
> >
> > Again, this is a different situation than a emergence shutdown due to
> > temperature/overheat on the typical application of the thermal subsystem.
> > Where it runs in the same system it controls the temperature of.
> >
> > Here we want to reduce the likelihood of loosing control of temperature of a target systems
> > upon events where the controlling system is unavailable.
> 
> So the use case for this seems to be a BMC running Linux that is
> responsible for the thermal control of a host system.

BMC is a great example here, yes. But not limited to it.

BMC is responsible of thermal control of not only host though,
but the entire server thermal, considering not only
host temperature sensor as inputs, but plenty of other sensing
in the motherboard, for instance.

The changes are not limited to BMC controlling a host temperature though.
Any system controlling a target device temperature will fit.

> 
> It kind of escapes me why you want a thermal governor in the BMC's
> kernel to be part of this.

Yeah, I understand the typical BMC design would have its control
in userland. But as I said this not necessarily only about BMCs
controlling host temperature.

Primary reason to have in kernel is reliability compared to a
userspace based control, avoiding downtime of the control,
having the control available and stable during the entire
life time of the controlling system, e.g from
early boot, and avoiding unnecessary down time of the control
due to application crashes. Sure the kernel can crash too :-),
that is why this patch was written in the first place, but
it is a more rare case.

Userspace may still be involved here where user wants to have,
for example a fixed override cooling state. But in that case
the user would need to disable the in kernel control and
take care of the cooling state and corner scenarios, like
crash and reboot.

I also do not see anything that would prevent a control
of the controlling system, like a BMC, be put in the kernel,
given all the abstractions needed, cooling devices, governor,
sensors, are available there. Mechanically and physically
the thermal zone is still something part of the hardware
where the controlling system, say a BMC, is responsible for.


-- 
All the best,
Eduardo Valentin
