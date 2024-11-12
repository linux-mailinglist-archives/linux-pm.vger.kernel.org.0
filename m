Return-Path: <linux-pm+bounces-17381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B89C500F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 08:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFF9289D5D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73A209F4A;
	Tue, 12 Nov 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BqKN8gec"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762D1A726D;
	Tue, 12 Nov 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398327; cv=none; b=abYiTnsqWzHgMKTqupnhu4bg42dlEaCxcwIsSo9usjmVXMrGUHdW0FjLUhGNJzMRYEWQmMOxz0GppltC9KBp3F+PXOtfRKJpUUp5b+0Zlnz2FlYbtDMMkn6NPVsmvGMkSpNKnCvmt9zGHHegvyxHVJrM97SIn9AjCvb9cGIelQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398327; c=relaxed/simple;
	bh=WsdhACWt6fuMbeyExd4i9NBXMizv12EVtRlObsb7hyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqrEwAL14AosPDWW1ew3+xDFNh9VuA7mHksBmq3B2mf+cCASKQ7GFE75eb0lGTThsjTKYKavwJIeh0zA6Fy3GGYXatA7TV1FroCjCn3BLCB/3mpLGOKmlce8EYT+5UWofzidS5b0xM+Tj0WLZpq4zKvEp3PqmhSetTCQn8QIQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BqKN8gec; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC1umjd004748;
	Tue, 12 Nov 2024 07:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Jr2KUsGP8HvkBibT1c1HcG
	6Z0KdWlTMmYks6zfnlQl8=; b=BqKN8gecCve/D27qKr+yiW6waXe+TIO08rQGpm
	Xzi/VM6R5udi/ftwx4041EIqGc5S03L3yaTKaXe4JsLGDjmEMhwBOA5hf7Mq69NQ
	Yhpz5iGWXUVSZmPoA3QVRnK5YpGAFofzMxewVIbntFCss0V/gz2MaiL5lrpmSXnl
	MPeAA+jI0xOvSeqzOY9FiLTfJ1kcc0VL07fmUW98Kixl82nUNaF/v/aIuUUiTC5j
	3mRP58papABBIeQASOtjKdOgRaW/TdslwXAcWC3FI08a4sIRWKLNKWHnZLF46+Of
	iYK+8EzNs7lwSm7OJcVg9kpwmv8HBGXUsaYRXZMitSsw49GQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uwt5gqhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:58:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AC7wh5v001115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:58:43 GMT
Received: from 19197b7011e2.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 23:58:39 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH V4 0/3] Add EPSS L3 provider support on SA8775P SoC
Date: Tue, 12 Nov 2024 07:58:23 +0000
Message-ID: <20241112075826.28296-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ziEd9BRp-vTcgCtdpqo3DykwTFMxlQX6
X-Proofpoint-ORIG-GUID: ziEd9BRp-vTcgCtdpqo3DykwTFMxlQX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120064

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Changes since v3:
 - Removed epss-l3-perf generic compatible changes. These will be posted
   as separate patch until then SoC specific compatible will be used for
   probing.

Changes since v2:
 - Updated the commit text to reflect the reason for code change.
 - Added SoC-specific and generic compatible to driver match table.

Changes since v1:
 - Removed the usage of static IDs and implemented dynamic ID assignment
   for icc nodes using IDA.
 - Removed separate compatibles for cl0 and cl1. Both cl0 and cl1
   devices use the same compatible.
 - Added new generic compatible for epss-l3-perf.

Raviteja Laggyshetty (3):
  dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
  interconnect: qcom: Add EPSS L3 support on SA8775P

 .../bindings/interconnect/qcom,osm-l3.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 19 ++++
 drivers/interconnect/qcom/osm-l3.c            | 86 ++++++++++++++-----
 3 files changed, 84 insertions(+), 22 deletions(-)

-- 
2.39.2


