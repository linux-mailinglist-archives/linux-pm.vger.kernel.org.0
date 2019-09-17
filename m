Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E6B57CE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 23:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfIQVxP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 17:53:15 -0400
Received: from muru.com ([72.249.23.125]:33556 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfIQVxP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 17:53:15 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8D38380F6;
        Tue, 17 Sep 2019 21:53:46 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/3] cpcap charger and battery changes to deal with dropped voltage
Date:   Tue, 17 Sep 2019 14:52:50 -0700
Message-Id: <20190917215253.17880-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

With lowered charge voltage fixes in set "[PATCH 0/3] cpcap charger and
battery fixes", the first two patches deal with the lower voltage using
POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE and make it configurable.

The third patch makes charging work for higher rates by lowering the
charge current basedon chrgcurr1 interrupts.

As far as I'm concerned, all these can easily wait for v5.5 merge window.

Regards,

Tony


Tony Lindgren (3):
  power: supply: cpcap-battery: Fix handling of lowered charger voltage
  power: supply: cpcap-charger: Allow changing constant charge voltage
  power: supply: cpcap-charger: Adjust current based on charger
    interrupts

 drivers/power/supply/cpcap-battery.c |  86 +++++++++++-
 drivers/power/supply/cpcap-charger.c | 188 ++++++++++++++++++++++++---
 2 files changed, 250 insertions(+), 24 deletions(-)

-- 
2.23.0
