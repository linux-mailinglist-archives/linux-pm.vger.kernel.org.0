Return-Path: <linux-pm+bounces-28872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E1ADC5B0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3F01897EE9
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F211291C13;
	Tue, 17 Jun 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Njy4D0by"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2928FAA7
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151226; cv=none; b=BeoO4HXItx+SPhtsdeQq6GZ/E3jB5f0JDXFW5bcsTI9fZCMwT61rNGAg+DZ4F51tOfkzmbw0JU4N/gkAZ6F+obIb+D254r6fmJ8pT+9GO5TgK/za11FJPYl8nh7yua/2qjQfmseeKlqdo0DrCUEEpEsHYtNKftOZQpm3Uo92O1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151226; c=relaxed/simple;
	bh=XNU86N9EHwH8cVHeT2hJe29cwljaIdUhr0t4VCXYkAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgScXlJupI8n1JcEh1RnhEjeoQ9qscpbtDDrMqtErYPtY6Gpq1hKrZwlR6PkODUObFk/+jggRjH8zML9/iPUXhIqG21r12BgpgwBMjsd+c7eRzdlnHyMCKNc9eD9u7Qv1ZhHCSrCkNeDDpoz5P66JP7m64HYzmx1mvOCo8a91R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Njy4D0by; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H7IOUf018217
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fmqvmK9k/AKo5SNpLwgroPGZIonaKg0+c1g
	g9XdcTz8=; b=Njy4D0by1rKz8FFXMBXuK4wYuGwJAfQohg0EidBRNaXef5i83to
	7SNicNaPQogiJ+3kP5VFIu88ODWHn2bKOc/Vn9Ua/LaXULw0k8cis/1RWMI43gmi
	4/Pgi/2vlzZCl/iudMc/yMAmNj09S48uTpw1yF5Lcffs6PRRTntMW7s2fDyXNn1X
	jz0UuDA5DeSpsLC3h/kq2cN7nKRLmlNV71tlv58Y+vVfkY4iN7pegkUPzkvK7pGM
	Uo+nZnOIxIfsSs/QiKR73u4LwJ5FwZOK6pv9YrmntGuod1SdngXTS/1uJUT5K/1K
	gGLvRf2qMWNCz5fGPey0Bq4yzK4V5FukyWA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mfn8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so7681969a91.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 02:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151223; x=1750756023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmqvmK9k/AKo5SNpLwgroPGZIonaKg0+c1gg9XdcTz8=;
        b=IWBHVEwKW336FxVXTkGBg8+R4cqyCV/tBgKEyYI1QFLkMh5OWuFr+ObmA2pVw2ud73
         AQGPannUJbQQCbcyVCLy8LlZH/uDf0GvsuthWrZDC/YqPkYjlvPDt5mWszOYU3bCZLfF
         ZTUGvyTlyiCETyLGDYpmyKffy2WO+RnnqqnUak+0KE/9MFGH9xYOH9a+JbJSXWfWk/7M
         fxfPtz173jLTjheJrxeRMOqvWoYnDW22ifXqJK91VaBXFRyUpENxzk+i83SgqozpKk3q
         FA1rkTf587f69wviEYdGURZBoNNLkBcqi6TXCdZDmzjrzRHDYhMw9FdOJbzHdt0GxRXd
         hdcA==
X-Forwarded-Encrypted: i=1; AJvYcCXQC70zI7kql+HOZOvmf+3OSFOurEq5l0tcecnCT0yo/4H55qNSXia82LS4FRU09wBTA1vupO+GFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLA63JC1n5PXeaFBhnyQqYeF+GIzz1jHH9oKPs9HAZSlOHFuaH
	JFDRnpgE916DZ0UbG7xkAGmZyTjDhRIdO7fkM+ObGhUp6flZC8jusUS3aMpIqJc3C69Wi8FsN6g
	rgVWb13ZLVxw9FCfiXxVFswb5zM3dOnSw/Sr1aS1HiRfvkr74o4wPrK6QqeR/+g==
X-Gm-Gg: ASbGnct5Tec7nBpNHJyzGjyflyy/PuSRqHobMpEVfp77k3E30aWErDMt21fmCpAIt2d
	twJqFQLz0fPC18OaUhebcUW2a6dXxisYMrtkwk6ZxeqYXijNl7a0fKN0mPBq88fJkpNuo8wdWrU
	JCNQTITUdawLmya6htBxmln5tOE42A49wad5Xp1ulh9u39YEmtCDiPism1XOU5SBDx3QaiRBv/K
	OFWDJ/cKFOGxfwOxtI0NpmWIe/roT/iwMtpxn1B/ZaQuFm5IF3KUybciTgxTLmfegock1s/CT4r
	k5rq6Gcc9jRPcP2CXdiLcvv4BrEE2iDhbeHrVN8IAVdJQPTQko1KtKpreVMj+A==
X-Received: by 2002:a17:90a:dfcd:b0:311:c1ec:7d12 with SMTP id 98e67ed59e1d1-313f1df631amr16365955a91.23.1750151222812;
        Tue, 17 Jun 2025 02:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDak9/m3y1Z+lHpFAZozMSnCXvpiXSdunaaZ8aIr66QWZk842CKABwPXtHP1IzwXStJ+syQ==
X-Received: by 2002:a17:90a:dfcd:b0:311:c1ec:7d12 with SMTP id 98e67ed59e1d1-313f1df631amr16365925a91.23.1750151222358;
        Tue, 17 Jun 2025 02:07:02 -0700 (PDT)
Received: from cb9a88ed5d41.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bdb39bsm10017370a91.20.2025.06.17.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:07:02 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mike Tiption <mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add EPSS L3 provider support on QCS8300 SoC
Date: Tue, 17 Jun 2025 09:06:48 +0000
Message-ID: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA3MyBTYWx0ZWRfX8obUumAhQHBV
 1iIOyRK176hHc3ikvJMuGWY6fS8lWa0B+h2QiKaeEMcD0WoMJEdFzWuU4VIq8h83vk8v8smCx9z
 KJzL6xGVJTwM5WlI8eKEZm/o/T3qrcj5ZJzyxT9B76Z7RXc52//miDw3E722To2p0T1ydnUOjhB
 NpUAvSfuYfKtXQyIfDPPTH8OgiA5sxQ26I/Qv1+M7yqmr2vMo3Hx6yt05e/ovW7lumyj7MivlAB
 20SOLrGH0HBKXxQET4eALZM050BiiMgo0Jw11E4O3/O71Cq5NPA4ezr8IrZb90Y0qMkTiioy1BE
 T2IOg2sn4xpfOk3mL2YQTEdy1avgtAcjibfnounlXyBfnFWdf5bruYXwrHi9nNhz0xZ8ANaq5q3
 BzSG3y07eSNOv453HKS5fuiiradFZkCCwQRYDkWbwCVYJ3j4mCsCWiN+ujV3XbC/ioONm20Q
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=68513037 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6IFa9wvqVegA:10 a=0wEiu_sYbdzYxkl5siMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: yGc8nLmu50szKkLr8U9p71wfoQKtDjcr
X-Proofpoint-ORIG-GUID: yGc8nLmu50szKkLr8U9p71wfoQKtDjcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170073

Add Epoch subsystem (EPSS) L3 scaling support on QCS8300 SoC.

Raviteja Laggyshetty (3):
  dt-bindings: interconnect: Add EPSS L3 compatible for QCS8300 SoC
  interconnect: qcom: Add EPSS L3 support on QCS8300 SoC
  arm64: dts: qcom: qcs8300: Add EPSS l3 interconnect provider node

 .../bindings/interconnect/qcom,osm-l3.yaml      |  1 +
 arch/arm64/boot/dts/qcom/qcs8300.dtsi           | 17 +++++++++++++++++
 drivers/interconnect/qcom/osm-l3.c              |  1 +
 3 files changed, 19 insertions(+)

-- 
2.43.0


