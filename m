Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4161A648562
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiLIP1i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiLIP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912EB8F0A7
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:40 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SA7aP9HJEm7lLpjdEMMhaStDXu4fW2+SsWEH6Sb1eQI=;
        b=EBh85ct9vfKmkxkSb9gGtbzgtwympWvbijVWoY9WKB4H4JRch5wk0eepKgl+MYbZKStkZ6
        eMfFy9r/1jiKnIY2hEH2QIADjNBFtBqKF14mH+Zc/K89DaRe3PPWO7DbX1gJNV71ovz8fJ
        8NUxHJzok7HKYzRcywpumH4JUhp3Gf3bgniilVzs0V/6AOLQdb/sXmtphLe4HsL4DyBUgA
        ZDNznLgTIH7lV4qg8T7Xfi/Nyq9FWY8N0uDEyPkvdQNs3CdqV4psI8ocEhkOP0V74+OKNY
        iVIQJMtF+4zodmlvqH7uAN+ziiekY/QwKI8Tdrb0boSgTfOiVrjX0+ylbAaO2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SA7aP9HJEm7lLpjdEMMhaStDXu4fW2+SsWEH6Sb1eQI=;
        b=UlHln5S4O4DU48D9ubVSPzlS7HcX+fKLhApAqjjFJprHfMLNWQki28oBeTCvEoicBOc8Bn
        T1hAH8pEYdcymsCg==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: hfi: ACK HFI for the same timestamp
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Arshad, Adeel" <adeel.arshad@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959687.4906.5952922094488556473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c0e3acdcdeb14099765de38224dfe0ad019c8482
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c0e3acdcdeb14099765de38224dfe0ad019c8482
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Wed, 16 Nov 2022 15:14:59 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 23 Nov 2022 20:13:22 +01:00

thermal: intel: hfi: ACK HFI for the same timestamp

Some processors issue more than one HFI interrupt with the same
timestamp. Each interrupt must be acknowledged to let the hardware issue
new HFI interrupts. But this can't be done without some additional flow
modification in the existing interrupt handling.

For background, the HFI interrupt is a package level thermal interrupt
delivered via a LVT. This LVT is common for both the CPU and package
level interrupts. Hence, all CPUs receive the HFI interrupts. But only
one CPU should process interrupt and others simply exit by issuing EOI
to LAPIC.

The current HFI interrupt processing flow:

  1. Receive Thermal interrupt
  2. Check if there is an active HFI status in MSR_IA32_THERM_STATUS
  3. Try and get spinlock, one CPU will enter spinlock and others
     will simply return from here to issue EOI.
    (Let's assume CPU 4 is processing interrupt)
  4. Check the stored time-stamp from the HFI memory time-stamp
  5. if same
  6.      ignore interrupt, unlock and return
  7. Copy the HFI message to local buffer
  8. unlock spinlock
  9. ACK HFI interrupt
 10. Queue the message for processing in a work-queue

It is tempting to simply acknowledge all the interrupts even if they
have the same timestamp. This may cause some interrupts to not be
processed.

Let's say CPU5 is slightly late and reaches step 4 while CPU4 is
between steps 8 and 9.

Currently we simply ignore interrupts with the same timestamp. No
issue here for CPU5. When CPU4 acknowledges the interrupt, the next
HFI interrupt can be delivered.

If we acknowledge interrupts with the same timestamp (at step 6), there
is a race condition. Under the same scenario, CPU 5 will acknowledge
the HFI interrupt. This lets hardware generate another HFI interrupt,
before CPU 4 start executing step 9. Once CPU 4 complete step 9, it
will acknowledge the newly arrived HFI interrupt, without actually
processing it.

Acknowledge the interrupt when holding the spinlock. This avoids
contention of the interrupt acknowledgment.

Updated flow:

  1. Receive HFI Thermal interrupt
  2. Check if there is an active HFI status in MSR_IA32_THERM_STATUS
  3. Try and get spin-lock
     Let's assume CPU 4 is processing interrupt
  4.1 Read MSR_IA32_PACKAGE_THERM_STATUS and check HFI status bit
  4.2	If hfi status is 0
  4.3		unlock spinlock
  4.4		return
  4.5 Check the stored time-stamp from the HFI memory time-stamp
  5. if same
  6.1      ACK HFI Interrupt,
  6.2	unlock spinlock
  6.3	return
  7. Copy the HFI message to local buffer
  8. ACK HFI interrupt
  9. unlock spinlock
 10. Queue the message for processing in a work-queue

To avoid taking the lock unnecessarily, intel_hfi_process_event() checks
the status of the HFI interrupt before taking the lock. If CPU5 is late,
when it starts processing the interrupt there are two scenarios:

 a) CPU4 acknowledged the HFI interrupt before CPU5 read
    MSR_IA32_THERM_STATUS. CPU5 exits.

 b) CPU5 reads MSR_IA32_THERM_STATUS before CPU4 has acknowledged the
    interrupt. CPU5 will take the lock if CPU4 has released it. It then
    re-reads MSR_IA32_THERM_STATUS. If there is not a new interrupt,
    the HFI status bit is clear and CPU5 exits. If a new HFI interrupt
    was generated it will find that the status bit is set and it will
    continue to process the interrupt. In this case even if timestamp
    is not changed, the ACK can be issued as this is a new interrupt.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Arshad, Adeel<adeel.arshad@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 65b9029..90a11ee 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -250,7 +250,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	struct hfi_instance *hfi_instance;
 	int cpu = smp_processor_id();
 	struct hfi_cpu_info *info;
-	u64 new_timestamp;
+	u64 new_timestamp, msr, hfi;
 
 	if (!pkg_therm_status_msr_val)
 		return;
@@ -279,9 +279,21 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	if (!raw_spin_trylock(&hfi_instance->event_lock))
 		return;
 
-	/* Skip duplicated updates. */
+	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr);
+	hfi = msr & PACKAGE_THERM_STATUS_HFI_UPDATED;
+	if (!hfi) {
+		raw_spin_unlock(&hfi_instance->event_lock);
+		return;
+	}
+
+	/*
+	 * Ack duplicate update. Since there is an active HFI
+	 * status from HW, it must be a new event, not a case
+	 * where a lagging CPU entered the locked region.
+	 */
 	new_timestamp = *(u64 *)hfi_instance->hw_table;
 	if (*hfi_instance->timestamp == new_timestamp) {
+		thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
 		raw_spin_unlock(&hfi_instance->event_lock);
 		return;
 	}
@@ -295,15 +307,15 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	memcpy(hfi_instance->local_table, hfi_instance->hw_table,
 	       hfi_features.nr_table_pages << PAGE_SHIFT);
 
-	raw_spin_unlock(&hfi_instance->table_lock);
-	raw_spin_unlock(&hfi_instance->event_lock);
-
 	/*
 	 * Let hardware know that we are done reading the HFI table and it is
 	 * free to update it again.
 	 */
 	thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
 
+	raw_spin_unlock(&hfi_instance->table_lock);
+	raw_spin_unlock(&hfi_instance->event_lock);
+
 	queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
 			   HFI_UPDATE_INTERVAL);
 }
