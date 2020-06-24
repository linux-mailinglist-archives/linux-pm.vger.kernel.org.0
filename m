Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC98207452
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbgFXNTl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 09:19:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389445AbgFXNTk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 09:19:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05ODIWE1064154;
        Wed, 24 Jun 2020 13:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=/CHyyqyPX91FA7D+EZofQoOQ+oKgF27GewZ7ADCObvI=;
 b=RIPooS+K44BtWf7/FbFv5ISdxykDc2HG28LCHlWqNMntLN2gMNY0ybH8crRudp+YhHj4
 oIo7KmD1Q+j8rW5N8n4y9Y4GIwO3qqyeNu+ZmwMdGesQ22eCKcUyvwkzkCsz3XeuIk8y
 91rZTre8GL1oVeUaHqtR6/GSIgdCqCspXizzOtY6PGZqvlDtlH/NnjIw1+ap4Z3uQA4m
 dqdFDFT+ntFgGqiP15JcmOg/BRez0ZlwNz9o2ns65cpzIQZWG149Ys2YWR0G82js3t8r
 CRXgbc5ALccH99P2yHaAAQ7Tzw3K2L8wK7DrDagJtxsHFw5e7Qn0YH1MI1BPan3XDXEO AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31uustjtd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 13:19:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05ODJJd5160990;
        Wed, 24 Jun 2020 13:19:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31uurqtbcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 13:19:34 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05ODJW7t005612;
        Wed, 24 Jun 2020 13:19:32 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 13:19:28 +0000
Date:   Wed, 24 Jun 2020 16:19:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] intel_idle: Fix uninitialized variable bug
Message-ID: <20200624131921.GB9972@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240096
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "tick" variable isn't initialized if "lapic_timer_always_reliable"
is true.

Fixes: 40ab82e08d78 ("intel_idle: Simplify LAPIC timer reliability checks")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index aae53e650638..6c9152f303a6 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -132,7 +132,7 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
-	bool tick;
+	bool tick = false;
 	int cpu = smp_processor_id();
 
 	/*
-- 
2.27.0

