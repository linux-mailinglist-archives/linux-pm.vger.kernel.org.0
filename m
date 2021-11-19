Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9A145761B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 18:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhKSSBA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhKSSA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 13:00:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A644DC061574
        for <linux-pm@vger.kernel.org>; Fri, 19 Nov 2021 09:57:57 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c32so46967520lfv.4
        for <linux-pm@vger.kernel.org>; Fri, 19 Nov 2021 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74ddysQWlFD4zT5G6tuW4b+jVpIQ15CZsk8lP5EA6RQ=;
        b=vYGhR+TskGCW8Z+0AwEfrnWuxFpBz5KNEqr8RW77rWPOlYqsU5AHoXQ1h5PGRtRk5X
         o//BsDojZzjnfbXZnezK/YdCzi9oiZfQ8sKs5uAzxDLXH63q8m3OvvhZERXVf8PBAMPn
         1UHpVB3q38cIOLlcQrOmipoKAJeObGviZdlB6y7kEz0pYX3y+QQOpfcuw4FKozH8oBil
         Qbfw9/7ZCeJS3O+K5W/8XHbaTBUyqKOksWTkYfyyYJjG9VDZr00CyU/wlsjuO9xQrWI3
         Y68Oun3XmTtF7r8FLeC+WYo4ImNwHA3S9c0E89nH9d56vY+HRgRsiIS1PYJb0f6NUztK
         lXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74ddysQWlFD4zT5G6tuW4b+jVpIQ15CZsk8lP5EA6RQ=;
        b=WmjQjmhzu9/UPfZyHpSDlNH10CTSr4vmQE4ULObQ56GozbhctKNU53oAQh2jtAMVd+
         +vvYRCDQZzs4WiEeGLPh2v1oGy0oYiX/naCoPlEeCsLbghXNohkxpGZUUyQeqspELFE9
         x05yagPIJv2OaEq1MKbGkpURkHTeuJLtcPksVFzKTZY4CwQBY6BNkPdYovJ/c0qzu53A
         Pq8aW8/FkguzFupfbDxiwE+BCfx9cb2oRMQRhgZunNkBk7o3tGr/Acmpl/+CQ+zEXWQ0
         QKIBRj64WK2zBLAuXt3VekLHzy9oGFmmBAJqqPgmDv/oq0VRbp2TwH/mDT1SaTMMdxPp
         ogmw==
X-Gm-Message-State: AOAM532/46XUk8RphoY3cROwVEEqot1NlSUDZybfDnedzKAnjtffsWSy
        9Giy75r3nTPafWc2IMlL7czQweFVkI5pEg==
X-Google-Smtp-Source: ABdhPJxE7b+J/utmW1QtRMXJ1iX45lTubxgcZ9yFK0MOQKfC3cfZCntuU6kl0zkbaeijrTl5ExGG3Q==
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr35136216lfu.581.1637344675758;
        Fri, 19 Nov 2021 09:57:55 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.gmail.com with ESMTPSA id q6sm40226ljc.117.2021.11.19.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:57:55 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Quentin Schulz <foss@0leil.net>
Cc:     Evgeny Boger <boger@wirenboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: [PATCH] power: supply: axp20x_battery: set charging voltage via DT
Date:   Fri, 19 Nov 2021 20:57:40 +0300
Message-Id: <20211119175740.405446-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver should use maximum constant charge voltage property
from battery description provided by power supply core by default
instead of fixed 4.2V. This value can be later changed at runtime.

The battery description is normally set via device tree, as described
in Documentation/devicetree/bindings/power/supply/battery.yaml

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 drivers/power/supply/axp20x_battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 18a9db0df4b1..83c5ffa24bd1 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -617,6 +617,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
 		int vmin = info.voltage_min_design_uv;
 		int ccc = info.constant_charge_current_max_ua;
+		int vcv = info.constant_charge_voltage_max_uv;
+
+		if (vcv > 0 && axp20x_batt->data->set_max_voltage(axp20x_batt,
+								  vcv))
+			dev_err(&pdev->dev,
+				"couldn't set charge constant voltage from DT");
 
 		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
 							      vmin))
-- 
2.25.1

