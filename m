Return-Path: <linux-pm+bounces-35311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3308BB9C6EE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 01:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC7D7B8ADD
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3FE27FD7C;
	Wed, 24 Sep 2025 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hs46tpna"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA087285CBC
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754983; cv=none; b=ncTMjnW7yDNz2XEGEVxpeQjnq7OkWcxDSY7eXJPoa+/2H1MIlvApf9aMLddI3Ye8wnl27PEsdPQk0CjRc4M0667BULFwwnXcGxuFgbJZeGTmnVZYDPB+tX69hmA3EkLZM0qp2MGhiPigOqtzKWSS5Ka1yl10WIClOxj9HNH70/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754983; c=relaxed/simple;
	bh=nRwt3nntfCFNmkA6WdE1w/AtgfXKpttU/xX/NO2gXrE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=leASRIZ7PJTvCOefh+uT2h2ggeH7QBcPJg95n+xg/XL9+S5zETzxXawFaZRA3sroAKe7dy00UgzRrzb1I51llTllrLXL8TdB/UCbYWU8jBUAJ/JvwD9oHv28uCLOVzdCiFju9tv7B76/eqwQDQV76uK7wnf/IKIHyWf/20TUiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hs46tpna; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCj2gC025243
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EEovNlQ5bCPkreL3sup3qN
	aWRrg/nYl3xLCiUK/1dNU=; b=Hs46tpna14/OGE0V9YcY97RUaYeJLUyDn72uTr
	K7Sz99NcAV3n9R7PTw8T1PcD0CeXeMP5mAFaX+fYdOqVHFDGEbOwg3n48IKK/6+P
	MAokNF9EwG4Bg5lE/r6nYxyl+KXNR9I7BcJChFtWGufjRqGYniw505cO/t7Y4HIb
	1bRuiFyvIV7dgesLaI30y2BdKUEwbptk7QVR1qrPm5gRVLNVjq0YIOHBn1Z5TptV
	AoamAudkg8IoiHUgXQd1XnPc4RIJbc1rwXA17kdcE+yhWGiWzM6ikPw9sNniEVfj
	+HqFCZO3Ma8PnEJg3Z9Bwvjk/m/jnn/ZNsDRHamPqyYKFirg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv160by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:03:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-268141f759aso2594835ad.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 16:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754979; x=1759359779;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEovNlQ5bCPkreL3sup3qNaWRrg/nYl3xLCiUK/1dNU=;
        b=IzEc2uOQNbxyEcLVYjZlOX0CxIwMdh8HVY081d7MwO9n6pxhl49yT3vDgpYWXl7xDS
         H5lVCPQt9zVXJmrYCpg/njig0toHbJfMJzmRvJ8VB/7zbrUu2CttTGpenBA4iXmnhpIY
         Rx1uS8fN1wms5gF2wlBeYOfNO+voyB7zNRSgD1IFXAcHkBNlHPuZWOWcWZkcmthYt9Pb
         J6kFFHuxnwy2p8iAOvJ+qU78DI963ERD9wZHeHGjdGdgK4mO+JdOemf9KGBsU6RHcR+q
         ftnngWHRp/H8ajk/Qwd99uMpRvKbx1PwW6e4PCL6sqc8MS1M9uPVD0az6hSUcULCAuzY
         cBsw==
X-Forwarded-Encrypted: i=1; AJvYcCWwHglYv4CsEKO+UBaAkceBJTWIwiP531M2dbscPgwexyAAAOwFGa4tiM/J+9uRC39GqjPDOhn6aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtqWUmekeN5fRvBjDxk1EbedER8Jzya4XmITCBUCGwMRkHcOd
	/ZBUbuRw/GIOXGd1tseXqeoiGqB6a/Djb4oSzmfwRRptRbiGe/eaSrWvmIo5Skyhrb92v2r1ZOn
	P7AgDmH65N+2UuJ7wyrLkJOkHBHCER2wkqkauYmdiUblHu+cqlL2KyrmSRrWFWg==
X-Gm-Gg: ASbGncsBMG9lM/pjVXCos9poIqdFRFttt/Pd09teybdxmRY6BN3YDFKGDH9SNA2Hx3l
	/pz0V63/dC5Wte9ZFYrM8mXtF9rPNwFU7cZPCrHAuXnoXlM5Hfu8lBVlRLWTu+BisLIc8dQ0ovN
	sRg9tBEVSLwn47msqdplQUb50mvQtTuJrFOO2CfhZq6bp8AokpmLvIag4PT9NP/AH7OCD00QY4t
	eR9Dj+VFSIFWgN4NHwUi3nZDtwlWqzCVgF9t2jgg5jSZdwqiEBahM5gLME7NAneh7H6JjupWYyb
	u3BgbgmJ9IsweOBUwI9NluR6O1MErnHkEgv/lsyiQOiuVM/3fdGln9uwDs386F3nivZRfMDqDu0
	0EsDlH7dS7EUg1+E=
X-Received: by 2002:a17:903:2f86:b0:269:aba0:f095 with SMTP id d9443c01a7336-27ed4a3164cmr13375755ad.35.1758754978505;
        Wed, 24 Sep 2025 16:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWqE9Wz0InuUFJtaOLtEVLSMSYQX4VVL8nUER9WUlygGTuSzRC5iSu6J+VMjwX8Wrz59nCxg==
X-Received: by 2002:a17:903:2f86:b0:269:aba0:f095 with SMTP id d9443c01a7336-27ed4a3164cmr13375285ad.35.1758754977922;
        Wed, 24 Sep 2025 16:02:57 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347472e49esm153255a91.21.2025.09.24.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:02:57 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] Add interconnect support for Kaanapali SoC
Date: Wed, 24 Sep 2025 16:02:43 -0700
Message-Id: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJN41GgC/x3MQQqDQAxA0atI1g04Q6Xaq5QuZtJMDaVRMiIF8
 e7GLt/i/w0qm3CFe7OB8SpVJnWESwM0Jn0zyssNsY1dO4QbfnRG0YWNJlWmBa89RRpCLqXrwbP
 ZuMjvv3w83TlVxmxJaTxH31Q9hn0/AAGLlWt7AAAA
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754976; l=1027;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=nRwt3nntfCFNmkA6WdE1w/AtgfXKpttU/xX/NO2gXrE=;
 b=EKTtxLaFS4Vb7zFVZ6YgHLsegqHVof070b+u26o6+YUPBWf6OZaQ5doirxHO8+yJ1pnli1Wtn
 sfLmYF8ecc2Cib0kjFMyxMCNLhVG3LN80QJDYYxRNgeTVTtEBRRBqNd
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: QjhtQRL1Z68S55a23QRvZ7hV6F6xSzm4
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d478a4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_cDidGYXCDOhaqYtY5wA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX01rFnd0mKpiD
 4CiBRDJu/lLjXF09xpFnHYVFygpJOdqMWSCcePMtkR0iMeRCYW34FVxvfNaEpZPAUXLahDC0yWk
 LxUF5h2NRcl4/7SYYe7a6lEDcoyd2rbXerdnnLD6UnJGD4e0RPW512lHa+pzOCMCzqUO1XNLXzq
 ZH4vYalHi+66io1VhjLDmFJHkGX+IZlcgSFw08sRbazVOB36d6zO5OnLoJT4bj/GfX/sI35c+qZ
 RXZ7AeohBTwwjKCYdrmTnwJrl6TRjDgVpx8rUTfaiKluRuXEDmuqoe4kfYwyWyX9u5/jhpx5iDP
 9bPK5UtLNAciTRgkqCQL/JfU3PuuL0Q8Or89Fweq4n0iBEWHzkfACmLjoIVTlrakNKNw4b+vyAr
 O/F9VvUf
X-Proofpoint-ORIG-GUID: QjhtQRL1Z68S55a23QRvZ7hV6F6xSzm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.
This yaml file depend on Kaanapali gcc patch header file:
https://lore.kernel.org/all/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml |  126 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kaanapali.c              | 1868 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h |  149 ++
 5 files changed, 2154 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-interconnect-48c2c91bff58

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


