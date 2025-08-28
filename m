Return-Path: <linux-pm+bounces-33239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08415B39A3D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174655E17CD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAC30F817;
	Thu, 28 Aug 2025 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="is6lkI56"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485E30AD0B;
	Thu, 28 Aug 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377263; cv=none; b=qsbvsEcSmPwo8FLocwk3tRDczu4/NmWSbfcaFwq9vH5QH4dbOxNJGuqTnnfqSaAXcgypfT7D0WQVBds0ojJIbC5VnPM/OBVXTpJBlB0rFdXfa4TPn/Hbm1isfx/h0qTQ1FbYgQpKsVXlAj8ksPqw6JLy4bnxVizo3DkdoZnuHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377263; c=relaxed/simple;
	bh=d15AkNgVbqYvSgm5b1QFYSe5jO49ues4SamiOXo+ahs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hViL4qr4leO1M0LC2wYZJbmmfhK+EKdRKP/nsrZWwxcXujXPcT/OBkRSPBNaUqX+lcTtP3xobHqZE0J8rvYa9aJXueGccmyfnF8q9IdjJGhsMPLSJhf4AAHyGGySQnEmkaXqzqFbv1PrLhuwzy7QmsWINYAx9137RrM1FG0ty5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=is6lkI56; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SADt7J006992;
	Thu, 28 Aug 2025 10:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JARU18ahRv+Dr0p5vM7Tw7FXxZjjRG75PXbMPgA6zHI=; b=is6lkI563+vUvwch
	QSqgmm9sIifNbagENfFdXi1CsC8uAEnLu3IqkwBpPKXJCCkzoyWMLUbjZevleT7Y
	vAV3tmh2+LAAjGRNA8TRH0fVV0Ye9gJdnutIguFj/9wXaTbfZ0ENM3jMCj0qowRH
	9prHN94SF0xeuW1Iu7o/58x3Bv9AoUwuyLaLwerR2l0HPznxSUgSxkgKt+x/kSXc
	RXbHvPrW8N51AbqIF66tEhy8d/2pwPK/jmF1TVd42hmauyowZgpJxO6CQRSlpvPN
	2rk/CX4l/GDNBGHsp9Pg4LyIUjNFws5A81ovwFG+e+rJl0+5UGdF1NBRE2FxNt+3
	KbBteA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67g1u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:34:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SAYA1n029798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:34:10 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 03:34:03 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 28 Aug 2025 18:32:19 +0800
Subject: [PATCH v4 06/10] dt-bindings: clock: Add required
 "interconnect-cells" property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250828-qcom_ipq5424_nsscc-v4-6-cb913b205bcb@quicinc.com>
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756377205; l=1029;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=d15AkNgVbqYvSgm5b1QFYSe5jO49ues4SamiOXo+ahs=;
 b=5fmj/kVXXKZ62TrlIBHSqssClcZzgl2oKmUBd2bR1NANH+25fcw8JFg6uCNVdkk4EhILvstRa
 kcP2z9oTA0uAoJCFT1hOfoE47rahTBoTNQMsnvTnOdSpTiH5tK3dU34
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX3RMjnShydBjo
 OraVgUuwD1YCp0Q5NRUtd5rnECX76WUe3/oknghZsRQReIRMSXoar+lUjYFdyuWKVlmxvb+/xi9
 VH5fc+wwkBwBUxqA6jcfxc+p1wzyxCECCPCUifontq0+ogg15lWA0Qi2MqHACiqRaZyDJ8l2flB
 5ibBaueMEgBqfqxbFE02m3YQhb7oSPLK+8SWUEw8ytNZ9Ih4n0BxpPjBmdB4UQcC0RhPQAlsvXW
 x+j+9KEMn2irOy8m/vAw30ZfSPU4Ip5fzojclEYagcUyRfZuwH+pmxeQxDGNdJsg0P50n/F/NFE
 rgsLSHqEVpEudOzWqtPiDTiufQ9gyLce7yyNQhdvhJsB/6+RsEMbmsAju0pUOMkpj6fjzbvdM12
 tEbFe4qa
X-Proofpoint-GUID: PgDVp1gE6JjtlU0AZ4nsJyqtTP0eIssW
X-Proofpoint-ORIG-GUID: PgDVp1gE6JjtlU0AZ4nsJyqtTP0eIssW
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b030a2 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=BW4L9BUWTq5nOPCB-8sA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

ICC clocks are always provided by the NSS clock controller of IPQ9574,
so add interconnect-cells as required DT property.

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


