Return-Path: <linux-pm+bounces-39994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0ECE54AE
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D71D3001BA0
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C323EA9D;
	Sun, 28 Dec 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ay5zcqfI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AcFup8dB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE4238C0B
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942504; cv=none; b=hc2tXgqObbruC6itZmaKbGNPBxX7slbCS0SHo623EprFEU4bWMQWBvnffRs8DfoRdqOv0G9V+EZa86vGbndqw7ibvaTKRaqXAs02+pf06bfFkdyvBfR4umtAAZQ3rnOEjRPXKpp6LchcE7Wj9Bxy7ZOENuGjw3/kb20QnAzh/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942504; c=relaxed/simple;
	bh=djZF5UFBEvnca6xGc5FxK/x9Ur59exsc3OaeKnFwerY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqc1w9zTyZIr595VScF2NXIO4eRK8cPq72rlOEQKwiWQPVJFIhqC7HjLeZIZ6xl4xQY64AtGcTqhEZp91HCOgM/zYKSKeRCFmSmn7FFRqdrcOf4L94A32oOfdGHHlCzs0iy/huvGVBQDuZxSAjVQqqtLhZ14HNj64mGWBsR3HQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ay5zcqfI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AcFup8dB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSEtt2T2306118
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pQNl6k9FVRxiRZu36Ul1H7qw6ya4whFcoD1DtYOJAek=; b=ay5zcqfIOFCL+B6p
	XwZiip/uLTkamPkdcq5FLuRjk1ukMksFGKZgOS3zz0Kxru2tne6vAQKUoYdm6JU+
	9mJCL6nGe6Xee7nuZCup7Wqj/BOYj0KPMMf8wcxrvwYugQcBmrn/AJRTOath2D0Z
	wh8cy15akUANBkT3TaEMgz0d91O334sqgSGV0ZS1ulK5lALqQSHvYUSCaeQcfxRH
	NoAPNgEIpJNgvup57tcezmpQHPMx4ScvlEKX/UVT6PJBAeJN7qoK2Y1dFedOjZPu
	x3bTTKoFqv0Sy++SDCmuiLcNJE/SN+B33p2sjMJMYiAf1ojKRfAiZXHjGzWe89QD
	jUNKPA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8r6adm4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a13be531b2so187256395ad.2
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942502; x=1767547302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQNl6k9FVRxiRZu36Ul1H7qw6ya4whFcoD1DtYOJAek=;
        b=AcFup8dBhv5HG5ygOdKWHDqF7AWkUkTYaya8AheOEen0PSTEKD0PHNJdz13uos5Pra
         5Q7wzjlmLoQ+roocEsBRzGLZqkffIqNxZe9aJQE7jwR1Qz9rurGLUfTonhGyLdbWr8Qd
         /OIf7VWECz1aVnJFA5bidDOLk9FzFBVPA9lb+FAV3IoiarywdQy6fpu+tN1F4wRr++ES
         XcjcLZa90WcAjo2uB4NBf2A5NKbVq/BEI1yT+nQ0t2T04zQf08ga5Xf30kZvPjiSeYMz
         fA8fj7G30mJW3UrMB3egP2q4qjfFvVla7pTh+DSElfYEJ7ResX1KxYSbMKB5dXcDwcy0
         WEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942502; x=1767547302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pQNl6k9FVRxiRZu36Ul1H7qw6ya4whFcoD1DtYOJAek=;
        b=MxOFnCrEhwxKze/xS8j2y8yzh/clKPOQWVgnXjCfD5CMaJFrPxPshCZoXWglB9GmEN
         bORRdqzrAD6ngpRmVxPFGHxIULkIwL7Ko0eE24nFC9UwlpqSJQFY4aEfO6qLXr+9hU/u
         xc1WWbmVYXEqnrqC//+g+bS5QCuPu2d/bH0ICU4AZqTH6CHQyNF3m946rZdvSnM5vuat
         3q+UPFnvpyBT85PY7Rgnm+PoNZN9UQKXboOxk2RU+XHhZzAjBGZnEFoSqD469AW6CciS
         l7CBPe2zQjLTOIh1VxxEynB8ixLnhL9Wyrfu8ZoTDsw7gYA4g45C7ReogOljB40BVjPK
         dVlA==
X-Forwarded-Encrypted: i=1; AJvYcCWL43GddC6Dxb3er3MRl81ibxPmbkBguJxluIQIba9ISiZw1VKBNol3cC35g4A8KGO0+V1GEC0pQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2Bwuz9TYai9gcmZCozB+ZbFuF8XikmdKhojR4j5nU0l3h5KN
	5VUl1fbcz4xX2oIP+pYsK58WKzTU61RBDHD6KJeNo2jCcoLsqxz/hFxoVhBuSp7gk4+z+iQJsRU
	mCXarzFcSiaaZhlBBbFiHwO4XBVRrqX+Knivj0cxUy1SFRGAiEXhMyvAGWVQl4w==
X-Gm-Gg: AY/fxX5qZVCtucE1hXdl2nWjLIh111Py/8/G0oCEQK7SHrQ5T5scsvwsRG90QOAVmPX
	T6zt+JNU9juijD/asyPej08HEPoUDBFMqymvs+XX2lGbV8A1T88nbP6jfK6gqkbNM7W+GWVaftX
	Wy0K28fQA1c6ZQgBI5HHrBKZOP+5dDDhbAV277LJWN3oWRLwJlylcW8WWTYbmmgwf8kHm+Za+TQ
	Q6gK4OpZCkXavIW3VY5eKt1gYrFF95z16C5w6CNPP2avfvEm6sYZa7794K9QdJbri0lS/asWd5e
	Bu0xGjkNg4iLc4p1T3Qjb4lMdwU7r6BY4YEw90ZD/uAW6Iu7fmHSMDk4DeFbXnihNpJnOoGbC/b
	XlAkqDRWWFquCJIq0s7mJ+09CmopYG04YzVzkjX82bpERuQ==
X-Received: by 2002:a17:902:cece:b0:2a0:8df5:2f6f with SMTP id d9443c01a7336-2a2f222359cmr260366715ad.15.1766942501888;
        Sun, 28 Dec 2025 09:21:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq787p1Ho63fjlcy8G81u/QrkDgHtvjgeeroB0B78/24OrcR7OHDo58D/xrcx/ezuepD0T/A==
X-Received: by 2002:a17:902:cece:b0:2a0:8df5:2f6f with SMTP id d9443c01a7336-2a2f222359cmr260366545ad.15.1766942501409;
        Sun, 28 Dec 2025 09:21:41 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:21:41 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:27 +0530
Subject: [PATCH v19 09/10] arm64: dts: qcom: monaco: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-9-ebb956053098@oss.qualcomm.com>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=1066;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=djZF5UFBEvnca6xGc5FxK/x9Ur59exsc3OaeKnFwerY=;
 b=Mj5E0OFdKuDieuQWf1uoUuRUrw7EexTkeFGSadCtQdobt1WP6IyHfOp7HA3VEEGikWX6W8k+a
 m+7/ZZbc8RBDyEenZKLfJRCu0VwCGaKF+UCG7idWnBegycJqDiGXCS8
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=Raidyltv c=1 sm=1 tr=0 ts=69516726 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_PJuSq69R3b4qrRYkJAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 1t2fgiKBP5QYY5Vhs_Xha0JOAQ3KYmGm
X-Proofpoint-GUID: 1t2fgiKBP5QYY5Vhs_Xha0JOAQ3KYmGm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfX0yEEM20y5E+u
 /ejCbSWs6QPRzeRST7ZUtOfhlSgxQiHVFRDQWJSAteIXJRH38yFxjTM7X5Mib1ybJG+6p77OqMp
 cEEeAqr3xZf8HSpPqMKPDzOOt+mmoMZf8brdla5sV5G/YEiI+1RaUSXKtuk6PdAVeOM4qhqpHP8
 TpLpgLew7a8+q6sZkLgL/lZ5ED1b/2BbDwO72B98w9OWQQdNdWXgKEg9rO+mfYS5CWxidTviVwf
 c/HGwdSOFJOonSPlKsFDzlY8RqYfQj8BHnQzzP2NB5X3NY1Z0nsehaTHeYBB+lzUCYH4+Lpr310
 6Ri8TVKl6+YPxeG6Awx8At72ZlXRQX3N1hlODlhAVElyQMBRFBVLioC7uSgjEwVvjOFKGIbnYE4
 qsbJ03vW8THm0azbJrb+MGR2mDeaTUeCfvhj12xzMQgN5pFRdShLpkDNOhLqsWBvABcWVrR6Dg8
 /L1jc2k0MdN41g6mNWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159

Add PSCI SYSTEM_RESET2 reboot-modes for monaco based boards, for use by
the psci_reboot_mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 816fa2af8a9a663b8ad176f93d2f18284a08c3d1..9c8087f870fc8889edffda63c62f4d5167729cbc 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -732,6 +732,11 @@ system_pd: power-domain-system {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&system_sleep>;
 		};
+
+		reboot-mode {
+			mode-bootloader = <0x80010001 0x2>;
+			mode-edl = <0x80000000 0x1>;
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


