Return-Path: <linux-pm+bounces-39876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08649CDA08F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F6C3300102D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D189C33A9C4;
	Tue, 23 Dec 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JI07FKpz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hofFpTLZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A602D0C8F
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509683; cv=none; b=iBTy68DF4/qkLZu0Y2t98g/Qsxp3goxWOo+IIKiU6G8Pn3Ld02d/nMB04xF99zAfrMjvFicRjQObZR3alVhAQD5dG6F/JcdBdl3WwS9S6MDU0gLR6/pXiatuAZXXP2MlV7hZUNbZI9vc6oXFHyHwUuglLxRX1h8dxyiVLdkTlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509683; c=relaxed/simple;
	bh=hUihycywL85PF9Y4rchFSopxS6VgQDH7nDccoCsKQFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UE42LgF/Mutov7pZJ1Aa6H5hxjl/YuAzIWKqgrVF5fB1iJffEQxcBQt+z2/XvEsyspIjG0dk/aPJncSHxmXqy7PXMCHOOeigIec0c7VR83QOt19W6OpsFZ045d0EzI+BTmLjpcMNYb5AJ+yUVM4kHPLHVZ3nEYsHAg3AZ8M4dQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JI07FKpz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hofFpTLZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNEsAt2462173
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TYyY7ah2Jw11z3Z+CXVq7+
	GaV0AkNjl/ELid+DxM5qk=; b=JI07FKpzCvOgALLXlMNTho06SxTFH7RVTE6Q91
	8pHMNoAN8kRiWrL4U3sthvM0KaWuTxvCcbz7dDyGb1i/TkXuPzdYR4EysUSAaztA
	LGOaSRSs1M9M8K6yeJRxu6tX4t1/C0AEePudpZJu4Yb72LFJnAuE6eyPbri5VZfD
	2DHb6Qb8LLqUx/JkT79p31Im3gQgza27EU/LCspUNt3bxgcJIfsv+pIlkJTuJFy0
	uSbtbtf3ng0wUFfv9SWggXFSQGENZMyOLpGJkxyDueWutGdhKoODgcCMBmOhLsMD
	mGpqA7MBRjbBr8ProcGJOSfjDHHkhf3O2qF1sGwIYg7U2c/g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8frea3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so10854488a91.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509679; x=1767114479; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYyY7ah2Jw11z3Z+CXVq7+GaV0AkNjl/ELid+DxM5qk=;
        b=hofFpTLZK/coZEMjPhBS5a1SMVUknFjCvLu/n5AkVfz4CcvH0PDlZWJj70LeDOG06G
         HCc27Oqy/Z5xCJUYNnWZjUB9O5aRpGCFB8G1cFa+VIBtbVo0E5wOddhKlPM9gsbhxAFg
         NHYq9MWDvVYG8VeqilhfYas4awQnrLqLcVpKnQsjyK2BBo97B//nj4wvP6Q53NLj6S8R
         a92dnRd+ww/mNiloabqgo6TAzMCmD1cAvVQNNL2KawJh7gnUp2lqHYQe+wqqHraulwZY
         jDMKzLSoY4kazXd3j6J4w8nyYpVX6tzlXzBGQjUierkmSJ+w/wSdcf9hNF5y4IqrOwyg
         Fqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509679; x=1767114479;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYyY7ah2Jw11z3Z+CXVq7+GaV0AkNjl/ELid+DxM5qk=;
        b=sh4YugfXOLQQuw/vur362DgLA9UqTfQfip4T2mTFKSwXj1IPRHml8LLIVvyneJ62Ra
         Hdz1b521H9ByD07QLqBCNPsusfg6578URLCU16RDkjM5HH/vl3sEpHMxo5hKK4pJXly9
         Q1Ks98kzGbKrQbOrur3FuZZiAkPk5KB2HqW6NXZq0Oc+DaRfj0QTQ710mykuhxQg4tV+
         hLRHDN1e87iDdDTwFgfBLO01I7J5xeY42SaCt9Zvp7jddPV7HfWFt+UZoR/j4NpPVgCl
         t/iJUA+BqjZ46hdRTX1khRONAmyq/LdV+EUlLnIjtZrvB/FcWnbqTtThyhElFBzjgSqf
         jWVg==
X-Forwarded-Encrypted: i=1; AJvYcCWd541Yeg4dOK9tmD7/skIJqdgwtXTAeVSdFofvooxlbqwvSAfdN1mCqqysMPPSE6YF+uKZPQ634Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ZIV5R/7A/Y2TUu+JXEFBHJuaynSOu0ZivUP8ZAn3CrvO6ph9
	rQyYvbLmho7u5CjZfcqZfg7uP5HCJPHkDMWZVRI/y7UbBkB5joXf5YWMJcWMBH5lLABEuexzdau
	T0Cp5ukfJESFOXU7L7ZewBlXpUX1foXCQUo9IyRCsOSLUG7tQxU2jWg9xZAV9AQ==
X-Gm-Gg: AY/fxX6xKQvcMW7GKdgbkfDTrhmr8RQL4UyHT7qsqmy8pkkRAeTLmotKmWnKCniFOqg
	coCvNOl8RCI3fMpfeNGosb0jJJdhthkbJu6oBV8bX35ZpfbLY/X4GVj76OZArErU/YqE9ZZz404
	P03l0po4AgHYq8hUZ7WlzRZ1lJyFnoKgkqbxpnMIwdPwn/J/1FTIHQBTfNPDnCRCrT5SkWgV520
	wwRkUG36cHoJ/hrZvy1Sbkuzj5w+kws6o8nVhoycnoCGRE6wr8p7eEhNWBdVYloxcqhpJmVib1U
	jUCKJm6iaa1Fp1ARSM2utAV/WWmvpfRrBH5XtAjqzTdHqL0JkxnpRw8f6Kck1SeKvqt2iXGPFOY
	3W27iN6zJbgZebfj+vLUrWFrS8BRO777xeb9+PfOOc6wY+g==
X-Received: by 2002:a17:903:fad:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a2f2212bc9mr165259465ad.6.1766509679128;
        Tue, 23 Dec 2025 09:07:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzTAGkfneiWjJN56t3DFRmzV/VbdJJfE/rgFumm4JrOfPUx/Vf2JfqrVBcRNOeASmH99AHGA==
X-Received: by 2002:a17:903:fad:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a2f2212bc9mr165258915ad.6.1766509678505;
        Tue, 23 Dec 2025 09:07:58 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:07:58 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: [PATCH v18 00/10] Implement PSCI reboot mode driver for PSCI
 resets
Date: Tue, 23 Dec 2025 22:37:31 +0530
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFPMSmkC/53TbUvDMBAH8K8ifW1Gcpc0V1/5PWRIHq6uYNeZ1
 OIY++6mQ9xAC9U3gRzk97+Ey6nKnDrO1cPdqUo8dbkb9mWj6P6uCju3f2HRxVKoQIKRVjbCpV4
 ccuhEPuaR++fEmUcQE+/jkERiPwxjFroOJKXWrg1tVaxD4rb7uAQ9bct+1+VxSMdL7qTkXP6KU
 HJlRDkmpGBrNVpCjDo8Djlv3t7daxj6flOWOflfqoeIngg8k/mpzheYlLpt2q7mVeFjiwweFGH
 AJR5ueFCreSg8We8CctAAvMTjLb++eyx87SkCojLU0BKvrzwps5rXhUcboWlN40Ljlnhz5RuA1
 bwpvA2MThJZatUSX3/zSv6h+3qenIYcR+cAefHt7ZVXq39UOVZ4XbMk44PT4Zdx357P50+1cLY
 j0wMAAA==
X-Change-ID: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf
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
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=15960;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=hUihycywL85PF9Y4rchFSopxS6VgQDH7nDccoCsKQFY=;
 b=ob1YaDeC13DNqdo2iji6rAxg58zfmnI1dY5yr4OIBv0fcCTyAQAgKtzxaP3YRE9mWyPwRwoKS
 6bZH1ntwpvfBGKtsilKpMM1GAQ8EZl9FkdueQm5JFURn81AUzawDi5R
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: aobGCD6FrccCxKO_T2rOsCBNrp82PdMC
X-Proofpoint-ORIG-GUID: aobGCD6FrccCxKO_T2rOsCBNrp82PdMC
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694acc70 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=g5qxB4vbiz2qMc2ulawA:9 a=2TqwiA3C7SzmGfX5:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfX2OqsxMEtw5Ud
 GDq90MpoFMmsGXKMmMLMo0hqPJgtC2tsmyusYYzIz4VnLw4V1znuwRM3bZRajfnn+xlJz/USfSe
 UKKugAltukEhbXdxE4rU9hRpGy1ZMUJEJf6cSDON4Ro1ONgv5+cmuJWWddpRiEFi4uFJ7FEaBFl
 mdrgsd2gPEcFGowVKBdA+JW4PUWMrp3rI9AqpP4e2QEkLc0yY73NdjXQWepHDZCImMAgYxXL56c
 dcgT7yW0PATL7iBLlSTA92yIpRNUcI2XPoYbnriNgf2GmZQHPYoj0oZ3v7Sss1Fo8BQ5zRx8LKM
 25FB6ba3z+cKoZYp/OIkV+R5hwoFFq+WMvphSZ9pJeuK5tPfeRM0WGdpWnqP6Day+9Ou0BmY160
 7uO5WbRyMjkhYM3+bSONy8XhnYiL0iRJ1HDOAI/w/ayy2S05Gp1MZk60SpQzfqDBXLyXglNGpjb
 XblF96cnpAADtPlySng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230142

Userspace should be able to initiate device reboots using the various
PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
patch series introduces psci-reboot-mode driver that registers with
reboot-mode framework to provide this functionality.

The PSCI system reset calls takes two arguments: reset_type and cookie.
It defines predefined reset types, such as warm and cold reset, and
vendor-specific reset types which are SoC vendor specific. To support
these requirements, the reboot-mode framework is enhanced in two key
ways:
1. 64-bit magic support: Extend reboot-mode to handle two 32-bit
arguments (reset_type and cookie) by encoding them into a single 64-bit
magic value.
2. Predefined modes: Add support for predefined reboot modes in the
framework.

With these enhancements, the patch series enables:
 - Warm reset and cold reset as predefined reboot modes.
 - Vendor-specific resets exposed as tunables, configurable via the
   SoC-specific device tree.

Together, these changes allow userspace to trigger all above PSCI resets
from userspace.

Currently three drivers register with reboot-mode framework -
syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
list of commands currently added across various vendor DTs:
 mode-loader
 mode-normal
 mode-bootloader
 mode-charge
 mode-fastboot
 mode-reboot-ab-update
 mode-recovery
 mode-rescue
 mode-shutdown-thermal
 mode-shutdown-thermal-battery

On gs101 we also pass kernel-generated modes from kernel_restart()
or panic(), specifically DM verity's 'dm-verity device corrupted':
	mode-dm-verity-device-corrupted = <0x50>;

- thanks Andre' for providing this.

Detailed list of commands being used by syscon-reboot-mode:
    arm64/boot/dts/exynos/exynosautov9.dtsi:
	mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
	mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
	mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;

    arm64/boot/dts/exynos/google/gs101.dtsi:
    	mode-bootloader = <0xfc>;
    	mode-charge = <0x0a>;
    	mode-fastboot = <0xfa>;
    	mode-reboot-ab-update = <0x52>;
    	mode-recovery = <0xff>;
    	mode-rescue = <0xf9>;
    	mode-shutdown-thermal = <0x51>;
    	mode-shutdown-thermal-battery = <0x51>;

    arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
    	mode-normal = <0x77665501>;
    	mode-bootloader = <0x77665500>;
    	mode-recovery = <0x77665502>;

    arm64/boot/dts/hisilicon/hi6220-hikey.dts:
    	mode-normal = <0x77665501>;
    	mode-bootloader = <0x77665500>;
    	mode-recovery = <0x77665502>;

    arm64/boot/dts/rockchip/px30.dtsi:
    	mode-bootloader = <BOOT_BL_DOWNLOAD>;
    	mode-fastboot = <BOOT_FASTBOOT>;
    	mode-loader = <BOOT_BL_DOWNLOAD>;
    	mode-normal = <BOOT_NORMAL>;
    	mode-recovery = <BOOT_RECOVERY>;

    arm64/boot/dts/rockchip/rk3308.dtsi:
    	mode-bootloader = <BOOT_BL_DOWNLOAD>;
    	mode-loader = <BOOT_BL_DOWNLOAD>;
    	mode-normal = <BOOT_NORMAL>;
    	mode-recovery = <BOOT_RECOVERY>;
    	mode-fastboot = <BOOT_FASTBOOT>;

    arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
    	mode-normal = <BOOT_NORMAL>;
    	mode-loader = <BOOT_BL_DOWNLOAD>;
			mode-recovery = <BOOT_RECOVERY>;
			mode-bootloader = <BOOT_FASTBOOT>;

Detailed list of commands being used by nvmem-reboot-mode:
    arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
			mode-recovery = <0x01>;
			mode-bootloader = <0x02>;

The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride,
qcs615-ride.

@Florian/@Kathiravan, Please note that reset_type in DT needs to be
full in itself with 31st bit set. (eg: 0x80000000).

Previous discussions around SYSTEM_RESET2:
- https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
- https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Changes in v18:
 power: reset: reboot-mode: Remove devres based allocations
 - Update commit text for alignment. – Bart
 - Read magic before assigning kzalloc(info) in reboot_mode_register. - Mukesh
 - Update error handling path. - Mukesh
By Bjorn
 - Expose sysfs for reboot-mode bisected to different series-
   Link: https://lore.kernel.org/all/20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com/
By Bjorn/Lorenzo/Mukesh
  power: reset: reboot-mode: Add support for 64 bit magic
  - Use FIELD_GET/FIELD_PREP for u64 magic wherever required.
  - Update commit text and add documentation for structure of 64 bit magic.
By Lorenzo
 - Remove direct reboot-mode registration by psci driver.
 - Add support for predefined reboot modes in reboot-mode framework.
 - Add psci-reboot-mode driver and implement a psci-resets to accommodate
   all psci-resets including warm, cold and customizable vendor-resets.
By Bjorn
 - Update DT patches for qcm6490, lemans, monaco and tolos.
  - Update commit text to include more details – By Bjorn
For Alignment
 - dt-bindings: arm: Document reboot mode magic
   - Update reboot mode documentation to clarify that argument1 should provide
     full value of reset_type along with the 31st bit wherever required.
 - DT patches for qcm6490, lemans, monaco and tolos.
   - Provide full value of reset_type including 31st bit.(eg:0x80000001).
- Link to v17: https://lore.kernel.org/r/20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com

Changes in v17:
 Remove the patch to synchronize list traversal - Bjorn
 power: reset: reboot-mode: Remove devres based allocations
   - Remove devres based allocations as a fix   - Bartosz
 power: reset: reboot-mode: Expose sysfs for registered reboot_modes
   - remove devres based allocations in create_reboot_mode_device
     and manually free resources on failure.    - Bartosz
   - Add driver data while creating reboot device and
     retrive the same in reboot_mode_show.      - Bartosz
   - Remove the mutex lock.
 firmware: psci: Implement vendor-specific resets as reboot-mode
   - Call put_device(np) once processing is complete - Pavan Kondeti
 Move reboot-mode to SOC DT wherever applicable - Mukesh Ojha
- Link to v16: https://lore.kernel.org/r/20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com

Changes in v16:
 firmware: psci: Implement vendor-specific resets as reboot-mode
  - Use GENMASK(31, 0) instead of 0xffffffff - by Kathiravan
- Link to v15: https://lore.kernel.org/r/20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com

Changes in v15:
By Sebastian:
  power: reset: reboot-mode: Synchronize list traversal
   - Change mutex locking to scoped_guard() and a Fixes: tag
  power: reset: reboot-mode: Add device tree node-based registration
   - Change reboot_mode_register external call to use fwnode
  power: reset: reboot-mode: Expose sysfs for registered reboot_modes
   - Use sysfs_emit_at for printing sysfs entries
   - Add driver_name to struct reboot_mode_driver instead of passing
     as argument
   - Update reboot_mode_register, devm_reboot_mode_register and
     create_reboot_mode_device for same.
  firmware: psci: Implement vendor-specific resets as reboot-mode
   - Update psci to use updated reboot_mode_register and store driver_name
     to struct reboot_mode_driver
- Add DT nodes for PSCI SYSTEM_RESET2 types for lemans-evk, qcs8300-ride,
  monaco-evk and qcs615-ride boards.
- Link to v14: https://lore.kernel.org/r/20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com

Changes in v14:
- mode-dm-verity-device-corrupted documented in cover letter -by André
 ABI Documentation:
- Updated KernelVersion in ABI documentation to reflect base commit
  version. – by André
- Revised ABI documentation to clarify space-separated format for
  supported reboot-mode commands. – by André
 power: reset: reboot-mode: Expose sysfs patch
- Modified `show_modes` to output a space-separated list of supported
  reboot modes – by André
- Added error handling in `create_reboot_mode_device()` to ensure
  proper cleanup on failure.
 firmware: psci:
- Locate psci/reboot-mode node using psci compatible. - by Krzysztof,
  Dmitry, Sudeep.
- Added error handling for additional code for compatible.
- Converted hex values to lowercase for consistency. – by André
- Introduced panic notifier to disable valid vendor-reset flag in
  panic path. – by André
- Added check for `psci_system_reset2` before registering vendor reset
  commands.
- Updated Commit text.
 dts: sa8775p:
- DT file name changed from sa8775p to lemans and commit text updated
  accordingly. – for dt renaming in base commit (sa8775p to lemans).
- Link to v13: https://lore.kernel.org/r/20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com

Changes in v13:
- Split patch1 into two (Synchronize list traversal and DT node-based
  registration) - by Dmitry.
- Move mutex lock inside get_reboot_mode_magic - by Dmitry.
- Reorder the patches – pull patch8 for exposing reboot-mode sysfs before
  psci patch - to align the change in reboot-mode sysfs patch.
- Update patch- reboot-mode: Expose sysfs for registered reboot_modes
     - Introduce a driver_name in reboot_mode_register. This will be used
       in sysfs creation  -  by Arnd.
     - Update documentation and commit text for above.
     - Fix release function to properly call delete attr file.
     - Fix sparse warning for devres_find.
     - Add error handling for devres_find.
- Split ABI documentation as a separate patch and update ABI documentation
  for usage of driver-name in sysfs - by Arnd
- Update patch - psci: Implement vendor-specific resets as reboot-mode
     - Fix Kconfig for CONFIG related warning.
     - Add driver_name as "psci" in register call to reboot-mode - by Arnd
- Link to v12: https://lore.kernel.org/r/20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com

Changes in v12:
- Added lock for list traversals in reboot-mode - by Dmitry.
- Added proper handling for BE and LE cases in reboot-mode - by Dmitry.
- Removed type casting for u64 to u32 conversions. Added limit checks
  and used bitwise operations for same - by Andrew.
- Link to v11: https://lore.kernel.org/r/20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com

Changes in v11:
- Remove reference of cookie in reboot-mode – Arnd/Rob
- Introduce 64-bit magic in reboot-mode to accommodate two 32-bit
  arguments – Arnd
- Change reset-type to reboot-mode in psci device tree binding – Arnd
	- binding no more mandates two arguments as in v10.
	- dt changes done to support this binding.
- Remove obvious comments in psci reset path – Konrad
- Merge sysfs and ABI doc into single patch.
- Fix compilation issue on X86 configs.
- Fix warnings for pr_fmt.
- Link to v10: https://lore.kernel.org/all/569f154d-c714-1714-b898-83a42a38771c@oss.qualcomm.com/

Changes in V10:
- Change in reset-type binding to make cookie as a mandatory
  argument.
- Change reboot-mode binding to support additional argument
  "cookie".
 From Lorenzo:
- Use reboot-mode framework for implementing vendor-resets.
- Modify reboot-mode framework to support two arguments
  (magic and cookie).
- Expose sysfs for supported reboot-modes commands.
- List out all existing reboot-mode commands and their users.
   - Added this to cover letter.
 From Dmitry:
- Modify reboot-mode to support non-device based registration.
- Modify reboot-mode to create a class and device to expose
  sysfs interface.
- Link to v9: https://lore.kernel.org/all/20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com/

Changes in v9:
- Don't fallback to architecturally defined resets from Lorenzo.
- Link to v8: https://lore.kernel.org/r/20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com

Changes in v8:
- Code style nits from Stephen
- Add rb3gen2
- Link to v7: https://lore.kernel.org/r/20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com

Changes in v7:
- Code style nits from Stephen
- Dropped unnecessary hunk from the sa8775p-ride patch
- Link to v6: https://lore.kernel.org/r/20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com

Changes in v6:
- Rebase to v6.11 and fix trivial conflicts in qcm6490-idp
- Add sa8775p-ride support (same as qcm6490-idp)
- Link to v5: https://lore.kernel.org/r/20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com

Changes in v5:
- Drop the nested "items" in prep for future dtschema tools
- Link to v4: https://lore.kernel.org/r/20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com

Changes in v4:
- Change mode- properties from uint32-matrix to uint32-array
- Restructure the reset-types node so only the restriction is in the
  if/then schemas and not the entire definition
- Link to v3: https://lore.kernel.org/r/20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com

Changes in v3:
- Limit outer number of items to 1 for mode-* properties
- Move the reboot-mode for psci under a subnode "reset-types"
- Fix the DT node in qcm6490-idp so it doesn't overwrite the one from
  sc7820.dtsi
- Link to v2: https://lore.kernel.org/r/20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com

Changes in v2:
- Fixes to schema as suggested by Rob and Krzysztof
- Add qcm6490 idp as first Qualcomm device to support
- Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com

Changes in v1:
- Reference reboot-mode bindings as suggeted by Rob.
- Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com

---
Shivendra Pratap (10):
      power: reset: reboot-mode: Remove devres based allocations
      power: reset: reboot-mode: Add support for 64 bit magic
      power: reset: reboot-mode: Add support for predefined reboot modes
      firmware: psci: Introduce command-based reset in psci_sys_reset
      dt-bindings: arm: Document reboot mode magic
      power: reset: Add psci-reboot-mode driver
      arm64: dts: qcom: qcm6490: Add psci reboot-modes
      arm64: dts: qcom: lemans: Add psci reboot-modes
      arm64: dts: qcom: monaco: Add psci reboot-modes
      arm64: dts: qcom: talos: Add psci reboot-modes

 Documentation/devicetree/bindings/arm/psci.yaml |  42 +++++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi            |   2 +-
 arch/arm64/boot/dts/qcom/lemans.dtsi            |   5 ++
 arch/arm64/boot/dts/qcom/monaco.dtsi            |   5 ++
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts        |   7 ++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts    |   7 ++
 arch/arm64/boot/dts/qcom/talos.dtsi             |   5 ++
 drivers/firmware/psci/psci.c                    |  46 +++++++++-
 drivers/power/reset/Kconfig                     |  10 +++
 drivers/power/reset/Makefile                    |   1 +
 drivers/power/reset/nvmem-reboot-mode.c         |  11 ++-
 drivers/power/reset/psci-reboot-mode.c          | 111 ++++++++++++++++++++++++
 drivers/power/reset/qcom-pon.c                  |   9 +-
 drivers/power/reset/reboot-mode.c               |  79 ++++++++++++-----
 drivers/power/reset/syscon-reboot-mode.c        |   9 +-
 include/linux/psci.h                            |   2 +
 include/linux/reboot-mode.h                     |  15 +++-
 17 files changed, 331 insertions(+), 35 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf

Best regards,
-- 
Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>


