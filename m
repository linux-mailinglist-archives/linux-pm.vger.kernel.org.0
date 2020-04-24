Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C81B7354
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDXLlW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 07:41:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14870 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXLlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 07:41:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OBWRX1023149;
        Fri, 24 Apr 2020 13:41:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=5Rg4znNj42bzqjnolZJ9lV8rYKa4nFxeh6irBMvctcs=;
 b=Cz/dBvho/0XMcgtyhgX+W9Q4pEgmNqeGCaUPo1EHOg6bNV9ptL7BHw1WnEvIE6Lf9XEP
 +ALfbyWp8T0ILDB6RGdtVPIjLIEK3w8TCsKtyLyA2iVk1qAxD1T/kabR55faLv1Wwb7+
 b2Y1rmm1MSweMa/CYsHoPvyACRCoeGlAgtjCYAjzvkrDKkJ2XCWvVUTr9FODH3X8fFX9
 bcEK5ybbmsAC2pQgNrf6tb57RTceHw8hcSFwsAbaGqHAd42x99+QIHiWgf8JcDD428zM
 q3n/3Jb9Dxtfof3ZxFRrNOBOR1P7ZHflgA5+pyj99aRNe85rQNv9yXzp6dZVJO9QhWSw RA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fpp9bch9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 13:41:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A0DE100038;
        Fri, 24 Apr 2020 13:41:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 576082B3DA2;
        Fri, 24 Apr 2020 13:41:04 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Apr 2020 13:41:03
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <hugues.fruchet@st.com>, <mchehab@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 2/3] cpufreq: governor: Use minimum load QoS
Date:   Fri, 24 Apr 2020 13:40:57 +0200
Message-ID: <20200424114058.21199-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200424114058.21199-1-benjamin.gaignard@st.com>
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make sure that the returned load is above the system-wide minimum
load QoS.
Devices could set this specific QoS to inform governors about their
need in terms of CPU load when computing it from idle time isn't accurate.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/cpufreq/cpufreq_governor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f99ae45efaea..1494e5e4c788 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -118,6 +118,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
 	unsigned int max_load = 0, idle_periods = UINT_MAX;
 	unsigned int sampling_rate, io_busy, j;
+	unsigned int qos_min_load;
 
 	/*
 	 * Sometimes governors may use an additional multiplier to increase
@@ -225,6 +226,10 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 
 	policy_dbs->idle_periods = idle_periods;
 
+	qos_min_load = cpufreq_minload_qos_limit();
+	if (qos_min_load > max_load)
+		max_load = qos_min_load;
+
 	return max_load;
 }
 EXPORT_SYMBOL_GPL(dbs_update);
-- 
2.15.0

