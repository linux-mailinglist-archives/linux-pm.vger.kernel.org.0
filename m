Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138D520B85A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgFZSeT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 14:34:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:1959 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFZSeS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 14:34:18 -0400
IronPort-SDR: vnTbQqWw73TOVwH3S8tqOLUOfzh51ufyhiirH7pKyFr/9B0UeCTLYyESglR0HVQ0xA0eE6rDlX
 9DfM1gJIyzaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143666455"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="143666455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:34:13 -0700
IronPort-SDR: LqYAJ/43LU55w4v9gAPe6/wkkrQm3ABpVDhCdpk51m7zfflfkpsVOGt+mKjUkWIR7TIyb/UDfW
 CDPMfo/A1QDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="453447586"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.109.205])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2020 11:34:12 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 0/2] cpufreq: intel_pstate: Support raw epp and energy_efficiency
Date:   Fri, 26 Jun 2020 11:33:59 -0700
Message-Id: <20200626183401.1495090-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v4
Changes suggested by Borislav
- msr-index file is sorted for the MSR_IA32_POWER_CTL
- Remove "_enable" from the new attribute
- Changes related to documentation
Changes suggested by Peter
- Use of kstrtobool
Suspend/resume restore

v3
Some edits for the description as suggested by Doug

v2
Remove raw value support for EPB

Srinivas Pandruvada (2):
  cpufreq: intel_pstate: Allow enable/disable energy efficiency
  cpufreq: intel_pstate: Allow raw energy performance preference value

 Documentation/admin-guide/pm/intel_pstate.rst |  17 +-
 arch/x86/include/asm/msr-index.h              |   6 +-
 drivers/cpufreq/intel_pstate.c                | 147 ++++++++++++++----
 3 files changed, 133 insertions(+), 37 deletions(-)

-- 
2.25.4

