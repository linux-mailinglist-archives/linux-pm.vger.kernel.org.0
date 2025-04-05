Return-Path: <linux-pm+bounces-24843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DEA7C97B
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 15:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D997A6DB3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B57C1EF368;
	Sat,  5 Apr 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AaJJ56Kw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2344C74;
	Sat,  5 Apr 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743861229; cv=none; b=UbqlmgXvex6xn3D+BCrMaWqxB3J+X3OveuzPlAM5IFlcAg7a3pfEyQCd1C3WK6r5Tq91nahEMeGJWk47uPeluj2KBcYQTaLZ2/bZDpYXVxBGtuhNsLQUoXAwkHcysvtvqdtr2n3QFC0sbK7Ns2Avd+3Bcaup8yuOkg+yylFxZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743861229; c=relaxed/simple;
	bh=6kbRGQd1SkeeAIEBr/yL2/lIqNa6RfTO2IR0o/S3lgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MbqSVAcsL+exM6b/6QLQIG3z9SjEPdImE6jo7Ulo3vhcziLpvHcJndD+4wGLiR1w5NO0ffe2HlWGvN9VJynu88XLLESx5ZYM+HtIl9MYduo8lzHf7+25I88hEqmKQ6OPev1Z179yl7iEPvBWe+j0O/z73dBQ2FVX6MdN6faVT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AaJJ56Kw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 535B9sHA027789;
	Sat, 5 Apr 2025 13:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=djBv5Xe95ErQ/suR/GZcXg
	HV0QBorZnp1GcAyIUIdhM=; b=AaJJ56KwtiBjpqBlELAEXNwshqt78+pT+MjeUN
	vHhk7oU1X5aqljTSRQfG9k5zXwf6w/RualNoBJmicJxPDV4qhBS5iEUn0dehzcoj
	Gdi/Irzb5M2YZNI7HkmE/6vyR13myVMZhdOtpj5Z9lHyT6VXqCSSXCsynMtFg3ep
	JKkxw/+9tNmedqHcwyUXPLdG/aoicBUPG70wuqwaVLHChZsFUEvY+zTNYii83zuS
	q1rZBr4j183XjszIaN6hpY+izjORm9yPFtuvqHPKEGn5J2PeCejkwKIXPXCM+zxW
	qi1j5EKonpriHENWZCOmn7lOzAPX+gosnuWnpm6K4mqN01bA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe0je6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:53:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 535DrXJe023032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Apr 2025 13:53:33 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Apr 2025 06:53:31 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH v2] cpuidle: menu: Optimize bucket assignment when next_timer_ns equals KTIME_MAX
Date: Sat, 5 Apr 2025 21:53:08 +0800
Message-ID: <20250405135308.1854342-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-GUID: _JCNgLbSgJlseBRLWeykxQOEX2ZMpXJ6
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f135dd cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=7CQSdrXTAAAA:8 a=8PjpGhcAf3todJjbOTUA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: _JCNgLbSgJlseBRLWeykxQOEX2ZMpXJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=708 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504050086

Directly assign the last bucket value instead of calling which_bucket()
when next_timer_ns equals KTIME_MAX, the largest possible value that
always falls into the last bucket. This avoids unnecessary calculations
and enhances performance.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
v1 -> v2:
- Rebased on top of current next.
- Following Christian's review suggestions, remove unnecessary code comments.
- Link to v1: https://lore.kernel.org/all/20250403092852.1072015-1-quic_zhonhan@quicinc.com/

 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 39aa0aea61c6..52d5d26fc7c6 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -255,7 +255,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		data->next_timer_ns = KTIME_MAX;
 		delta_tick = TICK_NSEC / 2;
-		data->bucket = which_bucket(KTIME_MAX);
+		data->bucket = BUCKETS - 1;
 	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
-- 
2.25.1


