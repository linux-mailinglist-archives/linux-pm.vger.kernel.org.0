Return-Path: <linux-pm+bounces-9885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276FC914641
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 11:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5799E1C22351
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA88132127;
	Mon, 24 Jun 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eZ40FcPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12625132116;
	Mon, 24 Jun 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220979; cv=none; b=iHLeprVusOY9xPkIOT2lWxKGJueZW6IS/jRFfXXW+YKvC+o7MgiaJz9yTWxBey0iAhMfXGPIS5/LjMPxJvFwE+TxdxpIO/KAzF1S4qnEHervAJHWaWy5QtbIPmzOk7C/hWvu4jX8zLTj2u0eLpuhE9PQsUu3KLlwHye+MJqmfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220979; c=relaxed/simple;
	bh=Kwk2HoLpGZMoarrsATqhXcQQgJrueC2QFnszRTLSZDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMnBE4i0WhuV1nyIdDMEobHBrG1ZZ9F9/ct71zeN0RvBMpuphx9cZhUaPT4qTsxzGjnAQpJWHsCs1iS87o2WmM4ZUSdAAyhLGZOuPMNPVKf8hELgiyElW99Ik9WPxSOy8VTxLntRcTo9F56jVfces/7JpV2Yu7ClHbawJ8SFrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eZ40FcPB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8YfpQ017133;
	Mon, 24 Jun 2024 09:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sy+fY/plzWOeT/uqLZqkezgno9zlZak1OCZopmOmtYE=; b=eZ40FcPB9eTmSa1Y
	kl4K6FlfzVFzhZm+UNfQWmtZxYve9uzVNZiu59Pns0jwuBrNC33eP0klwcjdRxAN
	+lMRq7O1EBWDJ2AbM+xz3IrLJrUXnRZyJlsKl6myYIV3UFsvvA1WHczWGEKcC2oZ
	E1w87C/ncx26Sc7LryYkhBI3pbXayMM6i9+TXWpeD/6abVbrpQP1iawQ3HgNyrzx
	su3XL/MSuA5b+5IYNj709Rxw688+8D8Aua/8mRHCUa3B7Y9BkLDxVtoAwO9fBjyB
	2VngsaA/lkel57o5lCNsD/Lj2Y9nqiQcP903TUT8r+newVI1s08qwvEPuddEWrOg
	/Z9OcA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw9ayrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:22:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O9MrpY030318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:22:53 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 02:22:48 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <abel.vesa@linaro.org>
Subject: [PATCH V3 1/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Remove opp-table from the required list
Date: Mon, 24 Jun 2024 14:52:11 +0530
Message-ID: <20240624092214.146935-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624092214.146935-1-quic_sibis@quicinc.com>
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Pb5nKGX412W-_VD_CZ1AfMxXx-evcoJ
X-Proofpoint-GUID: 1Pb5nKGX412W-_VD_CZ1AfMxXx-evcoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240075

Remove opp-table from the required list as the bindings shouldn't care
where the OPP tables (referenced by the operating-points-v2 property)
comes from.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
* Drop OPP table from the required property list. [Konrad/Krzysztof]

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 05067e197abe..9c248e1eabe2 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -72,7 +72,6 @@ required:
   - interconnects
   - interrupts
   - operating-points-v2
-  - opp-table
   - reg
 
 additionalProperties: false
-- 
2.34.1


