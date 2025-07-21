Return-Path: <linux-pm+bounces-31205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E246CB0C442
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B323AE644
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F32D4B58;
	Mon, 21 Jul 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZUmHj5CK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B32D46A6;
	Mon, 21 Jul 2025 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101711; cv=none; b=cOjUaUYyXd6r97bb6c8WmBACaROH8sXYugDWH5uFNO7vVrbnBD7q+r0WA7ZAJDCklGX4EQU+jzc6nRAKHY5cZCl0murC2ooxCeTO+vgnsX9LkA4nFoSYdAAutrClL1bPqugrabCvUp09ezXU6Q3NCNPfjcLKzYsK7lhXlAFEE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101711; c=relaxed/simple;
	bh=/O0oL8M5iv3njslxJtm0ds9/xnPMTHj3/8kLM17CYT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihf6hST/VYhFBmUMNG0KcvkFZSVMV7UpTZsaHQXT8WTR3yBffLEGYs909GgURId7IhqQnI0ltLwR2JYPcFM8yq+GTZZehfTwUaM5OOdQ9nUufGTgv0RLkhJzzC8Y+29szPmK2+PCC6Zscgn9FPqei/+wfS8AYJYQp0kCYDluRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZUmHj5CK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAMn2D015997;
	Mon, 21 Jul 2025 12:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I7R+WwqsFV5K3j9XqjXcaemw9xPBfHZ8TMOu7cwD9C8=; b=ZUmHj5CKdeyQ6KCC
	/URcCe0tUCPDrpnFnKAsXfyM5E2kNFHDN21vF4o+D6pWYMd/qnWGFIVvBB7Y/v2P
	ar3o9IPoJ+JZVbJJqJVHmU/ux3TcCsxM0BsNO0nR7QV9yex71Ih72zqLAjywOpv7
	v6SX3S8/ckbA+jvE4zICZ67aTWo+Ha7cfWhsMEGmLIcZ5tIZb2gcQR+Z+2czNW3i
	ZppgwTHMfUEgBFqlcu5TX/JeoDVpxAfede1+TAWfFP6VyxDlLJi6IeIY7sbjd14Q
	Y0ga+w6M5jmvk87qQ3PfxQX3MWrJzvFxkihVzLkfb8T8F2PQHCyWattvrlIondde
	eVrPbg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451d11w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LCfg2X013973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:42 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 05:41:38 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <tony.luck@intel.com>, <reinette.chatre@intel.com>,
        <Dave.Martin@arm.com>, <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 2/5] PM: QOS: Remove unnecessary KERN_ERR on WARN() calls
Date: Mon, 21 Jul 2025 20:41:01 +0800
Message-ID: <20250721124104.806120-3-quic_zhonhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687e3587 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=k7MmHeaFQfK7UbCyMzYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: A2Sfi7SJmZpCH5Byr5an09FqytF1BlCg
X-Proofpoint-GUID: A2Sfi7SJmZpCH5Byr5an09FqytF1BlCg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExMiBTYWx0ZWRfX80h3PNe/XjJc
 5lcP3CqLYbWk/zOytKDwUYNDjA+mdnBP0XOLxl1P2LMtEgJIWPrsS7wimVnEdOPTVEkp4HKEC1W
 UtvsyfD7+/I6MVuFiIrwjQUiPAgj/bJfytOSN3PEyZPssujDFGEmqZuv698I5SeWsfq7OLjNPZ8
 V2yTEZOHMiCF3wLnG4h0aICOFk+8iytDGnQSJr0Wzb36o97QW1VlqTQdRo3QmDed1OR/DijH9hl
 SBG0RK3QfUcKrVsFGEF/+1zzAt1UZKyjmLdr10L4eD+EE5i9UZ766fxEppN8H3CGJnHe7KBcDyk
 WnPvgaUnxEpBTFituNakNdAvYQF0CbPo5VGK4yJAx1z+XpYtFq9BfLK3FA2poZEvu7AXoJ5oTvF
 R+W7LHJmeEV3X2E0plr1DswylI8oB8ymBhJIOMn7XvlA8ni5Y+fpINJ05IRxGsxQ6J5936Oi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210112

Remove unnecessary KERN_ERR in WARN() calls and the latest version of
scripts/checkpatch.pl also warns about such a pattern.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 kernel/power/qos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 5e507ed8d077..5c157004b78f 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -272,7 +272,7 @@ void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value)
 		return;
 
 	if (cpu_latency_qos_request_active(req)) {
-		WARN(1, KERN_ERR "%s called for already added request\n", __func__);
+		WARN(1, "%s called for already added request\n", __func__);
 		return;
 	}
 
@@ -298,7 +298,7 @@ void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value)
 		return;
 
 	if (!cpu_latency_qos_request_active(req)) {
-		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
+		WARN(1, "%s called for unknown object\n", __func__);
 		return;
 	}
 
@@ -324,7 +324,7 @@ void cpu_latency_qos_remove_request(struct pm_qos_request *req)
 		return;
 
 	if (!cpu_latency_qos_request_active(req)) {
-		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
+		WARN(1, "%s called for unknown object\n", __func__);
 		return;
 	}
 
-- 
2.43.0


