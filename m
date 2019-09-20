Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9395B9176
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfITOP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 10:15:58 -0400
Received: from muru.com ([72.249.23.125]:33966 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfITOP6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 10:15:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5AD1980AA;
        Fri, 20 Sep 2019 14:16:29 +0000 (UTC)
Date:   Fri, 20 Sep 2019 07:15:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 3/3] power: supply: cpcap-charger: Adjust current based
 on charger interrupts
Message-ID: <20190920141554.GM5610@atomide.com>
References: <20190917215253.17880-1-tony@atomide.com>
 <20190917215253.17880-4-tony@atomide.com>
 <20190919093448.GE9644@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919093448.GE9644@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190919 09:35]:
> On Tue 2019-09-17 14:52:53, Tony Lindgren wrote:
> > When debugging why higher than 500 mA charge current does not work, I
> > noticed that we start getting lots of chrgcurr1 interrupts if we attempt
> > to charge at rates higher than the charger can provide.
> > 
> > We can take advantage of the chrgcurr1 interrupts for charger detection,
> > and retry charging at a lower rate if charging fails. When an acceptable
> > charge rate is found, the chrgcurr1 interrupts stop.
> 
> Do you still see these problems with "good" charger? (Wall one,
> capable of providing 2A)?

Yes, need to recheck again with the updated fix I posted.

> Note that 1A charging will decrease battery lifetime, and that phone
> definitely should not be charging with more than 500mA when charging
> from computer. I actually prefer the way it charges slowly in mainline...

It should still charge at 500mA when connected to a computer
because of different charger detection bits. Needs to be checked
again .though

> We'll eventually need a library or something; we don't want every
> driver to reinvent charging code..

Yeah currently implementing a charger takes weeks of work :)

Regards,

Tony

