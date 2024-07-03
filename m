Return-Path: <linux-pm+bounces-10511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31CF925675
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9070428C095
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8DF140E38;
	Wed,  3 Jul 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EmbTeWR6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950413D504;
	Wed,  3 Jul 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998338; cv=none; b=IdBPMveF7Us9V7sE6tcw4k9kNykcVmszHVYtpZY7jVzVMF+I8TmLOKfUJbJu0sfdrF4aC6klMinvQ2OrtlQ09PhGhvjmGpPoKScyGZLmllfSzQw16NS7GtEZAlh2ct22riy55MFfxar9ZFD/FGoz+D2A7Wt58heQJH1syGYUjwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998338; c=relaxed/simple;
	bh=B95GYPyP1399t9MHo4Ehwzkj58jx8WUn24NuNqCIbiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaSAJE7cS2jiY8q4T7uTMBALKLuGMIpQGSVsFWXg6BvGs8l8dP+ds1AqdBl1XrqSUkTs+HHz6Ef8eFdIVZcs/a5PyRG+MHni20mO2SPt8pE/lFxHWrurBNv02Yt1eUrP+MMP7ehetP4XcsnY/4Z/TjzG8pWyc1GCaNB/QtOC9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EmbTeWR6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4632UDoH028827;
	Wed, 3 Jul 2024 09:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vWmEnccTW/J9ONdJ3AuMS/xIVyAbqPegKw0w+/64QE0=; b=EmbTeWR6nwO1wixi
	qb/IFd5qglKPrrOdkRgNyjiY8+9f5DfWSft/HH94NlqzomtUAK1irwgGe41ugEZ7
	2jrTm2XxX9gAG7CxoGiM3SHMpa5SYLBbU232C0p1sczLhJSnAamXP7SoRhy5chix
	GIBW8rAf3/hCp9SnpdvGthzHPlbJwg4mYMyqlxsxChSRNWrriTWkKtIKGs50s9zW
	/9/Oof2wlfs7qmY7znsh07nf9fNlNZNL+s0s2ZISOhfHxGD48X40u8M6IOG9adQt
	xAygQdCm2dTqRPcsFD6wGTHJwbtbohwIR2sanpLa1xTESlBncPT8xU/5AmLtiAPx
	a3VvWA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404kctjkr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:18:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639IeCw026877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:18:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:18:32 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_rohiagar@quicinc.com>, <abel.vesa@linaro.org>,
        <otto.pflueger@abscue.de>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <quic_ipkumar@quicinc.com>,
        <luca@z3ntu.xyz>, <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v4 09/10] dt-bindings: opp: v2-qcom-level: Update minItems for oloop-vadj & cloop-vadj
Date: Wed, 3 Jul 2024 14:46:50 +0530
Message-ID: <20240703091651.2820236-10-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703091651.2820236-1-quic_varada@quicinc.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: Y_hRHQlQ0taji3iJaRBGba5XLY7AvdQb
X-Proofpoint-ORIG-GUID: Y_hRHQlQ0taji3iJaRBGba5XLY7AvdQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030068

Since IPQ9574 has only one CPR thread it will specify
only one voltage adjustment value. Hence update min items
accordingly for oloop-vadj and cloop-vadj. Without
constraining min items, dt_binding_check gives errors

	opp-table-cpr4:opp-0:qcom,opp-cloop-vadj:0: [0] is too short
	opp-table-cpr4:opp-0:qcom,opp-oloop-vadj:0: [0] is too short

	Failed validating 'minItems' in schema . . .
		{'maxItems': 2, 'minItems': 2}

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: Fix dt_bindings_check error
---
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index b203ea01b17a..1c1a9e12d57a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -39,6 +39,7 @@ patternProperties:
           An array of per-thread values representing the closed-loop
           voltage adjustment value associated with this OPP node.
         $ref: /schemas/types.yaml#/definitions/int32-array
+        minItems: 1
         maxItems: 2
 
       qcom,opp-oloop-vadj:
@@ -46,6 +47,7 @@ patternProperties:
           An array of per-thread values representing the open-loop
           voltage adjustment value associated with this OPP node.
         $ref: /schemas/types.yaml#/definitions/int32-array
+        minItems: 1
         maxItems: 2
 
     required:
-- 
2.34.1


