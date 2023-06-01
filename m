Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6171F220
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjFASbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFASar (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 14:30:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6035F1B7
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685644246; x=1717180246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKdhPPBYvkATBkf66MVCgik12brZChNrB577n2CaSSo=;
  b=ByTVkmxGUbgUkirfal2rpPCa+kZ31LYUU/30ps40lYoYnNErsuoflbcY
   j/fHb/q09Tq3lhbwVS91V0j8Duk5PqOIo59KeYjWXOW8Qi3E3hQTv0JLb
   jmGjYduz32WyThV64VnpZIvBDtjcsQ+PjVE4e28Zc56j99lQ54S/8txaG
   fNpfPSBXYMWriRq9yy7epqSYlGvRHdXZkD0QC8EerfFRNo6P9xGzr/cLK
   dKDNNXgmxuk+USPh26cfQ5sq9tdUlbPsGpm6sTgIaWWqv3Lx/5moO8efd
   MA7hSWi0huaaRDH3rlR354PUdkC5Gq+6gb6KEFmJvlm7ZBQ9bQdhFzh6i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383921641"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383921641"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657900922"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657900922"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:21 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 5/7] intel_idle: Add a way to skip the mwait check on all states
Date:   Thu,  1 Jun 2023 18:27:59 +0000
Message-Id: <20230601182801.2622044-6-arjan@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601182801.2622044-1-arjan@linux.intel.com>
References: <20230601182801.2622044-1-arjan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan.van.de.ven@intel.com>

Currently, intel_idle verifies that the cpuid instruction enumerates
that the mwait value for a state is actually supported by the CPU.

Going forward, when running in a VM guest, that check will not work
and we're going to need a way to turn it off.

Add a global bool for this, and uses this in the check
function to short circuit this cpuid check.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 66d262fd267e..55c3e6ece3dd 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -69,6 +69,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask __read_mostly;
 static unsigned int preferred_states_mask __read_mostly;
 static bool force_irq_on __read_mostly;
+static bool skip_mwait_check __read_mostly;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
@@ -1866,6 +1867,9 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 	unsigned int num_substates = (mwait_substates >> mwait_cstate * 4) &
 					MWAIT_SUBSTATE_MASK;
 
+	if (skip_mwait_check)
+		return true;
+
 	/* Ignore the C-state if there are NO sub-states in CPUID for it. */
 	if (num_substates == 0)
 		return false;
-- 
2.40.1

