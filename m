Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6D186F8B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgCPQC7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 12:02:59 -0400
Received: from muru.com ([72.249.23.125]:60608 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731618AbgCPQC7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 12:02:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A658F80AA;
        Mon, 16 Mar 2020 16:03:44 +0000 (UTC)
Date:   Mon, 16 Mar 2020 09:02:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Arthur D." <spinal.by@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>,
        sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 01/15] power: supply: cpcap-battery: Fix battery full
 status reporting
Message-ID: <20200316160255.GL37466@atomide.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315185857.GA4914@amd>
 <op.0hjf7fb5hxa7s4@supervisor.net28>
 <20200315215949.GK37466@atomide.com>
 <op.0hjs4kk2hxa7s4@supervisor.net28>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0hjs4kk2hxa7s4@supervisor.net28>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur D. <spinal.by@gmail.com> [200316 01:31]:
> Hi, Tony.
> 
> It seems like a misunderstanding here. There's no problem in detecting
> if the charging is in progress. The green led is switched off and
> the battery current sign is changed from "-" to "+" (which means
> that the battery is being discharged). So there's no need in additional
> checks. For cpcap-battery this situation seems like a battery stopped
> charging. And it doesn't matter if that was a user who disconnected
> the charger or it was done somewhere in a driver/firmware/hardware.
> 
> The problem is that the charging current cant get to the point <100 mA,
> not talking about <50 mA. And that's why I set the value of 112 mA for
> the end of charge current: to help the kernel to detect this plateau and
> to stop the calibration cycle, so the userspace can get all the battery
> parameters I mentioned in the previous mail.

OK I guess that's easy to change if we figure out something better :)
Maybe add some define for it like CPCAP_BATTERY_FULL_CHARGE_CURRENT or
similar?

> Please note, that the behaviour I mentioned was observed only when the
> conditions written in my last mail were met. The important one was:
> > 2) the display backlight is off
> 
> Because when I unlocked the display the charging current was able
> to go below 112 mA. Of course I couldn't rely on something like this:
> the user should stay with backlight on to have the battery calibrated.
> Think about it: waiting for the charging current to drop from 100 mA
> to 50 mA can take dozens of minutes (it depends on the age of battery -
> the older the battery the longer it will take), and the user should
> force somehow the device to not switch off the display hightlight
> until the battery is calibrated.
> 
> Of course it's unacceptable, so I decided to set the end of charge
> current limit to 112 mA. Which allows the user to just put the device
> on a table and to wait until it's fully charged without a need
> to interfere the charging process with some action from the user.

Yeah OK thanks.

Tony
