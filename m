Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F156534E95
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiEZLvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiEZLvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:51:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83240D0286
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:51:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s14so1231285plk.8
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkz2dsQcdq8VoLgJuf+4xRTABrCVsHR/qCSkvr7/nrc=;
        b=W+zIJqWIAnNtDMXC64J9UUubmqB8QkQBkUYBIXLOKj311EPmc1jgvchw5SJZWrKHfp
         jHMyZxiX82kcbklSeJF7qm7Tknb6jf2yxBeCYVI+DFe+asQgOpFPaLGPJdhSuT3pUk+A
         yiMl5V3f36aPFAh3dL88wpJ3V5Xk6isXruwJ8OEyVptVArVh35qkRUDY1pBPjcxW82NG
         veFXYcZrPBgKbfVM2oxjiJtsIS2Y5K0MZx5YHmm6BWm/aKWHKMUTRIFSAn/PEEnGro6v
         aZH/U8lGxkBvdVW2a7z36xRAJhB7qdwSXtBYBFZ4GeLMAzE3/MxYiU5acayCwKbSfPBi
         elyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkz2dsQcdq8VoLgJuf+4xRTABrCVsHR/qCSkvr7/nrc=;
        b=xzVCPLt5Agqs50WjA00hw+ZfN/R1eA7qs2fBzmzKM7rBf4qoPYwCO/nspYEOh2FBY9
         fxTW53WmF7fjsISoFkP5en2lYki0l7rA+xmb+vfugNxbNNX1K46KVAm5eTE7tAjaLxBH
         5k8Z03oLJbTw+owGsHWjB+sFoZMYtJCmu5tZN2rSLit2pXH0HEWbu3GxL5Tx8Qn6c54J
         +frtdpi09a0XQW1Ms+90pwAabX8xLZ2Mi/mfh9IWJB/6D7z9ISWSrQw4Lkz0DAPRJDYp
         Yi+MaXrCCgrtL9nmYqr4hilEd49v4poQGgdltn/kynw5FrZ5jum7Qv2PDGcPBXKKgBwj
         PZ4w==
X-Gm-Message-State: AOAM532cpRhoH2ADozWk5XhkI42178qRyXiG4kF/my9kBLOV/FgUFJfL
        TilZgRUTt63PUfTx8AOWcKMxTA==
X-Google-Smtp-Source: ABdhPJx0Sxdx2kcAKXhchnTBeCUspjgJvQRJF9QJZzR4OnEVwhPRyUbOBpDtZEvUec2jXPVOApFUKg==
X-Received: by 2002:a17:902:dac3:b0:161:a5b5:c8c0 with SMTP id q3-20020a170902dac300b00161a5b5c8c0mr37146046plx.61.1653565893094;
        Thu, 26 May 2022 04:51:33 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902b11100b0015e8d4eb297sm1308401plr.225.2022.05.26.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:51:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cpufreq: Panic if policy is active in cpufreq_policy_free()
Date:   Thu, 26 May 2022 17:21:20 +0530
Message-Id: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653565641.git.viresh.kumar@linaro.org>
References: <cover.1653565641.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the new design in place, show/store callbacks check if the policy
is active or not before proceeding further and cpufreq_policy_free()
must be called after emptying policy->cpus mask, i.e. inactive policy.

Lets make sure we don't get a bug around this later and catch this early
by putting a BUG_ON() within cpufreq_policy_free().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e24aa5d4bca5..53d163a84e06 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1284,6 +1284,12 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	unsigned long flags;
 	int cpu;
 
+	/*
+	 * The callers must ensure the policy is inactive by now, to avoid any
+	 * races with show()/store() callbacks.
+	 */
+	BUG_ON(!policy_is_inactive(policy));
+
 	/* Remove policy from list */
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	list_del(&policy->policy_list);
-- 
2.31.1.272.g89b43f80a514

