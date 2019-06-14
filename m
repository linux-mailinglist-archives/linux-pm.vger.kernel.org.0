Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0EA4568F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 09:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNHl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 03:41:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44392 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNHl4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 03:41:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so648771plr.11;
        Fri, 14 Jun 2019 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTN8zccKrdobWI38/ip/wwPCXH3X8VyP8EgQGu6WwT4=;
        b=Tx3zTdrZxlmZBygvwuVbgkil59kuAuDEE9UD/o9yXNf7z+83BF5msXsFToFYmZYp4E
         XQNHmim9ZBjucKmzzcSeHbwSWyreHdMPlMOEanVzlkX78CwPSYCOsE8/m3p5jc56JiSD
         bqk0LJyD4L28EhEOAJoXAJwXrYikXA1UQnWIFOFhd46PbySme9DU402xNwtgUMvOSqQ/
         I827m25SPAHWqj1C/AdTSO4O39CqR9R0nk6mmFTDkAGS/Bp72RWn/UNarsZfSSd7Y/dd
         Yx1xXLEIaOvVSUkS7evJYxbttwD/KV7HRyR5gFCW3oYFzUiGwkid6CiY38OPJCFA5EW3
         yHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTN8zccKrdobWI38/ip/wwPCXH3X8VyP8EgQGu6WwT4=;
        b=cE1cY9Dz/hxc+Upm5hjSyho6ivM8ZjsWaHC511ReRJCkmryp4Z2kDVsNID/R3wkGcf
         kMiCwfxPSTAI46I59FwTKk1CBMWrMDLmw3S27XBe1ZUzA4yjFGgSfUEbYEEYxkL/OAhc
         WEVCkOFd/rNTonqXoSJaRb3FxgP4FSEH8iFU7lJklxJwqxm2CSe6MmOh63mxptSJQzwy
         ugARzlH7GaE+YZRy/iq2NLUFKwnjw4R8+8+TevKSQ2Kt0pIROOJh+3srk5gUKBfc2JEU
         WMhevfl02WCBZFV+8UYuMLy1Dso1UZ7q6w5CUqRXkcN9Ncc7ZZ9yYgQz4tFNA/vNPjhQ
         8EzA==
X-Gm-Message-State: APjAAAVw6lm51mwYk9Fstlx4Nqga9RHiS61pk6f2o0JTkZ4wepFPDO8a
        mWRJ+QnO3QoZfQBrv3Kd9R8=
X-Google-Smtp-Source: APXvYqz1ezUgFwUfWTWpyFtqN1r3FJLRHBwqWF1tKFIH7v0Hytm+7RntCcWvpExkwSaYKI3rEoBEyA==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr66319599plo.249.1560498115397;
        Fri, 14 Jun 2019 00:41:55 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c6sm1979398pfm.163.2019.06.14.00.41.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 00:41:54 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: imx: skip registering legacy cooling on i.MX7
Date:   Fri, 14 Jun 2019 00:41:40 -0700
Message-Id: <20190614074140.15276-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX7 doesn't have a mainline cpufreq driver, so
imx_thermal_register_legacy_cooling() will always return -EPROBE_DEFER
preventing the driver probe from finishing. No-op
imx_thermal_register_legacy_cooling() on i.MX7 to avoid that problem.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/imx_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bb6754a5342c..bfc9c6d57916 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -658,6 +658,9 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 	struct device_node *np;
 	int ret;
 
+	if (data->socdata->version == TEMPMON_IMX7D)
+		return 0;
+
 	data->policy = cpufreq_cpu_get(0);
 	if (!data->policy) {
 		pr_debug("%s: CPUFreq policy not found\n", __func__);
-- 
2.21.0

