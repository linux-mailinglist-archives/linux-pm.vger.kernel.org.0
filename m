Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1497F2AD06
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfE0CqS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 May 2019 22:46:18 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.48]:35364 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbfE0CqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 May 2019 22:46:18 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 5A2F1E93
        for <linux-pm@vger.kernel.org>; Sun, 26 May 2019 21:23:17 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id V5IDhcT0ydnCeV5IDhHjOZ; Sun, 26 May 2019 21:23:17 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wcUEqwCmSzTwTOScs99jj/v1rr1UHqi6aLYmirJnCNA=; b=c3cE4r+kv5BtL26BIf7GnVQFcK
        8kNVtSVceNHPtN4Hf4vzCRKNOEU3r/xPt58ZvlYEUh4ztGzZkjpLiLPMNXXf14P7u/KkcX7yfxIum
        oJBEQMDjNv+Cpisfx3z21lM0M2XKJW14IYAkEIperIiQUqxO0ehLY4jAvVrJLTl96XLaGIJ35XgDZ
        rfUE/s19hh4LmGWN5uit5jB3NEhg5BTXmb7m+iiTIjq4M0MDU7+nAHOwynTo8vTHvSgy23HhGKetY
        xmVoVYNJhRwqCpTiPEaD/nVST+LVFUfKEv/Uga/Tqc9eTueYoV+RyihuLb4PPKlos4r15bgrgl6h5
        yJfSskAA==;
Received: from [177.34.20.96] (port=57660 helo=castello.castello.in)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hV5IC-003JNX-Ip; Sun, 26 May 2019 23:23:16 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 4/5] power: supply: max17040: Clear ALRT bit when the SOC are above threshold
Date:   Sun, 26 May 2019 23:22:57 -0300
Message-Id: <20190527022258.32748-5-matheus@castello.eng.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527022258.32748-1-matheus@castello.eng.br>
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hV5IC-003JNX-Ip
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello.in) [177.34.20.96]:57660
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 59
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to not generate duplicate interrupts we clear the ALRT bit when
the SOC is in a state that shows that the battery is charged above the set
threshold for the SOC low level alert.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 2f4851608cfe..61e6fcfea8a1 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -48,6 +48,7 @@ struct max17040_chip {
 	int status;
 	/* Low alert threshold from 32% to 1% of the State of Charge */
 	u32 low_soc_alert_threshold;
+	int alert_bit;
 };

 static int max17040_get_property(struct power_supply *psy,
@@ -107,6 +108,7 @@ static void max17040_reset(struct i2c_client *client)
 static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
 	u32 level)
 {
+	struct max17040_chip *chip = i2c_get_clientdata(client);
 	int ret;
 	u16 data;

@@ -118,6 +120,7 @@ static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
 		data &= MAX17040_ATHD_MASK;
 		data |= level;
 		max17040_write_reg(client, MAX17040_RCOMP, data);
+		chip->alert_bit = 0;
 		ret = 0;
 	} else {
 		ret = -EINVAL;
@@ -144,6 +147,11 @@ static void max17040_get_soc(struct i2c_client *client)
 	soc = max17040_read_reg(client, MAX17040_SOC);

 	chip->soc = (soc >> 8);
+
+	/* check SOC level to clear ALRT bit */
+	if (chip->soc > chip->low_soc_alert_threshold && chip->alert_bit)
+		max17040_set_low_soc_threshold_alert(client,
+			chip->low_soc_alert_threshold);
 }

 static void max17040_get_version(struct i2c_client *client)
@@ -229,6 +237,9 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
 	/* send uevent */
 	power_supply_changed(chip->battery);

+	/* ALRT bit is seted */
+	chip->alert_bit = 1;
+
 	return IRQ_HANDLED;
 }

--
2.20.1

