Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7928DA1A5
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391962AbfJPWl2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:41:28 -0400
Received: from muru.com ([72.249.23.125]:37688 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfJPWl2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:41:28 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id F3FB78107;
        Wed, 16 Oct 2019 22:42:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv3 0/2] cpcap charger and battery changes to deal with dropped voltage
Date:   Wed, 16 Oct 2019 15:41:20 -0700
Message-Id: <20191016224122.10126-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Here are the changes for v5.5 merge window to optionally allow reconfiguring the
charge voltage if folks want to do that.

These depend on v5.3 + [PATCH] power: supply: cpcap-charger: Limit voltage to 4.2V
for battery merged into v5.4-rc1 so we can keep the 4.2V fix usable for earlier
kernels as needed.

Regards,

Tony


Changes since v2:

- Fix up typo for 4.1V spotted by Pavel

Changes since v1:

- Sent the 4.2V charger change separately as a fix

Tony Lindgren (2):
  power: supply: cpcap-battery: Fix handling of lowered charger voltage
  power: supply: cpcap-charger: Allow changing constant charge voltage

 drivers/power/supply/cpcap-battery.c | 85 +++++++++++++++++++++++++---
 drivers/power/supply/cpcap-charger.c | 83 +++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 7 deletions(-)

-- 
2.23.0
