Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32032136528
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 03:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgAJCAH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 21:00:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34289 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbgAJCAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 21:00:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so224394pgf.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2020 18:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvCF4TaFq4NHuFxKrB7bfyibK4IZqbz7rtt+95xhHqo=;
        b=UhkNF2i6KaXltxMZXRbU88Ilw8OkJEXI6REMlfxksP+PYmlbEzftvOHIMyN7fYK08w
         Tqaihhp66NIs8LcSomRTfLax8Nm7UYv5neFP9D2xNLpcTUtO7X3de+NrsxNZIQDFZDEG
         k9Pr+5/igmkqzgl3qbPWOO52LVuTykmOmSX5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvCF4TaFq4NHuFxKrB7bfyibK4IZqbz7rtt+95xhHqo=;
        b=Bsbeu52eADIbR7wl6sbWSQ5CxiIhoxrL1P75f8N/vwYzQZ5kMYD0cu68Nu530ZKtu9
         7wH0QtO6t0HX1q2RQblnpwBuFlFrDKcx5rq2b+rucflxwmnPfKXqDig27l71ZvMfm4m1
         XGTvVbP3WSVkl6YGEg5JRJEEHF/0yUfQ/6IALCcbAtjh7yd1RCK1rs7x3Uy17rfocIlS
         Zx5tn7SkgO6unmR3dtxCp8ehvCVsuXnrtOHvQu3s4oaIiV5nQNLCdoPPCJiZWdpjQuG4
         NCGjSBuxHnT8wLacqhX7skQK3OCMg9FGcE/0RYTyg4/Z7echMHmjWdRT9aWy+jMsJPy+
         8Ehw==
X-Gm-Message-State: APjAAAWv8Njj2SwFjiDpF7A3m31n0/+AY6QnFbaANP0yC0fQ4jzQlsWH
        wyT2VlLZfZR8vuIIpF+TwKTUUSNRU7I=
X-Google-Smtp-Source: APXvYqy8CIzTVvdPT0/w3B7JHwB2lbAlbMW9Fuh1+JhZtXYS4f9PXX9xu9MMgcycQmesK9L3XRRSPA==
X-Received: by 2002:a63:4641:: with SMTP id v1mr1171519pgk.389.1578621605868;
        Thu, 09 Jan 2020 18:00:05 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id t30sm233232pgl.75.2020.01.09.18.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 18:00:05 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org,
        "RafaelJ . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     DanielLezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] BUG-REPORT: cpuidle: teo: intervals[] array index out
Date:   Fri, 10 Jan 2020 09:59:17 +0800
Message-Id: <20200110015917.32825-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This seems to be a simple bug in rotating array index.
---
 drivers/cpuidle/governors/teo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index de7e706efd46..6deaaf5f05b5 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -198,7 +198,7 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * pattern detection.
 	 */
 	cpu_data->intervals[cpu_data->interval_idx++] = measured_ns;
-	if (cpu_data->interval_idx > INTERVALS)
+	if (cpu_data->interval_idx >= INTERVALS)
 		cpu_data->interval_idx = 0;
 }
 
-- 
2.24.1.735.g03f4e72817-goog

