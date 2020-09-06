Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4425F10C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgIFXKX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIFXKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 19:10:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0836C061575;
        Sun,  6 Sep 2020 16:10:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u4so13054018ljd.10;
        Sun, 06 Sep 2020 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUGRQoQOfkm+Q1r5IdMfVQrE6dq9XkDPp8w5VNp/XW4=;
        b=A5/7U7PGysC7Lat9H1X1WrQsULCsjbslDkwUVOG/iH1O9q2QWz7FE1iJUxhr58Hj/4
         V20PbyZt46CuVFG041pKscToJe7Lh0LiDjHeXOLOV/b9WDgUux8u2PDxnJzlLnxpamZ/
         0BZf34CJxQOg9XSJ6oJEKfNmEkzFJe8hWPCZoJz6Wcdd1btLhc5lPXSntl/jUg7nd/Gt
         wsB5UHchdcYkOtOj9KNPHwNFTwPq2i+f0ju5BKC1EsUMg42BJTNHkPONB971GDL8nck5
         qF2WqdtKfm5Dur+zbkitJf39PTujSzjC1DuHJsmJopAYg8rWuSXvX+oIL0yYYYP7E3vW
         UPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUGRQoQOfkm+Q1r5IdMfVQrE6dq9XkDPp8w5VNp/XW4=;
        b=pr0hOZiRlos/aqs2jkWPfImblOxZmflO7YzSld9xkZKFcWbA/HYyY6fQwU25LFn9TO
         Rq/EPENrWyoxBlgMn1h0Pc2265XFrZdiAEYROtis8QMr2ZyMipxaiJqnSfTCLOQfnn1e
         W+/rjuHdw3EVZFyIXJCSo9R67LJ2xpxVQFjxzoA5E6Q+4nUqQ5qIJaqBIeqo5R7o4ieT
         4hoJ+b9mmZn9+u2NM9tMSmflJxsjqdwHHtwa/YvPT2Dt9aZgrBz1VCwJ0df8t7//PUB7
         1kdsUqJ7UMairPnLdIA+u6Evg6sv1vGD1J+CwyLK5vO+dQoFB/C/R4YGoWfdgSxDUHaV
         dlVg==
X-Gm-Message-State: AOAM532rxYqTbR/f9gg7lwR6GMtiS6h1O/0+7+buPfDGaEfMLKt2MToX
        DAawBSXwzxEwRsh42W20oKc=
X-Google-Smtp-Source: ABdhPJztcsF1D/9+BjP+M7FHssI19IN5D3FuSHqwt6KE+HfThPz7XhqQAk2eIXbCTe8Ozp1yUuG1PA==
X-Received: by 2002:a2e:8798:: with SMTP id n24mr6018798lji.373.1599433803479;
        Sun, 06 Sep 2020 16:10:03 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r17sm1325984ljp.117.2020.09.06.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 16:10:02 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] firmware: arm_scmi: Constify ops pointers in scmi_handle
Date:   Mon,  7 Sep 2020 01:04:51 +0200
Message-Id: <20200906230452.33410-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These are never modified, so make them const to allow drivers to make
them const.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 include/linux/scmi_protocol.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 7e5dd7d1e221..05570afc7f74 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -279,12 +279,12 @@ struct scmi_notify_ops {
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
-	struct scmi_perf_ops *perf_ops;
-	struct scmi_clk_ops *clk_ops;
-	struct scmi_power_ops *power_ops;
-	struct scmi_sensor_ops *sensor_ops;
-	struct scmi_reset_ops *reset_ops;
-	struct scmi_notify_ops *notify_ops;
+	const struct scmi_perf_ops *perf_ops;
+	const struct scmi_clk_ops *clk_ops;
+	const struct scmi_power_ops *power_ops;
+	const struct scmi_sensor_ops *sensor_ops;
+	const struct scmi_reset_ops *reset_ops;
+	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
 	void *perf_priv;
 	void *clk_priv;
-- 
2.28.0

