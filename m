Return-Path: <linux-pm+bounces-30926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B4B079CE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FE01760A3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D94233D9C;
	Wed, 16 Jul 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMKWZ2Dg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC12F237C
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679695; cv=none; b=JofaT2odrSkMbPjiOxrRzv6qKFvZMcVCj9Vc2FxzW4Dd4viXIOOWCmfRTVUVQtJTeLjtHXsRlX5F/93BnHYptLk73CadhpJKs0q90YP2JpVI+I30SZZpk5sXruYmddhkyR6BsdjYz4oo6pROonTZMQxd03nTarlOsm/kEzt8TfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679695; c=relaxed/simple;
	bh=HwJpo57RFu4YKFi1G/WbvBeaj5ntOXvHLOhM/OG4UqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RCe8/g3DrBrDYPfUw6wJWRELwrQlzDuHT3wxgCh18FjVkbFOesCuL+GvL7X5D6Ie6nQhTmZy60AZ49zKqgee29GRvxsOBV90nL3hL8zMtf5ZxWU5iozonhqKeJ4RZc0QyTMPhHD4SkNzNKf4njdxeb6F3CuMpI1nKJ6/kvpaFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMKWZ2Dg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD12tQ023969
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VZKMCsHazxjdkqYHSetpbR5/PKn4CY0xIoo
	KMOHaHjA=; b=pMKWZ2DgSADpm8HEqZuibDX0UBDDw9AST1FpgKSwjj2Jy+95/dP
	2NOQQMe0iNEtHHSEbSh81azFQUpxNV6zwu8hZMJTusGiygCOwVl0i5J/mjiRewY4
	CNmQWEXPHz2aPXV8xTEsqFPFJSKQLaTKixIU1HkEZoaeDpuxhAJfkhPlBOW4pvEG
	QzOj3qfpixBxJsbJw7jiS2C6iOFadoSo6s2XQIV46Hv0RF5kQcAaXVfSVAR0QAGY
	Mhn/X2XhSI+9HY/QaF4vYMGlaJO412Wt+fLw77k+u2Y74tJMDlQe1cUhCqU+am2W
	oMX6vhRWGgSdB2okQax3i0rgrN95bYZKWHQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsq8pj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so44373a91.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 08:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679692; x=1753284492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZKMCsHazxjdkqYHSetpbR5/PKn4CY0xIooKMOHaHjA=;
        b=wUJDXw0r9KE7AY7+v2tdtmjbysckBNviG3LSDG59zsGl666tOy80PIZxEzS/Mpc//K
         dRwiklgscW7d6R/+V9+0FJu18qeUUseZ6mgLdHQhgv6uB2pRlo8pU4koanpoY1BPoLFe
         XHO2shPm0qyv8YyE+zd6oFw6XqO3XEP3v8XYYGjQe0utnd0oOZ82Rjt+J4evRNct/Is9
         IXje2xXQKuprg44eE8a7gZlp+a7fskAIYzEvRAzIepM/5AUU56ZXfw97Gn7UE25b+fVg
         X30cMIB7fuYIkIAo1bCDbmt8pfzapREHxI4A+6+Kj33BGylbAwmNKGH9SZcVh4g25Flp
         vv9A==
X-Gm-Message-State: AOJu0YwAwa1qNRgHicRrVVy/+3CwwYhJ19JpgbG+NAqzbQLWtRlxKhgq
	wWuXkS53NOfDqXe6dP2Uo/IvH2wZ0Q3iteD7ag0GsthajUYKqCWo2jMGj+FH3COTackRvQ86BNe
	z3Q9/eCHz4ibimDpsLeYWCT7pH0tzcLg5GzNa2tCxaeTmDY7oOK6qchZy4++0og==
X-Gm-Gg: ASbGncvTpaNd2Mt/aTjLuIXZbcCgfkRaW3y6QeKIkkKeapQ7tJRPNs4AyQT9AxRgwe8
	NHKRGJsy7flIyY/W+0K3vHzGjJnq1j80fPejUucRJVRzTieyxLCdB3POGtq/geqRSarXtUum5hN
	X1GM+HoNFuLIfYUREDJX/uzXW7Q/noniF5/2eY5AO9uPzgsJQ66BND+Cs+ND+QPHsBMzhX/bB+s
	MWkEfqoCDifa6N370vabFI6gEpVQciNxT4NN74Yn836+y3jqIk665/vk8IhLO1GolvM29NmJD+M
	nyO5V+1qM5YeCQqdo6PSJYdJgAVdQmEM5ODwIVLOTiTnjUXOe7xEEqwO1rvI1OMZLb/oUsMFpQn
	pxeZ72ryjroLA4Y9KqRpBbU4R8rGvIFmxKKQnD49J6enz9CQ1y7mUIuGsdL+R
X-Received: by 2002:a17:90b:2ec7:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-31c9f4389ddmr4109787a91.29.1752679691808;
        Wed, 16 Jul 2025 08:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK4dc/pwGVIwFcWXELIY47gNpp4QXWUC2QB+vNktvv5F/caCsYlOFCAErMO4+m+GGA3ZhrXQ==
X-Received: by 2002:a17:90b:2ec7:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-31c9f4389ddmr4109750a91.29.1752679691396;
        Wed, 16 Jul 2025 08:28:11 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f20e87bsm1688563a91.35.2025.07.16.08.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:28:11 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, konrad.dybcio@oss.qualcomm.com,
        quic_tingguoc@quicinc.com, quic_rjendra@quicinc.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for RPMHPD on Glymur SoC
Date: Wed, 16 Jul 2025 20:57:56 +0530
Message-Id: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6877c50d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=76G38qL4IpClrheZAL0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: mBZGNQgGVCPGgS1jpeTmFj4Er-Xp6Ygk
X-Proofpoint-GUID: mBZGNQgGVCPGgS1jpeTmFj4Er-Xp6Ygk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfXxKDp+FHQTQMu
 bQGEuBGtzLstp9buuT6/QDOW4mSRs2rlHXN1gXxAXeI9MAnC3eTm2jk8CTC22cGvdfQgqnwdlQv
 KjHUEfAllZMbcRfsKknpdw3arsno5u0fqW3yQ4mL0j0wtKWTDrHSZvc2xKXG3+sacwT2dBzzlcw
 KD/bWMvVpSHLIiN/6QqrqLhYDIlW/psm3XxQBlC/xEl2jupTjeXnaSXw0ctwskHg0cpvDA+LV4R
 jJvt6Mlq0Utt58nCvEROXv+b49S87KW03sBYMSjgUrcCgoUnSZ8J/8J0flMPEbg5g7TfC8Vu/bC
 TW5/QNE/Qxzgvr3PiKNC1On6raz/9CqeWx8z4oVHN3gaVKXkH94CA8u77DwVI10LAznLf7frFfx
 tkN9Q5XKaQYYbp5pdhKC0FUgT5MpOqM57Z5fRT702Qa98WuCE12+JGJTM/uDnsr7IM/ylrZ+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=949 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160139

Add support for RPMHPD bindings and driver for the Qualcomm Glymur SoC

Kamal Wadhwa (2):
  dt-bindings: power: rpmpd: Add Glymur power domains
  pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.34.1


