Return-Path: <linux-pm+bounces-30544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE206AFFDBE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00AC4824E9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C831292B5B;
	Thu, 10 Jul 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NBeaEdjd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88920292B45
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139017; cv=none; b=VUzr9//Cnucmu7ugPC3nM1JsorFLLV9vSz/FeDnjVcetn4DKkLdkoMOoQor7kO3qIZl5dpB0Tjim8DGFZnFEhMwYdud8TxVGStSVHQ2Afu2Ajh/6TpAeEroL5h31ZFYRw0zvAIb2fA8wt4hcYLNhqXLFO6//ZNsjzKgrzDYYryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139017; c=relaxed/simple;
	bh=viCb3VHco50oE5St3/+zoJqA55BoCRGQlTkgrUYg/Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E95YrmpxePRD9ZvyZwBDjtjX7xEyjFI08AbU67qZ8vFZeq9/l5lyy46vmkp4ViSteZQlluTjqR27bJQWSxv85+H9ufL4iGi2pknR1p5wy7Ynp3uDGJdoksWc+e4sKXqsvq08lAuElcm+QRd5LJS9iGhVScRAYIF2r9eBfesl4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBeaEdjd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8edBQ016807
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3JHDq4xNymeRQPJylCbaS/K0qseIZK5kd41UanSbGBs=; b=NBeaEdjdL1iocVeu
	/rYDdybPhTfaKd04D1Ltrm02Fx08mFrP8+Y/le3PKMA4E6Yn7JRUshnex1oLmzO4
	V17upqXQFqIWJW0VC2elJMT6XUKi+D6UCEpKt4Cnf5Dma+uw99D57W+ke5kFMZAO
	RZskEFFLo9fkAQzAEv/tQkbxDBDoMomQG3H75Tb8LgpktM7xhfI/Ecb3qclcxFy8
	hWOhYUJLNH2lqiMKsnz8McR/KxxeV0M8+ukKzBtIgWgadj+51FAihBM5uLeIVOzV
	GXb8SVOKU7QRsZW7Q2+WK8Bryx+WBb0Ifr1WrlTIWvq6wS78CokNJ7xx1x1abvlJ
	z2a13Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbnvb5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:16:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234fedd3e51so8444495ad.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 02:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139014; x=1752743814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JHDq4xNymeRQPJylCbaS/K0qseIZK5kd41UanSbGBs=;
        b=jl9AGkzaQzhfY+RS1hkezYQ3wrt9Hg9KB/R3adrinOf+wfttTYVZfT4mxgax+sXyVk
         Me1km27Ovm5pBdLWdKaM3e0kAZF7eXnsBwBe6+uMmvUuvUi+3XIT9ifG8ip8mvGrLvbR
         TgvOF6yEWHwb5fGMBpcAC2QxutjSQI8HTx5tsFCANUXcaHAnuSpmjtjkh8wuYEkiO/R2
         2Rm0xHEy06JtlnO7p10ly+S3MGDEcm+ilqzN0p43qE75I2R3aapMmakm3Zkp3fcHzowL
         QaJTS3Wo4F6rCdtAGiue5ldCgLB/OPMZY/XtN8TwmkQZH/UrISXN0LueipfFbB3Rj7nD
         rKiw==
X-Forwarded-Encrypted: i=1; AJvYcCVRpHZnpgpkczGq5m9c37dFiLqVBb4peqppXL7wEvjxDAeai5xnncjTw+951mhNQlTkXgFCkr+MtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOvOncu1qF9n4YoWN8f8XdoMtd16bwso3HUwt2GNPGfaTPfzy
	kfDRnOcJUh8YF4wcdkZvR9Ek+ayYpw731UYtOlfsUPXuxIc+B6aiPMB3SDvYvKTMgqdfziq7DR+
	e5/En5X4Y42EtsZ9yONHSbtxa8Z/iEZoeQMFsitS0F6tkaW4ERTLmMxgkRRzzeA==
X-Gm-Gg: ASbGncsejTuMnrlReomHdA2QqgwBfnnNVpDJi8eB6QXQQClz+isXeOeGrGPbfANIuMd
	qbmaRoaAgwHAunN/K7L9gtLB/mLBct2zXVWz05XmMFGV2dF3oKY2bWFUv2bXNwJj0TxPk5xrsAX
	ZUvvs22RYauXVkiotSGnUbo1bMUvi1XJVEPD4IXv4xsMIhafL8bM1PqcdfmR0JyJ+EmN2Yku+fu
	Bx20oM1WmgpLLA0VzedmOrklLrjJ8FvuGU1X/mBPaMC8TWdXMVmbTPqekRcwk69Y7bBz4iNIgdp
	7JQo+c0Wdu0IdNJ/qHlTRGk8fndpd4BVuxreZPkrwO2ZOjnMsQ3Ih4KLaQA=
X-Received: by 2002:a17:903:19d0:b0:234:f580:a11 with SMTP id d9443c01a7336-23de245ff1fmr43550735ad.19.1752139013948;
        Thu, 10 Jul 2025 02:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhuu3BMPy6+m8LotTax4Q3myhPb72nZbkwXLoKvQavuh7mNiBOrFXL2YDf4RnsCd1Y59kqaA==
X-Received: by 2002:a17:903:19d0:b0:234:f580:a11 with SMTP id d9443c01a7336-23de245ff1fmr43550425ad.19.1752139013557;
        Thu, 10 Jul 2025 02:16:53 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm14837765ad.189.2025.07.10.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:16:53 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:45:44 +0530
Subject: [PATCH v10 02/10] dt-bindings: power: reset: Document reboot-mode
 cookie
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752138982; l=1990;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=viCb3VHco50oE5St3/+zoJqA55BoCRGQlTkgrUYg/Ls=;
 b=+tAQXKo/oQadh3EVPYHeqksr67cJmLufTnVdZiv/vcBJ0BqSY+aKThnGkD+4p/OYWNsrrETxS
 MZV5O05idFJChRAtYALBJlBTh7VUYG0QMDDrgODlWIE2AZJ0ZArgeR3
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OSBTYWx0ZWRfX5pErTMzLiVZu
 I+/Y1tKGWuQDYYBTIKGoZ4kbzVuKk8+zZs42GxBu5Hre1BB+4s2wFEoCi6jdPaPGDTdTqgNHXJ1
 xp0tK0l8RjZqTa8SnebhNBQGeOn1M6W39zgGpKnG/5dk8EScW9we40Pr+BgaLn6B9vX1uOzg7cp
 mxMdmJ155coFmxdLgJzY22hvkMXpBbtHzW2Ku6tzFDHjDvChfuC8Hq4H2FyyOm4GDKscQECgJ9+
 tV5nqrH71MYMwc2c0N6nIhvM7wwn7cA2SlOgfHedP/xc3MXvW/f4UG8TBvZFs2rL7yj3j0DB034
 ue5IiyQ18/hzbluqW6huYceVGJGmcRfxFCJXXh5LrS0NKr+cbeY7d13DOO4hYGzrNUChY8g8aSk
 BlgTkGyg7MvSD4OIZyUVjHgcK3l3n4qV0CNjqqMw1PiHfqLMkqpULnsarryhOUoNZ5umd5Sz
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=686f8506 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8
 a=vfvPc3r3pdiY9V1EK2IA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: ditzXubXv-rHesfAHMn5eyaiJufN2V_B
X-Proofpoint-GUID: ditzXubXv-rHesfAHMn5eyaiJufN2V_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100079

Update the reboot-mode binding to support an optional cookie
value in mode-<cmd> properties. The cookie is used to supply
additional data for reboot modes that accept two arguments.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../devicetree/bindings/power/reset/reboot-mode.yaml         | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index 3ddac06cec7277789b066d8426ea77d293298fac..a4d2fe1db51e0c1f34ebefddaad82b8cc0b1b34a 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -10,14 +10,15 @@ maintainers:
   - Andy Yan <andy.yan@rock-chips.com>
 
 description: |
-  This driver get reboot mode arguments and call the write
-  interface to store the magic value in special register
-  or ram. Then the bootloader can read it and take different
-  action according to the argument stored.
+  This driver gets reboot mode arguments and calls the write
+  interface to store the magic and an optional cookie value
+  in special register or ram. Then the bootloader can read it
+  and take different action according to the argument stored.
 
   All mode properties are vendor specific, it is a indication to tell
   the bootloader what to do when the system reboots, and should be named
-  as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
+  as mode-xxx = <magic cookie> (xxx is mode name, magic should be a
+  non-zero value, cookie is optional).
 
   For example, modes common Android platform are:
     - normal: Normal reboot mode, system reboot with command "reboot".
@@ -45,5 +46,6 @@ examples:
       mode-recovery = <1>;
       mode-bootloader = <2>;
       mode-loader = <3>;
+      mode-edl = <1 2>;
     };
 ...

-- 
2.34.1


