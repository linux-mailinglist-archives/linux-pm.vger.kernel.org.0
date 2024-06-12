Return-Path: <linux-pm+bounces-9038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B9905DA6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C54FB214E8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB884D0D;
	Wed, 12 Jun 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mmgj2EO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375F21360;
	Wed, 12 Jun 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227821; cv=none; b=GTSOlty0xPi88qFGforQq0Dshez58FwOhBvxOCVBjrirJ+XyNV+MxxTO2bLxG96eg2qpJuQ94++e8SQxIzEa28R14ulDVcbOsXAwBWmMNkrbFAkHp7CF2pH7yyFinRZ2O2OIRRj3R7uen0KYbHdUAd8cUZDbkGDaOFSjekmquvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227821; c=relaxed/simple;
	bh=7oi+Dxn3vPmuBX3GF+LezGlD7Ns+idrg1dOvb8SD5k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RcSBZRI6+/Yd+hKAPRZCjV/lw3mwmAeOrL/2u2l8GtN7SNdQJbbn5gxco4rh43tGksYoaUF/08pA3TLUEwZbuJYe5gTfgNSaB8oC8vu4Da5x9dJ5Z2yJ5bwC7CgtOuscKB+jtY5guT6TnLQ+gAAzhr4opEeIJLBORj7cLFfByTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mmgj2EO0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKnLup021461;
	Wed, 12 Jun 2024 21:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IvQCOazXZ/AL5r1TiWeTRP
	39ZBZboAl6gzkFzp6H2II=; b=Mmgj2EO0UkYiXJvOEQq7NMKrtuJ75PgJtZWnEj
	Se/1qv951rqc3LzFLQSvbc+qWL3SHMVd4XF2cbHiNVBYDWXrS3+hKhDC3RUOi+vu
	dWl9BC4O6ZbmGd0rcXz1iai2ePtyjglBE5prI9UcMlz9dVR7peEOR4nh2pvak8ZF
	1tO9g2sy1JhuXkj20/rU8yCH3PU3dEGshfoKWMcyoxcFK2yuJ0jw4Q0G8283kzf8
	ZfmT+ZSR1YePN0wJ3e5zylXMu5szeNRQFkbrNAGb2FQH6QgB88Odgu89bW2N2dzZ
	4G4DO2Tx6IG+4yDsNExVzPz5RFSt1rZEgbQ+xQSdnUfK26KA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype9153u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 21:30:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CLUFbt015143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 21:30:15 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 14:30:14 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 14:30:13 -0700
Subject: [PATCH] interconnect: qcom: add missing MODULE_DESCRIPTION()
 macros
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-drivers-interconnect-qcom-v1-1-da0462d6301b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGUTamYC/x3MwQrCMAwA0F8ZORvYik7wV8RDl2YuYFNNtjEY+
 3erx3d5OzibsMOt2cF4FZeiFd2pAZqiPhklVUNow7ntu4A5YTJZ2RxFZzYqqkwzfqhkpJGHSNf
 +koigFm/jUbZ/f39UD9EZB4tK0y99iS4b5uj1geP4AjIDTzqNAAAA
To: Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HAhboqsiavfmPmU6s1l8Y8y0xcHiRM5R
X-Proofpoint-ORIG-GUID: HAhboqsiavfmPmU6s1l8Y8y0xcHiRM5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_10,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=982 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120152

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/qcom/interconnect_qcom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/qcom/icc-rpmh.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/interconnect/qcom/icc-common.c | 1 +
 drivers/interconnect/qcom/icc-rpmh.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
index 9b9ee113f172..9b8a9c69e0cb 100644
--- a/drivers/interconnect/qcom/icc-common.c
+++ b/drivers/interconnect/qcom/icc-common.c
@@ -35,4 +35,5 @@ struct icc_node_data *qcom_icc_xlate_extended(const struct of_phandle_args *spec
 }
 EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
 
+MODULE_DESCRIPTION("Qualcomm interconnect common functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index c1aa265c1f4e..4c5aa342e013 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -262,4 +262,5 @@ void qcom_icc_rpmh_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpmh_remove);
 
+MODULE_DESCRIPTION("Qualcomm RPMh interconnect driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-drivers-interconnect-qcom-cfebac765dcc


