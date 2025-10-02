Return-Path: <linux-pm+bounces-35663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E9BB35BD
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F06188DD3E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEDE2FF649;
	Thu,  2 Oct 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6C5zS08"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C012FE56E
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395191; cv=none; b=egW1hKzxiDe97Z6M2CaEE1mCjeVbAUBGayvAiJqP789Y8uOHxnTkBwtNc7iwn+je3fqtLpNsGed+DNy3ST4AeUS2Xm1uBwzF7NbG/SNO/O7Vd4sLFs9bhFHbiGxL8KPJ8YqAjq1rdoIUERbCe13WEYygmI/WvcD3cIBAbq4f2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395191; c=relaxed/simple;
	bh=uC/+ZsvsvyQJAsa3f1YZ1SlG+IQTK89rfp7MY4WalD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW3oVPoTZ6VceeXYeEWzn+QX/x3Vh8S2NXFpqHMln7RrrSFG50L5RSWj/GxnFZuNuWrpIkf1ERoICIOpKIL3ev6PFAWN/wIki/z97ozM6xWnp4ScJTRII/t/uTwd+4XF8x3mCNgmPY707EXfCpeG3yQwxZOCjTiypHSA5c/Nu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6C5zS08; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic30t012307
	for <linux-pm@vger.kernel.org>; Thu, 2 Oct 2025 08:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BHDP8acxmTfrTc74mGbEFI0EKFoMUUkCRGJ8p0QKX4A=; b=g6C5zS08/lBWHPyT
	Xsre7COafcPH38dV0jjf/Eu3biHSK3ceZBg3yKyjXGzZyBaDpvrC8FtIvEBqdBMb
	UJkX2hnmK0IFC+cnr0wBvaO4JZ3IZEfkNL5zl98pl4KGVY3dN4Yisp5dcWQByhwr
	0S5qG/e1J0q28uvrO06WsJBX2vcQuTyCzAyiYngI4CF/PRjLDmv2qNp2iCEzfr8R
	1eflE77CsRElCGslWf+YORDOg42hvE+Rskf8u4uiRZceuDGA1Uj4W0hzDxdayqCd
	d717hCrgxkxAZUF7L/BVW7qB7OmTGvx2mPtwv7lTX8eqnyYR0RIaC4ARXfxd8x8o
	2VbFUA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tye9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 08:53:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dd6887656cso25773431cf.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 01:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395188; x=1759999988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHDP8acxmTfrTc74mGbEFI0EKFoMUUkCRGJ8p0QKX4A=;
        b=T4aJfRBDQRWz4eOy4v3PIuHVDVmh5NbL8KUOQq+ht4ea48rveNFClnFpoWOJEnA9OW
         g6lbhhz0yXsU7IweZy7Pl54bXW20QG6fM8oMGiO7NqzQnUHBOBwG5XH/oEDjTvWua6DZ
         lIGzpEXaCaB1R8ok3m2drRA3YLejufaEYs+auVGITukczHke7XOb1QfGybL4QRC9kc1N
         a4qHahpTEmrsmeBtMrB9FeCvqxp4CuLAg8TV6ZPCRkRdpZet8Gj2Sc+3lNqNlAUNs4r7
         BbEFZyjj6+mVGOcfsxtw3qDZ5fgLj/2lZ7gTujArc4VYRcl7uMq2ENAWmAnt1oICEl/X
         kpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUsv4GBG5bykn8dNV9/fIOl6D4zDlR6AQU86EybSl0Ol3kuTbKMA7TYywtHU9/fpLLidFlCEiF6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAE7SiEj+BdUZLLqydN6YSJYUWDuOePPgbyF1bDMM8rdMwxjLF
	NVwwkD8P6Py9hEPqe79qlsmNvxd83cmDFeb/n7sfYjZmHfgYrqxqrl/aoAJwS6Zxmr5zQmK7ozH
	wkXhzOAJA2fSIJGLOhtMuYv8QZ5qq5pOyYmV8V/DeBfkXXsDP9pWBhxQ7OcJMNw==
X-Gm-Gg: ASbGncuou1tJan8OtiV+12oBcaHyB3tdJDFcM0Dzw8gd3BXbZsDz/oXILDDZ9p308M+
	0m5g8pwtvn36DyV/LTgEIoloDUCpffHZxteLfuRPbA7uSkHJVXRE+TKG/CBm8b1dQkjAdfqNa8w
	+woXDMtkB3i0rUZwMBP9xxBnJL0Kc+7p2+L8fbp0rewdDxRQ2Y/Tz8y1zywOICYFRHPH+uJQ4G6
	c8N9AGW7KqsEKGxChCkqWbXyA/eIQxxS7khZ64gk1FF4zpz7kLpJuKPdEO+XAY13uZCcAue9DHW
	OM6D1UcZD7+J6WOrs9qJS5EXse51vkxE9s+Rpa1+xtEieBbxRy43sUW6lLvau8MRbdNfg/mxi8y
	ainKXO2N/BOaJrL2WXhjK3eX/lj8OrUWCAyd0SQc7KrOWbEi7Nh3/Ou/7dQ==
X-Received: by 2002:a05:622a:2507:b0:4b3:2dc:8b84 with SMTP id d75a77b69052e-4e41e72fe8dmr85908011cf.47.1759395187596;
        Thu, 02 Oct 2025 01:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaMDSbQXT/X5ft+mztpjyq4k0xqItpkqVhNpbUiMPK3YK4uqfrfHN/vZGFwSso7xrqXEKnFg==
X-Received: by 2002:a05:622a:2507:b0:4b3:2dc:8b84 with SMTP id d75a77b69052e-4e41e72fe8dmr85907681cf.47.1759395186973;
        Thu, 02 Oct 2025 01:53:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba3124bbsm5207351fa.27.2025.10.02.01.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:53:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 02 Oct 2025 11:53:01 +0300
Subject: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uC/+ZsvsvyQJAsa3f1YZ1SlG+IQTK89rfp7MY4WalD0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo3j1sfG2EgDuJQwjqi7G+27lREBjPBYAO2A2jU
 6SVN+meemOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaN49bAAKCRCLPIo+Aiko
 1aLJB/0S8lLBTmGEQl6m62L6x48MDBiCoDpduHypZB2Z7eVJNEJeB1lQKvwio3a3n5ACKyqKpEE
 h7pdqDX7kUaMYu8npni1m6pYUlEYKwVZKZOvJuXrRvi97uWmGFA3gOdpZyuvPLmWl+tVdR9o+QM
 ssTn+co0VP6AkqWdGR2FjV6JNCUfRaQrlJhBPZB48xImF/S4VFsRKJmzTR9dJALNTCEn1mLy5nS
 frBIqx60IY8gPWvRFwwrGdnvGw7sGDwkEoecy0UkS0nfAOD5MQJqjnvFRbWRHLrsfr+/RnhO8U7
 wBRpOVXLqc4um+5T7pRJ4WpxpJFIZPbuTDSoVKfSsXoi+Vay
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX9ihha6X4LHl5
 2Y+pPYdg4qkdmCVZ1otdkUvlEH7LTH5/TWWyNQhOg+cIwYPPJ1JGf4jn9jX8MQ6xeO+Shju/O4B
 UII0mgbefHqwTCJ2NOxSd7F62Y6U1VC0eWrn/fIzEfl0Mj6t9qc4pWsJiXkQ0UGJce27+FtJQlb
 ozqxydr5rpsMbyHp1RDjCq0wiOXLSGzdZrnM8rLulV0N1tKNBwijVcmeI7/+C1AuqL2GtvFR12T
 962/na34cEY9Uf7VxW8v+Kc8KnD+iqwgYEhJp3fl/njMbCmqUU2dnHopJ74jo4wN/U/bhYKAUUT
 Yd7B31XabuMxAfVRtNIiZXDOas7MdwH630uZ9y6ZCZmXoRRhvpJP21Si1EQiW/SYc+8oeq4VIS/
 jyFMcgY2TbmZIUaQTOuu7hNoqChtBw==
X-Proofpoint-GUID: ASCPNXpB8ONNHIA7PJiBpsNEiqqDKfl6
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68de3d74 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CwT6ynrRfNtyUp4jFLEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ASCPNXpB8ONNHIA7PJiBpsNEiqqDKfl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

Add the missing interconnects to the USB2 host. The Fixes tag points to
the commit which broke probing of the USB host on that platform.

Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---
Note: without the previous patch applying this one can result in the
kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
applying them through the same tree in order to make sure that the tree
is not broken (or using an immutable tag for the icc commit).
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c75b522f6eba66afeb71be5d81624183641bde71..33608b1d7d060b0a614357929eb3404bab46ecb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3496,6 +3496,9 @@ usb2: usb@76f8800 {
 					  <&gcc GCC_USB20_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <60000000>;
 
+			interconnects = <&pnoc MASTER_USB_HS &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &pnoc SLAVE_USB_HS>;
+			interconnect-names = "usb-ddr", "apps-usb";
 			power-domains = <&gcc USB30_GDSC>;
 			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";

-- 
2.47.3


