Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEDA1BB488
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 05:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1D1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 23:27:52 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48926 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD1D1v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 23:27:51 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49B6Xl09yXzFfFH;
        Mon, 27 Apr 2020 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588044471; bh=Jn/3Hh7+QKpOsjrz/1ry7Kkr0NliBM599QoG3E/jSq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+JrTVUF2gpIak/MKENvrPibE38ta319GGS+/vO1IJxWMc3MnSTgzQt199zfYGvCa
         1Y3a49C6RqzNHIv0VNPAIA50ln5GRnTJOvIDSF2qeXgGDqki8lzAoW3g5yEtVkOc+x
         Hq4Y8JE6YVVj4n9oxKXr7T6jKHJHyEyY88c0BJAQ=
X-Riseup-User-ID: 547A5229B4A1C176D71D349D0F1A9E9C1806DD9F22F331FDB485BCF7D9A4F8A9
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49B6Xk5MFvzJqbk;
        Mon, 27 Apr 2020 20:27:50 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHv2.99 04/11] cpufreq: Define ADAPTIVE frequency governor policy.
Date:   Mon, 27 Apr 2020 20:22:51 -0700
Message-Id: <20200428032258.2518-5-currojerez@riseup.net>
In-Reply-To: <20200428032258.2518-1-currojerez@riseup.net>
References: <20200428032258.2518-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This defines a generic policy in addition to the existing PERFORMANCE
and POWERSAVE policies.  The ADAPTIVE policy is expected to provide a
variable trade-off between performance and energy efficiency based on
the dynamic behavior of the workload -- E.g. whether the system has a
bottleneck on the CPU or another IO device.

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/cpufreq/cpufreq.c | 10 ++++++++--
 drivers/cpufreq/longrun.c |  1 +
 include/linux/cpufreq.h   |  1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 045f9fe157ce..e87285b6294c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -629,6 +629,9 @@ static unsigned int cpufreq_parse_policy(char *str_governor)
 	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN))
 		return CPUFREQ_POLICY_POWERSAVE;
 
+	if (!strncasecmp(str_governor, "adaptive", CPUFREQ_NAME_LEN))
+		return CPUFREQ_POLICY_ADAPTIVE;
+
 	return CPUFREQ_POLICY_UNKNOWN;
 }
 
@@ -750,6 +753,8 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
 		return sprintf(buf, "powersave\n");
 	else if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
 		return sprintf(buf, "performance\n");
+	else if (policy->policy == CPUFREQ_POLICY_ADAPTIVE)
+		return sprintf(buf, "adaptive\n");
 	else if (policy->governor)
 		return scnprintf(buf, CPUFREQ_NAME_PLEN, "%s\n",
 				policy->governor->name);
@@ -811,7 +816,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 	struct cpufreq_governor *t;
 
 	if (!has_target()) {
-		i += sprintf(buf, "performance powersave");
+		i += sprintf(buf, "performance powersave adaptive");
 		goto out;
 	}
 
@@ -1085,7 +1090,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 				pol = policy->policy;
 		}
 		if (pol != CPUFREQ_POLICY_PERFORMANCE &&
-		    pol != CPUFREQ_POLICY_POWERSAVE)
+		    pol != CPUFREQ_POLICY_POWERSAVE &&
+		    pol != CPUFREQ_POLICY_ADAPTIVE)
 			return -ENODATA;
 	}
 
diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 1caaec7c280b..cb70f0b7ff7a 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -99,6 +99,7 @@ static int longrun_set_policy(struct cpufreq_policy *policy)
 		msr_lo |= 0x00000001;
 		break;
 	case CPUFREQ_POLICY_POWERSAVE:
+	case CPUFREQ_POLICY_ADAPTIVE:
 		break;
 	}
 	wrmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index f7240251a949..fa63df914f9f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -536,6 +536,7 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
  */
 #define CPUFREQ_POLICY_POWERSAVE	(1)
 #define CPUFREQ_POLICY_PERFORMANCE	(2)
+#define CPUFREQ_POLICY_ADAPTIVE 	(3)
 
 /*
  * The polling frequency depends on the capability of the processor. Default
-- 
2.22.1

