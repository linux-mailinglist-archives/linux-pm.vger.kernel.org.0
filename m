Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4D11E0A0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMJ14 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 04:27:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56422 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfLMJ1h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 04:27:37 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 3389f51032fc8655; Fri, 13 Dec 2019 10:27:34 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 02/10] ACPI: processor: Introduce acpi_processor_evaluate_cst()
Date:   Fri, 13 Dec 2019 10:12:50 +0100
Message-ID: <12144402.mclmRrL0h9@kreacher>
In-Reply-To: <3950312.2WmFeOdZGY@kreacher>
References: <3950312.2WmFeOdZGY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In order to separate the ACPI _CST evaluation from checks
specific to the ACPI processor driver, move the majority of
the acpi_processor_get_power_info_cst() function body to a new
function, acpi_processor_evaluate_cst(), that will extract
the C-states information from _CST output, and redefine
acpi_processor_get_power_info_cst() as a wrapper around it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from the RFC version.

---
 drivers/acpi/processor_idle.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dd737d836c03..e92d0e6d4cd1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -297,21 +297,17 @@ static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
 	return 0;
 }
 
-static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
+static int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
+				       struct acpi_processor_power *info)
 {
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *cst;
 	acpi_status status;
 	u64 count;
-	int current_count;
+	int current_count = 0;
 	int i, ret = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *cst;
-
-	if (nocst)
-		return -ENODEV;
 
-	current_count = 0;
-
-	status = acpi_evaluate_object(pr->handle, "_CST", NULL, &buffer);
+	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _CST, giving up\n"));
 		return -ENODEV;
@@ -335,9 +331,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		goto end;
 	}
 
-	/* Tell driver that at least _CST is supported. */
-	pr->flags.has_cst = 1;
-
 	for (i = 1; i <= count; i++) {
 		union acpi_object *element;
 		union acpi_object *obj;
@@ -383,7 +376,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		cx.entry_method = ACPI_CSTATE_SYSTEMIO;
 		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
 			if (acpi_processor_ffh_cstate_probe
-					(pr->id, &cx, reg) == 0) {
+					(cpu, &cx, reg) == 0) {
 				cx.entry_method = ACPI_CSTATE_FFH;
 			} else if (cx.type == ACPI_STATE_C1) {
 				/*
@@ -432,7 +425,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 			continue;
 
 		current_count++;
-		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
+		memcpy(&info->states[current_count], &cx, sizeof(cx));
 
 		/*
 		 * We support total ACPI_PROCESSOR_MAX_POWER - 1
@@ -446,12 +439,9 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		}
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d power states\n",
-			  current_count));
+	acpi_handle_info(handle, "Found %d idle states\n", current_count);
 
-	/* Validate number of power states discovered */
-	if (current_count < 2)
-		ret = -EFAULT;
+	info->count = current_count;
 
       end:
 	kfree(buffer.pointer);
@@ -459,6 +449,28 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 	return ret;
 }
 
+static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
+{
+	int ret;
+
+	if (nocst)
+		return -ENODEV;
+
+	ret = acpi_processor_evaluate_cst(pr->handle, pr->id, &pr->power);
+	if (ret)
+		return ret;
+
+	/*
+	 * It is expected that there will be at least 2 states, C1 and
+	 * something else (C2 or C3), so fail if that is not the case.
+	 */
+	if (pr->power.count < 2)
+		return -EFAULT;
+
+	pr->flags.has_cst = 1;
+	return 0;
+}
+
 static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 					   struct acpi_processor_cx *cx)
 {
-- 
2.16.4





