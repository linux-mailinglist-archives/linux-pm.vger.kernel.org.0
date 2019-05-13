Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454321BC81
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfEMR70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 13:59:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33076 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbfEMR70 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 13:59:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so6853771plp.0;
        Mon, 13 May 2019 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=qcB7eahk6uost1tJIP3FkNXq29ur/hHJU+gIkVwerH0=;
        b=EqSqLmhMIhEkXb3UcdqmqEmzeSp707LwHp6ezi/bvRsnucBBCEXvSq4O9R8NC6zHF5
         ulS+KZxKDCFHMEIWTTnPeY9mTFiB9X1nPInsYPNip12OAXQzb0NROacov01np1oB3NdZ
         PPfepVT7ImuaWsKsm6yF/6/tT2ZL73UDrab34UjcHvhc+8LRZCzRxYChXEN9FKe4+zoi
         Bw1oB/b/K/xZc28QVgMEPzsEf/YKNvj7GGu7oMDSBJUys5s5HflHBS0xqzwsZBLAvyMU
         RU+dWfmFwTuYRwJIv0frRSIqV+ABtyGVp8f+opIbd8PL9WfY2FG90mART1HB76LX0KS3
         rsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=qcB7eahk6uost1tJIP3FkNXq29ur/hHJU+gIkVwerH0=;
        b=hGaleaAxOiXsh+6gKGbwvkoJh/tP/2L+VwSTNxfLIuwgAp14DtSQLuVl9yAUTxKxDo
         DOZZPQ2i7+ituQXNYMyOCrG43m/sBsMtJHM/yrKLr5f9mDjUh9RJBx+ng1idrSlKy7Fk
         QN14ANWQMnwpc6bLDjceUeyyQmj/Vds9ZSNTGU0ZoezLMU6MXzTBwHeJa9MMyzROjc3J
         u/pSFafdj9LkQ+nztcj7uOMIiNMTyi4RQZ/L5+BUyGrlPheVDH5TNmv4grJ2EtYJWz1u
         okL3vzFUX8Z6nBwTJjSfQ4x0z0kUAEh0VuEbghr44hD6VL57+k3DD8Sd+U0Ieq1dMpcs
         vclQ==
X-Gm-Message-State: APjAAAVHm6NkNnPNmhyyfbZbe657PMr/Kfy9RnKqxL91PH/Bnw28JTfB
        A6UBmlCMK1c/dHcSqX0Vo9g=
X-Google-Smtp-Source: APXvYqxfD9OoJX+0baCGAS7WdKoGeDR3he1a1v7D1nhmn/LwAQauslfOBU4jr2py1g5X8O99vPOBWg==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr16127280plb.300.1557770365565;
        Mon, 13 May 2019 10:59:25 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:24 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 07/19] powercap/intel_rapl: Support multi-die/package
Date:   Mon, 13 May 2019 13:58:51 -0400
Message-Id: <9fcb4719aeb7efccf3bc75ed8dd559e46121649f.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

RAPL "package" domains are actually implemented in hardware per-die.
Thus, the new multi-die/package systems have mulitple domains
within each physical package.

Update the intel_rapl driver to be "die aware" -- exporting multiple
domains within a single package, when present.
No change on single die/package systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3c3c0c23180b..9202dbcef96d 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package_domain(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1459,7 +1459,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
-- 
2.18.0-rc0

