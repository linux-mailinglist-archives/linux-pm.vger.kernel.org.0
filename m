Return-Path: <linux-pm+bounces-35375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B7B9FEC7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07B91883B1E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99F2F6175;
	Thu, 25 Sep 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CS+lChZJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77E2868A9;
	Thu, 25 Sep 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809234; cv=none; b=AAOZXBVKwnF28Iqno6yzxX+azSV8JVcIkvqMC8ZvRF67yM4X7FmaC0jy4Ri1IDnyeKY0n7anNShedK+blw90/n4i2rlhHveuC6f9EEhIwhjPuEJoMnpLfSJcMj08gV5NgH0vXabKTG3ehbl36Zgq7mXYeXqH8Q1KjhEegw1FOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809234; c=relaxed/simple;
	bh=fnZWzDDTTDEeBhEL/SWi3sXl1ujwKnlewazpL/KxiIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hZmKMlPapjgZURoyDnh6DeBjXWba3AEebn3nd7lIcbPxuV14u6rDhRew+9CUvWzCfIZR9o39wt4mZYgRoWpEGeSf0hRW7LwUOOdUGobk3Ntc6zQAo350i0adbCUHuMurV9FKpfxXrtPfIDGBWg09mGlnjUeZebiUFYk944Jz9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CS+lChZJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PDRnxI027521;
	Thu, 25 Sep 2025 14:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1yWgRltFJNThhSeNnr24vonmIf66fXtjWEcKmCdkMs=; b=CS+lChZJ/3LigltF
	21d7Ze3D7cJC3e0M0F56KvN8TUXAH5xvkC5vnXgIM5+kpVYwvA8wEGgcrMLH3GQG
	IPPHXbcdA1XwirNZ+yHCXnFi+tMpOCw6oKV+Ev/eI50fDgJdvNMXHsL/zJLWoud+
	SZ8OmeLupJ4CxaGQ77Wo2qjOSAj5csNuAQuT52rd1L3lf2kyMW6cK4W2/evtd82f
	Jr7S0JJnivqMXrfFhlVaWe37YoVgOQNXYZq0Qp4QgciPahQUVYxk6PjcqBMt5B6Q
	0DyXp7UV9mbBncTuqe9HZ14GSjV50lSVVtRrHqjiWkU6QORUUgvO1l0iqjOXz59s
	Nl04qg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup1j3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58PE6qUt023450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:52 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 07:06:46 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 25 Sep 2025 22:05:44 +0800
Subject: [PATCH v6 10/10] arm64: defconfig: Build NSS clock controller
 driver for IPQ5424
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250925-qcom_ipq5424_nsscc-v6-10-7fad69b14358@quicinc.com>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
In-Reply-To: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758809144; l=836;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=fnZWzDDTTDEeBhEL/SWi3sXl1ujwKnlewazpL/KxiIY=;
 b=SN/4xdbONLu/QOmtSKdVibONLiFW545wC0zLvg7ctC9vx6L6oA+HtF9N6hYFXDgQIgO6E9DLa
 z4hhqQcJEY9Ahvp7c5T+AROd2X/HMOcsh9ElhuMdGGxM6ShgYqzyeoh
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d54c7e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=ikIlBLl75NxfxiEf-eQA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX2i28j8dI5x9+
 zzIBXBJ3RYgEpUkiHJEJS21SX3Rf90pdR5ziAFH0wnj0zgYDT0tumue27+GNRr2jW3JlwCLrhiu
 GQLzOUJxQRAKrDjjQNEIALhAkPT1yqdiA1SJDInF+5MZoWoMrfJIjqu/WVe2vajkP+aTqyOMrnj
 c8kvR8hsDRGqOorQfIlajoLQSWT8kfbmtYHFyXBU9pSfsurO/J16OHBehTBZz5usyZ0T28Ysw/H
 +UwdyutRwdfwe3mJz4OYoLjpTVSaAQTn0WJN8eVHtK00oGu3OBJvgYvoSbH9HQRfn+R4oZxhnic
 ML5kvtTbDgVc9+dk2JtCpRGBjdJg/sidcce5fDSDiJ8B+qTMk01Ow0afJ1jR+y9gYTqrP9OaHGl
 MYvEvKDr
X-Proofpoint-GUID: UyHL3T9c1N6aC39EVs_ZnhiIydtZbQM8
X-Proofpoint-ORIG-GUID: UyHL3T9c1N6aC39EVs_ZnhiIydtZbQM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

NSS clock controller is needed for supplying clocks and resets to the
networking blocks for the Ethernet functions on the IPQ5424 platforms.

All boards based on the IPQ5424 SoC will require this driver to be enabled.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index acb6807d3461..013325255119 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1379,6 +1379,7 @@ CONFIG_IPQ_GCC_5424=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
+CONFIG_IPQ_NSSCC_5424=m
 CONFIG_IPQ_NSSCC_9574=m
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_MMCC_8994=m

-- 
2.34.1


