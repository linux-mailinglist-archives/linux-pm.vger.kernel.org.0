Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF86EC8DC
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfKATH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:07:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39321 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATH1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:07:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id 15so11680768qkh.6
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7KgS1GjohJOLHMPh2cKOpzGRBgkOIJAxx5JgFXYTTA=;
        b=QU8qQueq2LshHnhXpxCStJxa/tfBoVnZxsE82Csd6hDIF5l4vKBwgm53Hb+RG4NtGr
         YGlCeFjBNIBvI89PBv9TCi7E4DH8IdYIssDQYg7j13RRZIKa0RL6KmpLXiWZmfmbUEGf
         XiNMps6hN91n44KQvMkQTAMhOsptNlq3NrV2APu8oR3X9KKii7XADoYSluBvOBi2dwCJ
         0RnUqOJeNph+nFDaO30hVTA/MiNAyqe7NU1ilfWIZbMCKCdEcg2pQCFow53EbbMM2c7g
         lMFZQKhyZR9NmOcvNulYIzGKWYqq9LFrYO5mOtPIHiWOsC7elSZTCdKGypSVcz6zKkst
         oefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7KgS1GjohJOLHMPh2cKOpzGRBgkOIJAxx5JgFXYTTA=;
        b=ay6V9OYUTrVtZm9hGfFzE0TgjsWG2X3AUrISdhSA5tAxLTk3HQPC1OAOYxY1aR+A9s
         8Wy8oD9y18CiRTN87HfWwxkfb8vvwy2BIZI7LkbSNSZ7qXJ0XO2c7smlNqHy5kS3ocni
         +6wbBIvaGkVfwwPAuYeeRR9t3PqjOBwV1U5WFX0ChnyDlj4eN+NwZaGoKUKuu/vLdT02
         YdBCDoufj70b0+gFHyS+WKfs8OUYOC7nFVGy+0nxHTDInjzTLIrSZpy5X4eOeuB3kpwK
         y+LVzmZHiocexKWGVHCmU/QcWtTQgPZeWt4LlGb7j7aiWDRgQPuxPPDAS3MmPhVfnrPh
         5IhQ==
X-Gm-Message-State: APjAAAXaTZb9PWlHrBF1j2crfuPW6JSxeh3tGMoIdGs5lCQZOcQByvQC
        XeYT3719qgLIFDjP9AWyhHQ=
X-Google-Smtp-Source: APXvYqwSXbQai1aHn4yLdNyYccy/XoDkR252NUPl6Wxjv5yN8uJcUCTq5tUmNDlNhsE5iXZxV/tBNw==
X-Received: by 2002:a37:e10d:: with SMTP id c13mr11460762qkm.35.1572635245125;
        Fri, 01 Nov 2019 12:07:25 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id d139sm5105905qkb.36.2019.11.01.12.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:07:24 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 2/7] power: supply: sbs-battery: prefix module param variable
Date:   Fri,  1 Nov 2019 15:07:00 -0400
Message-Id: <20191101190705.13393-2-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101190705.13393-1-jeff.dagenais@gmail.com>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is to prevent confusion with the upcoming devicetree binding for
force_load.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 0e66968dabc3..f9e8c14ac830 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -168,7 +168,7 @@ struct sbs_info {
 
 static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
 static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
-static bool force_load;
+static bool param_force_load;
 
 static int sbs_read_word_data(struct i2c_client *client, u8 address)
 {
@@ -890,7 +890,7 @@ static int sbs_probe(struct i2c_client *client,
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	if (!(force_load || chip->gpio_detect)) {
+	if (!(param_force_load || chip->gpio_detect)) {
 		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
 
 		if (rc < 0) {
@@ -994,6 +994,6 @@ module_i2c_driver(sbs_battery_driver);
 MODULE_DESCRIPTION("SBS battery monitor driver");
 MODULE_LICENSE("GPL");
 
-module_param(force_load, bool, 0444);
-MODULE_PARM_DESC(force_load,
+module_param(param_force_load, bool, 0444);
+MODULE_PARM_DESC(param_force_load,
 		 "Attempt to load the driver even if no battery is connected");
-- 
2.23.0

