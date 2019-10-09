Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77567D1A1E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfJIUw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 16:52:57 -0400
Received: from muru.com ([72.249.23.125]:36414 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIUw4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 16:52:56 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4B7628140;
        Wed,  9 Oct 2019 20:53:30 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2 0/2] cpcap charger and battery fixes
Date:   Wed,  9 Oct 2019 13:52:50 -0700
Message-Id: <20191009205252.9510-1-tony@atomide.com>
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

Changes since v1:

- Sent the updated 4.2V voltage fix separately

Tony Lindgren (2):
  power: supply: cpcap-battery: Check voltage before orderly_poweroff
  power: supply: cpcap-charger: Improve battery detection

 drivers/power/supply/cpcap-battery.c | 9 ++++++---
 drivers/power/supply/cpcap-charger.c | 7 ++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.23.0
