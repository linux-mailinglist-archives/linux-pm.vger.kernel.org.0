Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3372625F107
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIFXKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 19:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgIFXKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 19:10:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FCC061574;
        Sun,  6 Sep 2020 16:10:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so13954200lja.7;
        Sun, 06 Sep 2020 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GL2e83YXWvqOYIIH9Yf2S3bCOInkKRYGV4eNfIULREw=;
        b=bN9fMPfk5k7AR0RXZmD3e2PZukleLU3FUD4l+Ua7NNZxShSPTZ8k8FS42qZFzmM3tk
         VjrhWPrca2egAqFJIC5Mh4znxN8A886Ilda96CebD/3fY7ctc1DLWm7G/OrmjGQ10lqF
         yMj5YCEt52zS/WsWt93oTSknUzvdi4mpVHtCiJ3cZNXzO59jW7KISibCakFfl2iVcEq8
         bgOCd/8DrXA9pv6hzf1s1c9kx3xTbUy9zlSkwXPU5DlIEwm0qw9+0AnRQtCK8bMTP6xL
         SoDsvmd9IaeJleRJ/E3WZEbKVKPc6X++bCxuVzXBscvFrJqszjlIBKKbKIh6yDiJ+ktg
         ijgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GL2e83YXWvqOYIIH9Yf2S3bCOInkKRYGV4eNfIULREw=;
        b=Qdv/PQtOlLbYAaDHNO5qLP2wHXiJN09uqEmFj/O4pClhUrHvfSFFQqT3p9LiJqUMHs
         o98hZcVu/Amo0g6cwb2oOQNqu/2FDMljb3OiUqRBMBgWKUHk2FoXE06XUX/tMU+PkGq6
         nopmw1d0OpQEKUConmlrZ+5c+m7cLrYvakxuviO4+z9cPpUvWizN+Db7m+GCFrK/6Svb
         XHa31HWsDznpBItKC5rrO4E6lv14efmNsmBbR9VT8J+yegX/WTCiuhpRAvmrB7bhWQYM
         t9+GQwCclvDUuwiMGgXODBCD1Kuv512tT3AfdcmFM90UZZPThta1WAlSJo5AWwH7q7pr
         26pg==
X-Gm-Message-State: AOAM531EVZRDun0DyUt0DJcib+JRW9GACBmrRjhBLczfSGMAv0IdmF/G
        3rxGkSuQ45Ci94bZhkBt7M0=
X-Google-Smtp-Source: ABdhPJxVzhLaV7RvltHlxIG8QGftcXErwcBG811EoA4VbDOXA7EkEe6eiPak6pfnC3MSgUxu1LxDxA==
X-Received: by 2002:a2e:91c5:: with SMTP id u5mr9091003ljg.278.1599433802219;
        Sun, 06 Sep 2020 16:10:02 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r17sm1325984ljp.117.2020.09.06.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 16:10:01 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
Date:   Mon,  7 Sep 2020 01:04:50 +0200
Message-Id: <20200906230452.33410-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The perf_ops are not modified through this pointer. Make them const to
indicate that. This is in preparation to make the scmi-ops pointers in
scmi_handle const.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index fb42e3390377..46b268095421 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -29,7 +29,7 @@ static const struct scmi_handle *handle;
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	struct scmi_data *priv = policy->driver_data;
 	unsigned long rate;
 	int ret;
@@ -50,7 +50,7 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	int ret;
 	struct scmi_data *priv = policy->driver_data;
-	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	u64 freq = policy->freq_table[index].frequency;
 
 	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
@@ -64,7 +64,7 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
-	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 
 	if (!perf_ops->freq_set(handle, priv->domain_id,
 				target_freq * 1000, true)) {
-- 
2.28.0

