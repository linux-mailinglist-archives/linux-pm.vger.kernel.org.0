Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64473B0D7D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhFVTOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 15:14:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43504 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhFVTOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 15:14:09 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 0fae083bb3ac6f6e; Tue, 22 Jun 2021 21:11:41 +0200
Received: from kreacher.localnet (89-64-82-70.dynamic.chello.pl [89.64.82.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A28C56645FF;
        Tue, 22 Jun 2021 21:11:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cpufreq: Make cpufreq_online() call driver->offline() on errors
Date:   Tue, 22 Jun 2021 21:11:39 +0200
Message-ID: <5490292.DvuYhMxLoT@kreacher>
In-Reply-To: <11788436.O9o76ZdvQC@kreacher>
References: <11788436.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.70
X-CLIENT-HOSTNAME: 89-64-82-70.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfeeguddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdekvddrjedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedvrdejtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Make cpufreq_online() call driver->offline() on errors

In the CPU removal path the ->offline() callback provided by the
driver is always invoked before ->exit(), but in the cpufreq_online()
error path it is not, so ->exit() is expected to somehow know the
context in which it has been called and act accordingly.

That is less than straightforward, so make cpufreq_online() invoke
the driver's ->offline() callback, if present, on errors before
->exit() too.

This only potentially affects intel_pstate.

Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of CPUs")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
   * Avoid calling ->offline() after a failing ->online().
   * Add a comment regarding the expected state after calling ->init().
   * Edit the changelog a bit.

---
 drivers/cpufreq/cpufreq.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1367,9 +1367,14 @@ static int cpufreq_online(unsigned int c
 			goto out_free_policy;
 		}
 
+		/*
+		 * The initialization has succeeded and the policy is online.
+		 * If there is a problem with its frequency table, take it
+		 * offline and drop it.
+		 */
 		ret = cpufreq_table_validate_and_sort(policy);
 		if (ret)
-			goto out_exit_policy;
+			goto out_offline_policy;
 
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
@@ -1515,6 +1520,10 @@ out_destroy_policy:
 
 	up_write(&policy->rwsem);
 
+out_offline_policy:
+	if (cpufreq_driver->offline)
+		cpufreq_driver->offline(policy);
+
 out_exit_policy:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);



