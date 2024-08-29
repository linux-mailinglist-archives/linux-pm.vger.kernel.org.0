Return-Path: <linux-pm+bounces-13134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95734963E6D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EE2B20E05
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70518C90D;
	Thu, 29 Aug 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GqCjEHQ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C418C904;
	Thu, 29 Aug 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920164; cv=none; b=VgsefdGhDP4ch/i3lfQPo1t3gH77sBsCsZ391T4rin+w4b26ij2NZtjw1nIYGYocfFmFwfQzdxHHlAoqoXSFMzWndzSByf1nY5t3pq8tQGW/PtyoXxdaBSMuOTeJjiUYtEBYGALxu53yHj2mEteLud5Ni4sImmH84RF8AC0+K+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920164; c=relaxed/simple;
	bh=xQ06iWojzUwwxNKo12S/Hyo14/69uVxPUJqBGr2Nh+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f87dqxub2yBhQN6xXZ9ByawB7fN0qdZDuuxzfsVMYMJEf7cYEQDCUpzC9fFaxy1lBiPO6NeHUvjMmm3kJLQlpncITv1fRCboRnwSgUa+uYIYq9+Ryk2XaTlcL20aBT3LW4n1+5w5w2qwwbRh5japJiOOLTQALOHZdOEvBVaEj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GqCjEHQ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJLuRr023318;
	Thu, 29 Aug 2024 08:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MLY9dyYai67GxCMmNSxqsz5hxe/X3nsNqqQF9029pNo=; b=GqCjEHQ154OM2fGG
	Qqw5NWwfxopqRsKDauoyLMbk4S4Ky4IIgPVZVwXnE8ogsihKs8Mzlp+N1FuJqN8B
	43MdVWeBncfPni5WS9ovg6AlIfHyiVCAf87VvME+7THvYsC0qj/VJs3Io8swZjdx
	C7ZzdcPUOfQRYPl0WtfxyVw3rS5NzBa1a89fgkmQ9zo3qBy42Fu6x48mlNUDu4gE
	RbMLkNAM7FuK5JJLyMf1GMDnElrF94wEixRXX7SStU592/7hgGV7r+VpLyYIiblz
	wlQ+9S2SsnRGnTdXsRK6+mymLh/xFuZ+98mB66C6EQCbVDPmc/kIFhnT3sLgCQLn
	uOjZ0A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41a612jd1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T8T6mC007468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 01:28:59 -0700
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
Subject: [PATCH v5 1/8] dt-bindings: clock: ipq5332: add definition for GPLL0_OUT_AUX clock
Date: Thu, 29 Aug 2024 13:58:23 +0530
Message-ID: <20240829082830.56959-2-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: IEUGW5powLH7yPgBduX067O0XmJqwwSq
X-Proofpoint-ORIG-GUID: IEUGW5powLH7yPgBduX067O0XmJqwwSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290062

From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Add the definition for GPLL0_OUT_AUX clock. This acts as the parent
for the certain networking subsystem (NSS) clocks.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Update commit message to include why this clock is needed
---
 include/dt-bindings/clock/qcom,ipq5332-gcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
index 8a405a0a96d0..24486eb47ed8 100644
--- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
@@ -179,6 +179,7 @@
 #define GCC_PCIE3X1_0_PIPE_CLK_SRC			170
 #define GCC_PCIE3X1_1_PIPE_CLK_SRC			171
 #define GCC_USB0_PIPE_CLK_SRC				172
+#define GPLL0_OUT_AUX					173
 
 #define GCC_ADSS_BCR					0
 #define GCC_ADSS_PWM_CLK_ARES				1
-- 
2.34.1


