Return-Path: <linux-pm+bounces-16166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A575E9A93A8
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 01:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6783A2834AF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 23:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97AF1FF5E8;
	Mon, 21 Oct 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H/rjM+kz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043E1E3766;
	Mon, 21 Oct 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551838; cv=none; b=MBip8/x6n1Bb5tBvb53UC4abfi2cyjQR/upoWneVHRG1ZkjTYs3HEUiK3MVqkR00vb3Gc4jYnOA8aQBHQneiTR+02gvNt/0EzT8DDXngR52KRHOoOGNDPNeUXZLmPNTuEAQs/DvbOwInZOs7D6w/b6grc5HCdq0YV5Z4+CDg2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551838; c=relaxed/simple;
	bh=rzm1mYdO64VmoTtfYP4xFCMogqichlS6ZQ+nnyxsMfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOIqmMaJpxLPaYqF+wwMWK8IhVBcv+itKk6lLB8u4PbYlKt/0AFpdxRMV7O942rJwmIPo4I/XFJ8Fie+Lg+TMZ9J/n1uwC+foOjTGHQBtZkpvEC/+lEK/Nqr8Uhc8WxlzpukwzJRa5eyLyOqdS6q0o2rPiLvNf0URaKcfwNQhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H/rjM+kz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LAoMof019646;
	Mon, 21 Oct 2024 23:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CJvQihQ/bv8EzM14ioNhOHRmmuGa/+ehrLSDHhcBIn4=; b=H/rjM+kzeoZEfEod
	D88Ikb7Rv/hqO687hvi13vCaOQ1hyNRn6Q3wOjdMzwhOStIMf7bkKOJNPfZVWffb
	pag+cUOkpKsMrMkrPZpQQgSuuGSqdobh9RZXYJX8dV+Nl+UNRLaiLK/GRIwtAyL0
	pY1rXYXNk/a546b/w7Pn0zFsIaP/Aju4HtvmxUxRX1TRAlQJOYA4sGic6weZQgvS
	RQHZ9NIe+D3ZX5Sp8zXGe4qc0al8q3jhoV9hYI7SN1otK4inZm5liuS7AvsFi5M5
	C077iegVIOFUGuk2aBREVQKpo3hEOZZrbjVWdp+yZ8elVuG8qcTz/AKpEDvvb6lW
	fpn6Ew==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6w1p6tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:03:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LN3lVZ032698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:03:47 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:03:46 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>, Luca Weiss
	<luca@lucaweiss.eu>,
        =?UTF-8?q?Otto=20Pfl=C3=BCger?=
	<otto.pflueger@abscue.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Abel Vesa" <abel.vesa@linaro.org>,
        Jishnu Prakash
	<quic_jprakash@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya
 Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains
Date: Mon, 21 Oct 2024 16:03:31 -0700
Message-ID: <20241021230333.2632368-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021230333.2632368-1-quic_molvera@quicinc.com>
References: <20241021230333.2632368-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tSVcM2VQNMuYK_zv_AjKXIhOlyN9H3xR
X-Proofpoint-ORIG-GUID: tSVcM2VQNMuYK_zv_AjKXIhOlyN9H3xR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210163

From: Taniya Das <quic_tdas@quicinc.com>

Document the RPMh Power Domains on the SM8750 Platform.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 17ad46e55529..baa1f52c206e 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -60,6 +60,7 @@ properties:
           - qcom,sm8450-rpmhpd
           - qcom,sm8550-rpmhpd
           - qcom,sm8650-rpmhpd
+          - qcom,sm8750-rpmhpd
           - qcom,x1e80100-rpmhpd
       - items:
           - enum:
-- 
2.46.1


