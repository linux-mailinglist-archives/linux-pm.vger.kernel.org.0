Return-Path: <linux-pm+bounces-35612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1231BBAF6D2
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2554A4AA1
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558EF275B09;
	Wed,  1 Oct 2025 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NoJtlIu2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1E274B57
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304065; cv=none; b=NmZZp6Slft+yG/J5WckQL4DWaaiuyYpkCKaIUTMle5Aj+s5LWK+6KP9ziHMTMmd1T+jWGh2NC0P4mmd9jbB69HpEijtUfJmjerDtNBiOVwp46j+4hp541DfUdnpKFLPNV+FnxY7Xi2x+1+A7tR0wfrkMsBIeuD+TUC6svYpgVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304065; c=relaxed/simple;
	bh=Rf4H9TynzVt1Lyq4dqEiXIdj3OavGVbmXN2dPpfuLM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PId1Q+niNcLegYSgS5NG17rVr1xq7wOTJt3vt/aqSxKt1s9PttvRCueMQy7//J0JxBZ6eIQWHLUF8MoZJNwvpQ4H+kxZ0LfXocKHlDtKX9dW85t2ZWSPIPLDM3sP9ZXPfQLRYxoZueqkeGhpaCBiqS/EkGpVbCVGgYecRSd81ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NoJtlIu2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULoJPb030669
	for <linux-pm@vger.kernel.org>; Wed, 1 Oct 2025 07:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=NpLFZShKKc/dLH3/RKojdQgBbxZSezqyQ9PQZX4YslE=; b=No
	JtlIu2wo3OqBgbn6xPeBznl3D2DVkXG6q0ylu1eu3nsZsprqayIkbLDco4aO6GjH
	j25ordIWWrcN5J/dpz5q/UpIYpWybp943rGkl/Gg6D8Y3ErhXIqz4Vhg3BCOFjLs
	FzV3rg/1f5TyXuv0JRARVLP2IGp71p/uuLMLvEKjcpI0n00yNH7c+2kRuRj/H0I7
	iLJfV7qHOBkGvGi936qklEwpAUcOqoFNJ1SbG8saKzPbz8kvsJPXcFhEwWHJuzRm
	Wfm/Yi7khtLLN0hiynpU+zzs65+J1poYBtqBvXjV+4Fn5wB3w9ShzQHgdcQcnTYn
	DtZfS39PfVGtrajjUHMQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdkfn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 07:34:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-334b0876195so7234402a91.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 00:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759304062; x=1759908862;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpLFZShKKc/dLH3/RKojdQgBbxZSezqyQ9PQZX4YslE=;
        b=d0HF65c7bIiVCMaRJFcibUbnE7d/jdLEyM3VENA/QKelS0bVvekmiVspJZkZbglHGu
         QVAw9B6XEuA7Hjwm781sYtYv7T4c6J0UW4oRH3CtGp3sbF6hqgyXTrl1AtCC7CKGrvhE
         3QIiDkET2RgMxGXWTaS9E2t+JAuN0Lg/Pojt77kL3w2ZZ+mSeUEEEliHQUDeYc5PPpoq
         LO6IuPSgzv/ZWwP8NBXCNFqPvD1Edre8IQwg7Cr1lQXVg9GZ9+bjGLBb55cDqhslUj/Q
         qmrzRYEOJiiaU892ujuaGVaRXh83cUVtcZnzprKOhcgG1wdgtqkTtO+HRqPHAp0qUlTB
         xIsA==
X-Forwarded-Encrypted: i=1; AJvYcCVlpfcjR1xReBfreU4YN5XH7LdwvfJim88+2MrGWZwNY9pBePGbwlRyiapozeiGZidlCTz6aqRQGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqFFCl61dy047S3R/J7hrXoCpuS9tdswocci1juBCIWb4fapd
	lMMF4SO002urFXL42H64SSKbRcimrXditP94hVR2HiCIK61yyKqEtS15PRmTPCno4CSl7D8bxkz
	YEO+FGSwj5TLH65g5c/+kNvnTUcZ/mNVJSnpxvQWTsh9FxJTMUTx07KOGfU/VxA==
X-Gm-Gg: ASbGnctQYMnzxNlq4FhPeRGpCiyaWPun0JnDCDPuAeQ6ijuf8oedD5LVDb+SqTagplH
	j0yHJpThdVPrKX+lfp7Wu8vW1VCxSQ3mjcmNyjlX5h8Qpi2t+SLE2Co6DSiaR7NxR3ku1DCpaL/
	CmwTcqIkUpbx5d7rn6xwvI/kZUQsgiL0WrDoNRH6mtHABelL503KGtlR9h0spnJJNcI1Hc82Hhw
	Bt0GoMgn676qdfUE6A0RmrNQOQsQd3lRZlvtl6HR2jDtixSojRas+8IQC10vWbk/Fy0Z7syUNoq
	ijnrj3HWseyRBpQnXvmt04UmXV4idUtnMlGY2OEmiOhnUDWk52FLayCEjSvVA4jqUMhtG825g37
	HDrg=
X-Received: by 2002:a17:90b:3144:b0:338:3e6f:2d63 with SMTP id 98e67ed59e1d1-339a6e28360mr2595365a91.6.1759304061944;
        Wed, 01 Oct 2025 00:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqhp5ZByqLJXN1nj/rJ75hI6VUocIQro//1ocqCgiiNl1aa2w2QssR4jg2Lxv5jlWUE0nPlw==
X-Received: by 2002:a17:90b:3144:b0:338:3e6f:2d63 with SMTP id 98e67ed59e1d1-339a6e28360mr2595329a91.6.1759304061400;
        Wed, 01 Oct 2025 00:34:21 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6effe77sm1642127a91.17.2025.10.01.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:34:20 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: sa8775p: Add reg and clocks for QoS configuration
Date: Wed,  1 Oct 2025 13:03:44 +0530
Message-Id: <20251001073344.6599-4-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: vfkE_kDCrwKidFk5yIYNtPoQCowTeWRb
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dcd97f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=BfUXBPTVPglUz1mEt9YA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: vfkE_kDCrwKidFk5yIYNtPoQCowTeWRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX/48BYaxWVlrU
 kpcQEBMQ3spg9x08SQSjYOkYCKl+EXJY4sO0dMnxr6YWFMCzi4a7IUbfpEm/Agwum67SK2OV0a7
 86pa9QXyb9raW1qnZ5szPdsEvnH0kYINEIGILYl/g9tihLZ1yynPnXnxSmP6xzMZq+z4Qvq6C1u
 Ncy/9LsSsSUlQfTR6N/JFiW3ZmqlepRZb0x5eEQKneYZrebYb5dGSepXU4Nu82zmXgOqTanD6Sb
 9UY8Gwuj1aIrLtnCtNSzIsMkXE29mVDqcQ2AUbiNiLOQ2rZCiUaNPcPF87LgOTYcvWBmhg8vViO
 F0cNeWey0bOFC46j31BBC7+7MDgCAdpbfJMGuk8fHUOR5jkR87wbIS6+6om8MDV4HNs1cD6DzgR
 lE6h2MRNai+pQ/Stt5Pnvnaerj58Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add register addresses and clocks which need to be enabled for
configuring QoS on sa8775p SoC.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 163 +++++++++++++++------------
 1 file changed, 91 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index cf685cb186ed..3a02a515af0d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -518,90 +518,18 @@
 		};
 	};
 
-	aggre1_noc: interconnect-aggre1-noc {
-		compatible = "qcom,sa8775p-aggre1-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	aggre2_noc: interconnect-aggre2-noc {
-		compatible = "qcom,sa8775p-aggre2-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
 	clk_virt: interconnect-clk-virt {
 		compatible = "qcom,sa8775p-clk-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
-	config_noc: interconnect-config-noc {
-		compatible = "qcom,sa8775p-config-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	dc_noc: interconnect-dc-noc {
-		compatible = "qcom,sa8775p-dc-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	gem_noc: interconnect-gem-noc {
-		compatible = "qcom,sa8775p-gem-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	gpdsp_anoc: interconnect-gpdsp-anoc {
-		compatible = "qcom,sa8775p-gpdsp-anoc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	lpass_ag_noc: interconnect-lpass-ag-noc {
-		compatible = "qcom,sa8775p-lpass-ag-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
 	mc_virt: interconnect-mc-virt {
 		compatible = "qcom,sa8775p-mc-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
-	mmss_noc: interconnect-mmss-noc {
-		compatible = "qcom,sa8775p-mmss-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	nspa_noc: interconnect-nspa-noc {
-		compatible = "qcom,sa8775p-nspa-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	nspb_noc: interconnect-nspb-noc {
-		compatible = "qcom,sa8775p-nspb-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	pcie_anoc: interconnect-pcie-anoc {
-		compatible = "qcom,sa8775p-pcie-anoc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	system_noc: interconnect-system-noc {
-		compatible = "qcom,sa8775p-system-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
 	/* Will be updated by the bootloader. */
 	memory@80000000 {
 		device_type = "memory";
@@ -2689,6 +2617,62 @@
 			reg = <0 0x010d2000 0 0x1000>;
 		};
 
+		config_noc: interconnect@14c0000 {
+			compatible = "qcom,sa8775p-config-noc";
+			reg = <0x0 0x014c0000 0x0 0x13080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1680000 {
+			compatible = "qcom,sa8775p-system-noc";
+			reg = <0x0 0x01680000 0x0 0x15080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16c0000 {
+			compatible = "qcom,sa8775p-aggre1-noc";
+			reg = <0x0 0x016c0000 0x0 0x18080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sa8775p-aggre2-noc";
+			reg = <0x0 0x01700000 0x0 0x1b080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_CARD_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
+		};
+
+		pcie_anoc: interconnect@1760000 {
+			compatible = "qcom,sa8775p-pcie-anoc";
+			reg = <0x0 0x01760000 0x0 0xc080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gpdsp_anoc: interconnect@1780000 {
+			compatible = "qcom,sa8775p-gpdsp-anoc";
+			reg = <0x0 0x01780000 0x0 0xe080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@17a0000 {
+			compatible = "qcom,sa8775p-mmss-noc";
+			reg = <0x0 0x017a0000 0x0 0x40000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;
@@ -2769,6 +2753,13 @@
 				 <&apps_smmu 0x481 0x00>;
 		};
 
+		lpass_ag_noc: interconnect@3c40000 {
+			compatible = "qcom,sa8775p-lpass-ag-noc";
+			reg = <0x0 0x03c40000 0x0 0x17200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ctcu@4001000 {
 			compatible = "qcom,sa8775p-ctcu";
 			reg = <0x0 0x04001000 0x0 0x1000>;
@@ -3925,6 +3916,20 @@
 			status = "disabled";
 		};
 
+		dc_noc: interconnect@90e0000 {
+			compatible = "qcom,sa8775p-dc-noc";
+			reg = <0x0 0x090e0000 0x0 0x5080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9100000 {
+			compatible = "qcom,sa8775p-gem-noc";
+			reg = <0x0 0x09100000 0x0 0xf6080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		usb_0: usb@a600000 {
 			compatible = "qcom,sa8775p-dwc3", "qcom,snps-dwc3";
 			reg = <0 0x0a600000 0 0xfc100>;
@@ -6875,6 +6880,13 @@
 			status = "disabled";
 		};
 
+		nspa_noc: interconnect@260c0000 {
+			compatible = "qcom,sa8775p-nspa-noc";
+			reg = <0x0 0x260c0000 0x0 0x16080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		remoteproc_cdsp0: remoteproc@26300000 {
 			compatible = "qcom,sa8775p-cdsp0-pas";
 			reg = <0x0 0x26300000 0x0 0x10000>;
@@ -7007,6 +7019,13 @@
 			};
 		};
 
+		nspb_noc: interconnect@2a0c0000 {
+			compatible = "qcom,sa8775p-nspb-noc";
+			reg = <0x0 0x2a0c0000 0x0 0x16080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		remoteproc_cdsp1: remoteproc@2a300000 {
 			compatible = "qcom,sa8775p-cdsp1-pas";
 			reg = <0x0 0x2A300000 0x0 0x10000>;
-- 
2.17.1


