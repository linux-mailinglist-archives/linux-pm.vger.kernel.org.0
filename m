Return-Path: <linux-pm+bounces-26921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D988AAB11B5
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EFF1C05F56
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAFF28F93E;
	Fri,  9 May 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEQadB0W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEB28F936
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789027; cv=none; b=Aup2KETtFOAYpYD6bSjzdQHHDDxWDXLyNiHUdHda8EmxPO+lnaQtENepfVT3jZxp0gD2aTWGElkvcrkxhInlf4VX5Bbl9wzLEbg88O0Yv3oyRLineUhP9iwm+ybirHs99LRpRzViZDAjWeZbpxuiXAUi0b4yRkAzgowhfAZLPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789027; c=relaxed/simple;
	bh=7dfdnysPwBMKS+82Clp896n3dU2RRsYEI+dYVYgZi0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tVZVFZ2tQRCuXFWxf+Pu7TqvdhZ5vtItfYILzptVfaqJ8s+jMPDLUhACYSc1aNw5586v8noWvyPxtfj1V7HRla4ct5SVA6RROJ+NwSimpmIrtbU/ZSfW+2VouM06WvD/OgeEuaAPhIrok4HvTpIsRsHsWGLzbcaZD0xLQnBXffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEQadB0W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54939NKH002148
	for <linux-pm@vger.kernel.org>; Fri, 9 May 2025 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WChW6NT2y3bT2Dd/AmO3BGrFqcOhrO0ctaK
	cTuAnPQ0=; b=DEQadB0Wx4paKl+O0rMDd+e5PkqMSktpxSPzcNt/mHl3boUJZ53
	X8MpcQFpM3kI4Amx2zppnN2ALw6wj2tDhHmf9t0kSE/NrxEsJ1RnFguC8fX+a8/e
	TaTCrkQjYe3KoZ+Vb59sOW96igq9eFMQXoQaXKhhMnxP2rpZmZ7EraDnpAcT1s7N
	KSy3CBtMHZfptPf3tvU1uOeKcvA+W6E2gQB2NGJnCPXLdhq//Cpq+DrJPl+MXdvX
	5yY8LajqNzU+F4IptUys9BWvEvIRUpGBnzL9xkTA+O47D1zppNDMp8ztAXW2sIep
	7Grcd0Xn66ldTlLaPKAfK3ctVKDbJgOTmPg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp5cd9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 May 2025 11:10:22 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736b5f9279cso2060391b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2025 04:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789021; x=1747393821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WChW6NT2y3bT2Dd/AmO3BGrFqcOhrO0ctaKcTuAnPQ0=;
        b=e/LWw0tC2YLO2LQPIzth8g/TBG/Tt+AzRTG01AGhNw4FvSoRopFDouxOOQeRjnFfBS
         bFuP7TJWhgYbiu/RJleXcShvCybzX3UHJW47AP3FuxGRCu5QYsquTpjFlmYD/qfGI2qS
         hu8n7CrPiwcIO5VGk3/YZxrYF8flaGRaKULRNGbnMGpT7e9Xw25GvhNH6wzqR5n6H6X2
         QEovN5m63yIqpG+Xl/kWC3wQAvj0OnhpdGrgMKwHg9xDc8Vp45XHVyub7fWjknLPTFig
         1m+tihNO9hLmCUeu6xGR1lZqkk2YjvNdWOOZMDxl8RuuRnMRZD7PUOjJyS6QXkNg7wXc
         1zEg==
X-Forwarded-Encrypted: i=1; AJvYcCXA3Aqgxlpp4s63PHyK9mPlHMDwdwdXg0ruyWN/Ja1KoeKqtS987Ngo/CiXsZvtj73EB0k2JX3rXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtR2DXseDFbvM6OPJVJnL6D8YfbtewT62g80uq16iQXtFECG5V
	0dKgSd64nbhOYfhjH+4AMBceGAIWx53lTrEPd2qqh0/4GTCHUmI16xII1oQCXaBG6JmhG/e4EXq
	6RpbkgWSDEBAw55ZvJcSJrVr3MKBZY+V9jH32fyrn6j1ircJpkuM7hVh1TQ==
X-Gm-Gg: ASbGncuRcs9NEItKaPrxs2XXuHFOW82uzWa3WnAI6HyOIqCtrpbyeZcjwCPAloloW9a
	A7bgjXZyYzjvUl/2kP3TpjZ/sB4z/xrePM9s6yLySBcVOSqbOGeVRI5q82tchWPIEzv8Kk1NHYr
	rUybuawug2Wfruc0glbGkEgWDtdoU8hGYqTtS+1nWQhdffer8GLz75kZdaOFnYWncpMzLsXEHTE
	UVmouVLTVX+qhwxur6SEaV2BPQP3Atv34h0onQzWE6zVIuDlipYDOolaKFEaAoy3nIWm0+u32Du
	MG1d1ECIfkQ6J81V63HdkSpAO5Hvx5d4P1x8S7qnYpYgJ5E=
X-Received: by 2002:a05:6a00:1488:b0:736:5438:ccc with SMTP id d2e1a72fcca58-7423be886d6mr3590863b3a.9.1746789021321;
        Fri, 09 May 2025 04:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6B4hUPZkyN0EguRbayUTn9kR7wQ+X/PQBVDr7XZ2boU57acIR/MEr3SR0hxpbREh4Zp5GUg==
X-Received: by 2002:a05:6a00:1488:b0:736:5438:ccc with SMTP id d2e1a72fcca58-7423be886d6mr3590816b3a.9.1746789020855;
        Fri, 09 May 2025 04:10:20 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237734c4asm1556223b3a.57.2025.05.09.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:10:20 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
Subject: [PATCH V6 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
Date: Fri,  9 May 2025 16:39:54 +0530
Message-Id: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XL0wSRhE c=1 sm=1 tr=0 ts=681de29e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=N0aDCOoQtnTZPCUHnXIA:9 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6fV-CiAfkcvF23AuI0zBTtqJ9z63Lt6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNyBTYWx0ZWRfX0TPBROG26YGz
 khRJIKFA9MwZlDrub5BSHJokAraYvJb1HuhmAQ4lqLLE5YjY+N7QiSBbvSvqgN1fdK0YOuMAfWe
 KxFqgzMT2lPTjz9Ck0FanO190F1iNszKMPzT69tRwGo4U3yrjiqJyud8QCqc60pb+S01a8hZhi4
 NU5VTzyuKhj/hhS83OP0CmFK0UjIY598a/XrQzwoTxa+kD/1tdHZ4PiwYecpiH6SZ0rSq9LRTST
 wZpMCDGmqQE7bltVesUmjtWU8T7oBMCd0f3q9rwD4X5gGcl3E9oD4/QRpOhZcKW7qpJLkGsNjwU
 wAQ8cKBaTSZOsB9CuBuwqJcRktnkEjYgKFPPnND7GVBoG7Sym3F0tICdG1MOSzmNXXzbLrEJ+0+
 CPh92d60/StpfuqZ7XJ7VXE9QC1j/LnzRiZ4yuACeamJYLMepd1X+rRV+A9PCGs7HkdZIdkS
X-Proofpoint-ORIG-GUID: 6fV-CiAfkcvF23AuI0zBTtqJ9z63Lt6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090107

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same driver.

Patch 1 is a cleanup, to move the QCOM ADC dt-bindings files from
dt-bindings/iio to dt-bindings/iio/adc folder, as they are
specifically for ADC devices. It also fixes all compilation errors
with this change in driver and devicetree files and similar errors
in documentation for dtbinding check.

Patch 2 splits out the common ADC channel properties used on older
VADC devices, which would also be reused on ADC5 Gen3.

Patch 3 adds bindings for ADC5 Gen3 peripheral.

Patch 4 adds the main driver for ADC5 Gen3.

Patch 5 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Changes since v5:
- Addressed some reviewer comments in documentation and driver patches.
- Link to v5: https://lore.kernel.org/all/20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com/

Changes since v4:
- Split common ADC channel properties out into a separate file to use as 
  ref for ADC5 Gen3 and moved ADC5 Gen3 documentation into a separate
  file as suggested by reviewers.
- Addressed few reviewer comments in driver patches.
- Link to v4: https://lore.kernel.org/all/20241030185854.4015348-1-quic_jprakash@quicinc.com/

Changes since v3:
- Updated files affected by adc file path change in /arch/arm folder,
  which were missed earlier.
- Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
  instead of adding separate file and addressed reviewer comments for all bindings.
- Addressed review comments in driver patch. Split out TM functionality into
  auxiliary driver in separate patch and added required changes in main driver.
- Link to v3: https://lore.kernel.org/all/20231231171237.3322376-1-quic_jprakash@quicinc.com/

Changes since v2:
- Reordered patches to keep cleanup change for ADC files first.
- Moved ADC5 Gen3 documentation into a separate file

Changes since v1:
- Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
- Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
- Combined patches 8-11 into a single patch as requested by reviewers to make
  the change clearer and made all fixes required in same patch.

Jishnu Prakash (5):
  dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
  dt-bindings: iio: adc: Split out QCOM VADC channel properties
  dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 155 ++++
 .../iio/adc/qcom,spmi-vadc-common.yaml        |  87 ++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  81 +-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   2 +-
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |   2 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-
 arch/arm/boot/dts/qcom/pm8226.dtsi            |   2 +-
 arch/arm/boot/dts/qcom/pm8941.dtsi            |   2 +-
 arch/arm/boot/dts/qcom/pma8084.dtsi           |   2 +-
 arch/arm/boot/dts/qcom/pmx55.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/pm4125.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm6125.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi           |   2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8937.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |   2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi          |   2 +-
 .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |   4 +-
 .../boot/dts/qcom/qcm6490-shift-otter.dts     |   4 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |   4 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |   4 +-
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |   2 +-
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |   2 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   2 +-
 .../dts/qcom/sc8280xp-microsoft-blackrock.dts |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |   6 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |   2 +-
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts |   6 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   8 +-
 drivers/iio/adc/Kconfig                       |  30 +
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/qcom-adc5-gen3-common.c       | 104 +++
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 763 ++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c              |   2 +-
 drivers/iio/adc/qcom-spmi-vadc.c              |   2 +-
 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 531 ++++++++++++
 .../iio/adc/qcom,pm8550-adc5-gen3.h           |  46 ++
 .../iio/adc/qcom,pm8550b-adc5-gen3.h          |  85 ++
 .../iio/adc/qcom,pm8550vx-adc5-gen3.h         |  22 +
 .../iio/adc/qcom,pmk8550-adc5-gen3.h          |  52 ++
 .../iio/{ => adc}/qcom,spmi-adc7-pm7325.h     |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350.h     |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-smb139x.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-vadc.h            |  81 ++
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 193 +++++
 67 files changed, 2231 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
 create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
 create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h


base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
-- 
2.25.1


