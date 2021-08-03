Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1823DEFFF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhHCORm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbhHCOR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 10:17:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB0C06179F;
        Tue,  3 Aug 2021 07:17:14 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Jb5aSxMzJCCyF6vaaPxjKFvUOG34sLHqd3B5PKT6/U=;
        b=pUvx+vJhiNba79yfpL+zehuhmJa5TOI990ciPa+hYy7hx8fIQs99i3+TpeKa94oop6fn2X
        jvZksgFOIO6th8lhraKqHBNcY0B02teQtDDJr0wPer1h2GAWTLLQcsBVzG8MXVWknhpDx+
        YaCvQmkFcTft9dJS1M4imFVnQK5DDRK5gX1mTpxY/0Y1Qky7RcwqPeJ9KKkv1KRc1MEfbl
        IBCHLM4/YgdEpLmwwG0l7vbB7ZywYIyHLQgjd1FT2c3wTlGTXUhu0DFUjK/XxNHQECCDt2
        wNyeMTfzcEoqojuuM/PsZxa1YGIH7/u8mpiVuXdfHaFHZBG7ss8z6ATu6rGhRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Jb5aSxMzJCCyF6vaaPxjKFvUOG34sLHqd3B5PKT6/U=;
        b=TvCnEmaF2DzMdBPuCycd9tPyB6091RfLS4A55N4UfkGjm0zKqgw9aTiVrotM9HJMesM0CD
        Gj567wT3t0VNgGBw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 28/38] cpufreq: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:11 +0200
Message-Id: <20210803141621.780504-29-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpufreq/acpi-cpufreq.c     | 4 ++--
 drivers/cpufreq/cpufreq.c          | 6 +++---
 drivers/cpufreq/cpufreq_ondemand.c | 4 ++--
 drivers/cpufreq/intel_pstate.c     | 4 ++--
 drivers/cpufreq/powernow-k8.c      | 6 +++---
 drivers/cpufreq/powernv-cpufreq.c  | 4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7e7450453714d..b49612895c786 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -163,9 +163,9 @@ static ssize_t store_cpb(struct cpufreq_policy *policy,=
 const char *buf,
 	if (ret || val > 1)
 		return -EINVAL;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	set_boost(policy, val);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return count;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 45f3416988f1a..06c526d66dd38 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2654,18 +2654,18 @@ int cpufreq_boost_trigger_state(int state)
 	cpufreq_driver->boost_enabled =3D state;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_active_policy(policy) {
 		ret =3D cpufreq_driver->set_boost(policy, state);
 		if (ret)
 			goto err_reset_state;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return 0;
=20
 err_reset_state:
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled =3D !state;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_o=
ndemand.c
index ac361a8b1d3bb..eb4320b619c9c 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -418,7 +418,7 @@ static void od_set_powersave_bias(unsigned int powersav=
e_bias)
 	default_powersave_bias =3D powersave_bias;
 	cpumask_clear(&done);
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy;
 		struct policy_dbs_info *policy_dbs;
@@ -442,7 +442,7 @@ static void od_set_powersave_bias(unsigned int powersav=
e_bias)
 		od_tuners =3D dbs_data->tuners;
 		od_tuners->powersave_bias =3D default_powersave_bias;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 void od_register_powersave_bias_handler(unsigned int (*f)
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bb4549959b113..2d83a9f9651b0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2969,7 +2969,7 @@ static void intel_pstate_driver_cleanup(void)
 {
 	unsigned int cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
 			if (intel_pstate_driver =3D=3D &intel_pstate)
@@ -2979,7 +2979,7 @@ static void intel_pstate_driver_cleanup(void)
 			all_cpu_data[cpu] =3D NULL;
 		}
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	intel_pstate_driver =3D NULL;
 }
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index b9ccb6a3dad98..12ab4014af712 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1180,7 +1180,7 @@ static int powernowk8_init(void)
 	if (!x86_match_cpu(powernow_k8_ids))
 		return -ENODEV;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(i) {
 		smp_call_function_single(i, check_supported_cpu, &ret, 1);
 		if (!ret)
@@ -1188,10 +1188,10 @@ static int powernowk8_init(void)
 	}
=20
 	if (supported_cpus !=3D num_online_cpus()) {
-		put_online_cpus();
+		cpus_read_unlock();
 		return -ENODEV;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	ret =3D cpufreq_register_driver(&cpufreq_amd64_driver);
 	if (ret)
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cp=
ufreq.c
index 005600cef2730..23a06cba392cd 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -918,7 +918,7 @@ static void powernv_cpufreq_work_fn(struct work_struct =
*work)
 	unsigned int cpu;
 	cpumask_t mask;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	cpumask_and(&mask, &chip->mask, cpu_online_mask);
 	smp_call_function_any(&mask,
 			      powernv_cpufreq_throttle_check, NULL, 0);
@@ -939,7 +939,7 @@ static void powernv_cpufreq_work_fn(struct work_struct =
*work)
 		cpufreq_cpu_put(policy);
 	}
 out:
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
--=20
2.32.0

