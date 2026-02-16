Return-Path: <linux-pm+bounces-42715-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOUODRBnk2mR4QEAu9opvQ
	(envelope-from <linux-pm+bounces-42715-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:50:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B16147186
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C923230292F8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A32E9EDA;
	Mon, 16 Feb 2026 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ThrHEnSD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD52E7F25;
	Mon, 16 Feb 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267829; cv=none; b=KhFq2Y3fr8vYss/LzCB7JvPcCHAgCwLdcF2p3dzt7GKO+L0wW76CyoJco8Xp+6yygXvegTiqwEv9zyf0sYLqHfIdQH79pmytZSLc3denpoFw3N1qKgkWzeVthBiUkrRhJJ34sP4A+CzA6xzTiDp42ecJoX2z/cwM/OBO52up8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267829; c=relaxed/simple;
	bh=Sc2dXiAJT/OILgjmrc3sKwHesOwNC8EtU+wzAqoAZAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKD9cImzxdrI+4N91plspCmtWTTn0uqkwCmCsioLFK+nGWO2pi/6NI8Ke9ghf2MMiD444QxcIh5xowRjcM/k5/FhNuyt4yrCcaEmCW4+mMbyZy+o8G2ycetZA36xrnZgQTnXppCXSPtLHP7N6wotFxr8aIwyu2+wLOg8QJDOSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ThrHEnSD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GEAraK3665841;
	Mon, 16 Feb 2026 18:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6ROujHPnS2BiHwuvF
	XlBPmdEyb0ri/ara6lyT6CkQSU=; b=ThrHEnSDzSoPASDiIXICqhEusrFm8/Hwx
	330bAAbrpJsvSSu1PPGO8Lsj80VBuEWmqjTDxSDMZlgC4JMDnkHEZuXs8+EdnHw1
	k1TicZZbaJeoSmwXE850QI7+t6ggZyb13sJjN9QJnsUvICpVvdG4yGRHm2GzDnE7
	plx2m+Li8x8XYjTVTyCTGlVeLI2CTrvi63ulpzRT0QOvXb1V2xbVUusIY8o+B/2D
	cnL+rgLEz3ChP2iEIlma9vH+JZdfjMXpuSprTYM+EY80jH23Rl5cgtCfb3wUTBXr
	byN1FPJndPJAG92pvGRNJj2a3gkLF4zkUzo1LOAEgpOWfedvcTnwg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj640d7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GI6fIJ002862;
	Mon, 16 Feb 2026 18:50:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb5kj69w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GIoE7V28836498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 18:50:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F2520043;
	Mon, 16 Feb 2026 18:50:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BDF120040;
	Mon, 16 Feb 2026 18:50:12 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.7.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 18:50:12 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] cpuidle: haltpoll: Remove single state handling
Date: Tue, 17 Feb 2026 00:20:03 +0530
Message-ID: <20260216185005.1131593-3-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 8S5HVXF4hYMcPbpLCAP6NAioI2H2bkPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE1OSBTYWx0ZWRfX1DpsWIS8PHG8
 GW3EKUbZhwmTlH3xupFRXrnGs2FD+CseYXqX45pL0IWNHJ3piOQTfE5lvh+n1NQ/PqBtkMb7Iq4
 NYOjqPik1sAPXpeUQSTRkI90Ehrdoqn1L1bE8k7oDG6Qo4iE0zbHC0rJ4kcOd3O4rhO2nEVI+4a
 o1mlC8UrRVeIpBQO95hA/Z8+yo0L3JkRYatRJFkr6wEekTShf8WpWaUKMPbe7LUoDQlnE086yu5
 9430xiKU1Z+9zIFCfRIEoRiHnP7WFmSvkuDq00HmMMCgoAReu3hYDFDRG32+PM6eGmdUNQilmCj
 j6/5htPf/JWfbnZy7OGzQAXyc1YB7ycnXkVPmdQgv+Z178MtkJOIqkuN8x/p6J7D0x3FueHuXfH
 Yo7PzSzE+hbo15VV017RFmx3m0Ceam4Oiw9BbQRRH7oZTi+ODfMwqO9M/qr9F6thBVOTqDilNnE
 3qx003lumrjOfqpCq9w==
X-Proofpoint-GUID: 8S5HVXF4hYMcPbpLCAP6NAioI2H2bkPn
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=699366e9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=S8W45NxqTDoTMVILZQQA:9
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42715-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A5B16147186
X-Rspamd-Action: no action

cpuidle systems where the governor has no choice because there's only
a single idle state are now handled by cpuidle core and bypass the
governor, so remove the related handling.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 drivers/cpuidle/governors/haltpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index 663b7f164d20..ed3952df8526 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -52,7 +52,7 @@ static int haltpoll_select(struct cpuidle_driver *drv,
 {
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 
-	if (!drv->state_count || latency_req == 0) {
+	if (latency_req == 0) {
 		*stop_tick = false;
 		return 0;
 	}
-- 
2.52.0


