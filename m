Return-Path: <linux-pm+bounces-19416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C98D9F637F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5885E7A16E1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981A3199EB2;
	Wed, 18 Dec 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YpDM1xjm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FE50276;
	Wed, 18 Dec 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518425; cv=none; b=F8ICRbtkhA/SB8/NTp977qC0YFNWchaWvB8FiN2yBh9XHMUamI/QmIxUhAq1z9Ir2rBee2rf12ZySzTo3Cu1OUGtmRsbRgV4Ja/wn3LKqfOJkb5XFJHaB/mp5TLHcaWBhcqWrFyce7kuPrJ1JU/jzPhOqKOCKBfSlUDz5FVl0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518425; c=relaxed/simple;
	bh=hhmnUR5c9uFdKHpqhLtr/hAqBcX2Ry/ge3JRYi47F8U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kmzN/ah4h4NqdZUUYygsv33at+xRAV5aia8oL4EurOjZb2sYTw+aYCeEvDSAFIVxdc9P+R2VbCF2QfmsYfYlUsIwzYexkKKjJSAg9DJxe4LFImMQQwI/ZISzvSEMaOrg+0O8wsfMGlJAu4zIoJT6YQ/HwGIhcbOIRbaEAklk3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YpDM1xjm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7VFpF025340;
	Wed, 18 Dec 2024 10:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PC0IYBvk/QNwFep9r1Mzjt
	nBXlF1JuCFcX6IQdLniEo=; b=YpDM1xjmdgA4Hn/F9bNh6SHT0rf3KNgfFJrnEr
	CVlzHJowLr+QcwChD9taSapcDIUuw8UwoTBpreQsg2skiNCmxqs+fFXCRQoMR/vS
	XAFOn+wu6cqtihoS5Bi45y0i3Epkh86DpqGh7TciWx1QCWmpI0hMHs/7qCGUUwVf
	/DIB9rgqUWSf/ccbIzTxYumysRbpQpKaXQJHXv6UxkzA7SBtchRg2JOOXVCd7r8A
	iyxs9uSd5+ldBiVVYVvZUbxM7Tw7PZaDo/8OH8aTJATr/ZbJqPFA+wWsMDV5J9ib
	jHW9QK3Q8usMRan75yThNysh+qbXfrl3X9nsCmJTc+jVEsWQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kt2w8f8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:40:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIAeI6l021197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:40:18 GMT
Received: from lijuang2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 02:40:12 -0800
From: Lijuan Gao <quic_lijuang@quicinc.com>
Subject: [PATCH 0/2] arm64: qcom: Add BWMON support for QCS615
Date: Wed, 18 Dec 2024 18:39:37 +0800
Message-ID: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmmYmcC/x3MSw7CIBAA0Ks0s5akUFrUqxhDEKZ1FgLO+Eua3
 l3S5du8FQSZUODcrcD4IaGSG/Shg3gPeUFFqRlMb6w22qmQkr99HyV7edda+OXnwv4ZZdKjCsf
 ogu0HO7gTtKIyzvTb+8t12/4If//FbgAAAA==
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lijuan Gao <quic_lijuang@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734518412; l=987;
 i=quic_lijuang@quicinc.com; s=20240827; h=from:subject:message-id;
 bh=hhmnUR5c9uFdKHpqhLtr/hAqBcX2Ry/ge3JRYi47F8U=;
 b=blkHq3XcsIFZ0MKDFcfUQSMMUfVrDBZAFV4d7hH0a9sN7moWcO9lcnY9plPvO7/GQu4IsX/pQ
 oFuLqHDcqnqAP3+yi5f+CralouDPnvtTjZCwYCmgVopa2QeCj4YfgQR
X-Developer-Key: i=quic_lijuang@quicinc.com; a=ed25519;
 pk=1zeM8FpQK/J1jSFHn8iXHeb3xt7F/3GvHv7ET2RNJxE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PzCeqeC3fwvTeakBS6kKhtyExi7bWUKU
X-Proofpoint-ORIG-GUID: PzCeqeC3fwvTeakBS6kKhtyExi7bWUKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180085

Document and add CPU and LLCC BWMON nodes and their corresponding OPP
tables for QCS615 SoC.

The patch has undergone the following verifications:
- Successfully passed dt_binding_check with DT_CHECKER_FLAGS=-m for binding
  file
- Successfully passed dtbs_check with W=1 for dts
- Verified each item in the CPU and LLCC OPP tables, and the BCM threshold
  and clock values meet expectations.

Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
---
Lijuan Gao (2):
      dt-bindings: interconnect: qcom-bwmon: Document QCS615 bwmon compatibles
      arm64: dts: qcom: qcs615: Add CPU and LLCC BWMON support

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  2 +
 arch/arm64/boot/dts/qcom/qcs615.dtsi               | 72 ++++++++++++++++++++++
 2 files changed, 74 insertions(+)
---
base-commit: fdb298fa865b0136f7be842e6c2e6310dede421a
change-id: 20241217-add_bwmon_support_for_qcs615-a8c7a4034379

Best regards,
-- 
Lijuan Gao <quic_lijuang@quicinc.com>


