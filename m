Return-Path: <linux-pm+bounces-17754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C109D26DB
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 14:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF37B27E0A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5AD1CC8BD;
	Tue, 19 Nov 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="r30K5B7Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173E1514FB;
	Tue, 19 Nov 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022477; cv=none; b=qALgWK9F9EEKoWQoVtms4ODuzge+BA/LGPOSylqljEjLYi6Jv/Dd+J8h02hq8RtRmbF5jMOY4WjKQjq5GE3Kr5IS2DH5VmdMv/31Umzx7TVA7OS/R49GcwJew8oQK2cK1DcaRVvmpl3JIsBQwxEGX1XDYpEge7iHJofU8oXIpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022477; c=relaxed/simple;
	bh=DWLhylf76f1GXIwwv4PC0rHW85ZamEL2nO9LSc8rYmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVnWqMWb9MFNabayAjmpqOte7E1a72KI7+Vn+eCfFMlpVQEXBWokuTt9XUstjEfuRupPxBKef58j+txXcWhPB93GYX31O/SnhB83dhRBoTuu5fnlfoez5d//gFn+Ptiaw4UxLxrpdli7l61Xfq41zxAXyx/jm2icobLk6Ixw6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=r30K5B7Q; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJD45DY028148;
	Tue, 19 Nov 2024 14:21:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=hIUID8xieOV5SK3rECKHKQ
	CWffQtbOG8ZqTfYVraUjY=; b=r30K5B7QBbqWKOJ75bQublHGRF6DvENG6pUKWT
	y7tP8+/s4f4Tl6a060p3Yw5tUQ6feEY7peIk5fGiTU43u0e6p35cH362MAUwTeSX
	nUdxmu0B6ys+zt//xq1XokqgU+MS604NZx7ZUWk7nVnvHNXzovAdmmvGU9iSgYEo
	CUlKPLWhEiVJn2ylEZ/Mg3vu98kxqvTdMGhfhB5l6ajaw24oLlJpzxbGxSLcjGCQ
	+GGlJ2SVt9MHMnqWcdWSVrL+lF/WmLEbQ5Lt/EEn9UXQUdr0p+gALDOGF3cRpzeY
	3kFrBBw4Cu99jAa9FD/lffQSVe4QHBwJaF4a4JyKGt/BnTVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42y77n9x7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 14:21:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D7E8C40047;
	Tue, 19 Nov 2024 14:20:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3E873270D6C;
	Tue, 19 Nov 2024 14:19:43 +0100 (CET)
Received: from localhost (10.48.86.243) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 19 Nov
 2024 14:19:42 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel
 Lezcano <daniel.lezcano@linaro.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] cpuidle: psci: Activate GENPD_FLAG_ACTIVE_WAKEUP with OSI
Date: Tue, 19 Nov 2024 14:18:34 +0100
Message-ID: <20241119141827.1.I6129b16ec6b558efc1707861db87e55bf7022f62@changeid>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Set GENPD_FLAG_ACTIVE_WAKEUP flag for domain psci cpuidle when OSI
is activated, then when a device is set as the wake-up source using
device_set_wakeup_path, the PSCI power domain could be retained to allow
so that the associated device can wake up the system.

With this flag, for S2IDLE system-wide suspend, the wake-up path is
managed in each device driver and is tested in the power framework:
a PSCI domain is only turned off when GENPD_FLAG_ACTIVE_WAKEUP is enabled
and the associated device is not in the wake-up path, so PSCI CPUIdle
selects the lowest level in the PSCI topology according to the wake-up
path.

This patch is a preliminary step to support PSCI OSI on the STM32MP25
platform with the D1 domain (power-domain-cluster) for the A35 cortex
cluster and for the associated peripherals including EXTI1 which manages
the wake-up interrupts for domain D1.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 drivers/cpuidle/cpuidle-psci-domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 146f97068022..5fb5228f6bf1 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -72,6 +72,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	 */
 	if (use_osi) {
 		pd->power_off = psci_pd_power_off;
+		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
 	} else {
-- 
2.25.1


