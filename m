Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2791165D5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 05:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLIEeY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 23:34:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLIEeY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 23:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z5wCHvvj5BNKu+yVA6hp40fY47Gzb5cUvJVOrEDs5h4=; b=h+gg/oFPuDo4nLPNHlEfYqskL
        xlVlEghkQJ8iyy0nIRrQTRdb+IOl1s8uALy6r4Hk2x54F2b2T6y8ZU4K8ZDgcD8bGSZY+9xaZJ/WR
        V4svJppP5kx/5uhXORWh0lJZh2Gt71zBpea2qO4Brb9pqp/HTpjXgUxhIp01ucfGKznKmx/ZKhCqE
        h+mx10xbBJ99ZWOhxuolD8+RYzFXIRLjil9Y2+ZkGD72LFhY4yX0G/2y5JPjgMDDfcEzo3Dxe8OPg
        xCwTiKZUo93Cw8wZkBo/lST+OKnqGHHn1hRUT9Z88g12E4XkgsJaNhZrnMOqukmVJgoYnIJOcEOJF
        t1AU374aw==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieAkZ-0002WU-NC; Mon, 09 Dec 2019 04:34:23 +0000
To:     Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] devfreq: fix multiple kernel-doc warnings
Message-ID: <50975461-6dab-8f89-e802-b34ca06008f5@infradead.org>
Date:   Sun, 8 Dec 2019 20:34:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in devfreq files.
Also fix a typo.

../include/linux/devfreq.h:181: warning: Function parameter or member 'last_status' not described in 'devfreq'

../drivers/devfreq/devfreq.c:1687: warning: bad line:         - Resource-managed devfreq_register_notifier()
../drivers/devfreq/devfreq.c:1723: warning: bad line:         - Resource-managed devfreq_unregister_notifier()
../drivers/devfreq/devfreq-event.c:355: warning: Function parameter or member 'edev' not described in 'devfreq_event_remove_edev'
../drivers/devfreq/devfreq-event.c:355: warning: Excess function parameter 'dev' description in 'devfreq_event_remove_edev'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/devfreq/devfreq-event.c |    4 ++--
 drivers/devfreq/devfreq.c       |    4 ++--
 include/linux/devfreq.h         |    3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

--- linux-next-20191209.orig/drivers/devfreq/devfreq.c
+++ linux-next-20191209/drivers/devfreq/devfreq.c
@@ -1733,7 +1733,7 @@ static void devm_devfreq_notifier_releas
 
 /**
  * devm_devfreq_register_notifier()
-	- Resource-managed devfreq_register_notifier()
+ *	- Resource-managed devfreq_register_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
@@ -1769,7 +1769,7 @@ EXPORT_SYMBOL(devm_devfreq_register_noti
 
 /**
  * devm_devfreq_unregister_notifier()
-	- Resource-managed devfreq_unregister_notifier()
+ *	- Resource-managed devfreq_unregister_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
--- linux-next-20191209.orig/drivers/devfreq/devfreq-event.c
+++ linux-next-20191209/drivers/devfreq/devfreq-event.c
@@ -346,9 +346,9 @@ EXPORT_SYMBOL_GPL(devfreq_event_add_edev
 
 /**
  * devfreq_event_remove_edev() - Remove the devfreq-event device registered.
- * @dev		: the devfreq-event device
+ * @edev	: the devfreq-event device
  *
- * Note that this function remove the registered devfreq-event device.
+ * Note that this function removes the registered devfreq-event device.
  */
 int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
 {
--- linux-next-20191209.orig/include/linux/devfreq.h
+++ linux-next-20191209/include/linux/devfreq.h
@@ -135,6 +135,7 @@ struct devfreq_stats {
  *		devfreq.nb to the corresponding register notifier call chain.
  * @work:	delayed work for load monitoring.
  * @previous_freq:	previously configured frequency value.
+ * @last_status:	devfreq user device info, performance statistics
  * @data:	Private data of the governor. The devfreq framework does not
  *		touch this.
  * @min_freq:	Limit minimum frequency requested by user (0: none)
@@ -148,7 +149,7 @@ struct devfreq_stats {
  * @stats:	Statistics of devfreq device behavior
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
  *
- * This structure stores the devfreq information for a give device.
+ * This structure stores the devfreq information for a given device.
  *
  * Note that when a governor accesses entries in struct devfreq in its
  * functions except for the context of callbacks defined in struct

