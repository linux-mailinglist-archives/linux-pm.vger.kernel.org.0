Return-Path: <linux-pm+bounces-7514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9D8BC4ED
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 02:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E368282191
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 00:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60606138;
	Mon,  6 May 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cD3JvVJV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F979C0;
	Mon,  6 May 2024 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956143; cv=none; b=kQ/6NnLt0ifVq1EjoVUw6eAPREYs75/xqVq28wW18OdAG02HHKSpCEYReRTPDyW+yfaWSTG0+obJ1auxTrbVuXmqP2qk8ekBjEKS5gpLXCtOtYVEWJ43OWgKBK7DlJU/cwK3JavQHMffd/UEqS7WiMbQU3AqFIRbXLDNkSUrNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956143; c=relaxed/simple;
	bh=ajrFI+J3JcdhdA2HeoUPpfM5ZMPTY5FKfst1aUw5uSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EO/r3BO9/EqKR4TOL8otlArBGYvaiuls8pJenGHUV4U6CbDvGyCCoLak/fS6Z20pZ6h7X6XXZP2zORg+w3itMzim/adZ6+nyJUrcFUZ+36iUmap/YB07WreDz6mHb87DcI9jYr0sI+Xonh2XQmv+00iwH9eBDMhMKWe3o9FVsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cD3JvVJV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4460LfVg006531;
	Mon, 6 May 2024 00:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=ODT
	j5D3lgHO399eys7ryhJlFJrnDxjR/8CwWSw4KajA=; b=cD3JvVJVMRTwtQbXOW3
	pooyZAEYYNFazp02zOmMqc+te0ZZZdpsSKJOt59AOu3bj/ohOhDa7dwQhT/WvS5g
	QcFc4olrhFV4rt5hHsqA0jHr3TMnYtiGVQFB90/ybFeA3RYkJvtVxCab8ECw0xDx
	fgtcuC37qEPA9YmL1uLTQccZcssGm/9SUXos1FMqP3qYHYDai2uQqbwiqnJMnWWc
	vuGmVzqh2hjnph33B1CndAxGZ37qMIIRly8RD/LIbshscn0bp+lKAJhgWF0fmX3W
	hthhh34CqM/arPbI2cvJyXDIrPKSXQQ9MR5FM2DLm2nvlwpHm6r9p3/4bAVXLNh2
	3Mg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwddc2ada-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 00:42:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4460gGVt031998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 00:42:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 5 May 2024
 17:42:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 5 May 2024 17:42:16 -0700
Subject: [PATCH] cpuidle: ladder: fix ladder_do_selection() kernel-doc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240505-ladder_do_selection-kdoc-v1-1-fa0da92735dd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGcnOGYC/x3MWwrCMBCF4a2UeXYgrSmNbkWk5DLawZjKTJVC6
 d6NPn5wzr+BkjApnJsNhD6sPJeK9tBAnHy5E3Kqhs501vSmx+xTIhnTPCplikvd4yPNEU9Dao/
 O2eDsAPX+Errx+k9frtXBK2EQX+L0C2Yu7xWfXhcS2PcvjW/NLIkAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TBOsQ61D6-iMnJU4kuWm-UX8keM2eZad
X-Proofpoint-GUID: TBOsQ61D6-iMnJU4kuWm-UX8keM2eZad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_16,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=920
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060001

make C=1 reports:

warning: Function parameter or struct member 'dev' not described in 'ladder_do_selection'

Document 'dev' for this function.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/cpuidle/governors/ladder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 8e9058c4ea63..6617eb494a11 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -44,6 +44,7 @@ static DEFINE_PER_CPU(struct ladder_device, ladder_devices);
 
 /**
  * ladder_do_selection - prepares private data for a state change
+ * @dev: the CPU
  * @ldev: the ladder device
  * @old_idx: the current state index
  * @new_idx: the new target state index

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240505-ladder_do_selection-kdoc-97d13884b847


