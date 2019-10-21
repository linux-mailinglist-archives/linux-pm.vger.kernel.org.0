Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E10FDEFA1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJUOc0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 21 Oct 2019 10:32:26 -0400
Received: from muru.com ([72.249.23.125]:38404 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfJUOc0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 10:32:26 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CC39E810A;
        Mon, 21 Oct 2019 14:33:00 +0000 (UTC)
Date:   Mon, 21 Oct 2019 07:32:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCHv2] power: supply: cpcap-charger: Limit voltage to 4.2V
 for battery
Message-ID: <20191021143223.GU5610@atomide.com>
References: <20191016221817.8501-1-tony@atomide.com>
 <20191020203516.sp2vafrvb2pi3hp6@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191020203516.sp2vafrvb2pi3hp6@earth.universe>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [191020 20:35]:
> Hi Tony,
> 
> On Wed, Oct 16, 2019 at 03:18:17PM -0700, Tony Lindgren wrote:
> > There have been some cases of droid4 battery bulging that seem to be
> > related to being left connected to the charger for several weeks.
> > 
> > It is suspected that the 4.35V charge voltage configured for the battery
> > is too much in the long run, so lets limit the charge voltage to 4.2V.
> > It could also be that the batteries are just getting old.
> > 
> > We don't really want to just change the charge voltage to 4.2V as Android
> > may have charged the battery to 4.35V as pointed out by Pavel Machek.
> > 
> > To add checks for battery voltage, the driver needs to understand the
> > voltage it's charging at, and also needs to better understand it's
> > charger state. Right now it only understands connect and disconnect,
> > while now we need to know also a connected state but not charging.
> > 
> > So let's add better charger state handling with help of chrgcurr2 interrupt
> > for detecting charge full and retry, and add a check for battery voltage
> > before we start charging. And then we finally can lower the charge voltage
> > to 4.2V.
> > 
> > Note that we've been using the same register values as the Android distros
> > on droid4, so it is suspected that the same problem also exists in Android.
> > 
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Reported-by: Merlijn Wajer <merlijn@wizzup.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > If this looks OK, I would appreciate an immutable branch against v5.4-rc1
> > with just this patch in it for merge conflicts with v5.5 dts changes.
> 
> Thanks, I queued this to power-supply's for-next branch using the following
> signed immutable branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tag/?h=psy-cpcap-charge-volt-limit-signed

Thanks and sorry about that sparse issue it caused.

Regards,

Tony

