Return-Path: <linux-pm+bounces-12973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4D961131
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 17:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B0F1C23772
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931F21C7B61;
	Tue, 27 Aug 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y7dKoaGd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12B1C6891;
	Tue, 27 Aug 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771817; cv=none; b=KD/bo8h/xc17Aqd30fe9oYyvp5iH2vuTAkl1LkUk/3ipdrpkVyUnnTi3vGgJ3d0uQiiARZkN5aH99MwVCdC6cCyograeB+R0qWIjPPVAXIZ4rC2w6+eA5llqwsbtkohKyA7MrxVO6jI1Kr0AgMCGeUXarlfYylB6JjUlHjb9noA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771817; c=relaxed/simple;
	bh=bvJtOJ1nbT9sH3oz7r2/d5+S2xeQOifgoGikr9WvDNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KrmeliibFcQB6FFOtK3ZtWLqhkrxqzOewBXnY20FFk92y/ExJmcMQ48cOOp2xu81aCb5p5CsBNZNIMi21RCvp2M1ipIvP9nBkdNsX7WXD4OC5AG9r1+WLLDFwCojIZ63BIpJDiEjG58Uqmz9nZD0IN+Uv2E05pD4zj5LJL3mgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y7dKoaGd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R7eKKB028220;
	Tue, 27 Aug 2024 15:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mZq4Sh2MbNAdxOG4FNjqiS
	KZCv2NfxR1KwjKF3HERx0=; b=Y7dKoaGdtZ0p+ihsbtA9tuAG8Bl+F0uDHfOB8e
	TwPoIP+tNMC3AVpT8uvXSlLlB0Wf7+WR6J3OBE/DOXOg5T+QoGkpk5UnHtDvdTt1
	NaUKgSMTftHQHe6OcI34m3/YluKhNDeGsIEVS7owdgxnljJsUS/U35b0RjZw8mLs
	4Khqu29bX4EtqPu3kAIpKOHqzUAmnY6P+kh7o5zVO1Lte9fQYnD9d3kqFbiwib9I
	xnXDLy8Esf6DcGDlSguzIihSzDASUmYxUWvxKIApoCKLGUuqe/SbTPZGXKtfs4gt
	RWgh6MV6kvHCrpIFdjeUNsnToCzBbD5D8llp4DAVwHBbPqvA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417973qcjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 15:16:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RFGiNi028479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 15:16:44 GMT
Received: from a7db4580273a.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 Aug 2024 08:16:39 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov
	<danila@jiaxyga.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Vladimir
 Lypak" <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andrew Halaney
	<ahalaney@redhat.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <quic_okukatla@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Subject: [PATCH 0/2] Add interconnect support for QCS8300 SoC
Date: Tue, 27 Aug 2024 15:16:20 +0000
Message-ID: <20240827151622.305-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 96YRx55Jf6uLX6Iz94O3XdWXlhHANElP
X-Proofpoint-GUID: 96YRx55Jf6uLX6Iz94O3XdWXlhHANElP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_08,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 mlxlogscore=922 adultscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270114

Add interconnect dtbindings and driver support for Qualcomm QCS8300 SoC.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add Qualcomm QCS8300 DT bindings
  interconnect: qcom: add QCS8300 interconnect provider driver

 .../interconnect/qcom,qcs8300-rpmh.yaml       |   52 +
 drivers/interconnect/qcom/Kconfig             |   11 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/qcs8300.c           | 2093 +++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h           |  177 ++
 .../interconnect/qcom,qcs8300-rpmh.h          |  189 ++
 6 files changed, 2524 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/qcs8300.c
 create mode 100644 drivers/interconnect/qcom/qcs8300.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h

-- 
2.39.2


