Return-Path: <linux-pm+bounces-12035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32194CB5F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6875AB247C7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAA161319;
	Fri,  9 Aug 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KVnEri2s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6F182A0;
	Fri,  9 Aug 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188701; cv=none; b=mc1c+4tBvhhMik1B4+f+CoxliBQhiKJrXVGCR3C9avuJ2WzXXBguTWbBBWZpST/paUzpigmMTIAs948Ogu2T+rEUxFyt4lAb8/W72MVuWRbZXI8ZxGjhxSMi2N8gnV/WMSK0fxeC3D8SiIBJ82oBkRQytQVjt1ilhzwr9AFA+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188701; c=relaxed/simple;
	bh=7mPvzryi7u75IjQ+A1VUQqynjh6Eqiq7VKmHDQ5u+nA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AYi2ZCBN0DD6pQBvhSwgaypoeL+6M0R7Tpzpo7WM2UMrlOLmrGRYNLYQJwbbjHrGYWkkRMA5oc51GsGOu++aPfv49tGVccdaiW0SjOev1NtDBJeNXs//um+i9uyMiIYN1VdliyFMqY+5FYocDxo87LC0SrbRYuQWH+iPGRjOjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KVnEri2s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4792cn1J010469;
	Fri, 9 Aug 2024 07:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=pp1; bh=j7oXnCWi1Koa2tsrt6/jrZjqw9
	THCXyU5nr+pEdRti8=; b=KVnEri2sw0ncUKn4ltre/3bBtKV3WdSbhfXvhIEKeg
	qHSix6faBNdxseg7yreMd6hM9PMV00HVFO2IGdDhpnK9GdlfVSya+1QGQLKq+pMO
	HsJ9d52RJYnyIcTOTKPpF4qMDf4tEGteifa+RYEYDjljgBAg0kR8z9M0/aokiwep
	xFr8nixLkaJozz2m0PcqU2XG0gBRkJmR1yzfNWA0XvLV4Fqbm9SFisuiNAKMd5QV
	iwH27lskeSltgrX9zaB/Q7RQwYHTlkk3kLl4B/cq8W0AVwMYVPRRlJTrQy69vmMp
	QGWXEhQ1HIY9eHPjBX/2HLBmV0W+OsuePMYIUFLm+GUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkcj7mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 07:31:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4793ZVPq018034;
	Fri, 9 Aug 2024 07:31:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40t0cn2a1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 07:31:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4797VO8x55116268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 07:31:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2C5E20043;
	Fri,  9 Aug 2024 07:31:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A2C020040;
	Fri,  9 Aug 2024 07:31:22 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com.com (unknown [9.43.8.213])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 07:31:22 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: aboorvad@linux.ibm.com, christian.loehle@arm.com, gautam@linux.ibm.com
Subject: [PATCH 0/1] cpuidle/menu: Address performance drop from favoring physical over polling cpuidle state
Date: Fri,  9 Aug 2024 13:01:19 +0530
Message-Id: <20240809073120.250974-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jbhx5zaq5J1_dvTIginMDU5x70js69v8
X-Proofpoint-ORIG-GUID: Jbhx5zaq5J1_dvTIginMDU5x70js69v8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_04,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090052

This patch aims to discuss a potential performance degradation that can occur
in certain workloads when the menu governor prioritizes selecting a physical
idle state over a polling state for short idle durations. 

Note: This patch is intended to showcase a performance degradation, applying
this patch could lead to increased power consumption due to the trade-off between
performance and power efficiency, potentially causing a higher preference for
performance at the expense of power usage.

==================================================
System details in which the degradation is observed:

$ uname -r
6.10.0+

$ lscpu
Architecture:             ppc64le
  Byte Order:             Little Endian
CPU(s):                   160
  On-line CPU(s) list:    0-159
Model name:               POWER10 (architected), altivec supported
  Model:                  2.0 (pvr 0080 0200)
  Thread(s) per core:     8
  Core(s) per socket:     3
  Socket(s):              6
  Physical sockets:       4
  Physical chips:         2
  Physical cores/chip:    6
Virtualization features:
  Hypervisor vendor:      pHyp
  Virtualization type:    para
Caches (sum of all):
  L1d:                    1.3 MiB (40 instances)
  L1i:                    1.9 MiB (40 instances)
  L2:                     40 MiB (40 instances)
  L3:                     160 MiB (40 instances)
NUMA:
  NUMA node(s):           6
  NUMA node0 CPU(s):      0-31
  NUMA node1 CPU(s):      32-71
  NUMA node2 CPU(s):      72-79
  NUMA node3 CPU(s):      80-87
  NUMA node4 CPU(s):      88-119
  NUMA node5 CPU(s):      120-159


$ cpupower idle-info
CPUidle driver: pseries_idle
CPUidle governor: menu
analyzing CPU 0:

Number of idle states: 2
Available idle states: snooze CEDE
snooze:
Flags/Description: snooze
Latency: 0
Residency: 0
Usage: 6229
Duration: 402142
CEDE:
Flags/Description: CEDE
Latency: 12
Residency: 120
Usage: 191411
Duration: 36329999037

==================================================

The menu governor contains a condition that selects physical idle states over,
such as the CEDE state over polling state, by checking if their exit latency meets
the latency requirements. This can lead to performance drops in workloads with
frequent short idle periods.

The specific condition which causes degradation is as below (menu governor):

```
if (s->target_residency_ns > predicted_ns) {
    ...
    if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
        s->exit_latency_ns <= latency_req &&
        s->target_residency_ns <= data->next_timer_ns) {
        predicted_ns = s->target_residency_ns;
        idx = i;
        break;
    }
    ...
}
```

This condition can cause the menu governor to choose the CEDE state on Power
Systems (residency: 120 us, exit latency: 12 us) over a polling state, even
when the predicted idle duration is much shorter than the target residency
of the physical state. This misprediction leads to performance degradation
in certain workloads.

==================================================
Test Results
==================================================

This issue can be clearly observed with the below test.

A test with multiple wakee threads and a single waker thread was run to
demonstrate this issue. The waker thread periodically wakes up the wakee
threads after a specific sleep duration, creating a repeating of sleep -> wake
pattern. The test was run for a stipulated period, and cpuidle statistics are
collected.

./cpuidle-test -a 0 -b 10 -b 20 -b 30 -b 40 -b 50 -b 60 -b 70 -r 20 -t 60

==================================================
Results (Baseline Kernel):
==================================================
Wakee 0[PID 8295] affined to CPUs: 10,
Wakee 2[PID 8297] affined to CPUs: 30,
Wakee 3[PID 8298] affined to CPUs: 40,
Wakee 1[PID 8296] affined to CPUs: 20,
Wakee 4[PID 8299] affined to CPUs: 50,
Wakee 5[PID 8300] affined to CPUs: 60,
Wakee 6[PID 8301] affined to CPUs: 70,
Waker[PID 8302] affined to CPUs: 0,

|-----------------------------------|-------------------------|-----------------------------|
| Metric                            | snooze                  | CEDE                        |
|-----------------------------------|-------------------------|-----------------------------|
| Usage                             | 47815                   | 2030160                     |
| Above                             | 0                       | 2030043                     |
| Below                             | 0                       | 0                           |
| Time Spent (us)                   | 976317 (1.63%)          | 51046474 (85.08%)           |
| Overall average sleep duration    | 28.721 us               |                             |
| Overall average wakeup latency    | 6.858 us                |                             |
|-----------------------------------|-------------------------|-----------------------------|

In this test, without the patch, the CPU often enters the CEDE state for
sleep durations of around 20-30 microseconds, even though the CEDE state's
residency time is 120 microseconds. This happens because the menu governor
prioritizes the physical idle state (CEDE) if its exit latency is within
the latency limits. It also uses next_timer_ns for comparison, which can
be farther off than the actual idle duration as it is more predictable,
instead of using predicted idle duration as a comparision point with the
target residency.

Inference: The "Above" metric in the table counts instances where the
state was entered but the observed idle duration was too short. The data
shows that the CEDE state's "Above" metric is high, with around 99.9% of
the CEDE state usage exceeding the expected cpuidle state.

==================================================
Results (With Patch):
==================================================
Wakee 0[PID 8295] affined to CPUs: 10,
Wakee 2[PID 8297] affined to CPUs: 30,
Wakee 3[PID 8298] affined to CPUs: 40,
Wakee 1[PID 8296] affined to CPUs: 20,
Wakee 4[PID 8299] affined to CPUs: 50,
Wakee 5[PID 8300] affined to CPUs: 60,
Wakee 6[PID 8301] affined to CPUs: 70,
Waker[PID 8302] affined to CPUs: 0,

|-----------------------------------|-------------------------|-----------------------------|
| Metric                            | snooze                  | CEDE                        |
|-----------------------------------|-------------------------|-----------------------------|
| Usage                             | 1853343                 | 6                           |
| Above                             | 0                       | 6                           |
| Below                             | 2                       | 0                           |
| Time Spent (us)                   | 51055087 (85.09%)       | 356 (0.00%)                 |
| Overall average sleep duration    | 32.268 us               |                             |
| Overall average wakeup latency    | 4.382 us                |                             |
|-----------------------------------|-------------------------|-----------------------------|

When the condition that prioritizes the selection of physical idle states
based on exit latency is removed, these metrics improve significantly.
The reduction in "above" metric for the CEDE state shows that the governor’s
selection of cpuidle state are now more accurate that before, leading to
better overall performance.

==================================================
Performance Improvements:
==================================================
The patch improved the performance of OLTP benchmarks by around 5-10%.

The following table summarizes the performance improvements observed in
multiple OLTP query tests:

|----|----------|------------------|---------------------------|
| #  | Base (s) | Base + Patch (s) | % Performance Improvement |
|    | Kernel   | Kernel           |    (lower the better)     |
|----|----------|------------------|---------------------------|
| 1  | 15.77    | 14.14            | -10.34%                   |
| 2  | 0.87     | 0.86             | -0.90%                    |
| 3  | 4.05     | 3.78             | -6.70%                    |
| 4  | 0.61     | 0.59             | -3.10%                    |
| 5  | 1.18     | 1.14             | -3.47%                    |
| 6  | 4.11     | 3.84             | -6.59%                    |
| 7  | 0.75     | 0.75             | -0.24%                    |
| 8  | 14.91    | 13.56            | -9.03%                    |
| 9  | 4.02     | 3.86             | -3.90%                    |
| 10 | 14.93    | 13.65            | -8.57%                    |
| 11 | 15.62    | 14.03            | -10.20%                   |
| 12 | 2.15     | 2.05             | -4.52%                    |
| 13 | 7.92     | 7.35             | -7.29%                    |
| 14 | 4.08     | 4.07             | -0.08%                    |
| 15 | 2.28     | 2.10             | -8.12%                    |
| 16 | 1.14     | 1.11             | -3.09%                    |
| 17 | 2.14     | 2.06             | -3.64%                    |
| 18 | 2.54     | 2.36             | -7.16%                    |
| 19 | 3.72     | 3.68             | -1.05%                    |
| 20 | 2.12     | 2.05             | -3.28%                    |
| 21 | 8.17     | 7.46             | -8.69%                    |
| 22 | 3.98     | 3.83             | -3.58%                    |
| 23 | 2.45     | 2.30             | -6.12%                    |
| 24 | 2.13     | 2.06             | -3.61%                    |
| 25 | 15.05    | 13.74            | -8.70%                    |
| 26 | 4.49     | 4.16             | -7.43%                    |
| 27 | 3.75     | 3.66             | -2.37%                    |
| 28 | 2.90     | 2.87             | -0.96%                    |
| 29 | 4.37     | 4.03             | -7.83%                    |
| 30 | 2.57     | 2.43             | -5.19%                    |
| 31 | 2.78     | 2.71             | -2.30%                    |
| 32 | 3.94     | 3.78             | -4.27%                    |
| 33 | 0.70     | 0.69             | -1.48%                    |
| 34 | 2.15     | 2.08             | -3.62%                    |
| 35 | 8.30     | 7.52             | -9.38%                    |
| 36 | 2.15     | 2.08             | -3.25%                    |
| 37 | 4.37     | 4.03             | -7.88%                    |
| 38 | 4.16     | 3.88             | -6.78%                    |
| 39 | 1.12     | 1.12             | -0.02%                    |
| 40 | 1.22     | 1.17             | -4.19%                    |
| 41 | 8.45     | 7.67             | -9.27%                    |
| 42 | 7.91     | 7.31             | -7.51%                    |
| 43 | 1.12     | 1.12             | -0.08%                    |
| 44 | 0.68     | 0.65             | -3.86%                    |
| 45 | 2.12     | 2.00             | -5.47%                    |
| 46 | 3.11     | 3.04             | -2.36%                    |
| 47 | 2.29     | 2.13             | -6.88%                    |
| 48 | 8.37     | 7.61             | -9.02%                    |
| 49 | 2.61     | 2.46             | -5.75%                    |
| 50 | 7.92     | 7.30             | -7.79%                    |
| 51 | 2.85     | 2.77             | -2.58%                    |
| 52 | 0.79     | 0.78             | -0.87%                    |
| 53 | 2.90     | 2.79             | -3.63%                    |
| 54 | 8.03     | 7.40             | -7.87%                    |
| 55 | 2.14     | 2.00             | -6.53%                    |
| 56 | 15.54    | 13.93            | -10.38%                   |
| 57 | 8.07     | 7.45             | -7.62%                    |
| 58 | 8.48     | 7.70             | -9.20%                    |
| 59 | 1.08     | 1.04             | -3.80%                    |
| 60 | 1.14     | 1.13             | -0.91%                    |
| 61 | 4.28     | 3.95             | -7.84%                    |
| 62 | 8.40     | 7.62             | -9.36%                    |
| 63 | 7.91     | 7.38             | -6.78%                    |
| 64 | 2.16     | 2.10             | -2.92%                    |
| 65 | 7.78     | 7.18             | -7.60%                    |
| 66 | 4.22     | 4.19             | -0.84%                    |
| 67 | 2.99     | 2.88             | -3.61%                    |
| 68 | 8.44     | 7.56             | -10.33%                   |
| 69 | 4.10     | 3.74             | -8.89%                    |
| 70 | 4.25     | 3.98             | -6.37%                    |
| 71 | 0.61     | 0.61             | -0.39%                    |
| 72 | 3.89     | 3.56             | -8.39%                    |
|----|----------|------------------|---------------------------|


==================================================
Observation:
==================================================

The condition under discussion is intended to prioritize physical idle state
when their exit latency is within the acceptable limits thereby improving
the power efficiency and overall SMT folding. However, in systems where the
target residency value is significantly higher than the exit latency, this
leads to frequent selection of states like CEDE in Power Systems, which is
less efficient for short sleep durations.

Whereas, in systems where the residency value and exit latency are almost
equal, this condition might not adversely affect the performance.

In general scenarios, there seems to be a preference for prioritizing
energy efficiency, as shown by the commit message 0c313cb (“cpuidle: menu:
Fallback to polling if the next timer event is near”). This change involved
reverting to next_timer_ns as a comparison point instead of using the predicted
idle duration. While next_timer_ns is more precise, it might not account for
very short idle durations, which could affect performance in certain
situations, even though it helps reduce energy consumption.

But, any feedback and suggestions on better improving the power-performance
tradeoff in menu governor to address the performance issue in specific cases
as mentioned above will be very helpful.

Thanks
Aboorva

Aboorva Devarajan (1):
  cpuidle/menu: avoid prioritizing physical state over polling state

 drivers/cpuidle/governors/menu.c | 11 -----------
 1 file changed, 11 deletions(-)

-- 
2.39.3


