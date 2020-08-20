Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00C624B09D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 09:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHTH4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgHTH4u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 03:56:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B9C061383
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so609089pfx.13
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqN+JRqBcM9sNS/bUUY7pxB30ldKatY72VtpGF2V5es=;
        b=mf3rBwfBi0yKumSxP8KE3wv22MrRq2xvrN50piShKy6hP8xLXV3o5c16JSMPtHIuy9
         +HGYFuxUtPOQIAee5skPIxdRSp80RPp98Qx6YwSDRviMIhgkE82sV9+XsVzIUBMIGU2e
         lkZcKh7JmQg9xjbLnH9GRK+c0hnXZDbtIKuTMOZ3W57PY29jgpHVO/nMynDjGZGJIrHE
         K+YfMWeOJij4utbSUAv5OX9S+m1BpIwcShog7ZvylOCusbSalofndd2qgQ4SeOiXiyMG
         OuXv/60JgKFcucPFV41z8wupsn3Qp0MuPSHYvbPdYjVV6ld3eHhT9ofkMZeqrFjVqJ5z
         J7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqN+JRqBcM9sNS/bUUY7pxB30ldKatY72VtpGF2V5es=;
        b=TwT9afCWubtUZrvMEeyOVXi4M4bWuS9YMJLz7yyUdrrEZzqiWrzokInIyJabW1Hk48
         TnAU2DJvobnQm8zM7MY8VYCVWWJX0N4HZ5IAYkyzMjFlh8QnJhn5B1rqzIxElCMkvVnp
         jgKN5yJIpuXh6crJeq1dmsaTNTmicCIoMzezVEK/WEHCRgXNVmxGdSbrPsQpEbdQ31D+
         6FUjKGKvtyqF6+mqoeh1MZU3ab3flxQnDDu/h+iUauS368z8xFIWpJ8ss4yKrRePNTew
         3vUhIyJ3rLlm+TjxLCIEfY3kOBUXyW5F6e3aR/PQO+6nopJ6f/zzFM9yPucO5678u6vo
         scsQ==
X-Gm-Message-State: AOAM531WCNIXLRDc/qIT4P2+lESArRwyJ2xRz4VfDZax8q3McBGUeWby
        UAOgSj5NHTxjty3QYITpJLd6yq0sQ0ut4A==
X-Google-Smtp-Source: ABdhPJxQ7U6EWVfkoD2z5UQBGCWPgueMB34snJzWDFh8s4UoEucOWlQWof69mlCJK0R6lO73TdPodw==
X-Received: by 2002:a63:4b61:: with SMTP id k33mr1583047pgl.195.1597910209384;
        Thu, 20 Aug 2020 00:56:49 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id n17sm1570767pgg.6.2020.08.20.00.56.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] opp: Split out _opp_set_rate_zero()
Date:   Thu, 20 Aug 2020 13:26:33 +0530
Message-Id: <5a0183fa0b61cf70839fa90aa70f79e33ab4f60a.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
References: <cover.1597909885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Create separate routine _opp_set_rate_zero() to handle !target_freq
case.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0b437d483b75..4edd2c3d6d91 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -860,6 +860,34 @@ int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
 
+static int _opp_set_rate_zero(struct device *dev, struct opp_table *opp_table)
+{
+	int ret;
+
+	if (!opp_table->enabled)
+		return 0;
+
+	/*
+	 * Some drivers need to support cases where some platforms may
+	 * have OPP table for the device, while others don't and
+	 * opp_set_rate() just needs to behave like clk_set_rate().
+	 */
+	if (!_get_opp_count(opp_table))
+		return 0;
+
+	ret = _set_opp_bw(opp_table, NULL, dev, true);
+	if (ret)
+		return ret;
+
+	if (opp_table->regulators)
+		regulator_disable(opp_table->regulators[0]);
+
+	ret = _set_required_opps(dev, opp_table, NULL);
+
+	opp_table->enabled = false;
+	return ret;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -886,29 +914,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
-		ret = 0;
-
-		if (!opp_table->enabled)
-			goto put_opp_table;
-
-		/*
-		 * Some drivers need to support cases where some platforms may
-		 * have OPP table for the device, while others don't and
-		 * opp_set_rate() just needs to behave like clk_set_rate().
-		 */
-		if (!_get_opp_count(opp_table))
-			goto put_opp_table;
-
-		ret = _set_opp_bw(opp_table, NULL, dev, true);
-		if (ret)
-			goto put_opp_table;
-
-		if (opp_table->regulators)
-			regulator_disable(opp_table->regulators[0]);
-
-		ret = _set_required_opps(dev, opp_table, NULL);
-
-		opp_table->enabled = false;
+		ret = _opp_set_rate_zero(dev, opp_table);
 		goto put_opp_table;
 	}
 
-- 
2.25.0.rc1.19.g042ed3e048af

