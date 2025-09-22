Return-Path: <linux-pm+bounces-35159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF5B91743
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6B4170C1C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B630EF6F;
	Mon, 22 Sep 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbq14I6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41430FC03
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548472; cv=none; b=QjDEKlSuKvzHNovufd+pSV4ezVaksNWUDET6i/4jJtqxiW3ICZecN0VdEpsM4qK0Zt/FahmO5u5OE5h/llslCN6BJfc1XGjOxf3DG88BQZBNb7z06iHvnlU7UoklvZsKDtwUxmIZXvEo/HSxz98IKhlSnBltESu2HZbB7sUp0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548472; c=relaxed/simple;
	bh=KkC4QSxclwx5Tk4AVwolzQwcYruXvNFOfpqU998deKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rk08bblWZk4QQwrBojZQYskqXwh4Dh+mEld/Lah7cbkH3mZ8KZ+QBtiIBgb8JwDFI4cqTPUmejXV7Yz+2HNjTbrw1EWGRhVtH9Djqx8TaUFOM6UYFTo5DZ6H4C+b5D2FP7Oup8y47mQrOEJQGhsTbIUF99UC0vDeZj9ZZeCgcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lbq14I6w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M90mqE031917
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zriVHHzMQQ8ELUT932V4l8RDRcEXWAm2X8YnUX13NY=; b=lbq14I6wezBqTHbX
	C3tBbifWxovD4vQWscjBArY3cpwx8tjFzHQCeVfSnfmi04z1gwgzQmE5UoCuSI3q
	zP8OzWx8dAJjcMnPpQrM5pDpFKD68xu1/EGI/N6IYUGiyObySRVM++qJHZv/au/2
	7eTn2PKlh1DxOI5Sjrg9ciHaDM5JnZqepahHsH4a+BctuJOjhZpDAOB8eJlmI5+F
	VEtTrDvcHV0uFVivcQejILSDBkH4l93C5aonapUB8rItarW320SvBHdTHGwfVeOY
	IGoHyb+/p1wAnMu/EChVBnaFxlolZ2EntobmHbm00ur5KSp9bXg7yY+Ql6fiKWIs
	Fkt/WQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyen5yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268149e1c28so51275945ad.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 06:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548468; x=1759153268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zriVHHzMQQ8ELUT932V4l8RDRcEXWAm2X8YnUX13NY=;
        b=o+6GsoFtV9L+ea3jt+H2a1mm74KugVqBZuYxxAeqMl7B4T+fobn/IB2Hmwup1V0Mrq
         2ACxqoxdTloi0iMj1bxzvimgC113FbwbLfNdFjmZUfKNPhjCvkogEI+s+nnmTUy/iw/2
         KdpDYWM6i2ki0I9vxk2M1/m4exzv4LUszlJNsxSJNZ1hJwzNLLmtGNvIVZlJKb+rWNbE
         ADWAa+QF6NA0ng+034zI8/bNpI5VAKsapwMhikj4cn/iDMouYpNZHUw+K6G9g7bzRq54
         hmLJXlqC3xBpkfiM7jNSkHJ8xIxjBcTeHZszBv7eqhg4ErxOzWkEHsWvxcCeXzm38UJU
         E/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuCp0eldfxLLfMTFydE8m7HjxIkd+sZ4UkRdvteJj78FjzlMJV6h1jw/pijX8lCxr6nW4RgXO1YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEaylMaIDAuwz5bnUcEgjaYQsO3L0aW+sYpIjzIWSKf2c27pS
	hRBkFPI+7UlQYor3u/CI96wJ3tOYcMF6FMto5pP5dNNILOzJ6rEvJnxX45gEs5mjyuPALrAIU5z
	++VZdulNzzIg/ClTexgJTSLyTXWM+VDNaQtEHDslGiJQdtvEzNY3vPnQj9C2L0A==
X-Gm-Gg: ASbGncvQvM6mJCIJsCspW1YepKNctSYt6/qjoQ9Ned7ymHo7NIE3dhQwRxzd985XZ/e
	EBr4UeG4zcjZt6KKX9nvLENAsXS9QHaVw/g95Q3S8JT/zgXOXjRArm04rrgminEQXmoWL9eFlv8
	9qJFmw55jPDFfrkkaujV/dga0E3J6yDoMF++GR461VEyXkIZXMWjBuVtoqaMPLdmBK83vdRXo7E
	GFxpjdFfe6KfNmrSYzVFuT5iSDFStbFltfn8liKLdvDUPJ+xm4Sd02643rJGgDeirZDnbksWrDV
	zbRQXOmVRH6b8i39+d2DCSTmoAMbfUBkOs65ezbxZtrvV8Z7ZJAVnIhku9CG4CrtisrKynF3A0O
	y
X-Received: by 2002:a17:902:f645:b0:258:c13d:9b1a with SMTP id d9443c01a7336-269ba534dc8mr157814065ad.41.1758548468286;
        Mon, 22 Sep 2025 06:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHduNm914Aec/xKw82GcSDYLVCzvWXbdPEGvEZBtKD9TBFGvd/XuvNECs8ldINaTjU69ejDGg==
X-Received: by 2002:a17:902:f645:b0:258:c13d:9b1a with SMTP id d9443c01a7336-269ba534dc8mr157813555ad.41.1758548467797;
        Mon, 22 Sep 2025 06:41:07 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:41:07 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:14 +0530
Subject: [PATCH v15 04/14] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-4-7ce3a08878f1@oss.qualcomm.com>
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
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=2381;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=KkC4QSxclwx5Tk4AVwolzQwcYruXvNFOfpqU998deKY=;
 b=uN/mNSJciqwPL2c846Ag2zmHUDTAwr0+DmX3GeKjBJun6SviBcqN2hIimRUdXBy5VUvYhksA1
 lXOvd8ZvtgZApCFxM4p+PgWnnQaGrV1OVcuhR4WyI0oc7VoQWD4VOt4
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: mpmSnMNaAZl7AqMMLLWPhO8oAG6c4Uj2
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d151f5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=5CgfHzhl2afHKY-Ush4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX97LCSf0mXwRo
 FW615/9IqFd5MhyHGyICyZXtL/CSp+c5gHDs1hK8XzU6b1YQ8z9wc2ogYF2rlvhQ0VMYA9mDIzW
 Nvk1A2rFBCQc7qyVhW5d022QdlqMbZ1OUof6FrusqxAIA/USA8/zYnYjnVmyVHw8/37mPVCCCib
 1BpFNapdIlH2F1L4G1++cpX6qEyKRz9s6fQjCeGKeceQ5Ts0KfCSDcKyYmg6g1GSUW6JUFTc1L8
 0QQDyc+NVgVvUDKBbKNh+nvEiZjUNB4QAiMOF2krXjtp+tkULqywPIw+eWahrwFZRmnkrZi15f3
 soRuC0MpH3rZB2Gh7ElarnRsFM591RYinP5sOLivCjXRWhezZRAqjPgoDs7pE3yA/qVp7ZfFWMG
 otadkKUr
X-Proofpoint-ORIG-GUID: mpmSnMNaAZl7AqMMLLWPhO8oAG6c4Uj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes,
a read-only sysfs attribute exposing the list of supported
reboot-mode arguments. This file is created by reboot-mode
framework and provides a user-readable interface to query
available reboot-mode arguments.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..6a3fc379afae3a6caf56ad0b73b1c06c43a9fee7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,39 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		August 2025
+KernelVersion:	6.17.0-rc1
+Contact:	linux-pm@vger.kernel.org
+		Description:
+		This interface exposes the reboot-mode arguments
+		registered with the reboot-mode framework. It is
+		a read-only interface and provides a space
+		separated list of reboot-mode arguments supported
+		on the current platform.
+		Example:
+		 recovery fastboot bootloader
+
+		The exact sysfs path may vary depending on the
+		name of the driver that registers the arguments.
+		Example:
+		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/qcom-pon/reboot_modes
+
+		The supported arguments can be used by userspace
+		to invoke device reset using the reboot() system
+		call, with the "argument" as string to "*arg"
+		parameter along with LINUX_REBOOT_CMD_RESTART2.
+		Example:
+		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
+
+		A driver can expose the supported arguments by
+		registering them with the reboot-mode framework
+		using the property names that follow the
+		mode-<argument> format.
+		Example:
+		 mode-bootloader, mode-recovery.
+
+		This attribute is useful for scripts or initramfs
+		logic that need to programmatically determine
+		which reboot-mode arguments are valid before
+		triggering a reboot.

-- 
2.34.1


