Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2C185DCD
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgCOPO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43224 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgCOPO2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id b2so11826674wrj.10;
        Sun, 15 Mar 2020 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MCtPpHnUbydv9gcw0m5qsMshS01Auq8Za00j3T9ln10=;
        b=VAXmvyDi77W2Q1ICz57RRn9OooContTpvFuwFXdLyFsV+gH/8nfbTsBQk7QXuxdpMR
         g37LQlcZxxX/BhGbFezAmOpwcfC8E52sks00cHKgzVUs+ZK+AskMGiG/9w4Ha80Y9NBn
         dRlHRBjozyrWIZvNG+rWU5joHdfFuEElYNPy9hS5Zi885twQ3MPSZaXF1vuu7wDSfYdX
         7tUBd6bIuiAgzfkQSBe4JwnV7wvrBHHhaz3/hYQCpnFiTsb+k2Ol3MUzz0tO6VtcmGFG
         kcPZ85x0JkbY4aEFBmsMcZMrcZtBaN6awgWR8AxKJKQ//tYVxT25/exqWyuA5kmsUXIg
         3cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MCtPpHnUbydv9gcw0m5qsMshS01Auq8Za00j3T9ln10=;
        b=OwvkG/T46q5DdELwuaPEvT9PIxczy9byThexqd4A+gqLC6v8b7GZW49eu4/UJoqIaU
         2tUgWx/x3bmh4hUHvPUu04UxZa2btbqbSB80OeMoQtogkpGBFYVAVDCocqRZS0s18u8C
         /1/UqKza5J5ichjJsrdX5eCh3FLe37Au14oeBFGPbpxQB4qHQc/27auAnJwmQrX2cAIz
         TNvpWJ3N9zV9DgBwJxu44VeeOIQJjrUcjpdISm+P7qk4VjCoP4M7/H0ZgXH7kX7qru/8
         jZypWN5Q2wLy4bRC3h+omkPG6j76DNex0pWJWfHvbBXv2yPFYV8uFciQfVa4YmJ2rjOL
         10Fw==
X-Gm-Message-State: ANhLgQ2cPYoaaz17+Nnw8du9Ie0lhM7OqfxVsrt0y6x7DMzSJ0OZxF+b
        CVUppE/GdsHxBx83jsNHQAR2tq3mTKUbVw==
X-Google-Smtp-Source: ADFU+vsvRZlztZYro9pFbHgdix1uzOzFmaeWXNUe0McqWXPLmj5Srb0UbuHH+HUXfxTELoEWuq5Rqw==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr5109680wrq.368.1584285265069;
        Sun, 15 Mar 2020 08:14:25 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:24 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 01/15] power: supply: cpcap-battery: Fix battery full status reporting
Date:   Sun, 15 Mar 2020 18:11:52 +0300
Message-Id: <20200315151206.30909-1-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Don't report that the battery is fully charged if the charging current
exceeds 100 mA.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index d7b3234ec264..34a9dbcd1a23 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -408,7 +408,8 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
 
 	if (state->voltage >=
-	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000))
+	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000) &&
+		state->current_ua > -100000)
 		return true;
 
 	return false;
-- 
2.11.0

