Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7A82F0971
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAJTyt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:54:49 -0500
Received: from muru.com ([72.249.23.125]:42334 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbhAJTyt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:54:49 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 29DC580E4;
        Sun, 10 Jan 2021 19:54:08 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 00/15] Updates for cpcap charger and battery
Date:   Sun, 10 Jan 2021 21:53:48 +0200
Message-Id: <20210110195403.13758-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here's a series of patches to update cpcap charger and battery support
for showing capacity. I've reorganized and cleaned up the patches posted
earlier and simplified few things in the process compared to the earlier
patches. The first few patches contain minor fixes that can wait for the
merge window no problem.

The battery capacity is only available if charge_full is written via
sysfs based on calibration, and then a battery low or high value is
seen. This follows what we already have for n900.

Regards,

Tony


Arthur Demchenkov (4):
  power: supply: cpcap-battery: Add charge_full property
  power: supply: cpcap-battery: Keep track of state for capacity
    reporting
  power: supply: cpcap-battery: Implement capacity reporting
  power: supply: cpcap-battery: Add charge_now property

Pavel Machek (2):
  power: supply: cpcap-charger: Limiting charge current on Droid 4
  power: supply: cpcap-battery: Fix typo

Tony Lindgren (9):
  power: supply: cpcap-charger: Fix missing power_supply_put()
  power: supply: cpcap-battery: Fix missing power_supply_put()
  power: supply: cpcap-charger: Fix flakey reboot with charger connected
  power: supply: cpcap-charger: Make VBUS already provided debug only
  power: supply: cpcap-charger: Use standard enumeration
  power: supply: cpcap-charger: Drop internal state and use generic
    stats
  power: supply: cpcap-charger: Simplify things with enable and disable
  power: supply: cpcap-charger: Provide state updates for battery from
    charger
  power: supply: cpcap-battery: Use charger status for battery full
    detection

 drivers/power/supply/cpcap-battery.c | 178 ++++++++++++++++--
 drivers/power/supply/cpcap-charger.c | 259 +++++++++++++++++----------
 2 files changed, 329 insertions(+), 108 deletions(-)

-- 
2.30.0
