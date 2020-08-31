Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C80257679
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHaJ1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgHaJ1O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 05:27:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D161C061573
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 02:27:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i13so2833401pjv.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU+ye3DFPZbAV6pQiN8wFPJa6aARNezf++/kyW/uVuI=;
        b=EpoiQoXcv7ag2BZboESNDV8ueXVg7gPRhJwh0HJmK0jjxVOplU9RU+KzVm9W9WqBC9
         JHHOX0WWO9bODH9Di16FMFHq8OzWErkqnpA9HXxWGtiN+LyEjiMmfESPZ+kv+Do6OqVX
         ifi6XiPNhiW9ZYjFRCo6WupZEH13dMoZ4x4+Y4VBrmhcq/1SAN4c6raMNNuV0n8rqLrR
         RPONK2LGjM13mM60e+GgF6Vl5vCeZJw5JbuMxChUkW5ixwPuVph9G2oEQpUYvLEuxAKh
         W7GxKOLwkKM/AuTgHjiG0ZocABjLNggfN5OauAJ0iUnqFcmhtB7mGUUisQm65OcULL5R
         qhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU+ye3DFPZbAV6pQiN8wFPJa6aARNezf++/kyW/uVuI=;
        b=lhWU1KPwD3xSFDcaOuIzdK/6xebwykweCZPfifn1f2UlqgGogn/ohGy22Ui8WfoT0W
         cWyCLHABdevUS6JMOZ2HIEbzn/31FjeImu8WUELyFZWrnEIk1xtCS3mUBz/b9aYv0hgH
         Jv+NChECKKpIqiQ4SLmZ+jJDJ/7jH7B4gxKkLNxDGPnG7bEVdVwJCNOYNORVbtkhRZIA
         rTv/tI9qNHFfSMoKXf4O8ByNOMP+Dp/JldQ8/iq1dJrz2vowKUAy9tPftHoI9mUmPatx
         aEdI5w7I3RIaKe0MJYo1LsJ5JFYzZQJ/2LXH+ke2nrMP6Fslbc5fUDSEbKgIkcwlfDoY
         nlZw==
X-Gm-Message-State: AOAM530cErZzz/d/3x1m2f/LuOlB8Y3TRwP3jcRUgVIQl70E16KAkLB0
        n8x4D2/+PzGy8R/s57V2fZA66Q==
X-Google-Smtp-Source: ABdhPJwMKSI/DxgWWVduGT7bfBgazAzmC0cUQbGNmOrklC5B/CSMw6tk2YWg7AIdKXeKpPRtr5YA9Q==
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr426722plo.320.1598866033880;
        Mon, 31 Aug 2020 02:27:13 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id h5sm7865081pfk.0.2020.08.31.02.27.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 02:27:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Don't drop reference for an OPP table that was never parsed
Date:   Mon, 31 Aug 2020 14:56:56 +0530
Message-Id: <922ff0759a16299e24cacfc981ac07914d8f1826.1598865786.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_remove_table() should drop a reference to the OPP table only
if the DT OPP table was parsed earlier with a call to
dev_pm_opp_of_add_table() earlier. Else it may end up dropping the
reference to the OPP table, which was added as a result of other calls
like dev_pm_opp_set_clkname(). And would hence result in undesirable
behavior later on when caller would try to free the resource again.

Fixes: 03758d60265c ("opp: Replace list_kref with a local counter")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 22 ++++++++++++++++------
 drivers/opp/opp.h  |  2 +-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9d7fb45b1786..31ce5d19ee9e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1291,13 +1291,19 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
-void _opp_remove_all_static(struct opp_table *opp_table)
+bool _opp_remove_all_static(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp, *tmp;
+	bool ret = true;
 
 	mutex_lock(&opp_table->lock);
 
-	if (!opp_table->parsed_static_opps || --opp_table->parsed_static_opps)
+	if (!opp_table->parsed_static_opps) {
+		ret = false;
+		goto unlock;
+	}
+
+	if (--opp_table->parsed_static_opps)
 		goto unlock;
 
 	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
@@ -1307,6 +1313,8 @@ void _opp_remove_all_static(struct opp_table *opp_table)
 
 unlock:
 	mutex_unlock(&opp_table->lock);
+
+	return ret;
 }
 
 /**
@@ -2409,13 +2417,15 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 		return;
 	}
 
-	_opp_remove_all_static(opp_table);
+	/*
+	 * Drop the extra reference only if the OPP table was successfully added
+	 * with dev_pm_opp_of_add_table() earlier.
+	 **/
+	if (_opp_remove_all_static(opp_table))
+		dev_pm_opp_put_opp_table(opp_table);
 
 	/* Drop reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
-
-	/* Drop reference taken while the OPP table was added */
-	dev_pm_opp_put_opp_table(opp_table);
 }
 
 /**
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e51646ff279e..c3fcd571e446 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -212,7 +212,7 @@ struct opp_table {
 
 /* Routines internal to opp core */
 void dev_pm_opp_get(struct dev_pm_opp *opp);
-void _opp_remove_all_static(struct opp_table *opp_table);
+bool _opp_remove_all_static(struct opp_table *opp_table);
 void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
-- 
2.25.0.rc1.19.g042ed3e048af

