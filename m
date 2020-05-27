Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E61E36DF
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 06:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgE0EHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 00:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgE0EHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 00:07:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75EAC03E97B
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 21:07:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e11so10295809pfn.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 21:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIU60IIBCZmiBBYjlcnA3+Z62eyxZftbez2P4JhOGz0=;
        b=ji07iUmsxzL5OTjKkByLDlUB9yuFIIUDKEFDffRLh2WLg3PTMsr6gSb9aheyF3dWhh
         1jydjFmU3me6Rzh9/791mf0yg0KRn+554youg0XUgm0UhIxYmjOWMYL0dHTWV6hcQHam
         vD11UOkYMs3OZhZ1ipCE+9NTk5e7I45zuOgNzN3YR9POohMHq9J2BhuX5M0OVyuSSZCF
         1oJJDFWV3b29m/lTzMVeTdpDzympPTsyXD1GlKasOpkWvFiCFoUUISyrhQIwOxi8y5Nq
         DhshdPhvEOIoasTQo8YXczmzazKd6u3OHZtodB7NuH1u/lcW4x3RUTh/3cQ+Bn9T2FZj
         RGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIU60IIBCZmiBBYjlcnA3+Z62eyxZftbez2P4JhOGz0=;
        b=EFK2SkmTei0+F5CWHwLdQ4go5ib7G4QV1+Ph7QH8vrc2L2JLnQPwQWIaLamPJepM4m
         v9aFqMjXcbe3Yltj/5TQIhgE5aVK1Z+EQLShcWR5Q8qxVO8PWVLMxBEYpSxl8LQlC1Ff
         6+6m7yhuRrpgwTNo95XSht4pRiJgpOjnTyyzqOtYg4dC7f5gPqcyDJ+OQJvpOK27pslG
         YWhiN3Xo035hLVmehRiVktTKG3yyqb1Fz5e+B80h44ziooZlh6y/7HaUSmhFJ+2H/ITD
         sCB5EKmwhjO+h6D3P7TNpOg2VIvU1h5jiVXcUoyN6ChxWhkJplHTmxGZbkfk8D20EixZ
         K2jg==
X-Gm-Message-State: AOAM531S6IPfdL/wuSuyAWX4/wjbkvT7eG26/ua/wmij+zx4ZjiMu7n2
        fHUbsZ+U0pyuIdXlVzS5+ZFJmA==
X-Google-Smtp-Source: ABdhPJzEM29IyiSEssb7QXL96O/HQMHYQ/moyf5cAXSnMKK0zq8bqWNjRk5L63foZs2z2MdlVxuWbw==
X-Received: by 2002:aa7:928e:: with SMTP id j14mr1939135pfa.261.1590552466476;
        Tue, 26 May 2020 21:07:46 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id u69sm848927pjb.40.2020.05.26.21.07.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 21:07:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, georgi.djakov@linaro.org,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Remove bandwidth votes when target_freq is zero
Date:   Wed, 27 May 2020 09:37:36 +0530
Message-Id: <a761681456ef6b8c9a98918c130a0b402caf90c4.1590552303.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We already drop several votes when target_freq is set to zero, drop
bandwidth votes as well.

Reported-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Georgi/Sibi: Sibi requested this change, please test this out.

 drivers/opp/core.c | 47 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 56d3022c1ca2..0c259d5ed232 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -725,6 +725,34 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	return ret;
 }
 
+static int _set_opp_bw(const struct opp_table *opp_table,
+		       struct dev_pm_opp *opp, bool remove)
+{
+	u32 avg, peak;
+	int i, ret;
+
+	if (!opp_table->paths)
+		return 0;
+
+	for (i = 0; i < opp_table->path_count; i++) {
+		if (remove) {
+			avg = 0;
+			peak = 0;
+		} else {
+			avg = opp->bandwidth[i].avg;
+			peak = opp->bandwidth[i].peak;
+		}
+		ret = icc_set_bw(opp_table->paths[i], avg, peak);
+		if (ret) {
+			dev_err(dev, "Failed to %s bandwidth[%d]: %d\n",
+				remove ? "remove" : "set", i, ret);
+			retrun ret;
+		}
+	}
+
+	return 0;
+}
+
 static int _set_opp_custom(const struct opp_table *opp_table,
 			   struct device *dev, unsigned long old_freq,
 			   unsigned long freq,
@@ -837,12 +865,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (!_get_opp_count(opp_table))
 			return 0;
 
-		if (!opp_table->required_opp_tables && !opp_table->regulators) {
+		if (!opp_table->required_opp_tables && !opp_table->regulators &&
+		    !opp_table->paths) {
 			dev_err(dev, "target frequency can't be 0\n");
 			ret = -EINVAL;
 			goto put_opp_table;
 		}
 
+		ret = _set_opp_bw(opp_table, opp, true);
+		if (ret)
+			return ret;
+
 		if (opp_table->regulator_enabled) {
 			regulator_disable(opp_table->regulators[0]);
 			opp_table->regulator_enabled = false;
@@ -932,16 +965,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
-	if (!ret && opp_table->paths) {
-		for (i = 0; i < opp_table->path_count; i++) {
-			ret = icc_set_bw(opp_table->paths[i],
-					 opp->bandwidth[i].avg,
-					 opp->bandwidth[i].peak);
-			if (ret)
-				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
-					i, ret);
-		}
-	}
+	if (!ret)
+		ret = _set_opp_bw(opp_table, opp, false);
 
 put_opp:
 	dev_pm_opp_put(opp);
-- 
2.25.0.rc1.19.g042ed3e048af

