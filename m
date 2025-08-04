Return-Path: <linux-pm+bounces-31842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B44B19AF1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55433B5514
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 05:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B839221F17;
	Mon,  4 Aug 2025 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="muXpCsr/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80181C2334
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283983; cv=none; b=Cfw0wdAULq6v+/8XD616SIGiaAoXKXuyYCD2Y336HwEISoN+in3FSX1WE9u+KZkGZECW91VAGC/9UJp4rG46GyX3HccoEQA8ZyjSrT8CadYDvppPQ2EyTXuOW+mF9Svr9IPZFyu+FTYlpkXoKZSnAj6HDkhAAbUUVUkLpps4JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283983; c=relaxed/simple;
	bh=o+KKhqjgceUKc54+3lwvh9D2uZKZYubKBJvC6PvrxDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci2Sw2N/Svs5QrHbLgvizsKXYOdGnFVEgk1IfQB3WD3jvZY9bYoJH434q1FkuBKUL0CJMY47afZWDyGErGwSH9Rz0dNy6Z/ekRJmlhq4vzNfpWErvlzoRWHpRWhOyrur4P9EJAsi92kDaX8DecdX0MBn8wppTLi+VIfEX+M56/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=muXpCsr/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MghXU005456
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 05:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mFgAZJ7P3Zm+6XkWFs5BVvgYy6OJo2QLp+7
	HH563RNs=; b=muXpCsr/zsFbL166dtN8CxzUqtxQo9GaQvp56QrnjHQiI/nJsSE
	j4C6ztRwWvDL+KNADD66Y8sC2T+7sbnMhQPJzbKrrnGgUFg1Ri4F+jvP2zSdVQL4
	TAdmceULpyCPOYYHqG/hJEEGkglnseIR2t8BdB4avGLPLfmfYntSXfi1qv7esaxV
	45hNtxjeFI9mg66jFAkkJcmwVBINQXcrupnNlvKJKqdIDAoDRpLSKju1Af2Hf2ym
	h1EwWyguCa38yFDky7HOliATiKugyCqNboBBjFaqhDHZeXVbuHXGvVGvEsQ04w1E
	4jGkOnp3PYZlhATLYhkNmhtJKb0A1BEVrmw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke1ks8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 05:06:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31ea10f801aso6539267a91.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 22:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283980; x=1754888780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFgAZJ7P3Zm+6XkWFs5BVvgYy6OJo2QLp+7HH563RNs=;
        b=h6QqoqrUf1TS+xmfMgShfeDtPp02War9jFeOCZSIA5spvZO6r+xkgTFFLfrM+BVFdg
         lS/quScUIkfUqt4mLLnmtnoquGeL3bb4mj4QKvQRZm7FVK3OP6yrEfHuFMMPeiKlD3Nm
         ZA19he93kJbwpgJQ6HvP4cdNFLkF1BBCsAy3IgPTNAWOd+yN7JorfiwLzVhXMiJqybnT
         rn33GUEGIASpqRSPVZxjNZgYiojh++jgEm/TN/Oa9n16Af8yYF07Tc+hLkv3Z+3leReJ
         4zloMdn2Vm26RKcvkQONUM67MBP7N+c81/8vbBrZ/JOqTY2cU4h1X8ty7KZTuupPxKgB
         UBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaa5adZfXzcevdHd3k/X1OcdHtInRpu4rrnRwbD0nYf5lh+UmYOXon4Gb57bOqdnRgAgQcr01Upg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD54Zh/6uxKnUnFCNqz9iWcIXTq1vaiZclYHtr2dXaiggnRqht
	fW2BriWap78Pn3a+V1GvhRXs2s6cSJgO0oxRhPajiAfv4FYJLDODkTKIhUYD+En6D3SxI6Vn7QF
	cYt4PsPM9rrqCP2GKE0tQT0YCr2ROiY+Rs09/WjcOd4I4DmXCPgKjCA2tF6/1udxMBvQOMg==
X-Gm-Gg: ASbGncvUjQncyk/Yx1WjkP/ykkGxUam5RXsIVBc4w1lRkAVQV8ClBSbVMzbb4nqNoLU
	3vl4zy8KGuEayIwv4au8fAzLJJmkbxmMPdL2k0HIUA/8rYgJaJ+x9iR281XrBTEpwDfjJARJVQ5
	OpfkojFFY924qLipoRO/Vp8Qh3dL++4Nfxt0jpbJ7kLvHtLWmoUlceVF31SRDO1qEmiSxHhkYan
	faAP+Oa5ZrXD5536u+8SmVjdahnjiTBplB4XDeWXPYLE0ko8F3bIFEOjzuZfgbGt18NG/qn2/wG
	lRFd8DSNYPAfiv+w9wA/VNXNDKTBB4eF2VKuJwYB2HvWI+TF5kA3WzHaklpoUJxioOgpY2BH7kC
	EMY0=
X-Received: by 2002:a17:90b:3b45:b0:31e:ff94:3fa0 with SMTP id 98e67ed59e1d1-321161d6078mr11744943a91.6.1754283979757;
        Sun, 03 Aug 2025 22:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGWeHm4SZUpqc8ezy4PspRdFA/54Q0jokeRMGEtdsPupU2NKwBbTJIGQaIB1gJqcWLAo0wvw==
X-Received: by 2002:a17:90b:3b45:b0:31e:ff94:3fa0 with SMTP id 98e67ed59e1d1-321161d6078mr11744914a91.6.1754283979290;
        Sun, 03 Aug 2025 22:06:19 -0700 (PDT)
Received: from e0cec1fbb194.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm99705135ad.7.2025.08.03.22.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:06:18 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] Add OSM L3 provider support on QCS615 SoC
Date: Mon,  4 Aug 2025 05:05:40 +0000
Message-ID: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X5xc3CRxX4Aj4eIRLZXHZ8uX8o2VP8Om
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=68903fcc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VdEDuztqGucW-MqrkSEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyMyBTYWx0ZWRfXyaqgGJfnw3Jd
 6ldXQBXnqv6WmrX2R/hqfXk0Ec5jKqC9nrZfb99O3+ZwFeRnMN+I6TO7+gPz6FdF0UL94vmdLYs
 VISI5T0/+Hu1ezHmEJlPoYGzarwDz1OP3wU/OreH164LgXV1k3fnXCsQV9HPdF1pQnmt2WpdGpU
 hn3HWM6+z5u3gH/2UMtufpi0BgWAXWJzCj0W/D1hlEK5XIOFlq+F34qqsBU+Lue0zey5CNiGwcO
 vXWIPSqTvslWBoAqgbdj4k02eJI/wOWtain8x9UM6KbxYeCTuH8A9RueCl7mLxJBWkLJFdo8iBK
 jxt55Ym37pKo4BKyWjFbTAmMTvuMPmgANlSMKnulO4ADDqTJrdvyLo+zg0I92mXDO169oV0dukO
 75pZ0GN+ZLX/YtkmZldROw4DUceKn85asWtbkDky4y4PZ/ayx51k/aFqph4tCy28t/OTKOIf
X-Proofpoint-GUID: X5xc3CRxX4Aj4eIRLZXHZ8uX8o2VP8Om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040023

Add Operation State Manager (OSM) L3 scaling support on QCS615 SoC.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
  arm64: dts: qcom: qcs615: Add OSM l3 interconnect provider node and
    CPU OPP tables to scale DDR/L3

 .../bindings/interconnect/qcom,osm-l3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/sm6150.dtsi          | 148 ++++++++++++++++++
 2 files changed, 153 insertions(+)

-- 
2.43.0


