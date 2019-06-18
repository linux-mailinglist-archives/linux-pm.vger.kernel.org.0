Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F194AE16
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfFRWsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 18:48:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45698 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbfFRWsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 18:48:17 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id ff427a1802679567; Wed, 19 Jun 2019 00:48:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] PM: sleep: Update struct wakeup_source documentation
Date:   Wed, 19 Jun 2019 00:48:15 +0200
Message-ID: <9413171.SRfamDnp5r@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The kerneldoc comment for struct wakeup_source has become outdated,
so fix that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_wakeup.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/include/linux/pm_wakeup.h
===================================================================
--- linux-pm.orig/include/linux/pm_wakeup.h
+++ linux-pm/include/linux/pm_wakeup.h
@@ -36,7 +36,7 @@ struct wake_irq;
  * @expire_count: Number of times the wakeup source's timeout has expired.
  * @wakeup_count: Number of times the wakeup source might abort suspend.
  * @active: Status of the wakeup source.
- * @has_timeout: The wakeup source has been activated with a timeout.
+ * @autosleep_enabled: Autosleep is active, so update @prevent_sleep_time.
  */
 struct wakeup_source {
 	const char 		*name;



