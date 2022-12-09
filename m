Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE664856D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiLIP1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59098F70A
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:42 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n1Yv7x4DAhLB1jZ5aV02TrryESpXZ6xL+NjPjWCPf0Q=;
        b=3MXY577iAmDN0FCZgnNB09V7/TduDlmbCrf/gNTPfBstc1CRyHwfnt5iPzR1BcFDCOTG37
        N0c0zdhI6EmtYBtIaGSlHjheqUhy9HrgdYdmAoPbgTGQlaRhxSulNEUN8ZDKL/Eaiec2q2
        RndxuO1qMIM5xQwQsRDzwJVFMFe5w6igP37XDYvQ8SJTem28fXGTuWS7RwXXBUvNQZgt6S
        khWy+ZzCTd1rP3RDMCNO185fB9YMhL9ZUjy50MYn2ltBydqGoDMz1vGCN/f51/sqES19so
        j3pq3+9Kjlm4odwzbB8Weho97c+WTxPvwlwPdRW+EpxZt0vqRmZsZeGiZUA2cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n1Yv7x4DAhLB1jZ5aV02TrryESpXZ6xL+NjPjWCPf0Q=;
        b=Ol9NfAIXM/o8hVXyngPpBZG5Cb8zLaZ5Uxyhe0WpS3YI72//A8+zTN+q1msiydV58xRerS
        bpIjr8aCGW85mmDg==
From:   "thermal-bot for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: hfi: Improve the type of
 hfi_features::nr_table_pages
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959938.4906.9514132250300945843.tip-bot2@tip-bot2>
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

Commit-ID:     54d9135cf223f221546bd51b0f5e4a73e99891f4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//54d9135cf223f221546bd51b0f5e4a73e99891f4
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Tue, 18 Oct 2022 04:22:40 -07:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Fri, 28 Oct 2022 20:11:48 +02:00

thermal: intel: hfi: Improve the type of hfi_features::nr_table_pages

A Coverity static code scan raised a potential overflow_before_widen
warning when hfi_features::nr_table_pages is used as an argument to
memcpy in intel_hfi_process_event().

Even though the overflow can never happen (the maximum number of pages of
the HFI table is 0x10 and 0x10 << PAGE_SHIFT = 0x10000), using size_t as
the data type of hfi_features::nr_table_pages makes Coverity happy and
matches the data type of the argument 'size' of memcpy().

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index a0640f7..239afe0 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -137,7 +137,7 @@ struct hfi_instance {
  * Parameters and supported features that are common to all HFI instances
  */
 struct hfi_features {
-	unsigned int	nr_table_pages;
+	size_t		nr_table_pages;
 	unsigned int	cpu_stride;
 	unsigned int	hdr_size;
 };
