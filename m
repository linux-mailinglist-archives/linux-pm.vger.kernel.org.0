Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D681E185DDF
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgCOPOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46961 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgCOPOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id w16so1638017wrv.13;
        Sun, 15 Mar 2020 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6wXAlJbWmH6uTZMni2idP4m1tsWk4quBIdgxNLZSbM=;
        b=Z50RIKP1iXqzNSYIITq4BMB+5uKGR3lvTTHqorU1KIkxaRXFxkwRuC1oh+llcvP+Yo
         4sES990ZN1hHkjpT1Dg1asTQsBO8L8vqwlQO37Arp+I3KoOcWe7TNTwnFmFz9JgRnAKt
         He3ze8DMnALdhgalRGSXpE3atKdy5Ye37PjT0HaUWAJJX1xJ9uDvysOzxfFydZ8Zz2RU
         1gbUGVMgBKdyUN9RhNeHiyFo7oc656X7gTSdTHN/dxUzEcSczrhves06WPApQi06gZRc
         txJuCmYFdtt2HH0aX5wiaN3MR1J8OF7cdgJvt7iP1nz6UynIL1h1iUkFseLRM2ALYg/N
         NoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6wXAlJbWmH6uTZMni2idP4m1tsWk4quBIdgxNLZSbM=;
        b=fSamb8bqjtlTU31vGbEAnhi2LnJN0IKkZd32ukwAPHdKATC0PU1k+O1hQT/bhBUjmR
         pyK1RsRz0EZUtFE6V9NadAcQ4rmLEqUwl6IYSmfHLtoTNr8INoj8uAjjg/RCJAxoZ+Jl
         ZtAz8X2GY5DYll34MjgeEDLPzkOvtXAWIKECCaOnDb4g2C86nrPRXTyUCgGJMHpRnDPn
         EPsww0tXe9vtxAOFY/6W7i7jNFE284iU4T/y3I36zWsKvixNxvoYQmAarxPZs5U/oAMq
         9fSME0HpoPgV879yW3GH+qd/CEWV+jNqponrnOTMYlhJq/uNl1KXJqNDcOh9fZN3205p
         vziw==
X-Gm-Message-State: ANhLgQ0ICoak96fUuwRvfa1bP2P7pGfOvZO6bbRjQ23mYuSPW/J25TM8
        FvHx5slZPabmbbOgPjBOleY=
X-Google-Smtp-Source: ADFU+vv+GLi0Ojit+1OnNLAprCPxACmAocFiko3TYXnjq+nd5PVcdlJrYmcqACcZXKyBWIjEz6gMeA==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr13868401wrq.399.1584285283969;
        Sun, 15 Mar 2020 08:14:43 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:43 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 10/15] power: supply: cpcap-battery: Improve full status reporting
Date:   Sun, 15 Mar 2020 18:12:01 +0300
Message-Id: <20200315151206.30909-10-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use average current when detecting the fully charged state

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index da6138df2117..6205a5e43a32 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -407,12 +407,16 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
 	static bool is_full;
 
-	if (state->voltage >=
-	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000) &&
-	    state->current_ua > (is_full ? -150000 : -100000))
-		is_full = true;
-	else
+	if (state->voltage <
+	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000)) {
 		is_full = false;
+	} else if (is_full) {
+		if (state->current_ua < -150000)
+			is_full = false;
+	} else if (state->current_ua >= -150000 &&
+		   cpcap_battery_cc_get_avg_current(ddata) >= -100000) {
+		is_full = true;
+	}
 
 	return is_full;
 }
-- 
2.11.0

