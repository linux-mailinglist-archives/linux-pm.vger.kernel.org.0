Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754023BF810
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGHKMR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 06:12:17 -0400
Received: from foss.arm.com ([217.140.110.172]:55428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhGHKMR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930101063;
        Thu,  8 Jul 2021 03:09:35 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E3003F5A1;
        Thu,  8 Jul 2021 03:09:34 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v4 9/9] cpufreq: dt: Add CPUFREQ_READ_ENERGY_MODEL
Date:   Thu,  8 Jul 2021 11:09:06 +0100
Message-Id: <1625738946-295849-10-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq-dt driver registers an Energy Model. Let CPUfreq use it to
mark and skip inefficient frequencies.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ece52863ba62..40c6109df427 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -176,7 +176,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver dt_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_IS_COOLING_DEV,
+		 CPUFREQ_IS_COOLING_DEV | CPUFREQ_READ_ENERGY_MODEL,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
-- 
2.7.4

