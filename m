Return-Path: <linux-pm+bounces-42485-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB8KMUoVjGk8gQAAu9opvQ
	(envelope-from <linux-pm+bounces-42485-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 06:36:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A65F1215DD
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 06:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6623046007
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 05:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F733305E1F;
	Wed, 11 Feb 2026 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YNb7XbPh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E72EBDFA;
	Wed, 11 Feb 2026 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788167; cv=none; b=qCm3WxFtE+ySb3/owbCSpMVqMbsTpQW8N9w3w8GaehJGjcsxYy78u+uQF9R11RN+krhWVlcofKdmBRwWEd/yuF4vST0eeFQIfMeQRhtRM+na4u/mGuKLhjvzljDyiDWwKvVJZsNOIccr2qVVdmqnve3f0vPOhnbmsztrErDOk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788167; c=relaxed/simple;
	bh=B181mYgru7WmUPNF+kMO8jG55PX6/vxv5ym+h4pzGbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/irltJLA2UKpNPI0bL1afFK5J4j9oGJHgOy+lRcztQ2mmdR7+yA6P4zbpiOF35uHOl6WQd2PDi3DZ85XLlZBHSJ5DeHxhbZ0fk4MjwuJdYpvGQn20G56UJSQdY8ZqP8wQn7K2m3Z1hQa3L4Ds6UznutSXCZZ9Y72EzlDuNjJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YNb7XbPh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ANslGl470140;
	Wed, 11 Feb 2026 05:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LXxQYGQWWyPCAzrg0cUvTngf93KrbsUGeg+pPcYXJ
	R0=; b=YNb7XbPhQPakf6NrCCdYhOAGYkMRAWySXIBZ50MwVfehXrJC1w3zsy4JE
	ig5o3nh4GhbzcvPs/4Lz8HlUrPD24g/9oMOH6ijPfBA5TKGywasE22AuMuoUxtrT
	sVyAITMX4EAS980exwghw6cHl3lp65/qMp9obsEsSg97sMfwYgJ2h0A88DQ1O7tQ
	++lFUpvAxGv6zWPGscM6PJQwtHCfrGUwlwu+c2W67A9A8QYvOowBQN5VhEo4Go6L
	k/VxSkGNSz+pvxBnMSx2v+WMq+rYqL7T0pA0etC88egExxTyhcZNEdeK17f/aXQI
	9dq/iMvro3jvPtp9YVtK0dgDDc7jg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wwc9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 05:35:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B5GGV4019274;
	Wed, 11 Feb 2026 05:35:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk4c9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 05:35:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61B5Zut723069156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 05:35:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E932C2004B;
	Wed, 11 Feb 2026 05:35:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3BDD20040;
	Wed, 11 Feb 2026 05:35:53 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.18.8])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Feb 2026 05:35:53 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: ladder: Fix state index when only one idle state is registered
Date: Wed, 11 Feb 2026 11:05:52 +0530
Message-ID: <20260211053552.739337-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698c153e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=U4tRRsJ4TXZnTGwuz54A:9
X-Proofpoint-GUID: sF8M6wPP82y3omJChLHZoGSAQD3ErfRg
X-Proofpoint-ORIG-GUID: sF8M6wPP82y3omJChLHZoGSAQD3ErfRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0MCBTYWx0ZWRfX1phLpZ2im1Sm
 4evcpX+CSD5G91wi5aLaGofOtaCav1VKFafMEoer7WqgYYDUh0nMuS4uHWcYFLfLQhGIfgSgmbi
 7CuWCQKkFvwxjP5m2qKidLyokV0x+SQQut8LdE/GMWbWq0I+jDy5F6DwjQsYbJgWQ1b/MIQVGAi
 27HPlbYcC/XgNpsjYyJ+vSQI81MwcDZ1I8u1qAduoMUpWFs8T3ekapO7VV2z2BMfNxj0DlQF6gi
 9xDKhTPtr0ecHY/UAiZqik2Ms5waiJO9sRBNZlRbAwIOnf3hpDjSkg6yslvTf2orGY9YRwEWn6S
 Clf/YmtL77dAEJc585R3VKan7NWbVY1jalxlIO10J3ySWpLb6UXLHiM9r0i4y4WB4wjB4KjdN+8
 bbVkkeVsEN0Mw4rVRT22jA6YsVjwhmg7vJbWYs6m/KR2GDbg/+3+9TVk6oTAgdLIn1aNg33QPG3
 H5JEfzQ0368USPxXAtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110040
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42485-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2A65F1215DD
X-Rspamd-Action: no action

On certain platforms (PowerNV systems without a power-mgt DT node),
cpuidle may register only a single idle state. In cases where that
single state is a polling state (state 0), the ladder governor may
incorrectly treat state 1 as the first usable state and pass an
out-of-bounds index. This can lead to a NULL enter callback being
invoked, ultimately resulting in a system crash.

[   13.342636] cpuidle-powernv : Only Snooze is available
[   13.351854] Faulting instruction address: 0x00000000
[   13.376489] NIP [0000000000000000] 0x0
[   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668

Fix this by determining the first non-polling state index based on
the number of registered states, and by returning state 0 when only
one state is registered.

Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 drivers/cpuidle/governors/ladder.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 6617eb494a11..294a688ed0bb 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -42,6 +42,21 @@ struct ladder_device {
 
 static DEFINE_PER_CPU(struct ladder_device, ladder_devices);
 
+/**
+ * ladder_get_first_idx - get the first non-polling state index
+ * @drv: cpuidle driver
+ *
+ * Returns the index of the first non-polling state, or 0 if state 0 is not
+ * polling or if there's only one state available.
+ */
+static inline int ladder_get_first_idx(struct cpuidle_driver *drv)
+{
+	if (drv->state_count > 1 &&
+	    drv->states[0].flags & CPUIDLE_FLAG_POLLING)
+		return 1;
+	return 0;
+}
+
 /**
  * ladder_do_selection - prepares private data for a state change
  * @dev: the CPU
@@ -70,16 +85,17 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_idx = dev->last_state_idx;
-	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
+	int first_idx;
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	s64 last_residency;
 
-	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0)) {
+	/* Special case when there's only one state or strict latency requirement */
+	if (unlikely(drv->state_count <= 1 || latency_req == 0)) {
 		ladder_do_selection(dev, ldev, last_idx, 0);
 		return 0;
 	}
 
+	first_idx = ladder_get_first_idx(drv);
 	last_state = &ldev->states[last_idx];
 
 	last_residency = dev->last_residency_ns - drv->states[last_idx].exit_latency_ns;
@@ -134,7 +150,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev)
 {
 	int i;
-	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
+	int first_idx = ladder_get_first_idx(drv);
 	struct ladder_device *ldev = &per_cpu(ladder_devices, dev->cpu);
 	struct ladder_device_state *lstate;
 	struct cpuidle_state *state;
-- 
2.52.0


