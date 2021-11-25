Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BD45E083
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhKYS2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 13:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhKYS0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 13:26:42 -0500
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Nov 2021 10:14:22 PST
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [IPv6:2001:19f0:5:727:1e84:17da:7c52:5ab4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4027DC06179B;
        Thu, 25 Nov 2021 10:14:22 -0800 (PST)
Received: from kevinolos.kevinlocke.name (2600-6c67-5000-3d1b-acf4-78ed-e050-e54b.res6.spectrum.com [IPv6:2600:6c67:5000:3d1b:acf4:78ed:e050:e54b])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 1B6C828D37FA;
        Thu, 25 Nov 2021 18:04:34 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id DF4FB13003B1; Thu, 25 Nov 2021 11:04:32 -0700 (MST)
Date:   Thu, 25 Nov 2021 11:04:32 -0700
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ibm-acpi-devel] [PATCH 0/4] power: supply: add charge_behaviour
 property (force-discharge, inhibit-charge)
Message-ID: <YZ/QMNQIe04x/tkF@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-pm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211123232704.25394-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123232704.25394-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-11-24 at 00:27 +0100, Thomas Weißschuh wrote:
> this series adds support for the charge_behaviour property to the power
> subsystem and thinkpad_acpi driver.

Wonderful!  Thanks for working on this.

I can confirm inhibit-charge and force-discharge states work with
patch v2 on v5.16-rc2 on a T430 (2342-CTO) with BIOS G1ETC2WW (2.82 ),
EC G1HT36WW and a single battery.  Most behavior is as expected:

- With force-discharge, status becomes "Discharging" and energy_now
  drops over time while AC remains connected.
- With inhibit-charge, status becomes "Unknown" and energy_now is
  stable over time, even when not fully charged.
- With auto, status becomes "Charging" and energy_now rises over time.
- charge_behaviour takes precedence over
  charge_control_{start,end}_threshold: status remains
  Discharging/Unknown when below the start threshold, either due to
  discharge or threshold change.
- charge_behaviour is preserved over soft reboot.
- inhibit-charge/auto are preserved across battery removal and
  reinsertion.
- inhibit-charge/auto are preserved across s2ram (S3).
- With force-discharge, if the battery is removed, the machine
  immediately powers off.

Some behavior is a little surprising:

- charge_behaviour can not be set to force-discharge if AC is
  disconnected (EIO).  If charge_behaviour is force-discharge when AC
  is disconnected, it changes to auto, unlike inhibit-charge.
- charge_behavior force-discharge is not preserved across s2ram (S3),
  unlike inhibit-charge.
- charge_behaviour is not preserved across hard reset (unlike charge
  thresholds).  Interestingly, it appears that inhibit-charge is
  preserved across power-off (no charging is observed while powered
  off) but not power-on, even though it is preserved across soft
  reboot, as noted above.

I assume the behavior is under the control of the EC, so these aren't
criticisms of the patch.  Just some observations.

Tested-by: Kevin Locke <kevin@kevinlocke.name>

Thanks again,
Kevin
