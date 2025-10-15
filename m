Return-Path: <linux-pm+bounces-36118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D48BDC83E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15433A27D4
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14002FF16F;
	Wed, 15 Oct 2025 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msPOCJZx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72B2FE591
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503203; cv=none; b=do3Z7V5YtQSrdiBUEvRqeS+BgpBswkqcUMbVoQ7y2Vjmn2RMBdChdx7zkL/LLVExM3zjeg8kHmPa4f5qQhQRJFw4F4BhFANfACXjm5b09Px0qF5s5CUx3Rl47uwU0l9omsSn6LXS6nea6z6TEFBNLBTO313xAykxU8Ov1pO2IJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503203; c=relaxed/simple;
	bh=BQbA1PfTf4T3catTnFJyQPDRyKoNlBdFRYRrfUNeAx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba/GpeEiRJPy5OrHMs/2XezGh3HSDWVTYzVRSxX/jA1ZXuRAaxh6nGYgKKXqaQxI0uDCiaFL/nCEzBRMXemSd3cpoDV9nmMDjAg2K1G3zfvqbWSt2irApLlOkklrMP8/rgl0ZSYfMRYDKrJudYJmXmPBbiC9MR50fXouPAERv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msPOCJZx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sJtT003643
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=; b=msPOCJZxEE3uULcc
	MC+h/g08u9WGbFghGMnkBDqCEUVs7YqwOkQPLyeX/JOhMaQmAAmdMrnJbudQyrDf
	hat7XaOi5Q99fxRLeYhocHYd70hVqeyC2UOTpCVI+X1NYHE69htytLFg0/BNYgkn
	RgLcHWeFUckj2+MDusmTrcIpxkj7EvX8/psHeTh/8Wrg1uTUUwuZ+kPDDCq90jfX
	uH3u6/1Bf+QXk8K4iWtvZqlVnDbtsEV08qzAhuay9tuQVdPrS378lCT7yWgNy/bN
	PHOXTDP6hZ2BDIqHNOs+Phvbvu7qpY8ak/HPhrLIpT1XCI5V7i7HrIIPbe5C4d6k
	Zjg+Dw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd934bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b551338c2c9so7495829a12.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503200; x=1761108000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=;
        b=wyBMZH4XUuzcznvAhADpy8wvbAWIErJBWqMkMTLxYMVhRmOBMkF8qwYempOs9CZ32u
         JqqpCPPge41WQtE8ah4UP9J7ryyEFTfS6C47dn/NgM2z1nqJR9ZhiC0B18nzdjySFMZv
         zEoxKNGxGjQRDDTm0tMOY4tEQQaqGiM9DVu0f8OSylnMdkJHV+mWT8A2QqvkKLrh2+QS
         BZWU2lx5HlRRtSeEncxi3x48Q28mdg/fiATckCoAXo+9EKMkhmPXW50qMCoPxseVPb8i
         +z4V1CE3Yj2ufx2ckEiKOsC0wvkQMJptgHJB1T6Gv3P/HslGs/YDzIUs074a7WvS3uSj
         MMQA==
X-Forwarded-Encrypted: i=1; AJvYcCWuVsW37NPH23fN8V0Lgvcmj1cS+MgH2BBwnCDUcXV+njiZE3YncG887SJXCKuId/Fs+AyBftF1zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWvzBEFf7qYxitBe9s8y+9UfJ7FbBWMFge3y2WcmpbChRr9rC
	f/Rg7K3k9igi0TR0Qcm0O7ze9fWR3MGU11qXxNU+A6j7PXZvyAdaQUzajkHhbjD6NCKM1ZKa21o
	VVN9LuzvwtTCVQrgWSQCpwFgBarRf80PTClZ220aZv2BNhg5mKuxplAPuNnEvYQ==
X-Gm-Gg: ASbGnctdJsRGrC2g8ZYKirgEDGuZkehdxpFsyDiEXxOoPNWXdrKkQ1hlJYJRF0PPBVh
	gxp6/mb/PdJDOIZVO70tB8FHxLRJbbq1Cu7yaqmgCIjxpeprjHzOMgFj0GTwl+xEQW3k4lSu8It
	L9LrPaIRlbLvXlUA8Ra5HZxMB53ByCKk89uI+SPgGBq7Yb40avNddxittCYVmhsWBd+/TLVAo8R
	uPtoYoVYQY4OG5ZiWI1t6x3sLvDzQiDPGMppr9IRMy9SeQl2NFO7XKHMrVZPxj7wVkP12U/2Xic
	1o0n2opRr869+bIvn3NU2mVP0TOgQCyhD+jfxE2PIqND9NGVgUqMVnQS3eWvJ3rsDNkvKCfrESl
	z
X-Received: by 2002:a17:90b:33d1:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33b51149957mr40663634a91.12.1760503200054;
        Tue, 14 Oct 2025 21:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhSUdPcBNtpuWSbeLJvXggYqhWYI2i+smtNsSh5TePFlbEjw8lNbvl3tdNRydAZ2+8EAKWg==
X-Received: by 2002:a17:90b:33d1:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33b51149957mr40663569a91.12.1760503199250;
        Tue, 14 Oct 2025 21:39:59 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:58 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:24 +0530
Subject: [PATCH v16 09/14] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-9-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=fkRav5QA/W0o9Ycg3/xbut6S1Npfgr1jXzERBrOotDE=;
 b=skcrZstdabB94QPMmNvmUBmgXo2iDP/K2PrViGd7XleSuwoAEkPT9UvVVi5uAiw0VXmzxWXoP
 MuzJD13LH3EBKpAvsTX2o9knFlhccW9FSl09RtowPFeXjC+ycWwLPRj
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: Y3QglebKS4A7H-X96dYleJxhQhDLwNgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/VSxvhcatnSs
 wEnJMYcbBNN4xD0DJ8AYoBsV1oaQpnV6URWGCaBgjOfRYEBs9nZGJE5q0yBgVIG1kjNNexJBFE3
 FMMc4tTAdl3UK+hwVMGGS6HBq1+9dIE8TpGNJtlU+MpOPH/4waHxPzHWpzYX9GxfTnFJTZriK+L
 bKnZJTDDqSxERoMkAF2Ne30E+p0Xt6X28NCEhORD53T0ohk+kVOIljehgNkB4JF3mWPw6bMObnt
 kF+x0JZPLBWfAc3kgcMw575FO1P9v04Ay0cEUvw37pbeMs7Qzjs8eHm+LvEx8mN2GVVhHOa5iGp
 ktnqoAwfTMAucCs21bKKQhRXwwNblAu1vd1VZmllziJOAGA1AWW2EL5EMVh/Sm52bHE+E2xjGgK
 lkz/C6DQAPmMkkPt3lhrk63BAs0InA==
X-Proofpoint-GUID: Y3QglebKS4A7H-X96dYleJxhQhDLwNgZ
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ef25a1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

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
index 18cea8812001421456dc85547c3c711e2c42182a..f38fa2e52a635100a7505c615c0e96f1111d0b5a 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -975,6 +975,13 @@ &pon_resin {
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


