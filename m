Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF2345600
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 04:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCWDNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 23:13:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55216 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhCWDNF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 23:13:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C9A95200D74;
        Tue, 23 Mar 2021 04:13:01 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 18973200D76;
        Tue, 23 Mar 2021 04:12:57 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B56DD402B0;
        Tue, 23 Mar 2021 04:12:50 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 1/6] PM / devfreq: fix build error when DEVFREQ_GOV_PASSIVE enabled
Date:   Tue, 23 Mar 2021 10:59:14 +0800
Message-Id: <1616468359-14513-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
References: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/devfreq/devfreq.c: In function ‘devfreq_transitions_show’:
drivers/devfreq/devfreq.c:2188:25: error: ‘struct devfreq’ has no member named ‘governor_name’; did you mean ‘governor’?
 2188 |   if (!strncmp(devfreq->governor_name,
      |                         ^~~~~~~~~~~~~
      |                         governor

Fixes: 5cc75e9252e9 ("PM / devfreq: Add devfreq_transitions debugfs file")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index d625b268adf2..107badfc6b2b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -2185,7 +2185,7 @@ static int devfreq_transitions_show(struct seq_file *s, void *data)
 			continue;
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
-		if (!strncmp(devfreq->governor_name,
+		if (!strncmp(devfreq->governor->name,
 				DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {
 			struct devfreq_passive_data *data = devfreq->data;
 
-- 
2.25.1

