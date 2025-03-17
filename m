Return-Path: <linux-pm+bounces-24131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D48A6409C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 07:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42071188E518
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 06:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354B21A432;
	Mon, 17 Mar 2025 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N4L9L1zs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B11219A67;
	Mon, 17 Mar 2025 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191465; cv=none; b=spURLh8CMkD1WSVNW86xM/v+i9P0KUHKJ5iR65WerW0kbyWmFPY7NRHfuLyOWOhYxBae5jqJ4gcRRcthgGTM6kW/6gtqiOT68tu/tYxkrxAlQ5GG6lD+u9rWomZUsmiUPkKODQOMZ5AEOdClKMiAJFHwJlsLq/Fdz+TBGLKNWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191465; c=relaxed/simple;
	bh=BuLAe+ckD3KglGlKDOe/14ODpCMzOcuTzcAY60aVtB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=folIYRdheouqCW/VMXcyvAhRyzPbkPVHIC85632K4Aq121sVqkv0oaK79C680YqO9b0nSmBT2KY+Kt75uR1/mClQKA5w/UGdGSpSWwDrqMIbJeYW6GzvtmQ1vRAClMUuwFMgu7dEf/ccKGO81zYOTe37ktl9loHr0CiYI6oW1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N4L9L1zs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GKb4iN020117;
	Mon, 17 Mar 2025 06:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6QyI19WOzYbsyCFPiTCl6pr1yzidgieZZUfeDkCxa
	8s=; b=N4L9L1zs4+29PXSiFIBitPHYyAzR+uxH5gTbOKAYFC3Q/7IsW0F9QdS8g
	BS/mEMfIqCdvBjtFVMlFrqURAePeZhxYnGZ/UxoBzSuPktp7CCLvhPAgHsAi0uTt
	E3CVbEeIy+/9WKjEb7lpMIgyTA9J+V5loyDB8AbJZD22TLMa1aMIy/5ntiy3GSBR
	3gLmC6JeHiSbnD4hWZIzTIq8zGjozIB+Ar9XnX92kd3gQdMiQ4cLDIS74razrFyS
	5icjwlkvsRbkvOZ06ijWlyq/tLQHTtaqcAaZ+TSq605MnliJsjEASksp0BaM+Knp
	xMNurm2As7t6Ih89NoVsRCEQWtn4Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5tp9k35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:04:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H3LU65009577;
	Mon, 17 Mar 2025 06:04:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8ymte0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:04:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52H640k747710690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 06:04:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B95D620043;
	Mon, 17 Mar 2025 06:04:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6210620040;
	Mon, 17 Mar 2025 06:03:59 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.in.ibm.com (unknown [9.109.215.55])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 06:03:59 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] cpuidle: menu: Prefer polling state for short idle durations
Date: Mon, 17 Mar 2025 11:33:57 +0530
Message-ID: <20250317060357.29451-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tNbJvwSjnEJAJOzgXClmmcDcd8RXCkkI
X-Proofpoint-ORIG-GUID: tNbJvwSjnEJAJOzgXClmmcDcd8RXCkkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_01,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170042

Avoid selecting deep idle state when the predicted idle duration is
shorter than its target residency, as this leads to unnecessary state
transitions without energy savings.

On virtualized PowerPC (pseries) systems, where only one polling state
(Snooze) and one deep state (CEDE) are available, selecting CEDE when
its target residency exceeds the predicted idle duration hurts
performance.

For example, if the predicted idle duration is 15 us and the first
non-polling state has a target residency of 120 us, selecting it
would be suboptimal.

Remove the condition introduced in commit 69d25870f20c
("cpuidle: fix the menu governor to boost IO performance") that
prioritized non-polling states even when their target residency
exceeded the predicted idle duration and allow polling states to
be selected when appropriate.

Performance improvement observed with pgbench on PowerPC (pseries)
system:
+---------------------------+------------+------------+------------+
| Metric                    | Baseline   | Patched    | Change (%) |
+---------------------------+------------+------------+------------+
| Transactions/sec (TPS)    | 494,834    | 538,707    | +8.85%     |
| Avg latency (ms)          | 0.162      | 0.149      | -8.02%     |
+---------------------------+------------+------------+------------+

CPUIdle state usage:
+--------------+--------------+-------------+
| Metric       | Baseline     | Patched     |
+--------------+--------------+-------------+
| Total usage  | 12,703,630   | 13,941,966  |
| Above usage  | 11,388,990   | 1,620,474   |
| Below usage  | 19,973       | 684,708     |
+--------------+--------------+-------------+

Above/Total and Below/Total usage percentages:
+------------------------+-----------+---------+
| Metric                 | Baseline  | Patched |
+------------------------+-----------+---------+
| Above % (Above/Total)  | 89.67%    | 11.63%  |
| Below % (Below/Total)  | 0.16%     | 4.91%   |
| Total cpuidle miss (%) | 89.83%    | 16.54%  |
+------------------------+-----------+---------+

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

---

v1: https://lore.kernel.org/all/20240809073120.250974-1-aboorvad@linux.ibm.com/

v1 -> v2:

- Drop cover letter and improve commit message.
---
 drivers/cpuidle/governors/menu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 28363bfa3e4c..4b199377e4be 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -296,17 +296,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			idx = i; /* first enabled state */
 
 		if (s->target_residency_ns > predicted_ns) {
-			/*
-			 * Use a physical idle state, not busy polling, unless
-			 * a timer is going to trigger soon enough.
-			 */
-			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    s->exit_latency_ns <= latency_req &&
-			    s->target_residency_ns <= data->next_timer_ns) {
-				predicted_ns = s->target_residency_ns;
-				idx = i;
-				break;
-			}
 			if (predicted_ns < TICK_NSEC)
 				break;
 
-- 
2.43.5


