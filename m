Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C8722BEA
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjFEPuc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjFEPth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 11:49:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D11B1
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685980153; x=1717516153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nX8fmsid8DYzjW7a45NxGNIFQX/H4kDTVVleKyGgmcs=;
  b=RpcpykOFm2v4ri1vB9pEo9jba7wl5a0pxf1SUdgA8piIejzazCGaP1vq
   TDr/TqLvzGTxwCB21sNsQTTawz6g3SPyGvMOqAApcpHRR2Y+U5CxNxUb9
   AQXUcItBzvGV+4X8za9fn6F6gCC+AC2jc5O0CPGk8n8rC+jFEy2tJTwmG
   YDTVXRS+mGy4mvrPMUTQW1dLPe8eoyN8VBTM3lc7e7BO9ab5Z5GgH8cDk
   LfzX64fe/JQd49/4zomYfgMiTXWzoZeDdFfI2JRJrcsmqSdp930oLdJpE
   AdZxQ1F4hahKnabtODTAxbTffiDCK9At2IX6MmAu0Pbb/R18UHMcG1876
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355256209"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="355256209"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955374787"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="955374787"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:47:33 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 0/4 v2] Add support for running in VM guests to intel_idle
Date:   Mon,  5 Jun 2023 15:47:12 +0000
Message-Id: <20230605154716.840930-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

intel_idle provides the CPU Idle states (for power saving in idle) to the
cpuidle framework, based on per-cpu tables combined with limited hardware
enumeration. This combination of cpuidle and intel_idle provides dynamic
behavior where power saving and performance impact are dynamically balanced
and where a set of generic knobs are provided in sysfs for users to tune
the heuristics (and get statistics etc)

However, intel_idle currently does not support running inside VM guests, and
the linux kernel falls back to either ACPI based idle (if supported by the
hypervisor/virtual bios) or just the default x86 fallback "hlt" based idle
method... that was introduced in the 1.2 kernel series... and lacks all the
dynamic behavior, user control and statistics that cpuidle brings.

While this is obviously functional, it's not great and we can do better
for the user by hooking up intel_idle into the cpuidle framework also
for the "in a guest" case.
And not only not great for the user, it's also not optimal and lacks two
key capabilities that are supported by the bare metal case:

1) The ability to flush the TLB for very long idle periods, to avoid
   a costly (and high latency) IPI wakeup later, of an idle vCPU when a
   process that used to run on the idle vCPU does an munmap or similar
   operation. Avoiding high latency IPIs helps avoid performance jitter.
2) The ability to use the new Intel C0.2 idle state instead of polling
   for very short duration idle periods to save power (and carbon footprint)

This patch series adds the basic support to run in a VM guest
to the intel_idle driver, and then addresses the first of these shortfalls.
The C0.2 gap will be fixed with a small additional patch after the
C0.2 support is merged seperately.


Arjan van de Ven (4):
  intel_idle: refactor state->enter manipulation into its own function
  intel_idle: clean up the (new) state_update_enter_method function
  intel_idle: Add support for using intel_idle in a VM guest using just
    hlt
  intel_idle: Add a "Long HLT" C1 state for the VM guest mode

 drivers/idle/intel_idle.c | 238 ++++++++++++++++++++++++++++++++++----
 1 file changed, 215 insertions(+), 23 deletions(-)

-- 
2.40.1

