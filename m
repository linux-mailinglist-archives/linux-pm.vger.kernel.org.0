Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CFEF54B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 07:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfKEGDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 01:03:01 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.87]:46065 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730520AbfKEGDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 01:03:01 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id B2D4811B3F
        for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2019 23:42:39 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id Rrbzi7ltwVUVYRrbzihrkV; Mon, 04 Nov 2019 23:42:39 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NXoTDm5tilUy+3fiCn1QLdQDuJ4WM4+qUq84t9usS4k=; b=y0g1VKoYKEdO/9b5CptUIGjYdl
        umbUcAqMZWmxgEhDq4Ar0JYjUCfRTD1FnDKvbP5uFsGSVn1HuquS/X+qSnYnCBXJWx/0DEEGZhcth
        8MifgPRm+PRuRiVH8XqvFjJ9lHWcIv+DgFrzhqx7gdUpfqSIGY/JvFmwWQ21Z+8NYXa0abAMJx635
        XGRLXX/1UHKC1Ih7q3pYk4d7b1FhWFKIhUxzIW/YWQ5urr55TrEdJmkR/XqEA8055uBTqAvAuRnV+
        FExZxxefngQV3WKSmN/tkWbZNtHeZ5nXM9k9TrzY5I6fwqoVmBb+G0AYg+vP5YiTlISgu+nwZpqLY
        9fdEeBaQ==;
Received: from [191.31.196.28] (port=37450 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iRrby-002sjK-Uv; Tue, 05 Nov 2019 02:42:39 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v5 5/5] power: supply: max17040: Send uevent in SOC and status change
Date:   Tue,  5 Nov 2019 02:42:18 -0300
Message-Id: <20191105054218.29826-6-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191105054218.29826-1-matheus@castello.eng.br>
References: <20191105015827.GA332@bogus>
 <20191105054218.29826-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.28
X-Source-L: No
X-Exim-ID: 1iRrby-002sjK-Uv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.196.28]:37450
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 73
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
index c48a691cbd7b..d7405650cc38 100644
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

