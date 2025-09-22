Return-Path: <linux-pm+bounces-35164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4FB917A1
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA5D19006CC
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C430FC06;
	Mon, 22 Sep 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwYvpOg+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF5310640
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548522; cv=none; b=BEbvQ3+ida7AUftJqzzuLOLa+cN9Mrecu22HiltTMp58LVnp8N6SDYT1XTqwrXSayMk+NZSrPkZ6p9TXRp43Q2R+eRrSeFHVm/CvCGtCJSNHigjalqf51qLG2hVBBQ/x6Yl65M36QFRSvVoI9ePdOFc4tkChXigqkvQXkGPPZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548522; c=relaxed/simple;
	bh=BQbA1PfTf4T3catTnFJyQPDRyKoNlBdFRYRrfUNeAx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uA5X3/o8uI6N1HWi8OJYzwYrvT+nDlG0mlhPSM66v98f3H1p6r4USgqKsf2SBgOofSDUJqHqgpmXF3+SPUxsVas5cd6e3s+rBw49jP/pCuqCiYeQ+08MemHnalpmsRi3m/1DakHcdxYXrOmptwGgQAmaeoL6GemYpfhJfJy/zkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwYvpOg+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8ni2i032343
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=; b=NwYvpOg+xZS7eHP0
	xDNER6FmPa5tBlNEMzLiHHu1qY+74UFzQbYQXWlr0JRsVQTkUi0v33MPdgcYFwix
	rz/0WJ2t380Rag2TMTjVmrBUe7pYiy3n63iSjuAoAeEMO9Gdp+gW4Iq9USX8XUk5
	edOKM4JrJn8KVY1Y7ZwwBfGvg8OBlvQolFgGaSq/aknrz0Ouqup571qn+SY6OwfQ
	s0PbBgH/koWZSlemX+W6Dqbg+ojVDk0H+jzSrMBRRHnADxLN7RHhjBTMEPqCFP4A
	1srZ3nofm5yzwt8td9ZGMIqLIMd16VP6bJCBMJB5XgIiJydcm7BiYENtMWBo12qP
	agglDg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cwr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:42:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2681623f927so43435905ad.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 06:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548519; x=1759153319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=;
        b=LhHcpTi00zXABiV/jiRssY+r0i5OYn7qweHZwwADlrUqrDzfIBllxtMS6nVys15cT1
         QSlQc85H5oU39B7HRe2AL155KcLedVl8R2HfGtZClH4nZbYAF6MtYdcMs8tYmsNsMjJA
         gTybXv36N1rUWIenQo0PaDWxlzlXD000cDKM5y/zWP2/9/5mZvux9i+0MvGvV5NV7Fld
         u1lU1uNpvFnN9u1MoI/OJMx41zJocxAabXf+ApnC6XBHjGwuH01AoGHdiT6DWTbGP7Uq
         XoZDmhadCwl0hv1PRC+C11KC8SoAO0W6Q4NEx4sRCzxPFyOo1TXePaVgikJZCkvVPkyw
         OBvA==
X-Forwarded-Encrypted: i=1; AJvYcCWskteZCDDgVYL959WZgy8dCElbYUn9c2Vn4WcMA9EUiCRFBadXOjmqnSaTPO5Zqti7ZxPWH8q05g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQrJlCqPbUFG8C37scVEO7ndv71DzbaGtHcv5tZztrKDAjUl3
	Hxq/ygy7fZcOFEaiTyskuSQ0cE1gIHZUTr2pEU3ZddZ1TYegQ4kZTBiN6ojyou3J+f1nFiSJuE7
	YDxjYxeJSLPiKc/ibvoG46pwnqIdGU1zKZYrSBKeMwJePlC/WcxMDEkTthhXZUQ==
X-Gm-Gg: ASbGnctxgOapgTAXjg2u0GRX0idQ5nakGbFoaoXg6b9+wV0SCB61AWhSsupofa/pPTf
	vStjOhnI5H1fSmSij2NCpxFZXUKJS7maF8LaewN7KEQ7Sa/mcWiO08Vx6/NNy6crS6JPuNlMHY9
	587CraS2we4b+OgPPduLMA+ZTJtR1QfIZnpG9YoqzwGmiM8uqFb2bKDWyWpqrg1Mw/qQ9+/0/vT
	pQDJdILZs8/uX2Mxh+MfPjbffG6q52LAUwQjQV4kaqUlo3YmCE+xdhc4cGSBHB0eU33DTkn+pSQ
	m+gylWGSj+zNKDhkN0ogPtiBh0Mjrh+OAsyCTtNoGzgVAE2G8G0XuJBYooQlrqL36ViUvH7JBSi
	W
X-Received: by 2002:a17:902:e94e:b0:268:5892:6a2e with SMTP id d9443c01a7336-269ba59b78emr169070575ad.56.1758548518438;
        Mon, 22 Sep 2025 06:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7GSFmhWYvpYF0EOoGE36KcGoA9Rhnhe/ZjWh/d/dlfb6rO08M9tGC4TLjf/3UCGfieqRxAA==
X-Received: by 2002:a17:902:e94e:b0:268:5892:6a2e with SMTP id d9443c01a7336-269ba59b78emr169069835ad.56.1758548517815;
        Mon, 22 Sep 2025 06:41:57 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:41:57 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:19 +0530
Subject: [PATCH v15 09/14] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-9-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=fkRav5QA/W0o9Ycg3/xbut6S1Npfgr1jXzERBrOotDE=;
 b=nEF91WM16FRKVprlDcNfVQWq2bR49it9Jbo2EoH3aVuK0XkhCYHknxQNy4bTTsN+sz9xNq820
 k2On/w+tYoKBrQpRIp/RsOf/hNnMynZS+XFJDUOtM528sIVCEEvrJ9u
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX+kkB8AvWyu2l
 Q5blcGdwNQ2jFWglRcWqBdiFiTPKAywTxeolbSeesBqJCk8h9vG6JYHs2dsVi2ZRIhMmnrcHLQS
 8OF7hbPjIPhWTqjf6DJ0C3fM2aJVV++/tUz4+xdrAOxeqGsYTejCisMyGHlR3/J/8OFoqE331F8
 uUbfGmhQ6dmeo2suVMGO/yitpPNEN8K8FHqrzfwM2bdJ/jmf+l+cy6Th4/+4u14FGG5syzP6AcX
 7Mijji2AKEcKZmcmnl+FHCLGz6wYfhM06NWaemFy/UWekb+omwFX1Uok50xQOnzmn5f9/PRz9q4
 C/Y1FLeJpgLOUCrPmA5QIA/9ZWSGKLR2MXWjyV/MvXfPTUk851ajNegI0J7soARj1VWeRw5ZnqZ
 JbZfM6IL
X-Proofpoint-GUID: LX0uSSsmZO6-9Gbit7EmfuQcmpY331Ss
X-Proofpoint-ORIG-GUID: LX0uSSsmZO6-9Gbit7EmfuQcmpY331Ss
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d15228 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

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


