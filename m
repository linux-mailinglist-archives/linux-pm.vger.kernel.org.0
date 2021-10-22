Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263C9437A60
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJVP4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 11:56:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47726 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhJVP4E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 11:56:04 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id a55714590f225a46; Fri, 22 Oct 2021 17:53:45 +0200
Received: from kreacher.localnet (unknown [213.134.175.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5FB0166A9BA;
        Fri, 22 Oct 2021 17:53:44 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: suspend: Use valid_state() consistently
Date:   Fri, 22 Oct 2021 17:53:43 +0200
Message-ID: <2617889.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.233
X-CLIENT-HOSTNAME: 213.134.175.233
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddujeehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvdeffedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make valid_state() check if the ->enter callback is present in
suspend_ops (only PM_SUSPEND_TO_IDLE can be valid otherwise) and
make sleep_state_supported() call valid_state() consistently to
validate the states other than PM_SUSPEND_TO_IDLE.

While at it, clean up the comment in valid_state().

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -160,11 +160,13 @@ EXPORT_SYMBOL_GPL(s2idle_wake);
 static bool valid_state(suspend_state_t state)
 {
 	/*
-	 * PM_SUSPEND_STANDBY and PM_SUSPEND_MEM states need low level
-	 * support and need to be valid to the low level
-	 * implementation, no valid callback implies that none are valid.
+	 * The PM_SUSPEND_STANDBY and PM_SUSPEND_MEM states require low-level
+	 * support and need to be valid to the low-level implementation.
+	 *
+	 * No ->valid() or ->enter() callback implies that none are valid.
 	 */
-	return suspend_ops && suspend_ops->valid && suspend_ops->valid(state);
+	return suspend_ops && suspend_ops->valid && suspend_ops->valid(state) &&
+		suspend_ops->enter;
 }
 
 void __init pm_states_init(void)
@@ -236,7 +238,7 @@ EXPORT_SYMBOL_GPL(suspend_valid_only_mem
 
 static bool sleep_state_supported(suspend_state_t state)
 {
-	return state == PM_SUSPEND_TO_IDLE || (suspend_ops && suspend_ops->enter);
+	return state == PM_SUSPEND_TO_IDLE || valid_state(state);
 }
 
 static int platform_suspend_prepare(suspend_state_t state)



