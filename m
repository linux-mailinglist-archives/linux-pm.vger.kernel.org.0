Return-Path: <linux-pm+bounces-24749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09536A7A007
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA811896823
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2424166C;
	Thu,  3 Apr 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bMhdXqRD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A718DB10;
	Thu,  3 Apr 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672558; cv=none; b=XF4p7Y912cYCYnOW52IC7alB7XTa9aCKI+BNrErv11guyv1YDLTwptUZm1T0FjmqVfmEsPVQo3wwLPwV17ID216LKfrZ0EPmz3jUhEoSiK2ijcVPZ1rO5W40BaMZbJ/72Ho5RlqxfPBzrztcln2PyuIzawyH2X8MhAwcqgKmcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672558; c=relaxed/simple;
	bh=VM/cLfCgm577hl+3Nc9rRc0FiWM24kqgYPmrFcyaPJM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sHm322fF8Vi6SbRBP3pE2xWmnTmcPLTHjBb1MYgmdauiHg5gtcw8Z3f/nkMtLJZVK0H+XPwXNZ7yn/H0iRmi25X7nPZIemN4ly0TU0vSFV9s4r9F2SH0v3KPjcKCiHVMmiFR2cQfkI27r3pCMyPDoWIbeiUOqJY0gjsjKU0WjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bMhdXqRD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5338FV2v025054;
	Thu, 3 Apr 2025 09:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9tGsEa4qOhX/M1jjIfZ6sX
	mDCAWmoTmJ0boB7K8AKrM=; b=bMhdXqRDcwe3yB+T1KZnic+UU63BFtQX7vC+ih
	kGBWNpJwvq2Ajd5Fo+0wnjV5owmy0NARaVaKkgk9iLmhDBqkMyhuv2ngW3CjyIan
	RF9nqDU3WFCU64E+nIH3bOdah061406Oe5ltAvhE1sn0sEbPNLbGrT8u3JNMh2hp
	eRUWQxaVb5pzAJR5kqmrw1qBeqBnGQVaH4Y/GOOjsB2JRfaN4+2D/QQNN91Zbvv0
	O3zU4Zr6WGBh625Q7Ty3tvIICE+AbYnaa9sksyvWUoO5M8dYIeBmphKBFiI6VIEH
	amjAPS9gE0IGHKbMqHrBmKpMozV9oeyvx909V3ouMFj4pMjw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45spnp073n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 09:29:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5339T7QQ032276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Apr 2025 09:29:07 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 3 Apr 2025 02:29:06 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] cpuidle: menu: Optimize bucket assignment when next_timer_ns equals KTIME_MAX
Date: Thu, 3 Apr 2025 17:28:52 +0800
Message-ID: <20250403092852.1072015-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tGyUaV91xNkiQfUo-7cu3cd2svw5GMMY
X-Authority-Analysis: v=2.4 cv=N/gpF39B c=1 sm=1 tr=0 ts=67ee54e5 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=oV2fX3CoP5SyQ73Pz8oA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tGyUaV91xNkiQfUo-7cu3cd2svw5GMMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_03,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=815
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030033

Directly assign the last bucket value instead of calling which_bucket()
when next_timer_ns equals KTIME_MAX, the largest possible value that
always falls into the last bucket. This avoids unnecessary calculations
and enhances performance.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/cpuidle/governors/menu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 39aa0aea61c6..8fc7fbed0052 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -255,7 +255,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		data->next_timer_ns = KTIME_MAX;
 		delta_tick = TICK_NSEC / 2;
-		data->bucket = which_bucket(KTIME_MAX);
+		/*
+		 * Assign the last bucket value directly instead of calling
+		 * which_bucket(), since KTIME_MAX is the largest possible
+		 * value that always falls into the last bucket.
+		 */
+		data->bucket = BUCKETS - 1;
 	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
-- 
2.25.1


