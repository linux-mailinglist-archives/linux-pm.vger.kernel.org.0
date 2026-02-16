Return-Path: <linux-pm+bounces-42714-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHdbGi9nk2mR4QEAu9opvQ
	(envelope-from <linux-pm+bounces-42714-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:51:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F5E1471C1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41552304ADAF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD812E8B64;
	Mon, 16 Feb 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wyc2E1io"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF029AAF7;
	Mon, 16 Feb 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267828; cv=none; b=qx20PxqrAqWl8/FgAGLBdrkcXKq5Y7OKufNpbcBdmXFptCrofnqrbK0HFm3iis1m4MzewAVVuclxeM2QLF7C2JDeohv7CbETc+BYd1cqNJdHbqvX9rKzCEqxB1128HWMADS0k0ExOp/WPdzKHIfPUXJb+rHyx04swv98cg1Z7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267828; c=relaxed/simple;
	bh=9dePlDcovVzKllpAQWYk0HpX/eZLz/mIK5zPQooAgI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGVAsl6HB3gyKVeCmJyGbsY76ktrEMV11x4XxxNU+gt5g1nbvVHdibYxAvDWeEtNja4Aa2qTi4ozsDiLvl7JTUIclw6jNWRDtgIPQ0v7iaYjg/UHtf7tvRuvq49/MWuL+oIc9UxFsCW3Nk2sQKSbdNXpHv2agSo4ErXpVFQK3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wyc2E1io; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GH0laD1506974;
	Mon, 16 Feb 2026 18:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BPKtRnxBkzvXFY4m4
	NkNz8Pk1ELkIuYV//tuZpi60MY=; b=Wyc2E1ios99TU0d0j1S1qZIxccL+P2TTy
	OISdiOc5a2P05yc44txPwY6sAekaL3NDHtquNraScKzxBdN9LrnZRIO2glgnpMcS
	I/TG5ns+99SJsXp1qODqsxY3pZ13CSArAX0mTcHuHN4qkJh5E8JqJHnaBeAUUbYI
	Jk1HMDZodIRG1bCgzOpWigFRGFCeVxEYJaJ9gKUrXlLypJ4Id7OeVg13dTY34D4+
	VH16HEzxu/3W/lX25FR/GKvE/uOYBhG4iN5LPgJ/1WwUZ3aclmCiBqjJSLfaiQRV
	EfzGiMbAvP5t0L+qD7PUiHNMxlj0bKXPRAbSSO3gM2HugRfEAn1qg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj640d85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GHVG1H032477;
	Mon, 16 Feb 2026 18:50:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4vjxecw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GIoJIe44237286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 18:50:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CC8D20043;
	Mon, 16 Feb 2026 18:50:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781B020040;
	Mon, 16 Feb 2026 18:50:17 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.7.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 18:50:17 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] cpuidle: menu: Remove single state handling
Date: Tue, 17 Feb 2026 00:20:05 +0530
Message-ID: <20260216185005.1131593-5-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: jZLpsB_5-pUAzWO5SAsd3RIpFEycbCD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE1OSBTYWx0ZWRfX5WR7W/2yvzXu
 gTSGA6DNo0ZsdIF+IUSlyL5UXOk/vCTwsHyGD2Per6K4DY29JKmwjBoFyAi79xNkouuyz3JRwzs
 pT8fH889Dn/nlwXOzhYVfUSkh8JcWydPyQmr99W4Ab9rALyXvFJnFfTyQm3E5JiAK39g2sTrq8I
 yC08dC+9+/CozrWOLlfJBXYREdabj2nxY4Y00xieQENWof6kaKZUD+qWZlXu7O3G7jZOJMrsgqz
 5eGdCummpo9OW3Kq0YLYxVFoI7CMozGe+ajI+yorTw34aTxtNpl+HCgt7K1W1u6DGkH1GYpxGw4
 oLvf/q6yZNBxwED8L1/U5jjpGCz0Qs+9ffjvwbCG/tx2DdohSgdHjsLaIrAOOEsKLaGW7LfNKTm
 oo//VvMd0tXvMkasMugEbz50kUEHhhmDNlh74ziZVsMtCnQlgkC2s/4y27M9/dPIJvP3aaxHfka
 lQR/tU85ouvqTlJ/Bng==
X-Proofpoint-GUID: jZLpsB_5-pUAzWO5SAsd3RIpFEycbCD-
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=699366ed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8 a=H2bq5lvY-VcIl05QleYA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_06,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160159
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
	TAGGED_FROM(0.00)[bounces-42714-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: C8F5E1471C1
X-Rspamd-Action: no action

From: Christian Loehle <christian.loehle@arm.com>

cpuidle systems where the governor has no choice because there's only
a single idle state are now handled by cpuidle core and bypass the
governor, so remove the related handling.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c776..fdfa5d7e10a6 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		data->bucket = BUCKETS - 1;
 	}
 
-	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
+	if (unlikely(latency_req == 0) ||
 	    ((data->next_timer_ns < drv->states[1].target_residency_ns ||
 	      latency_req < drv->states[1].exit_latency_ns) &&
 	     !dev->states_usage[0].disable)) {
-- 
2.52.0


