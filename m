Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92835FFA52
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2019 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfKQOkS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Nov 2019 09:40:18 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.109]:43070 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfKQOkR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Nov 2019 09:40:17 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 7BD054092
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2019 08:15:46 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id WLL8i6TkXiJ43WLL8idc04; Sun, 17 Nov 2019 08:15:46 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bpq1Lr0RjA7GEI60Pxufk6S9EZ2BnHAO3RgT1P1A6D4=; b=z+6TWq6PHyySAdQT68R8gY2SBC
        cgiae4O+Jj7fkSjCoSjYL/zU2bRDJvET94TX9qWLZiCWIJOwkGrKGqmfDtGseRXWyY16jreqv+s3M
        ZOE6E8f3+pL4xw+cX0AV87IEwzQOUm/zwCfWv6HPlKEnjLKtQsmL/pOgJhWMoUNqwz6J8/sw2F7c2
        /QOHCYPshFZw0BRY3AHvBI71wJrBvcNO/T/xeSnV+tueCQIy+mV2JnPTSfIJoCpSIWnEzKcbTtU1w
        l059NoDE7evRgScVG/vQKhJEk6dms39NwpESgBIYFCZ+pmO3TlduIyb+4oRwhIWNVwTxcF9HDrHD/
        HWdJRFhg==;
Received: from [186.222.229.111] (port=47408 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iWLL6-001Ad4-W4; Sun, 17 Nov 2019 11:15:46 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v7 5/5] power: supply: max17040: Send uevent in SOC and status change
Date:   Sun, 17 Nov 2019 11:13:35 -0300
Message-Id: <20191117141335.23404-6-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191117141335.23404-1-matheus@castello.eng.br>
References: <20191117141335.23404-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 186.222.229.111
X-Source-L: No
X-Exim-ID: 1iWLL6-001Ad4-W4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [186.222.229.111]:47408
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 60
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Notify core through power_supply_changed() in case of changes in state
of charge and power supply status. This is useful for user-space to
efficiently update current battery level.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 3fc9e1c7b257..1f5afabdbabc 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -209,10 +209,19 @@ static void max17040_check_changes(struct i2c_client *client)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
+	int last_soc, last_status;

 	chip = container_of(work, struct max17040_chip, work.work);
+
+	/* store SOC and status to check changes */
+	last_soc = chip->soc;
+	last_status = chip->status;
 	max17040_check_changes(chip->client);

+	/* check changes and send uevent */
+	if (last_soc != chip->soc || last_status != chip->status)
+		power_supply_changed(chip->battery);
+
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
--
2.24.0.rc2

