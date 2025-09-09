Return-Path: <linux-pm+bounces-34266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25482B4FDE6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C364413AB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7C34A307;
	Tue,  9 Sep 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cP4lD+ps"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477323451B4;
	Tue,  9 Sep 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425278; cv=none; b=GWHrz6kUm9R0BZnblK1Xp0QkpTQehk4MJQUeBMwv2f8gTgCPXY7UL4BVxPyi3hAHe/8KKqJgs39an2Uli+cuFRQNbhMacSSbx+CM5zE9fKLmfVXQMKhwtfR5S1YRzTlWYFYeB9lHcD6GdZ4Z27EQrMfLmnKQjchPJ0uiIMT0ifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425278; c=relaxed/simple;
	bh=fnZWzDDTTDEeBhEL/SWi3sXl1ujwKnlewazpL/KxiIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Qk74LNLjPytjS/YqJT7MkhZfPIt5IcikvSGf817EYwG+4T7nWw7jyC37H+e8Nsk2dEGiUIezFgxUs9flcHotTzfMx1r1/Diz0kDES/CuXZ3Hy8UWzl3oBjOL0a7ma9hS3HOXlmapBDav0djzqbbeuG7MAVvM5Cc27zvs75LSDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cP4lD+ps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LTPp020099;
	Tue, 9 Sep 2025 13:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1yWgRltFJNThhSeNnr24vonmIf66fXtjWEcKmCdkMs=; b=cP4lD+psSvqPm4R5
	tgmkPZAbXIj7OLWMWc649p8XMKlrZUBlxMwINSWvqr6RNCqEkS5GQLoUmD3F8lRj
	PxfNk6FUQ4Ykl8pdOx+nix5kFVMDQOesOljhSLHd2XY9CtkGKnynp8ere5n69VEU
	ywKQLudqbc3HJklc+vfQrCdEBT69+WfHM7VOKhfbRK6hLzU29hSzH079NHXYXzhC
	9QrjVx0OP9Bj8ZAppaX5nX05eEyL7WkZOH648fO3K01qXiL43QszEiEJRVxLOq7l
	1Brax7Z0I8NQ1V0/KKInEOLdURcoj2bIqsMsrCQdiJD5PO7UK2q3NiGadmGZaOwq
	zI1fGQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc24d6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:41:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 589Df4Ho026246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 13:41:04 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 9 Sep 2025 06:40:25 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 9 Sep 2025 21:39:19 +0800
Subject: [PATCH v5 10/10] arm64: defconfig: Build NSS clock controller
 driver for IPQ5424
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-qcom_ipq5424_nsscc-v5-10-332c49a8512b@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757425161; l=836;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=fnZWzDDTTDEeBhEL/SWi3sXl1ujwKnlewazpL/KxiIY=;
 b=cD/EQdYWsTEAucYZxDqjG+AQARUJ9G6djy/nO+A7JkEhjsCBdExLGRqjl61tH2CXM6I7Ad2vw
 SvuvqiYulMRAqzAacg/Oo0+pYPugItEW9iyOLR141dmcZsDttsqqdbw
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c02e71 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=ikIlBLl75NxfxiEf-eQA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Omt8GkxLuZYPwpM4H6f2kNrZdm2D9nIG
X-Proofpoint-GUID: Omt8GkxLuZYPwpM4H6f2kNrZdm2D9nIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX3R8txnBK1+3d
 W5pHBTjS5UR3SQamgDubIQNNd+nTYp6HVDxa+nG0ys/RDZG4Zy+fnaJ9T1m5ERQTTn6ZJvW8I+f
 B539JGWCbJfWRAW9qNmEk+wmuW2cUeC339ce23cKWlO12muZBwY7+JPVMPHQb7bZAWeFBR9lOzY
 14IvBPguqBL0S+PAQWP0JRCJhFaxvXhFeJDAttOgTFby7np7odkIyX0p0/6X2c3B0yIe2DaftmZ
 p1krudfGSblEyCszW76xXh0zbATNpnJ8kA2nenk65E+FJ+FHZpx+9SlrvUJi3AQqKcUfv0yOyQ8
 KL+7My7TIZJirkff2Tq5osPLEW69uPp55epgbhH3XiNWIsgjJIA9Gayrdn31u9N1/5aGnRUBUGV
 MIOscT/u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

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


