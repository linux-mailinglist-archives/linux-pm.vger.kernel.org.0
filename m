Return-Path: <linux-pm+bounces-41128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F1DD3B47D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 18:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 594523027304
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD431D367;
	Mon, 19 Jan 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bdXh/LSc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LLpLrCFK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9772281369
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842484; cv=none; b=BggUv9ZsJ4A5LRZkuVR4I9DxLpPSemqd3fhU0yhdtdirDQdL4euojY7YJANR5nKTG+KqW2FkY6D4zHWbI/DueMYVCV8u2NujJgDumj7TjIjuDVvgBndrl0G4Rw1FGo4aDK3P1b/pqtYRGVGqb6J7lIiBIJVtn0Vee3r1DTKQoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842484; c=relaxed/simple;
	bh=pF+NoNB27rR2B5kf3GRbkX0b5W1kFhH3f5ZtNMnq/f8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eEys0GrqI3Hboo+neTnbjKKeG2Qzln7SbwhNRzMUk7gzfcBN840sBt5xDydq35h1QRzdOOWiuQ5kqsMomTykieVacoz0D0FJw5h9UrKxTw3cObQRHP+2VudzFUxJwB5uhY00FrgmZ9GmmDjzai2UgNgdaE/HBKLnBt3tJRjbjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bdXh/LSc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LLpLrCFK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JAJfsh1531113
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KHvHOGQMTvf7yVqvc6PEck
	mL8H0oxTcEyimip3Z3H8o=; b=bdXh/LScrAyN34xW7iSR9JhUU4/JDLdtBYuaVu
	2rK7iEJ1Yzc5f9Yr9HP4lpxQtDkrtk8gCtTw5lhOVk8p7tZAcQv+NTa/uxfLz4H7
	T9jiX/ZFL6tbs5IUuYlaZZ0FIwiDm7Yi5swCFGIFaUjMNi+9hqrzPWAdAtisbLBa
	1tGBU5pnf+2ycZtAdCIWTzCPHcj0ymchQ7O8TWz9q1OeTYFPottpuN2F8prLGABr
	jCNtelwgdjxNsUOzfAqims+qjjDi7tIZKh82LwD2eINE1FOlLp9QpFAAPspJFgqF
	TZcqlk2JQ6t0g7EyHBKBL+gKNpkWKSO0rhUxZvcT8/Cyx2OQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjrxs5e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 17:08:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a341ac9fso777143885a.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 09:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842481; x=1769447281; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHvHOGQMTvf7yVqvc6PEckmL8H0oxTcEyimip3Z3H8o=;
        b=LLpLrCFKrKmE17JHIik7kT/B69H/HzLeV5E7qZ36mxfXxuNvbL73kNqSKTUHi2Wpfc
         d8k5fDLTuCmgA23uYqPlYHfsxO3koqNyZfy98xFJd9flmR5UnEYs9uS0wY88XXGEfqzO
         LuiL+WKXC+ePhjL66yYjFCyKfYkmdOSzi/ZpQyT6pi3UHT/YX4bLITCsfneqn0tXZcNF
         UsMIik311azOUgHyQqBlsXig3lar/9yefEtUWPR1AMaC00WHHYvBGkp9AhHLXT1chhU+
         IFq4jQP/0W9OTGPpNZImxj8b1xPD/5Fq1fRQlGpB/a7NEuAWKFjVkW67RY5qhTbYXve0
         npYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842481; x=1769447281;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHvHOGQMTvf7yVqvc6PEckmL8H0oxTcEyimip3Z3H8o=;
        b=lZu9VJsn04WpNqLwxuWL+LvouHJ/b3ltVJN08gWRyWXG/dy8HVFOLDUc3lMCwP1ala
         khNpWeBSElgqWOmwIYuI2VBRaO3D9iJ+SQZu+5iUadVrNm1jPSZ7wY03ChAy9JZyimTH
         cUz0/W+IE6rqCgOXu3BW7Hqv/DxPcNWvUI+lS+wRPVXMpOi2qZ/u5vQhSwTZRpZ51BHk
         lQWk03zHxYvZlvKlPLZaROUi2prbM3aOgpePLXAOBVp9Rt3TqsWa0dcw153J/cJ4YHt/
         zvArw29FZU8oXyJ9T2OoY6QELbnVS6GyQdRNFLoeyMsM0vAmoUX97RjAwmCMiHOwxrbR
         u1WA==
X-Forwarded-Encrypted: i=1; AJvYcCWSSdQjCHs1HDyjWPH47q40YS50QnZCQMwRgIwC55QFvBxtYn36ei5VWCfphnOFd89tV0fes4odLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8vMN+GVAx8imRiy03mJJVn+KJuwtwmdmFkE+slv/iWbsrCeW
	ZOJEwKNGTVPMOysNkFmLCmt6JzKAhGx5BUJBD0sZlODorjcmXD8EzNpgCTjULAzSgOTVEX9eBHo
	fD6yBAjTNs33Sf+dOlMFd/GDnbZy+cbJudiDEjQgOVY9aP4Cec2vll0F3WiRujQ==
X-Gm-Gg: AY/fxX51XlWcQFcwQH+CVyYOp0Fs3rWArVRk/tuPhYNgDU1kEOe3oIi4MAn8VLx1YOA
	Jkbs0mek8a+9ZKTYMug/4uu2md+pNqGq3DMXJZ1yJFWPpzdsrL6d2IjKUo3CuRMXnGK3LxCAZcO
	sRnIdaMcep7D0Q9jqZ3EUPmk2J1PVtrwnAzZTpN15Fj2C6tHRjorbDgFSitnL3IFXhvi+lUGqQI
	ROcAOSmpAqCWBRQ/HIyZtHuprG/N0FQsFQoCbtYpedva9O+hHURTQIBC8uFz+3DuzY9D0DHW9ce
	cyrIBPatQza+kSgxYe/O1L4ZOMEOyj3Yf7Mu21L+CGppBeb9CEf81IRVOgkLxZeafQRa+yzqVqt
	uil3OLReI/59wakb4jE21eTGSrIRIcdDrMNEtc7S0HmuZHxYqKxSMVSaDrseZkhwEgAGIJCWsEO
	UdhcuXv5PbutvIyx5wlHzGVmY=
X-Received: by 2002:a05:620a:f12:b0:8b1:8858:6ead with SMTP id af79cd13be357-8c6a66dae7bmr1539046785a.11.1768842480983;
        Mon, 19 Jan 2026 09:08:00 -0800 (PST)
X-Received: by 2002:a05:620a:f12:b0:8b1:8858:6ead with SMTP id af79cd13be357-8c6a66dae7bmr1539041385a.11.1768842480440;
        Mon, 19 Jan 2026 09:08:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:07:59 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/8] Bluetooth, wifi, arm64: extend WCN driver to
 support WCN399x device
Date: Mon, 19 Jan 2026 19:07:54 +0200
Message-Id: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOpkbmkC/23OzQ7CIAwH8FdZOItCmbh58j2MB8aKkrgvwG1m2
 buLW7yolyb/pv21E/HoLHpyTCbisLfeNnUMYpMQfVP1FaktYybAYM8BcjroWuQ5o+3gdLhTbZR
 MTV5mXB5IXGodGjsu4PmyZofdI7phbZJCeaS6qSobjkmNY9hVygd05D1+sz407rm80/Nlfr0s+
 PflnlNGuTFpKRlkqtyfGu+33UPd3/g2lkXs4aNIxpn8USAqTGQSWCogK/CPMs/zCwO6b+ooAQA
 A
X-Change-ID: 20251229-wcn3990-pwrctl-cfa64f9d8167
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pF+NoNB27rR2B5kf3GRbkX0b5W1kFhH3f5ZtNMnq/f8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTtvK+kYfrPetMIGRSwvfUD63/MiSK/3+mtc
 BXPEUZDDN2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7QAKCRCLPIo+Aiko
 1QOWB/9emxmjm5KsLSNTBbh0w2WqVTrV9TpgDhif+2mOdRm1jJUm3zmOsS+0wKk6sdgrEEMjH1q
 pgan36DmIA7eJsTGQxhvN1C8aba4E1/JOhrwkt3xVVWJ2NQpNSqeb/SPMGogUkdqNj5mEwnoNos
 8z2KVckqEehWmhyRZSjUHn3/J2EdQh8W87GPyBzNt3kprOb+UK02x9XWK5MYIowJsXzt9sftW/c
 bL20sCjFsWLuAayZv2MUhFshX45o0Ngb7rkSIgJS2mIdZ137O+hhdQynSTNeGKTT3vU+LdYRo5k
 r3lNnSKHKAh7xb/cMtdvVJLScU+WPI5/hxzRh4DqPkljtTos
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX4Iw56BftXTGC
 F5zRDJwp64CrcU4GZql4umTtCF/X55mLcjlqocBKAgbiVGFgQC2sBDJucHAlcBm4nLVT5JXdF9V
 xkrm5uTFCfqDSNiYTR5U4r5ZTyVMw2xfUrPHvx9M9GRucR/wZtMGprn4YuUjfFwj24edcPBxeum
 iWmGA9uPupdEko4h//Ff3e5hPTaTA8C7ojVteKs/pthmTpauFgdo11AJ3GQiabTp98zPrwgzsfM
 I5xDJh0qb2E6xGTRpIoOYRXzSHHiheBkPeJ5Hb9r+29eFs63pnGToAa7m0jKybKUiQc4c/G1IJb
 VXKGo3P0spRYlaOYGkYUsvPz4d7h4+/xK2DsWek7cj07KL8mlA+/F4B0V5gbUl7lXEevJqgjb7W
 VMAL/GJWTyvi3AG/3iAJu+OApaKgol6m1H6Etc6SvqISteVHBg0+uW8s0L1m3BUwulzivY9UT8s
 c+3aYjXPL3pXO44uWjg==
X-Proofpoint-GUID: oMjKxTfjHWEybI8rhM4w_HCPTo25UxAq
X-Authority-Analysis: v=2.4 cv=PPUCOPqC c=1 sm=1 tr=0 ts=696e64f1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sVAF8I02KzBGxPgs2jAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: oMjKxTfjHWEybI8rhM4w_HCPTo25UxAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190143

Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
the later WCN / QCA devices, but they still incorporate a very simple
PMU on die. It controls internal on-chip power networks, but, most
importantly, it also requires a certain start-up procedure (first bring
up VDD_IO, then bring up other voltages). In order to further unify code
supporting different families of QCA / WCN chips and in order to
maintain the required power up sequence, properly represent these chips
in DTs and modify drivers to use power sequencing for these chips.

Backwards compatibility with the existing DTs is retained by keeping the
regulator&clock code in the drivers as a fallback.

As a part of the series I've converted only several boards, verifying
that all known instances of WCN39xx family work (fixing the issues
meanwhile). The rest of devices might follow the pattern later.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Dropped patches accepted by maintainers
- Changed ath10k to call pwrseq_power_on() unconditionally (Jeff)
- Added copyright headers to the changed ath10k files (Jeff)
- Link to v2: https://lore.kernel.org/r/20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com

Changes in v2:
- Split the WCN39xx PMU schema from the qcom,qca6390-pmu.yaml
  (Krzysztof)
- Expanded the comment in the WiFi driver (Bartosz)
- Changed vddrfa1p3-supply to vddrf-supply.
- Link to v1: https://lore.kernel.org/r/20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      Bluetooth: qca: enable pwrseq support for WCN39xx devices
      Bluetooth: qca: fix ROM version reading on WCN3998 chips
      wifi: ath10k: snoc: support powering on the device via pwrseq
      arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT properly
      arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT properly
      arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT properly
      arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
      arm64: dts: qcom: sm8150-hdk: describe WiFi/BT properly

 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  60 +++++++--
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |  60 +++++++--
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts |  66 ++++++++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  69 ++++++++--
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            | 141 ++++++++++++++++++++-
 drivers/bluetooth/btqca.c                          |   2 +
 drivers/bluetooth/hci_qca.c                        |  26 ++--
 drivers/net/wireless/ath/ath10k/snoc.c             |  53 +++++++-
 drivers/net/wireless/ath/ath10k/snoc.h             |   3 +
 9 files changed, 430 insertions(+), 50 deletions(-)
---
base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
change-id: 20251229-wcn3990-pwrctl-cfa64f9d8167

Best regards,
-- 
With best wishes
Dmitry


