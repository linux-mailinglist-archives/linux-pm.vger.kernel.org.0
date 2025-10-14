Return-Path: <linux-pm+bounces-36072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E0BDA0A2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F93E502A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1A22FDC43;
	Tue, 14 Oct 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D45Sm+tO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A012BAF4;
	Tue, 14 Oct 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452564; cv=none; b=tZkLLejaCcisq3YEyMF7tiDA1qBUqeADK2iythpZLBmERfA9XfB4is9YQ9I3orSbhNKZFsReWSZE04qg7bLdWfvYE8stmXHYs3CxLA/Z6NnUocBFhmci7xc9usNI0sNUlcE9fH/g8uBFINm790Ehf/nXnMW8mWeLT2FJwpYeI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452564; c=relaxed/simple;
	bh=QyINDOhJY1/sxrCkNA48DYucmTCgSWxOyHCSZPpqEzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=l7i63ANV3UuB7tmtqLkbwShc9CH5GDf6SlwYe87XOyiU4snzYU8FUAfXEzKTJYegGH/n7/nal4PlZI3Up2UnFY0ndnlXL573V7a7kO/JmjTsuozhrDtg3xJf0d+6uVHKrTnuX0Z1gu5Af704eIWw6vgnP4R99ahbsOthlXG8+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D45Sm+tO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87jRQ006569;
	Tue, 14 Oct 2025 14:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OKYRYmZ+c0jIy97FTRODndldeXus0D78NF4fF1Ushnw=; b=D45Sm+tO255c2dC2
	Zegj7Ao+6Gjap3FnOHIy9wwqVJYf2COj+qAD2RSAB3kd64hQFDpvwNFYIWTKwMrK
	MIFkPrtYjfzp8zIZAs0Jox/W33J3AGElnBmzPW7wZ4YxkoKViXvBWNAMEgG8kRsq
	Or3XMPPmrGmTUDDfG5laBEC9/7OkFxbEukw5vUu8vpvYGQjLRO4PBTmx5HaI6YBN
	5bvbNYrYKszFv71mvKwEh0Yichjk9dSu3FcxOcJ92Sgs6cUKYvRKxxj45Vm2lfKQ
	W0eWSQEZFIzGEdMYjNuA7XyGuT9zUqt7lTv344vG22hvQ5sLh1nFQYXOkd4p7805
	eHgw8A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj0ukf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:35:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EEZrVt004631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:35:53 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 07:35:48 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 14 Oct 2025 22:35:27 +0800
Subject: [PATCH v7 02/10] dt-bindings: clock: Add "#interconnect-cells"
 property in IPQ9574 example
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251014-qcom_ipq5424_nsscc-v7-2-081f4956be02@quicinc.com>
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Anusha Rao" <quic_anusha@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Manikanta Mylavarapu
	<quic_mmanikan@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad
 Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>,
        Luo Jie <quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760452536; l=1207;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=QyINDOhJY1/sxrCkNA48DYucmTCgSWxOyHCSZPpqEzE=;
 b=RSzUiZUIlBJp92S4artJRk6pMcRvPB6xsjjiOvLOAW/JIU5Hz3B1fceLOi5D8LzA6BwxA8gtm
 9zv3V3KVqPpDq0TkwWuc8IGpDDqlsV7ClHp60k0wAvfJkpCzptiQY1a
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX09ZkiJQiRvpN
 y6a/ZSJZhKLVV2hfstfzAmo4cJIZg2/LV9lmSCwhqfY5OQaY7U1OZfwDAQESAlI7pqtGoJMoK/N
 w5gVw1AdZkTR3CsPqwf2/Jxd30sfZ8+VJmfyCLZE4iNL2jTeuAISre1OYrqatlMoJVm47KbtFnE
 Hlf9oCrzHl54/4ZCacKp2aSFzEju1WLci9iheBh0Ik/xpSQlh7isgbcoF2Wt152CJUJss5QnLhW
 yrUiaHBuNgj8+tQM69pRx7d8NkVBPD+lnynaO0VT9D+jcIuEClJU0O7ONSaAiOQubQSGFVYTvjO
 Ur7C0cll87TSO7Hk6dxl6RuhhnLAUanDFjR+6/ddgMtrLKhi2RWsaWSLtoQTlirJGIiIQUi9rK3
 eXG4H9OsgXQrpPsO2LmTAqVKlwGAOg==
X-Proofpoint-ORIG-GUID: G8CI4qehwk53eMAcNi05xdEjd6D-RjmL
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ee5fca cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=TKdP9mIMqFxeD0qFjnIA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: G8CI4qehwk53eMAcNi05xdEjd6D-RjmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

The Networking Subsystem (NSS) clock controller acts as both a clock
provider and an interconnect provider. The #interconnect-cells property
is needed in the Device Tree Source (DTS) to ensure that client drivers
such as the PPE driver can correctly acquire ICC clocks from the NSS ICC
provider.

Add the #interconnect-cells property to the IPQ9574 Device Tree binding
example to complete it.

Fixes: 28300ecedce4 ("dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions")
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index 17252b6ea3be..5d35925e60d0 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -94,5 +94,6 @@ examples:
                     "bus";
       #clock-cells = <1>;
       #reset-cells = <1>;
+      #interconnect-cells = <1>;
     };
 ...

-- 
2.34.1


