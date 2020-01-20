Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59B142B9A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 14:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgATNHI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 08:07:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29302 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729022AbgATNHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 08:07:07 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KCvscY025411;
        Mon, 20 Jan 2020 14:07:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=6ywHm9tIKJeNeNj6aCygOOca018jp2viwOFpjy5/kL8=;
 b=hBH+wvSXj3rSNp+0OG31DL249bW1EMjuu731SfnvEiKq+nwppvuOtSq2gIsiDU3SBciX
 FLY3pHJLQfF8nuuKGBrZmvjVqK2ViFi4K5v8HQB0lsFbDdrm1t3yFJp4nj6LvoDYLixT
 YbOmfqbsNgVh+IUan1AobaFBQek5zwXly8GQUUX+iLiVKViu6t12xpdAZAmCZsBGx0n6
 irKBKfn02sv7xF9SCRzH5xISOHuB6hRsbP+82/3o2jWKQHB16s9RsZJ60dsDeQH1lu/X
 Kw5jWjK1UFthwHvAcNXAQ4kGi4Bh3tSO6a45g03GmEzchNaz/5N9cb/KJDRm5ZGIP3Dw JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrp21k33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 14:07:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85DEC10002A;
        Mon, 20 Jan 2020 14:07:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C04D2BD419;
        Mon, 20 Jan 2020 14:07:03 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 14:07:02
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rjw@rjwysocki.net>, <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] cpuidle: fix kernel doc warnings
Date:   Mon, 20 Jan 2020 14:07:01 +0100
Message-ID: <20200120130701.29948-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix cpuidle_find_deepest_state() kernel documentation to avoid warnings when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
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
+ * Returns the index of the deepest available idle state.
  */
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev,
-- 
2.15.0

