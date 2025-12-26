Return-Path: <linux-pm+bounces-39954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB9CDEEC9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0174D3007280
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7DD277CA5;
	Fri, 26 Dec 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHhhSnoM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxJaYJuu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A52459CF
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766775404; cv=none; b=MhCIiBR/HZO50e8ry3p0WxbNG7k4vkD31ca6BA//IXL8oZfnRoznwrvheK/kBoGGLN6b+XBoSrLJ3FhqFRkdqEIdrmFGyXdm+8LGM8IxobJkR1PC/8oXSyGkhEw4FxiP5SMafJKZBpn2v/k5f+PVm1F0GanH8D1Hfory/OK9TuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766775404; c=relaxed/simple;
	bh=VbqIQMroIlq6JMMANB+DTWjTL1f1TuzU3o0hZWDdc+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khERu1pSv8IQxFqfCQhp+2WJA5Er8MVc8ct/Be3DcutnghP0bSFqcncZLEFYthOcq6SsPuR6jaRwvURN8gCZrfgClOmspJcQSpXv884FoJsX6DhFbUP/gtIF6Na519iivNLxLAfr+ci3ESd6wH9zhO2aeh72MHFgl39qXjtUhe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHhhSnoM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxJaYJuu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BQ8bjf52454509
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 18:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maLQn0/g6TQ0tBQyQOJF0vW4h969wzxQrbt5sqlv9hw=; b=lHhhSnoMJYdVHeZl
	PpIZjGnobDA0orpmLSNWu5yRdrBXr9oszi3rQDyEv+lQOTJjaVbfOPVML8xvikU1
	D+LZJwJXWh7+r5QvfglSw8rePqNVjSOZdaqKLsjrSsJLIz1++52kTlKM9Rhw9Nul
	3SH3uGD4iTA4/5eNrW0zMSeQouW7f1766xlQyrVy5nKMfnsq1wxkMmtHp2j0EIYu
	aSvpRcyT4PA9r61UsQyphtoAZqljP63+jKymcFStM0Uf9F+dGuGDx9K5WRGc9BHX
	QWk5G3zgawnMXT7qfErrOa7XtufXFCOxyDH2dCrKLSE19uQpeHbW4H3iP4d44cr3
	nwWEIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8hwe4vby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 18:56:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7aa9f595688so11516993b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 10:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766775402; x=1767380202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maLQn0/g6TQ0tBQyQOJF0vW4h969wzxQrbt5sqlv9hw=;
        b=TxJaYJuuWbbNvQxrDhQyw0ruwSk7fchj8xe+/WOWxND0fkA45R/MgS3YB0miQJ6nTO
         IupxwIE7IQW7u7NkFEe7WhZQkB5NulQ5oO68fpUuufShrTM8/Ib3f39vfMugyAYgH0vq
         fJm7XubyRCyj+0V/o2u4s1KKDtN/RKxANKp749vsy10AMR0rzs1KkLFLYoDzAdwbHJnL
         E27ZQdOUzZYWBotQq2tq+IoPfRpiykkCAxZFB0grOjlLyIW/2FW0hdJZJmdViJk0WD2M
         Z3S0uccdFZQnX3xS+30pyg3Xu2Jwtv4kGFUqgVKXyrEIcjJ8RBzUbH6ZB7U6lEACZ2gs
         ebhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766775402; x=1767380202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=maLQn0/g6TQ0tBQyQOJF0vW4h969wzxQrbt5sqlv9hw=;
        b=Z4YdImm102A1iUriXpx55h54qsR/lVtBiXTZcW5rxgE9XYP1GiB0V6VvhR6E889HAC
         wgUWuz2OpA5y0VVDRayIVvvSrbZijo91uj71Uadp4J7ZDcNHp1uYaWurpcf5s9exp5qc
         l9p7Iy7OUlpF0lk0HffcvOqlmT6OggOhWgpC85nurugL8wAiDI5OVRyVnuwXkM4uaQA0
         RCiA2FPvcVH/wLH+ZdAPCXU1jx41NTTeYffZHpDjIe9vI5tj3JvGI/zK/QlUvnluYZHx
         /Qk4MV76tMZIclT0jLBDVB250c8ONTYQ+O+/1GcPCEK4Dx0dA2zNm1oFLXHIcy+e31BY
         rUBw==
X-Forwarded-Encrypted: i=1; AJvYcCVEckvWRhulyFcaXHQh3rzN9qz/dmSUflekzqvkR/QNEZ8Kp+GadIr8jX2oqgdfvNwbNmUmnJGfyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWV8UfCkTOFVUWBdNYPElVlGpPxQBKLS1UIcDBLbx9jhb48Re
	4GWZioU5ZUM4aI/YAOZtoAwE7nJj4X9GEW7q2QekY5vU60uOjVNGDNonuV9wYqe8mZsM2tiYP3t
	94LqqQmZByV4Ypn5l2I51t/DgU39HIfkoJv0Wyc80eH8ZtJh5weMpNRtPKSXoig==
X-Gm-Gg: AY/fxX7Ug+v+qJU+QlS3DOqT8AneBf8mTDFRnkPrHBbhOwTWFhN+tztWcj6g3p/s2SD
	1D5va4zCHa++4xVCTzaTeca97o3i3cJ9O81RGAGFo7YoPQeeeSFff2kQRZcwhpU3lJ0nPmD2UOf
	pU9A4Cb0/vYv35JD71C2Ld0sM955e/NDKZ5Xypvtx4NuixtPgT3ZcjtLELEsXwF1T0QJO+Hz/+/
	w8a3eiqzmNqe9ua4m3xp/dRbyiiXBDl6ZTLZINblWkqokcRGhD2CrTS2fVtr8NxThNdxd+13i2u
	LldktPNyGXgmWizeoR5TvpIkxHu5y1l98lG1XouOB26sVhVH3MO0clo0LD2mMAgMoWdc4ibx589
	p44E8Py6rsWkJy3q9ecn6rrH0MkrQwfpfmTDTOZjd4okYkA==
X-Received: by 2002:a05:6a00:1d27:b0:7f7:1857:8456 with SMTP id d2e1a72fcca58-7ff6667cdb2mr20548014b3a.55.1766775402141;
        Fri, 26 Dec 2025 10:56:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERWjkBwyqqrCPa7tb3AVg5b/stcMwi80y4amP/imcusyJfTWAvkM8b4jFCAfc7rNtZDEIG3g==
X-Received: by 2002:a05:6a00:1d27:b0:7f7:1857:8456 with SMTP id d2e1a72fcca58-7ff6667cdb2mr20547997b3a.55.1766775401707;
        Fri, 26 Dec 2025 10:56:41 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e88cd71sm22638187b3a.64.2025.12.26.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 10:56:41 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sat, 27 Dec 2025 00:26:33 +0530
Subject: [PATCH v22 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-next-15nov_expose_sysfs-v22-1-2d153438ba19@oss.qualcomm.com>
References: <20251227-next-15nov_expose_sysfs-v22-0-2d153438ba19@oss.qualcomm.com>
In-Reply-To: <20251227-next-15nov_expose_sysfs-v22-0-2d153438ba19@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766775395; l=2330;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=VbqIQMroIlq6JMMANB+DTWjTL1f1TuzU3o0hZWDdc+U=;
 b=YwXhOppQlqYvmBBf4fFNIoB7tI3zaKTtQvQ09Aq2dEY2KHHMWL6LPmNCn4iulQmTqKnjZWxr2
 IWYEMyCGav/BcyUaB38KPl+ey2tvAJPHkVy/02G+lZ3f2HmvJJSDVPl
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDE3NyBTYWx0ZWRfX2bVLNQ4gt80Y
 HPukTBOf8VBo6ab+6MC61r4m8uLg//KTnxHbRcKl69L2/LBV8AXDkcXBeSyX+jpL5s7HY05ViRe
 1JtfRKBPYPEm4ngdHusoWpheju5NxKyD43GsM4q6HAOfSL2EKeuKJPyV95ZDCcDYZAxcYtwochs
 3m6KDf1hk8uG4kKwoLgZCQrI6nBwHdks88Ki1xZu66rn6NYR1SmNBdrVnjyXZ2yNr2Plj+1mZRY
 piqygDkKEVjp0u39Lj+5Yk8oFH9UDAyQzu57uNs1odJnAikw9XA+xOi0re2GRTe2lPvQ+tHBHy8
 QGo1bqczoZkE7PCFyfZ7CHmp/guZr66mdeJnjRoN+qm21OsOoC6wlcj8y0ezdBK8w3vJNpK5Nk0
 lb05WWDUpQDqqdIsoMABluVrm1zwo1BTveTZV5HN/V7XH6NGUG6jeuyBiiT+qqMBQnvYMukjCRk
 ErmHmq2kMsN9MCTKXIQ==
X-Proofpoint-GUID: z23JMF9eUf2YzagbGpMui6sahyKvWAdR
X-Proofpoint-ORIG-GUID: z23JMF9eUf2YzagbGpMui6sahyKvWAdR
X-Authority-Analysis: v=2.4 cv=P9c3RyAu c=1 sm=1 tr=0 ts=694eda6a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=LKyF0dicRlewKW4vAhwA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_05,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512260177

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


