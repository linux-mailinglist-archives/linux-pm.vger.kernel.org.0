Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF88185DD2
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgCOPOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35621 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCOPOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id d5so17741879wrc.2;
        Sun, 15 Mar 2020 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kd7pvZkdhxqfRhkmXixEY9mGa6jMzVWdflnEm/bgK9Q=;
        b=R3+gKzwKuIigXkPbp2TuGXz2LSZ0TUoFUb0Dd+JOTx+fkQgRpjEG4tCzbdzLJZE5UO
         9PaWZwsKkeV0/SAexS5nKq05noDaibO3UboEdCBWPz5r9NFbJuDGpTFXXDKj34OMVoKV
         uZ7QYdArNbgODVggqcSDZIvX1xy0CNpRYm+XYV0AM3vq5rUCzZSklPZu9f1wokSXz8mj
         l27Lky2d3LshlHgo5c4fyz5nP3KKtcDzBaTI+oTdnTpV5bkseZYa1XClSsk8yBemzar+
         LLDyfkQR2QJUTiyKecl7tJcGV1/d/+YcflwovQBMI0A2CU3roci3f9NQwYrDthvGVGZc
         WYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kd7pvZkdhxqfRhkmXixEY9mGa6jMzVWdflnEm/bgK9Q=;
        b=IV5R5ZC4FfyRhk52bvFvdXPmHwbm5xEIwuN4pnrXpzTUS/qYmoghbTHcr1sbMAXvOH
         xmlOsLzJbGuJUWGPsriM/kenhongIl0eEFzhUNn68xKHFeEG2JRO63fg1V/uZHcvS2fm
         NUkv6/9GxtQGLgT0mREQXAX9+81oAMfGI0dXflXaE52iYvyENBH0KiNu6D8HuxHoIu9e
         LNmToc+PAOy/a9Z6Px4ReP3pdlTcpuWCL+lRQhqFtqvYEd6AKGxtoobEGhaJk2xaqP4k
         M36ZKvJjZYDAxObswpY4tqo74MIHvv04ljyaaashOLgGtA8w0RuATkBdkDRJ0e14ciJC
         xlmA==
X-Gm-Message-State: ANhLgQ0bfDnyWJKY/sam6TjyrZ6Yyjh22EY/K+WzgvDfHxZbwL5aPwWz
        shZWsjG5hz0ML3ipN9QJuzo=
X-Google-Smtp-Source: ADFU+vs/FiZYdm4c+CV3Ph+UKXhDch+CPOehl/ViKihfr+y13UTRxv3auMAg/LCtMyU/Azet7fbDCA==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr31269869wrv.5.1584285275739;
        Sun, 15 Mar 2020 08:14:35 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:35 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 03/15] power: supply: cpcap-battery: Fix battery low status reporting
Date:   Sun, 15 Mar 2020 18:11:54 +0300
Message-Id: <20200315151206.30909-3-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If we hit battery low once, we should stick on reporting it until the
charger is connected. This way low->counter_uah will be updated
properly, and that will allow us to get more accurate charge_full value.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 52f03a2662a5..8a58ad943960 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -421,11 +421,14 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
 {
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
+	static bool is_low;
 
-	if (state->current_ua && state->voltage <= 3300000)
-		return true;
+	if (state->current_ua > 0 && (state->voltage <= 3300000 || is_low))
+		is_low = true;
+	else
+		is_low = false;
 
-	return false;
+	return is_low;
 }
 
 static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
-- 
2.11.0

