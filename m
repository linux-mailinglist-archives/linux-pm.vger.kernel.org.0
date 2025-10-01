Return-Path: <linux-pm+bounces-35609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8895BAF6A5
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 09:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516643A8E16
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 07:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535BD2727FE;
	Wed,  1 Oct 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o1vEMLjy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B464622F74E
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304050; cv=none; b=WtoDgEmgjenjE1ygW8R5Bl2raCDcNZB60b7rV5S/hUm0y9G+GPKgGIBeADoTL2bieUGIs/MSD8FZJQzORJthCX/2QH3hY3kE5NICdePQlLsNJ00KmxjCNuICRmxsvFeIJimqGT8znlfaACqjPBlwOMZVwuFXdhnv1WnbpQyej8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304050; c=relaxed/simple;
	bh=LzYC1jG3vaEWlmKbl0QenPi4ZGyQJHOiHpelOB+tbiM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EiYfmuXWlJZNukSOY4I3RAduWoWqKUu9BoPxpmsPprj7qfI4R4ncVSDodqRGgCbRtz9InN9RdqUAEwlsoYVx38TiKPQ0rrc3K83a90y1VZN+VndJLxywRIYoaEevJDcaINSBQeRBiFSGf2k/0A+GBDX3TBz8UhdPv0tdrz9Ewug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o1vEMLjy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917KgIG020554
	for <linux-pm@vger.kernel.org>; Wed, 1 Oct 2025 07:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=pp07pEUrCGLz
	DIs+Sa04jo+3a7TQCSPNLP1KjYGlBDg=; b=o1vEMLjy3GoDGECoKyxvayd5gxPL
	UHGXr4GmoC5uLEJw/DWlHeNMn2IJnVPvr2O4hGxs4cqt55BkmvQonxMgC+s7zn0G
	QDHE0KznlHYTEDPqXgybCTjDK2a/IIbZ8E7w11FtB4Oa2w9TQcH1hnGLEaKBa63m
	8WxTGeI4nNH3v5bHq2aE0g+bwc5KXSqHw7fAlbcjabZ97RHBtYB6zQMltEVhUAB+
	gxWsgqpD2PQqzPuO4OToWD8jevSIr859zslI0E+gIV8PmPm9IJkddIcS43fJX/4G
	Toj2kuoVHMU220EopoXxseIh/uYJ80pz2U4cj3F6FfasJ8sqd7O3wAFcfA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu18101-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 07:34:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so11108648a91.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 00:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759304047; x=1759908847;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp07pEUrCGLzDIs+Sa04jo+3a7TQCSPNLP1KjYGlBDg=;
        b=CVA06c627NM+wuajDftWqM3UtH7LXKldud2ix0P7/RQcPh17MSKJWkOt8CKonFCZl+
         m/jJRw6tdpU/SXZlEhKjnXwna+3Ajr+FXn8XFJv51XobqdUBAlnW+uxCi69+/cIOaZna
         yFgWMHv3Gp7P/lhzGX8RuBxOGH/JJ2y26QTU9Rnb2BeBJx76cdGDDCvc18bRsM37T3uK
         8tj9ZBY4w/90PPB6pj0r4ePjeHc8ZHknN/9zjUH/A32pSYlN0xCjL5L2UQ4xtvOAnpnD
         X5tPqQ73H35jEaelp3MnLMbXw5o4GS8jZU1UUXWAP3miKxaIuBevy1apisUT/PX39JcQ
         zLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAiE5bjWqtdvqNDo7/TM1jzapnhIl0cQgqaax9KMY62G2juCh88Sjw88YYQKPl7r3p5cdDMntYAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRWo864kgZF1Oa5xNUHrdN3bkpUMJgPQMaM3pt0rb4xgf1GhNP
	NBgevgbAG9+uNHmChH4EJ8bZ4oo796k7tK19fqrkcZ6jHpfSsagkXC6lGbxwZd9uml2cTsi4Ys9
	cq4YUktY6FWTrI7/zcdTEE9nlPeema7ZZco9focqzE+jB/nv8/u2QxwgKa4rLPQ==
X-Gm-Gg: ASbGncuvZdjotJ4ViSWlWvPYV2l6TF30yo4qylgrYuyQ7Sbylk5ptUpcOkoableXokt
	Y5hRwxPhN1MUxq+ugjeJ8VvAGaG6gUHu79AaSluI2MfoDHSVnSQrqViCuVvwZa0tPb1bPFVeon9
	QDGjmRpG0bBdb9vFkKHzC71YV954le0raAlxPwmKog53vV0ANlmUPADxYOPngz1nbdXZIRGPOsO
	elNlGiTGkXkRqmYXI4m073I7lK2Vlo3krE4/ft+wwWfN9HI5GT8sF7z88n/qcLshie6qqdbaVuA
	usXlepRCVRRAVRaAqEJ79FbN3HX8pRVW1vEJ1Ofi5VAH+Sv6BVXW5jQ8gNn0e4xYlXh1FGO7R9w
	LNes=
X-Received: by 2002:a17:90b:3850:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-339a6e2821dmr2984149a91.6.1759304046904;
        Wed, 01 Oct 2025 00:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4wCdRDYc1kF9kYi2y0x882T/fk3TpUqLUiTJTCRQG5Z3IT69LYgUd1RC3VsNXoEp1qGQSAA==
X-Received: by 2002:a17:90b:3850:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-339a6e2821dmr2984111a91.6.1759304046398;
        Wed, 01 Oct 2025 00:34:06 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6effe77sm1642127a91.17.2025.10.01.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:34:05 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Enable QoS configuration on SA8775P
Date: Wed,  1 Oct 2025 13:03:41 +0530
Message-Id: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68dcd96f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=myv7mu_oF8MPm2fSyvIA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: QxenCMHDX6oamUtIfbVZvi8HNUhIjQmo
X-Proofpoint-GUID: QxenCMHDX6oamUtIfbVZvi8HNUhIjQmo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfX3Yo+w5xut1yN
 kOf6wVAIt2nnBUhVqNwlSrEwF29EKmaTVeJrjEZypAe2JijwO7HBnguux9mPNwBjYONohCAOmL2
 T9zfP7DJAwtY3KbGTZDSmtVasj2Svl8rKdDO2TsxrfP8ByPfMDUetOe7Ydou6UpCkZv76Iw39oE
 QC6boMkJaDCmn+0PSPGufmDa9wvHopdZsz57GPwMuIoteDPyRL4WAcbWXKlgKtlireBQ8bVZLP1
 oZ1N9CkjXVghxmuPMIEIOX1pAOk/qjNm7gU8H4Ux6lG2QCjVEQ/JkYtbK5xdsGDPkp4ufm/DMq0
 VX1y8f3444sLG0ko6Ee5X/yvQJ1xG8omubraHEXtZcNUWtknfeiDM6Ekr1wO3ZYmGDPpdrTy+56
 jqLtqfQvgR4sQetSw8mqeuXQ8lRKGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

This series enables QoS configuration for QNOC type device which
can be found on SA8775P platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip). 
The system may function normally without this feature. However,
enabling QoS helps optimize latency and bandwidth across subsystems
like CPU, GPU, and multimedia engines, which becomes important in
high-throughput scenarios. This is a feature aimed at performance
enhancement to improve system performance under concurrent workloads.

Changes since v1:
  - Updated 'reg' and 'clocks' properties as optional.
  - Removed leading zeros in devicetree change.
  - Updated commit message for binding change with justification.

Odelu Kukatla (3):
  dt-bindings: interconnect: add reg and clocks properties to enable QoS
    on sa8775p
  interconnect: qcom: sa8775p: enable QoS configuration
  arm64: dts: qcom: sa8775p: Add reg and clocks for QoS configuration

 .../interconnect/qcom,sa8775p-rpmh.yaml       |  50 +-
 arch/arm64/boot/dts/qcom/lemans.dtsi          | 163 ++++---
 drivers/interconnect/qcom/sa8775p.c           | 439 ++++++++++++++++++
 3 files changed, 579 insertions(+), 73 deletions(-)

-- 
2.17.1


