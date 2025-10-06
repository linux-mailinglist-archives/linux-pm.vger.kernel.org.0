Return-Path: <linux-pm+bounces-35717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C694BBCF74
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 03:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DAE1889D5B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF181AAA1C;
	Mon,  6 Oct 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CIn7E8lw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF291B3935;
	Mon,  6 Oct 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759714821; cv=none; b=DOFUcT63tDHpAl6ntnULnHqrUbTnNVzD9KAc27oJPzzryhDetR4DyHObETTup9dar4ycHssXUEm466/Iw7G8zDesIPxE9NExCycMk3vkhhPEhK9OJTWx2fr6bPtAiNR6Oyjx5hON7CkYUG1zUMWbmfRJwzBeOw6i86SPf3ucB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759714821; c=relaxed/simple;
	bh=58BjvUQEqPzD+9OK0iCgBRFpUAb5YsB7recq8WV52FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzdxhISxxBLmHWBoM9kcsNvy80xj3YuK25LuIqv3PfZYMvMIgxn+GGwOZSluwxC9RFOA+52S4nkYSII3Kh/DXhITtzDa+Ejoae91XBhN4krT30C0tvpQEBaEytQqfp2aKHXR6hXPuRCkz9D4bOMAnyykS4z/5rcn92C+MxlxRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CIn7E8lw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595BlGaU018271;
	Mon, 6 Oct 2025 01:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qPcdImALRl72sFXkGrgNDZmhcloWFUe77eyxUhYR9
	68=; b=CIn7E8lwYeNgwEzCKCYdOQzLL7ttoXu+s9rEfeXB3sXtHl2+gUkmcxNEj
	mOuNPl/aPBDpkohYkGXQGvsVIkVEEZOffzWgAXR0aTrHrR0P9gjVhi5sPGNyY9ei
	Qidkdi4DFoqfKZTUWx45yeJia1YUX3m6f6epTxjiEtRXYdIPwYiOg4JlZRldxmlp
	IQ4e7L1g30YflwSx5y4xeSMGojCppmmJyfCSTVXonnQuTvVVkaNp4IEPHIpyxiTD
	x//hCcY8HkkW4Dqcl86Bh9jhys3JpsBhnbhAIt6O9mwbjifQn6kzDdV/+Uspd3iU
	lgdFM3hVsPehDjsmkYoI2lQrMVzAg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju936q7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 01:40:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5960SlwW030976;
	Mon, 6 Oct 2025 01:40:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kfdjupew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 01:40:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5961e2IP60817744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Oct 2025 01:40:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E60320049;
	Mon,  6 Oct 2025 01:40:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D84B520040;
	Mon,  6 Oct 2025 01:39:57 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.9.46])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Oct 2025 01:39:57 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, gautam@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] cpuidle: menu: Use residency threshold in polling state override decisions
Date: Mon,  6 Oct 2025 07:09:54 +0530
Message-ID: <20251006013954.17972-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lsOe536Bmw4-ZKhEZfucf4OBJo6epKqT
X-Proofpoint-ORIG-GUID: lsOe536Bmw4-ZKhEZfucf4OBJo6epKqT
X-Authority-Analysis: v=2.4 cv=Fec6BZ+6 c=1 sm=1 tr=0 ts=68e31df7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
 a=RMWZt8AqD-_lvsXj4dkA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX7SJcm5OmCgu1
 nq+JvwQ7MvAGFITMDy+HozqkOHDhuTNiAIoJUO/4l76vBlmTIHaPeVvTsxIA9t1bFGuYASKM6CE
 KPZJFGP7PvjVLjLsG8dVxx5lSVpY2UR6+6Wd22uNMtQlt4s7opnLQiQfAQSCMgbguGdfSQms/b3
 SLNJiQSh1qMxZZUh35x6WwdZklIL7hTDVBJZd1RloIBm6njf2q0SKwL8BJjgL4dAYxriXRQHcKi
 ryK7EwKP5CFf9aJLfgVGFzhTkHj67WhlUq+KyG6lG56ibeTrwQVob1d0kv8gBwI5SkeMRZhUSYm
 3dbME4HJEFiIT2lliatf7r8J9lMJmysUtUVO5Cc8phwuURU5TJlh3hRfZWUa3fSrMmpg0PxFDcB
 iLHmffOTxg8tzU4AMlja1B+XsKv8uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On virtualized PowerPC (pseries) systems, where only one polling state
(Snooze) and one deep state (CEDE) are available, selecting CEDE when
the predicted idle duration is less than the target residency of CEDE
state can hurt performance. In such cases, the entry/exit overhead of
CEDE outweighs the power savings, leading to unnecessary state
transitions and higher latency.

Menu governor currently contains a special-case rule that prioritizes
the first non-polling state over polling, even when its target residency
is much longer than the predicted idle duration. On PowerPC/pseries,
where the gap between the polling state (Snooze) and the first non-polling
state (CEDE) is large, this behavior causes performance regressions.

This patch refines the special case by adding an extra requirement:
the first non-polling state can only be chosen if its
target residency is below the defined RESIDENCY_THRESHOLD_NS. If
this condition is not satisfied, polling is allowed instead, avoiding
suboptimal non-polling state entries.

This change is limited to the single special-case rule for the first
non-polling state. The general non-polling state selection logic in the
menu governor remains unchanged.

Performance improvement observed with pgbench on PowerPC (pseries)
system:
+---------------------------+------------+------------+------------+
| Metric                    | Baseline   | Patched    | Change (%) |
+---------------------------+------------+------------+------------+
| Transactions/sec (TPS)    | 495,210    | 536,982    | +8.45%     |
| Avg latency (ms)          | 0.163      | 0.150      | -7.98%     |
+---------------------------+------------+------------+------------+
CPUIdle state usage:
+--------------+--------------+-------------+
| Metric       | Baseline     | Patched     |
+--------------+--------------+-------------+
| Total usage  | 12,735,820   | 13,918,442  |
| Above usage  | 11,401,520   | 1,598,210   |
| Below usage  | 20,145       | 702,395     |
+--------------+--------------+-------------+

Above/Total and Below/Total usage percentages:
+------------------------+-----------+---------+
| Metric                 | Baseline  | Patched |
+------------------------+-----------+---------+
| Above % (Above/Total)  | 89.56%    | 11.49%  |
| Below % (Below/Total)  | 0.16%     | 5.05%   |
| Total cpuidle miss (%) | 89.72%    | 16.54%  |
+------------------------+-----------+---------+

The results indicate that restricting CEDE selection to cases where
its residency matches the predicted idle time reduces mispredictions,
lowers unnecessary state transitions, and improves overall throughput.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---

v3: https://lore.kernel.org/all/20250908075443.208570-1-aboorvad@linux.ibm.com/

v3 -> v4

- Rebased onto the linux-pm/pm branch.
- Updated commit message and comments based on review feedback.
- Reordered condition checks as recommended in review.
- Added Reviewed-by tag from Christian.

---
 drivers/cpuidle/governors/menu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 4d9aa5ce31f0..6a98a724442e 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -320,10 +320,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		}
 
 		/*
-		 * Use a physical idle state, not busy polling, unless a timer
-		 * is going to trigger soon enough.
+		 * Use a physical idle state instead of busy polling as long as
+		 * its target residency is below the residency threshold and the
+		 * next timer doesn't expire soon.
 		 */
 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
+		    s->target_residency_ns < RESIDENCY_THRESHOLD_NS &&
 		    s->target_residency_ns <= data->next_timer_ns) {
 			predicted_ns = s->target_residency_ns;
 			idx = i;
-- 
2.47.1


