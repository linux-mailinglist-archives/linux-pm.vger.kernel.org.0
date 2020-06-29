Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9120E240
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbgF2VDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgF2TMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:12:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8397FC0147C7
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:25:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so7161309pgg.10
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9cN6j0Ra4hTEQxVvKv02zIobt4Y/RvzU1LBCy2puJqU=;
        b=Qgec2BJkq7UooQ/OTJc/ye/hxVhyPLlqi9ITafcrZQh0NONrh9LallTFIsrjUAwteY
         Dxqj09oQUh23HK2po7xV3g5ppKJ6LdmlFXjvcXU9tLMADtodwCAVk7W6mbIm0Vjvkvhl
         VQFtUPTrEsrutiSPI2UK72jylfkeUtvToUOY0RAj/WMfkUE2yV2kcFCV9fMhckkh5F68
         6cTRfyN+70n5zoPOCGBYnoKLNAwQbhXHcuWMjA8OOdvRBcFoUYOBeZHdiqMKIN/LHfK+
         BXW8Rus3omR3mCmviN38JBCDpsatBJAKEKvUcJ1UYyy0L3xF7r6YEATZ+158GbnEuCLa
         UXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cN6j0Ra4hTEQxVvKv02zIobt4Y/RvzU1LBCy2puJqU=;
        b=Dd/vANR5iaCqRU2Nd6GCOM8tX4zlwKC6Z/HEbmV/+5uDcjxk+9JukGhePrKdiMeydk
         urq0iex1fWcU8LkEEE0zuhJJ5QxefanJOxCJ1qxQLTaOUKiCDy3ZMh0rMOZr/KeIz8a+
         XoouqmB4jQn0U8PzeyZOf8vlt8vTFl413VF9MKsrpCNf7eCYe0iAxJGbaOJsoQAxT/ik
         EEzsr/FRNDwx2SlnqQcvP7GGAiWvnu5yS0CdR+Av03UMUw2LxfEmZ5U0X2LH5A3XVU0W
         +r3EDIRgKHgLe+dglQNLv7XiLe+sKPBMfshkMa5HwmQQsd/smS0aUxf4h4vTAW1nuEx/
         BVFA==
X-Gm-Message-State: AOAM5309XQi9wpuqJEkk8pGhRyVPoek0gtPfi4U5SClR+eK9DIX0Vx07
        ragRAioFXSdM0MqxZibSvWB+Ag==
X-Google-Smtp-Source: ABdhPJy88bXkx/N/KFZoZOZgrWhDp//E4ZzApQLzxh5Z0Ohkn7kvLmtrWT1NrP9Wp7nV2sIq4HRrcw==
X-Received: by 2002:a62:1692:: with SMTP id 140mr13937131pfw.168.1593419111080;
        Mon, 29 Jun 2020 01:25:11 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id h7sm8404191pfq.15.2020.06.29.01.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 01:25:10 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] cpufreq: Fix locking issues with governors
Date:   Mon, 29 Jun 2020 13:54:58 +0530
Message-Id: <fdc55a7550a6a6a95dab1c80ff94d461b8ba0664.1593418662.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1593418662.git.viresh.kumar@linaro.org>
References: <cover.1593418662.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The locking around governors handling isn't adequate currently. The list
of governors should never be traversed without locking in place. Also we
must make sure the governor isn't removed while it is still referenced
by code.

Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 58 +++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0128de3603df..e9e8200a0211 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -621,6 +621,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 	return NULL;
 }
 
+static struct cpufreq_governor *get_governor(const char *str_governor)
+{
+	struct cpufreq_governor *t;
+
+	mutex_lock(&cpufreq_governor_mutex);
+	t = find_governor(str_governor);
+	if (!t)
+		goto unlock;
+
+	if (!try_module_get(t->owner))
+		t = NULL;
+
+unlock:
+	mutex_unlock(&cpufreq_governor_mutex);
+
+	return t;
+}
+
 static unsigned int cpufreq_parse_policy(char *str_governor)
 {
 	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
@@ -640,28 +658,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
 {
 	struct cpufreq_governor *t;
 
-	mutex_lock(&cpufreq_governor_mutex);
-
-	t = find_governor(str_governor);
-	if (!t) {
-		int ret;
-
-		mutex_unlock(&cpufreq_governor_mutex);
-
-		ret = request_module("cpufreq_%s", str_governor);
-		if (ret)
-			return NULL;
-
-		mutex_lock(&cpufreq_governor_mutex);
+	t = get_governor(str_governor);
+	if (t)
+		return t;
 
-		t = find_governor(str_governor);
-	}
-	if (t && !try_module_get(t->owner))
-		t = NULL;
-
-	mutex_unlock(&cpufreq_governor_mutex);
+	if (request_module("cpufreq_%s", str_governor))
+		return NULL;
 
-	return t;
+	return get_governor(str_governor);
 }
 
 /**
@@ -815,12 +819,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 		goto out;
 	}
 
+	mutex_lock(&cpufreq_governor_mutex);
 	for_each_governor(t) {
 		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
 		    - (CPUFREQ_NAME_LEN + 2)))
-			goto out;
+			break;
 		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
 	}
+	mutex_unlock(&cpufreq_governor_mutex);
 out:
 	i += sprintf(&buf[i], "\n");
 	return i;
@@ -1058,15 +1064,17 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 	struct cpufreq_governor *def_gov = cpufreq_default_governor();
 	struct cpufreq_governor *gov = NULL;
 	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
+	int ret;
 
 	if (has_target()) {
 		/* Update policy governor to the one used before hotplug. */
-		gov = find_governor(policy->last_governor);
+		gov = get_governor(policy->last_governor);
 		if (gov) {
 			pr_debug("Restoring governor %s for cpu %d\n",
 				 policy->governor->name, policy->cpu);
 		} else if (def_gov) {
 			gov = def_gov;
+			__module_get(gov->owner);
 		} else {
 			return -ENODATA;
 		}
@@ -1089,7 +1097,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 			return -ENODATA;
 	}
 
-	return cpufreq_set_policy(policy, gov, pol);
+	ret = cpufreq_set_policy(policy, gov, pol);
+	if (gov)
+		module_put(gov->owner);
+
+	return ret;
 }
 
 static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
-- 
2.25.0.rc1.19.g042ed3e048af

