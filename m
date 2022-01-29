Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA50A4A2AB4
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbiA2Avo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344734AbiA2Avm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED1C061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z19so14945315lfq.13
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeZ9WCJuW3tGBok5WiTsDPgvKuJb68iBDe0TLVYC36c=;
        b=QjUTwj4XLdcfA9br4S9ysl6dOWmKoIAvJ2KZYVM7/3z/QjdPRROaYk8SEaeTE6M8Hi
         VInvlXZWq1hW/PB9l6SVTKCKAznnLd4TfvtVZK04GKq4mh6FqwtMP9uD8MMwbAXokFnO
         jLBl+waQmeiHU6eElBZVoqhZMspf0mPW3EA3bY8yu0P26vd2f6w6jBxzpoFRasMcHg5p
         kb+GVrI7enkRmeW2BXf8s7RSVyk9cM1ZgRoEJC3oVnIYw4Zi8hg/fcJ2AvIqvYVJKO/1
         5B+01e7dc9kcuDqObwziBLaD0RNxfsS2XbHtD0nakem8K+y58fcLoIGAmm2vW0OtL6AQ
         AQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeZ9WCJuW3tGBok5WiTsDPgvKuJb68iBDe0TLVYC36c=;
        b=PcM0YKmaw/hcVmkQHR+Q2W/PigTn+9NffcVRlQ7rfIKj4EfhTdXnVT1AL2gGjrSoDw
         XaHDGQLu+jt3El7dipFyPNQZX77PcRsE0mp6VglH2oMTLLBVTFcISUoGt9+ifYrIYLPD
         OBgOzpM+5IMlLmDDaCX87zfSRkpY7Ho0ZZ754nnTVoS814zU/vBrYFhWouR+K74pWsm6
         RBgPo+pM5koy12hWb2qwDKR031lui7/4zcGB5DTLmJIiqejTfrOwVoFP1Fosro8CAD64
         VrH82n1bpsU10JZo57aFnfWI2KePCNAQNqomZ9iqmup8IHi0zG1zgFk29sTLV+2M98cr
         jRKw==
X-Gm-Message-State: AOAM532++37aEmE7jJj7PGCePmHHBEykSON+B+my6FPm0nrQhmx8uPkX
        GXnA9UbVPExG2fDP2SWFIbum6g==
X-Google-Smtp-Source: ABdhPJxSYvzHW9P/LKkcRxjVNls2TZUhwE22Gt90As6Z1JX+k5V0kUQdbrnNYmD6OuGamjz7Jx3d3w==
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr7821622lfr.163.1643417500901;
        Fri, 28 Jan 2022 16:51:40 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/11 v2] power: supply: ab8500_fg: Break loop for measurement
Date:   Sat, 29 Jan 2022 01:49:18 +0100
Message-Id: <20220129004925.639684-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the Samsung code tree we find that it can happen that this
measurement loop goes on for a long time, and it seems like a
good idea to break it after 70 iterations if it goes on for
too long.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with other patches, no changes.
---
 drivers/power/supply/ab8500_fg.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 236fd9f9d6f1..29896f09fd17 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -45,6 +45,7 @@
 #define SEC_TO_SAMPLE(S)		(S * 4)
 
 #define NBR_AVG_SAMPLES			20
+#define WAIT_FOR_INST_CURRENT_MAX	70
 
 #define LOW_BAT_CHECK_INTERVAL		(HZ / 16) /* 62.5 ms */
 
@@ -926,10 +927,18 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
 		vbat_uv += ab8500_fg_bat_voltage(di);
 		i++;
 		usleep_range(5000, 6000);
-	} while (!ab8500_fg_inst_curr_done(di));
+	} while (!ab8500_fg_inst_curr_done(di) &&
+		 i <= WAIT_FOR_INST_CURRENT_MAX);
+
+	if (i > WAIT_FOR_INST_CURRENT_MAX) {
+		dev_err(di->dev,
+			"TIMEOUT: return capacity based on uncompensated measurement of VBAT\n");
+		goto calc_cap;
+	}
 
 	ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
 
+calc_cap:
 	di->vbat_uv = vbat_uv / i;
 	res = ab8500_fg_battery_resistance(di);
 
-- 
2.34.1

