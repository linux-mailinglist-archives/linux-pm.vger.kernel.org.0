Return-Path: <linux-pm+bounces-37679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB44C44063
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E915C3B11AF
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1782FBDE0;
	Sun,  9 Nov 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HU53mVUB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aye2nmj0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC22F744D
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699090; cv=none; b=Ovs+1X7bYEXiqObt2jn0z7wC7/22RmjguOZLMlFTdAb1P6DlLWCw6wNJfld3Jxb6PH+Y5ULFNkKzt5jO9MtZCqEy+fjCnWY4PeETaNLd5davEluj97GmL4JVbu17CauPR7a1fN1S9tXZwrJRriyA454IIgjaSfudB3QFIjxfvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699090; c=relaxed/simple;
	bh=x3Lr4ZmEbVM+ag4cXsvdgyTtGMktLJ4FG07NOgjnsDw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IrIsLpnQs2yYX0EKiK/hBzcLlrurURtB3aq0vYJFPxuFt9490uzHY1dx7CcEzX79oT94j5CZRW8O+jDLRP+Rxzm/0baS8KMc3DPFV3yHJYB/ON6z59SPCUp863sOmDfjOvcdU7R7Aw21AzRwFFRPD7bi7F0S80VGhpZ7q94km0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HU53mVUB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aye2nmj0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9CrNQn640469
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Rp4FzzeLXQQyGINC6F/+/B
	oegFBFXm4E8h/c0wdMHjE=; b=HU53mVUBGV9AqRfeJDSBDXht50c85c4qAJVOks
	RBtM2K1vVFEhShd0Co1ZYFIn30yVQmLTKr3gbGbcbeI6/uGFxafAGFDFF9j72rwT
	58/lv8VH68x7KKQkr8r9ExpTv5ZoVigU3Ydp7NLQw/t0IBpCyld65fbFvjzUwgG1
	RKno4H0ywp+Gg+NiiPRhXZfsr7PGLuOmL3Tw03cjD90U5J8lLO8QaDDfUMnRxuCZ
	xnP6IfSpF2dJk31IV8D1samBzGro4hdmRKB6evNNMQ8GNgcJffMQ4kr13WM1N+96
	bICX4CFIk0NyUe4rA6WlaHlnYRseaVv17jn1HV7B4cnVPstw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu2t7yf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:38:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c0604e3dso2750383a91.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699084; x=1763303884; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp4FzzeLXQQyGINC6F/+/BoegFBFXm4E8h/c0wdMHjE=;
        b=aye2nmj0yAfP8S4y9DfugKFby/SC1KWZLV0FhaBKrzHpLYh0Yi4KHkDgqx4TiOYHm8
         wILe76SoqiwdIHeW+UowYZKjd+N/gfvbXrTSbM+vwPwFsvzejq8oAoUC1/AcqbHAYYwp
         VM+I0x0r9oOC/gucGNFOJjpFaP9i5IgMc6p2j6+0PvjMPLd++vt3+QlH/N/995WZVMsP
         XgDYXrGMDvbyNbIyHqQ6bgZk4s0gxIMcXACgdYso5QdPnvxYUFzTfx3ziCoSqKqMwBCY
         GrTiAP582jT/Hc9od4le1CfUSe+ynNhcHqcvDmHzcCNEB2yWI9m133COk25wAAVcVKeS
         yIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699084; x=1763303884;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp4FzzeLXQQyGINC6F/+/BoegFBFXm4E8h/c0wdMHjE=;
        b=XQcfq+yeR72zciRek1fmyX1FQFZ655i8xWn6vDF9IYECmRmkX/jY2Q2ltabrwbxPhQ
         h7TdH+y/pjTzxbub4Vq46IP1Y9NOdVWjH2DH9mKUVPbBRcQpT96WCOOu+XrXvJDWJA3O
         M8pHhz/tp8DMkb72dmXNYiz8m4Qd1I1d3UFSV7lCOeSTV9gN/REbsflvXsvFQs+PTHlM
         B8TUIEz7abnqLKkDC2eFRq+Y+vFlWHT1kL6Drsam+lWAf7cN2TG6ZsA+m6YLGKUq9MBG
         dBXjfMINqdy+YR57VbTylMvv7o1jlUaDyBvZ2ba2ZcG5za1BXUC0psLzrAqFWoPyaW2S
         XfWw==
X-Forwarded-Encrypted: i=1; AJvYcCWB0+oF+xhtSCAfkoDW+qpGeujtpGFQVmLF1w3LAGnlZTFa6jvjuzv0bn2R0vQ19p8yjntH3nmtvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjM7cBy03mdY9nTI3KvK/hpzFxAU7vTQOe7dLVUxqAnTheV0/
	Smiy22woSD3hOMzx83Y9D8c6aACxDDDfIHlBr4BckMCsAQUd8gpj4IHxYV2RKJ2CmvXmIvkbgkN
	pS0q2/FWS7HUXm0oTlJf4/jplIBJEHDTXnBwYg7UOWaVthm3cU+ktwMGeDFSpBQ==
X-Gm-Gg: ASbGncvS20vtufdobAhTha6kQrmtP9qqFs59Pib+ZpuGAziPojc1K+AoPqC2hMgccP/
	HBA3SXwJPnjKgOspDpb6OuhkOsKZ9OUFNC+9hxWVEjoNynB9cBJvsu/kOQqATLCubpHyg0DkuD3
	nVdIEbl11nP9sK60h2tHFxUl513UagOU1jrdpn4zIL6VlTqcwWB84QZiUbXf7fJXcNFK3iCjyGe
	C5DVguu83AFJimSlRbAWy8vH4TnRzX5Kxg4+Ysm0C8ZhdXDxZKhC2X7ng+CZrTkQBzgPme8FmUW
	+HbD5p3nAFDKFIMq4xry5JjDz4RKfcZJK6AMZGMl+/C4tBbUQ5NS/OFOZSk7rGg3tywatIl6/VD
	QtnQ3f3kzSY5I9z7Fa29eU3q2W7h9nMW2D3A=
X-Received: by 2002:a17:90b:2fcd:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-3436cb227c9mr6135148a91.15.1762699083949;
        Sun, 09 Nov 2025 06:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcbTOfabWyh8beJ1pk/9bwtYIYvRZMVkvTrPUjXZRzrxrjCFLXXbqXzn4dup5wBqHQ1ry3dQ==
X-Received: by 2002:a17:90b:2fcd:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-3436cb227c9mr6135116a91.15.1762699083308;
        Sun, 09 Nov 2025 06:38:03 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:38:02 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: [PATCH v17 00/12] Implement vendor resets for PSCI SYSTEM_RESET2
Date: Sun, 09 Nov 2025 20:07:13 +0530
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABmnEGkC/53SUUvDMBAH8K8y+mxGcpc0V5/8HiKSJlcXsOtMa
 nGMfXfTIW6ghepL4A7y+9+FnKrMKXKu7jenKvEUcxz2pVD2blP5ndu/sIihNCqQYKSVjXCpF4f
 so8jHPHL/nDjzCGLifRiSSNwOw5iFrj1JqbXrfFcV65C4ix+XoMenUu9iHod0vOROSs7trwglV
 0aUa0IKtlajJcSg/cOQ8/bt3b36oe+35ZiT/6W2ELAlgpbJ/FTnBSalboe2q3lV+NAhQwuK0OM
 SDzc8qNU8FJ5s6zyy1wC8xOMtv356LHzdUgBEZaihJV5feVJmNa8LjzZA05nG+cYt8ebKNwCre
 VN46xmdJLLUqSW+/uaV/MP09fxzGnIcnAPk397+fD5/Auo1bZ50AwAA
X-Change-ID: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf
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
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=16919;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=x3Lr4ZmEbVM+ag4cXsvdgyTtGMktLJ4FG07NOgjnsDw=;
 b=HQGcQBHfYOOk/x5cj43A2wmw/VggsE9mBDI/j3nGYpD62aEAB+ApBOAZpZ5nEVzTNYGXtgVnT
 6tuba98zeIxAwRwuufBte+pr0CpAFWU9ODABOCcOV8zG3WYUJC3v0Bi
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=dMWrWeZb c=1 sm=1 tr=0 ts=6910a74e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Q-fNiiVtAAAA:8 a=Ar03WaVmlBmnQrY0rM4A:9 a=BodpQ9I-8dFPbuBO:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: E7-DOAj8dxkcvnVBsmVHbw9Q4NfMxfZC
X-Proofpoint-ORIG-GUID: E7-DOAj8dxkcvnVBsmVHbw9Q4NfMxfZC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX3it/ys2MFOxT
 xHjD+bwEqlu0bqipKGJYRj5uH5pXCazHGIelyf2GewVxWUugtGTbkcPJwqs41DCZGHrHN5E2gGs
 z+9l5qV/l1UY7FQiNEcoqkCC+lfE8TIP0eLPXKph0BTbmdqb4fu540KmQATXfXRVzf1aGNh9xry
 ccDWvqkLSveUOH1CgAbtMp+ejqclvlxrmm60HGLBsjF2EgYHW8gelIv1bKEAPnn1fqF/0IuMFub
 nCHXFqp9icn3302oriFs9gmJHsepgYbQO1zlsJLmJs0/OLQ6/CzHP4Nq82aRnywCxekKs6Kl7Yw
 5PYWw01fLsb+AKdK+XPLiUmmoWo8+zhh69ZpWh3mtft251bmAsbMrKtU37pupUuRts/72uzE17M
 zmd98JG9VMNuyu1JnFxsOb/11Y0wGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

The PSCI SYSTEM_RESET2 call allows vendor firmware to define
additional reset types which could be mapped to the reboot
argument.

User-space should be able to reboot a device into different
operational boot-states supported by underlying bootloader and
firmware. Generally, some HW registers need to be written, based
on which the bootloader and firmware decide the next boot state
of device, after the reset. For example, a requirement on
Qualcomm platforms may state that reboot with "bootloader"
command, should reboot the device into bootloader flashing mode
and reboot with “edl” command, should reboot the device into an
Emergency flashing mode.  Setting up such reboots on Qualcomm
devices can be inconsistent across SoC platforms and may require
setting different HW registers, where some of these registers may
not be accessible to HLOS. These knobs evolve over product
generations and require more drivers.  PSCI defines a
vendor-specific reset in SYSTEM_RESET2 spec, which enables the
firmware to take care of underlying setting for any such
supported vendor-specific reboot. Qualcomm firmwares are
beginning to support and expose PSCI SYSTEM_RESET2
vendor-specific reset types to simplify driver requirements from
Linux. With such support added in the firmware, we now need a
Linux interface which can make use of the firmware calls for PSCI
vendor-specific resets. This will align such reboot requirement
across platforms and vendors.

The current psci driver supports two types of resets –
SYSTEM_RESET2 Arch warm-reset and SYSTEM_RESET cold-reset. The
patchset introduces the PSCI SYSTEM_RESET2 vendor-specific reset
into the reset path of the psci driver and aligns it to work with
reboot system call - LINUX_REBOOT_CMD_RESTART2, when used along
with a supported string-based command in “*arg”.

The patchset uses reboot-mode based commands, to define the
supported vendor reset-types commands in psci device tree node
and registers these commands with the reboot-mode framework.

The PSCI vendor-specific reset takes two arguments, being,
reset_type and cookie as defined by the spec. To accommodate this
requirement, enhance the reboot-mode framework to support two
32-bit arguments by switching to 64-bit magic values.

Along this line, the patchset also extends the reboot-mode
framework to add a non-device-based registration function, which
will allow drivers to register using firmware node, while
keeping backward compatibility for existing users of reboot-mode.
This will enable psci driver to register for reboot-mode and
implement a write function, which will save the magic and then
use it in psci reset path to make a vendor-specific reset call
into the firmware. In addition, the patchset will expose a sysfs
entry interface within reboot-mode which can be used by userspace
to view the supported reboot-mode commands.

The list of vendor-specific reset commands remains open due to
divergent requirements across vendors, but this can be
streamlined and standardized through dedicated device tree
bindings.

The patchset removes devres-based allocations from reboot-mode
as a fix. Its placed as first change in the series as a prerequisite
for addition of firmware node–based registration.

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

Previous discussions around SYSTEM_RESET2:
- https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
- https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com> # On ARCH_BRCMSTB
Tested-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com> # IPQ5424-RDP466
Tested-by: Xin Liu <xin.liu@oss.qualcomm.com> # On qcs615-ride 

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
Elliot Berman (3):
      dt-bindings: arm: Document reboot mode magic
      arm64: dts: qcom: qcm6490-idp: Add PSCI SYSTEM_RESET2 types
      arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI SYSTEM_RESET2 types

Shivendra Pratap (9):
      power: reset: reboot-mode: Remove devres based allocations
      power: reset: reboot-mode: Add firmware node based registration
      power: reset: reboot-mode: Add support for 64 bit magic
      Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
      power: reset: reboot-mode: Expose sysfs for registered reboot_modes
      firmware: psci: Implement vendor-specific resets as reboot-mode
      arm64: dts: qcom: lemans: Add PSCI SYSTEM_RESET2 types
      arm64: dts: qcom: monaco: Add PSCI SYSTEM_RESET2 types
      arm64: dts: qcom: talos: Add PSCI SYSTEM_RESET2 types

 .../testing/sysfs-class-reboot-mode-reboot_modes   |  39 +++++++
 Documentation/devicetree/bindings/arm/psci.yaml    |  43 +++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               |   5 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               |   5 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |   7 ++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/talos.dtsi                |   5 +
 drivers/firmware/psci/Kconfig                      |   2 +
 drivers/firmware/psci/psci.c                       |  92 ++++++++++++++-
 drivers/power/reset/nvmem-reboot-mode.c            |  13 ++-
 drivers/power/reset/qcom-pon.c                     |  11 +-
 drivers/power/reset/reboot-mode.c                  | 126 ++++++++++++++++++---
 drivers/power/reset/syscon-reboot-mode.c           |  11 +-
 include/linux/reboot-mode.h                        |   9 +-
 15 files changed, 345 insertions(+), 32 deletions(-)
---
base-commit: f9ba12abc5282bf992f9a9ae87ad814fd03a0270
change-id: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf

Best regards,
-- 
Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>


