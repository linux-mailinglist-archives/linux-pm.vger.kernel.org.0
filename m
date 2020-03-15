Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 666D7186024
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 22:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgCOV7x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 17:59:53 -0400
Received: from muru.com ([72.249.23.125]:60546 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgCOV7x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 17:59:53 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9734D81D5;
        Sun, 15 Mar 2020 22:00:38 +0000 (UTC)
Date:   Sun, 15 Mar 2020 14:59:49 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Arthur D." <spinal.by@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>,
        sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 01/15] power: supply: cpcap-battery: Fix battery full
 status reporting
Message-ID: <20200315215949.GK37466@atomide.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315185857.GA4914@amd>
 <op.0hjf7fb5hxa7s4@supervisor.net28>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0hjf7fb5hxa7s4@supervisor.net28>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur D. <spinal.by@gmail.com> [200315 20:51]:
> Now about the chosen limits. For some reason the charging is
> interrupted (and restarted after a while) when the following
> conditions are met:
> 1) the charging current is < 112 mA
> 2) the display backlight is off
> 
> This behaviour was observed in Maemo Leste with hildon-desktop
> running. I tested these patches for several days, so I picked up
> the parameters for optimal (from my point of view) work in practice
> taking into account the current "features" of Droid 4 drivers.
> 
> If we could somehow fix this behaviour (charging interruption),
> I'd reconsider the end of charge current value to be 50 mA.

Hmm well we do have two chargers, the usb charger and the
unknown inductive charger for the pins on the back.

It would be best to keep cpcap-battery.c independent of the
chargers to avoid depndencies as the chargers do usually start
charging briefly always when connected.

Maybe just adding something like below would be enough of a check:

static int
cpcap_battery_get_counter_rate(struct cpcap_battery_ddata *ddata,
			       int poll_time_ms);

And then based on the value being negative or positive you
would know if it's charging or not. I guess we could then
use this also for POWER_SUPPLY_PROP_CHARGE_NOW with poll_time_ms
value of 0. I think the charge counter is configure to poll
at 250 ms right now.

Regards,

Tony
