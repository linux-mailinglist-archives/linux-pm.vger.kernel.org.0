Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFC145B38
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 18:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVR5S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 12:57:18 -0500
Received: from ms.lwn.net ([45.79.88.28]:52394 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVR5S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 12:57:18 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 627F02BA;
        Wed, 22 Jan 2020 17:57:17 +0000 (UTC)
Date:   Wed, 22 Jan 2020 10:57:16 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Fix two malformed kerneldoc comments
Message-ID: <20200122105716.2868f272@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Two kerneldoc comments in devfreq.c fail to adhere to the required format,
resulting in these doc-build warnings:

  ./drivers/devfreq/devfreq.c:1818: warning: bad line:
  	- Resource-managed devfreq_register_notifier()
  ./drivers/devfreq/devfreq.c:1854: warning: bad line:
	- Resource-managed devfreq_unregister_notifier()

Add a couple of missing asterisks and make kerneldoc a little happier.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 57f6944d65a6..00c9b80b3d33 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1814,7 +1814,7 @@ static void devm_devfreq_notifier_release(struct device *dev, void *res)
 
 /**
  * devm_devfreq_register_notifier()
-	- Resource-managed devfreq_register_notifier()
+ *	- Resource-managed devfreq_register_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
@@ -1850,7 +1850,7 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
 
 /**
  * devm_devfreq_unregister_notifier()
-	- Resource-managed devfreq_unregister_notifier()
+ *	- Resource-managed devfreq_unregister_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
-- 
2.24.1

