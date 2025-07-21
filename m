Return-Path: <linux-pm+bounces-31207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08836B0C447
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A1C7ABDAC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526AF2D5A0C;
	Mon, 21 Jul 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hng8XynC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59982D5A04;
	Mon, 21 Jul 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101719; cv=none; b=Lc5pz6RjLkI/hIzqmqrI741byjQFaM9ky7nK6dnUJBIXjG+xwZhmeyqTOD4n7k2z72dg+6geAayHi/FsoY8uGuNl0/EHVHeVFrM+T7s03cmH3oB169I77XVVqRC+uyLYsUo/3vmds1sF7EIux+RiPVYduLTDPLGrLbzCvvH8mGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101719; c=relaxed/simple;
	bh=w6KY0bttrOjHkYZY0aEkpiy2ZPnPtR9Qkt4ba5opjrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUwwFc3QyC5IVzgL+IF9qU1/BRGlJjfga6DhTAYsbdgOfibcrTErHHk9uKqEr73M8JT8fj/7wCHTqSz0nygfymMHWOpBl7tjA1pPiHGVwgSdIXl7NIYE1u5TdIzzYc6rJSH4O0bjpgArsL9wI3IO3KFh+o3lRTrXyYIY3qpNqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hng8XynC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAFx8e027797;
	Mon, 21 Jul 2025 12:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LBjBWJVPt/vr1haA2zED4BkOuELCVeXVsGzVfTOwRBo=; b=hng8XynCV6yADuRW
	E8C1Vq5r1J6WYrKhFj+7Y6BBvQlQ4WT/M+85cxSNYiQtEUS5yD0Wm9SPYJEbL4yw
	t24OHkv76qBKvwzbke0yRazCNCSvmuD7C8dzZKC9RdTzROalXpdcUzugTSs1M/wX
	dRM40elbky/YWczhdTD1OzXv9cpwAlqM39mEU62Gv15Kw32FZWjAFnkfq5ACUY8p
	EikUgQw+s3KxOo0c3PGRWKqkYNUPms5YK769HYWKgICxBh21hqLeDhnVdfETqYvI
	bdEcVoYHbSB0NUdPd/cTWtyf7fMt1xOSRALPExPPSvwUe6mrSDjFYRUSOKj6I7lU
	61Xc1g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045hd0j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LCfmeH002263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:48 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 05:41:45 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <tony.luck@intel.com>, <reinette.chatre@intel.com>,
        <Dave.Martin@arm.com>, <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 4/5] Documentation: PM: QoS: Fix return type and return value description
Date: Mon, 21 Jul 2025 20:41:03 +0800
Message-ID: <20250721124104.806120-5-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ZtDtK87G c=1 sm=1 tr=0 ts=687e358d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=2Mn5PldW32zOEzkLXbQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExMiBTYWx0ZWRfX74HhvHfgQUwu
 fvzhC1dMgi5Tjv6TptZlvqxf01Xhhoh6xgLB/wrq0vfN6MF3j4QT8XYWl3777D9md2Z0cqrHCM9
 ZbgF/6BHbc+qYuy14YbLrvxdw37PGSy+q9+/DabPxlWJweiG8oZFSsi4duX3GZsEjO6qiSwbbxi
 399REZgpeER552ecmR0Z+FVcg5aF2ujCOu8eS2G6+Fi5bs+BcY0jf1vBheqXhQt+Y3w9pkAd12Q
 YDl/mis+k/cYDrRKkEFR410gKk1IxeGuhd/AEVO+TG9sT7287glSOgNJk1G8auG8z6/Xa2kjaIZ
 yUbw/9BwrjOi/B9XFjFtYSnR8AXwnB9peSYBQe8PaQiwaCqWxtq5wxfmmGQy66TnVovUgu3LFnf
 Ub8AI05h1tURU9Bv650CHhCXUD8654Z8wfVhormLN6GSXCLL6nyxcgdGjIMcOHlzFzh9t/bh
X-Proofpoint-GUID: 8XvAua4r59u_aJHHNE5Lmg5G_x9lVbYZ
X-Proofpoint-ORIG-GUID: 8XvAua4r59u_aJHHNE5Lmg5G_x9lVbYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=994
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210112

The documentation for cpu_latency_qos_request_active() incorrectly stated
the return type as 'int' instead of 'bool', and the return value
description was incomplete. This patch corrects the return type and
clarifies the return value semantics.

Fixes: b8e6e27c626e ("Documentation: PM: QoS: Update to reflect previous code changes")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 Documentation/power/pm_qos_interface.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 1ede4cafc2e3..c6b8b9cda166 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -55,9 +55,9 @@ void cpu_latency_qos_remove_request(handle):
 int cpu_latency_qos_limit():
   Returns the aggregated value for the CPU latency QoS.
 
-int cpu_latency_qos_request_active(handle):
-  Returns if the request is still active, i.e. it has not been removed from the
-  CPU latency QoS list.
+bool cpu_latency_qos_request_active(handle):
+  Returns true if the request is still active, i.e. it has not been removed from
+  the CPU latency QoS list.
 
 
 From user space:
-- 
2.43.0


