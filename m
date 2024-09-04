Return-Path: <linux-pm+bounces-13606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E296C4FC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F33E287BB2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610781E0B91;
	Wed,  4 Sep 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VKkqhGiT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB311E0B71;
	Wed,  4 Sep 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469964; cv=none; b=dlAhxmbpuA5b5UpVOasLS4xlPzpoWlvhf3j88gxwZverzp2p9+107TPIuuvjzKLE0VQZ3okYUf0Idq7jGhPiuBhQaZF8kqCUjFqo1yBq+jeL3vclVdH3J+FhcFLTaRUGIeGZdJRSxeVXJhb3hG0D8XRWceRGLVidQ+S3CdYoQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469964; c=relaxed/simple;
	bh=FnjmjyIPJ+UDDju8J+PDzrU1IqO8fEoj/of0Ro5nJTc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FynzZ2dGxKTasdVwF8QW0ZP3rsbIZwLxt6nuE9CS9Qhtp9XeZd/3sz+vWoBUvpaxGlh/hBM+JAeYhe2/ImCXrckHTAncs1WWPr+iZ3KAVOZJQDOXtQLcp38JzNi6rqeP0c3YE/LKhkRqAcasWTj3cJbxx2caylrpzHY/9nmfVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VKkqhGiT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DH8dc009037;
	Wed, 4 Sep 2024 17:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hP8b27UGUNy3qqqk6/G3dx
	i1GzhlYgsoUuAgR8+m35A=; b=VKkqhGiT+bWTqCEaYEQQhUFv6qtCrsMBwZth0p
	gnpP8p6OEx3GAtYGsQzOxpHR5QhXGvS6+wxbnY5rVAUljVsj0aueenBLhT757NzY
	JeW/vM/v/tGy4tKuzc23CYF/QqzRxC3UTSTyf9rhmBpbvy4eRoe1EgHLeb/N2vHj
	U9N1Ieseao6RWj5Ok556nhklHwE7247EQWh2b/2AJsHfpRiCkxBceCHlqrTuTftb
	+QWEKaClK2j4ELMlZNyM+Ax77w0sorTcnXS0W/uUcK/5DfWx6DtBFdfUcUx6y1Vh
	ynLMDSC978qVv6Q0EuG5ptNp8C0GslgwWV3KYb4/PeKVMnpQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt673mpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:12:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HCapJ007282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:12:36 GMT
Received: from 0e63825dadb5.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 10:12:32 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add EPSS L3 provider support on SA8775P SoC
Date: Wed, 4 Sep 2024 17:12:06 +0000
Message-ID: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UF1Fr5pMZ_QOFYqwP-JEcn9TbJ805Or1
X-Proofpoint-GUID: UF1Fr5pMZ_QOFYqwP-JEcn9TbJ805Or1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_14,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040130

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Raviteja Laggyshetty (3):
  dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
  interconnect: qcom: Add EPSS L3 support on SA8775P

 .../bindings/interconnect/qcom,osm-l3.yaml    |  2 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 19 +++++++++++++
 drivers/interconnect/qcom/osm-l3.c            | 27 +++++++++++++++++++
 3 files changed, 48 insertions(+)

-- 
2.39.2


