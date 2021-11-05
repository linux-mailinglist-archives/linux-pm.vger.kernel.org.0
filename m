Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A26446707
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhKEQej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 12:34:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50326 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhKEQei (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 12:34:38 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id c24e8bb4fbc41704; Fri, 5 Nov 2021 17:31:56 +0100
Received: from kreacher.localnet (unknown [213.134.175.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 97E4F66542E;
        Fri,  5 Nov 2021 17:31:55 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [PATCH] thermal: Replace pr_warn() with pr_warn_once() in user_space_bind()
Date:   Fri, 05 Nov 2021 17:31:54 +0100
Message-ID: <2607026.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.123
X-CLIENT-HOSTNAME: 213.134.175.123
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeigdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhppfgvthifohhrkhculddvhedtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudejhedruddvfeenucfuphgrmhfkphfpvghtfihorhhkpedvudefrddufeegrddujeehrdduvdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedruddvfedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordho
 rhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use pr_warn_once() instead of pr_warn() to print the user space
governor deprecation message in user_space_bind() to reduce the
kernel log noise.

Fixes: 0275c9fb0eff ("thermal/core: Make the userspace governor deprecated")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_user_space.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/gov_user_space.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_user_space.c
+++ linux-pm/drivers/thermal/gov_user_space.c
@@ -17,8 +17,8 @@
 
 static int user_space_bind(struct thermal_zone_device *tz)
 {
-	pr_warn("Userspace governor deprecated: use thermal netlink "	\
-		"notification instead\n");
+	pr_warn_once("Userspace governor deprecated: use thermal netlink " \
+		     "notification instead\n");
 
 	return 0;
 }



