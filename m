Return-Path: <linux-pm+bounces-39424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38CCB47DB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 02:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB953043F49
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 01:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6852C275870;
	Thu, 11 Dec 2025 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cL0bxpAI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ybxc+gtj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CE272813
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417986; cv=none; b=N/iMHvIniyM5gAFbTGgNC0TisN/Z0RYbDQAvbk7zcE3e4y0qFPGmLOa0jDBLWc0d5ECuYBakZsnN4KCoN4iI4JjIvEebBXau2JSJcxHkyWV+pUkf8HQ2Idko3ZCTf9EuKRvElXQbXVSACExEzZY7IMyZq2Rh/NdfnHelzM13XrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417986; c=relaxed/simple;
	bh=mI8OHz1a+H+1J1OvBA9S8STtqd7mREjQc8uhNszk4wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psUmyflbpvxJXnOMxz99IlOyk77tXKzsGR4TGv3xSgY4e9tBGTKqVduuJb1/Xaa4pVU5h+bUuednNhjEKRFvxamRi1mJvF7QRzqNJNIGZBwz7WRx5elfsZTiRp39XYMXrx3UCmGm+bD4m8pc5MjGxPM6scRZ4QOk60Nj0AeIvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cL0bxpAI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ybxc+gtj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB1GpTw3927310
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 01:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5gXVpspFZ0ce69k6KqGIee7CnwdYFvfJN28a2Y4i1qY=; b=cL0bxpAImUcJ9C8Y
	OnizvQ79khoHGu468MGYnAPCjRgfO6SOGKkYaJvU+tldUuD3CRa2kAB9wUr425vt
	tTYwMnd9M/33uAmdLmDryr1JI91atsbdlt+6hhE85xntgFsD2pTWr5J12mTzcBBn
	DjZqpp72yG9rlO+/uiGSGW9jRqLzk0XFaoCB0GO+xf+c+7lQOBikNQzJFcagH/eW
	9H9rE575eipXmm/zamjxAgTDMdawvWY3eZFz8XdmzRQPEDRx1bf5tMhBg6GMVdH1
	TkzzDVAjD6fw5DpbBgTJSZOZBod8D/2MdqKqonCLFA4f4+ZOSXokQaXI2OregkhV
	xt6vtQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aym5802qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 01:53:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee09211413so10854711cf.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 17:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765417983; x=1766022783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gXVpspFZ0ce69k6KqGIee7CnwdYFvfJN28a2Y4i1qY=;
        b=Ybxc+gtjkYzTfRqROswv7dPc8K6jscXcH8GtyifMc1CYdMG4ZqT/hwJtQDkD5M5oTi
         0f9bxLXRVPR5OU/zYa0zkrWUp/hvSWTwcXWLK4qdOBvZgSAhidIBRC2kmILDVTRnlQcc
         mt9Al4dUEfqq9jCAeE85nFiPt4wFgHLC+dNiXeqQ3k2CcMwq3RgjDSMftKQgwuAg5k8p
         8EJK8Lrxg+0vgJYyEXpEYd6jwP4sKMXBcOVbOt9aR1eTScYPhnlCx2WY+WaiPgsi7Vm8
         L65uLkKrMeCfrUoGXSlVDP6HHGXPMXy59veG1/QAZVK8uii4KTVfDMf0w70hgynD7g+1
         aMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765417983; x=1766022783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gXVpspFZ0ce69k6KqGIee7CnwdYFvfJN28a2Y4i1qY=;
        b=AJ4e5Crij8Dn0ZM4WTsoUUZ+N+c6gVjGPw7hBpviW0H7+K+iYAb5EnAhf6QJb3ThHk
         v5T08ckdWP9NqT8jDedUAqbsrvAivFPJHsSORd2SeoDNzdXGybEREG2RaUW8oxGYczbR
         wTJqdjgfNDXq0BWlipCTxnSBPum2pHc7E1n8KOC7awCLCLRwgYqKdu/URH8mlZJ7if8U
         a7mth/r040AVxm9AmVA9MHZJAUZ35cqqK62spDnsE89+3SumqkzeOqTvZps3tjvWAU2g
         TF07wQf6VVyhiCSIFwDPhIhvoiFvVVhVph2kY9fubvc2VDsJfkUXkG9XK9dkIo7Jpbv8
         EnBg==
X-Forwarded-Encrypted: i=1; AJvYcCUkfH+mMzTOYWHbd99t/TwUkFWyo/cTuAp54kKnXuPCEvualTQdmqqlTaIcma5x8BgI1E4s20+gdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX32dATcQ8riyeEG8ZHf2cok4k+Sa8zs2RnoKA/fgLH4Sw0Lb6
	dXceJQv5VG0xLa1wb4o01VhxL2CzQ3WZEx5cognvg+jqqAFVZ23VojwEzSB1BKKefbfRo7Xi3jY
	XRy8Nsam73OTr0xFs9Accly0WZ7qrrPtHH22prVYvWc2kml+NYOybvZapFO9Vmw==
X-Gm-Gg: ASbGnctpCLglNVpAgUo1vSMm916ahT1zfcfwtFrCSU2XD1fPXgfE9+HTHGRyDp9P/sq
	/ouiHIJPpTAXtrhU44XSewrFMVMv1y6fxmQ7beEU/5Cn3aZ2xz1cnF18hTzQk8PWFhj/mDpjXUv
	H1sPmGioK2lagSvo3IAT5e1RSw5Fmbjwjw9n+/66/g4Xb6F3+bWGZNifMEAUKKPoYSDxcqFltYW
	Yae0YVwjr4+09tjpvhP6Jxf/fRIRDrDjDHlqRXEmxWJYtRhiWUojID97JDlyBHhsqYMVenq/63J
	pwUZc8i4tBXwIIpmLsbcdzwkWUoBgTzmI/i05JESeUS6F2SG1TIAspnav588PsWZPYbzQq0b2ik
	0RYrzY7mbzGVwUUiFxe5T7ddll0D0OYvW9eQlUPBvlodxeaASfDvB/wJ5MCr6JOpQNMNFunP/uG
	2A7JDzF4QYMJXOq/StTA6Uu50=
X-Received: by 2002:a05:622a:7e0e:b0:4f1:b9b3:9c2c with SMTP id d75a77b69052e-4f1b9b3a24dmr23944041cf.24.1765417982706;
        Wed, 10 Dec 2025 17:53:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl86fqSultrWYGOxYBjlM9DzZ7sPvLXB4dJeS/cgnQ1nBs2+206U39R5QGLp8lXu/aBMEC7w==
X-Received: by 2002:a05:622a:7e0e:b0:4f1:b9b3:9c2c with SMTP id d75a77b69052e-4f1b9b3a24dmr23943871cf.24.1765417982058;
        Wed, 10 Dec 2025 17:53:02 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f95416sm393252e87.57.2025.12.10.17.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 17:53:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 11 Dec 2025 03:52:53 +0200
Subject: [PATCH v2 2/3] ARM: dts: qcom: dts: switch to RPMPD_* indices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-rework-rpmhpd-rpmpd-v2-2-a5ec4028129f@oss.qualcomm.com>
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mI8OHz1a+H+1J1OvBA9S8STtqd7mREjQc8uhNszk4wc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpOiP0bpb7ioUP3xiUxp8vodF2+RgbCAX8m/XvZ
 ezkj5Ntr2yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaToj9AAKCRCLPIo+Aiko
 1Z/7CACVhcCnufNdrghAP8OyFwikc2v1/RyWZzl0hoaVhVa4ynzTVpM8nEcM+BkHxIZUh+K7g5l
 L1cbqD2zSO5XSJjUn7m/0CtcNv5602sF5kz1VjCpgHZkuKbN5rxnMZjUmp/1OE3HTo9ndPyRyQ6
 3SqAyzAUMhhYs8StSNhOTamUorTtnqy91onNfEVfPyG0msXN36b7KE2xUBp5P8fY4E5aXDWBtF1
 SB9pQyuO4O2K3opJ3CatG/E12Orv26UFoNn3wgGzmP239XZ2wj5k4vlQ6vU35+wQE896hm1/bIg
 bNXFhnuwS0taa9mBUN4hDmiZiM11cymTb9ENZxGrTqPCbwKN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: RV4HsQPA-0dfRYkAdPpT0v1-Rovs4aMV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAxMSBTYWx0ZWRfX5APBOiRjwzcz
 jAbuV1wPeQ4qUdtGy6awYLGQU9Yd7te5XlKhcjVN5gB94FSmmyD6FqyNc/z0uJ6pyBfvHtvGQUt
 ZDELuu7HKDDbxSLS+3vLS/zkeJW5bIeZ7yyRPJ8T86ttNa11pirWqalIFsIZnQU7XSj5nxPJq0t
 b1eDqtc4mg7uJuWRpbRMEeHLUOOi9codVkXW6qamW+TRlODrRcmbZAXK8rL16gDMq5eZ1XX7UyP
 jEJWaMd8C4M7MmqV3MfigdJ+3PNjdl8IsDMNY9iiv7iIqFLloOnT0u7/WOXw5ZYJNJkMsOAcWxG
 ZIxQafs36sxwye4//9BzeSla5z4q/E+uGgOXjjBqoVX4JhtYWUEUDmMPkIcjtpZJaKcVXDzuj0S
 cJF/0JDTbieVUZFL61IMdkEHepA93g==
X-Authority-Analysis: v=2.4 cv=FYU6BZ+6 c=1 sm=1 tr=0 ts=693a23ff cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bH1gikAX_8Q3Q33Jyh4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: RV4HsQPA-0dfRYkAdPpT0v1-Rovs4aMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110011

Use generic RPMPD_* defines for power domain instead of using
platform-specific defines.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 51a7a3fb36d8..bcf14a3b13a1 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -959,7 +959,7 @@ modem: remoteproc@fc880000 {
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";
 
-			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			qcom,ext-bhs-reg = <&tcsr_regs_1 0x194>;
@@ -1372,7 +1372,7 @@ adsp: remoteproc@fe200000 {
 					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;

-- 
2.47.3


