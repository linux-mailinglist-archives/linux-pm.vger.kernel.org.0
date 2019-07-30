Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D17ADB6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfG3Qd2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:33:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43288 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732902AbfG3Qcm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so66462911wru.10;
        Tue, 30 Jul 2019 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmdGNk4oNO4STFUUcJmXV87+bjb8OGrYJzjuXg++0eg=;
        b=YMR/EwvrgUn7iTeE2I0BcdmvIOc8h2UPagqrNRtz6XSKx1d4HDj8okgti2ywcWfduQ
         WeOSv0DL8lRGYJ6monsDZdgM3DmExNwTit4u9i8nxQczwa7yxlAY66y9sqZ7X+HS4Bfa
         Hh7MEQH6dOA4MfMro4mW/Wk5u4tW9Sn5dZhOwukpUQ3YWiTWo8r5RdsF/V2Q4HF6JIKs
         0j1BpdPe0Oemxt559Uh/zoowFD1YHoBcyLJaBHpBVWUwmslPNJ3ZOcMTX3tJa8KBvCpN
         o8PW1dNxwjSJkhijdQP8DR0K2ICcXxVtOKKFPWDh8zWhpx7LeMGRGgDz+NIGp+OZbpVo
         Leeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmdGNk4oNO4STFUUcJmXV87+bjb8OGrYJzjuXg++0eg=;
        b=lJmtEibUUaWIZvhg5fga1kCuxip4x8IU1f6WMhpVBgyZOgpOQtsQpNXlJWO9lG50lD
         e8tbs26x2uMzg/CHG7YKi59oDRvzEzkchjIJXXZPrxaIxS1JwmBp6nK1r+K5/ViH5ugD
         RBdbfSl6Y2k44SM/tD2zd+xqgq91rQZ5oKh2iL22Fli+gc3ZndldT7zYElvmk3S8vLZ2
         EZaWRm4jPez8AG624TjN6CEYPhFzCqeePdjIrNgVUiL+8DpPlYz6B6JDgvMlqocBBDaT
         TDjJQFbhN3mFXeUkyB4XbyYk7UUTT8thwzfJKCgtVEx3OdjnobVCey4/gsgE+PqNcpwI
         Uw2A==
X-Gm-Message-State: APjAAAWYb55CRAIfSSITjadCzXvWU431AiWbOQJnezXHfusxgEIbAjos
        OOj2NMMrmiOYEoQP9ViudseDHyWO
X-Google-Smtp-Source: APXvYqyXHBWiO1COppwKmNpaAn5hNvdAM4G8Jq59l5I7Jb1x+FnRT3BqdlZXBqzfaTnwOLDDUgherg==
X-Received: by 2002:adf:e552:: with SMTP id z18mr131982400wrm.45.1564504360757;
        Tue, 30 Jul 2019 09:32:40 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/20] PM / devfreq: tegra30: Increase sampling period to 16ms
Date:   Tue, 30 Jul 2019 19:22:33 +0300
Message-Id: <20190730162236.6063-18-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Increase sampling period by 4ms to get a nicer pow2 value, converting
diving into shifts in the code. That's more preferable for Tegra30 that
doesn't have hardware divider instructions because of older Cortex-A9 CPU.
In a result boosting events are delayed by 4ms, which is not sensible in
practice at all.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8280f96f4cb9..3543fba74b52 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -67,7 +67,7 @@
  * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) = 128
  */
 #define ACTMON_AVERAGE_WINDOW_LOG2				6
-#define ACTMON_SAMPLING_PERIOD					12 /* ms */
+#define ACTMON_SAMPLING_PERIOD					16 /* ms */
 
 #define KHZ							1000
 
-- 
2.22.0

