Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BBEC8DF
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfKATHh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:07:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44834 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:07:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id o11so9200690qtr.11
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lj1aUbt9PEV6Gdc4Q2RVOQ8l6t5blUEdDBYHs19jKj4=;
        b=jwR9Bj0HG7npBAO7dJ5AuIsF5sM2NFOXyAiYLDKUMKHFp9uo0mNga2BO1pBOmS7+Gr
         E2GJZZOclSpkOMjTOJZ5MTMptgB9emP4tIcu9jVHsI70T/bh3GPsWAUflYsYJsmvP2MO
         HH/vH73gIW9fUJT5B8JFdIBYoRm8f2UqJ8qcemcZnaoUWzBQCujfjDF9TjlPEY/eB6KH
         vQqf1qj7gp/NNdQCcstu9T4qXp8j3WsMetxtHHeDCtrJJOqp5BzvEUl9Hnc8jTldq9VS
         ZuqgmGQRF6SbIf12clXGNwUTuSrQAfAdFrMbqNyGfnYIeRBXjLynuPECsYiZhSuTX9Ki
         jVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj1aUbt9PEV6Gdc4Q2RVOQ8l6t5blUEdDBYHs19jKj4=;
        b=J6B13ivAyVGpNDZaofoJaJ6Dk5p7L8XTvUt5GyQVKRHECySM6vUDw3x2+7qHO53v3e
         f+BEI7K8Z9A/402wlW2zhcWJ1lfGe45VfLN2ct6JfkZFRyvmfdLSg5iIKV3HFnm4JHmg
         VyaVusLGZnr8ak5cO9s1t0HCceUKMiCyVEdXoD3ZyFUK7bgY1Y8rcC4e2cFoxissnLAK
         xOLSDCo7VZ7H4Uy1b4XvBDoeNP5tGYci8iDrtYgdj5jIo4yRdEXMAh9Twm8lBgcW4II8
         rmhWR5F8UwzznvAjrcddas3PkjD2uOEQPbXe9+L81ZMy1gXZGzbRHBb9gVaUoW+COcOO
         FiYQ==
X-Gm-Message-State: APjAAAWCzytjoQAODjtvO4OuMNviVao9VRjUr/S/HMkC58+k06rB/tUH
        29UMH/wUPMCRevBgUvSFYpM=
X-Google-Smtp-Source: APXvYqyGODdQuSV3v0aNR9dLteZeFxFjGMfXU8yLFvfwY7j8noN4s0bM89+N5D0UTBq2bhPilDwQcw==
X-Received: by 2002:ac8:35a4:: with SMTP id k33mr970995qtb.354.1572635256416;
        Fri, 01 Nov 2019 12:07:36 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id d139sm5105905qkb.36.2019.11.01.12.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:07:35 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 5/7] power: supply: sbs-battery: fix CAPACITY_MODE bit naming
Date:   Fri,  1 Nov 2019 15:07:03 -0400
Message-Id: <20191101190705.13393-5-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101190705.13393-1-jeff.dagenais@gmail.com>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"Battery mode" is the name of the register, the bit manipulated by this
code is "CAPACITY_MODE" (Smart Battery System Specifications).

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f92b98d900d2..46c89dd05f46 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -46,10 +46,10 @@ enum {
 
 /* Battery Mode defines */
 #define BATTERY_MODE_OFFSET		0x03
-#define BATTERY_MODE_MASK		0x8000
-enum sbs_battery_mode {
-	BATTERY_MODE_AMPS = 0,
-	BATTERY_MODE_WATTS = 0x8000
+#define BATTERY_MODE_CAPACITY_MASK	(1<<15)
+enum sbs_capacity_mode {
+	CAPACITY_MODE_AMPS = 0,
+	CAPACITY_MODE_WATTS = BATTERY_MODE_CAPACITY_MASK
 };
 
 /* manufacturer access defines */
@@ -513,8 +513,8 @@ static void  sbs_unit_adjustment(struct i2c_client *client,
 	}
 }
 
-static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
-	enum sbs_battery_mode mode)
+static enum sbs_capacity_mode sbs_set_capacity_mode(struct i2c_client *client,
+	enum sbs_capacity_mode mode)
 {
 	int ret, original_val;
 
@@ -522,13 +522,13 @@ static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
 	if (original_val < 0)
 		return original_val;
 
-	if ((original_val & BATTERY_MODE_MASK) == mode)
+	if ((original_val & BATTERY_MODE_CAPACITY_MASK) == mode)
 		return mode;
 
-	if (mode == BATTERY_MODE_AMPS)
-		ret = original_val & ~BATTERY_MODE_MASK;
+	if (mode == CAPACITY_MODE_AMPS)
+		ret = original_val & ~BATTERY_MODE_CAPACITY_MASK;
 	else
-		ret = original_val | BATTERY_MODE_MASK;
+		ret = original_val | BATTERY_MODE_CAPACITY_MASK;
 
 	ret = sbs_write_word_data(client, BATTERY_MODE_OFFSET, ret);
 	if (ret < 0)
@@ -536,7 +536,7 @@ static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
 
 	usleep_range(1000, 2000);
 
-	return original_val & BATTERY_MODE_MASK;
+	return original_val & BATTERY_MODE_CAPACITY_MASK;
 }
 
 static int sbs_get_battery_capacity(struct i2c_client *client,
@@ -544,12 +544,12 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
 	union power_supply_propval *val)
 {
 	s32 ret;
-	enum sbs_battery_mode mode = BATTERY_MODE_WATTS;
+	enum sbs_capacity_mode mode = CAPACITY_MODE_WATTS;
 
 	if (power_supply_is_amp_property(psp))
-		mode = BATTERY_MODE_AMPS;
+		mode = CAPACITY_MODE_AMPS;
 
-	mode = sbs_set_battery_mode(client, mode);
+	mode = sbs_set_capacity_mode(client, mode);
 	if (mode < 0)
 		return mode;
 
@@ -559,7 +559,7 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
 
 	val->intval = ret;
 
-	ret = sbs_set_battery_mode(client, mode);
+	ret = sbs_set_capacity_mode(client, mode);
 	if (ret < 0)
 		return ret;
 
-- 
2.23.0

