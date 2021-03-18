Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA80340CAD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhCRSQN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 14:16:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55420 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhCRSPp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 14:15:45 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 1e0020f270e78a72; Thu, 18 Mar 2021 19:15:44 +0100
Received: from kreacher.localnet (89-64-80-250.dynamic.chello.pl [89.64.80.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7DEAF668FA9;
        Thu, 18 Mar 2021 19:15:43 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/2] Revert "PM: runtime: Update device status before letting suppliers suspend"
Date:   Thu, 18 Mar 2021 19:09:06 +0100
Message-ID: <4304785.LvFx2qVVIh@kreacher>
In-Reply-To: <5448054.DvuYhMxLoT@kreacher>
References: <5448054.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefiedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffeuvddutdelgfdvtefgiefftddvfffgjeelvdethfehgfekfeeluedvueevvedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeelrdeigedrkedtrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrddvhedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhrghnghhqihhnghesrhhotghkqdgthhhiphhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit 44cc89f76464 ("PM: runtime: Update device status
before letting suppliers suspend") that introduced a race condition
into __rpm_callback() which allowed a concurrent rpm_resume() to
run and resume the device prematurely after its status had been
changed to RPM_SUSPENDED by __rpm_callback().

Fixes: 44cc89f76464 ("PM: runtime: Update device status before letting suppliers suspend")
Link: https://lore.kernel.org/linux-pm/24dfb6fc-5d54-6ee2-9195-26428b7ecf8a@intel.com/
Reported by: Adrian Hunter <adrian.hunter@intel.com>
Cc: 4.10+ <stable@vger.kernel.org> # 4.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c | 62 +++++++++++++++---------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 18b82427d0cb..a46a7e30881b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -325,22 +325,22 @@ static void rpm_put_suppliers(struct device *dev)
 static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	bool use_links = dev->power.links_count > 0;
-	bool get = false;
 	int retval, idx;
-	bool put;
+	bool use_links = dev->power.links_count > 0;
 
 	if (dev->power.irq_safe) {
 		spin_unlock(&dev->power.lock);
-	} else if (!use_links) {
-		spin_unlock_irq(&dev->power.lock);
 	} else {
-		get = dev->power.runtime_status == RPM_RESUMING;
-
 		spin_unlock_irq(&dev->power.lock);
 
-		/* Resume suppliers if necessary. */
-		if (get) {
+		/*
+		 * Resume suppliers if necessary.
+		 *
+		 * The device's runtime PM status cannot change until this
+		 * routine returns, so it is safe to read the status outside of
+		 * the lock.
+		 */
+		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
 			idx = device_links_read_lock();
 
 			retval = rpm_get_suppliers(dev);
@@ -355,36 +355,24 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 
 	if (dev->power.irq_safe) {
 		spin_lock(&dev->power.lock);
-		return retval;
-	}
-
-	spin_lock_irq(&dev->power.lock);
-
-	if (!use_links)
-		return retval;
-
-	/*
-	 * If the device is suspending and the callback has returned success,
-	 * drop the usage counters of the suppliers that have been reference
-	 * counted on its resume.
-	 *
-	 * Do that if the resume fails too.
-	 */
-	put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
-	if (put)
-		__update_runtime_status(dev, RPM_SUSPENDED);
-	else
-		put = get && retval;
-
-	if (put) {
-		spin_unlock_irq(&dev->power.lock);
-
-		idx = device_links_read_lock();
+	} else {
+		/*
+		 * If the device is suspending and the callback has returned
+		 * success, drop the usage counters of the suppliers that have
+		 * been reference counted on its resume.
+		 *
+		 * Do that if resume fails too.
+		 */
+		if (use_links
+		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
+		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
+			idx = device_links_read_lock();
 
-fail:
-		rpm_put_suppliers(dev);
+ fail:
+			rpm_put_suppliers(dev);
 
-		device_links_read_unlock(idx);
+			device_links_read_unlock(idx);
+		}
 
 		spin_lock_irq(&dev->power.lock);
 	}
-- 
2.26.2




