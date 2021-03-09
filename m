Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3DD332649
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCINM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:12:58 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47152 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhCINMl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:41 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B7A71A100C;
        Tue,  9 Mar 2021 14:12:40 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 470F11A1009;
        Tue,  9 Mar 2021 14:12:34 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4CA5440314;
        Tue,  9 Mar 2021 14:12:26 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 02/11] PM / devfreq: remove the invalid description for get_target_freq
Date:   Tue,  9 Mar 2021 20:58:44 +0800
Message-Id: <1615294733-22761-15-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

First of all, no_central_polling was removed since
commit 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices
which can idle")
Secondly, get_target_freq() is not only called only with update_devfreq()
notified by OPP now, but also min/max freq qos notifier.

So remove this invalid description now to avoid confusing.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/governor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 70f44b3ca42e..5cee3f64fe2b 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -57,8 +57,6 @@
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
  *			status of the device (load = busy_time / total_time).
- *			If no_central_polling is set, this callback is called
- *			only with update_devfreq() notified by OPP.
  * @event_handler:      Callback for devfreq core framework to notify events
  *                      to governors. Events include per device governor
  *                      init and exit, opp changes out of devfreq, suspend
-- 
2.25.1

