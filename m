Return-Path: <linux-pm+bounces-38095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DBC6174E
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 16:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83C2E35371E
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AF22E2DF3;
	Sun, 16 Nov 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gA8sQmID";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QcCZSt+U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7316A956
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763306413; cv=none; b=CvnUKx4RStbSOIUHXwFzOyui+8QqF4LSyhBnVVjZWMkpcWZXAhjFC5opiejNwzhYBc1cB7gc7fNlqujLk1gENsaddYt4OYHHPdDv2dj87Dam00/Enj0SnTiYdenY4cfPjVsmnqgZj2vrb7EuzkfVstiNZmYZ1aAwNfdO3iqaoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763306413; c=relaxed/simple;
	bh=MC5JEYdXy7P4R4AAjgzZeqWyCBV/Peo4M8omPHYHvTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gKOhF9GmOYxx5LjMqm/3OcRTxBy3K9RLX+FTPsFRHxRozF+iwD5HPEN49gHbM1vCdLjsESTA/RZq7N+1PrLr0FjWpSt2geVXfUzgcuZ7DzXEgaYx0yAIZWR5CJdyG6eNHlallIIi27BpeQDnImNhBWX7ZG4ATJ6dAPl8C7LzD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gA8sQmID; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QcCZSt+U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AGAqPwS693370
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q0/6IowwQRnaHgr2jz4j7p
	hEMr+u8umowWWdSoOsEVg=; b=gA8sQmID8VQwXVopJQ1POGkWVnPgkWfR3ZejbZ
	AmPHALzJddhyIHnZFA9Kif9YqeWdxa7ykQJ/MHrl//6hOhKuGViWoqCIfL17Om1w
	ba8FvcWEpz01C3+mhNxhdqwUK9BzrIUx3pA0+1FGWu3MHDhg6F9vDROxxdLWhSEV
	XSg2PvGioEZdyYKBh8LjjValbptbvUTRtSgbc6Eh2r7idbzfy+a0KVzo4FIJ1pYo
	mLJONa7q9B1f/Xn7tfFxaozjKZWFt9KgJQcJDGLcmjb1t0XBSZsfew3k0VLqgNeP
	+g+E2+pNKE0r8ThVA+CyGX1z/rzZICpokHDApVT+0ArMUrwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejh0a90n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2955f0b8895so51809845ad.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763306410; x=1763911210; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0/6IowwQRnaHgr2jz4j7phEMr+u8umowWWdSoOsEVg=;
        b=QcCZSt+UMkWyjKUZvnGOEHZmlUaBELFmjVSOo/8fBzR7s+4RTN0QxeqTktL5T4z4PL
         KBAsEAIRO+/yiWzxuNAB3usxvbwt4h6eufz+xmUlgEtBgHpLdUWXTtffqVTGpJyUknJc
         tfMQdV5zCPycCcpTQ7JfZ5DakmKr5vcegEI9q3XtrtG+UsBUR7MUpNkkkivRen+/24/4
         GZuHwHJSLa5RoVLo8ejNW2gG6gd6cciui7nm6Jf9G5R3otpIVEaGBmK7yNIkdhca9Y/5
         MxIxyI+n7N+REAglHBcqpHOF6Cyo3bhoTT4B2OCioCz0qldAu9RWNiuv2cfTKTaF7eW5
         NICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763306410; x=1763911210;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0/6IowwQRnaHgr2jz4j7phEMr+u8umowWWdSoOsEVg=;
        b=HKu0knXvWZ2rXPb3Km1c8dqaueq8I1MuL5RwGzweqHzRnQncVO3FGThfMfzCEHdagQ
         Mfo8Fe3cneA3FdJYePJWvsYLrQl/XUdA6bbnR5EO+j7v4ZODJqW5TCfIRp0qDlmDxfQP
         n4KOpXTQNesxL5amUdn3u/85QTDcuTdn9U88ZovhVPmEXalXhNUMckiDs/Ibax4cmdhS
         BxnzzEv9DtwVZhBibq1NZNmqlXXD2bGjYHQ9n46tbL7+0Xs+1WL6LBFqIlkcjrKtXYjP
         opjUL7BgCSmJhA+8kqI5CGfk4FMkr/cYT2HEIiih/S3jiTjemGUU5CA5c+dxfDwR//9t
         zvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfvBdC5/xh81wTemtkiQ+E5q0JQIyWbBW6PWIAv47gNXqpibl718CSIUQWC4gguKAxxbhsuHAK0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWItejhJB8KiqLnR0THdsHNjNuOKd6aCRJphSjURBQgwqOfJUb
	6eL9F1NWzd6Tpdzadt4M/QyXeMAkQdSuQ9G6YNdS8Y0I78FVDIOY8ysiBg9UhuF+Rb/OjYcBdSX
	DkAH3rNZrcclKcd4yu4jXOvbDh7DqR17VtpHnt43LbLW+dvcK6KYF7UCRzewWPQ==
X-Gm-Gg: ASbGnctjL3bNSB2UNoZizKFbnM3S7d932OTw6/bMLAtccvKvVD1c7/CJMgMZ6f0JV2d
	ZxCW/IlH5IGNWnARUbLq4qhXfZ7VttI4iXtl67El/KLJ0ly9oaIJysnK683scbyH+dHhMFv8xRV
	HRo02C1DY7o7Ywzl2sjYrPG6nIFYvvNXFRgKua8hM994ggcMJgdpGZ/A4DcA/v7BQuahRPTjVrJ
	Q18AOn6PReZLQck1emF8w48Zk3sD0hUxkB/l8ldMrT0L/H4dL6oN7mJwxTR1uY3HjzCwzKxZKeD
	yMfAiFpu9Gv+dNuk0rZE1sMI/8agtbZcxpwHMHXrL3nTBXtexq3Yi48pTDq6zK3E7rs7vD6Pfy8
	RMRqTG/9yMfW7XvHv+mpleW+yb5BFymYb7IM=
X-Received: by 2002:a17:903:4b4e:b0:297:eb3c:51ed with SMTP id d9443c01a7336-2985a52bd4dmr160885305ad.16.1763306409714;
        Sun, 16 Nov 2025 07:20:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgsCsSC0I+c8dSyeB+kkc3Yi1tduArSbUGLqIA58UJUoYeuSp2N6gfdsmdk4+QDGGxgjKTxA==
X-Received: by 2002:a17:903:4b4e:b0:297:eb3c:51ed with SMTP id d9443c01a7336-2985a52bd4dmr160885035ad.16.1763306409180;
        Sun, 16 Nov 2025 07:20:09 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c241f89sm111166205ad.28.2025.11.16.07.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:20:08 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: [PATCH 0/2] reboot-mode: Expose sysfs for registered reboot modes
Date: Sun, 16 Nov 2025 20:49:46 +0530
Message-Id: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJLrGWkC/x3MQQqAIBBA0avErBOcwKCuEhGlY81Gw4kwpLsnL
 d/i/wJCiUlgbAokulk4hgpsG7DHGnZS7Kqh051BxF4FypdCE+K9UD6j0CKPeFFWu8167czgVqj
 1mchz/s/T/L4f8JLgR2kAAAA=
X-Change-ID: 20251116-next-15nov_expose_sysfs-c0dbcf0d59da
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763306406; l=3373;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=MC5JEYdXy7P4R4AAjgzZeqWyCBV/Peo4M8omPHYHvTs=;
 b=ICXgME0ElElVSAgpSIC26++9HJVKMDuxCev/7fAz1U8IbNSM5qcHQ/+Hyb4Q2iEowssPaXF9U
 v6so/z644RKDI6fxYqX8AdQdEFN03HB4J4Cp1uz9vQ9iWy9cfv44cOg
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 4iYI6ASD0nnR6Qm5Vr-hc0ycHRT7QH8m
X-Authority-Analysis: v=2.4 cv=A8lh/qWG c=1 sm=1 tr=0 ts=6919ebaa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=amjtPp5AYEGc_Cr1mlwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 4iYI6ASD0nnR6Qm5Vr-hc0ycHRT7QH8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE2MDEyNyBTYWx0ZWRfX1ZEosNCb8pwu
 w+Xa6pih7Ai5hXYC99jrZbc0KfJk/Mf2h5Xj2B59uX4A1NavYv/78CLtQSpTINkvX71sdMFl/BI
 LCTEtMM2jGkubFB+mjS8YgeAa+THVrf36hLP8akjdyJ9k/7HjeOBYRGU8grmB0lVm7IFvclWdRE
 93ReiEG6zvpPhbDKPPAvGBhOGFDqkvKdWJLcoBDyIgMCPLRUd94h4UIV/gVdZ25x2B/BaBO8osN
 MebC6a83HLUCkm4fj+VHzbTgWnPJMAkrj5jMRFdC/7LJDiYArgLdVXTumv6ssPyYDk+ADOkc++h
 B2FJQHhBTlb+abCtI3Y9VA5k7G9+lc7wOYf/+MsX2qUUDWXJS58+i3xZ6guetmCE2K0eENX/NCi
 BQJWdxEjNXnV5h84oIBqPjkODXm3Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511160127

The reboot-mode framework provides infrastructure for drivers that want
to implement a userspace reboot command interface. However, there is
currently no standardized way for userspace to discover the list of
supported commands at runtime. This series introduces a sysfs interface
in the reboot-mode framework to expose the list of supported reboot-mode
commands to userspace. This will enable userspace tools to query
available reboot modes using the sysfs interface.

Example:
  cat /sys/class/reboot-mode/<driver-name>/reboot_modes

The series consists of two patches:
  1. power: reset: reboot-mode: Expose sysfs for registered reboot_modes
  2. Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes

These patches were previously being reviewed as part of “vendor resets
for PSCI SYSTEM_RESET2”, until v17. Following the suggestions from
Bjorn, the reboot-mode sysfs patches have been split into a separate
series here, for focused discussions and better alignment.

Previous discussion on these patches:
https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com/
https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-4-46e085bca4cc@oss.qualcomm.com/

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Changes from previous version:
By Bjyon
 - class is made static const and moved on the stack and registered
   using class_register.
 - Renamed name of class variable from rb_class to reboot_mode_class –
   Bart/ Bjyon
 - Renamed function name to prefix reboot_mode* to better align naming
   convention in reboot-mode.
 - Changed reboot_mode_device as static in reboot struct and registered
   using device_register.
 - Used dev_groups, instead of creating the sysfs attr file manually.
 - Continued the reboot-mode registration even if the sysfs creation
   fails at reboot_mode_create_device.
 - Used container of dev in show_reboot_modes to get the structure
   pointer of reboot.

By Bart
 -Synchronize class registration, as there may be race in this lazy
class_register.
 -Remove inversion kind of logic and align the return path of
show_reboot_modes

Other changes
 - reboot_dev is renamed to reboot_mode_device to align the naming
   conventions. 
 - Keep a check on status of device_register with bool flag as
   device_unregister should be called only if the registration was
  successful.
 - Add a dummy function reboot_mode_device_release to avoid warn in
   driver unload path.
 - Date and version change in ABI documentation.

Link to previous series:
https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com

---
Shivendra Pratap (2):
      Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
      power: reset: reboot-mode: Expose sysfs for registered reboot_modes

 .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++
 drivers/power/reset/reboot-mode.c                  | 72 ++++++++++++++++++++++
 include/linux/reboot-mode.h                        |  3 +
 3 files changed, 114 insertions(+)
---
base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
change-id: 20251116-next-15nov_expose_sysfs-c0dbcf0d59da

Best regards,
-- 
Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>


