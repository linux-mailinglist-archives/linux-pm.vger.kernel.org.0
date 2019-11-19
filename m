Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49E101A7B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 08:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKSHq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 02:46:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33363 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKSHq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 02:46:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so22176659ljk.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 23:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQcL4KeSUnBX/WAoY428hVjcl0P7/kkL2Fm2OZbyzCA=;
        b=fkvCkItxkx0F8zOFusOr8rkJVZzDK9EfXZ4WTvL35D42a7Cf0OI0EmcaVbpF01xmSa
         gNjxnkGNiNu4blhsWTDnmd3xSQjPRoU0pcZYhS9CvejOL3s1NRuB0Y0J4+cFgmn6/IBa
         QJnu0bxve/aDzWyZ1oW688z1XyqTul8/3U77zcgYCr6H+6Dv1cHMsGXFe+cEAeCCMtJW
         SSFiqLjtt12LB5ERGTpjop4xLf3Rm+AXJJWfGQt3+p26b9Sd+/0EpVJaTG9zGHfmErB+
         pLMiux15H009ow4tTRIku8N+YOF5T3TjTr0PY2+3SCfpXF9k/Nrc+iOukW5CYaavlVxg
         1nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQcL4KeSUnBX/WAoY428hVjcl0P7/kkL2Fm2OZbyzCA=;
        b=eLD42tpW8ZBzmx4l6GtOhKfNvp/YPFVhAuX4G91o2ahHfLg0+6Ipq5q0rlZbCQIuFy
         dj+u5zfEvXde5NpVvAp6oOqbz4/9p9FT4XJyaIOhJWJdV4XjSuTZxhBXw6QILr46lx0q
         BmHWE4zsOuLCfXdmaRhkDTYiYj7V2oI2PAXYOalWJAlWe0ibHRQwuh/szAmVv6sQnpjp
         brWOk7bU4265ZNmRpG69nB1q1/pC7ynqQTD69SSIgf0lrn6Tq9XEHP7rlkZG3CnK2gSV
         Yqwgez4cb99AXifTsoGM8j/Ue0O3tNWcDYictOJU2Y5vl056qd9NyMU8KqDcOk+0EVuL
         6Klw==
X-Gm-Message-State: APjAAAVWNDndS8jFnRxksN2Z5QHpK96hEMsybs9xKCjxXNtYMKAtAY7d
        r8+Jlj+k2h+lPMTabqsHWups+g==
X-Google-Smtp-Source: APXvYqw8dlD+iLZYpffwJEx56n/V6YAQfhSnDMoiUdL1Yi9Ed/3rRIOcfpvUz7FGlSGc+p93bSf10g==
X-Received: by 2002:a2e:8919:: with SMTP id d25mr2568438lji.97.1574149613992;
        Mon, 18 Nov 2019 23:46:53 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id c80sm442584lfg.81.2019.11.18.23.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 23:46:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] thermal: db8500: Depromote debug print
Date:   Tue, 19 Nov 2019 08:46:50 +0100
Message-Id: <20191119074650.2664-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are not interested in getting this debug print on our
console all the time.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Fixes: 6c375eccded4 ("thermal: db8500: Rewrite to be a pure OF sensor")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/thermal/db8500_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 372dbbaaafb8..21d4d6e6409a 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -152,8 +152,8 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
 					     next_low, next_high);
 
-		dev_info(&th->tz->device,
-			 "PRCMU set max %ld, min %ld\n", next_high, next_low);
+		dev_dbg(&th->tz->device,
+			"PRCMU set max %ld, min %ld\n", next_high, next_low);
 	} else if (idx == num_points - 1)
 		/* So we roof out 1 degree over the max point */
 		th->interpolated_temp = db8500_thermal_points[idx] + 1;
-- 
2.21.0

