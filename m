Return-Path: <linux-pm+bounces-34134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1731AB4861F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FC6165470
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355E2E54D3;
	Mon,  8 Sep 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lfqt42tW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31B2E2EE5;
	Mon,  8 Sep 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318099; cv=none; b=Uq9ZtyspfGqh6fG2kGmA02gFC9n0RXYNvYJmBdFpV/6yfY3i20cRwEDqNeLMIrIyi2RcVNX8gtQhLDdRTtXrIfxzUsl9iOfETnFOEUx6lMu6oLNp+sBJx58VIjJduOFxxVod9nnNSj3pDliw3PZRjxPd0NVwYqmQ4euO/dznFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318099; c=relaxed/simple;
	bh=9jyM4l+zzeSaXAh/J86ALE2gazQVCvzE2WjsQ8nc700=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdiTeVrO7d1QVjIls4H7SltewwGFzHORIlI81HD85wozKig62ZB8wx+KBvg665x7fnWiw5etozkLbPUNomOj2E3bWxphitVucjAnGApODKampic9EhwtpzQb5XDVR/pYVXpadcfFJ1eK/0GFg8tauzDmK/+Qjk1X8q+16xW5p/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lfqt42tW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587KU42E021524;
	Mon, 8 Sep 2025 07:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0AW79ARpv8Jhmkse2u1q1muQPzj9PtKwGuXjdd1Sj
	cw=; b=Lfqt42tWnteqm5/kHosx6+dTAWIebwIqREj08XgPQV595uEkPZRSwj+L+
	6e9OHI2m03DqHI9WROQtFMQkgw/MbcQRzDC0RhBm347W5TddV67orkm9GIjcIXcE
	AdM4QWoE5HN3Jl1ZibiNaZTnASQ6Pds5y88tglSFPwLgsoU351XHcxR7pVJ0nDVD
	aNuSOTTxnZNaq2ALM3UK5/FO2mBWb2hOhlag1wKJcx6Gm9yZcHF7f7O7j3SsQJNf
	PWhSE4bVlekwrZU1S7TjYfP4g5JFoytaBVJvd/aFF566mWhkJ9DsomB9xj1sVTwX
	q2HfYxT0SqGRMXuF//0q7EPVuzj+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uke5a8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:54:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58861mHv017181;
	Mon, 8 Sep 2025 07:54:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm4ss0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:54:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5887slDO44761370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 07:54:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E60B02004E;
	Mon,  8 Sep 2025 07:54:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96F4320043;
	Mon,  8 Sep 2025 07:54:44 +0000 (GMT)
Received: from aboo.in.ibm.com (unknown [9.109.247.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 07:54:44 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, gautam@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] cpuidle: menu: Add residency threshold for non-polling state selection
Date: Mon,  8 Sep 2025 13:24:43 +0530
Message-ID: <20250908075443.208570-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX6krycO0Svlo6
 mlsmkO4hxcgsKinrklU/4F3O/9JJLXVko4gIm5PF7uMogmkujbpLzeyI7e+QuefZZlH+7riVDWn
 F1OyayfJKoim8/h1yJA+zofkUSGsa9a5bSERFyXgVb8ASf7gSHFnephP13l0ElZ9gve+xtHjCe/
 G6PWco7XEODyC7f5mgIcsChECT/wAvbA42tSBwKfLA/uYsuQdCdTBHDijViNqr7HCZbJYW1yYXI
 +jNOzYBWmYEGBTVMecIpkQaWwlUvdLRqhsDVkFd2NqASu0Jx+TAEhb5nnepL7zqR2v8SlCdyHOp
 H4/aXkuDLB5WT1xdwXM+DIYNT45drFWwdzPOoPc/zAAroIFf+G9kFZwL6GXT7kChD57Yg2VZ5EC
 mG1SF9Fl
X-Proofpoint-ORIG-GUID: -DcVqTIjU7pbN8-ZD3a4Qpvi7HPbS1hU
X-Proofpoint-GUID: -DcVqTIjU7pbN8-ZD3a4Qpvi7HPbS1hU
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68be8bcb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=CjxhCAsD_r_--zMTXuoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On virtualized PowerPC (pseries) systems, where only one polling state
(Snooze) and one deep state (CEDE) are available, selecting CEDE when
the predicted idle duration exceeds the target residency of the CEDE
state can hurt performance. In such cases, the entry/exit overhead of
CEDE outweighs the power savings, leading to unnecessary state transitions
and higher latency.

Menu governor currently contains a special-case rule that prioritizes
the first non-polling state over polling, even when its target residency
is much longer than the predicted idle duration. On PowerPC/pseries,
where the gap between the polling state (Snooze) and the first non-polling
state (CEDE) is large, this behavior causes performance regressions.

This patch refines the special case by adding an extra requirement:
the first non-polling state may only be chosen if its
target_residency_ns is below the defined RESIDENCY_THRESHOLD_NS. If this
condition is not met, the non-polling state is not selected, and polling
state is retained instead.

This change is limited to the single special-case condition for the first
non-polling state. The general state selection logic in the menu governor
remains unchanged.

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

Above/Total and Below/Total usage percentages which indicates
mispredictions:
+------------------------+-----------+---------+
| Metric                 | Baseline  | Patched |
+------------------------+-----------+---------+
| Above % (Above/Total)  | 89.56%    | 11.49%  |
| Below % (Below/Total)  | 0.16%     | 5.05%   |
| Total cpuidle miss (%) | 89.72%    | 16.54%  |
+------------------------+-----------+---------+

The results show that restricting non-polling state selection to
cases where its residency is within the threshold reduces mispredictions,
lowers unnecessary state transitions, and improves overall throughput.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---

v2: https://lore.kernel.org/all/20250317060357.29451-1-aboorvad@linux.ibm.com/

Changes in v2 -> v3:
  - Modifed the patch following Rafael's feedback, incorporated a residency threshold check
    (s->target_residency_ns < RESIDENCY_THRESHOLD_NS) as suggested.
  - Updated commit message accordingly.
---
 drivers/cpuidle/governors/menu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b2e3d0b0a116..d25b04539109 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -316,11 +316,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 		if (s->target_residency_ns > predicted_ns) {
 			/*
-			 * Use a physical idle state, not busy polling, unless
-			 * a timer is going to trigger soon enough.
+			 * Use a physical idle state instead of busy polling
+			 * if the next timer doesn't expire soon and its
+			 * target residency is below the residency threshold.
 			 */
 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    s->target_residency_ns <= data->next_timer_ns) {
+			    s->target_residency_ns <= data->next_timer_ns &&
+			    s->target_residency_ns < RESIDENCY_THRESHOLD_NS) {
 				predicted_ns = s->target_residency_ns;
 				idx = i;
 				break;
-- 
2.50.1


