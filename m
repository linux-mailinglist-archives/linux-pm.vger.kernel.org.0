Return-Path: <linux-pm+bounces-38096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE715C61757
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A21CD4E8754
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21030C61F;
	Sun, 16 Nov 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKhxYAxV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cAmr6PUO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68BA30AABF
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763306416; cv=none; b=BpGDD22F05yfIYVb8cxZHbtVJtG6dfGEy58PrDl7tG/U0KlGjKvKngXdBjUaDU/z/cjqiMrB8lxbZW537ixgqJbLXIw8MOSSIo1MEO1tPebHJVKDV5zF2vsb/Goo3Vw2g58Qi7K+vB/T133/srP2lnT1KS3KgcnBt1Gyh6lSN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763306416; c=relaxed/simple;
	bh=x68jRFp5+Ep135r/sEE2bKgY0z0IuEd+y7yLWTo/bzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9pZwiJHoazqB1t7RP2x80iBWCZWD5/q9+bfYr18WZ/63HxQiiC3fFffEu/pSBCMifu0zZNa08rxreBPOKkI3iX58PaMUDALdsWPRAPUUqKNkLKQcX13b62fY7gQyH5GDvAWzLekQ5uikFglEdfwcx1goEN5ggySqHw7+tFEhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cKhxYAxV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cAmr6PUO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AG9uW1o335223
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sGA9hYTr1IMErczwCUGeUfRUFMoZs5m5Jm/OUZnJOlI=; b=cKhxYAxVt3dcjW76
	WH5CADuUdsLYYtsNfsDDaxyu8E4QlSxVs+rmwQoMXDuNcJibz8yZtC7Huo4g7GCL
	ytEAVKqbefPt0HuVTBXVGWIVr6sfUjoKwiFcC6FQcOgOznrUW7cSTajbhhcpoac8
	albYH3nd1BpOcODyxxzjjKTBWQ0CFPkBk66WgHdJ0LdAwrn0Tmqq8ZErSdNDRMo/
	6nuzOSw2LYNS2DAGMGsFiDMKp3VLRY1Tb3N8DMGuVVzaTuwAL9FYthYcBG49Cvit
	WmmD7uqGB+/w6f88p/GCCB4w8qrFeb86dcNVRzPpfXof1/BtsOejsd8XiDy18dX0
	eiXLcw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejph29p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2980ef53fc5so41066595ad.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 07:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763306412; x=1763911212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGA9hYTr1IMErczwCUGeUfRUFMoZs5m5Jm/OUZnJOlI=;
        b=cAmr6PUOvDp9kTcCo0UDg1i869HBriVOmoCBS3LXrJdnZRj8V2yNLSnYcnTivNOn51
         LjM8L109A3QIURwMlEElkaYcg64WSC02r4UsMgIuMmolT0pCpt2SzDtcaDVTXm3DiiDv
         CCHcWqMBlLDorASkSWjBBz1fGAvZQqzvYg56MF1rjdJCaEoQUVlhFkKlgm9p9ox+KGJA
         5ieh6GuFqjKds122gUa1aMMmhtUkpMxxnFkqs3OfXrwQpgRDf0/JJWYaYT2cYf5hnzIZ
         g0Vg28t1quOm5l0IUbA3n6Q8MgGD5TzeIx6XeQX0ioRhkY7E3yp0vamoLxo11Y4U4nX5
         nKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763306412; x=1763911212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGA9hYTr1IMErczwCUGeUfRUFMoZs5m5Jm/OUZnJOlI=;
        b=taA/BtRQlnrLq1N9XYhyEe8NB+P5j0bGBLTEmja7qkdUfaNmZDTURU4NwDvF1FAWe0
         DQ/yqBmBuXs9BHRNNYoLDLJpcMuT2X5gMNeS25kJsCzXVmuq8z8Rd1IsENOm88ZSWJWq
         pSTdwvkn4o7hUPMfxaJsRC0FpykhbGR/uZHik9XOKAZ0tijJg4b9X+CbLKkbvccHa+u7
         NhjUXQJ0OdCPB0KWNkwQdnuYzgYvo14GaWCMLMKu1duVHOiOTB4HW2pZp6gFHYa9XlBF
         vfwnTVxEP59p4zn9zeeoPVutinJmMg1IKalECC2J+Fgjy3mO82pBOxQ1zpw5bJv9Mu1r
         T1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXSmzKxrxDTefJNkv+R+5TBvpccE8kPOJGWXmJS4S9I2ukg0S1pkwyCoZBgEy454U34VQ4qKFxq5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWeGqPIcCCG8AfiOslGds1kl0igRtdUdmRYW5bm8GRJb9/Qc+b
	ArPhHz1BTRCVRqXdbr63afWAZKI0COikSJh/cwVGIsBuAG92y0eUDs7spA5/HoT/Xny5o4sDr9O
	HJLg1COgfao2Uv2GdHofogtm/UlLdCXsc90MliI4eyUDG0zzNEQ3H12csyz4HTA==
X-Gm-Gg: ASbGncvF8gQtQ7aCrGcnyOuyy8Ew8CgMy4cG9Q5DEugTrV9rxPYEewaswSAM7WAoQKa
	VvycQcInV0651R3Xpefl/HU4sHMJ+5m7a+0NOwBOGHtZbSb2mz9DuitqEnPwxQrr0Y4ANOIkbhA
	UZZLdJD9sb5mTTChrfLg0cFjpyuMMHWVYa43OpVxXzcYm7Ejz2UQ6gX1aM4p3CoiI2a3Eu64z4Q
	E3oBmqt1xv4nz77/s/rdPlNTeRI8o0HB57v/SP5WzfbGnSGrc5MSbTK+XrSs5STL3IOsH1pXAxd
	nhrip7uG02Rs9IK4HdTBmV/vLi6cw965go7iRoaHf6tHvgiF5WU5rCQ+9xZ0cAIoz7l+LsQrn/r
	wpynQSUCQHxVG8bAjuSWynZTaKYIucpU/MzI=
X-Received: by 2002:a17:903:3c2e:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2986a6d567emr103436595ad.19.1763306412406;
        Sun, 16 Nov 2025 07:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz1vNpP2QFMVLYhK96pUpFR8ZiwKFWbTkTNB2NBCvXCU45AQFzxqStf/RfRDg8o44D6+uVXw==
X-Received: by 2002:a17:903:3c2e:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2986a6d567emr103436295ad.19.1763306411919;
        Sun, 16 Nov 2025 07:20:11 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c241f89sm111166205ad.28.2025.11.16.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:20:11 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 16 Nov 2025 20:49:47 +0530
Subject: [PATCH 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-next-15nov_expose_sysfs-v1-1-3b7880e5b40e@oss.qualcomm.com>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
In-Reply-To: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763306406; l=2382;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=x68jRFp5+Ep135r/sEE2bKgY0z0IuEd+y7yLWTo/bzo=;
 b=KW2TSEm/VotGkWV9be+AEVfXRXm+LoVnESDgwfHl2FRRusPT3QN6GlzniAKbTv6wNrOsX8E1F
 XrZFWDPqBYKAQOMWl5zW/OQ5BDob7VMtzUHfNf6/JEti+B2qTY/V84o
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE2MDEyNyBTYWx0ZWRfX4oQtUKTvG0sC
 OBI8YqC2ej6OdBu8UDeSiu+8tBNqyi84OXQZclw2ZruqsthNd9i65DXRJPlgo7RBBLmtEosSCIB
 KhiqQ/VZml8HELeQCTWGrElyKYzlicgZps17y5+OrNJ04VgnWRpIOGc01KM/g7eMXwyaloZPAoc
 28HNAHblM/lL9kOgEOgE/fL1byorgPzJDzQbpV9oilONBnmyE+ZrWQPzP2I77O3He5QxhMHVG7G
 fHFE/XL+IhtrfsjVnVLKFBnvsfenKCfskGEO12cluaFLsEiH/vreuSFhvZrMarmP5r93FktMoDy
 4292RhXXA9H6jYf4jNOPuwnHb95UEo79KArzzweHObU+bjI5PUCsE5ciEzDBV1MwI49e3yd15dJ
 aQG+5YjqndwPnrhogV057QHn3Xx7WA==
X-Proofpoint-GUID: 82JY40TCvXuavEZchA3HoQe9yRRYUgK1
X-Authority-Analysis: v=2.4 cv=E4vAZKdl c=1 sm=1 tr=0 ts=6919ebad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=LKyF0dicRlewKW4vAhwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: 82JY40TCvXuavEZchA3HoQe9yRRYUgK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511160127

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
read-only sysfs attribute exposing the list of supported reboot-mode
arguments. This file is created by reboot-mode framework and provides a
user-readable interface to query available reboot-mode arguments.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..28280ffe9bf962ef9d2136ea5d7c6aef77c4bd34
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,39 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		November 2025
+KernelVersion:	6.18.0-rc5
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


