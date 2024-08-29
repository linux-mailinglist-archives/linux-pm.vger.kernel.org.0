Return-Path: <linux-pm+bounces-13141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40178963E9A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2414B21323
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702918E77E;
	Thu, 29 Aug 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lswyE7cv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19C18C033;
	Thu, 29 Aug 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920213; cv=none; b=L8yfDxZ1css3Ib1vyhAdfTR9U7E64wiNS3IDBFhzuObvZbaZirxFWVTI15tordTIbhZsqZ+nugU3KXP/usszVi//4/SZsZwpv+Uu5Cn88cNesEVycnzPbR0qAWeE6BFcEpxBHRA3F/qy8TWx/YHnCLcn7C2qb5bHLX5+nKAnOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920213; c=relaxed/simple;
	bh=cZc2j8iERsxik3XaaeLG3n3brBXvp6UxbYVHjy5fpLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsAy6kjddiku+mrHTMwdOC5iEHwj0sg77PiDcUs+zZ6xpRLD8xs4zrwbjN+hFI3VBEqnifYfJEFdZxnVvhuktPPJuAG1DPBUj1/vjw5FfYgcXxEyH6XIMoIvnmDk0vi3znoXIz7LgQWI5jxGfdYEwgN7x8NJSqtFI/FFyv3JJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lswyE7cv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJLuLE002697;
	Thu, 29 Aug 2024 08:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGKNNRsxgan7LrE3JmFUZvV3G9dxagz9H0bEmvaJBI8=; b=lswyE7cv33RIur/g
	HTvelpla7SXyytWPS7q1+ZrXk3SYTzXbBj5/36kvMoBN8puSv+zXL2lTBjUwujAy
	QUrO7FkyNzK6jcQzidIOwLzz/2TizhKAZT6z5JCoCro3LSQDl7kKzAqobfo6tmny
	uglMLzhHWKS5X6f7yd/SxpRCWQELBoym5p/QNpq+ovphozZDvT0wZvcIp0CWgMcd
	aHzv4V9PYBawU8vCX3GuzWPbAlywG7uP+vFZ3ZNylnvOjXOaUjv3mijftxXRsLwK
	8MHU6OxMUYTJda3V5VxgMW5HCfFt1Lj6LyjUHe+sBhbKLt1vVtThNBpeO/zDvKq7
	NnS3Jw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putvhmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T8TuKM024801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:56 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 01:29:49 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <djakov@kernel.org>, <richardcochran@gmail.com>,
        <geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <nfraprado@collabora.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>
Subject: [PATCH v5 8/8] arm64: defconfig: build NSS Clock Controller driver for Qualcomm IPQ5332
Date: Thu, 29 Aug 2024 13:58:30 +0530
Message-ID: <20240829082830.56959-9-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829082830.56959-1-quic_varada@quicinc.com>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xLKOIB4wP5qphndM1hc1TQXp-B388VX1
X-Proofpoint-GUID: xLKOIB4wP5qphndM1hc1TQXp-B388VX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290062

From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

NSSCC driver is needed to enable the ethernet interfaces and not
necessary for the bootup of the SoC, hence build it as a module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 81ca46e3ab4b..2962bc079ddb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1307,6 +1307,7 @@ CONFIG_IPQ_GCC_5332=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
+CONFIG_IPQ_NSSCC_5332=m
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_MMCC_8994=m
 CONFIG_MSM_GCC_8994=y
-- 
2.34.1


