Return-Path: <linux-pm+bounces-17876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7769D51BB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CF328261C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E941BDA8A;
	Thu, 21 Nov 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sa2waNf2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362710A3E;
	Thu, 21 Nov 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210088; cv=none; b=P80QbbvhhOef8k1VRdoXUmJGQ3UUZQYRXQNO8B0NmvFglUNTW6SkfKXUomuSuZkECypCDxbANRcpW/MVv7GJD26kmeXDmiwM2vKsQf9T2Yt7UlCJbm8zMmsvbBlHL58WlyJ5CoAzsG34zPkw26ZtDhLyTWE0qJ0TkbZ9Uew9XLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210088; c=relaxed/simple;
	bh=DqERNMBz329lndqZHu/SMyiXBkSfQFzFKltH7TcBJ0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r21+9bsAPBR1NfhSmIO3POdKylRUuxG+SeWm4wvlAtpWBDZXEUkxkw11np82PVJIzysUDpccPBv2LX82fp+vAatvi1ZUEOrprppURMdmYIE1KUsDlUFc30YVxXpu9/OkFTY5vk/bnDNF01+DV55X3n4IjLvmYtJ7AHD3Rzi8pkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sa2waNf2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALGVpwT015515;
	Thu, 21 Nov 2024 17:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4f6hklYn6OIq3k1OiJK/ZZ6uV3QxdmOOd0G/AHzMhCg=; b=Sa2waNf2BsYeTtFw
	Gf+k1laiH7okhHWpXllOH/qnC8KvyRyXy6SPDARy43GuOxXUbkSCytJf+o9bcWcn
	rSOlfEvAvdzhRAN0WUjd4lpbFDtmcQzFEtAPayS2Up5dInB7cgejfca8z9gOv/n6
	5HEo5TUyCK7SYvPg1qDnRsnsqIG7kLQCqXerTj6zQyQIsPo3VlBhxKKNqRd+ZNJ9
	iLckggbP9kAixA/4xgctIs6FqenmFGz9T7NZW/xadp3NbISV56FA4zkhf5x0SJoB
	uMC47+Q0bspg/I0ayuECaZB7ldOOU+xIh8VBWWGeZb+ZA5993HywpO+tdmGErxWC
	6WQ9WQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320y9hm72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:28:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALHS2D1008817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:28:02 GMT
Received: from a629a2d9ebad.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 09:27:58 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom: drop QPIC_CORE IDs
Date: Thu, 21 Nov 2024 17:27:36 +0000
Message-ID: <20241121172737.255-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241121172737.255-1-quic_rlaggysh@quicinc.com>
References: <20241121172737.255-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M9uO_lV810raKFQSm8ieTi1TbQRzvBex
X-Proofpoint-ORIG-GUID: M9uO_lV810raKFQSm8ieTi1TbQRzvBex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=901 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210132

QPIC resources are modeled as clks, therefore remove corresponding
defines from the binding as they're unused.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 include/dt-bindings/interconnect/qcom,sdx75.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/interconnect/qcom,sdx75.h b/include/dt-bindings/interconnect/qcom,sdx75.h
index e903f5f3dd8f..0746f1704ec0 100644
--- a/include/dt-bindings/interconnect/qcom,sdx75.h
+++ b/include/dt-bindings/interconnect/qcom,sdx75.h
@@ -6,10 +6,8 @@
 #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
 #define __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
 
-#define MASTER_QPIC_CORE		0
-#define MASTER_QUP_CORE_0		1
-#define SLAVE_QPIC_CORE			2
-#define SLAVE_QUP_CORE_0		3
+#define MASTER_QUP_CORE_0		0
+#define SLAVE_QUP_CORE_0		1
 
 #define MASTER_LLCC			0
 #define SLAVE_EBI1			1
-- 
2.39.2


