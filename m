Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79F146DB9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 17:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAWQDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 11:03:01 -0500
Received: from muru.com ([72.249.23.125]:52040 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWQDB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Jan 2020 11:03:01 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B7D5C810A;
        Thu, 23 Jan 2020 16:03:42 +0000 (UTC)
Date:   Thu, 23 Jan 2020 08:02:57 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, "Arthur D." <spinal.by@gmail.com>
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
Message-ID: <20200123160257.GX5885@atomide.com>
References: <20200119201124.29620-1-tony@atomide.com>
 <20200121095712.GC6934@amd>
 <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
 <20200121222547.GA17712@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121222547.GA17712@duo.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200121 22:26]:
> Hi!
> 
> > >> Get a rough battery charge estimate until we've seen a high or low
> > >> battery level. After that we can use the coulomb counter to calculate
> > >> the battery capacity.
> > >>
> > >> Note that I should probably update this to support ocv-capacity-table
> > >> before this makes sense to apply. With ocv-capacity-table we should be
> > >> able to estimate battery state as described in the documentation for
> > >> Documentation/devicetree/bindings/power/supply/battery.txt.
> > > 
> > > Maybe we should let userspace do that?
> > > 
> > > https://github.com/pavelmachek/libbattery
> > 
> > Unless this gets integrated in UPower, My point of view is that
> > userspace probably wants some uniform approach. Kernel interface
> > definitely is one uniform interface that would also get picked up by UPower.
> 
> I see that it is convenient to have it in kernel. I just assumed
> Sebastian would not take that, because it does not _need_ to be in
> kernel...

I think we should find a way where we can keep the existing kernel
interface as all the apps rely on that. If we allow userspace to
optionally set the estimated battery full and battery empty coulomb
counter values we should be all set.

For temperature compensation it seems that the ocv-capacity-table
is the way to go to describe the battery if the battery data is
unsuable or does not exist.

> And maybe it is easier in userspace, since userspace has access to
> persistent storage, so it can store detailed battery calibration
> parameters? (And Gnome/Mate even does something like that, see
> mate-power-statistics).

Agreed, at minimum the userspace should save estimated coulomb
counter full and empty values. After that calculations are trivial
as seen with this series.

> So... not my decision. Don't care too much either way. I have been
> doing this in userspace, but...
> 
> What I'd like to see is some kind of indication that "this attribute
> is not from hardware, kernel computed it for you" so clever userspace
> can ignore it/compute it in more advanced way.

Well we do have that via IIO already. Not sure if that is needed
for power supply.

Regards,

Tony
