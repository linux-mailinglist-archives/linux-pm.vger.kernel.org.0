Return-Path: <linux-pm+bounces-7543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE58BD2A2
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 18:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CB4283B6A
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BB15667C;
	Mon,  6 May 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mlkkBGn8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524E156249;
	Mon,  6 May 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012626; cv=none; b=JP5n4v6Blkt5lreBxX/691LgKnW5mYgQFiJI+uiASVcKU0bCCyh/fWgf1xvzAaNShwrQv237T7mxQ9qcy2dUkijguBM0hW/BuXWEF2cEv93FDYy7h4N1sP0qBl2ee7xkiNso8MzIFRmg5Yupd3w12ddZEuFFImyyoUZKOpmhqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012626; c=relaxed/simple;
	bh=+/79PzSKmQqts0bin6aPKBOwCMJ4laAlgqQpKYvQtKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=d+AMrFNYQgK0+YR9kany/ntN0dQ1Nr/SE6oJnVH7JnANlUd1lJU2Be06wpLxNZ68KqDQP2heh8AF14rFKwg5CCsnufnLseaXO4QtN6+tT2XhQ2myyZr73xzUKogvsXHQ3Ov9Sw1FXu/KjrzXYF8tEe8doX2dBvzVU0HB3YpA5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mlkkBGn8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446FiroX019014;
	Mon, 6 May 2024 16:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=1AY
	FRPIEhsBskY65wXUubXZEOcFHW0IsSaJRIk/GcV4=; b=mlkkBGn839G76t0WXpA
	298yIqugsLdNr0yoSbvXl4h3OnXObHbzSLCQ1Ly3aXh+OFwg3ihweEXYstEDGOi2
	Bv5tDEVhAHnCv5DDcubJiFRfNnGFdracVBPC9BRW/1FFmgLPk2KxSb7JsL3+g3UD
	fs9OZmNjA5dc6vPdzyAOYyexac7BZOGoqhXJbG5kBPm2Qx/2BXAf/0l3rX1qyr8G
	Wb+nslSAGB1KhCzrEij8VXb6HaLwGoXrqP8JqCtUj/jKbgP0yOLTYBsVoXGXMjQ3
	9Yvn+t/r7e4Ppycb6cuMRVSGPS7femMsHIS/oRnanzfAutV6ajYCCJB/hjRhho4g
	1jA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxw800swd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 16:23:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446GNZ28029547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 16:23:35 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 09:23:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 6 May 2024 09:23:35 -0700
Subject: [PATCH] thermal/drivers/max77620: Fix max77620_thermal_read_temp()
 kernel-doc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240506-max77620_thermal_read_temp-kdoc-v1-1-679f0486d52c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAYEOWYC/x3NQQrDIBBA0auEWVdQawz0KqWESZxWaTRhNEUIu
 Xttl3/z/gGZOFCGW3cA0yfksKYW6tLB7DG9SATXGrTURvbSioh1GKyWY/HEEZeRCd1YKG7i7dZ
 ZWKWURGOs66/QlI3pGer/cH+0njCTmBjT7H/uEtJeG5oLMZznF5TSwWaQAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3-54EL4_VJNFMq1lQGgXChJ85p40hkjz
X-Proofpoint-ORIG-GUID: 3-54EL4_VJNFMq1lQGgXChJ85p40hkjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060114

Fix the following kernel-doc issues reported by make W=1:

drivers/thermal/max77620_thermal.c:48: warning: Function parameter or struct member 'tz' not described in 'max77620_thermal_read_temp'
drivers/thermal/max77620_thermal.c:48: warning: Excess function parameter 'data' description in 'max77620_thermal_read_temp'

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/thermal/max77620_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 85a12e98d6dc..f0cfe1a8fa94 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -32,7 +32,7 @@ struct max77620_therm_info {
 
 /**
  * max77620_thermal_read_temp: Read PMIC die temperatue.
- * @data:	Device specific data.
+ * @tz:		Device specific data.
  * @temp:	Temperature in millidegrees Celsius
  *
  * The actual temperature of PMIC die is not available from PMIC.

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240506-max77620_thermal_read_temp-kdoc-61110a446d53


