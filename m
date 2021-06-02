Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0539925C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 20:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhFBSUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 14:20:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53266 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSUe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 14:20:34 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id a230bfc6cfa75d23; Wed, 2 Jun 2021 20:18:49 +0200
Received: from kreacher.localnet (89-64-80-45.dynamic.chello.pl [89.64.80.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D03CD6697FA;
        Wed,  2 Jun 2021 20:18:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 5/5] cpuidle: teo: Use kerneldoc documentation in admin-guide
Date:   Wed, 02 Jun 2021 20:18:02 +0200
Message-ID: <1886763.usQuhbGJ8B@kreacher>
In-Reply-To: <1867445.PYKUYFuaPT@kreacher>
References: <1867445.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.45
X-CLIENT-HOSTNAME: 89-64-80-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdektddrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There are two descriptions of the TEO (Timer Events Oriented) cpuidle
governor in the kernel source tree, one in the C file containing its
code and one in cpuidle.rst which is part of admin-guide.

Instead of trying to keep them both in sync and in order to reduce
text duplication, include the governor description from the C file
directly into cpuidle.rst.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst |   77 -------------------------------
 drivers/cpuidle/governors/teo.c          |   12 +++-
 2 files changed, 10 insertions(+), 79 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -347,81 +347,8 @@ for tickless systems.  It follows the sa
 <menu-gov_>`_: it always tries to find the deepest idle state suitable for the
 given conditions.  However, it applies a different approach to that problem.
 
-First, it does not use sleep length correction factors, but instead it attempts
-to correlate the observed idle duration values with the available idle states
-and use that information to pick up the idle state that is most likely to
-"match" the upcoming CPU idle interval.   Second, it does not take the tasks
-that were running on the given CPU in the past and are waiting on some I/O
-operations to complete now at all (there is no guarantee that they will run on
-the same CPU when they become runnable again) and the pattern detection code in
-it avoids taking timer wakeups into account.  It also only uses idle duration
-values less than the current time till the closest timer (with the scheduler
-tick excluded) for that purpose.
-
-Like in the ``menu`` governor `case <menu-gov_>`_, the first step is to obtain
-the *sleep length*, which is the time until the closest timer event with the
-assumption that the scheduler tick will be stopped (that also is the upper bound
-on the time until the next CPU wakeup).  That value is then used to preselect an
-idle state on the basis of three metrics maintained for each idle state provided
-by the ``CPUIdle`` driver: ``hits``, ``misses`` and ``early_hits``.
-
-The ``hits`` and ``misses`` metrics measure the likelihood that a given idle
-state will "match" the observed (post-wakeup) idle duration if it "matches" the
-sleep length.  They both are subject to decay (after a CPU wakeup) every time
-the target residency of the idle state corresponding to them is less than or
-equal to the sleep length and the target residency of the next idle state is
-greater than the sleep length (that is, when the idle state corresponding to
-them "matches" the sleep length).  The ``hits`` metric is increased if the
-former condition is satisfied and the target residency of the given idle state
-is less than or equal to the observed idle duration and the target residency of
-the next idle state is greater than the observed idle duration at the same time
-(that is, it is increased when the given idle state "matches" both the sleep
-length and the observed idle duration).  In turn, the ``misses`` metric is
-increased when the given idle state "matches" the sleep length only and the
-observed idle duration is too short for its target residency.
-
-The ``early_hits`` metric measures the likelihood that a given idle state will
-"match" the observed (post-wakeup) idle duration if it does not "match" the
-sleep length.  It is subject to decay on every CPU wakeup and it is increased
-when the idle state corresponding to it "matches" the observed (post-wakeup)
-idle duration and the target residency of the next idle state is less than or
-equal to the sleep length (i.e. the idle state "matching" the sleep length is
-deeper than the given one).
-
-The governor walks the list of idle states provided by the ``CPUIdle`` driver
-and finds the last (deepest) one with the target residency less than or equal
-to the sleep length.  Then, the ``hits`` and ``misses`` metrics of that idle
-state are compared with each other and it is preselected if the ``hits`` one is
-greater (which means that that idle state is likely to "match" the observed idle
-duration after CPU wakeup).  If the ``misses`` one is greater, the governor
-preselects the shallower idle state with the maximum ``early_hits`` metric
-(or if there are multiple shallower idle states with equal ``early_hits``
-metric which also is the maximum, the shallowest of them will be preselected).
-[If there is a wakeup latency constraint coming from the `PM QoS framework
-<cpu-pm-qos_>`_ which is hit before reaching the deepest idle state with the
-target residency within the sleep length, the deepest idle state with the exit
-latency within the constraint is preselected without consulting the ``hits``,
-``misses`` and ``early_hits`` metrics.]
-
-Next, the governor takes several idle duration values observed most recently
-into consideration and if at least a half of them are greater than or equal to
-the target residency of the preselected idle state, that idle state becomes the
-final candidate to ask for.  Otherwise, the average of the most recent idle
-duration values below the target residency of the preselected idle state is
-computed and the governor walks the idle states shallower than the preselected
-one and finds the deepest of them with the target residency within that average.
-That idle state is then taken as the final candidate to ask for.
-
-Still, at this point the governor may need to refine the idle state selection if
-it has not decided to `stop the scheduler tick <idle-cpus-and-tick_>`_.  That
-generally happens if the target residency of the idle state selected so far is
-less than the tick period and the tick has not been stopped already (in a
-previous iteration of the idle loop).  Then, like in the ``menu`` governor
-`case <menu-gov_>`_, the sleep length used in the previous computations may not
-reflect the real time until the closest timer event and if it really is greater
-than that time, a shallower state with a suitable target residency may need to
-be selected.
-
+.. kernel-doc:: drivers/cpuidle/governors/teo.c
+   :doc: teo-description
 
 .. _idle-states-representation:
 
Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -4,6 +4,10 @@
  *
  * Copyright (C) 2018 - 2021 Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ */
+
+/**
+ * DOC: teo-description
  *
  * The idea of this governor is based on the observation that on many systems
  * timer events are two or more orders of magnitude more frequent than any
@@ -28,7 +32,7 @@
  *
  * The computations carried out by this governor are based on using bins whose
  * boundaries are aligned with the target residency parameter values of the CPU
- * idle states provided by the cpuidle driver in the ascending order.  That is,
+ * idle states provided by the %CPUIdle driver in the ascending order.  That is,
  * the first bin spans from 0 up to, but not including, the target residency of
  * the second idle state (idle state 1), the second bin spans from the target
  * residency of idle state 1 up to, but not including, the target residency of
@@ -51,8 +55,8 @@
  * situations are referred to as "intercepts" below).
  *
  * In addition to the metrics described above, the governor counts recent
- * intercepts (that is, intercepts that have occurred during the last NR_RECENT
- * invocations of it for the given CPU) for each bin.
+ * intercepts (that is, intercepts that have occurred during the last
+ * %NR_RECENT invocations of it for the given CPU) for each bin.
  *
  * In order to select an idle state for a CPU, the governor takes the following
  * steps (modulo the possible latency constraint that must be taken into account
@@ -76,7 +80,7 @@
  *      shallower than the candidate one.
  *
  * 2. If the second sum is greater than the first one or the third sum is
- *    greater than NR_RECENT / 2, the CPU is likely to wake up early, so look
+ *    greater than %NR_RECENT / 2, the CPU is likely to wake up early, so look
  *    for an alternative idle state to select.
  *
  *    - Traverse the idle states shallower than the candidate one in the



