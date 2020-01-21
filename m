Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D61143832
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgAUI2O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 03:28:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgAUI2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 03:28:14 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L8O5bt022760;
        Tue, 21 Jan 2020 09:28:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=hlw2ikkuyZngGM22RNb9i/rqeJqWLztM+xKpl8dXoAo=;
 b=tN+OBEmiXXzs5ftLMUHfODZ9QPzZGcj1pc2rj7wHJKzSbymEdijRN8SD/EYJnfDQFisR
 dVPXhgAp80XDN5Osqe4on+hAY5rFgKd9VHv8VcNBg/uodXNJ7zltRMQtuV/cBG90Y053
 F3QSHFwJqHn0QiQ7YpQ22YW1praNmX1saZA/rogBj/n4fIwgk6XdPSFZqCBNznc1UR+x
 l7YPRtuqv3wEJD2rJ7W6xstumyp935N1gcTSd7gWlUDH2IJqL4Djyfcy/7D+BFAdHXkb
 4Qu9bH4RXfxzufIR3poGgfFEvBetTHQ0Tn1z64sfiXuiJ8uBqWx6YWwpB3ym+KUk10FR Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrc4wh71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 09:28:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C12BA100038;
        Tue, 21 Jan 2020 09:28:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4F792A4D81;
        Tue, 21 Jan 2020 09:28:03 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 Jan 2020 09:28:03
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rjw@rjwysocki.net>, <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        <rdunlap@infradead.org>
Subject: [PATCH v2] cpuidle: fix kernel doc warnings
Date:   Tue, 21 Jan 2020 09:27:58 +0100
Message-ID: <20200121082758.8808-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-20,2020-01-21 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix cpuidle_find_deepest_state() kernel documentation to avoid warnings when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
CC: rdunlap@infradead.org
version 2:
- fix the comment done by Randy
 drivers/cpuidle/cpuidle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 33d19c8eb027..19c6dee88921 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -121,6 +121,9 @@ void cpuidle_use_deepest_state(u64 latency_limit_ns)
  * cpuidle_find_deepest_state - Find the deepest available idle state.
  * @drv: cpuidle driver for the given CPU.
  * @dev: cpuidle device for the given CPU.
+ * @latency_limit_ns: Idle state exit latency limit
+ *
+ * Return: the index of the deepest available idle state.
  */
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev,
-- 
2.15.0

