Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4112A240D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 06:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKBFVz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 00:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgKBFVz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 00:21:55 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23636C0617A6
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 21:21:55 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t22so6256783plr.9
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 21:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvXFnt9hhX2LofCdOg6VIZ0RCEbm1xCOvYlBDofSUBs=;
        b=NNUAW7kUvw/9uReQqDk5oj1JzyggrFkEfRrlSEHfvjEKrm3PkmAMmm13GLImGPD9de
         aU1Mi4n4CG66oGFMZpZuslEro6Ipl14DMpEQ+DaovL85ZjFMTEwiuSqcgybS+Pu/ANN9
         Ml1vtAmzfjM1X+8GxE4e7qUxL53QZXm1UMIsXjFmBnpqijQc2Rsn9WVc7hL9B6XCM9av
         djgsxNhn6wfeqZagfPew5s8Q6vMzFKxGEKYna/p+UnUzU0Kzj7MjMZdFR/BUUdSOO84j
         JnPXfOomFQrjCbPVyYOCPhPDYPfdKX9L/iMJ5AEXMM3QcRXgRHqgX5R23T6wHEm+5+XE
         kgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvXFnt9hhX2LofCdOg6VIZ0RCEbm1xCOvYlBDofSUBs=;
        b=DT0j6G3A9ttIme+q+HEYgRmFeLANMD+wbh6HoOYrFb5zjlLv4247TE4o2bYmn6dgpB
         oFJdXIMRHsyEmV0XfvQmPx/HB+elxb7P3pkgRWSWxxsmWv7XTwRgKPLTpgvrr1Xb4dSP
         fDlWsgoo5zjC8tnhHFr5ItyNtvRcb/kYwIGplGrgE+cPIoXxXxPq0PrmcQ8/FHi0VltL
         a+USln757WbQia7XU37aH00+8T9ockiZV2EGYwMUh7SEzsmO0U5FCMLOmN2UmqHG7iVa
         M9rUga9Lct98+e0/IUUTc3Dhg9VMFm3LwgpjfpgDmtg7+RvnqEYWQmD4F8+pPbLyyb1M
         hYNw==
X-Gm-Message-State: AOAM531jWAykcmJqPqQlv3blOkxlm5o/8d3Q0fLHxBO089uvSeofR3tz
        9dLwPNOv9zXYf4YOY/nNogJ9PlS7TlVy4g==
X-Google-Smtp-Source: ABdhPJwPzQ2GGc6ql3unqtgFq7Rej7ZDNthA1XBf30TKCmGaSI9EkbPOwmQVMrAL+CfaY9cFASpbRA==
X-Received: by 2002:a17:902:6943:b029:d6:bd35:c84b with SMTP id k3-20020a1709026943b02900d6bd35c84bmr7574255plt.53.1604294514719;
        Sun, 01 Nov 2020 21:21:54 -0800 (PST)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s38sm11375758pgm.62.2020.11.01.21.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 21:21:54 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, robdclark@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] opp: Don't return opp_dev from _find_opp_dev()
Date:   Mon,  2 Nov 2020 10:51:40 +0530
Message-Id: <b00bd2467090acc26a4e90d8a15e0740044830ab.1604294460.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <ef43f01ac06976b2aa2b17266d307bb1a4f7e6f9.1604294460.git.viresh.kumar@linaro.org>
References: <ef43f01ac06976b2aa2b17266d307bb1a4f7e6f9.1604294460.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The caller of _find_opp_dev() only needs to know if the opp_dev is there
in the list or not.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6f4a73a6391f..9915e8487f0b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -32,31 +32,29 @@ DEFINE_MUTEX(opp_table_lock);
 /* Flag indicating that opp_tables list is being updated at the moment */
 static bool opp_tables_busy;
 
-static struct opp_device *_find_opp_dev(const struct device *dev,
-					struct opp_table *opp_table)
+static bool _find_opp_dev(const struct device *dev, struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
+	bool found = false;
 
+	mutex_lock(&opp_table->lock);
 	list_for_each_entry(opp_dev, &opp_table->dev_list, node)
-		if (opp_dev->dev == dev)
-			return opp_dev;
+		if (opp_dev->dev == dev) {
+			found = true;
+			break;
+		}
 
-	return NULL;
+	mutex_unlock(&opp_table->lock);
+	return found;
 }
 
 static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 {
 	struct opp_table *opp_table;
-	bool found;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
-		mutex_lock(&opp_table->lock);
-		found = !!_find_opp_dev(dev, opp_table);
-		mutex_unlock(&opp_table->lock);
-
-		if (found) {
+		if (_find_opp_dev(dev, opp_table)) {
 			_get_opp_table_kref(opp_table);
-
 			return opp_table;
 		}
 	}
-- 
2.25.0.rc1.19.g042ed3e048af

