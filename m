Return-Path: <linux-pm+bounces-21823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F8A30BF4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E31163A94
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6F213E61;
	Tue, 11 Feb 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZhJUw8/A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CB204859;
	Tue, 11 Feb 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277908; cv=none; b=n9Twn3EDvfCuQUTOhbUujFJY0m4GXn1sngiGP1VkVp8J5+EhcoAq+Xbaa2qRh0n7MDnvMErsQw2suqv2D1ABnjIwjr3xtMUAbJv68gzZgz0+CMqzTFW6HPFwFyWUkUrsnr7xylFiEfQqqdaMwlT8HN1h/uOsTZF3Sj8VN7AIzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277908; c=relaxed/simple;
	bh=V9k10qmJrqoARBr2IWZK7XdaH8IuPpMg51At5ra5rDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQK3favxk6yBLrSROR9nQbIhCO8AeT7SZ/N1c0kAG/1UYt2Fi6i91RVhx1O+GRHilyJu2tZ50YZ1kslD9pCNcDHSL15ce0BCCJSm2U343iVupJ4vAv4O+zYrnj/N4YB3fTTa3rHZT1jrSyzdj3+UDsieptAXSkoaYhIyJ1GQvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZhJUw8/A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BCRSEX030318;
	Tue, 11 Feb 2025 12:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=yXCCH/PU40ZjxFTTlFdpHNTE8a98ecuNdKQIWGUHmH0=; b=Zh
	JUw8/ATmAGY4Fk1MEEJNJbkUGt0MluOf6ox0zxJXSjzVG/SoKWOrKKSl2tYGo9kS
	6dyJl+x+M8OlWDwqABRomwdx4KWNfAF8fka/j2uBk7CV8346JJxUVkkRcxYmSh4f
	mFtu1xa0S4E37cDX69PHX/SWFHR7TQknocDomPPhC1PeYhCl9H5ir5DtiyhCj9R7
	a28N7LqWG8kuaf0xRAFsw7MH0VaCQFq4TDXatp3inJ62wj9WPYNTdU1gHle8lN7w
	Z5LsYvlGmsNX73SSOxG0CBEDjd8BaHfkzXwGRtqEY8+s9nRmfYHVpvgIPRSjhr4F
	DwHbLTzWqb8xG4yO5BRA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxg9hett-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 12:44:57 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51BCiuJH030672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 12:44:56 GMT
Received: from codeaurora.org (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Feb
 2025 04:44:53 -0800
From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf
 Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH] thermal: core: Fix race between zone registration and userspace sysfs access
Date: Tue, 11 Feb 2025 18:14:21 +0530
Message-ID: <20250211124421.27169-1-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xWoqyAvGEUuoP-kEgL07Eft6Do_HqTKD
X-Proofpoint-GUID: xWoqyAvGEUuoP-kEgL07Eft6Do_HqTKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110081

Currently, the thermal zone sysfs is created before setting the
governor for that thermal zone during registration. If a thermal
zone is being registered while a userspace module tries to access
the same thermal zone policy sysfs node, it can lead to a potential
NULL pointer dereference issue in the policy sysfs path.

To avoid this race condition, set the thermal zone governor first
before enabling the thermal zone sysfs during registration.
This change fixes below issue,

[ 20.964589]   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[ 21.049645]   pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[ 21.049647]   pc : policy_show+0x1c/0x3c
[ 21.049652]   lr : dev_attr_show+0x38/0x7c
[ 21.049655]   sp : ffffffc09a98bbf0
[ 21.049657]   x29: ffffffc09a98bbf0 x28: ffffff885b940000 x27: 0000000000000000
[ 21.049660]   x26: 0000000000000000 x25: 000000007ffff001 x24: 0000000000000001
[ 21.049664]   x23: ffffffdca6334c78 x22: ffffff88a2b2fe00 x21: ffffff881cee8000
[ 21.049667]   x20: ffffff8868318018 x19: ffffffdca7640d78 x18: ffffffdca74d94c0
[ 21.049670]   x17: 00000000ae84bcd4 x16: 00000000ae84bcd4 x15: 000000002df29963
[ 21.049673]   x14: 00000000cbef29c7 x13: 000000004e61db0a x12: ffffff885b940be0
[ 21.049677]   x11: ffffff881cee8000 x10: 0000000000000000 x9 : ffffffdca59f00b8
[ 21.049680]   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
[ 21.049683]   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
[ 21.049686]   x2 : ffffff881cee8000 x1 : ffffffdca66e5bfb x0 : ffffff881cee8000
[ 21.049689]   Call trace:
[ 21.049690]    policy_show+0x1c/0x3c
[ 21.049692]    dev_attr_show+0x38/0x7c
[ 21.049695]    sysfs_kf_seq_show+0xd8/0x160
[ 21.049699]    kernfs_seq_show+0x44/0x54
[ 21.049701]    seq_read_iter+0x16c/0x4ec
[ 21.049705]    kernfs_fop_read_iter+0x64/0x1d8
[ 21.049709]    vfs_read+0x2d8/0x33c
[ 21.049711]    ksys_read+0x78/0xe8
[ 21.049714]    __arm64_sys_read+0x1c/0x2c
[ 21.049716]    invoke_syscall+0x58/0x10c
[ 21.049719]    el0_svc_common+0xa8/0xdc
[ 21.049722]    do_el0_svc+0x1c/0x28
[ 21.049724]    el0_svc+0x40/0x90
[ 21.049726]    el0t_64_sync_handler+0x70/0xbc
[ 21.049728]    el0t_64_sync+0x1a8/0x1ac
[ 21.049731]   Code: f9435008 aa0203e0 d00054e1 912fec21 (f9400108)

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/thermal/thermal_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2328ac0d8561..c6e6b229cc6e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1589,6 +1589,11 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	tz->state = TZ_STATE_FLAG_INIT;
 
+	thermal_zone_device_init(tz);
+	result = thermal_zone_init_governor(tz);
+	if (result)
+		goto unregister;
+
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
@@ -1600,19 +1605,14 @@ thermal_zone_device_register_with_trips(const char *type,
 		thermal_zone_destroy_device_groups(tz);
 		goto remove_id;
 	}
-	thermal_zone_device_init(tz);
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
 
-	result = thermal_zone_init_governor(tz);
-	if (result)
-		goto unregister;
-
 	if (!tz->tzp || !tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
 		if (result)
-			goto unregister;
+			goto release_device;
 	}
 
 	result = thermal_thresholds_init(tz);
@@ -1629,12 +1629,12 @@ thermal_zone_device_register_with_trips(const char *type,
 
 remove_hwmon:
 	thermal_remove_hwmon_sysfs(tz);
-unregister:
-	device_del(&tz->device);
 release_device:
 	put_device(&tz->device);
 remove_id:
 	ida_free(&thermal_tz_ida, id);
+unregister:
+	device_del(&tz->device);
 free_tzp:
 	kfree(tz->tzp);
 free_tz:
-- 


