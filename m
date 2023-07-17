Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D534756792
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jul 2023 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGQPUB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jul 2023 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGQPTl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2023 11:19:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435021739
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689607169; x=1721143169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDyxnFMW6ToDi+AVUzlUAgIJLjyTYn/1ND+QK+JrqIk=;
  b=UMq2iuZo9kid36PgF48qyE8kYaC926BtR1WUPWe6pXArE6l9KiZYOhKq
   xZHP/cBVn01UW98cmc4cq4aw1COTAqtvSANsTHazRl7075b4USsb99f5l
   I+pKyauAwaCMhGtUon67IKDePrpu1qFVQ6X6d5dZkIglpRNwbkd9hgGcF
   BIEIP88p6BvTPc6L0VD1q0m1ntV5599CxXr2+5bndjJJWpfTHasZlvkCH
   4Szoz5o+4lsVIQEEzL5TBBPgPAYkVIfbgOz13XbnTu1lkni1LgBkmeZK/
   UPRLbZJTScboMrVHYYBnz+50igVrtTz3KaruZpz70kK3m1STRIFtSjxAp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429716547"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429716547"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726581590"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726581590"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:19:11 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 3/4] intel_idle: add VM guest (non)handling to model_specific_fixups
Date:   Mon, 17 Jul 2023 15:18:55 +0000
Message-ID: <20230717151856.2529029-3-arjan@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717151856.2529029-1-arjan@linux.intel.com>
References: <20230717151856.2529029-1-arjan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

The model specific fixups don't make sense in a VM guest; all the MSR
accesses at best will be fiction, and at worse cause logspam

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f3eba9b147d2..4dd8081d2406 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1957,6 +1957,10 @@ static bool should_verify_mwait(struct cpuidle_state *state)
 
 static void __init model_specific_fixups(void)
 {
+	/* when running in a hypervisor, none of these fixups will work */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
+
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_IVYBRIDGE_X:
 		ivt_idle_state_table_update();
-- 
2.41.0

