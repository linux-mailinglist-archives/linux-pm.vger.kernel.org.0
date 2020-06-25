Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5277209B60
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 10:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbgFYIhr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 04:37:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:38613 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390001AbgFYIhq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 04:37:46 -0400
IronPort-SDR: BbekztHK1n8oNxeKLefDZe3r7LhopmSyHP/pg/hvMtYae5e28NSt3vMv6RILAVhGnr60Votm9d
 iCY2Cj8eqHyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="209926278"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="209926278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 01:37:46 -0700
IronPort-SDR: MaIw8jX+LX2i/qrurSGC8MMqlKOx1gW0o1GnJ5Ej5sfJ4RorUBJ4GNxU6u53cZ5/hUwAjjHFJ/
 VS/t50NY/1RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="265298123"
Received: from unknown (HELO spandruv-mobl.amr.corp.intel.com) ([10.251.17.249])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2020 01:37:45 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/2] cpufreq: intel_pstate: Support raw epp and energy_efficiency
Date:   Thu, 25 Jun 2020 01:37:38 -0700
Message-Id: <20200625083740.1445342-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v3
Some edits for the description as suggested by Doug

v2
Remove raw value support for EPB

Srinivas Pandruvada (2):
  cpufreq: intel_pstate: Allow enable/disable energy efficiency
  cpufreq: intel_pstate: Allow raw energy performance preference value

 Documentation/admin-guide/pm/intel_pstate.rst | 13 ++-
 drivers/cpufreq/intel_pstate.c                | 99 ++++++++++++++++---
 2 files changed, 99 insertions(+), 13 deletions(-)

-- 
2.25.4

