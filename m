Return-Path: <linux-pm+bounces-31437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C823AB1307E
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8087AA367
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6C21C9E4;
	Sun, 27 Jul 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ll2dnarX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53E21E0AF
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633537; cv=none; b=TxrIA7w1U0nlq8u3uP6PKp93/9sCMp27O/tXjj85E082UIdgIVSNNY9aw5TUjX+o9ATbEvdbVSoduBxrF/TPuE4hA7EEBIuZga+BS1uS/u9UmslHvxvLNNf6puh7m0WLHTYt0zJ2T7ESW9L1xjJLUUksagXm+DbbvSeVf4H53Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633537; c=relaxed/simple;
	bh=B5BLAbfGWAu1tjZeNLd2S/l/pA+itiinQJEbqhqQ7Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiXgU1nGCtas44rC4ColRmntRUWQ+rtcSVF3hCB3ApCl5+5ynL/1BsxFpQlyeIrXxAqHDEsE53xQCpOx6g4W5/K4QRC1BQAED+ZgGwu+M3eINamaXMzTNFKNjd+0WE3u3YNLqCoSuW3wOWSSkA5XvTb79VZaXjB6p9SD5RHJs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ll2dnarX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RAdmtf017122
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LAjdEtX3RT7zSV5WrhnDDtIT/eTrigKKIJeo9CD77g8=; b=Ll2dnarXF3tA763o
	n0D2snUMmai1xsB9hkOvnb2fifsSLg1eWkxr6LBWGPBJWONv1lc7QUlNM3CJ5E3H
	NMm/+P1jsD/L+TRxS2KeEdHs1QuQ+5eeZ/Bxyz/1Ko/TJAVN90y0DFU0kzbO7TZb
	1uazZIYQWW2I3TZJoyZconGYcOXvAs85jsqQwgeH903e71Uy8IM6YxYyE9LMN25K
	2RCMgvxVUxaIDe3Bm0tJjyp/b7K82bwNDMIheJX9tSheGicesNanxpmyUXn2PzGP
	/kc/qpXNoKhDl9WOfzHEPgFE9zdV/Ve3LVmgzyG7HiI38Rn1+tN9+5y5JkxJg5p2
	qDCFEg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xjat4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23632fd6248so36232625ad.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 09:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633534; x=1754238334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAjdEtX3RT7zSV5WrhnDDtIT/eTrigKKIJeo9CD77g8=;
        b=F+pa3WX8J0IBuvfvIWLKHVniJw3LAvbAzfSu54csi7JqVF+T3MwWi1lKci20I0M17O
         OIFy3+s7mfVmqU9g8Ui7SvcP2QUcMFvwte01aZmDEUw885T1XCkvMS5he7I7Xv53n6rE
         eY0VnU+w/b8lTLDiopGYfXfLunUZhmblMLzVnLweUr3jmvUAQqAMo6wAkS+2h4nGRhgQ
         KOI36NobNslP0iTteFnbM/cCUpvEnPGzxwujgfTExzWykuk4Uyj9SO5gOeXt4zuuYUBZ
         hLaqscCuQsetnRpPAwCiuEa9cBMy5fZt9encrqyH8Z5Z4psFNIYHZGDsc3Z813jXdgGB
         s/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxs4wAY99GtK+MBt1SdiFBuvCtEparATnzaSPiEm5LB4AqeEj92YUw0Dyz52KfCb5fgp1IFFw1Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIv5jAMM5XL0/wm4NbZIFcirc4QEVTY/uGOKI9nQyTQJp2fRm0
	y2WgrsjEMq/fPYIz4reKL3a88GKRFGb8/E63yUjhV78ZnY8Twol9xsTxx6qa41+b3PCKfVK2FWA
	IhXtVZSbp6JGR3SlMVYnwawMMIWom6J9nx599CyvXs0938CZZ3eIzy40LyuL/Cg==
X-Gm-Gg: ASbGnctC+RG5cbV2dFjb4atX/L1ManiJa6g8sF8CFcwDd20nN2rhP9Tu0RKzmqzYOnY
	kSx2AWVmMHM/EiUCKUK5oXUJEMeaGWfZUiwmi118KyVGFuOStCOrh2+yMpp+lHMn2hAX7tQzcht
	ouZ5zsrWUnZg907AwpzM5YI0LYAckcZFLIQLVDDE/HfPhPNfM4vANSmasfnzFltAX6QazTgj4Z8
	UKNYsfLfhXA7PzWXqYiWOI33cNN2rYKqK/xRjQxMVEF4zWLHtjk9mORx7nWhxXvNs3OXLvoU3G3
	c6Buv6Z6P0N3s0mH5kKXX7am30fVPH7xA4WLTDJJQIMJiC9bYvUlMjF2eBc3nnD+lh3t0aAWL1/
	4
X-Received: by 2002:a17:902:d2c7:b0:23f:8df8:e7b1 with SMTP id d9443c01a7336-23fb30b3224mr145314795ad.32.1753633533690;
        Sun, 27 Jul 2025 09:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7X/a1NVbBv9ysYl7a3wo9LMuxbvZnRFcCXyu7AESYMzqbL9vACORQwwTa7YynJTdngrt2rw==
X-Received: by 2002:a17:902:d2c7:b0:23f:8df8:e7b1 with SMTP id d9443c01a7336-23fb30b3224mr145314215ad.32.1753633533214;
        Sun, 27 Jul 2025 09:25:33 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:25:32 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:47 +0530
Subject: [PATCH v13 04/10] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-4-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=2307;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=B5BLAbfGWAu1tjZeNLd2S/l/pA+itiinQJEbqhqQ7Iw=;
 b=pgH9mIPi7GA0ayDqkKnR2+E/P0dq3sd1IZAeVGSFF5+JaYFGGS/XBZthLHPT9KAF1UJ/RpQH4
 Hoy706MVMLNDID9ZV+MW3XmZWBEhJJ0oZVWXtccIrzCMNUZQ3rPFPly
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=688652fe cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=5CgfHzhl2afHKY-Ush4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7rVK8pwmQ04prU4vlXgb2lSyJ4ys_jqW
X-Proofpoint-GUID: 7rVK8pwmQ04prU4vlXgb2lSyJ4ys_jqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0MSBTYWx0ZWRfXxNNW5YyW4iTP
 dzEkS35F7Fz9hx33WSV5JVJ+IXjyBlYjDpFb/js5jdLOjrjOUIaZFEClAzdTC2XZXbSmTXg3akj
 VFAYJILEao3A7baxPTKzy93Ij0144JMbItmpWU8DfUNmOzrkOb0XiUepEZFAO20L6R6CT7IuDeL
 NOsxwHXh4TaZNmjwRgbpAUV0Bp7ngS7UDU7qQyyrDO3npTHEWUQ9TorFWLgWmxNC4HjJXmUOsqq
 Z4dIaHKCkQUPqpAR9B4SD9C9gLqyzR9KsvjEt6aiwb7GdeSfkmd+a0+H2qZqDKeWan0H5P6IVSS
 sh6+Q8CRk4S+nMkFGswSTP3qHPVoRLRrJLpuAMCx7FfuXscPmsiWtzX2CPSeqIIrMGOBgAZBQOk
 PgedlP8LiHbw9wnrDET28NOTSbqJk+GkU6s+KasVHeMNmNuvMuY0KHZEDcl+KaQbqSiOWtxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270141

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes,
a read-only sysfs attribute exposing the list of supported
reboot-mode arguments. This file is created by reboot-mode
framework and provides a user-readable interface to query
available reboot-mode arguments.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..7147a781e5d4d11977c3a156bf4308aa13310e39
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,39 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		July 2025
+KernelVersion:	6.16
+Contact:	linux-pm@vger.kernel.org
+		Description:
+		This interface exposes the reboot-mode arguments
+		registered with the reboot-mode framework. It is
+		a read-only interface and provides a comma
+		separated list of reboot-mode arguments supported
+		on the current platform.
+		Example:
+		 recovery,fastboot,bootloader
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


