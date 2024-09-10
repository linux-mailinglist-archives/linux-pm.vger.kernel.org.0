Return-Path: <linux-pm+bounces-13939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6697327A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 12:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AE5B2B8E5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB7819AD6E;
	Tue, 10 Sep 2024 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YElqqXyo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2E18B498;
	Tue, 10 Sep 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963347; cv=none; b=rx8BJWrvncLfet8vroPyUMue3GsOesxhWPYpB4FgY41jOLJ6ad6pWYh93MfBEOCUQvewYvsZgUgrqNDMoagorCuR5OkUklgN3o3PdQMx5hvJ26uQW7Q9MjFYYRZqbU5AdVnuIDO7tAO00kqzJDiGzNtmgtjsENR3rYgPrMBy8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963347; c=relaxed/simple;
	bh=RJakgAWPl3L8DYhY9yMdwho4N1JyK2KPRQa3NxMSuYk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESO0MTkxlwfaaylYDqE0eYN4fM6b5lgEFbvl0ZOblSkKxR6qiezCz3QYOBmONOekzpXclOsJJxcZISnlHLxA1C25KBhfVJdVma5+OeLE8zgJ0xvXcqlb/MMrzDMZgdSLrErmZPbjARlAZt3V+6MDdw4/oCxQ4pq4B0MaBaSzRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YElqqXyo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A4b1Zg000538;
	Tue, 10 Sep 2024 10:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N5YXDTqQmIZOplCswfYBfX
	Uif9UQ0Rc55Bi0BP6n8qg=; b=YElqqXyo7z8jUpeC2jpPZDHku4+9ne3YmKRJgt
	uhR9KvLNEiGhxdzYV2Sl0MTYaVA9EExUiIkBloAisFKH1DVwI5HKJCV3h/LiAud0
	GUeKPmo1G8X41wFdgcYES8zYHkDUzaWoyMMWYWU/Mo83orR05FJGvbq4yMWFALLD
	D3qpoRR9pVOylcNX68UaSGIZrrP9mIlZIEVOppL4bFVM4OjowEG7NsMqRArscLtw
	4H5nYG9DfOZCGAta0Z0ttklkIBF5FITCnnQlmlSq48aP6oP2cbTfqkdEgulCVs8G
	VZpJNaiwzmbl7i7CDjazy1jjj1xaWf6NMJsN1xzLXUOvT7HQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy515fyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 10:10:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AAAY4x016629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 10:10:34 GMT
Received: from 3a9ae799c7fb.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 03:10:29 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Stephan Gerhold
	<stephan.gerhold@kernkonzept.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        "Adam Skladowski" <a39.skl@gmail.com>,
        Vladimir Lypak
	<vladimir.lypak@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Odelu
 Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 0/2] Add interconnect support for QCS8300 SoC
Date: Tue, 10 Sep 2024 10:10:11 +0000
Message-ID: <20240910101013.3020-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5KI-C9ruJ9W-bKaA_drjmlrH2nlwYBEo
X-Proofpoint-GUID: 5KI-C9ruJ9W-bKaA_drjmlrH2nlwYBEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409100077

Add interconnect dtbindings and driver support for Qualcomm QCS8300 SoC.

Changes since V2:
 - Addressed comments related to dt-bindings title and commit text.

Changes since V1:
 - constify all the array of pointers to structures and provider
   descriptor structures.
 - Dropped all empty nodes.
 - Added reg as required property for all the providers excluding
   clk-virt and mc-virt in dt-bindings.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: document the RPMh Network-On-Chip
    interconnect in QCS8300 SoC
  interconnect: qcom: add QCS8300 interconnect provider driver

 .../interconnect/qcom,qcs8300-rpmh.yaml       |   72 +
 drivers/interconnect/qcom/Kconfig             |   11 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/qcs8300.c           | 2088 +++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h           |  177 ++
 .../interconnect/qcom,qcs8300-rpmh.h          |  189 ++
 6 files changed, 2539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/qcs8300.c
 create mode 100644 drivers/interconnect/qcom/qcs8300.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h

-- 
2.39.2


