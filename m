Return-Path: <linux-pm+bounces-34263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C87B4FDD6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA875E5310
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA5350D48;
	Tue,  9 Sep 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mn3BZzLc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2434A309;
	Tue,  9 Sep 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425227; cv=none; b=qP/fwFwVQILmTwYmtzx7ZW0KSVLAQGrS8NxvM8pfL7ikKJDvGTsbPSBaTnGawhjUeykbBRyMYZqmFR2yr1ZbEz7XZqTmkLJbSSeJKQ94GckmaeG0NW1Ifjg5oN3T4Hp22sn44Nb2VfkxPwE0suaAZiQtAEudRROUMkcDQ2jMNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425227; c=relaxed/simple;
	bh=3iKwOo2CrK/eKNakDQZO7OeL5ujpqeuVAaG1t+5mbX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ztzq+/I34VcrIU5OCKLt2towldIXC5lsqVANH6pPF+GIz8wHiuLIN43P35gYY4yO/DDc8VeMuhjo+CG0qENS05qiYud8tZ/8+2+sD7b60stWGIMhgN74b9KoaY1/V5PddLmGcNanDrIo/gRVWxZae+qZ60LTl+u8kMANscQmFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mn3BZzLc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LQe9009065;
	Tue, 9 Sep 2025 13:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kyvU4wcWd3fvz/FIz5RRK9/DHmQiARXoQLs6yV0Drq4=; b=mn3BZzLc3R7a4NFV
	QD/Ysya3lcA75vOPmKoxpdK+l77EdUu1V5lE/Jko2Vw0r74mlq8kcrvi2Xc5d3e5
	SpTvN8F+9Tiyjod+jPE/l7jpp7c2iqtCI1iyslvn4exeynqisuVxqk8rvQfAO9Rk
	HHIZeG3XzcG5+dsov2z1vwmoPYjh4ekYQO4ImyXm2q3tt6//HGFnx3vAcvFuTD7Q
	flMMVe/91M4joOaM0sefobppvwiXHorT9edSmCayOX+Dzkf89iNdGIRfz7qgTXOS
	nhzkOX28eXpa6mi7RZ+gMspCkYRfrMRHmp71UYo/5S70GF+BpuykwOSCarnGWJHp
	kePBhQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdw5ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:39:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 589DdeHb020898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 13:39:40 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 9 Sep 2025 06:39:34 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 9 Sep 2025 21:39:11 +0800
Subject: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
In-Reply-To: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757425161; l=1664;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=3iKwOo2CrK/eKNakDQZO7OeL5ujpqeuVAaG1t+5mbX8=;
 b=MZjBVf1rAhYMYfZQWlSQJHWRy9JD3k4+4u8Z2jlxXQSxoKN2xZkPukk/PxJ2MXWlvQkZAV6QD
 RDDEtdP9AQHDnMig6fw/fCYJyp+VeDIsRM3LzKa+bbUwn+vUzv9icd7
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: unXK5unQp9c9HotljCgXpG1vFI2YG2df
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX7EIJvSwkhpQ+
 APzL9fuJJ9yMl8lGJKjXbJ/TPxizblAvlR2XQvVYplOnMH3O7frUBY7SgUaNZezZcXWdmfNalI1
 lNn5wjGSpr27hdyfJWGMdXsQJNPIZqcQzmAMF5S6cVOpF4Ro5eAPaWO8suayqODGSSbRWOXVVkR
 U54vR3SI18VvmOdY8kJX7WrMwweAnf8ff7cki3wog8zO4aKZ0fm9GoYVjaomvArthZ+wl0/O0Se
 fJwh3KVwdR2p4OPY134hSQlrxx3QMbtg1NFVt0W4q+o+kVMYsYWyes+h16i+w1SOzHZ2e5vsznq
 peV//XGbq35j/gSC+GF8trwWQx2fOzE1cFcCqVEpsicLcxXNReCwnuZVtarsCm/XDJ/+fTDsI05
 z8TTnShm
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68c02e1c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=TKdP9mIMqFxeD0qFjnIA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: unXK5unQp9c9HotljCgXpG1vFI2YG2df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

The Networking Subsystem (NSS) clock controller acts as both a clock
provider and an interconnect provider. The #interconnect-cells property
is mandatory in the Device Tree Source (DTS) to ensure that client
drivers, such as the PPE driver, can correctly acquire ICC clocks from
the NSS ICC provider.

Although this property is already present in the NSS CC node of the DTS
for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
omitted from the list of required properties in the bindings documentation.
Adding this as a required property is not expected to break the ABI for
currently supported SoC.

Marking #interconnect-cells as required to comply with Device Tree (DT)
binding requirements for interconnect providers.

Fixes: 28300ecedce4 ("dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions")
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index 17252b6ea3be..fc604279114f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -57,6 +57,7 @@ required:
   - compatible
   - clocks
   - clock-names
+  - '#interconnect-cells'
 
 allOf:
   - $ref: qcom,gcc.yaml#
@@ -94,5 +95,6 @@ examples:
                     "bus";
       #clock-cells = <1>;
       #reset-cells = <1>;
+      #interconnect-cells = <1>;
     };
 ...

-- 
2.34.1


