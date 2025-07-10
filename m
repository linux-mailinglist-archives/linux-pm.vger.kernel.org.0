Return-Path: <linux-pm+bounces-30549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C4AFFDD5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EC11884281
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939629A30A;
	Thu, 10 Jul 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T2leWwQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E33299929
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139070; cv=none; b=BZju87w2b5UGKhyo2u3AdCopvCJ6aR+8N0YAJa68/lTsurLdpSQikzNJVNJarBcL/iry/9qgO/7CWhSWWMiD0KCTp22hmB46o7RUXzJ/tY7VcytFpCYtfwUWkHUOPY//gvo0pVwhJf2XQPjCQWVxSfzWwSybzOzWIQq3IhrToME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139070; c=relaxed/simple;
	bh=BcXSb8+CR0HgJL8ZGlO3s8zt5KfV3AVBmUeP6D5jawo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7SG9R+YLghON3/OfWoxsQwGw7qSMyZA4mbA9UJRjTfU8+Vf4GUhoR+3Pa1qR6fDsquaiAUuj0NSQbwYGW7VVp5/nrp7TTO6mN1BVA9YMk90gW3dfagUNnrnS6AUNZ8uCHrM/OGrJ0my4ESuMx1nOgh+wM4jzUC4jua60VhwWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T2leWwQn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8UrtA011029
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LHGeVOx0U2s9qP0ikhLwIs2P+IuUNoY0lfi0EgG0DtY=; b=T2leWwQnvLvOkFT5
	FqxaS8UlSjT2B3VyMJW/m80MFFazSucqvPBpJnIE0FykN9J0Jrnn0TBJjigP3BFp
	HC5rSlMxaCCXV6ZY8ZVsx2Urc4vVFfdjEmW+OiaYUeRYXredSnDRdup+9khzzpxk
	Y4ZoRaX8ySim5buzzTB5VFaujIvS3dBRpSSReF0L3SahKEkiyGO3vRBSfzieGYtv
	EKKUQszXEPp+NWhoiCHdFb5cw9Jrn2WFcCYkOeug/I7wyK32bMS4J026Yl3ZbmLo
	4gtNC5Ddh9jurzukUaEA3mUSYVGUzXqUi9P4m3rUqXQDK215N6e/BtyeWqJllsVF
	D34PwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn7vqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23632fd6248so8563545ad.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 02:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139066; x=1752743866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHGeVOx0U2s9qP0ikhLwIs2P+IuUNoY0lfi0EgG0DtY=;
        b=LxFOeo/OCwN86c4npJJS/SSGWf3seM3wSL6x1heuKKd9GtHL0STrpfFF7/wRgSjs7W
         72nGx8Yv+0uIqvpnW/GNJVhh1x2vqv1gwL8fOCoAdSe/Pi2n6ysCtbrgUPQe+tAbpGqY
         8uUOXHbNgogRb6eC2V/lcA5TQCpBjXtPoXDQYtVRD6GfuqhnfxU/GSZFYf07IzXfB33d
         E+32k6P3spENBGI5r7eDYafN4tqU3hScuE4AfZ9FGQoGdDy1t0+WDlQeiEmzPeC1THkn
         5zdaimiPQ0o84430iR47pmakoe6nkDwFiV/FBAuwClEzwXus2o4+STgg/QBa31jpLNH3
         B/lA==
X-Forwarded-Encrypted: i=1; AJvYcCV7YvINtMyaydjNlzzpDSRx/A+4cPRMKxfb7hxYrgLjZBYGOQrf0JAnzIG7mvsg7jNY0wR3cMSg6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbGCkL7/e4V4Z3EaK6Bf34tjGf4H1MluOIVfFUYlWbQFKFOXX
	5Y+UdCGWlg4opDg2c3R2nFn8KtrVcU4vHWxcjvEDF5BUOKg1/iPSCzB4Mknod/05bES2+PAzWaW
	t/EODBfCPL96DVSUYSrz0aBhMrqnmZcb1nVHkHNcRdcIegysB9SDwqprbmbPNwA==
X-Gm-Gg: ASbGncuUwqz1PeEc2tenkj7M1dhNERoT5xJcmQOMkh6h0kW7PEwKEyMXqoVr/GcEqgd
	QLfJ/lw9ICRUj4qrAlNc8mfXJuAl/RmqiQGUyjhk70qrKJLPK/Tq4rV4iFPRZ5+Fe7x+ICJbhXO
	LAGd6bNHTt8A5f97Hw6HXuH2gylK3wSuYXM7WXNQOCkzy2wY3kZ//sz3XOza9LXmu4rl+v8RHfW
	iRmW9uN8+H0cO+ibDInZrHZ9yCv7xw/bnxrV+rDpokkR3qrTWkE7lNMjdaqJw+KEednr3QW3rsx
	n2wzLWMBSVuCid32dUNrk7WJf6x7/pEdVTaj8c5NykExYZRCSsNAL44wMo4=
X-Received: by 2002:a17:902:8f85:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-23de24f375emr43328415ad.35.1752139065807;
        Thu, 10 Jul 2025 02:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRrq1v9TOcKehLshyNd7Q9DOKQg1TlB7iqx+awqZ/WY5auAdU7wXya8kio0FJy8iSW3PY2Pw==
X-Received: by 2002:a17:902:8f85:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-23de24f375emr43327605ad.35.1752139065322;
        Thu, 10 Jul 2025 02:17:45 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm14837765ad.189.2025.07.10.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:17:44 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:45:49 +0530
Subject: [PATCH v10 07/10] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm-psci-system_reset2-vendor-reboots-v10-7-b2d3b882be85@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752138982; l=1169;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=hDcOEnYaWsyU0iqVg0jGaDC9VsmHgvyimm+9MopdURY=;
 b=LLxxdiwC89+T3X5nLirDzCvhuvPRD/c3MNOaVzUQd4mRVGpcSzTIh7ADcfoFeLkJX+zkArk/k
 5kif1NoHvivCPiFySaWIVEsxNKuvF2Bu4vUXGv4gtaXwnEgWXYmX131
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686f853b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mlMSzhu8tE62a9u_TvcA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: HH8cNni_bKGBq42gVB7hnTumfojbIgM3
X-Proofpoint-ORIG-GUID: HH8cNni_bKGBq42gVB7hnTumfojbIgM3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OSBTYWx0ZWRfX1uBTFf0PJtqT
 3v6h+7EE4q0ezoqMBmRXTnN90u2JMcHWVAJtB8HE5SpyqP95XNnNEqmk0kATDfRVM+rDjx+uNX5
 kOCdObefsp+XGo7+tV46Ms/19zGnJ9Y3V7WTeJhw56luuztbY3JEKmqSe+EaY88JsBiZkfIkEFh
 vXryudgrRv4sarzeFgeQa1GWWZGFyUliHNe27yQekzNq8ON0c4Sw0Y5zu0pf4Tg9Hy20eNn8Q5x
 w9uH2QT5STArLtEYfQkMlbY70hYdhVSdFnzxSImx1lvZ7uysHPgxvUJGET30T2uiPCZ0mPQxcNm
 xJFZIOxQQITLJy44sPO8tiQ9uVEnvfvmpYAjDBY7ieR4OTyaaFxK2TflmkVALtKDxhFbXDmSqW8
 FnG78FTGW8K+u3aG9S1OTlhLAovq6qo/9LORV04Yf+Q9xvEEWghtTxcj6O0ifvV8sCNw1znc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100079

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

qcs6490-rb3gen2 firmware supports vendor-defined SYSTEM_RESET2 types.
Describe the reset types: "bootloader" will cause device to reboot and
stop in the bootloader's fastboot mode. "edl" will cause device to
reboot into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5fbcd48f2e2d839835fa464a8d5682f00557f82e..7c06fe496e800e758d59ca793785d7c2907df8dd 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -966,6 +966,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reset-types {
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


