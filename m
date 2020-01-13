Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37FD138EEF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 11:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgAMKWu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 05:22:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:64218 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAMKWu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 05:22:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 02:22:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="255840582"
Received: from jingma1-mobl1.ccr.corp.intel.com (HELO M5530.gar.corp.intel.com) ([10.255.175.37])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2020 02:22:47 -0800
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: intel_pstate: fix spelling mistake: "Whethet" -> "Whether"
Date:   Mon, 13 Jan 2020 18:22:40 +0800
Message-Id: <20200113182228.1.I3c4155635fe990891a2c98c874cc4a270c82fe1b@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a spelling typo in the comment, no function change.

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8ab31702cf6a..4bd9cb33132c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -172,7 +172,7 @@ struct vid_data {
 /**
  * struct global_params - Global parameters, mostly tunable via sysfs.
  * @no_turbo:		Whether or not to use turbo P-states.
- * @turbo_disabled:	Whethet or not turbo P-states are available at all,
+ * @turbo_disabled:	Whether or not turbo P-states are available at all,
  *			based on the MSR_IA32_MISC_ENABLE value and whether or
  *			not the maximum reported turbo P-state is different from
  *			the maximum reported non-turbo one.
-- 
2.24.1

