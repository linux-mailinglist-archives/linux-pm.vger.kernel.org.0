Return-Path: <linux-pm+bounces-12036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C194CB61
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 09:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00288B24889
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751FA175D5F;
	Fri,  9 Aug 2024 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fw3Zi08V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917A42A80;
	Fri,  9 Aug 2024 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188703; cv=none; b=nOH2cy1Mmiu32YGsLIboFM+XC/+y3nVWxC456yO3Sui8S7p+uDb12s50MITQz0j9vjY/uw1oax/2klFmF7H6zoiPhxUBEegFHY7H5zAqfj7dvtwEO9uI2/IVXsiea1op+TB/vRhuc/sU9b99PY8PiKC8iozkjy9mG5QxgmQGMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188703; c=relaxed/simple;
	bh=yMQ3Q3eLvNbv9q2n1oFCiwLvHFSgMLVSSkJlH/F4ODo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrGf+iPePMESqEz/YtOem9b9FAzES1DhrNkfXQ588PzLJerQ5Uarb/VjqB45LEaXCBGUT7dxbsyLBADgy0RSzHlcG8jEec0+t/oOj6nbbLHOYZNcbA11TJrr/HHsIjR5n9EXDiJu0ueG0S3SemKC5D8k1yo1STl83OopFmfpHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fw3Zi08V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4793vX94027462;
	Fri, 9 Aug 2024 07:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=A2J2fMDbSsONj
	HYVtVqbdyBvoF11xb7WI9cAk+oPzAo=; b=Fw3Zi08VVl+xWmKryPsif9fJ0ANAa
	T3zSzxAoAtZZejMtpeLZf6lI4NpF9o+D6Wdpp8IPYZBDzg0U0eulEvDRtRkWVhMn
	dnlLk6vleyK/jtr7RbnbsuGpHdDjG/9FxVAd6K/hWzS8QKzubPb820KkBv9jlvMu
	5fX9/RzGpkmrvxqTFnC+R8qDEOfg4IwTi6rr1bdcqjlCCFy0xTutX2199u5TD8Cm
	/PasmoQwj04pyzFWS4/w1ZScbLPz4MkO2TAwKXOluURL0mcSXe6kOl6Bp35pPiQE
	4xQTXTTOgho/RvwLe38/qVFarsvcZTtw47oUvO2mdWpdv86NQsdpBFcrw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkd27gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 07:31:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4796xOJe024361;
	Fri, 9 Aug 2024 07:31:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy912m79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 07:31:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4797VRrA50856250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 07:31:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3842004B;
	Fri,  9 Aug 2024 07:31:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 501E820040;
	Fri,  9 Aug 2024 07:31:25 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com.com (unknown [9.43.8.213])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 07:31:24 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: aboorvad@linux.ibm.com, christian.loehle@arm.com, gautam@linux.ibm.com
Subject: [PATCH 1/1] cpuidle/menu: avoid prioritizing physical state over polling state
Date: Fri,  9 Aug 2024 13:01:20 +0530
Message-Id: <20240809073120.250974-2-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240809073120.250974-1-aboorvad@linux.ibm.com>
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lw_nz3AssyCdF4eSBwEL1UPnIp7kA92X
X-Proofpoint-ORIG-GUID: Lw_nz3AssyCdF4eSBwEL1UPnIp7kA92X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_04,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=861 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090052

Update the cpuidle menu governor to avoid prioritizing physical states
over polling states when predicted idle duration is lesser than the
physical states target residency duration for performance gains.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 drivers/cpuidle/governors/menu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index f3c9d49f0f2a..cf99ca103f9b 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -354,17 +354,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
2.39.3


