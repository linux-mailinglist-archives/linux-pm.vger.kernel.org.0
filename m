Return-Path: <linux-pm+bounces-42716-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLaVHm5nk2mR4QEAu9opvQ
	(envelope-from <linux-pm+bounces-42716-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:52:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D51471D1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 798163037445
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294C2D7DD5;
	Mon, 16 Feb 2026 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xjr7/3By"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A42E7F3E;
	Mon, 16 Feb 2026 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267842; cv=none; b=bnp2aSqRCIe+vOJcShpMLZjJwZnuUWuCUK1so1lIzqBc/Y7RngUI/32JPEGNFbbAe/QDsiBzluQPK93XWo+Rw00PdVxbN5Nf9pGd+eTdCSBC8fIRNcccZRvPqTEtIeWSaOdrrmH8ZYXlRrCeLh6Hl99e5GNEQEI1fVikgEK5CkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267842; c=relaxed/simple;
	bh=bkxKr/OHEKitVYLt62QMS9Zk5lJAF3UmjDJdO8Ni+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEluV7WkDlv/WrSjZtES16df0UAOHrfSl5ehw+PHzdb+6uJquHtczzpkHch+tA9ynBxEBssw7BbtAnDTLPshcYSOKnXOiwB4IuMvnsKcj8Q9LnkKXWMZdzJDbQcHCEEFQZkGse9yXyLnYhd7dyQXPWw2cyOZfmnfFZ3Uniqk0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xjr7/3By; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GDVJor3618137;
	Mon, 16 Feb 2026 18:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T1BXR83yQ624hwlUO
	LHr+/pD9bh4xpbbp+Zp8Nj2Gpg=; b=Xjr7/3ByOXXuwX0W+z+FbAaQZhvorf3x9
	WShYpNTjHAwOrZefvCewo/NCFzKVSI6NcFQuLT39quuV9NxFTrGowsvz1FwNstIU
	n7/VeUE87jIR3+FHOjbUwLfXckWxwdS+mQ1blY4o4ASqIPsdnnvbYsdIhFwJo7st
	a9p8ef5jgNqeDuVHa4+wSP3Drm2Ek4Wxh1h9O0XdSpLTyGOseu5pbMaRWrKdkeYr
	O65q8Lzi8TRvImFQVpdKsrZ1+8Mfar+/ilL8GnuSOXQqCo6JXNOcuQUsPl4wA9NK
	XJzDlxIU2363aCqFZKiP0GXHYBSqGoUqJV4ErLu4MP9tvBbqXh8hw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqrxa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GGLA8x013085;
	Mon, 16 Feb 2026 18:50:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb3crxkyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GIoHSm46203166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 18:50:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE67420043;
	Mon, 16 Feb 2026 18:50:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0654820040;
	Mon, 16 Feb 2026 18:50:15 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.7.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 18:50:14 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] cpuidle: teo: Remove single state handling
Date: Tue, 17 Feb 2026 00:20:04 +0530
Message-ID: <20260216185005.1131593-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
References: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4nWaHP0SygnkmuJ6mJ2a93MjWSz7i8kB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE1OSBTYWx0ZWRfX2f344rDJyN5+
 8LWuSqhjz/YVeE1Nlkjwlk2v4aY4jQ0mdD42SyvRMus4PgdIJepLEkJ5GK5+Ot88c5cbAHqMQD6
 b+zMNSZrgDwFr+bd4CtlkkTjZ+G7gRYIyB1mMfUsw1th7Jiomd80MhLzrqXXAOr0GQ4HCGLAqct
 flRhBDP9VrMcBhbjwcv5ZTkMn+lzJ8kGLmq0kw2qxcRafPWJ5n132aIc9Qpl2Imp1GydTISp72n
 u4dyesxgbjdo9c5pwAhztQdpMTeRkZ1dTSmDYICifzORNiFJOhwxxMAOBkS9qlXbItgDWJbfSGo
 0f4AFn2jHRa9/fXLe6bwvrWLS4i7oVa5e/cUuKNq+3cQtKN5+HR8ArRz9rCTJPFawfmRkb+2Wwv
 I20Uulk6mhOxquL9xWLUiAmHjTss2eB/KFzpSeKGeSF/2eMa8Li8v2QhOOyqg8S3L1VKdChuZ8J
 0Zp8gxLI0Y0CtvJHhcA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=699366eb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8 a=GAkCKx7umozebFGUKCEA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 4nWaHP0SygnkmuJ6mJ2a93MjWSz7i8kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_06,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42716-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D68D51471D1
X-Rspamd-Action: no action

From: Christian Loehle <christian.loehle@arm.com>

cpuidle systems where the governor has no choice because there's only
a single idle state are now handled by cpuidle core and bypass the
governor, so remove the related handling.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 81ac5fd58a1c..9b5b8c617806 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -317,12 +317,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 */
 	cpu_data->sleep_length_ns = KTIME_MAX;
 
-	/* Check if there is any choice in the first place. */
-	if (drv->state_count < 2) {
-		idx = 0;
-		goto out_tick;
-	}
-
 	if (!dev->states_usage[0].disable)
 		idx = 0;
 
-- 
2.52.0


