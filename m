Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426DA11F2BB
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2019 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfLNQDN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Dec 2019 11:03:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfLNQDN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Dec 2019 11:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XBaM42oBNhOSXJ0EDeTAvIyXJwZ5pDoXlUcg9BjVjf4=; b=jDBRPuIDc8BvevpOBxnzvFVDN
        kqWQFf8kWtSZEY0dvIYfsmPdloFnbm8H8WV6Rx3rxIOaMVtzWititWXRwHKNZJcuAZAM1Q5mMC6dM
        JyxhVaKxpvUoHVO5rAlZ6xNutdlXAyIUIBSx5XAAcIWCbvFlCSUBiznE9NZCpVe50J+bfd0ygsCp1
        Igdv4rdAAocY+vS3kWrd5GyLQx44ZVYKnpPAJmWPhjP+5ZpXljO85eujDTBwyrM8WhmS3iF2JJ0kQ
        GhSixTjyaPer9emU5/TW0RnD79AybIg/hwXVDgamv+368rscWeMHYZLndesrXti6hZsWuOhNI48Gq
        PXx1xV0zA==;
Received: from [2601:1c0:6280:3f0::fee9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ig9su-0005KH-TW; Sat, 14 Dec 2019 16:03:12 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] devfreq: fix multiple kernel-doc warnings
Message-ID: <a6cbc380-0f88-1c97-83f2-c06f47eb18fa@infradead.org>
Date:   Sat, 14 Dec 2019 08:03:11 -0800
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
v2: update for latest devfreq tree

 drivers/devfreq/devfreq-event.c |    4 ++--
 drivers/devfreq/devfreq.c       |    4 ++--
 include/linux/devfreq.h         |    3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

--- linux-next-20191213.orig/drivers/devfreq/devfreq.c
+++ linux-next-20191213/drivers/devfreq/devfreq.c
@@ -1852,7 +1852,7 @@ static void devm_devfreq_notifier_releas
 
 /**
  * devm_devfreq_register_notifier()
-	- Resource-managed devfreq_register_notifier()
+ *	- Resource-managed devfreq_register_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
@@ -1888,7 +1888,7 @@ EXPORT_SYMBOL(devm_devfreq_register_noti
 
 /**
  * devm_devfreq_unregister_notifier()
-	- Resource-managed devfreq_unregister_notifier()
+ *	- Resource-managed devfreq_unregister_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
--- linux-next-20191213.orig/drivers/devfreq/devfreq-event.c
+++ linux-next-20191213/drivers/devfreq/devfreq-event.c
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
--- linux-next-20191213.orig/include/linux/devfreq.h
+++ linux-next-20191213/include/linux/devfreq.h
@@ -136,6 +136,7 @@ struct devfreq_stats {
  *		devfreq.nb to the corresponding register notifier call chain.
  * @work:	delayed work for load monitoring.
  * @previous_freq:	previously configured frequency value.
+ * @last_status:	devfreq user device info, performance statistics
  * @data:	Private data of the governor. The devfreq framework does not
  *		touch this.
  * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
@@ -151,7 +152,7 @@ struct devfreq_stats {
  * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
  * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
  *
- * This structure stores the devfreq information for a give device.
+ * This structure stores the devfreq information for a given device.
  *
  * Note that when a governor accesses entries in struct devfreq in its
  * functions except for the context of callbacks defined in struct

