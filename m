Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE2403B2D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhIHOG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 10:06:58 -0400
Received: from foss.arm.com ([217.140.110.172]:47140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351761AbhIHOG5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 10:06:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD94D6E;
        Wed,  8 Sep 2021 07:05:49 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A69E3F766;
        Wed,  8 Sep 2021 07:05:48 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v7 5/9] cpufreq: Make policy min/max hard requirements
Date:   Wed,  8 Sep 2021 15:05:26 +0100
Message-Id: <1631109930-290049-6-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
References: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When applying the policy min/max limits, the requested frequency is
simply clamped to not be out of range. It means, however, if one of the
boundaries isn't an available frequency, the frequency resolution can
return a value out of those limits, depending on the relation used.

e.g. freq{0,1,2} being available frequencies.

          freq0  policy->min  freq1  policy->max   freq2
            |        |          |        |           |
          17kHz     18kHz     19kHz     20kHz      21kHz

     __resolve_freq(21kHz, CPUFREQ_RELATION_L) -> 21kHz (out of bounds)
     __resolve_freq(17kHz, CPUFREQ_RELATION_H) -> 17kHz (out of bounds)

If, during the policy init, we resolve the requested min/max to existing
frequencies, we ensure that any CPUFREQ_RELATION_* would resolve to a
frequency which is inside the policy min/max range.

Making the policy limits rigid helps to introduce the inefficient
frequencies support. Resolving an inefficient frequency to an efficient
one should not transgress policy->max (which can be set for thermal
reason) and having a value we can trust simplify this comparison.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7d5f170ecad1..95b0464249d6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2527,8 +2527,15 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
+	/*
+	 * Resolve policy min/max to available frequencies. It ensures
+	 * no frequency resolution will neither overshoot the requested maximum
+	 * nor undershoot the requested minimum.
+	 */
 	policy->min = new_data.min;
 	policy->max = new_data.max;
+	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
+	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
 	trace_cpu_frequency_limits(policy);
 
 	policy->cached_target_freq = UINT_MAX;
-- 
2.7.4

