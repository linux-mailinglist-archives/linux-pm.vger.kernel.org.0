Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6693185DCF
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgCOPOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37302 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgCOPOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id 6so18060836wre.4;
        Sun, 15 Mar 2020 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05qXy//GL7EBGHN41xTmsALDVVzrAy8aFFqqDu1cw9g=;
        b=PiC2BcFiqeHwllVFc15FrrV9KZqXDRjERBN69qJQy4b3+ohcCElxGkjr/Mu2c7Ogrz
         3yfdP42f1Wlu8MQj4rOV6DYRDLFUTA8n1DjAJ7p4EeATsbkluUt1z2DDJfw89TZ0xIbe
         ojgoitqbNXhdGsypAwIQrlgbsPS2vRQ7dR+9g4G9C8AK1ywBjGED0fMivuE7C7heVAlV
         CFpNaIM3Zw/FrulvyNnn5CPpvblRvhulRwZT3zdcp341bZc8+tMu4h+MpAEuPrchrXjW
         IM9MfltR5ahDrkyqUdrAenj3HHCvpAFIG+Tx6yXoy88mbVeotSwqhn3bjDVqF8Q56aLc
         ebyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05qXy//GL7EBGHN41xTmsALDVVzrAy8aFFqqDu1cw9g=;
        b=tk8R8XtFoeGkovY+a9T4C79lKxwb+eaeCmGjkXsxu9W64xpA0mZ8gdChcwhMXiR6Vw
         o8IIwsucjlr6HJbxIbjRy0zOAd1n5aIRbRHLdtFKHYbI99yCCvnRGLY8L603Vo5DoYGq
         Mwb2vEcB/SQqL3tuojo1EfGMU6tmL3yFhd7R01cP4m+V24qSMf7HtEFb28/mwgROhW0h
         Vs8HUlMj1tcQpq2u1kxnaNTA2WZXlUUxRiECepb9AIwwRtpxgUP1th/EvVjK57aUCDon
         qfQPxi2sYApHBww09tWUt9S2zMidWqiswBpLslTeZoDnlU5ZQTo+X04gH6UFBUW8Hj0j
         crlQ==
X-Gm-Message-State: ANhLgQ2OcgSLZev56JGb3pAn+jjo7fPuGvDjeDiRaFo+WCHA0PufMYYw
        GJYy2+uDMqOzzT5Y7lY6N94z+xlhNc/92Q==
X-Google-Smtp-Source: ADFU+vsSj1tTt3gEgBPMl2oio7uHJGBcHx3+s2zeuZgPvvp6JSnFKctxTRC/xSfIVZ+pJgcTC3Et1A==
X-Received: by 2002:adf:8165:: with SMTP id 92mr6569995wrm.217.1584285274609;
        Sun, 15 Mar 2020 08:14:34 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:34 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 02/15] power: supply: cpcap-battery: Improve battery full status detection
Date:   Sun, 15 Mar 2020 18:11:53 +0300
Message-Id: <20200315151206.30909-2-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the battery status is detected as full for the charging current that
doesn't exceed 100 mA, it will then be reported as full for charging
currents in the range of 100-150 mA. This is needed because
charge_current value has a spread.

We don't use avg_current here because it can trigger wrong battery full
status on charger connected event.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 34a9dbcd1a23..52f03a2662a5 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -406,13 +406,16 @@ static int cpcap_battery_cc_get_avg_current(struct cpcap_battery_ddata *ddata)
 static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 {
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
+	static bool is_full;
 
 	if (state->voltage >=
 	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000) &&
-		state->current_ua > -100000)
-		return true;
+	    state->current_ua > (is_full ? -150000 : -100000))
+		is_full = true;
+	else
+		is_full = false;
 
-	return false;
+	return is_full;
 }
 
 static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
-- 
2.11.0

