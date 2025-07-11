Return-Path: <linux-pm+bounces-30673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85512B019AB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6EB5A006C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094D28134F;
	Fri, 11 Jul 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dr58cQa8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73132820C7
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229552; cv=none; b=lzvjS3Z6RlgHEWT3Gw2bV3M+xo6NBWWyWMZ5wpwgZcTVGJnZsuWLwCbrRqIkixattVTXTvtDJUrEPSPwa/aoQ++F3husTG6wuf/nw5w3DeVKjP7J3GTPW+QPk5TyykdzuHfS2XrXEC3Cq/os8a74ld2EynYY2DBExwlur7DCByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229552; c=relaxed/simple;
	bh=PUWLtICbEV4L4aRlWDR0eUg09UFWc4K+vrBGp32riA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkxgAdzAZym5urSo5p1DKlioQSE44muQ190Celu9cdDsHL5RQ1oYuKsULhby41uJNlKzh++uvf/ZjtRm+At/mTUnWNAwO7AxiFyS/Kxxj+tQ07oHECzl272jKmL0+tMEQKhDskxuBWQzpce3q6vWQI2B3MiizVVOqalb6BXFIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dr58cQa8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7xk029941
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=H0BE0LBDOrjuC7B70yCc4WxoF2P4/T4YLOW
	BcDkRgnE=; b=Dr58cQa8Au9Kq//IpQjchEEbWX1jbEuhhQ6vnGT8GyJDavRhvm6
	DQ621XqYWv/b+54bZLCNGBKeJBM+5gmeifYtVGVs3LqF05EZdSYORvh9c6Oxbn5x
	iSRESzFgOhPypXGtAQ1sQmc53dkovUIU8IF5SuEvFr05Ieohwz3fRZJJwv4uDg10
	76Ir76RyeFwXEn84Y5Q3Glygvc1gNl7INc3AuuJeQHylBC0K/zBL9BIFjBOFkJds
	DfabjTMqYPuRePcjr20ECWuOv4O/JjdA6Z7sKvpXH/Cualeyo8GLtgccq0iBjfNN
	EWB1AzrO6aznxESkx72chff2IS9w4qSGhUA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smber9nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:25:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e1d66fa6so18636145ad.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 03:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229549; x=1752834349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0BE0LBDOrjuC7B70yCc4WxoF2P4/T4YLOWBcDkRgnE=;
        b=sBPonXrRf/5jVoEzM7nb3VdfqPUbUUcSxDKK5cOgAKBREVvZO9KvwcSHikXAOHGMbH
         8QMGRjI8mJ/1j6uhrb4q09JOZ3QZoimeeBRDE2LNiA3xHbmGt3b4J7PuhQjZhX9mrgt9
         /96zOh4Zfr37tFdVMwtjnOPpuhVHV9i9vK6agw4aQ0swT+s9eHX8kJouoPNKBIyduqG9
         ATivya6qzcjLQWu+D8QAb7xlwoQB0ITChDK6FUAS6g/1V3/oNYPZ/foU7zT6TDp0V4ti
         iht/Y40PmxU+6C3acxkvretATH4HbFpWbhU3OET1zhXENTmZ45kj28in3hBsjIBGJ0AO
         uG+A==
X-Forwarded-Encrypted: i=1; AJvYcCU6/wz50TzfAvJW0BrpsNL/Q0GiV37a9H6s+YX4SMt2MZg1UBCLO0D10aDS4P4Za5uqG/RNGULsMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWboQXDZ2Qtc4LXrxcMvJUBczGrbxiKn/gXmyH3UQUO7FuxX8
	yRJrx2x5J9ChKliuf+MsK7TxhGOJnn/bUZd8d4aJnkDZyB2pxPiyYpEzr8XtYcUe3L8UURAuSN+
	kjasHaVkm1t8dt2XufzWYfKAlFtZMNifIs0MgyEZrp8S5wbuFVolmn40qE9b9Qw==
X-Gm-Gg: ASbGncswWT1x/M7ygMW5N4nkho9rmL5QjnjmVpXZL33KiGRcZy0CJhPnEZ3jEfjmzod
	HAt31gkbjzYtbHAiiDURtoX1l3OfH8l2eYb0JEVlO+Cdqxb9oQxv9dZWfaMdOy2NtFfDi21I7oi
	almDryx+Kg6+ykqY8I/LFNMGWKZQP+QRPkKtdm/6wRf0+cR3IeSASXmVl0XJMWI2qZ0OO+NFUeF
	PetmuXN1zWlEILPVE8b+6EEvhzGiNbt++fczKjBoFLKdYbVqenvvGg31N24y9nMXcQ4faaNrhDI
	ge26EPkeQ03RQi/O9P440M8tt3+E5PvSRd50LCEEfFkZkggEleEBIaGNukei4ET4/CAJ1rdLfPK
	K2Y8=
X-Received: by 2002:a17:902:e88e:b0:23d:d0e7:754b with SMTP id d9443c01a7336-23df0831355mr23342145ad.18.1752229549005;
        Fri, 11 Jul 2025 03:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMWhYRTz9DHMwDnknPY8+YaEh+l+tNPzBDYHrBCVYA0fm1baC/+C2SiR09t+a0HEd6eQzK+w==
X-Received: by 2002:a17:902:e88e:b0:23d:d0e7:754b with SMTP id d9443c01a7336-23df0831355mr23341885ad.18.1752229548626;
        Fri, 11 Jul 2025 03:25:48 -0700 (PDT)
Received: from a10065738a1d.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436839bsm42861375ad.253.2025.07.11.03.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:25:48 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 0/3] Add EPSS L3 provider support on QCS8300 SoC
Date: Fri, 11 Jul 2025 10:25:37 +0000
Message-ID: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MyBTYWx0ZWRfX6Fcbs62zm0m1
 oOqQPgYi87M/KGo9lzmwcP+s1bpW/bTCHcKc+l8OHBs5GlVABggKYP+i6US8vu0OPT8PVsq++5l
 3JIjY0gJo7t7Jowdd1bpuGzXhNhcl/KhXd7NAMTfMsIiurYd2UzTvHU6xrOezcs6V9yZ6cG/rZk
 RdjPeXLhKgjjy7VNTXwYNWLfD91aqUU4wpJFaS1zohBGzeGYDpCJEnsOUbAY2Pmq/Jn2cjkDDXP
 gWYRB9dkIZQlGi64ZX4bxc/QfjmqCXBj3BP68AfvQIqiD8JmQ1dK8DQDW6FyKK7Z+WXBAlOxLyN
 e+hAh7bHZrWYsXUp35r+JSrthoZQsievjLflb8T0GYRdRA7L1OLJUPJE5Eg9OrexoYSDhlJyytc
 QkeTgneeeAZD8EHNlOAnjRrEd2oUPiyXGNDtO7Etd7fR5DSzINysNnzAZVVXEnRYxqk61K/o
X-Proofpoint-GUID: -20kM7OpLUZvn-N8CEQHM6WFWfUa7qp_
X-Proofpoint-ORIG-GUID: -20kM7OpLUZvn-N8CEQHM6WFWfUa7qp_
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6870e6ad cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=3bDbtYyfCIv0pmMcAUEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110073

Add Epoch subsystem (EPSS) L3 scaling support on QCS8300 SoC.

Changes since v1:
 - Removed SoC specific compatible "qcom,qcs8300-epss-l3"
   from driver and used SA8775P SoC compatible as fallback in devicetree.
 - As the EPSS hardware in QCS8300 and SA8775P SoCs are same, a 
   family-specific compatible string for the SA8775P has been added to the
   bindings. This avoids the need to explicitly listing each SoC in the
   match table and the family-specific fallback compatible can be used 
   for SoCs sharing the same hardware.
 - As suggested by konrad, added EPSS path handles for CPU nodes.

Imran Shaik (1):
  arm64: dts: qcom: qcs8300: Add CPU OPP tables to scale DDR/L3

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add EPSS L3 compatible for QCS8300 SoC
  arm64: dts: qcom: qcs8300: Add EPSS l3 interconnect provider node

 .../bindings/interconnect/qcom,osm-l3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 301 ++++++++++++++++++
 2 files changed, 306 insertions(+)

-- 
2.43.0


