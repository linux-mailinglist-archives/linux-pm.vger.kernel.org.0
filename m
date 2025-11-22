Return-Path: <linux-pm+bounces-38401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF7DC7D513
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 19:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150A63A99DF
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58F298CC9;
	Sat, 22 Nov 2025 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YyeRt0Xw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lq3+Q1qb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EF296BD7
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763834764; cv=none; b=E9QyZQmKEzMHlhfoZAZQmc+JU0sTEVpcXctZsLIqh3FYfaKCtKQjg6Jd4bUNWLBprGIYvLh6DHxWO4+Ce8WALrruVPOaOXvxqnCuji3GiAnwgtbT+BZQHAXVRu16nU3uJ1NvqaBKok5txRBxujLlVDl5xjflmqj2MFT/zQjh7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763834764; c=relaxed/simple;
	bh=usgZ50lsKAOs/daHoCBRLBx0aO1Pg/3aRrkQMCznHx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o892T9G5c4yHSNPFqNCrkPGYSgvkcbdUlBREQOriCP3OjNOLH/rfPGAnSUkd3tOuSo3WHdamj8GEWFOE/BqjOIzOlRqUM2fiLIbG0iAlv7bt3SDho/FK7Al7UTAmgcMA6NQ0SQ6OKW9RLadY1HKFt1Qs7Bt13eQ+IIHBkm2xS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YyeRt0Xw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lq3+Q1qb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AMGcLEV2962428
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 18:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zbSn4WvxMEi5fN3EkuAFKvYhh+IG+Q93MMbD1rInegA=; b=YyeRt0Xw9hj+fUHW
	cK4aXbymvgcae4MXMKybcuK9VtwkpziSRjmOqiUcOihCRo3tFeieeselY65R+POR
	fqifg/wufuQ4/U/IHcH3VHngnDcdffwlqGdKi4ednwDrhqLn5fv3SJMXI3+f9uBP
	HxlCSdr9HWW9qrLDeuNX+8ey1FvI9PVvh5n98jRy8tV0yF1fbUc6bivchP06CFNe
	zEIiDK3O82mY/vpYRzjKRcPnTVMDDaWUsVkSivKgqV6iMLj1OcXYNIrxDj9cXRh5
	u6kXj34obzh+3rckjoYXt1sygJrin5/HRcfVWiWoxILfLwMGUb6tQwmhyYDuBJVc
	4vFMLQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak68ds2py-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 18:06:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343806688cbso7815773a91.3
        for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763834761; x=1764439561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbSn4WvxMEi5fN3EkuAFKvYhh+IG+Q93MMbD1rInegA=;
        b=Lq3+Q1qbesBV7HB2FdpbAxZ6muNthWb1CpsnAfymHCzkbdlfV+/HfQwbQxgnd1F6tZ
         ccYR+H9zhWuR0AB+Qjgwrd/LGxooWiPLK6Eqd9btFDu+pVn0A2CcWZECncRgbHtcW+4V
         VhoM+lIGNBy6ppn9cpkzZ/WLItA5OoRc309+cj6cWDlOxKffOUuWj5ulsQ7yPme+NpqZ
         1pTbKt52N4NjlkLa9UJec803q3WeuvfM0+nRfIBKpXJIu1z0/yLcf2qHPfFUqADSa1GT
         QYYp3IKJLt1aIAdN2UrHphKkSJPIU6Xbf2ZjSjF8jleDyNInLcR67ojfaWPIz6VZYk6h
         VWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763834761; x=1764439561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zbSn4WvxMEi5fN3EkuAFKvYhh+IG+Q93MMbD1rInegA=;
        b=NfMOpOYMctUPGU3Gw/5WwaRueS3ssnIrv2dxUlyhh2hM0/sea3Nj+uQ6kOGmNiYnnF
         FB0zos8Wuy/JQ+StT44+6bln+MYtymTqpHlXtSZn0B9lc9+HLy5r4lYaB86aKkuzTiL2
         zdPmPFvAbuSuiqhSn5faKzjKmid8wKyL4phfK1wI7QB7GGZSyWJSFK/r6AUuwx1LvfhJ
         Mf/W/55rTBJzWk7r/c7tF6Pg0eiM7objsX9RNF0AQrJWqUg/xcETGrblS6q+YGGwEXSu
         3Me689HVBftUneI663zoEASNd2sZV42h9P9IzKVcX1B4TbosBEcZ2MOsir79MrZ7H9ET
         cs4w==
X-Forwarded-Encrypted: i=1; AJvYcCX19x0nLXropQKDS9A6IVPhgaIwqMNScsYsjtITqV+4UxJg1rI2ZmORbL1RYGVD9SGoocLdHJMvog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVvzhGxlEzGBaquRNrcK8QikoVHhDwmbb0CgcUwT0f4IzI0Q/
	yi3G0uEOj6GOd5tPrCmBaSVTzb1X5SI9YjtVjLIh0LmYdi7yFnw68oTvcK0xTj8nxxpvxyNPdd5
	G3h0gtlNKZejH1TbUOjunjPCz4rlbXDRq8cPCcKtuU+cGKR1QZZ1iui/xaOwOsQ==
X-Gm-Gg: ASbGncvE3LKXZL0D7pmzCGd8laBj8nzsoy+D+cIZ7TteUHgblNoHdHy8UfV89mpuEXm
	rR+FVqUOK0xH9kqUS8+6MDq1Hwb9JnFnCV8IEgZuBn9NFBWjIkR+qu1VtWVKpWCrG0HTtsUOSzk
	FMBGwZVl8fVgtNUCIazH01q8/DEffVztj7CoyHu65zf1CeJQqas6usqW1X3vjEszz5QN1QyXRLp
	bYLz0OihRxFPd5+XTfdopA/rg2lo1TUROVgO98Zi3lUjZO+euuf+njsbHmzXcK9Mlx2zNIVLwcF
	P+TonsGJJe8FMhAGywEIZPb50GQl3E539BhTkWcc71OeNHdQOg4tcFJ4Eyh/Gw9LVrhRrWLgziF
	x8z0rdlGOTmnYh2FoVuCEJfGjEnjrv2hit5NTwu8RPjjDyw==
X-Received: by 2002:a17:90b:2b50:b0:340:ec6f:5ad0 with SMTP id 98e67ed59e1d1-34733e55257mr5999384a91.1.1763834761037;
        Sat, 22 Nov 2025 10:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Q3Vwhdetg7OFvyAcv7ginE73yeRL9+GumCPtMyoF9318svFS+oZEbcsRUpDgmTAS6kpAig==
X-Received: by 2002:a17:90b:2b50:b0:340:ec6f:5ad0 with SMTP id 98e67ed59e1d1-34733e55257mr5999366a91.1.1763834760522;
        Sat, 22 Nov 2025 10:06:00 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fafe57sm8763553a12.33.2025.11.22.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 10:06:00 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sat, 22 Nov 2025 23:35:44 +0530
Subject: [PATCH v19 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251122-next-15nov_expose_sysfs-v19-1-4d3d578ad9ee@oss.qualcomm.com>
References: <20251122-next-15nov_expose_sysfs-v19-0-4d3d578ad9ee@oss.qualcomm.com>
In-Reply-To: <20251122-next-15nov_expose_sysfs-v19-0-4d3d578ad9ee@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763834754; l=2280;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=usgZ50lsKAOs/daHoCBRLBx0aO1Pg/3aRrkQMCznHx8=;
 b=CRQqs+Q/CFiIjzboSpFW8bgjM07eldLYs+opndTcqLPPh6wJQmp08ljteF7qZi0b7ihl22j4N
 s6WEtr6cJRNAcEQuvuJ80jQFH6nFT/gPa6+EzEIDMc98o3q0RHOsoWb
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDE1MCBTYWx0ZWRfX1fe6smp1lj1w
 +Rv3qoKVt2/43qJ/VTqBh0HmJkmdWeJx2gDi/NVQTwCrH+5j17fywIJH5o/itjbhQ52qLh9rEAn
 i7x1p+GbJa3Wgq2pLbW+dk4+JOMsil8LxRzTnl7AA4sTAkNj2+FkDSTyAMbOdVqMF6ipTUdwrV6
 00+dw5T088DNl/uD1hUs++55j/wfgMHvMwx0gXW8FCDXLyYhwc4rIhVs5pX0yhAtrE4G1WEDZ8l
 LqWbzM2Q99WOKm9GUbGoARLHtMutYH+1V6u0rHm3SE2cwr6jKhiUJUXU2BDI4hSbFHcVacaBJ8p
 LU5AxUOYB86QPB4APZ91a849Faxa1RXyUjh/OXlvg7mqS4s0qzwEbFi+dbKZnP27j+a57vB/FGZ
 8r1/KucZQZYcQzYlp6HPmiUhqJlCGA==
X-Proofpoint-GUID: 96VIBfIPREoBadPuPdafLzRk0MVXCyGN
X-Proofpoint-ORIG-GUID: 96VIBfIPREoBadPuPdafLzRk0MVXCyGN
X-Authority-Analysis: v=2.4 cv=UsBu9uwB c=1 sm=1 tr=0 ts=6921fb89 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=LKyF0dicRlewKW4vAhwA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-22_07,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511220150

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
read-only sysfs attribute exposing the list of supported reboot-mode
arguments. This file is created by reboot-mode framework and provides a
user-readable interface to query available reboot-mode arguments.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..a50f9433942b8cab4cb3d699e9c0955299ec48f0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,36 @@
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
+		The supported arguments can be used by userspace to
+		invoke device reset using the standard reboot() system
+		call interface, with the "argument" as string to "*arg"
+		parameter along with LINUX_REBOOT_CMD_RESTART2.
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


