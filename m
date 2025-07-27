Return-Path: <linux-pm+bounces-31442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B3EB13097
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA8E3BB56D
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616622AE7A;
	Sun, 27 Jul 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCssGXc/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6122A7E9
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633578; cv=none; b=Z2tiDVso1kBF3eaYi+5MOqulMTvbSguQORxNJtBKpz8ecp8KFHN7mOARVqoPOSs/B+GpZBTn+LkZaNT2TAdkU0Qx40vlwhQTrdaNz9zAGqbaqTlUlF9LLFRau3wJBNz7GODCl+rWVLnGRPNfm4WPYbqQesgOfBqcIQdyjGmzURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633578; c=relaxed/simple;
	bh=wwP0wgs37G7SIgdBXKyajalMO8uencXdkJwBMyqMQK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPkqKelXhYl1nH4ca0Fyyl2saf0R3t2cf0ML60rPJae6KQKZZsWxm748Q0veRheQqKGrkxAtxK+eN8O5Jb8XRuo1IpfFvGJ0XLjEsEvfrllzP/DC09w570n/wI2khaw88znvjRvx7qPETSED8hIgBw8Sjq+wj+grPMCRLBmbUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCssGXc/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RDlnXV031378
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	751t52RdbCcwhdqGfw2MHgsiZQ8ax24R2DVj0BioALo=; b=YCssGXc/+PcbODIr
	BXsd8GOGDMLCWgs7k6oqWgd/Mt+EYW4PYdHwCAC51JM3WXsGly0s2Xl2SWEQlsD7
	m062UagyoNwxlvT8cnTgO6jhxwArBz5Asuazzpj2LFiV7e7jZ16mjdXVtwlyMAgO
	sHxoKGuNl6xKDsPftS0vRgRwrXBlNxRw8kh+8II88bxIpWrzYXZL2AhLGC7kQY4q
	zEaj9iFyW0FuFbmofdYOCoRruS7FpS2RQ4w3tSrXqAeWbI4rnS9eivL1F5DsHRn/
	UC9VyBKexA++NL1WOE+uRXRcZyxKDoKkIsb/TvWyeWIPDym9Ni7FCpygFHHQ4AfJ
	D/xjQw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbktb8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:26:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23ff063d087so5623395ad.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 09:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633572; x=1754238372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=751t52RdbCcwhdqGfw2MHgsiZQ8ax24R2DVj0BioALo=;
        b=a7qsFlM7xYFedtnfL1i4HcaVtiaQvXezJ2d224D/7C9BUSZWC/Us80lkTcO7EyuxR1
         k+85W9Jy+YIdc8tr6vLg9S/mqLIXYpSH459aKSPKRZAwpkyKxx7gXqhBChv9f6dYK4Wv
         lURJNXKztuZ+t1U8kc2kopkbhsLrdnC60p88acrKe3Vr0VUnSPalrK5HgrMz0y5BoO8C
         pA1/87C3R+qlbcPIZncgXvrOxkyGyAeq95sH9L25MLSCwhepB6XEqd+OhA7M+vvISX96
         antEV7c0CVhIVsQA6rRwzjtrKhaQGGAhfAzZRwg5C/8nn1TCt4CEH6gpvsp+i5rImPKE
         hy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWUtX6dXG+35sWijx+QfULUx64DNKxulRVi5HgdyVtXhYRuRWUimXHjmaTCAInX9ojdsGqikcQjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V8ylyKC9JqeyHKCA8ADMx7x8a5OuSVCIOEGeLgBKIpG9vcN7
	8lVue3/t4gFPiR6JXxLwtjvIUHnPPoeoQ7p8b+9Gm6RTJ5u/q3GUDqX8mXjMuPMozuUKwPNXdPw
	TWQBS5JU2UbaBK8wLD83saGUcyFZETOMmyGqQR6zVhFGOkBmf7xufxRsr7fiDBw==
X-Gm-Gg: ASbGncvL4oSbe4E6z6PZxdcB3nu+sAC5fc0E2pQGV0tkOw6BWp4PT3w8OVXNbTblobK
	v1eMq9aFZ0lSmrDvbouLghq9fOrMv2C53v/Mm9bHcYPcRhiouc+9JW1LFAXhsvbEbDsJmY0EqUF
	1qHvAlHUIRFVYIY3Vj05ufaJLjTjYpKhhEDpzBMsaNMlYNcowk0wqxupvMOle2v+HrnXumFG0SG
	63JFjBBz4HKAF8gAXSUbU34Jk0RPy89PD3Q61fh00QL4n8A5J8aIDIlxZtS196SOgPrfQNRsruj
	2GFXL80d+890IsQqvZWOPDh1elLPZMDO3QXueHxrfBF0AJwJaUqYQH01Qi7u4iPB5EDCjnV97Y9
	b
X-Received: by 2002:a17:902:ca8d:b0:240:35ae:506d with SMTP id d9443c01a7336-24035ae51demr1133665ad.35.1753633572015;
        Sun, 27 Jul 2025 09:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkgKR95HfbF6oQwB+eiE+UGyj35NLc2nILT1f4/5kpa8bLrNcUqa3To0n7rXU9i9uwnvwD2w==
X-Received: by 2002:a17:902:ca8d:b0:240:35ae:506d with SMTP id d9443c01a7336-24035ae51demr1133435ad.35.1753633571483;
        Sun, 27 Jul 2025 09:26:11 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:26:11 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:52 +0530
Subject: [PATCH v13 09/10] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-9-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=rmo18nL+UB7XAtgXRRqne0fPUU/Z0j3760cEPwsemB8=;
 b=Q7kRckRAJ/nnrtAocNnkqrdbMErSSbliIlAcnFlr5Am3UV00ZuO0f1aKxMH6JVpoxOHtlYRiG
 CXP4DUR/vLfCVMCZcSZwpLotxiQa0+gmmIkxpVhVAWNxL8A6eWqj+4o
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=68865327 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NiBTYWx0ZWRfX5z8J7qFA5wPi
 pz9GPBTy6n0e6GQLLsK1kP0J+tOceymT7DizOhjoj+27U/EtBfe+3jt94HYEuVpEpHIVasE4VrH
 FqmP31i4EEcP1PdF5WmBQ3622Xj47Di6+Zw/3EH88Ezqu0wPUvVLXxdkolgUVsQScnw0Zs9BQMm
 f5xee4H+iil8KskmmGYSTU3bBw4PlVqnZBPd929CRzOYcy++8oXccV2pYjBu9U4oXcFOtnfR6UC
 YbZoxy/jtvrHZiWWFQGytgO2Gud+XcXwirUxaQ3oGp+vQdAvM667yetvKyAt9lr7IyUtVc9ue02
 jJGXrJVVfdpMyxI1FUaoWYZXEYkCnw80VBqlj1PpUPAu30/4EsYlVEwxsQvW9/GU4BAykz6Aqwj
 y+IkG8CdjQuciPRkZ541AArS7M7i4J71OQ9vCb0D7bPd5xIX6AXhbFSr0gzYom2QxbKu3h1F
X-Proofpoint-ORIG-GUID: 1jQVSftusuL1MhZptdJ8dASwo_C_u3dk
X-Proofpoint-GUID: 1jQVSftusuL1MhZptdJ8dASwo_C_u3dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270146

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode. "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5fbcd48f2e2d839835fa464a8d5682f00557f82e..8cf289a3cfc4ac7014885494c27fb003a7258519 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -966,6 +966,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1


