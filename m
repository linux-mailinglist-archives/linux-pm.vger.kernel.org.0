Return-Path: <linux-pm+bounces-38400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89865C7D50D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 19:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 384E84E0F63
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC2296BD2;
	Sat, 22 Nov 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oulktgeo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wdhn9WsJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295828EA56
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763834762; cv=none; b=D+X8eRdjUDFxrfc+etIXgFqriDOSAvhUCvCmM4hOLEZQBZfkWdCV3On4iLJF9e7YkaWd7D07e7UG2DxfBJpqwufu5t7iIErwPFdZe4O2WiC1G0wGfpchsOtIhhYS1BVznXnydVg9+c0ucQA6i4v9aPsHQskD5v+dtntYVhvfypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763834762; c=relaxed/simple;
	bh=VxFkh726rDNzxUp+vu5HXTMOfHzgzTYNHYjfwD//mFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VLgc2vrLoyZfs89+fBglitXd4QHMknfCqZ03gv7u1yeMX6wEUOfmXtW1xskEZFKto+7f4lsuZsVyDfOhl5xZt0GOzrbEPEudONKpB2JEdqnmYfILU0mim8whbuAHBORxgGjwSGfqnim5Mh64aquCUMIke6MHlx/gbC7kkdoAp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oulktgeo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wdhn9WsJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AMGbVco2961107
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 18:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eP4BeUV5HgCG5Z1jKdwPU8
	2eGdbrp4T3rePFe+y9QeA=; b=oulktgeoA2rrhBU/xcoJoB03wzLcwirlZXgVI4
	b9330MsRjcBOn7GiE2j07ZlcHA1Q7fxQIZpo3ocLRm0kvXS0Mv21+yeTpOWfKmLZ
	2coO4v+AnlwGFoJE9H8hwYS+4AaAv6D0zWC9biS8rBrL55gUi0O9QAnLvCDWSFXG
	bqtKVY3ozqpKYOW0SHqq7g4T/OVIBe6yOOyQQxLKRfqxKF/NIpur2ir+jymuFTg0
	YhAYwPDLz7+JMAIXpKFkGQIQKM+paLxa8qKP5VjfEjngkRILVRXdBtv0wYRofklQ
	nT3kic4ulGf49OBgR1/xvcekZ8Wz3DgKp6OdAAvjmrEuf6mw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak68ds2pw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 18:05:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3437f0760daso7206159a91.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763834758; x=1764439558; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eP4BeUV5HgCG5Z1jKdwPU82eGdbrp4T3rePFe+y9QeA=;
        b=Wdhn9WsJ/R0xFaPyl7gQcTSpCeXcpZwOQbaIN+x6hAUGIf3ecF4spawHVohg3t+VEQ
         7mgkmN7jScUTkAs24lI1Jnj+wyeRqf+QtAF9RIxFxs+CUaheOgWljgg1GCZAPljM5JZ3
         GLlg1nJcuX/HDAAQvf5eWZZMakbGNonCciXWFsiFf02qTfZeJ0b0gUwR1Hb+AqxQY8ic
         Lv+1tRoJt78DUO+jhtMYPwIhaYbdv1MEYGSZXvMq6s5VgctABjHtzSxpcgJ2/wMKoTtB
         w9O2HOjrG+4BJ0Hy6835vVemgyDgvPs7lS9DzUKQXdpkMbgXj5buqCppNCftmTGLVX23
         LR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763834758; x=1764439558;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP4BeUV5HgCG5Z1jKdwPU82eGdbrp4T3rePFe+y9QeA=;
        b=FhgP5bta/4j86QtnPG5T5Hs1wUDOx9d/QpImVQV34VbS2jO27+ERD/coQOarjDywcH
         imkRwcbH2nMGLysft4C3g6+mxtCEf2+vxJDxvI7atKEdhFE6BWd8xdnieMwvA4Qtjpq+
         Qtf9J2t5EznqlGeH1LvrAu9mYx9Rh+qTc884Nl/MK4X3LZQDunSutddmqiHpVv0qw0uL
         Qa1MX0aFT7jOJ+Ftbn3y6NkJ5P0rqEJ9xIurY/Kepnke9+lVJO3p3Ttt2gOwRZ5R94PX
         dTzLnZ7b9AHQ7wu7KMm1UCZTZvFuhFYVl5SIprtk+BkGUviny1mpBVJMngA93yb3rj6L
         xlpg==
X-Forwarded-Encrypted: i=1; AJvYcCW6tOG6cxIVoxoBkDEmD4k9cooOOJ43/FvKdjmLuB1VlwcKSMnuZtESMU2OAijx97Sb7vGC0gJyEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0Z+qWQehevuvBgbSAU7Z6B1xX/nsV8L48zjjdU3pTAIyeqw2
	YVafTRU9Fdr27yjy1McL6+KdGu4YRQEF4lg0eFG2ucxnwdb/ES3B2Q6o6K1/X/ExTFHPonyKRqO
	u9i5xNSkHXbCdQW2sfcarkPn0MjoNgyiw0yaXVMFLmZcQb5sC/31mvB7tz1C5ZA==
X-Gm-Gg: ASbGncuheGzhBmk8ILecZBO/0+vpDrwSC3LajTXIpwhQp8xRHP1ByLM3DxxaNvuj441
	tWQBBS2A2VB8wEBB5PF5XsrtuxxuAeEmwRi/BgraAVawVA2YmbAmSlJ77ncHXweLO45YYW9izg9
	3zTtea9xq/I9ug1ONzTzZ8dDPhXwv4CYw2yca4XadPUB6jhEQ+DYTFZtTWfFqHhi54fg1Ewjirw
	xmd8T8hD6MNdMAb9NMuMiOYI50fsanLwcsymKZVWHJNmHuE6LgqQQR73x70LNGcnZ2GT2xvvwbI
	1+j+pa1vPkpYf8UZRvevIE0kj0j298qYBObD34PWQFa0X0Z7V1zl7/s4F/YaPhG/F+acyZLBtbR
	h3I4QkAut1oCR0btAXq0cyjbel6ltFa9KqPDE8Ze4wRRP4g==
X-Received: by 2002:a05:6a20:939d:b0:35d:cc9a:8bc2 with SMTP id adf61e73a8af0-36150f069b1mr7014211637.31.1763834758154;
        Sat, 22 Nov 2025 10:05:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7y9JbnxKHn6B/H9oK3//Vm9mIUGLBoFzZyKNv6if14trCqItn/bJTq7IEGOA+wqEP/ydqIg==
X-Received: by 2002:a05:6a20:939d:b0:35d:cc9a:8bc2 with SMTP id adf61e73a8af0-36150f069b1mr7014180637.31.1763834757630;
        Sat, 22 Nov 2025 10:05:57 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fafe57sm8763553a12.33.2025.11.22.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 10:05:57 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: [PATCH v19 0/2] reboot-mode: Expose sysfs for registered reboot
 modes
Date: Sat, 22 Nov 2025 23:35:43 +0530
Message-Id: <20251122-next-15nov_expose_sysfs-v19-0-4d3d578ad9ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHf7IWkC/4WNUQ6CMBBEr2L225IuWgW/vIchBNpFmkiLXWwgh
 LtbuYA/k7xJ5s0KTMESw+2wQqBo2XqXAMvjAXTfuCcJa1IBucwVIl6Eo3kSqJyPNc2jZ6p54Y6
 FlqbVnTSqNA2k9Rios/OuflSJe8uTD8v+FPHX/ndGFFKc2mtRSFLtWdLdM2fvT/PSfhiyFFBt2
 /YFFufVZMYAAAA=
X-Change-ID: 20251116-next-15nov_expose_sysfs-c0dbcf0d59da
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763834754; l=4262;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=VxFkh726rDNzxUp+vu5HXTMOfHzgzTYNHYjfwD//mFY=;
 b=fbTCh+PR5NrC3lJMeZEWqrs9j5YeXCC6R4o7wjBgZnw6vXue8fO5/hNGe358D2yu+BRW4t7Mx
 ei2kGqVnwgABJkLmIkxVLmGKCzNWvrEhPnIyTAzrRUkeo0xCDy+PDc6
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDE1MCBTYWx0ZWRfX18jykpaUTthH
 mER0H8hMrFSGPHLoaS5bGurdfzk/znKWqecEkCJKeA5lZO68C7zLppuklxoNC0fD0hNxww83kMm
 i6qLLMzxkeSmh/uxoi/11XKlPEqHMjx+mwDdaqhUpS+x8ZasI7b6R2ftddcwyiiawbMax95Kba1
 NCcQ3MyiDJb1LQcqBQXcrYKVL+bVi1vs5WZUDGc0JTMrTk0E5ZfNhN75gfoUBczopp366gmqaLO
 q/XxHZS9F/rbjVbbSdNshSnfJa/uY3eMkNWVYcJhHXIU9TZt5d9N01XZA63MeFnETmAA3rJI7wB
 0YeZMmkfpTIXJzOQpqm5OQr2Ae5qL0HnFWYzeSsPifzsZluzuNehvcSmG2aA+FnhJXuRtK9W5GV
 S2bY39LwmaP3s3ElO7GRC9aIhONZ4A==
X-Proofpoint-GUID: oLOizJ_Cr4SlwweKXdjpR2KAs4EyxUyq
X-Proofpoint-ORIG-GUID: oLOizJ_Cr4SlwweKXdjpR2KAs4EyxUyq
X-Authority-Analysis: v=2.4 cv=UsBu9uwB c=1 sm=1 tr=0 ts=6921fb87 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jZ2Nz-NwOMBJIO0keyIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-22_07,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511220150

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

Changes in v19:
By Bart
 - Added subsys_initcall and moved class_register to initcall.

By Bjorn
 - Remove example of reboot SYSCALL from ABI documentation and mention
  about this being standard interface.

For Alignment
 - Added module_init/module_exit, in case reboot-mode is compiled as module.
 - Call class_unregister on module_exit.
 - Remove mutex lock on class_register as its not needed now.
 - Added a static bool reboot_mode_class_registered, to save the status of
   class registration.
 - Rename reboot_mode_create_device to reboot_mode_register_device.
    - Removed class_register as its moved to initcall.
 - Version correction for split series: Previous changed to v18.
 - Corrected Typo in Bjorn's Name in last change history.
- Link to v18: https://lore.kernel.org/r/20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com
  - *v18 was sent as v1 in last post.

Changes in v18:
By Bjorn 
 - class is made static const and moved on the stack and registered
   using class_register.
 - Renamed name of class variable from rb_class to reboot_mode_class –
   Bart/ Bjorn
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
Link to v17:
https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com

---
---
Shivendra Pratap (2):
      Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
      power: reset: reboot-mode: Expose sysfs for registered reboot_modes

 .../testing/sysfs-class-reboot-mode-reboot_modes   | 36 +++++++++
 drivers/power/reset/reboot-mode.c                  | 86 ++++++++++++++++++++++
 include/linux/reboot-mode.h                        |  3 +
 3 files changed, 125 insertions(+)
---
base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
change-id: 20251116-next-15nov_expose_sysfs-c0dbcf0d59da

Best regards,
-- 
Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>


