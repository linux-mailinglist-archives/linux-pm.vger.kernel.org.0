Return-Path: <linux-pm+bounces-13138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1F963E88
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2ABB21577
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A918E024;
	Thu, 29 Aug 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Weap8l6B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D018C911;
	Thu, 29 Aug 2024 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920194; cv=none; b=mrvxsUqB6rPinaAkf950D2LBqZalWb3OnQG8+WIqVxUuqTNC7GZIvuEfM/LKsWjLuTW3pQCc5/hQ1LL2RPJ7nwusMpHYum2iEKu+HtYKXwCU2EwHrwVg7XPW0jF1BJK4BEPoaWVNci2NlvhKd23aXqMh02eGiEsIq5FTRskiNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920194; c=relaxed/simple;
	bh=8tHvSQBp1FwC1z2KmJDTKKH+TJwjakksX4yBR5JmhQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1qQF4WjzgEu/a+JIgkRFyailD6sEM2HqEZmDVDd8Ho53dHyEAwjdBjte8kqDZt6kBJwiqFPcjRUqBas0NdEIFTJvwEkye5jMBakJNHoPs2d1cGaZWKHT78S+/T524uhu9UjYYQRpDh+OhfcoemH/hkv30WO5OOyaaHlJR7lk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Weap8l6B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJMNkH005860;
	Thu, 29 Aug 2024 08:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LJipQoJC9QrwqiEZWYzUmfinyhUiajzTt/8ZoqFML/w=; b=Weap8l6BJzFoyr2k
	Qnf3oSTCWOp1sBQ2kYTW+D0qW6kKj7N7e/Iara274A+jd0b7VGtsBVLwbnLMoKC/
	tzBgPxupVDmpNcmpgqEyO6d6X95/qb11UZ6THro43arccd5MjyNorNIh/WUJNSWJ
	WpPsHb3/yQg7S3229ARuX+0OC3pqPBiKrYtjec5xhEYgnXB1dmSyLkBKjBfyADq4
	BvkVOkJsnFJA2basckAQv96NpH0VU9f3uHZoUvElPreE+gNBNZ8rOhsk06hWFjN1
	yrsWNWI/2y21TXFzczCzaztFDWJRc1EG8SieeG8O1CPfkuvPgFCW6Zvko8ZNiGcq
	Dy2ZYA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putvhkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T8TSWY024527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 01:29:21 -0700
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
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v5 4/8] dt-bindings: interconnect: Update master/slave id list
Date: Thu, 29 Aug 2024 13:58:26 +0530
Message-ID: <20240829082830.56959-5-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1_dYHAZUSB528sPaioSvAnQpIYD5o0O4
X-Proofpoint-GUID: 1_dYHAZUSB528sPaioSvAnQpIYD5o0O4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290062

Update the GCC master/slave list to include couple of
more interfaces needed by the Network Subsystem Clock
Controller (NSSCC)

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 include/dt-bindings/interconnect/qcom,ipq5332.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,ipq5332.h b/include/dt-bindings/interconnect/qcom,ipq5332.h
index 16475bb07a48..5c08dd3c4f47 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5332.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5332.h
@@ -28,6 +28,10 @@
 #define SLAVE_NSSNOC_TIMEOUT_REF	23
 #define MASTER_NSSNOC_XO_DCD		24
 #define SLAVE_NSSNOC_XO_DCD		25
+#define MASTER_SNOC_NSSNOC_1_CLK	26
+#define SLAVE_SNOC_NSSNOC_1_CLK		27
+#define MASTER_SNOC_NSSNOC_CLK		28
+#define SLAVE_SNOC_NSSNOC_CLK		29
 
 #define MASTER_NSSNOC_PPE		0
 #define SLAVE_NSSNOC_PPE		1
-- 
2.34.1


