Return-Path: <linux-pm+bounces-39770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B056CD4A22
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 04:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2636030065BB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 03:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ED932572A;
	Mon, 22 Dec 2025 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/fpNBIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CEk2oKdM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD0324B24
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766374423; cv=none; b=uLmHct65LXOViol5JLK1nAzcT6mg5+s30iT+mV4UwO5iuStAfX5kE9Mrk9RoC4luMaKAXWXySiYUwzvujEJZ+7MWYpHAqMDHXagGoADTeicTOHxzjhGOYtDrIDolZ2Lzvl+BIjAzi7yc/TyMABEYayX/ljpT+MCC0mEmmkBnBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766374423; c=relaxed/simple;
	bh=VbqIQMroIlq6JMMANB+DTWjTL1f1TuzU3o0hZWDdc+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSYvjkOrj5i0iNCf98lEROjnQUXnUtLv8rtehYAf+TMmXe3hEBCALrAn0r+79OLoNk/FdnyOF2nrv61iajxfLCU5Z5zIhfGKBnlaDUpXl2MkX64JyBx48Z/dkW/3wSj4yDIr5N++AtbniTcMhMa4gJTtM8TiNPPC+TQzqhNiRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/fpNBIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CEk2oKdM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM09BIW1491735
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 03:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maLQn0/g6TQ0tBQyQOJF0vW4h969wzxQrbt5sqlv9hw=; b=F/fpNBIYl6HNaJLg
	aNAmKjLIzQqgdtCe3eeJAYz2AUnDPs/cF9+vWUBowBC63lOG93CnaqONVQoV6KGn
	bmtYxSVrtzLpHwlgrXycM8v0xOq/27tzzqXXdbXu2L02xIdb2d2MPtDXt3DmNjhP
	ZlxoGNBDgTyabaHDHFvPZprjP+lxRF4x1JNSRCv82O9DX0tiZ20Y3HugodcAVVI5
	BkI0auNXYCW1O4Rysab3NPR/Gf0wPaArpxWFP5QazGH9NTdkNqSXznWHbEDFtjGp
	YchcZW2cni7TaPtY3q8yVHCkkewYlWIBMA5QCuqnMUM7UiPaiuyIe45tZmATL5jY
	LXubFA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mydufqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 03:33:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7f89d880668so5410566b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2025 19:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766374420; x=1766979220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maLQn0/g6TQ0tBQyQOJF0vW4h969wzxQrbt5sqlv9hw=;
        b=CEk2oKdMZJJ6ILrO8pmmHWWfvkZs2+M6Z5PEUcmNtlVG7PiHolBk6vwBocCBAwKQNt
         60UFSjPzqWs8N6ksOy2eDJFUV+gdW+aaO/Swsjs1NOJqem0+tToIIoHnD8sUEIyvh3y6
         zcK00gpfjuvikc8AIeHQnM1WtylpU2mjxzv3xWxblF7C626eGFnsmI94YjG04A/KIeFC
         j2g1kM2t/qhx+yUF19eToXpdlffDMgtzvVYSLK9ohIBnunkvWiGLNlswYx2f3L/oTRRI
         GnV+Bq4AdFnPv1gI5T3q7mwof9doRcYBXvqpMkhh0VFHg+fli2aJaC42MIFuvxu5XsE8
         Unjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766374420; x=1766979220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=maLQn0/g6TQ0tBQyQOJF0vW4h969wzxQrbt5sqlv9hw=;
        b=bEC4+oZUtgB458xOxY4bIUKpiyJIYJUbFgZb7IEqA/WrwD1ne1TJ6no0cz6AuF+TDt
         2rn0RdjC06JrnWEhKJyfcnpUdQij85teW7pPZC9tuCjvPmMRq79DSmFJKAg8potcpIUr
         mAaC8L36wzp9ZISxEAxDj3x3gQexTwoJxvkIk4BQJOKo7JTWsNt5cclaXVdlCPgEov5M
         Z/lrOvnz8lJ+PT0RqjTjlZJgdmXcMy72pRq1VdIt46X9LfK9PLDZqz06swYBaz9HqkMw
         dp970cLOqRXmu9WrqbsG9THVvWf7G/A100yWMh+DEJ/p+iGOxUWnncGHHR65nzhyFXU+
         6dqw==
X-Forwarded-Encrypted: i=1; AJvYcCWS0vWeGkWcvDRTGjdX9RBQbnnayDuhxB/hEp4RsDqQqxPCBRBANwuRCslQgvI1gHCmUDiiaILc8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpjdzMLSPSUPNFqhjDzho4JBrHJpewkCxo/WOP8aHMhynNluS
	q9nIA1cgBdqWj+7klmPCcUk4yWRkyvgNBTdxpaowYT1PhRiEf8UjCw+P5djuqE9SyW1wikLbTwI
	HTw7ziaSyBi5FFJ7evLp2O/xrEOdTgSlqQhZsNBdGgCGsN6s6TYXRr7X4Szw1iw==
X-Gm-Gg: AY/fxX7Xfkm5Orcz9Dn37IiBNWNxITN3MeJtgAt1guygIvTNqano6qgeXfK5Ef9iEGa
	MjAaEk9bxDWv4PaniG2XDJ8HUN3RVuIquH3+4RaiTIMyKiExPke71Q3fNAGD2G/5GAeATCLRwOj
	QC5HZGnPVyIFEHjxb5L6cpVToqpl4c/T8bHF8tN4w2apMDoJG3UWOtn3gWrA5w6Y+iGWigiqD7F
	/UaaSplBlruA3Z32Xoe2qI1/tT7P4b4TleprImmaEM9OA4omBYOgdOArOiTOXZWJzeg2GD5cLJV
	RGCNCUW5pRS3n+Ns3ddmIXiH05NTvIUmWotXjU0giF7XZ3V8x7UnC0iJ9AFittUoZi4xIAnNCwM
	VkgaCvejY7TEfpzesD7lc41IL/16vMgWfnPtWMbtZBMbmQQ==
X-Received: by 2002:a05:6a00:278e:b0:7f6:fd3b:caa6 with SMTP id d2e1a72fcca58-7ff648e960dmr8020682b3a.19.1766374420096;
        Sun, 21 Dec 2025 19:33:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3QmlHGy4R/5KCHdv5JakzwKHqFIBpAMkQx1RSf2GWhEA8H3a8GxhflUP36jW16Vr8xOKCiw==
X-Received: by 2002:a05:6a00:278e:b0:7f6:fd3b:caa6 with SMTP id d2e1a72fcca58-7ff648e960dmr8020662b3a.19.1766374419570;
        Sun, 21 Dec 2025 19:33:39 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f30bsm8633837b3a.48.2025.12.21.19.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 19:33:39 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 09:03:22 +0530
Subject: [PATCH v21 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-next-15nov_expose_sysfs-v21-1-244614135fd8@oss.qualcomm.com>
References: <20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com>
In-Reply-To: <20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766374413; l=2330;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=VbqIQMroIlq6JMMANB+DTWjTL1f1TuzU3o0hZWDdc+U=;
 b=C9EPPyOVk0N+CORGqGEGXbEzd2hhvAhcAHUiniYT0EhnRLbDR1Ty1ZmeOPaGp61VTSeeZwt7y
 rb1ux/CI/J7CGfOc8h+Ir3w8G1xlThmYj1Rt4uvSPw60ikotJ7J4tJW
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: Wa0BPVwwAc5kFzw8eOgvO3vhCjgwAauu
X-Proofpoint-ORIG-GUID: Wa0BPVwwAc5kFzw8eOgvO3vhCjgwAauu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAyOSBTYWx0ZWRfX0op5ytSPX31N
 a+MEe0sH0T1u7mbnXk+jNLi//cxErAH1ayOz3DWUVQHyb7N/ygfh2qCoJc6hhLokN+JmtgBT0Wn
 0dDBvuAgdsmr9F4ZS4uiByAtBWpW1IQskqKqZoXgqu7VseGWMcdtOjP5KTDicJIpSIi/Ccc/brG
 Higj7o5aivAcH/cBdkeoezjL/9Aj73J0mi3vvLgObvYo6+j5SjFFVVjKgYet9EhQ1XmeaOMQrjO
 7dUxfDrszDPZGR1gf1f+3WnPAU+aDqvUdOp3AlQtzVFA0ZcCfWsG2nI3Qf2JzFaHwdzsrpNkQUN
 DCPYmE/E602ruo24OBYCYkAP2r7oQ/TqW6bgwnZ0Y2x67qom+oYzsG7eVamAwhPu/g0zlP2ujcf
 LdjwxUHa9XcbYKkL2EROEIiEr0SJqpt1XCKu9TiAz8P64sV5/4t/1Wdr0qfQVYyCd3+oPQq84EP
 JVqLmfiwyYhdo7W2WYQ==
X-Authority-Analysis: v=2.4 cv=N6wk1m9B c=1 sm=1 tr=0 ts=6948bc14 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=LKyF0dicRlewKW4vAhwA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220029

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
read-only sysfs attribute exposing the list of supported reboot-mode
arguments. This file is created by reboot-mode framework and provides a
user-readable interface to query available reboot-mode arguments.

Reviewed-by: Bartosz Golaszewski <brgl@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..dc27cb4e698eebc99e72821225e8bf3bbe7cc7e6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,36 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		December 2025
+KernelVersion:	6.19-rc1
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


