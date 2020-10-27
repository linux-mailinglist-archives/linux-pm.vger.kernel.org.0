Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5646329A576
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 08:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgJ0HYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 03:24:50 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:44251 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507575AbgJ0HYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 03:24:49 -0400
Received: by mail-qk1-f202.google.com with SMTP id v186so228341qkb.11
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=v17o19+YnU8WUH8fPM9zqxvAIBUHHC5coCCN3OqBEHM=;
        b=oynU9DwRJ9SluUXFN93bnlTTy4ymlqK0CqOE1YOo3JTPeszIdnlN6uROW3ufaGCZWp
         t9Gk06jLjG2UyVr/TdJ3Kui3cu1OJ6pQpf4Q8wr6KFj7YCsTpAoYh9WGaVyZcbQP3v1+
         soecEoocP15De+14llSRA/Ilgt/ZVhzXvHigbuSbkgaHcMYoXwo3EZMCZD95mQJMHmer
         Wt4/6/p9EJWH/JBRCi9L9jJFUxkYOEahKwaaiXqTNQxizwMiApYXFIOopzh8ENW6iVaE
         tQu6zzA3vQ97fwbNNvaouMtH20xsxs4izoXn0b8MQjzvp/NygQvytF4n9223/pI0oWir
         jSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v17o19+YnU8WUH8fPM9zqxvAIBUHHC5coCCN3OqBEHM=;
        b=H+VuiFdQwiOOlrQhHnI1upmsayueFibEI4sEOV3oFeUuXcoeH2eQ4GG4+t5AaQzbkT
         MR7ooyYbEcgNVV2Z1PAJD4Va1r7OuhRl3W0by0CNp8EpwQQMcz3VtbBqhSiNKZUHIq2v
         r8eoylJ38B2CEzKvIqdGfZlJBRrJ+Gtk8RNYn7LcJWOaqWR47J0T73Xag76dY5tl7QUV
         Wtggn0uUy7q9qRvbdJWVrDF2mHta7NZBQ8PQ/3zS8i7Q6hGq5qOWgwRGQg7dqVg9L3Nw
         /1y5VWQ7WjsvjO5urpeumDpOcSTSLwL5zv6utyHrRnc0EDt0pDYvV2fNO1I4VjE/Nu48
         waUQ==
X-Gm-Message-State: AOAM530DT43cuiisiuwLvGttm8+xT+T4J5S4zyEa+OJxU2iMF/9ROV1w
        J8eNq34XTB5aDiAfczwRjGqa62TrKEZyAHdi
X-Google-Smtp-Source: ABdhPJyF+hUvH4GmtPOfeUj659ZHaxF7w2Z2JhfKgSbpggQryH0vXyTKRJHrl7GCPDq2BzhskMUe3bCjnwhF/BHn
Sender: "victording via sendgmr" <victording@victording.syd.corp.google.com>
X-Received: from victording.syd.corp.google.com ([2401:fa00:9:14:f693:9fff:fef4:fa73])
 (user=victording job=sendgmr) by 2002:a0c:e054:: with SMTP id
 y20mr1204435qvk.30.1603783487096; Tue, 27 Oct 2020 00:24:47 -0700 (PDT)
Date:   Tue, 27 Oct 2020 07:23:55 +0000
In-Reply-To: <20201027072358.13725-1-victording@google.com>
Message-Id: <20201027072358.13725-3-victording@google.com>
Mime-Version: 1.0
References: <20201027072358.13725-1-victording@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v3 2/4] powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
From:   Victor Ding <victording@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Victor Ding <victording@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch changes the static struct rapl_msr_priv to a pointer to allow
using a different set of RAPL MSR interface, preparing for supporting AMD's
RAPL MSR interface.

No functional changes.
Signed-off-by: Victor Ding <victording@google.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>


---

(no changes since v2)

Changes in v2:
By Kim Phillips <kim.phillips@amd.com>:
 - Added Kim's Acked-by.
 - Added Daniel Lezcano to Cc.
 - (No code changes).

 drivers/powercap/intel_rapl_msr.c | 33 +++++++++++++++++--------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 1646808d354c..a819b3b89b2f 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -31,7 +31,9 @@
 #define MSR_VR_CURRENT_CONFIG		0x00000601
 
 /* private data for RAPL MSR Interface */
-static struct rapl_if_priv rapl_msr_priv = {
+static struct rapl_if_priv *rapl_msr_priv;
+
+static struct rapl_if_priv rapl_msr_priv_intel = {
 	.reg_unit = MSR_RAPL_POWER_UNIT,
 	.regs[RAPL_DOMAIN_PACKAGE] = {
 		MSR_PKG_POWER_LIMIT, MSR_PKG_ENERGY_STATUS, MSR_PKG_PERF_STATUS, 0, MSR_PKG_POWER_INFO },
@@ -58,9 +60,9 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	struct rapl_package *rp;
 
-	rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
 	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_msr_priv);
+		rp = rapl_add_package(cpu, rapl_msr_priv);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -73,7 +75,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
 	if (!rp)
 		return 0;
 
@@ -136,40 +138,41 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
 	int ret;
 
-	rapl_msr_priv.read_raw = rapl_msr_read_raw;
-	rapl_msr_priv.write_raw = rapl_msr_write_raw;
+	rapl_msr_priv = &rapl_msr_priv_intel;
+	rapl_msr_priv->read_raw = rapl_msr_read_raw;
+	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 
 	if (id) {
-		rapl_msr_priv.limits[RAPL_DOMAIN_PACKAGE] = 3;
-		rapl_msr_priv.regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
+		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] = 3;
+		rapl_msr_priv->regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
 			MSR_VR_CURRENT_CONFIG;
 		pr_info("PL4 support detected.\n");
 	}
 
-	rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
-	if (IS_ERR(rapl_msr_priv.control_type)) {
+	rapl_msr_priv->control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
+	if (IS_ERR(rapl_msr_priv->control_type)) {
 		pr_debug("failed to register powercap control_type.\n");
-		return PTR_ERR(rapl_msr_priv.control_type);
+		return PTR_ERR(rapl_msr_priv->control_type);
 	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
 				rapl_cpu_online, rapl_cpu_down_prep);
 	if (ret < 0)
 		goto out;
-	rapl_msr_priv.pcap_rapl_online = ret;
+	rapl_msr_priv->pcap_rapl_online = ret;
 
 	return 0;
 
 out:
 	if (ret)
-		powercap_unregister_control_type(rapl_msr_priv.control_type);
+		powercap_unregister_control_type(rapl_msr_priv->control_type);
 	return ret;
 }
 
 static int rapl_msr_remove(struct platform_device *pdev)
 {
-	cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
-	powercap_unregister_control_type(rapl_msr_priv.control_type);
+	cpuhp_remove_state(rapl_msr_priv->pcap_rapl_online);
+	powercap_unregister_control_type(rapl_msr_priv->control_type);
 	return 0;
 }
 
-- 
2.29.0.rc2.309.g374f81d7ae-goog

