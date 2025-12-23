Return-Path: <linux-pm+bounces-39884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E6CDA0E9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F2B30A7452
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CFB346A1B;
	Tue, 23 Dec 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRQ94JdC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kugtp5Da"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7C346AD5
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509726; cv=none; b=ZkUltHJ27uF3L9fsUfighxRMTe+s3+rOGfJL8FDMP8L2Ic81oXJzat6uag0oRjjapgRhLlqSA1zykhfhJlXO2FHpovQrQuemDgW8MMayl8xiK5Rt+mBPSWNXal6lDQbr9ervb/99PWa4wAydNFXe8ydB3hXc5vQ5l9Kn9p+v65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509726; c=relaxed/simple;
	bh=zyaMjYOjFDa2SPj03vZF0IuCzZxO/R2dcgFXOkM351U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiNQC9QBlQod3/Yv0I2ARVoivtAA4AmDmjdjg1ybdQ340eTmwdOXlFGC4IbLjefz+mgRWX9k6/bhyTvYGvQyF0HbVYVF0Dp3BPZNw+g6Wk3txSvir7KSu0wF7/V8CvinKqccD8dmwkL/LIIuwSOAQpGgz1ZfmnwBLhf9B8gSyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRQ94JdC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kugtp5Da; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNF691m4044367
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4yj3uTrVzY91o9UvaViQBsZAb2B7yFqWeP8MulTCY84=; b=HRQ94JdC/hefFDBW
	iPfjuxwzKQK4WWDPHUStzcw0jG0SS/3p6dePwPKdrnLb7uevq/bTf4RE4a7V4o7l
	15FgRsJj9+oL7ntE8LJAm1Dh5VQXY5cqqeAwuHvo9YDPBZMdSvOAmrdkFzuE1+Jn
	YS4xgic1/ZLEjQ03grjHb3t1rVL18wSFv2KnW+RSZAV3Wv4z8kbfQ8pCpWwOWYn+
	i0QoZXVfXP/cK6hAoRh8j0GOhFYrn/jFTWUOgVbFNfkNV/VXyyIHBPsc5RVeBazN
	WpjRF8KN3P6TVgppW32Hp4dyZc5aRoBYAItphLf8HQWJYJoGjJ9T5PR8pZHztIJX
	JMmZSQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7cuhbec4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso165201715ad.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509723; x=1767114523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yj3uTrVzY91o9UvaViQBsZAb2B7yFqWeP8MulTCY84=;
        b=kugtp5DaIbNCGzbw7lHrhGa8jTHFCWuk7TwOUTvP8ay7sYnayQsw2k2bEO5QewlQ9B
         jX6Pk+IRWMCwa6dk2hA2bTuNtiQO084fNT9CKwTLC+FhIDDVRKuFF2leK6CaLVl7P0Em
         78LbS9xHloPMgwFXw24mQkVYbthC5kdbzPNcF15O16UbiHmIlp20mPpUye6oKJNxswq/
         ALkMusAcZTCeVFe/kihuASl7Ho8trLJTt92SMiGrKzC0YAoa8OmO2m7+ThvH/wnEBzsD
         of7nIJDUv3JTDIhYgI5Vqtnyvw4uErl2NWGo6fDz7lzBeRjDZCU/QtU3qxMa0hGCXGXp
         exGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509723; x=1767114523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4yj3uTrVzY91o9UvaViQBsZAb2B7yFqWeP8MulTCY84=;
        b=jLF9V3hj1+xKVaecSrj58/9En6/H9FZ/8arsHuueOIi0a1em+AUJ4mit7DvFGvewib
         3irUNW/n2u8y2yERHlJ9XwtwdPko/yqCA/3fXBLRtXW38ExmVToEX9gQb+IlezjWrBdF
         skysEn3U39bl++lSLy8AlNJBTd2pPLpedwu6bDSTE1HyqfVWc3rTnX6zmLnS+kGe3QW+
         MNoxmFfkQcr5Y0LHSpJfqqEgXahAf8ZYQunmxJWEnHbARV6mkwb46E/Ajr3IdEWvWFBy
         1grs2J7QGYjVFd303v1pXTeK23C3K+kHKmGpfWrr2+02WvDfcY6zgxognPWinFVVgmhv
         86aA==
X-Forwarded-Encrypted: i=1; AJvYcCUsSihWupSO+WOBCukQRFJIU3a0wfk26NIkfekioAH//szjL825a3tPwfAcplr2NBhdUKXFeJeQQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzacRfLWrFcAM9GCJN7YlJCC8l4qs7ZN7myXiTBxSqEhGJCKb3V
	5IuAZgFb/xlmZDgELvwVcsem4hIjAN41/aUhPDGmMrbyL1suVAmAAx6lQ4ylHbUtHEzp/GC8BQ0
	5EMzk/bN/XDLfdUVpz2as9PCXQTYl9MZ51yw5E3QApYZRly3Lx2QlK+shNiUOqQ==
X-Gm-Gg: AY/fxX6JEXcC18eR4G4Tq8tpVfL+cIcVNAFxag4mktIi3mWsS6y9WT2cT9Z9lmnUi04
	Oov700vwwAVhzpELCHmfAyu5T9kDEZWNpw3rEHHTl4r6OSMGxUvFIH3tZTXHPiwQLvvI2RFacKd
	KrXvRQ1DVM7ueT5H2wh25clWSyi/CtsPN10zQQTIPRN7fgTRiamv8Em4Q8MuZfN0WB1YKq9UpHQ
	SMc7F4GA7ctAno39mIZ5xhSiETyOo0w4qknWkJQBS+4HnuW2Si6+78EocrZt0afE4hKB8OjpjOv
	bZRpzN2dCG4gYkqfaauXCyonPZ/5UraEWZpExHDIO4mxWAm8E3nZEk31dKHgluQh3ZZvnHWBOuS
	55u4QiYLkib8eIf+mgN2fDwpmyAkylzkOp4mA0KXh2YwNOA==
X-Received: by 2002:a17:903:40cb:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2a2f2a41a37mr134505395ad.56.1766509723261;
        Tue, 23 Dec 2025 09:08:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ1Fj4uQ2liIo6VAlU6QcFtiDsvDxHyH17s8W+Y7L2nFddhJNPJyS/P7f69uV1PpHS/k1faQ==
X-Received: by 2002:a17:903:40cb:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2a2f2a41a37mr134505105ad.56.1766509722777;
        Tue, 23 Dec 2025 09:08:42 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:42 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:39 +0530
Subject: [PATCH v18 08/10] arm64: dts: qcom: lemans: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-8-32fa9e76efc3@oss.qualcomm.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=1079;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=zyaMjYOjFDa2SPj03vZF0IuCzZxO/R2dcgFXOkM351U=;
 b=Fc6RcorlMm2rMSuJrm8pkanAycaULDpxTiofIummpRV1QoobrxYOeY1At7M9D+rjT5F7WnjZ3
 v2UfekVvNiMCKud9qP77Krs9vT9ns3zLwBMv4XgHL8PEmD1/jZ2sRZ6
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: DfRDQTn7alL0EzHo_YOxqFEia0XmuKyo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfX+/okz6CwaG3L
 qN6vxMbFjNcjUgYJzoxhqSW2VbvWLpYe7ZZSV9ftdpt7lasSf3JXF6ZwMolBDGoc7ImOd+089m4
 uaLHxnRbHrGZfXT9EsXAks9R6vpA75u3pBE6H/63E6YZiyvSfyfvItFpZA1NoJ4offFHdsb8kpt
 mtZAW+cJyAtKPIQGdlq1/EeY873dwrm1j7BOTtU9Au8il99EGuKSaXDUMvtRLOIM6BKUxQuSjSw
 wxI5yBaB0g52LVEFRTxch45Jj0Qb1OF6o/MHsqsl9bmB393P/n1d53kNGaK3XIrjno1EaN62I37
 EMuX5xAadv+NP9q2fHXPN4QcIsFkW2ZjNheXFsOJ08iUXRbHoXRgwYEYmTTnZ9coUmzlsADVoiz
 OJN7He81oNB1kneP9c3ELU/v7GZAYIp60Fzcmzs00cdrnXs3kN6bR4U+FzBK8jHqOHN3zCNi/52
 f+R8GKFBUyTA2QxJesQ==
X-Proofpoint-GUID: DfRDQTn7alL0EzHo_YOxqFEia0XmuKyo
X-Authority-Analysis: v=2.4 cv=NZDrFmD4 c=1 sm=1 tr=0 ts=694acc9b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ld_RF3OM1xByVwKNVVYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230142

Add PSCI SYSTEM_RESET2 reboot-modes for lemans based boards, for use by
the psci_reboot_mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 0b154d57ba24e69a9d900f06bbb22baa2781cc3f..cc70316d6949c8a36280b85931c4adec9cd60f62 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -698,6 +698,11 @@ system_pd: power-domain-system {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cluster_sleep_apss_rsc_pc>;
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


