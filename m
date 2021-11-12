Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5244E3B1
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhKLJUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 04:20:40 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:32988 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhKLJUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 04:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1636708670; x=1668244670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j3XnDy9D0a0oV3i+5pPpaensOxiWshzijm5A1W2afc8=;
  b=GNIBewJ7MH8DF2NSnPAjLzA1Xb2OH1OHhmJ6WVcgW/f5+0Rncj1B96b5
   AFgMfJzbjcFFUowodchjiseleQhGNqV6Tl6Nkjn8++xmGbl09lLlB+Mpq
   nqUPhY5FW/7BSMQcWNVeOFcG0zmzz3uvhsaLj5YjFb4vmx2PYnchil7Wm
   Y=;
X-IronPort-AV: E=Sophos;i="5.87,229,1631577600"; 
   d="scan'208";a="173556530"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 12 Nov 2021 09:17:35 +0000
Received: from EX13MTAUEE001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com (Postfix) with ESMTPS id 140EC41767;
        Fri, 12 Nov 2021 09:17:34 +0000 (UTC)
Received: from EX13D08UEB001.ant.amazon.com (10.43.60.245) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.200) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Fri, 12 Nov 2021 09:17:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D08UEB001.ant.amazon.com (10.43.60.245) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Fri, 12 Nov 2021 09:17:33 +0000
Received: from dev-dsk-attofari-1c-9e00ebdc.eu-west-1.amazon.com
 (10.13.242.123) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26 via Frontend Transport; Fri, 12 Nov 2021
 09:17:32 +0000
From:   Adamos Ttofari <attofari@amazon.de>
To:     <attofari@amazon.de>
CC:     Hendrik Borghorst <hborghor@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: intel_pstate: Add Ice Lake server to out-of-band IDs
Date:   Fri, 12 Nov 2021 09:16:57 +0000
Message-ID: <20211112091657.9848-1-attofari@amazon.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support in
no-HWP mode") enabled the use of Intel P-State driver for Ice Lake servers.
But it doesn't cover the case when OS can't control P-States.

Therefore, for Ice Lake server, if MSR_MISC_PWR_MGMT bits 8 or 18 are
enabled, then the Intel P-State driver should exit as OS can't control
P-States.

Fixes: fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support in no-HWP mode")

Signed-off-by: Adamos Ttofari <attofari@amazon.de>
Cc: Hendrik Borghorst <hborghor@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 815df3daae9d..1088ff350159 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2353,6 +2353,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(BROADWELL_D,		core_funcs),
 	X86_MATCH(BROADWELL_X,		core_funcs),
 	X86_MATCH(SKYLAKE_X,		core_funcs),
+	X86_MATCH(ICELAKE_X,		core_funcs),
 	{}
 };
 
-- 
2.32.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



