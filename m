Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D0185DE5
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgCOPOt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55835 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgCOPOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so14919198wmi.5;
        Sun, 15 Mar 2020 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVPxIoZo/vKodsHN/qS4/fBJ4w5+dc7DuMJbCteKrrM=;
        b=R9izYlv93M4b3lcNWWP+qtEpqqYGfPQl8nQ1uKin/exVlDcFnhvePq6zVFkrxJQMeZ
         hKvt/TPkaae7PXKmjOn5w8Dd0agqCfJX2tiAH/utVu1XPGQ3gD6ZGGDFh1rKBOT2AuW7
         DRw98ywRqrZYgNu1/Z4enfdgoHan3a/zMQwre5/chvsZ6OjPeZ6u0SsJlDpVMQPHyvfg
         zKVnyuw/+TY8IktDLh7RR53AP8C0i2npGuIz4ifx+JQI8+nhzN8go5cAXskQJCsMbuIa
         yP+x6BqfyJrkEbrKC3SXlzxlcIwzuCogxvojDIaIGFxzN8QPDgngWybkETrxN9HQWQGp
         GcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVPxIoZo/vKodsHN/qS4/fBJ4w5+dc7DuMJbCteKrrM=;
        b=A5Vrb6qRwgCAYEADGQQGxWj2jSTaqn1NB0g83xHbprx69H+tlaeqhaitCn/mqxrMVz
         QaKInOSjIpVugHdJaDB1s5GHFbpv3CBqXoZtoCZP9NXiQ2TSCRn7lMRTWXDS7fJ+2V7n
         +WNTgDmAC2jlOu7Lg8HjncawjuU05hQmmf/9sGZtvchOEfugaKgm2rjYhOTCIUv6MrZ+
         31zdoT0cBno5etuzl7taDQk4qiumH7YiDMMFXEWyIAAEUs0FfNPFZAB7MC6iHuwRL5Vb
         UshDxjvwIPeheJtCsQp7WZIkiJvrL2Eqm/T5tjG5RU7nT188A2oUtn14ZGhuw/zxI1Tm
         A2oQ==
X-Gm-Message-State: ANhLgQ12rib3kZIj9TI2qt3CUJP5XSC8L0CcDzr0+ZZ7p6z00z8juIUs
        ZPrFNd6jVhwGgXg0I2cIMqI=
X-Google-Smtp-Source: ADFU+vvUw8RmrHntFQcgB/ZgXAXUDdh8nfGN0fbBpRQAwOJAOEIrpqpCviJcRW0SNCmkWU3rQjJWxg==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr4866555wmk.2.1584285287723;
        Sun, 15 Mar 2020 08:14:47 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:47 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 13/15] power: supply: cpcap-battery: Fine tune end of charge current
Date:   Sun, 15 Mar 2020 18:12:04 +0300
Message-Id: <20200315151206.30909-13-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For some reason the charger device gets disconnected prior we have 100 mA
current. Set the fully charged state detection current to 112 mA.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 517acdfa6009..938117638983 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -411,10 +411,10 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000)) {
 		is_full = false;
 	} else if (is_full) {
-		if (state->current_ua < -150000)
+		if (state->current_ua < -170000)
 			is_full = false;
-	} else if (state->current_ua >= -150000 &&
-		   cpcap_battery_cc_get_avg_current(ddata) >= -100000) {
+	} else if (state->current_ua >= -170000 &&
+		   cpcap_battery_cc_get_avg_current(ddata) >= -112000) {
 		is_full = true;
 	}
 
-- 
2.11.0

