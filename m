Return-Path: <linux-pm+bounces-38930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB3C95342
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08CE34E01EA
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268F28C5B1;
	Sun, 30 Nov 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gYBqFqC7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J17yihxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE727FB1C
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764526892; cv=none; b=ZaohMnyrHcbZiD0PHMUCx/3ZQJmyOOcMV4PWe85UoBYaVqzpDvDcbkRMpz79Y4FQLWU/kIzCXxhriAWKAaGO7gGefoITdH3iSc/M7GfJIieWFtN/+nLsx4eOIWCqskWWP2bJj6BKIMve4k9REo9Lf/gfiKLUM6F9DQPa/lPCeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764526892; c=relaxed/simple;
	bh=4+sHuyVROK0XcOi41cRvBlL3Uge9KrVbF0txjUuCfnw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rbLbOCk8sC7W4/L7oz8VaPScLTPnJy4rUHigOWKRPRAYju4nKGFTMfbMDNh5shdjhxZRYm99bdmeVuCOVBRgrSVfKCehGorYKf4tiUEINLMlS/XvWh+GrSj882+SzHwfERRwXtAsafyP8MwmkcWly6XCucjCIV7e7OzBfZge7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gYBqFqC7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J17yihxi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AUHNdho1977654
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 18:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+IWV1SuRVvqlXsnbQxeHVV
	wXDwYw6P1R2V45EyccHyE=; b=gYBqFqC7NO/WLtg497tqzyIGFm0joxjBu2cBjR
	pTi4VCxcHlWeMHmu9RhNyIDNcGnSWx+f6yMk8zYnAjrpvisFvRVup1vFNXumoP7U
	avdiDcY99X5cfK4w4PNv5waP17yeqerl8v6STXgeIKvVb2VUFgMMb4eSHeeyUT4f
	mMMB92jwhSGUK47mTqG+TN/nCVSO96o2CFaD1H7LPfhTFvc1GwiEVz0fXbGBLlxm
	Suqepnb+/M1SKBzbWS/E/cw8dEAzoUTE1k6KsG91vXYiCGwvYhztJJKqdFMRA+Rt
	qFJEyBK0SiHXJHqsSTUapJPnL5N4RgNj0ulDEzVBE8Y8lq5Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqs20tk6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 18:21:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29806c42760so119700245ad.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764526889; x=1765131689; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IWV1SuRVvqlXsnbQxeHVVwXDwYw6P1R2V45EyccHyE=;
        b=J17yihxiqcebIcvdZYV5iMsFT51tPFUmXaqb+i/DplOX3rZt0yZwks36Ulap3GWbcY
         ddW85hO8drxNEVeYTPZd+MbKym2OyOVabv04GBKymb95t6l7GKFqbKEONpNYmKfuDblI
         dZmqig/rt+n9q8ieJj3+PdAPbYjMcJMf0ScNr98MFIeenKyVntLa0UkORlAyLBr9/YJj
         mJ4HjWFR6rrk+HGu83eNyGsFmCp5nDW9KRxuYRGkNIFGbf9eIa6BSa7ObCBu8v8L4lv7
         bsSmxFuDGQLdh1aYYOdrBSnx68QE+qkJ38nfKdJvGqsOj/1w5Uy+E2rbje5afZDesbvX
         Aocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764526889; x=1765131689;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IWV1SuRVvqlXsnbQxeHVVwXDwYw6P1R2V45EyccHyE=;
        b=cVrCwI/+SvGleC3xNtsUZ7e7D0/KSP+CxbVSL4+WluTTPaEMu9yEroFnZWvnCkWQx5
         4h8kAXA/i0O081ZjET1EAkLBJ+H9a6CJlQwOFYTe+B86Tl1DbyK74PCALwtMUmeI9/2C
         L8ha7NWldL9cA/IBKJi3Eh7Z7TSzJDhZ1pKviexYOhF2nnjqMN8hN0NbVmAFlLRliYzw
         iB//M4XcwOuuWPV+gnuzFvvErpXVhXU61OBJdXobSEkKi3VcPa+hw2lxdyoXf+Ac0JJl
         yY8SFxARhjzOHBMFQgoDvUDxlJMy+tTswzKDrX1FSigM0cuEg21YzR/YhiN2Rmo+f46h
         6oAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZLwP8HqwQcp3WjtGThmMBAZj6NoqXReDn2IAm2WPOAtQ75HrHdBAi4I2wFqkikbmTX7EMCaZXbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHSSm7YZHYHSBD6MYgH8WCJlLztnmyc/m65ryRfgaMniSfFUZ
	4JQQPCdqHQDWEovk9ikMzH4Peaom0sl2Dc3iWliCZ/PQ0ExSGI45uylKIx3ypga5JadnC4DQAiM
	+nE8YMQa489WFh8Vu2LI7HhIGqNhJtr1o4B08cxGDNDxGVkElj2DcPXuy0EwjXCGXizGDIw==
X-Gm-Gg: ASbGnctjUb/Kzm5AEg4RodfNUZGEzvz//tKxwzWuKxBIPlRCpSn0jHz4vgfdNn92ELU
	KzO64cqsONZj3Kud0yUviDzi/Ve46vd+nyZCZEoTnGSBOiK0QbdCZOloEGvpp47XbVYh8dXrVzr
	jkBNW8FLK3Do6gRJkxtJ1btuOAHmKVuzgUr+zcL1q9QpHIjuIe93rTHZ7FD7jLG3YLlbehVAF6U
	WhH4vcaJVIW9G3XFYOybNpfA0rRgcihGJyV3Gogv5NRoWH47krWydruqBLYiRNtdjP00nu/aXL8
	nIPIHkEX440O5AkC78bLkKRaJYZ27ypwb/6FM1wODLHGUR3gQIR24Anj92faN+2txCKJ9G6XwuB
	rGsLYrQde0DqV2tE0s/zkVpXeyqTUWHFN1XUd75dT7JdFQA==
X-Received: by 2002:a17:902:f78c:b0:295:9b73:b15c with SMTP id d9443c01a7336-29bab19b2b5mr243854475ad.42.1764526888749;
        Sun, 30 Nov 2025 10:21:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGOO/iNupMj4ruNssVjp9j5ubcrO5vr6gqW2CYN9gMam0A2nlOEi7/xLmTmoazNdiIG8hEWw==
X-Received: by 2002:a17:902:f78c:b0:295:9b73:b15c with SMTP id d9443c01a7336-29bab19b2b5mr243854255ad.42.1764526888266;
        Sun, 30 Nov 2025 10:21:28 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb27691sm100911385ad.64.2025.11.30.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:21:28 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: [PATCH v20 0/2] reboot-mode: Expose sysfs for registered reboot
 modes
Date: Sun, 30 Nov 2025 23:51:22 +0530
Message-Id: <20251130-next-15nov_expose_sysfs-v20-0-18c80f8248dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACKLLGkC/4XNQQ6CMBAF0KuYri1pCxXqynsYQwodpIm0yGADI
 dzdwsqF0c0k/yf/zUIQBgtIzoeFDBAsWu9iEOx4IHWr3R2oNbEgggnJOT9RB9NIuXQ+lDD1HqH
 EGRukNTNV3TAjldEkrvsBGjvt9PUWc2tx9MO8fwp8a/+bgVNG0yovCgayyhhcPGLyfOlH7bsui
 YdsdODqwxPih6cimJnUyLzQRsE3cF3XN4TBJYMXAQAA
X-Change-ID: 20251116-next-15nov_expose_sysfs-c0dbcf0d59da
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764526885; l=5452;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=4+sHuyVROK0XcOi41cRvBlL3Uge9KrVbF0txjUuCfnw=;
 b=KmiiYAOjDJy9ZGJgrs0NYJvrs+ZtkqkCnmpnVeeXEzPCDBf9Drk7HJFG9iJE3QdRXCn7hJpH8
 0U5jvR72gfaDmXCHUYyIR7McZf/Bp5FAUry7JD3z4pBasZKP5k+IJrQ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: iEycXaHsLU52t_qavzqNDciSP3HaKX7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTMwMDE1OCBTYWx0ZWRfX8tmpNiNS5yMW
 97+wn0aoYNvjXKZ3ef7x5tY9f7tQmBoGYDX8j7SGIpO/oY22xBw97YmuauPF23UPiKjEkQm70EP
 uF+SUYhcg1mJRZ9OlY0XtRY20ESKrvn8DSU2y3rBoirKtTkRpfm+GJkOmf3hFfzXlWZyT4lkp07
 qnA25LJ5k2KWcadDnenY2EsXipUf4ViB6G7mcDA42JrSbFZwLAjE4CDsUkhAPHizToamdsJ+7OE
 Ys/vaCLc6MZ3kFJLiYIg7WSKNOLYC6SRy0kCTPY1+LsHtlQ5xhIgX+P5pjWwHiXczmPvZVbf5jO
 MsQ4mTnKgKYTihjgpIdkvenWLVe6otTdh4UEeKSDf0t6G8DtVkm3hBiyYBTqRdFtAlDIVr7v+BS
 qI8oiwCqvmgYf9mE9bjW/XeSZ6V62Q==
X-Proofpoint-GUID: iEycXaHsLU52t_qavzqNDciSP3HaKX7V
X-Authority-Analysis: v=2.4 cv=EqXfbCcA c=1 sm=1 tr=0 ts=692c8b29 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5gLYR6zKSy0TCjlXUDQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511300158

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

Changes in v20:
By Bart
 - Use device_is_registered() instead of maintaining an explicit variable
   for status of device_register.
 - class_unregister already maintains an internal check; remove explicit
   check on status of class_register.
 - Protect the reboot_mode_list with mutex lock in reboot_modes_show.
 - Remove explicit "#ifdef MODULE"; subsys_initcall is just fine.

For Alignment
 - Move reboot_mode_register_device after the reboot_mode list additions
   are completed in reboot_mode_register. This also avoids explicit
   device_unregister in error paths and need for a lock in addition.
 - reboot-mode list protected in reboot_mode_unregister against a lock
   in reboot_modes_show.
 - Unregister reboot_mode_device before deleting the list in
   reboot_mode_unregister.
 - Although, we want to continue irrespective of the status of reboot_mode
   device_register, add a check and pr_debug to avoid compiler warning. 
- Link to v19: https://lore.kernel.org/r/20251122-next-15nov_expose_sysfs-v19-0-4d3d578ad9ee@oss.qualcomm.com

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
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Shivendra Pratap (2):
      Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
      power: reset: reboot-mode: Expose sysfs for registered reboot_modes

 .../testing/sysfs-class-reboot-mode-reboot_modes   | 36 ++++++++++
 drivers/power/reset/reboot-mode.c                  | 76 +++++++++++++++++++++-
 include/linux/reboot-mode.h                        |  6 ++
 3 files changed, 116 insertions(+), 2 deletions(-)
---
base-commit: 7d31f578f3230f3b7b33b0930b08f9afd8429817
change-id: 20251116-next-15nov_expose_sysfs-c0dbcf0d59da

Best regards,
-- 
Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>


