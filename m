Return-Path: <linux-pm+bounces-40251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4CACF640B
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 02:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14A90308B0B5
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06932861D;
	Tue,  6 Jan 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNjFSgZu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ej4FV8Au"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7D326D6F
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661315; cv=none; b=KhiZiKioHV4+NzFnAp+WDSGM9t9NkGQL1b9P27JEbUorlJARuAzMa72bDK7RVklu+cTrglAaQ9r3mim67SlDyK8R7qdrYHjVuRWecVdDLoXEuWvBf8iZcqKOOmjWCWK9F9tETsLPtpv+AxlbeGthdF8KcBprok7d+2OJumz3U9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661315; c=relaxed/simple;
	bh=q9y+Dif9HlWdcnmMDM5hAVRBaWF08BPAccXmvU/QVEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UszDzq6YyyLrRiFAw9fz55egNx6bS1+j1zPxXjcOMaaZegqNV1lFpXwzDAUkBuRMqVtD1W3TlN4d8C8lKL4hRILKuSkC+bC2tQmpJA/PfUR7z3C8osgyZLp52gT3t9sbwIEagtftl/bI5bBXy9HjxvtuFUuRCiy+sYTE0hQmxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNjFSgZu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ej4FV8Au; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nGTT3114826
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 01:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=; b=LNjFSgZub+8hN4ZM
	oZBHpZYo/6RJPJ634S+7e7ATt1GUBrOKOkAQ1dp9D1+tSSMGs3lbJfsd1W+w1uwj
	g9c8IyKAL2zU/zPkzbcKxNHf7xOztIerRw2FIz3WjCh4/tpMHIHLI15OcQtsjzDP
	k/nhrq6vObV8Mhy7C0lZ+mFrdOO0u/6wgmjAMZmZbS4tHrIBtSCdqjlqxvq6ExT8
	8mJF20NydW3iE3klTokDZUWqoHfpE1jHJnP0rPpXnqp2sD11mX2KFLvUyEAlPZzb
	c/zhj7+K0auhBmBZY+LrcGYv3ypdGKqYOC/gHi9oMflOwTE5ApOccCEWVdvmILzA
	69T/jA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgmnh8h06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:01:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee04f4c632so8157551cf.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661311; x=1768266111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=;
        b=ej4FV8Aua8BsqUl/WAimMOi4zBH1RMx/YHO6XSzXYuVXK8jJIHJ4+A4ZjRf4Y6kefc
         ptb5t9S1NcIP0M/UkG2FhV39U/any1WFq0S8inuXf/nSIVYliMNRxLqhIQCt3AuzETAw
         fkd167PEP2Bc/eAyzUD/vrsntL5K86lQHBG9iJjsF1ze/NLhN3RMupP0iwsJNULSzRSd
         6wVgA7avkw9EcyM4pJ/APcc8QeumRltSZRIcsN8Li7cZP9nuQtPYbJ2P4z/rU84bAtp/
         2FmKzhWe7DMBndTezSHK71R4XmXeJrYVnwqYeH9cPfNmOE1OYeaozk3T7bGRsvVHQJ6n
         f3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661311; x=1768266111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=;
        b=FLkNPW/eg6A6wiEmCn7MsBVOXcVaUNHTfRxt05xPsfR6jposbj4TjifTUYKF0UXQ7R
         USOSjWLgh2rXIEzMWe9wc4rxjdIomvtlRRJtFbzw8wbiTi/xAMNe94dcDi1UXnNVivZM
         XzRfw5w3gBfoG7tp1RCOQI81oZbo4pf8G355oX1nMsRdbpM/Vd+tO1U0BqGD2cezCs4u
         J6NOgnBdMBStvLgbeEFqwVMOnrByTERmntW6UySBxwvBRUbWjMA5SCPRSXGSm5Wid+Ur
         mVGhsurNlHHzPCBZACWLwdruK/XXflHt0zTTVFQWZmDeo7rjg/LjBm82yd6bTeauPyT9
         UcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2GUN9oGdMmPMGCtcykPXqDVnyfLDmjph0qvWwGHgmQG6/xNRjBUH2uSlfltIy7XsWV5Qep91vRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo652c/qU3r2T0/rU2igpu3LkuR/y4foiUi7+3ShAfTrXOB09c
	9Xmlyxw7fYE5SlNT53hVzLvv2rBcqd3NqbCn/B7s6DaObYNnk+rGZHUX3ywDdRqDGbitgnxase6
	0zcctqJDXwu5AzGmmgKaEiJIYlu5q73tnx+V9DGVEoQ8zwPXeIdoEIhr3L9lcjA==
X-Gm-Gg: AY/fxX7T0JKPV1TGSUhOH2Zi64C2tylhu2Q3DBWw+OPGKUqMt27BJXApyAg3UnLr5F/
	tjK0l4MmkjrAVE9FtYFD42Z+RJYRXzcZtUAZT3MfYzW1oyLWyy5nlh+GOnQvDJeRKf5a9RI/xXh
	WAzZQ3y9H/GwEKVyhWXMNR0VGYu3ijNFBZwCgB2G7b6h3H22n68B+XxILDqZmbe6RPYGn6bf5BR
	RKzBhl+b4SlWEQYcKbKaiW1WAlkhroxHNFJ6NDobRI5M8DbFdZZ7kc+hU6ygpEQIpGBCYtjeDOu
	SuN8ViXuJ/ex/XdHIeJtOFiaKLdb7srNKutJZcTlqwzs92gy1j3njntdkc4+J1AHNJYxt8WSYBf
	LQtVCcq3Y8cTNWjWAJWYTdAI0vv0cM289qFXk74znOe5rdaV1aU3NzOA316ImHCxU03/yUpAauB
	x8T0VjKtFX7LkaRKgugVBtHPE=
X-Received: by 2002:a05:622a:1b0e:b0:4f1:bdb1:eac7 with SMTP id d75a77b69052e-4ffa77d90b5mr19653291cf.55.1767661311315;
        Mon, 05 Jan 2026 17:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2rfvBff9pcaENAxSLwBaEsGSjWXENSQaskdKeKTaq/4/BVsPJY11d5lKCuvFHjQ51JK1SUw==
X-Received: by 2002:a05:622a:1b0e:b0:4f1:bdb1:eac7 with SMTP id d75a77b69052e-4ffa77d90b5mr19652881cf.55.1767661310654;
        Mon, 05 Jan 2026 17:01:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:24 +0200
Subject: [PATCH v2 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-14-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5744;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=q9y+Dif9HlWdcnmMDM5hAVRBaWF08BPAccXmvU/QVEU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7a6K+/f+otdXC4XFp/otfrE7F6zDF5dXqGY
 p3jobuYaHqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2gAKCRCLPIo+Aiko
 1bHJCACjyBHBDSElbc7bbb1YtK2V27VbPAlZja5rFSb4UmSUGf4P+/bMIGmkzvWg7VhiwA4AfuW
 zWuGcoDN0a+9YDfIDmOt+OJ3lSpRGzwVdeGlD0lHMm+Mlj//6KiMwpznilDD/vT8m3FsZ6+G0re
 y3KdWUNWmSrYVVFmZecqidWodYLjSVCqbiOW4PDhYRkzQowyaqvQIvDwBKYCgeDY1tm/ml1mk/I
 93200dHSJdLCidy+XZhi1tNb5DmG5avsiEnsfzMenn7iAR6PfbTg4CIRw71XFqvzzLb/CYWv/iZ
 VnLE/yCXgdBZaZVJU5gkoMhco6O2jM3H/uT41/Sk8jpCgx6B
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: JC3SpaRwJZv2qJs24x5JbdaNn2zUjYe1
X-Proofpoint-ORIG-GUID: JC3SpaRwJZv2qJs24x5JbdaNn2zUjYe1
X-Authority-Analysis: v=2.4 cv=Vscuwu2n c=1 sm=1 tr=0 ts=695c5f00 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=daeKR1c1ZtUuBhPExssA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX882WZhDz+hfv
 tNZqBVzIZcyvhI+LA6Ye9UDCubpDm/6snLU3mCCTD6dGnb00vdY/ZBHHKt5pmmlHvWgUpWp3gzY
 pb2Q+21p6u+eHC9psPDGcBMt1np1LafcDk2OYQniR/7gCSVvSbqN+7mqdLpUMoyP7vZCEjLiM4d
 iZFjrxaMzIzwUhpDLuzRcffz4xs9PPcCDh8p4k89Y/GMe9lwvZrt6d3kQVppivnJvslGypS8RlU
 +K+Jhd6zl5gzuhS00ZqJDt7qOmhmcodIsBwn+ZBj5B9tzDST+fq6Vg+Uebt2HGOWkMfTUObLG7H
 68DMIJI19VvIpBkzCNSCmyqfyyOvf/o0QCrdFm3NGJsGRhqgpoaXKU0Bm4BXgeZtN4MlMiyVC6I
 L9ukAU1yxFkGed/vaRnc9uFUFVG4y6WoqFpvlmHX/cCQ0hX0PJ7UOijE+6urWEpz8hHlHc2FqLU
 tB53vPjLxtloPjc0N3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060007

Properly describe the PMU present as a part of the onboard WCN3998
WiFi/BT chip. Enable Bluetooth part of the chip too.

[    5.479978] Bluetooth: hci0: setting up wcn399x
[    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
[    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
[    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
[    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
[    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
[    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[    6.842948] Bluetooth: hci0: QCA setup on UART is completed

[   81.510709] ath10k_snoc 18800000.wifi: qmi chip_id 0x30224 chip_family 0x4001 board_id 0x55 soc_id 0x40060000
[   81.521713] ath10k_snoc 18800000.wifi: qmi fw_version 0x32040163 fw_build_timestamp 2019-10-08 05:42 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.0-00355-QCAHLSWMTPLZ-1
[   81.554143] ath10k_snoc 18800000.wifi: failed to fetch board data for bus=snoc,qmi-board-id=55,qmi-chip-id=30224,variant=Qualcomm_sm8150hdk from ath10k/WCN3990/hw1.0/board-2.bin
[   85.467464] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
[   85.478132] ath10k_snoc 18800000.wifi: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
[   85.487223] ath10k_snoc 18800000.wifi: firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
[   85.758168] ath10k_snoc 18800000.wifi: htt-ver 3.73 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
[   85.901630] ath10k_snoc 18800000.wifi: invalid MAC address; choosing random

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 141 ++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 1eea9c5c6684..6ae6e07c37df 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -20,6 +20,7 @@ / {
 
 	aliases {
 		serial0 = &uart2;
+		serial1 = &uart13;
 	};
 
 	chosen {
@@ -66,6 +67,43 @@ hdmi_con: endpoint {
 			};
 		};
 	};
+
+	wcn3998-pmu {
+		compatible = "qcom,wcn3998-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l2c_1p3>;
+		vddch0-supply = <&vreg_l11c_3p3>;
+		vddch1-supply = <&vreg_l10c_3p3>;
+
+		swctrl-gpios = <&tlmm 50 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -598,6 +636,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	status = "okay";
 
@@ -630,12 +672,97 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	qup_uart13_default: qup-uart13-default-state {
+		cts-pins {
+			pins = "gpio43";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio44";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		tx-pins {
+			pins = "gpio45";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio46";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	qup_uart13_sleep: qup-uart13-sleep-state {
+		cts-pins {
+			pins = "gpio43";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio44";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		tx-pins {
+			pins = "gpio45";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		rx-pins {
+			pins = "gpio46";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio50";
+		function = "gpio";
+		bias-pull-down;
+	};
 };
 
 &uart2 {
 	status = "okay";
 };
 
+&uart13 {
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+	pinctrl-0 = <&qup_uart13_default>;
+	pinctrl-1 = <&qup_uart13_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3998-bt";
+
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
 &ufs_mem_hc {
 	status = "okay";
 
@@ -709,12 +836,16 @@ &usb_2_dwc3 {
 };
 
 &wifi {
-	status = "okay";
-
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l1a_0p75>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	vdd-3.3-ch1-supply = <&vreg_pmu_ch1>;
 
 	qcom,calibration-variant = "Qualcomm_sm8150hdk";
+
+	status = "okay";
 };

-- 
2.47.3


