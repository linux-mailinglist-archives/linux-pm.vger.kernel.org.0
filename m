Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5ED6C947
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 08:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfGRG12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 02:27:28 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38107 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRG12 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 02:27:28 -0400
Received: by mail-pg1-f181.google.com with SMTP id f5so3551081pgu.5;
        Wed, 17 Jul 2019 23:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fv1F1u+9An7zr0O1ROG6I6eeHptRElpdTjY+XJ3dwig=;
        b=abwLc42WD5E5/IpSi4oKnlvsdQOQ/WY9MOZdqbd4f+0TCmAYLG6DTnO43H3Ft1vX1p
         tOXSeGn8SaYXvPoRz0BfqtgoVaJ93PJVSPFyj0oSjBCU9d+2efhZcBR2dRe+zmiwQf1H
         Dg87uT+S3ycbSdPXzzGcE4hZNnS2cdec7z9MBeax+Xue44xiy8M66CB5JQxrNYzDiqVC
         ZuRK7HBd/UhPkrUPZZYCKeQg4DB4VPaA568T0Hyrdvn3D8WIkRhZPMlap/XP0Pzdpg4+
         4ksC6KqMrj5L86U09Zb79PpXv2KP6zz9F6fyaK696+VJnDsT2bNuhfamFYsFrnfywaWg
         C1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fv1F1u+9An7zr0O1ROG6I6eeHptRElpdTjY+XJ3dwig=;
        b=tzTNiuYJ9+c4gouSLktYFVwEBqTQ8B6Q8Rnr/1K07jFxBGY+0iyGwN59U5uIofrk7Y
         bXDf+Ivy/HOGqY29nhONN6ZIufIsZW95TY2qg37VOY7BXkrvA7Fj4WgmfwWBj5NjpYCO
         gYn9hghXFZNUMEsS99VjYfP7QAqtu2jppHnWqs5F/HORmTBXzgwcT8rA8OaHqaInLeOV
         KiOzNsKowGdZzqKfEUHci1/wD1/dk2LRs2ZiTF6U+S3FjgICi/onjIK7WImMjgdVK+mz
         jJ2xtbAJk2Jz+wCbBN0YM+SSmBFl1+5Y8cxvUlxgmj9lf2DzgyKBb8TeiO8TMSfaoHjw
         oGRQ==
X-Gm-Message-State: APjAAAWHAZMd/sckQyY7trqt+ftSfmrapmBmcaFQZCVViBNrFXQMj/6Y
        LGDf2thMQQcWtm84mmOfVc3LBlHf
X-Google-Smtp-Source: APXvYqyZt6zk/Rn5ClbAaMJWMl3y2wFlMGI/BiFN8QGaRTMdstla+IZ4W0oOBRTkI8v/cQyZ8dr6xg==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr45615139pgc.328.1563431247085;
        Wed, 17 Jul 2019 23:27:27 -0700 (PDT)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id u97sm23736305pjb.26.2019.07.17.23.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jul 2019 23:27:26 -0700 (PDT)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     viresh.kumar@linaro.org, rjw@rjwysocki.net, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dsmythies@telus.net
Subject: [PATCH] Revert "cpufreq: schedutil: Don't set next_freq to UINT_MAX"
Date:   Wed, 17 Jul 2019 23:26:40 -0700
Message-Id: <1563431200-3042-1-git-send-email-dsmythies@telus.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit ecd2884291261e3fddbc7651ee11a20d596bb514.

The commit caused a regression whereby reducing the maximum
CPU clock frequency is ineffective while busy, and the CPU
clock remains unchanged. Once the system has experienced
some idle time, the new limit is implemented.
A consequence is that any thermal throttling monitoring
and control based on max freq limits fail to respond
in a timely manor, if at all, to a thermal temperature
trip on a busy system.

Please review the original e-mail threads, as this
attempt at a revertion would then re-open some of
those questions. One possible alterative to this
revertion would be to revert B7EAF1AAB9F8:

  Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  Date:   Wed Mar 22 00:08:50 2017 +0100

      cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely

References:

https://marc.info/?t=152576189300002&r=1&w=2
https://marc.info/?t=152586219000002&r=1&w=2
https://marc.info/?t=152607169800004&r=1&w=2

https://marc.info/?t=149013813900002&r=1&w=2
---
Test Data:

Typical commands:
watch -n 5 cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
watch -n 5 cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 5
watch -n 5 cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq

Driver: intel_cpufreq ; Governor: Schedutil
Kernel 5.2:

Test 1: No thermal throttling involved:
- load the system (some sort of CPU stress test).
- adjust downwards the maximum clock frequency
  echo 60 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
- observe the Bzy_MHz does not change on the turbostat output.
- reduce the system load, such that there is some idle time.
- observe the Bzy_MHz now does change.
- increase the load again.
- observe the CPU frequency is now pinned to the new limit.

Test 2: Use thermald to try Thermal throttling:
- By default thermald will use pstate control first.
  On my system a lower thermal trip point it used,
  because it doesn't get hot enough.
- enable and start thermald
- load the system (some sort of CPU stress test)
- Once the thermal trip point is reached, observe thermald
  adjusting the max_perf_pct but nothing happens in response.
- Once the lowest limit of max_perf_pct is reached, observe
  thermald fall through to intel-powerclamp, and kidle inject
  starts to be used. Therefore the "busy" condition (see the code)
  is not longer met, and the CPU frequency suddenly goes to minimum.

Test 3: Limit thermald to using max_perf_pct only:
- Adjust the cpu cooling device order to just include the one
  option, thereby excluding help from the fall through partner
  experienced in test 2.
- Observations here tracked test 2 until the lower limit
  of max_perf_pct is reached. The CPUs remain at maximum
  frequency until the load is removed. Processor
  temperature continues to climb.

Driver: intel_cpufreq ; Governor: Schedutil
Kernel 5.2 + this revert patch:

Test 1: No thermal throttling involved:
- load the system (some sort of CPU stress test)
- adjust downwards the maximum clock frequency
  echo 60 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
- observe the Bzy_MHz changes on the turbostat output.

Test 2: Use thermald to try Thermal throttling:
- By default thermald will use pstate control first.
- enable and start thermald
- load the system (some sort of CPU stress test)
- Once the thermal trip point is reached, observe thermald
  adjusting the max_perf_pct and observe the actual frequency
  adjust in response.

Test 3: Limit thermald to using max_perf_pct only:
- Adjust the cpu cooling device order to just include the one
  option, adjusting max_perf_pct.
- Observations here tracked test 2. (test 2 never fell
  through to intel_powerclamp and kidle inject.

Driver: acpi-cpufreq ; Governor: Schedutil
Kernel 5.2:

Test 1: No thermal throttling involved:
- load the system (some sort of CPU stress test)
- adjust downwards the maximum clock frequency
  for file in /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq; do echo "2200000" > $file; done
- observe the Bzy_MHz does not change on the turbostat output.
- reduce the system load, such that there is some idle time.
- observe the Bzy_MHz now does change.
- increase the load again.
- observe the CPU frequency is now pinned to the new limit.

Test 2: Use thermald to try Thermal throttling:
- By default thermald will use intel_powerclamp control first.
- enable and start thermald
- load the system (some sort of CPU stress test)
- Once the thermal trip point is reached, observe thermald
  adjusting the kidle_inj amounts.
- If the maximum kidle_inj is not enough, then oberve thermald
  start to limit scaling_max_freq, however the actual frequency
  response is immediate. Why? Because of the kidle inject, the
  system is not longer fully "busy", and so that condition is not met.

Test 3: Limit thermald to using scaling_max_freq only:
- Adjust the cpu cooling device order to just include the one
  option, thereby excluding help from previous partner
  experienced in test 2.
- load the system (some sort of CPU stress test)
- Once the thermal trip point is reached, observe thermald
  reducing scaling_max_freq.
- observe the Bzy_MHz does not change on the turbostat output.
- Eventually, for all CPUs, scaling_max_freq is set to the minimum.
- Processor temperature continues to climb.
- The CPUs remain at maximum frequency until the load is removed.

Driver: acpi-cpufreq ; Governor: Schedutil
Kernel 5.2 + this revert patch:

Test 1: No thermal throttling involved:
- load the system (some sort of CPU stress test)
- adjust downwards the maximum clock frequency
  for file in /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq; do echo "2200000" > $file; done
- observe the Bzy_MHz changes on the turbostat output.

Test 2: Use thermald to try Thermal throttling:
- By default thermald will use intel_powerclamp control first.
- enable and start thermald
- This test already passes using kernel 5.2, and
  proper operation was observed with this revert.

Test 3: Limit thermald to using scaling_max_freq only:
- Adjust the cpu cooling device order to just include the one
  option, thereby excluding help from previous partner
  experienced in test 2.
- load the system (some sort of CPU stress test)
- Once the thermal trip point is reached, observe thermald
  reducing scaling_max_freq.
- observe the Bzy_MHz now does change on the turbostat output
  and the processor package temperature is now controlled.
---
 kernel/sched/cpufreq_schedutil.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 962cf34..ea4e04b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -89,8 +89,15 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	    !cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->need_freq_update))
+	if (unlikely(sg_policy->need_freq_update)) {
+		sg_policy->need_freq_update = false;
+		/*
+		 * This happens when limits change, so forget the previous
+		 * next_freq value and force an update.
+		 */
+		sg_policy->next_freq = UINT_MAX;
 		return true;
+	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
 
@@ -168,10 +175,8 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = map_util_freq(util, freq, max);
 
-	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
+	if (freq == sg_policy->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
 		return sg_policy->next_freq;
-
-	sg_policy->need_freq_update = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
@@ -457,7 +462,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
 	 */
-	if (busy && next_f < sg_policy->next_freq) {
+	if (busy && next_f < sg_policy->next_freq &&
+	    sg_policy->next_freq != UINT_MAX) {
 		next_f = sg_policy->next_freq;
 
 		/* Reset cached freq as next_freq has changed */
@@ -819,7 +825,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
-	sg_policy->next_freq			= 0;
+	sg_policy->next_freq			= UINT_MAX;
 	sg_policy->work_in_progress		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
-- 
2.7.4

