Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772AC258CBA
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIAK12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIAK11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 06:27:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2DC061245
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 03:27:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o68so545024pfg.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpn9D/5jf8Cl22DmcPIsP0D+8jPdGfJ5t9xD++zoV1Y=;
        b=tk/7VJW1f+B+d95M0Sy7avts3U1k6DUjgFMhJuU1znFnZ+74BtL+25cGrXcRehXyX+
         3oBs28+vr+MiH7bp1nKwcRuK8fqq5HZoZ5aUojM2/4bF4Hh8aoNHubPGlMZkEzr/AHtH
         N3eISZ78fEOZPQbtjjLM59p97evtmvWwMieOYQrQEM1bwxPogJq8m3n0s3axUTkMAV0i
         GI82DiLS2enBEh4KJKTnyRljMFBHIp5jb68ZrDBBUGiQKCpDXJJfX0aDMqJ51+ITJY8n
         I8BSLwfr9A1aYCOKzMMYtB3GueAvRNZR26g8vI0/IrMknt4YGwkg6xq+8VJET5ea/vT1
         bnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpn9D/5jf8Cl22DmcPIsP0D+8jPdGfJ5t9xD++zoV1Y=;
        b=oGOkb3cW34wmvYO5XO2rEfj/5Fx8bYtVAKPScfeysR+HM2MxDoKpYJQaefszavZR3Z
         9RRv8RUySbXrVRHLa3mdnJxlavdwMWrhaNsVO7PpdYoWxjIlrwhjmMnGY3DLexezhJ8D
         QqWP7YE/KRNKmMOoJR3fLaSsA76cs4g0HCTgyUysU8siCEtz04ndIHIHWy2Gh8Qpbskv
         mi7tyQn7MeSOZEsB6CTqdHjsvTY/dTaSoIMKU2eS5Gq2nDym8fQmWowAF5Hb43/wEiYN
         2gQSiikvdc4QinoaQNnSWn0yJdlUghTo/BJL+s3NxG9il7SfiXilJ9mzw5PiznZO0VLi
         sqSA==
X-Gm-Message-State: AOAM532K2B/AaV6TdF4NHcKtiUp21/kznuiMywOlv09j22nmYW2DYKBd
        95OM6UzzUQWyVsz1ieQqnjxc0w==
X-Google-Smtp-Source: ABdhPJyAoTXZaC+iT5BOYZfnb359nfLCt/TY8um+EGWfET2XBrG/hBr5Oh1T2GiOkJ2tbRfhoWcYGQ==
X-Received: by 2002:a63:4401:: with SMTP id r1mr881229pga.331.1598956046238;
        Tue, 01 Sep 2020 03:27:26 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id h11sm1419135pfq.101.2020.09.01.03.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 03:27:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, stephan@gerhold.net,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()
Date:   Tue,  1 Sep 2020 15:57:18 +0530
Message-Id: <99f1c7ff37b00d2f59fbce9d934abf23932363c5.1598956021.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Until now for V1 OPP bindings we used to call
dev_pm_opp_of_cpumask_add_table() first and then
dev_pm_opp_set_sharing_cpus() in the cpufreq-dt driver.

A later patch will though update the cpufreq-dt driver to optimize the
code a bit and we will call dev_pm_opp_set_sharing_cpus() first followed
by dev_pm_opp_of_cpumask_add_table(), which doesn't work well today as
it tries to re parse the OPP entries. This should work nevertheless for
V1 bindings as the same works for V2 bindings.

Adapt the same approach from V2 bindings and fix this.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index d8b623cc015a..6fc56660fa52 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -886,6 +886,16 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	const __be32 *val;
 	int nr, ret = 0;
 
+	mutex_lock(&opp_table->lock);
+	if (opp_table->parsed_static_opps) {
+		opp_table->parsed_static_opps++;
+		mutex_unlock(&opp_table->lock);
+		return 0;
+	}
+
+	opp_table->parsed_static_opps = 1;
+	mutex_unlock(&opp_table->lock);
+
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop)
 		return -ENODEV;
@@ -902,10 +912,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		return -EINVAL;
 	}
 
-	mutex_lock(&opp_table->lock);
-	opp_table->parsed_static_opps = 1;
-	mutex_unlock(&opp_table->lock);
-
 	val = prop->value;
 	while (nr) {
 		unsigned long freq = be32_to_cpup(val++) * 1000;
-- 
2.25.0.rc1.19.g042ed3e048af

