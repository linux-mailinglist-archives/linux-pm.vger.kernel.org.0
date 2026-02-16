Return-Path: <linux-pm+bounces-42713-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NltMiFnk2mR4QEAu9opvQ
	(envelope-from <linux-pm+bounces-42713-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:51:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 373911471AB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CE63047BFE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB02E973A;
	Mon, 16 Feb 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FXG/7Q5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B62D7DD5;
	Mon, 16 Feb 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267827; cv=none; b=a0s6R1iA7oP+ex4Fmr3oqBPkExB7v0BgM9gn7HE6kPSM07f36hvDOLKOtRu+utAbfJOiphLxDQSrGQzh0SZMlI1N5+OjKdNZDtk1H+gxuFgNU/rzUwyXbQSTscEl7nnGA1Rbi7PEXucI+RDn2nxmB2P4bInFt4V/i+uT2OCiG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267827; c=relaxed/simple;
	bh=Q2kZc9eB7owlBPAnDEiNF7+eQmQ3CgKvg44VdYwO/WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWbVRXVIN3um2RZ5CzWQ01gSGmqIN9qlUfudejj12GRoXR7j8tcudqqtG4ehnJWBW3KylPdhoIZHnRr53qxmYXdAqzuk5RqUJVwzHmsYQDey0qvFXLAahHwuwzlmG64KH90kvL3ogRMC7zTCN/AHrToOVfLY9xynD6JI2Pdirqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FXG/7Q5G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GF3Dh73499605;
	Mon, 16 Feb 2026 18:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OOh6GxGAE/WLQciiY
	14zMdGuTpXN5iQKKKURhB1ofsY=; b=FXG/7Q5GfhWMvE3g1zNbuq8WfQit+iNW2
	sKqjUtRNZOv7x0ShFTrXnai/Gls8BCFdh0sCr2gtSGBVMFdbcULPc8oRgvhT+ISH
	jfV4/A+F7va1XPJ5lAKfmrn6mYpiOdMonT5n5wY/rBq8jSvusHaMn3fCBYpv4UAX
	VKkfMoJwoYoY5fTHXvO2tPmXU/dOrIWTd5VBr/1kWlOCHREu3Aa+2Tzaw73BwU8D
	1x+k3vhlca97EvCBcLLgnN2awT9Luimq5P1pH3WKRHinkqSlCRUrbrL+My3a2tvD
	+MpvnSEN2h+NkTACIewOQk5DLGgprD4IOmQcPQvD5CRGUXc233o0Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj640d7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GGjG84004197;
	Mon, 16 Feb 2026 18:50:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmxfjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GIoCUc44040580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 18:50:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF5762004E;
	Mon, 16 Feb 2026 18:50:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD25020040;
	Mon, 16 Feb 2026 18:50:09 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.7.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 18:50:09 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] cpuidle: Skip governor when only one idle state is available
Date: Tue, 17 Feb 2026 00:20:02 +0530
Message-ID: <20260216185005.1131593-2-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cgjSCwj_JlpQ_F2rxlQ_Uu3i7FrMgG5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE1OSBTYWx0ZWRfX/B8qU2BL2fTM
 Om0WQO+BHNAaz0TwglnBiF8yRGHaa+qfo/uGrEvbuaMMl+ClCBOVtw7qIdDDmtvgJsCMWt/a2iG
 n9zzA+CAkJHyGBOBiHcdId2ftjAL4rFjKIQRDFbUzFuNWErwp4yn4mxxnRuoJ7NBIsLjgfqhVMG
 nmQQPbogC7cyAt3nMJOHBOqCC/DeWFvTmypy0fmX178Smzq17RMICIFxha3jAhBM/jBxg9QG6ME
 WVYIEDbBIReGLHiok+ZbVYB6gsoelWt9PoPuOQlg8H/jCa0rdXpYmcfblqrsx0rJEIPpNfImHEj
 DV8ZoogX/WDSq5UFdFCXlsr2HUZ7T98HmHi2yyS7rV3GDcoSvEZ+gFiyJE9j05eDwT8JgeV81oB
 dMYyzplTaaCysqy/kChVsiqeA2zvZAi359fIXTmb8AVoU5dAD27RYz6X+wljmqd/htfQWvjBukw
 JfhF6xWjGUs44jKoGkA==
X-Proofpoint-GUID: cgjSCwj_JlpQ_F2rxlQ_Uu3i7FrMgG5D
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=699366e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=YIsf0ydp8jgAjUZD7Z8A:9
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
	TAGGED_FROM(0.00)[bounces-42713-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 373911471AB
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

Fix this by adding a bail-out in cpuidle_select() that returns state 0
directly when state_count <= 1, bypassing the governor and keeping the
tick running.

Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 drivers/cpuidle/cpuidle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c7876e9e024f..65fbb8e807b9 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
+	/*
+	 * If there is only a single idle state (or none), there is nothing
+	 * meaningful for the governor to choose. Skip the governor and
+	 * always use state 0 with the tick running.
+	 */
+	if (drv->state_count <= 1) {
+		*stop_tick = false;
+		return 0;
+	}
+
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
-- 
2.52.0


