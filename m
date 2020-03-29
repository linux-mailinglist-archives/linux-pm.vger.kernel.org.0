Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434F0196E73
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgC2QZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:25:51 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52672 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgC2QZv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:25:51 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2C81124982;
        Sun, 29 Mar 2020 18:17:02 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 2/9] power: supply: smb347-charger: Add delay before getting IRQSTAT
Date:   Sun, 29 Mar 2020 18:15:45 +0200
Message-Id: <20200329161552.215075-3-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This delay-fix is picked up from downstream driver,
we measured that 25 - 35 ms delay ensure that we get required data.

Tested on SMB347 on Nexus 7 2012. Otherwise IRQSTAT_E fails to provide
correct information.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index d102921b3ab2..f99026d81f2a 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -8,6 +8,7 @@
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
@@ -708,6 +709,9 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	bool handled = false;
 	int ret;
 
+	/* SMB347 it needs at least 20ms for setting IRQSTAT_E_*IN_UV_IRQ */
+	usleep_range(25000, 35000);
+
 	ret = regmap_read(smb->regmap, STAT_C, &stat_c);
 	if (ret < 0) {
 		dev_warn(smb->dev, "reading STAT_C failed\n");
-- 
2.25.0

