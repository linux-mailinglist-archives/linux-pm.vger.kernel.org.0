Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C350B57A2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 23:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfIQVfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 17:35:07 -0400
Received: from muru.com ([72.249.23.125]:33518 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfIQVfH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 17:35:07 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id ECD4180F6;
        Tue, 17 Sep 2019 21:35:37 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/3] cpcap charger and battery fixes
Date:   Tue, 17 Sep 2019 14:34:58 -0700
Message-Id: <20190917213501.16907-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Here are few fixes for cpcap charger and battery.

The first fix lowers the battery charge voltage to 4.2V from 4.35V, and
should probably applied to the -rc series. The other two can wait if
preferred.

Regards,

Tony


Pavel Machek (1):
  power: supply: cpcap-charger: Limit voltage to 4.2V for battery

Tony Lindgren (2):
  power: supply: cpcap-battery: Check voltage before orderly_poweroff
  power: supply: cpcap-charger: Improve battery detection

 drivers/power/supply/cpcap-battery.c | 9 ++++++---
 drivers/power/supply/cpcap-charger.c | 9 +++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.23.0
