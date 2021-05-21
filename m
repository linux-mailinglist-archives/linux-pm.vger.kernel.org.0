Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00838D14A
	for <lists+linux-pm@lfdr.de>; Sat, 22 May 2021 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhEUWVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 18:21:02 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:48596 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhEUWVC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 18:21:02 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LMI6cH025938;
        Fri, 21 May 2021 22:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=q8QhXGTfWElVKM98+dODFF6vgoKg7xIj/f6m9TTGGAg=;
 b=ANsYwupGaCf7fHujCp8EiOmIj4kzAj5+U7KtflGUtmgADLVbgsU1lqzV2gyHVeFf6y4X
 Tg32G6k7CNmxJprVfEtdGXDmkQSyhppPpUgx9xdhHwsTo5xmVRBleDrW/LNyeHbD+sYw
 7llU5sslCj3QhVtQgHMASJ72fKUR7ZMceGd+MeTUAqC7VsEOgPFdDgINHrB29B0e1HFE
 JX0at13GkTdkmKPVWWWtyQkAGaoFouW9NsIfj7vd8hs7i/9FJHwDNobuNAga8zQLoHDg
 tyKd56f0sJ8grsc/9JGTdNQDBwmOxXJk34hlf/MeATbv7EkIP+0ud591wcGuLlCI84ua yQ== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 38p0dcsw44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 22:19:35 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 9BC316F;
        Fri, 21 May 2021 22:19:34 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 6B9894A;
        Fri, 21 May 2021 22:19:34 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 17E9E302F481D; Fri, 21 May 2021 17:19:34 -0500 (CDT)
From:   Kyle Meyer <kyle.meyer@hpe.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-acpi@vegr.kernel.org,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver exists
Date:   Fri, 21 May 2021 17:19:06 -0500
Message-Id: <20210521221906.199436-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f3wzvZwN-ZLyGF8xOXh0LB-SAt38UjiY
X-Proofpoint-ORIG-GUID: f3wzvZwN-ZLyGF8xOXh0LB-SAt38UjiY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_11:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210122
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Revert part of commit 75c0758137c7a
("acpi-cpufreq: Fail initialization if driver cannot be registered").

acpi-cpufreq is mutually exclusive with intel_pstate, however,
acpi-cpufreq is loaded multiple times during startup while intel_pstate is
enabled. On systems using systemd the kernel triggers one uevent for each
device as a result of systemd-udev-trigger.service. The service exists to
retrigger all devices as uevents sent by the kernel before systemd-udevd
is running are missed. The delay caused by systemd-udevd repeatedly loading
the driver, getting a fail return, and unloading the driver twice per
logical CPU has a significant impact on the startup time, and can cause
some devices to be unavailable after reaching the root login prompt.

Load the driver once but skip initialization if a cpufreq driver exists by
changing the return value of cpufreq_get_current_driver() from -EEXIST to
0.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7e7450453714..e79a945369d1 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1003,7 +1003,7 @@ static int __init acpi_cpufreq_init(void)
 
 	/* don't keep reloading if cpufreq_driver exists */
 	if (cpufreq_get_current_driver())
-		return -EEXIST;
+		return 0;
 
 	pr_debug("%s\n", __func__);
 
-- 
2.26.2

