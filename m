Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4E2F0D4F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbhAKHkl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 02:40:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:6034 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbhAKHkl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 02:40:41 -0500
IronPort-SDR: q3rBnEBYbj03kzpTd7sD3ET42eYJpWzk09JNq0Kd+aj/vOsRKetsejvPPc1mJf0gDzsDcxYd14
 fW5JcqDtBCcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="165503016"
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="165503016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 23:40:00 -0800
IronPort-SDR: pNsLNvUtyRvOc1dJGqUN16zgIPnrTiN0QLeOgveumBTmKKAYRAK68hovcwR5cdTrCnatvonrzF
 dKfNGkdUwqPg==
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="380920464"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 23:39:58 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][v2] Get percpu max freq via HWP MSR register
Date:   Mon, 11 Jan 2021 15:43:07 +0800
Message-Id: <cover.1610338353.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Asymmetric platforms might have different max cpu frequency between
small and big cores. Currently the intel_pstate driver uses package wide MSR
register that can not distinguish max cpu frequency between small and big cores
when turbo is disabled, which causes inconsistency compared to the scenario when
turbo mode is enabled. This patch changes the logic from package wide MSR register
to percpu HWP register so as to avoid this issue.

This path is based on Rafael's previous patchset to clean up the intel_pstate_get_hwp_max()
https://patchwork.kernel.org/project/linux-pm/patch/2241039.bdjsIDbar3@kreacher/


Chen Yu (2):
  cpufreq: intel_pstate: Add parameter to get guarantee
  cpufreq: intel_pstate: Get percpu max freq via HWP MSR register if
    available

 drivers/cpufreq/intel_pstate.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

-- 
2.17.1

