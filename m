Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362116B665
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfGQGNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:13:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34924 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQGNI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:13:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so4311469pgr.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98wHL3V8M3pNyD7AjD/VjmdvFc90F9O3DnpKK14WS+8=;
        b=DXblnYwgj3/tbURi1UsD4ktaRj5BJuWdPdDx2aRF+ahc2OC9u5xmYevXLh6oHpMwWy
         7hqdBA7l4KtXHRkTTp62+KZNyXi257cnXVrXLf6vLBCEEbHH6dTtIlPfeHxlkr+ZxR30
         aB/ZUGP/pdGBn7Dlttvi1kBzIrUqOn0biGEPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98wHL3V8M3pNyD7AjD/VjmdvFc90F9O3DnpKK14WS+8=;
        b=KhaBzNPdxez/dNspXYjYqIb7tXQ8SLWG9mRmOvpZTlPKZUP1FfIU4pWCTtumeYOEd5
         NLJ8vGz+99srwBzNzpwddmg/hepaLVs8tB3RFUspCQEfkA+7KgYMV3Z+ar95OMSzRbQd
         EKiW2N2k5mrlq/r86jT/XUX4tir6oUNwwilk1uzLN5BIS0kdlUHxEe0QJBlYuSR6QSyj
         MuLTBua4QazfghR5gporklk3RUCxDI4Ti89DfcDMRTJ9CD6yxeBlM8tzLrY1f3smw7zn
         EJacFcNX7eGWRLhQ7T7WbRvN0ms2WnMjSvZFz8btToFNDQon6c8GhR+V15cSLZs8LJgB
         0bkw==
X-Gm-Message-State: APjAAAVd4NqGgkFJ/hD64sCZGb43RL/TOYpR3bLgWc8pAc/Vm/EQQVj9
        rsyDJftrR43EwSGs27ppbQvqmA==
X-Google-Smtp-Source: APXvYqw0QPqTLvm4/cwncq8kMZs1M60f3vtMOpvmiHWE5FPXcczz63uk9yFFWGip4Q4mA9MXPHtqIg==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr42325982pjp.62.1563343987347;
        Tue, 16 Jul 2019 23:13:07 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id y23sm24079706pfo.106.2019.07.16.23.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 23:13:06 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/2] cpufreq: mediatek: Support vproc shared by multiple component
Date:   Wed, 17 Jul 2019 14:11:27 +0800
Message-Id: <20190717061124.453-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717061124.453-1-hsinyi@chromium.org>
References: <20190717061124.453-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

mt8183-cci shares vproc with small cluster. If the regulator is shared
between several devices then the lowest request voltage that meets the
system constraints will be used.

However, previous mediatek cpufreq implementation would cause race condition
if vproc is shared by multiple devices, which would crash device due to
incorrect voltage supply.

A race condition example:
cci sets vproc 90 --> vproc=90
cpu0 sets vproc 50 --> vproc=max(50,90)=90
cpu0 sets vproc 70 --> cpu0 reads vproc 90, target is lower, so decide to scale
                       up frequency first, but before it set voltage...
cci sets vproc 60 --> vproc=max(60,50)=60. cpu0 already set freq to 70, but
                      before it set voltage, vproc becomes 60, which is not
                      sufficient for cpu0.

Let cpu and cci manages their own previous target voltage can avoid such race.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 7282834e8fe2..f5e737b862f0 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -46,6 +46,7 @@ struct mtk_cpu_dvfs_info {
 	struct notifier_block opp_nb;
 	int opp_cpu;
 	unsigned long opp_freq;
+	int old_vproc;
 };
 
 static LIST_HEAD(dvfs_info_list);
@@ -196,11 +197,16 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 
 static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
 {
+	int ret;
+
 	if (info->need_voltage_tracking)
-		return mtk_cpufreq_voltage_tracking(info, vproc);
+		ret = mtk_cpufreq_voltage_tracking(info, vproc);
 	else
-		return regulator_set_voltage(info->proc_reg, vproc,
-					     vproc + VOLT_TOL);
+		ret = regulator_set_voltage(info->proc_reg, vproc,
+					     MAX_VOLT_LIMIT);
+	if (!ret)
+		info->old_vproc = vproc;
+	return ret;
 }
 
 static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
@@ -218,7 +224,9 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	inter_vproc = info->intermediate_voltage;
 
 	old_freq_hz = clk_get_rate(cpu_clk);
-	old_vproc = regulator_get_voltage(info->proc_reg);
+	old_vproc = info->old_vproc;
+	if (old_vproc == 0)
+		old_vproc = regulator_get_voltage(info->proc_reg);
 	if (old_vproc < 0) {
 		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
 		return old_vproc;
-- 
2.20.1

