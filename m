Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42737F894
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhEMNWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 09:22:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233890AbhEMNWP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 09:22:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19D96AE57;
        Thu, 13 May 2021 13:21:02 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in no-HWP mode
Date:   Thu, 13 May 2021 15:20:51 +0200
Message-Id: <20210513132051.31465-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Users may disable HWP in firmware, in which case intel_pstate wouldn't load
unless the CPU model is explicitly supported.

Add ICELAKE_X to the list of CPUs that can register intel_pstate while not
advertising the HWP capability. Without this change, an ICELAKE_X in no-HWP
mode could only use the acpi_cpufreq frequency scaling driver.

See also commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers
support").

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
This replaces https://lore.kernel.org/lkml/20210513075930.22657-1-ggherdovich@suse.cz

 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f0401064d7aa..28c9733e0dce 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2087,6 +2087,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(ATOM_GOLDMONT,	core_funcs),
 	X86_MATCH(ATOM_GOLDMONT_PLUS,	core_funcs),
 	X86_MATCH(SKYLAKE_X,		core_funcs),
+	X86_MATCH(ICELAKE_X,		core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.26.2

