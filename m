Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083FD454CA5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhKQSAo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 13:00:44 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:55613 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239783AbhKQSAn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Nov 2021 13:00:43 -0500
Date:   Wed, 17 Nov 2021 18:57:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1637171860;
        bh=9R7AiZBy616DlRSyvvUAZa85pJwmHl/hFx0sLaYBnrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQRIr+rud2ZHtAmqjM3aJHv2sNaOGDKzwcHigcwdd7rHiRoIj6NJZXYSyCWcAfeFL
         LhYdH77hIeK8wY7vtuiCwEJ2FwFdjMFxDFrAo2mbKbumrL2zSi+dHCnbC/eYoQ0YVe
         jFjuInzlS0hyy59AX0VmJOE2riu0S0rV3O14fEU8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Thomas Koch <linrunner@gmx.net>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        linux-kernel@vger.kernel.org, bberg@redhat.com, hadess@hadess.net,
        markpearson@lenovo.com, nicolopiazzalunga@gmail.com,
        njoshi1@lenovo.com, smclt30p@gmail.com
Subject: Re: [PATCH 0/4] power: supply: add charge_behaviour property
 (force-discharge, inhibit-charge)
Message-ID: <d1bc62e9-a5da-4c23-b31f-8ba718faf4a3@t-8ch.de>
References: <20211113104225.141333-1-linux@weissschuh.net>
 <9cebba85-f399-a7aa-91f7-237852338dc5@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cebba85-f399-a7aa-91f7-237852338dc5@gmx.net>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-11-16 17:56+0100, Thomas Koch wrote:
> thank you very much for working on this. It is high time that we leave
> external kernel modules for ThinkPads behind us.
> 
> On 13.11.21 11:42, Thomas Weißschuh wrote:
> > Hi,
> > 
> > this series adds support for the charge_behaviour property to the power
> > subsystem and thinkpad_acpi driver.
> > 
> > As thinkpad_acpi has to use the 'struct power_supply' created by the generic
> > ACPI driver it has to rely on custom sysfs attributes instead of proper
> > power_supply properties to implement this property.
> > 
> > Patch 1: Adds the power_supply documentation and basic public API
> > Patch 2: Adds helpers to power_supply core to help drivers implement the
> >    charge_behaviour attribute
> > Patch 3: Adds support for force-discharge to thinkpad_acpi.
> > Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
> > 
> > Patch 3 and 4 are largely taken from other patches and adapted to the new API.
> > (Links are in the patch trailer)
> > 
> > Ognjen Galic, Nicolo' Piazzalunga, Thomas Koch:
> > 
> > Your S-o-b is on the original inhibit_charge and force_discharge patches.
> > I would like to add you as Co-developed-by but to do that it will also require
> > your S-o-b. Could you give your sign-offs for the new patches, so you can be
> > properly attributed?
> S-o-b/Co-developed-by/Tested-by is fine with me.
> 
> I tested your patches.
> 
> Hardware:
> 
> - ThinkPad X220, BAT0
> - ThinkPad T450s, BAT0+BAT1
> - ThinkPad X1C6, BAT0
> 
> Test Results:
> 
> 1. force-discharge
> 
> Everythings works as expected
> - Writing including disengaging w/ "auto" : OK
> - Reading: OK
> 
> - Battery discharging: OK
> - Disengaging with "auto": OK
> 
> 2. inhibit-charge
> 
> Works as expected:
> - Writing: OK
> 
> - Disengaging with "auto": OK
> 
> 
> Discrepancies:
> - Battery charge inhibited: BAT0 OK, BAT1 no effect e.g. continues charging
> - Reading: always returns "auto"

I tested it on a T460s with two batteries and there inhibit-charge works
fine for both batteries.
What does not work is setting force-discharge for both batteries at the same
time.
This makes somewhat sense as on a physical level probably only one of them can
be used at a time.

Mark Pearson: Could you confirm that this is the intended behaviour?

In my changes queued for v2 of the series[0] I added validation of the written
settings and an EIO is now reported if the settings were not applied, so this
should help userspace handle this situatoin.

The plan is to submit v2 after the first round of review for the core PM
changes.

[0] https://git.sr.ht/~t-8ch/linux/tree/charge-control
