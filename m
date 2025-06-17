Return-Path: <linux-pm+bounces-28871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D8ADC54F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 10:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45A41894C12
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9E28C036;
	Tue, 17 Jun 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o71sq5U6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7285260;
	Tue, 17 Jun 2025 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150033; cv=none; b=KUVbL0Ho2Cq/i+bNiTqq1NY/rFSUtNski48pNyqfJxunP2DS06I828djgRp3t8ZkqI6cG8feVWIKJl4GcThjYxIbxcHdLUhDlupCkY7nTifsPztc78XDeLWJIYV85jA1gGFn62iya/D8zhJm8Kwk/p4siMcPSVJj+XM75ws9nKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150033; c=relaxed/simple;
	bh=LfBfzJOI9hyof9Q7j7bpwacs6cutsXJf8ZFmcOMRXnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jOldw4tqb8FmJMlp2y0V6GK3z+437uU1FUPHTQpcFiq1zc56IkVijqnX7POK4g3yT6Sh6KOmkm0pMzuS9EmDj1pBtc8KnIG1xsMU4ef1yue3HLcMehyqF/0s5wVpOC8gKc6iuhhSsCR3hTgYFkjFtsCzf+d/eLochwbc7X88nR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o71sq5U6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H5gW7j027045;
	Tue, 17 Jun 2025 08:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V0az5VXjqwYak6U75gaKDM
	VsBD+fhMtuhxxxgPjDMGM=; b=o71sq5U6vpw4d4KnnO/tcaojBjbtE2hhV1f4qj
	+oy3ymo/u5pz6dBR5QHUTt+EFUqxcKrcuiBDWVn4VRzTSshnIH0qMd/aSIbhBO6o
	N6W/kxquwFfxgjn4oQyE3c0TcYIPmUAN5ZJ/SuZ9WckiiWu4GyP7c7vbGtVOR0Do
	NW2imdIftUv/ZfJb+q/WsH3d3iM09q4gkgT+7uyEb5JPFEW/vSdily1OyLHOKj6j
	4K6LiICcHNnXbqZ/Ud3zwLbslSvQSFJWIlwUN4ssinzxWJCx+Md9+Fg/N/9Tb4n2
	ilUadY6prfpdbXFhOU2+2uFMCRy2/k2lunRO8DuxRzLaeTZQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hffq1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 08:47:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55H8l6w0019108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 08:47:07 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Jun 2025 01:47:04 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <len.brown@intel.com>, <pavel@kernel.org>,
        <gregkh@linuxfoundation.org>, <dakr@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] PM: sleep: Drop superfluous might_sleep() calls
Date: Tue, 17 Jun 2025 16:46:50 +0800
Message-ID: <20250617084650.341262-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA3MCBTYWx0ZWRfXxUxF55PT81qD
 m0BR7hu26yW/zYrUDbFPGtHPJGJe3ZX1aLvHQki6DtTKYSNrQrI7MCVRWMWIXaktEeKn7JH4ehI
 BrLRT+Az9JuwJwHwoAckiUHbaCNoBvhJbCa/6hC/OD2WUgAipx36KRQeDYP+g/mde5/C6Y3ULtq
 aNaYy3VLDfsdovGKZtEc9oP3eTw75rDr2Nq+8oYI4bu4zu4A9lxoLlOSrF2stMKj20vNlilRPLY
 waqax3aU9KCrRaG8ZVXyEjo2UKCrFHyNElJZbuukpG0oBnlDZ0Hyq2l3zN0fc1kaqvhr2spIQvo
 yMjNa7gPcKHZKEGOBQLJeKl2+Irb3bz4pHNgmm8LLsgS8ktmbBe8qYRR58hP/viLigY2tGnT6s6
 ip9f09HrpAwdD4AIEhje2yKC/rNqgBCXLr6V9f+V5gmT6zsWNWMgdrtUNYnkE5mRwbO+0qkV
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=68512b8b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=Ct5OFoWzB3YGJjc9bSsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VkNDCt0wgTQKyumgFyg4F16KeqF0D_Co
X-Proofpoint-ORIG-GUID: VkNDCt0wgTQKyumgFyg4F16KeqF0D_Co
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170070

Drop superfluous might_sleep() calls from dpm_resume(), dpm_complete(),
and dpm_prepare(). These functions already invoke primitives that
implicitly check for sleep in atomic context:

- dpm_resume() and dpm_complete() invoke mutex_lock(), which internally
  triggers might_sleep()
- dpm_prepare() calls wait_for_device_probe(), which internally uses
  flush_work(), and thus might_sleep()

These annotations are unnecessary and can be dropped to reduce clutter.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/base/power/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index eebe699fdf4f..0f40c00c1401 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1095,7 +1095,6 @@ void dpm_resume(pm_message_t state)
 	ktime_t starttime = ktime_get();
 
 	trace_suspend_resume(TPS("dpm_resume"), state.event, true);
-	might_sleep();
 
 	pm_transition = state;
 	async_error = 0;
@@ -1198,7 +1197,6 @@ void dpm_complete(pm_message_t state)
 	struct list_head list;
 
 	trace_suspend_resume(TPS("dpm_complete"), state.event, true);
-	might_sleep();
 
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
@@ -2109,7 +2107,6 @@ int dpm_prepare(pm_message_t state)
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
-	might_sleep();
 
 	/*
 	 * Give a chance for the known devices to complete their probes, before
-- 
2.43.0


