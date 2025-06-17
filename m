Return-Path: <linux-pm+bounces-28875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F584ADC5BE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8C71898428
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34535292B40;
	Tue, 17 Jun 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePN/lwWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A00292B34
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151246; cv=none; b=Q3xs0s2OPWb8Bsi+vEM8OJxrYz19aGireCipFW4bWTdmybY0YN96Rld+Npp484XqHMRnSX9HdVT0S4S13VZCD3sB1I7qSHkU71sABr1IqfeikAcCBfZe2xC0GNPhmgE/gn4u0fD0Gd13Lc/0a+LQKyA2S5neiR+80mrutd8YOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151246; c=relaxed/simple;
	bh=HpCmu2Xxf2CKasxkFlZBU3mNBTm4LYqEUU50Qj7bYcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5kpiqZcgG6SoblYCOS/2Pik3NK751ALXEk33rdVymh7Q+I4AnJ/SSat33UbGFcUwAbS4KGoCCKj+ihGHyCGLiaP5+7oT3ETNOgOL86GF8c34kp9zpQpkFCFkFLjmE8Rkf0DoFK8UbF58L2wkzISCqGXaMWSpRUmniF9yt5UMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePN/lwWM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H751Uf002459
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v8VxgZncMLU
	vweLJo/cjubLjIJAD9fPEBEdpFY84mSg=; b=ePN/lwWM+0vp1Sjida6wPoRuxmP
	HlfzCkLq4oNI37xybN080wnV5zG9jmOtYKyeKkjw8xMvPOpmx+NZP6EY11BaaU4y
	MZyuuxHxsxlMWfyPPUKWiCUHep8MwhUtp72hGESkT/9b/RKh6AsUjM7sADh9tvnM
	fi6TOceDMlFr49iwCyZv4qmJ3nq8/ZX2V7zrX9K1s+DJh2cIgQuuZFLthquJsyIS
	9SfC6BtBjPvI+sTayGmIwBUKqItza0P3X/VmQrMKs61EmibszUG+VhV/x3OMGCvf
	ZYsybNqPTLAkErosO3qsVsLDdLKw+cM6w4WYsqwChK9/bfIYlJ/MGh7Dq5Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag233s07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2358de17665so46330995ad.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 02:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151242; x=1750756042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8VxgZncMLUvweLJo/cjubLjIJAD9fPEBEdpFY84mSg=;
        b=PUJVopcak2R3lvYmaSP6pY3YAbX3CI9aB9RwqUPPOvwdfSskzfQTY/CrTP4iA99tJg
         6cBx6+CH9uTYWSHoZv0CFYRs0e/YD6a4LSfGU3j9ndgxoqkRQkvS9oqoACfVRigYx9s9
         Q+MGvsVG4yMT0bYXzcAadR0ZcGOd94iScPcPRZ+0YlKNDk41S44ra0RT4D34g06uIL/o
         LnhD+xEu6/CkhttjQnl8XxKBk4x7YyQre3owXWbSUpAFTYhJC24PUFDrIiF4z8XcPJzm
         5dbzrg2uLxZ72nn2kVGfWViFIDMzjw6HM7yZscSn4tXsEK3RU/ft+LbNcy3HI+k4IR5J
         YqBg==
X-Forwarded-Encrypted: i=1; AJvYcCXF0LH64MP3dRelm84KIUKqZu8nf9ldopx9qq/ppc8n0dhyAQNTohoNIGJQ/gFBKSGWvGwle0A3kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLmkFKRK5VNVBfO17qZciFotr/6Iy+1Zv1Rlqxn2PLDcIIusJ
	h5JjSiyPhviNC9GqhXFCFtcHM8Bo/2c7Ay5hhZ5yAHuy9WgZgxKlQCU3JIvjYteczqZ5s07mJpG
	TR3tvsyQh3tN2rLFw1jDzy6PuImQk7rVUiFXhf0PxfrIpfqRt+IEGgFSROA0oMarVKJVNtw==
X-Gm-Gg: ASbGncvvcQMl/XJVr6n5hl4C7m2Hl0VWPREudOQsya1d1+bWg9MtPdB0ADndcduwu0z
	f2cAisFyjHBdz2UJsfySDGpNFQG2GF/PTcz/3ZXqSSozyuetfoNqGteoa8M5GdnBF7rXixnrMSj
	kZOR8LGb/PWXjYl+4bQryk3DkRuSAerieP/FVjfamnI1FROF16KTb2urwHZD3WaKImMC61zqsvr
	u186hPzFTwqyT/RKOwO5gbcr7KXOdDIm4S5UOpGLb9pRPJc4JwNkd2zdu9+hSAxPxZVjjjn4Krk
	gto4MJOhNlYsltvKdEZqnYu8t1YLT65j+gaI5ztyQHiqqdedCD4YTDU1vruqZg==
X-Received: by 2002:a17:903:19cf:b0:234:d7b2:2ac4 with SMTP id d9443c01a7336-2366b00629cmr200740565ad.17.1750151241752;
        Tue, 17 Jun 2025 02:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQFcFoHfGO2OG62bjBmAIXOgg3ajRa+GMsZLmM5oo1I6OCeOlHJ67+7+KcYPcabd8OdkgVsg==
X-Received: by 2002:a17:903:19cf:b0:234:d7b2:2ac4 with SMTP id d9443c01a7336-2366b00629cmr200739995ad.17.1750151241328;
        Tue, 17 Jun 2025 02:07:21 -0700 (PDT)
Received: from cb9a88ed5d41.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bdb39bsm10017370a91.20.2025.06.17.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:07:21 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: qcom: qcs8300: Add EPSS l3 interconnect provider node
Date: Tue, 17 Jun 2025 09:06:51 +0000
Message-ID: <20250617090651.55-4-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gnL20bkk9zlfQOCXM00p9b-X0AOSO-VH
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=6851304b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=pcgX-mRZKd7nGorDqcQA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA3MyBTYWx0ZWRfX78Z/ByQBUDvL
 mJ/5lyDDZJwYnbcJcDF0v5jTQOros7adZ5QozGbWCfoOsUM6KCVq6UbJHaVBc/5UvFysp94a7V6
 6Ts1LIwingv3rKAf12wVscwvoCxlz+cwnSs4mcb0E5ZM4Izrk512wbzdojaLTyftD/D8mmCMjq1
 xcHdpxw/NlbLf/gE679GtjhQL05xuaGV77JVbPFIeBVV1pvDCFX84+xGyCkm3VWZZb7DJexVJBZ
 0dqTwo5pi6hctjYEwjTbxWaCLK3fi7gdY1npivQLISLAu1yOA7b3m2Dpgg5PvOGuEwVFNV18UaT
 OpHnAbt/3PYZtouRRblCW4285X/ei42n25hUrv3nY9ijExy6g2aQA4oE+En5aPbXxXGyl1Fvawm
 dOsWrNTd8sYZ6AYoa6+5G8mxR8nE5E3FFkcEGzHruz34QL7Cw1vY/EIXIdvdkSx4B7JrDmzO
X-Proofpoint-GUID: gnL20bkk9zlfQOCXM00p9b-X0AOSO-VH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170073

Add Epoch Subsystem (EPSS) L3 interconnect provider node for QCS8300 SoC.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 7ada029c32c1..e056b3af21d5 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -5433,6 +5434,14 @@ rpmhpd_opp_turbo_l1: opp-9 {
 			};
 		};
 
+		epss_l3_cl0: interconnect@18590000 {
+			compatible = "qcom,qcs8300-epss-l3", "qcom,epss-l3";
+				reg = <0x0 0x18590000 0x0 0x1000>;
+				clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+				clock-names = "xo", "alternate";
+				#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@18591000 {
 			compatible = "qcom,qcs8300-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0x0 0x18591000 0x0 0x1000>,
@@ -5455,6 +5464,14 @@ cpufreq_hw: cpufreq@18591000 {
 			#freq-domain-cells = <1>;
 		};
 
+		epss_l3_cl1: interconnect@18592000 {
+			compatible = "qcom,qcs8300-epss-l3", "qcom,epss-l3";
+				reg = <0x0 0x18592000 0x0 0x1000>;
+				clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+				clock-names = "xo", "alternate";
+				#interconnect-cells = <1>;
+		};
+
 		remoteproc_gpdsp: remoteproc@20c00000 {
 			compatible = "qcom,qcs8300-gpdsp-pas", "qcom,sa8775p-gpdsp0-pas";
 			reg = <0x0 0x20c00000 0x0 0x10000>;
-- 
2.43.0


