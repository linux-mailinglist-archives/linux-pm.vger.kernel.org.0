Return-Path: <linux-pm+bounces-42712-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP0vIPxmk2mR4QEAu9opvQ
	(envelope-from <linux-pm+bounces-42712-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:50:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F10A147177
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1FD83033A8C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11622E5B32;
	Mon, 16 Feb 2026 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P1T00KBT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5829AAF7;
	Mon, 16 Feb 2026 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267824; cv=none; b=Q4/jcRZb0Ohu5On67G/FKhHEAR5djQqZYmzf3LkA9YAeq4Z/OQf6XwoCDnbIMENcyd2lkjWzL1xETv4lnzJzlMySvSm8kJg8aPBo+wsByQ3FXT3bWnfT8TnZA5Jt9jlrzBZiwLzaQq1V1XSQh+T/mY73VIgw56B6CYeqcau+lmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267824; c=relaxed/simple;
	bh=gsgz2dA4l43s3E4uicE7uy3FMI9SOkiJpnZEtEEFjGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZKFDdllYTGtpDyUTxnRIoNR/7CRXl1h0EDS0ht/tbSVXwu2jf5EJr+TA5tHwbmcDHifQxPl8eL/c9iCYqTQ6AZl6VwORhExAox45G5ATl08KxkpxyvNEPVn+kf4qHUX+hxNbf3r5fjTtP2dui4/gZb9GouOHnadpAFlUdvTIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P1T00KBT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GEqhI03526026;
	Mon, 16 Feb 2026 18:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uaJpw/TT3KKhCYPwQxJxtLf9PeFK2UyLh7CGRHL9P
	/M=; b=P1T00KBTwGNO9zQH86OqKOj8kAw/6AtWM4ejdI4QzPnwUpspHe83x8Csq
	paNUDhx/nCEXQ63QnL6YG/drkktsFvmDKXzCbr+rqroxQor29Nr3T+khDbmNtatx
	34k2sPxugSWmKe+KoHRDoEUQ1sRUfRIWGWhHNfz6o+kQps+YJhBRK+cWXeCvFW9R
	73n2WgxlFZT4T3QrVmEnDGqGbaJM2wJHlwZE2d2Er0XlaGfnAH0yaBGRjotyEB0m
	vAhtHnV89rCjxe3qysBAC2y9Wfq/WtJucbms7H8frxKcdQqdLq++VV1ZJitII+dj
	QBfDSie2ArkOBy2wj0G4PtX8AbBlQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj8crn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GH995o003762;
	Mon, 16 Feb 2026 18:50:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmxfjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:50:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GIo9Ub58196460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 18:50:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E32E20043;
	Mon, 16 Feb 2026 18:50:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C6EE20040;
	Mon, 16 Feb 2026 18:50:07 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.7.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 18:50:06 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org
Cc: aboorvad@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] cpuidle: Fix crash with single idle state
Date: Tue, 17 Feb 2026 00:20:01 +0530
Message-ID: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JLOgnF3_C8jcX7mqtfnmMk8s8zEphQyC
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699366e3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8cvJxYw84IpXfcRceYoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE1OSBTYWx0ZWRfXxOkyB/TaDzJl
 UCqcqNcYHHDMjbbBO2Fs3SncH8sOXusMJ2G/rQp3aiecIgu8Koi8DyPHDX05++4npy3ck3sG6Z3
 94bDn0F1UiYephyAwyf2Ev4lMMjUS9t85VehutX1wN8PcqiJa22dk8cfjKa2O5iY3CSSPCt8ya5
 OTwTTvqkoyCaF5DzBmkafT8SV0wGcSzbzH7w6RRxJ5Bl12B1w22CV4WX6Pprbxvgiymv1Jg05Ak
 dd7xDR5Bg/OMboflkEmLuaY9dQhHZrP0gC1l4n/hW8HdIS5mP9DWApHYmoAYiaFz+eQ3F80DFq/
 +Bwr0V23C0FNfZPKpe3oNjzqnbLJyd/EEpYVxiFnB92hdz3KvuuFmk584DdZsu5F+cxCAbdSmQm
 I//glMjGdPqJ0ZnIufUFQlVAkmALIYQe7Kof5To4wxhQ7LDVLcpwDMvS6k8ikVbe3tT/BiOFM/5
 R8lbUjGuaMwRawQFEGA==
X-Proofpoint-GUID: JLOgnF3_C8jcX7mqtfnmMk8s8zEphQyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_06,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42712-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1F10A147177
X-Rspamd-Action: no action

When a cpuidle driver registers only a single idle state, the ladder
governor can compute an out-of-bounds index, leading to a NULL pointer
dereference in cpuidle_enter_state().

Patch 1 fixes this by adding a bail-out in cpuidle_select() that
bypasses the governor entirely when state_count <= 1.

Patches 2-4 remove the now-redundant single-state handling from the
haltpoll, teo, and menu governors.

v1:
https://lore.kernel.org/all/20260211053552.739337-1-aboorvad@linux.ibm.com/

v1 -> v2:
- Move fix to cpuidle_select() core bail-out instead of ladder governor
- Remove redundant single-state handling from menu, teo, haltpoll

Aboorva Devarajan (2):
  cpuidle: Skip governor when only one idle state is available
  cpuidle: haltpoll: Remove single state handling

Christian Loehle (2):
  cpuidle: teo: Remove single state handling
  cpuidle: menu: Remove single state handling

 drivers/cpuidle/cpuidle.c            | 10 ++++++++++
 drivers/cpuidle/governors/haltpoll.c |  2 +-
 drivers/cpuidle/governors/menu.c     |  2 +-
 drivers/cpuidle/governors/teo.c      |  6 ------
 4 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.52.0

