Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6451999F
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiEDIZS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiEDIZR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 04:25:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668DE1EC6D
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 01:21:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so4594929pjq.0
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGHn8biVzkArfif1A3GGDNCCNtu9nk8kwnWV4EieXww=;
        b=ovuglYP6XIUlR99cJzmFGcviclvTUlrxiDBD5INA8pVtqhRoQM6hLt+Cff8YnmJkDa
         j1sZc375hNN0vGZXiwU3NCy5HBOt9CXrOjV8Lzs81sgXN/HjEi6lmPYAeTa3mxkqFIPc
         2GrKSv4JCXh6SwJMPQXFdmbalWFKhhK6BSDzuCu50kWn/usf3Fb3+3HwOZT6fdH/fyuy
         ipNn57BZf//zwh64eqnCaXAnV3mcPv2uvTgtbikkakLbcl6AisH+9L53vcXDJ9AwKDpi
         sdqxB4n8Xo+gV63I/b/PjIFLYcQ680Neg6R6HKhX0WDy2qDVbbcpRt+Kt+58Y9NsxZbs
         Px9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGHn8biVzkArfif1A3GGDNCCNtu9nk8kwnWV4EieXww=;
        b=WQPXIytHCqj4gPF0KD+6mV2ufoT+lJjD/tmJC/CF0A0ZXgQMMM2AOuTLqQrq/KHu+4
         Ou6xmAuvdeVnY0QD0PU5NUI0RQEsZ/tqB447x6nYeEOByX5Kov/OkmJh6xGHxbmLGr1h
         YCWj+fR5/Pp+aGbIj6y3OlH+WtWWLQMpASJSQsR6eFNNCixsBNySenJGIVotNzeh+35v
         42aFXYxXR4cDq6O4d6yvB/rzQV+HuDyNMy/6nc95ZodiHLhRUd3R0uE1+vrEyAMCAbEV
         dFimFWo6QOgM9CzJxDvq3X1RIUMg20HqBixUdxg3ke+cdoVBVx9CrJcFxO2VUEbsLM23
         8g1Q==
X-Gm-Message-State: AOAM533yzv7lRfS4YobYYr471z7FBmSLL5biGzoPrOqKTpjxhijwtAG8
        DxKnIVdxg8OZlSgVBQpwOc6/KA==
X-Google-Smtp-Source: ABdhPJy+Ar/gTjEhiBq3udBPTLyLW/kvpVmkDs3NrFb1w1kzCGG7xkVwWss2TJ8eHql/kS8ynEH0bQ==
X-Received: by 2002:a17:902:a406:b0:158:260d:1ed2 with SMTP id p6-20020a170902a40600b00158260d1ed2mr20541941plq.49.1651652501758;
        Wed, 04 May 2022 01:21:41 -0700 (PDT)
Received: from localhost ([122.162.207.161])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a550a00b001d954837197sm2639962pji.22.2022.05.04.01.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:21:41 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: Avoid unnecessary frequency updates due to mismatch
Date:   Wed,  4 May 2022 13:51:35 +0530
Message-Id: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For some platforms, the frequency returned by hardware may be slightly
different from what is provided in the frequency table. For example,
hardware may return 499 MHz instead of 500 MHz. In such cases it is
better to avoid getting into unnecessary frequency updates, as we may
end up switching policy->cur between the two and sending unnecessary
pre/post update notifications, etc.

This patch has chosen allows the hardware frequency and table frequency
to deviate by 1 MHz for now, we may want to increase it a bit later on
if someone still complains.

Reported-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0d58b0f8f3af..233e8af48848 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/tick.h>
+#include <linux/units.h>
 #include <trace/events/power.h>
 
 static LIST_HEAD(cpufreq_policy_list);
@@ -1708,6 +1709,16 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 		return new_freq;
 
 	if (policy->cur != new_freq) {
+		/*
+		 * For some platforms, the frequency returned by hardware may be
+		 * slightly different from what is provided in the frequency
+		 * table, for example hardware may return 499 MHz instead of 500
+		 * MHz. In such cases it is better to avoid getting into
+		 * unnecessary frequency updates.
+		 */
+		if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
+			return policy->cur;
+
 		cpufreq_out_of_sync(policy, new_freq);
 		if (update)
 			schedule_work(&policy->update);
-- 
2.31.1.272.g89b43f80a514

