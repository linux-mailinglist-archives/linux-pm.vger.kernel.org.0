Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DB3878DE
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbhERMgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 08:36:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245556AbhERMgB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 May 2021 08:36:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06714B06A;
        Tue, 18 May 2021 12:34:42 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v3 2/2] cpufreq: intel_pstate: Add Cometlake support in no-HWP mode
Date:   Tue, 18 May 2021 14:34:13 +0200
Message-Id: <20210518123413.20670-2-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518123413.20670-1-ggherdovich@suse.cz>
References: <CAJZ5v0g5_BY3DCi=VxqkRh+TYPS5nkJ-J96EzPVrc975uiWf3Q@mail.gmail.com>
 <20210518123413.20670-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Users may disable HWP in firmware, in which case intel_pstate wouldn't load
unless the CPU model is explicitly supported.

See also commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers
support").

Suggested-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9a93603acd3f..a6d8e56c8e27 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2087,6 +2087,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(ATOM_GOLDMONT,	core_funcs),
 	X86_MATCH(ATOM_GOLDMONT_PLUS,	core_funcs),
 	X86_MATCH(SKYLAKE_X,		core_funcs),
+	X86_MATCH(COMETLAKE,		core_funcs),
 	X86_MATCH(ICELAKE_X,		core_funcs),
 	{}
 };
-- 
2.26.2

