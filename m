Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8172204907
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 07:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgFWFPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 01:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFWFPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 01:15:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B765C061573
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 22:15:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f9so704287pfn.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 22:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3phtSZElnKhAKAsJ0GkPo5emlqkKBgqm+SMemI7XzZE=;
        b=yTd34Wi8nuuX1GjOPwJKiPvV3apHnv1PBY5cE3Txgjq7ZhCA5x5CVfF/3zOXQLo+RA
         UNoQkrET3GF3kqKwRgcoppDliQzeTcK5pE8JNYIku0KWis95i5MicFo/DyTaGlMENdEY
         OFOz6j8HmYJpWGOqHNoD3yOZh32eNXcWVEGB/n87Lt2YBNoQ3uq5eoV3lQCNVvD/6zvb
         a+tOvufVyKXv4E1Jb7Jum/3U8uqBsq1WG1sfdom6B0K1GUaIJcK3oShUwQo1MLjAcAZ5
         3paxC0VY98zUkGERCN58qkatsvsXvocT/RKh02WsluOPObokqUMkHKtqRAP/q3VBhzu3
         RO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3phtSZElnKhAKAsJ0GkPo5emlqkKBgqm+SMemI7XzZE=;
        b=mNgEvk+NYXn7tXAikF6cFZBBxWU/DIiqEXCM5OU+xQE34L7Q4iyOM+32yz2bYsnfsF
         VVV/rWruMZUmYLMUe35wXjN4jvV4bG/x8gcLfeIECA/0xjBx0vFLysLVYFWsiBH4iCKs
         Sii5M0BCRss6bhUyUPkwDC+2AoTO80i21mNeZre1SJLwyJDJXbjRZZvjp6ObtQ6W0hGT
         7mwZyrS1hB0/+1sqWtdtj55LqFzOb2kaO6pY4eNzeCj7YRHt0ARFltI30qFjNk3l0Tmv
         OdfNScZaFGU7pUCaao0h30t4UoF97WCwxINUlNW9FK2hCV2CIOI+JPauSmmnvGTf5eED
         pBKg==
X-Gm-Message-State: AOAM531+oVhu8Iji72Zg9p4Q/iWVHzmDnBDarq9aQhuV46pVq+CbKjZ4
        OqmWsyVf1OEXk8/YRNA94M7Pqg==
X-Google-Smtp-Source: ABdhPJxDJmmDQujdEzvEsZ71dYVPCTHV1QA8cJuQCCak03eaFvWu2zff1mtJNhHPc1SW3zuBJ0uUaw==
X-Received: by 2002:aa7:9184:: with SMTP id x4mr23054383pfa.271.1592889317007;
        Mon, 22 Jun 2020 22:15:17 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id o1sm16562358pfu.70.2020.06.22.22.15.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 22:15:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: cppc: Reorder code and remove apply_hisi_workaround variable
Date:   Tue, 23 Jun 2020 10:45:11 +0530
Message-Id: <b217dc843935e3f86584a73893d330fd99a4e472.1592889188.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the current approach we have an extra check in the
cppc_cpufreq_get_rate() callback, which checks if hisilicon's get rate
implementation should be used instead. While it works fine, the approach
isn't very straight forward, over that we have an extra check in the
routine.

Rearrange code and update the cpufreq driver's get() callback pointer
directly for the hisilicon case. This gets the extra variable is removed
and the extra check isn't required anymore as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Xiongfeng Wang, will it be possible for you to give this a try as I
can't really test it locally.

 drivers/cpufreq/cppc_cpufreq.c | 91 ++++++++++++++++------------------
 1 file changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 257d726a4456..03a21daddbec 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -45,8 +45,6 @@ struct cppc_workaround_oem_info {
 	u32 oem_revision;
 };
 
-static bool apply_hisi_workaround;
-
 static struct cppc_workaround_oem_info wa_info[] = {
 	{
 		.oem_id		= "HISI  ",
@@ -59,50 +57,6 @@ static struct cppc_workaround_oem_info wa_info[] = {
 	}
 };
 
-static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
-					unsigned int perf);
-
-/*
- * HISI platform does not support delivered performance counter and
- * reference performance counter. It can calculate the performance using the
- * platform specific mechanism. We reuse the desired performance register to
- * store the real performance calculated by the platform.
- */
-static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
-{
-	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
-	u64 desired_perf;
-	int ret;
-
-	ret = cppc_get_desired_perf(cpunum, &desired_perf);
-	if (ret < 0)
-		return -EIO;
-
-	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
-}
-
-static void cppc_check_hisi_workaround(void)
-{
-	struct acpi_table_header *tbl;
-	acpi_status status = AE_OK;
-	int i;
-
-	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
-	if (ACPI_FAILURE(status) || !tbl)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
-		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
-		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
-		    wa_info[i].oem_revision == tbl->oem_revision) {
-			apply_hisi_workaround = true;
-			break;
-		}
-	}
-
-	acpi_put_table(tbl);
-}
-
 /* Callback function used to retrieve the max frequency from DMI */
 static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 {
@@ -402,9 +356,6 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
 	int ret;
 
-	if (apply_hisi_workaround)
-		return hisi_cppc_cpufreq_get_rate(cpunum);
-
 	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
 	if (ret)
 		return ret;
@@ -455,6 +406,48 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.name = "cppc_cpufreq",
 };
 
+/*
+ * HISI platform does not support delivered performance counter and
+ * reference performance counter. It can calculate the performance using the
+ * platform specific mechanism. We reuse the desired performance register to
+ * store the real performance calculated by the platform.
+ */
+static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
+	u64 desired_perf;
+	int ret;
+
+	ret = cppc_get_desired_perf(cpunum, &desired_perf);
+	if (ret < 0)
+		return -EIO;
+
+	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
+}
+
+static void cppc_check_hisi_workaround(void)
+{
+	struct acpi_table_header *tbl;
+	acpi_status status = AE_OK;
+	int i;
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
+	if (ACPI_FAILURE(status) || !tbl)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
+		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    wa_info[i].oem_revision == tbl->oem_revision) {
+			/* Overwrite the get() callback */
+			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
+			break;
+		}
+	}
+
+	acpi_put_table(tbl);
+}
+
 static int __init cppc_cpufreq_init(void)
 {
 	int i, ret = 0;
-- 
2.25.0.rc1.19.g042ed3e048af

