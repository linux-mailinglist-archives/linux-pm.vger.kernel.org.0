Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7E455BBC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbhKRMtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 07:49:51 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:51622
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344808AbhKRMto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 07:49:44 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5870B3F180;
        Thu, 18 Nov 2021 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637239602;
        bh=3GGm/8mZHP7JAYlztAqV2/1PYddCRZrbpkZjiFEExOI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uuytkAMvNiHYbThxcfDEFGBFEROQ6CrIXTL9FpJleA+FmVZTzDEdekCz9V1CIC6Yj
         RJ7IelAPbrmmnpP0dfpX4tYzGnjBvF/45YkKsQrXRVw681deb1FmgHiBuoxIbOmKnB
         uu9PLrEFlpPYG0BzQ7r1NLlj4WWDT285FAbdNSo3jv+RGFp6e1Y4ayc2qTLhQOlRhc
         P8huvcTtavex3YU+wXWn/7LEH7kZMMENq0aU9Ofs9zpvTA9GFtMFmfokbb5YLfXV6N
         NIml0+3knCPFsU7gRjF3+uvEXP0v1Fg6ZIR/pfb7NCgsSshkCGB90RiAkM9FI/SGK+
         pxLu8wvHMTmiQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org (open list:INTEL PSTATE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cpufreq: intel_pstate: Avoid using CPPC when ACPI CPC is not valid
Date:   Thu, 18 Nov 2021 20:45:53 +0800
Message-Id: <20211118124553.599419-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If ACPI CPC is not valid, dereference cpc_desc in cppc_get_perf() causes
a NULL pointer dereference. So avoid using CPPC for that scenario.

Fixes: 46573fd6369f ("cpufreq: intel_pstate: hybrid: Rework HWP calibration")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 815df3daae9df..24c7d705b99b6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3369,7 +3369,7 @@ static int __init intel_pstate_init(void)
 			if (!default_driver)
 				default_driver = &intel_pstate;
 
-			if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
+			if (boot_cpu_has(X86_FEATURE_HYBRID_CPU) && acpi_cpc_valid())
 				intel_pstate_cppc_set_cpu_scaling();
 
 			goto hwp_cpu_matched;
-- 
2.32.0

