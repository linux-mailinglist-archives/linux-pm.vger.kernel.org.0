Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3B4A39A0
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 22:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiA3VCW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 16:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiA3VCV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 16:02:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C964BC06173D
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso12323871wmj.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ithO/SYTnsee84comcLV1v8xrhItpMkDguw8atTZK/s=;
        b=pzxLkgSIDPizAvQzi/Z4rkcv9NnVAZUlnC7Xguxppjx+JOs1+blnWBzFAo0bW7wBHD
         GFNugIclNSwYRf11usjqo2OzHfSV7n2X4wFnXFSedyzuMtuJB4l5ZXUAK8RjG5GJjSgf
         UwnjgCRbYNvbDyetKo4KgomsuMyzmWzHgu8NUcXWtOwc8TWNQoteXKvp6WFTuQW8rTyJ
         o2J05bnnBwrWi4CtNhzNEH+lTYMaFOWsINcikp1i74eITClupp1F2bCXZqGs3PsL1EDm
         PxIaJBtt1BSVcZNUW2XiKie4EbS44JX0HDR071hB30F0QpOf+TMHLXA2l665kTYZwaeI
         VrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ithO/SYTnsee84comcLV1v8xrhItpMkDguw8atTZK/s=;
        b=ymqyixyFt3HQEXRwQMrryr9Mb28lXHU1sO7ww98Q61a87vyNRkj7tMYUsGkYrWUj7W
         brqyi3GHX4Y864Mja6K+j7omYiICw7I7UhQoEAjWTmmxOXoA9QLRPRsYEExbXIHkBepp
         p/oqimSirV0KfYW6eta2cIX0OlAFz/UvflDab2EqapR01pPfb6qdPWx3zGuBaFWJZxvN
         gyxDpHXn6sbnUJSl2C7n47xcYNzYj3anGai6f+95bNlvtVS1KVu5X43O2JtMhAhBGQPv
         1nh31/O7kYVMgt2a9201hsZHBklUSLgZc2TEZRCjVYFH/o9liuO5Q5iBMAq481dKAtN7
         JUBQ==
X-Gm-Message-State: AOAM530ozB36l3NVF3zGi2na09cxKor5F03Kr/lz2Noq9WLx93lFCe97
        SbbTdcp7Jb3UoM2ax3nLPkM1bg==
X-Google-Smtp-Source: ABdhPJzQBkb2Ykpl/FUs+I+2wd7ewr2SsnlQsLiH22Tebb5rc9YByWShua6Tl+JcrGciTh/6avWD5A==
X-Received: by 2002:a05:600c:694:: with SMTP id a20mr15648018wmn.186.1643576539319;
        Sun, 30 Jan 2022 13:02:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 4/7] powercap/dtpm: Destroy hierarchy function
Date:   Sun, 30 Jan 2022 22:02:06 +0100
Message-Id: <20220130210210.549877-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The hierarchy creation function exits but without a destroy hierarchy
function. Due to that, the modules creating the hierarchy can not be
unloaded properly because they don't have an exit callback.

Provide the dtpm_destroy_hierarchy() function to remove the previously
created hierarchy.

The function relies on all the release mechanisms implemented by the
underlying powercap framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dtpm.h    |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 7bddd25a6767..d9d74f981118 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -617,3 +617,46 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
+
+static void __dtpm_destroy_hierarchy(struct dtpm *dtpm)
+{
+	struct dtpm *child, *aux;
+
+	list_for_each_entry_safe(child, aux, &dtpm->children, sibling)
+		__dtpm_destroy_hierarchy(child);
+
+	/*
+	 * At this point, we know all children were removed from the
+	 * recursive call before
+	 */
+	dtpm_unregister(dtpm);
+}
+
+void dtpm_destroy_hierarchy(void)
+{
+	int i;
+
+	mutex_lock(&dtpm_lock);
+
+	if (!pct)
+		goto out_unlock;
+
+	__dtpm_destroy_hierarchy(root);
+	
+
+	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
+
+		if (!dtpm_subsys[i]->exit)
+			continue;
+
+		dtpm_subsys[i]->exit();
+	}
+
+	powercap_unregister_control_type(pct);
+
+	pct = NULL;
+
+out_unlock:
+	mutex_unlock(&dtpm_lock);
+}
+EXPORT_SYMBOL_GPL(dtpm_destroy_hierarchy);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index f7a25c70dd4c..a4a13514b730 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -37,6 +37,7 @@ struct device_node;
 struct dtpm_subsys_ops {
 	const char *name;
 	int (*init)(void);
+	void (*exit)(void);
 	int (*setup)(struct dtpm *, struct device_node *);
 };
 
@@ -67,4 +68,6 @@ void dtpm_unregister(struct dtpm *dtpm);
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
 int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);
+
+void dtpm_destroy_hierarchy(void);
 #endif
-- 
2.25.1

