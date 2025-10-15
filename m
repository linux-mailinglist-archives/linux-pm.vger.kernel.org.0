Return-Path: <linux-pm+bounces-36113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA52ABDC80B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5D4423EAD
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841002FF653;
	Wed, 15 Oct 2025 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cbXPvs1s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968222FBE1C
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503158; cv=none; b=OKQQinSMP6xJhvevULXrn5mgo81l8RnR2WDTDuvC7MPb4pOFe4w4ZuucfqtvB/ol1WGFW8lnQ7/x6faLL3mfjWpbj7uCUv90zI7H/kiSAzQwglE75J3TVHNLuW8kpt3KfH4na5P72otKt4ZNIqFDq0yMWuGLTmFzNtgv7wguZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503158; c=relaxed/simple;
	bh=KkC4QSxclwx5Tk4AVwolzQwcYruXvNFOfpqU998deKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6xNVnYANEqmOdkwetGOE6UH+eC3g85T6H4ipVfAmqvpf9CR4sJLLur7Mp2hYq9FdCcDZYAFHOZ8H7A7wkkD516YPA5Rt4hOahZd/CEbPWrlZUTfYtkBfaH6FuArR9QQKn4dyuasYHTF8O9cvDQyYtkyHC6uBiT6G4PTK9oEPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cbXPvs1s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sAOG014748
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zriVHHzMQQ8ELUT932V4l8RDRcEXWAm2X8YnUX13NY=; b=cbXPvs1sDHgld0fG
	QqpifzS/Mk/1tf2zVQOYOazzoiLXk+PRDNQlf8XOMjiuH8IgFGcCYaC4eTGz54/n
	CLtl5v20hoRXSiNXqTnJHRxCxd84xUq9wOFVPnbYuf1E/XYNNzFhjlFv9sQYyt6s
	qmFFgXXUIKXOlgUNOATyicjbCT5wlpa9xq8H7kvJQ4Gdm5ar8FCaFBesqlWc7SfZ
	57Br/g8gCKnGEjkE7V7ybGSh6Uom+KJwKRJFzHSl5PUem8DS7J7UxyWsjh7YGreK
	dUp89ifinUJ5qRvm3x18+UtOux47QgPCNyg8bf1U2g5PiNVgv8QK5PfyriAtWRZc
	2uCFgw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj32x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6ee6so120869985ad.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503154; x=1761107954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zriVHHzMQQ8ELUT932V4l8RDRcEXWAm2X8YnUX13NY=;
        b=NnDC14gtnV1Lqe8KWqVmL+z+Oks5Ky6nVSdk7klnbDw0aadzJ+QQp38DFl/g9ObDsC
         hQQKWAvBxuxpeIjSC1BIiTCQkdRbfrrdkzbx1sJyrflVphvWXSIcAFUpWpSgKNtydXBA
         p1X/mQIii9R2W6bOjngIQsmR5IDW9JJYltHcKvOX8bLu79+K1ikpF2xrIH9QdIZqXNsV
         34tt8l/kLq2D7mtpG+hKvSC7052XrISqE3AerrupOrTo/CawzO1Q0qaXb+uNA4/7tAde
         VyMDKk0OmG5GmW8R6SAOifwm+5Lx5SCZmouAJ4w/k2QmY3ETt5fna8QFUaZlbGBtuAZo
         ijyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+lyOwGu0YBt9Y2dRtu5GV8kdkrHCq9WL3qLpNbOty3JYeGlObV2t/rumv4e84ie5qHkyUxt9xsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzItfu2K3OdgPMHUNtP5g64XsQrckCntBf0Wkla354fG2wSyR97
	5hvAvfHO0UcLwgeVkw2eFOdeH43WsDa0LSllTDX+L2/KfXpQi6nwxnIXjE0w12LoQzFl8bPnEYz
	SapQf0HagpWcT2wrMthwhl9QN6tra29ZH0306zQjzyQTT2iIzwpKQZ2/5hP3R3Q==
X-Gm-Gg: ASbGnctGyUIG0V79qyn1JDdIJ8Bq2ZHeaDJK11XB/vyEvJtKYlq0ofNiQmYY7s5kKsi
	cC/mvNJi64426VdTrNJzyGq+NGVj8EmjwhseeQTtkB62MXekq6zdI5cVns0ZImvKUqPm9tIOPMn
	HgMjDcoe+nmjDekpmKPpHYNFG1+eL1pUnWl5MIwzOlNZ2fSBKnL5XUupeZfhskbIh1pH5yhNNLp
	2urqnMp7CTH2n3IuzL9xLx/eNrngYFrOvyWREZMrtBQq2sDPXWCJOxi++ToVwrXA7UeXUgEWGdC
	3snPR57Mvpa2RS/4pUfKc5K/nGC/4p6xVuhL8BHXVJ35qxpy4Jjq3pEg7XpqlXTISGXIhS87GJL
	/
X-Received: by 2002:a17:903:1a2b:b0:28e:7e7e:fb6f with SMTP id d9443c01a7336-290272167d8mr343984455ad.10.1760503153719;
        Tue, 14 Oct 2025 21:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD/q2ZAyeonVx5Bl1SpVHse69Gj4E2Egf2d4zHl0TDjVXVsdjY7bQQBwsO8PFsGdYg78s5JA==
X-Received: by 2002:a17:903:1a2b:b0:28e:7e7e:fb6f with SMTP id d9443c01a7336-290272167d8mr343984115ad.10.1760503153214;
        Tue, 14 Oct 2025 21:39:13 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:12 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:19 +0530
Subject: [PATCH v16 04/14] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-4-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=2381;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=KkC4QSxclwx5Tk4AVwolzQwcYruXvNFOfpqU998deKY=;
 b=ZZwqtg9gVy1w3/zW2svJRlN5sbGqfaom+icR4QjkzNyB1j4w/IVVyTvO8fBI0HPRCUa0b3EqR
 9kxmtNWCmFNDHs4zr97HOYv/TnV4I+0Ghy0HeurEavrD1TNcxLRLLG4
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/cIPXw5xaOWF
 faH3E7Zcx5REQtf9Z34dFcVSZCIysKhpx66OtnoX8582vo3+iGxsMwBjz3cDjTKDt13G7tVuLw8
 pXSlLSg+3pzbTmyBHqVg/a01ESxEWQj+0TeX/cerZBnPe2U1BdGcn6CExHsiqEffef/oViUQcDz
 65szMkokepx99Qif9FX9M2izxxgV6Ln49DdNT37VU4WwYWijlkwpJVJ6odnhif7yodjAdDDC38X
 H9wa8i4AbUX9vPutb8PD7BFJmW3eo21ZvWRIB1Hd73bghEz5paEv5ap+8z3TUuSpb8jbkIkRQxs
 Ilp0exIZM/aon11YFzftl6k8ekwa2eGQEG/ZbcfHhZP3sG8kvMESYzEpGP96EsXcUSi8xjPZmjm
 xJq9PDINDMXLoG2Vn3iM16HUrBOMWw==
X-Proofpoint-ORIG-GUID: FjGIKCVuggT4wQ5KUFlOtSqVqRC3dJSF
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ef2573 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=5CgfHzhl2afHKY-Ush4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: FjGIKCVuggT4wQ5KUFlOtSqVqRC3dJSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

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


