Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0864915D1DB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 07:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgBNGFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 01:05:19 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:22202 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgBNGFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 01:05:18 -0500
Received: from localhost.localdomain ([93.22.37.15])
        by mwinf5d17 with ME
        id 2W5E220080KcLDH03W5ETK; Fri, 14 Feb 2020 07:05:15 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 14 Feb 2020 07:05:15 +0100
X-ME-IP: 93.22.37.15
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PM / devfreq: Fix a typo in a comment
Date:   Fri, 14 Feb 2020 07:05:06 +0100
Message-Id: <20200214060506.29500-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'govenror' was used in place of 'governor'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/devfreq/governor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index c07ce77c253d..ae4d0cc18359 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -30,7 +30,7 @@
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
  * @immutable:		Immutable flag for governor. If the value is 1,
- *			this govenror is never changeable to other governor.
+ *			this governor is never changeable to other governor.
  * @interrupt_driven:	Devfreq core won't schedule polling work for this
  *			governor if value is set to 1.
  * @get_target_freq:	Returns desired operating frequency for the device.
-- 
2.20.1

