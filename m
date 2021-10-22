Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72A043779F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhJVNAo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 09:00:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41596 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhJVNAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 09:00:43 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 0a6d88729bbdbd76; Fri, 22 Oct 2021 14:58:25 +0200
Received: from kreacher.localnet (unknown [213.134.175.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8D19966A92E;
        Fri, 22 Oct 2021 14:58:24 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH] PM: sleep: Do not let "syscore" devices runtime-suspend during system transitions
Date:   Fri, 22 Oct 2021 14:58:23 +0200
Message-ID: <5773062.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.233
X-CLIENT-HOSTNAME: 213.134.175.233
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvkedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudejhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvfeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehmkhhshhgrhhestghouggv
 rghurhhorhgrrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is no reason to allow "syscore" devices to runtime-suspend
during system-wide PM transitions, because they are subject to the
same possible failure modes as any other devices in that respect.

Accordingly, change device_prepare() and device_complete() to call
pm_runtime_get_noresume() and pm_runtime_put(), respectively, for
"syscore" devices too.

Fixes: 057d51a1268f ("Merge branch 'pm-sleep'")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
---
 drivers/base/power/main.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1048,7 +1048,7 @@ static void device_complete(struct devic
 	const char *info = NULL;
 
 	if (dev->power.syscore)
-		return;
+		goto out;
 
 	device_lock(dev);
 
@@ -1078,6 +1078,7 @@ static void device_complete(struct devic
 
 	device_unlock(dev);
 
+out:
 	pm_runtime_put(dev);
 }
 
@@ -1789,9 +1790,6 @@ static int device_prepare(struct device
 	int (*callback)(struct device *) = NULL;
 	int ret = 0;
 
-	if (dev->power.syscore)
-		return 0;
-
 	/*
 	 * If a device's parent goes into runtime suspend at the wrong time,
 	 * it won't be possible to resume the device.  To prevent this we
@@ -1800,6 +1798,9 @@ static int device_prepare(struct device
 	 */
 	pm_runtime_get_noresume(dev);
 
+	if (dev->power.syscore)
+		return 0;
+
 	device_lock(dev);
 
 	dev->power.wakeup_path = false;



