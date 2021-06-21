Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5AC3AF1E9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFUR2a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 13:28:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59582 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFUR23 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 13:28:29 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id aad6e4917f8b4308; Mon, 21 Jun 2021 19:26:13 +0200
Received: from kreacher.localnet (89-64-82-37.dynamic.chello.pl [89.64.82.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3B1C0669A35;
        Mon, 21 Jun 2021 19:26:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: Make cpufreq_online() call driver->offline() on errors
Date:   Mon, 21 Jun 2021 19:26:12 +0200
Message-ID: <11788436.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.37
X-CLIENT-HOSTNAME: 89-64-82-37.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfeefledguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppeekledrieegrdekvddrfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedvrdefjedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the CPU removal path the ->offline() callback provided by the
driver is always invoked before ->exit(), but in the cpufreq_online()
error path it is not, so ->exit() is somehow expected to know the
context in which it has been called and act accordingly.

That is less than straightforward, so make cpufreq_online() invoke
the driver's ->offline() callback before ->exit() too.

This only potentially affects intel_pstate at this point.

Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of CPUs")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1516,6 +1516,9 @@ out_destroy_policy:
 	up_write(&policy->rwsem);
 
 out_exit_policy:
+	if (cpufreq_driver->offline)
+		cpufreq_driver->offline(policy);
+
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 



