Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF1D250A74
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgHXVDx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 17:03:53 -0400
Received: from foss.arm.com ([217.140.110.172]:43030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHXVDw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 17:03:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52DBE1FB;
        Mon, 24 Aug 2020 14:03:51 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4B1D3F71F;
        Mon, 24 Aug 2020 14:03:49 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v3 1/5] arch_topology: validate input frequencies to arch_set_freq_scale()
Date:   Mon, 24 Aug 2020 22:02:48 +0100
Message-Id: <20200824210252.27486-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824210252.27486-1-ionela.voinescu@arm.com>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current frequency passed to arch_set_freq_scale() could end up
being 0, signaling an error in setting a new frequency. Also, if the
maximum frequency in 0, this will result in a division by 0 error.

Therefore, validate these input values before using them for the
setting of the frequency scale factor.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/base/arch_topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 75f72d684294..1aca82fcceb8 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -33,6 +33,9 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 	unsigned long scale;
 	int i;
 
+	if (!cur_freq || !max_freq)
+		return;
+
 	/*
 	 * If the use of counters for FIE is enabled, just return as we don't
 	 * want to update the scale factor with information from CPUFREQ.
-- 
2.17.1

