Return-Path: <linux-pm+bounces-22421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F13A3BE00
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46513B34AC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555301DE2A4;
	Wed, 19 Feb 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ay55fBXp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81D1D52B;
	Wed, 19 Feb 2025 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968078; cv=none; b=mmPTuqCWoIBhxhiVLAqZKS3X42hv2UjmhiE096r4cUbChauq6zTv79OG4gfB/co5X9QIZVDOzqnY/Ic3QLvC0g5zWDIBQr+G2/mn3EtgHClKbkLF7JyxbkoDzbHyaay8jeJFNjDIWDP0Yz1uaObI/2eEHEQnmVO/hYu66XPVFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968078; c=relaxed/simple;
	bh=PzstfB5Kk7OA2NbabaBac/ub6s4BQnchxzHxs6Spa0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sgZqg3h4+CuQQ77iHUEjRkSJyAzU5VLt1gGeMdYE4dQZdFdLiCPNRTFdkEKVOtPe0l+/rMVMgPFu8GPMZsXofqsewIAXtYMNSHRHXgx3MYcFgutUaUuZWhcnnRXMy6ssOrtfvlIWykSe/No42D18hlSWSWq1vVNO9Pc5slrBKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ay55fBXp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JAaXWh017365;
	Wed, 19 Feb 2025 12:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DzW4Ihd/ixMoF3qpQLRVvu
	T5+Dho1ejPQkS/vCVoeSg=; b=ay55fBXprn5Key09e/eWR50pQ8pzj/GpsWmsLR
	NTpFbvQqyBky39MLpqi4uiDmKHBdOqypaA7bCWAhqwn7sLJwrETedIynZcmz8cPT
	9RPxT0NvYZXn5hSUOuywGd4gk1A0naI+t2mgWvjm+12ZpPn2D7jwDQdMdaP/wvVn
	lVZfcQRVf7XSluZ8ZXh6k36CA05QXf8xwVZOgPkhwrKRzF4EuQXTpBOnEDf7iTSK
	I5XiiidNtqW46KNnXUbIoLbtNQhHA7421LuVTmSM3enxmqh3sAQVH8qfp+z+/fp1
	fPMiPaTg1CVWcdrEgYuCnukJSlZoYfH4j1bjJKyrHe/YrUlg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3ahqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 12:27:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51JCRUox000415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 12:27:30 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Feb 2025 04:27:28 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <trenn@suse.com>, <shuah@kernel.org>, <jwyatt@redhat.com>,
        <jkacur@redhat.com>, <peng.fan@nxp.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Wed, 19 Feb 2025 20:27:15 +0800
Message-ID: <20250219122715.3892223-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0bf2-zZ5ff0WT2AvpSJS8XaqkA4IlwDd
X-Proofpoint-GUID: 0bf2-zZ5ff0WT2AvpSJS8XaqkA4IlwDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_05,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190101

If malloc returns NULL due to low memory, 'config' pointer can be NULL.
Add a check to prevent NULL dereference.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 tools/power/cpupower/bench/parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 080678d9d74e..bd67c758b33a 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -121,6 +121,10 @@ FILE *prepare_output(const char *dirname)
 struct config *prepare_default_config()
 {
 	struct config *config = malloc(sizeof(struct config));
+	if (!config) {
+		perror("malloc");
+		return NULL;
+	}
 
 	dprintf("loading defaults\n");
 
-- 
2.25.1


