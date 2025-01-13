Return-Path: <linux-pm+bounces-20383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D81A0C345
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9D1888398
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BFB1CDFCE;
	Mon, 13 Jan 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LTyrAtFf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55921EA65;
	Mon, 13 Jan 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802517; cv=none; b=nbuSygGFb3lVFIzrbCpnnj23UR039+XVgyuy4eVVRDZ6yEq9hDSgvUJ3uhRKst7taPEIkeSxxF0P9rjjQwBXAxmI/CX2njmRqH6LxG3UXzYaYEjkWOmm2Et+md3MBFU15h6YBxG2I6/1mvoSscwWWuemVWAGzyTuU0lw2DY9d0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802517; c=relaxed/simple;
	bh=u86pFjr/gswDn64tcLgFaVm6wWSL3MypRv30v2+1NLw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=sDLfRBcP/WlpWegeQMB0oyoSHHG3mC3JXamuxkk+0trUfLtcFDBu+dej1ghLlfj+BgIqenq64LwPkOT9EZAjGgUEtX3OJFuwBDKJ6G4kK+1s4fmDGLQtvvuyqmHrfubDZKfFe+ZB+6rftngzpJH/p89k9pT78svlpsTW4BWnd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LTyrAtFf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DH3h6e020108;
	Mon, 13 Jan 2025 21:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TRkATnv+asOVlrEbiSLV+w
	5Cn4+nN8JQq7iTNUpH97k=; b=LTyrAtFfbOdLDVPhMwrKB0o9cm+XvBSxG8LUnI
	3l3ue87yBva5rCKE6eVbbWRA72Xq77HRSQsDCtfUPfGliNzCBDPaDwlooRpAZ0Px
	wgF+z9chXUE43XMy8Re2Z3CKeNVKTBSaYUaWS6O251ZWX0D9R7rhTV9KRdv14Vay
	Hza7xFUDNZKWQ0i+ElYiwL59ucwy/J8Lhn1WUu/emcnTQhKTGzrBJrzLwgegd/Qa
	ZfYv1owipBmbtmnZ31c9WQ0b2Fd1pifuoGtZPs5cOvnyGAZwi7CxyutofJcZc/ww
	l/Wpnf4/LS1JigFCbiyILUBV/KYMA1lRkpx/CzrnWWsLXJWQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4456wa8hfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 21:08:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50DL8Q97021206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 21:08:26 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 Jan 2025 13:08:26 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 0/2] arm64: dts: qcom: sm8750: Introduce BWMONs
Date: Mon, 13 Jan 2025 13:08:16 -0800
Message-ID: <20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCAhWcC/x3MQQ5AMBBA0avIrDWZClGuItJQg1m0pCNIxN01l
 m/x/wNCkUmgzR6IdLLwFhJ0noFbh7CQ4ikZCiwq1Fgr8aau0I6X34L1gxwUlZvK0ZBGg66BVO6
 RZr7/a9e/7wcvl72vZQAAAA==
X-Change-ID: 20250107-sm8750_bwmon_master-cd4b8e1080c9
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Satya
 Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736802506; l=617;
 i=quic_molvera@quicinc.com; s=20241204; h=from:subject:message-id;
 bh=u86pFjr/gswDn64tcLgFaVm6wWSL3MypRv30v2+1NLw=;
 b=/l9NS95xsAH2gooHH+kxMzk4rc2yEX20NNSY1tYITEPBHArvP51p4RObhpXUmcpuZbmH5uc+1
 xoUg8UIxvqFApGD6+wsIbhuCCUynqlvswcXibS4LjLB5qnfGCIJMLH5
X-Developer-Key: i=quic_molvera@quicinc.com; a=ed25519;
 pk=1DGLp3zVYsHAWipMaNZZTHR321e8xK52C9vuAoeca5c=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f0srBoZUZcgHIknXzKd_1jGyePkq5vTn
X-Proofpoint-ORIG-GUID: f0srBoZUZcgHIknXzKd_1jGyePkq5vTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 mlxlogscore=712 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130168

Document and describe the BWMONs in the SM8750 SoC.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
Shivnandan Kumar (2):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM8750 CPU BWMONs
      arm64: dts: qcom: sm8750: Add BWMONs

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  1 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi               | 74 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)
---
base-commit: 37136bf5c3a6f6b686d74f41837a6406bec6b7bc
change-id: 20250107-sm8750_bwmon_master-cd4b8e1080c9

Best regards,
-- 
Melody Olvera <quic_molvera@quicinc.com>


