Return-Path: <linux-pm+bounces-37688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9FC440CA
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64C354E6397
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3B62FFDE0;
	Sun,  9 Nov 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qulzs5RI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZgiIy2o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5D2FE585
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699166; cv=none; b=ROUyzv71R63bhgC0KlNNwMJTOQOXBs3a85FMMv0o3uYSd/d0Cqo0OuZp4yrkFRJnsutPhU/tEfBOYPdfynkqqXBfNqpqZNGOslxrNBwG2xuPSokltZimDb+hOvLci1N6w9232R7Zh0j9dLX/XihdhyE+SMsDKeRtZrptObxsk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699166; c=relaxed/simple;
	bh=L5z7An1rQfRgBI3aAbZ9RvjHkAJiYPaDq4L3GKStdk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxyNlw5P3SpMlTTW2o2BmS6srtJMtYBUBcaL2Dx9McMHacyCO1Q1MG0fix9gPRo2cvrV6JFDboejJylAG2dLY/QwYJ4jxMFPQkrF8ZOuYEYaUq5KeziCVozpUcC9Qb27SvbHit5FQmPtU9U6tefp1mXrvnrRVlRoSr+NuLhh0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qulzs5RI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jZgiIy2o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9AxS1H134237
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kca6TC9CdzvVOcI/VsKM/bsiay1QMyWDYIKPAfu3ShE=; b=Qulzs5RIIcnCNQvw
	3YASa0XskvbnqqKy9Et5ewjLMICObYe5WyY4Dp9KLZDrt1fKTRPPJEVoF+hKdhnt
	1nVtb5sLIeeEsMQQs+OWfbBzB2L8tzmb9g3O+ega2uaFOsQq/GL0G0CrXp0NUdmE
	CU0hQj4rvUY69jpAJzSa14a5JbXYJt909h1ZPYHQTz0Lmb52KCiToZkj8gG/6ufp
	ueLmRn13RSa+g6vU/HD72oV0TCUjkXUWnjkwQPTU2PgtKwVJUKmTAGO7gVmtgkHe
	H0wZejM89vC7pojazs4Rq8swLhC/zCNkrxchus3j37ug7KIgNnp3YLDsW57qCyr+
	Ij4Iqw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs7a8cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:39:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3418ad76023so5629319a91.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699163; x=1763303963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kca6TC9CdzvVOcI/VsKM/bsiay1QMyWDYIKPAfu3ShE=;
        b=jZgiIy2oAs2ilqRqsJYytbJsNvkw0Q9vCB+5tDijCJxacGoDk+8u2+mK6upMG1fXRv
         DUxLHp/iug9IihWlmd3dNMHVHHDd7XMVO+A1nEZ0Qd2Bahiutb2zQ4Fr/AkamhvyhCpa
         0r1Fv7P1P4UUwBoyhdp9YMrSH5TdiPCAvUl8l6ZgN/AVuVx9mt5ZURSnBkz/QKuqm8F5
         7M/9kryJsOej60g7FLDP91onY75cg4cSPLOYsBzYPxQK7XgP6X8INUWI5Wc7IVHGbrdd
         1dlV8yQVRt/NXW2iLVHIrj+U/u2G415OV0+gXdGKPoX6tpvbIh3O03CbWH8yxjGp2zNz
         W6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699163; x=1763303963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kca6TC9CdzvVOcI/VsKM/bsiay1QMyWDYIKPAfu3ShE=;
        b=XPnFU5iQt83j1f6H0eFlapxQUAvdOIhHOKx5OQdnE42fZdTYNduQYyczJt1UY5WlnU
         PRuheBA23eFpg+w4AwcPViouRNT26gNp62dqitQka0CEuYi/yFHco3HVMbOdubdkqBdJ
         VAEiO/BSC2qG6y9Q3GXMM0jaqIqlA2tseCvT/KuLhUoCN+fzviqwEwDv6fcmWkMamOXx
         lGBMgPBw+6yCRkcvnsgek9qZntuqCkf5MuLeEjJ9bQE+sknHTgKM6i1RE/S1p7RvUCXE
         0byADGtlP4N+hmXK5dA1iyUT43vmWKy5nupXDJZZOeaFnmKIt5Wk0DDRMdhTYqZqO5GF
         qbcA==
X-Forwarded-Encrypted: i=1; AJvYcCWJxBoiBPE6GiQWY8XLsecLfls8pxvymyjvVpcjy2MukYqMus4AOcCFHicXbM4Eghu/BAE7FD46Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmJv0uxx+GyVtqj6W8hGes0FqSs+PInMp6Nck6U9BPhRmaIDB
	WDUL3c8ujYI668RY4SXsahWG7q//YRNGHTzebzEo0CcqIoUDVa3dxUV5623Zn+3/vxKof/MRRpZ
	Awswn+nW8DrVV/8FSuSkKWc5RI49xyrHdX9EDUZb6+r07Pejo2NNNMLvwZlDMIA==
X-Gm-Gg: ASbGncu9j5z1HUY6MW8OettstpYWDgG09/NX5tjfPMw9BFg/oowyhRpUBD7lbmu/hu9
	gOyyOTuw2lnovCWevXTNYnhgB5OE7WdaEa82k6fg38uPZ45LvIrgCj6hFeuELx2q9mGbDNXV6En
	neM0YR5Vf8xeeO6qj4carH1S8xa+WzcATurEx/pj6HtIu8tI2e/osWHGDTqw5pd7sGM6BS/XoTb
	7MYKjxpl9iWk+MgD2cPslmVZT4DSurxk/Inn9BCU6o/TL3ieGco7hSknhi2YfpYhzpy85Snj4ce
	0AcDHXYIBEzG0v+LcMwZRbyXdnjW5hfdWIaD5IB/S2UIFEhdm1aajUAsFrjd1e1Z8hIAIhntj8d
	fTwZ8NmQQuu6l/Mvunm3r0s/gCN3sg+NJi/g=
X-Received: by 2002:a17:90a:e7ca:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-3436ccfa18amr6671667a91.24.1762699163451;
        Sun, 09 Nov 2025 06:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVvyQ7Ie5qv51GMyMWvjT+5IIfkhTgU5ORFWh8Z2JxruCZKThIUurXvRJ2KKFN2TNS6U0/pA==
X-Received: by 2002:a17:90a:e7ca:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-3436ccfa18amr6671612a91.24.1762699162859;
        Sun, 09 Nov 2025 06:39:22 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:39:22 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:22 +0530
Subject: [PATCH v17 09/12] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
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
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=aXB/ZtnzKwJgS2fh5ZS7UmEMWdC2tYWUu81bgPi7sZA=;
 b=cGRfGGTemz5mYMnHzcIsN7x+3Xmr9GhPgiiKRvGsHEkgcZwXovPN8MabUz5/JPID3VZvw/NR1
 ZRO8BE+Wor7ATT2oXZpYWQAGPs+8aDB6Tz4FhHXDk06RqE5h7lgvJnC
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: 4k_1UNwsDGx6He3SYo0_U4BwZnKz7Wia
X-Proofpoint-ORIG-GUID: 4k_1UNwsDGx6He3SYo0_U4BwZnKz7Wia
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=6910a79c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfXw/Rk0u2lZhLH
 4/JxaHE7HzqytYOwk0t4lgAv9zzt8VZfeV/XDEKNMaLt3rwGPwaiPM4ERdk0MfyzFbuOQxCOOER
 3phGZCQae7WJ1iwfExiNuY1yq2U7bOaa1mGVw9TjC5CteALRjIMbPVwl6LOPusrnHiWFBkAaJZI
 kZh4Voo0nA/rCP3dQIWTUbcs3zuweBZ6DI38X3Z4i6zwKot/wYN7SDWq2g5BrVZN7i9oAlmvdRp
 FSWnXxGrC0AeXOdMRXPOMAWtTSREY/MI24LBAkxq1/210rAG2gUZ4oVw5oDBudM15AMIADIbFo6
 l/G64cNqMj3faNhmkViiw6vb2wSgr0BuvBP8MTkzAgOttj3JXbkAQS+FQ3VWeWRW1/k6h9N+8n5
 ti8aghpZ3kPVWNhSAsK+bqtZrJ8uUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

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
index 721a26d49ccaeb1429e2cc1c3a5c8d9517da3be6..cebdedd5d614b9efb6dfbee91dd67f3c3e322a38 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -935,6 +935,13 @@ &pon_resin {
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


