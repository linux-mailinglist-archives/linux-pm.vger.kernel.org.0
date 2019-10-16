Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7CDA185
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfJPWaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:30:10 -0400
Received: from muru.com ([72.249.23.125]:37636 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfJPWaJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:30:09 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D60688107;
        Wed, 16 Oct 2019 22:30:43 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2 0/2] cpcap charger and battery fixes
Date:   Wed, 16 Oct 2019 15:30:03 -0700
Message-Id: <20191016223005.9246-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Here are few fixes for cpcap charger and battery. These can probably wait
for v5.5 if preferred that way and can be applied separate from the 4.2V
charger fix.

Regards,

Tony

Changes since v2:

- Drop the pointless test for latest->voltage >= 0 as noted by Pavel

- Allow poweroff to trigger at 3.2V and lower as suggested by Pavel

Changes since v1:

- Sent the updated 4.2V voltage fix separately

Tony Lindgren (2):
  power: supply: cpcap-battery: Check voltage before orderly_poweroff
  power: supply: cpcap-charger: Improve battery detection

 drivers/power/supply/cpcap-battery.c | 8 +++++---
 drivers/power/supply/cpcap-charger.c | 7 ++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.23.0
