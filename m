Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3977F1C4748
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgEDTru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:47:50 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:4943 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgEDTrs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:48 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0d6Q5vzKc;
        Mon,  4 May 2020 21:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621665; bh=zqZch5CRr9vG4l7fwTEuCyzjtZ4uRNFWQY4JULm254Y=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=OYTK4tUCwQf3x2q+uUDM/U0F/s/8O4cMGyzT8nMqRgMOng/CM/qvm4sCOYeBhk8NA
         AGVsX4S0WcbEOHeEfnxxgTeXQhN1FghE0onTQe6o//sasvTUAIa0jQ4WZT8mUJYDI+
         QRbHIKnkU0AZsnAu/yzr8w4BG2YNEA0l+7/jYCCqBHct9YnO9mf9f0Dwg8j+KiRFvI
         w/SKQv6gZa7t+OINHCEMaM+ynDsg7mTxUJdyXEE1OCWoW1Nr40jxQvifMsxm+Dtzd7
         muTlS+dmyof9bc2RPXLRiGlUzT4XE7d4zkGB/q9PmCY22m9WST9vqubJycZosQPkIG
         Sc/QoRkWZPTFQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:45 +0200
Message-Id: <8dd5ede84b19ca24c0ee7fa00746923650070536.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 3/8] power: bq25890: update state on property read
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Edge interrupts from the charger may be lost or stuck in fault mode
since probe(). Check if something changed everytime userspace wants
some data.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 325fdd1b1d23..322d48d28fe5 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -387,6 +387,8 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
 	}
 }
 
+static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq);
+
 static int bq25890_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -397,6 +399,8 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 	int ret;
 
 	mutex_lock(&bq->lock);
+	/* update state in case we lost an interrupt */
+	__bq25890_handle_irq(bq);
 	state = bq->state;
 	do_adc_conv = !state.online && bq25890_is_adc_property(psp);
 	if (do_adc_conv)
-- 
2.20.1

