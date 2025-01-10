Return-Path: <linux-pm+bounces-20217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D342AA09112
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9C7A0609
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6520D515;
	Fri, 10 Jan 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HqZxb263"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879020DD45;
	Fri, 10 Jan 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513296; cv=none; b=u/TojVJ8ENX8hQJqX0rqWhaSfix3SxNAWMDPEcZXg3oUUEp2CcmHGudbQsSjEfNd0DVYb0hKayZ2Vxh0CIocUsgr9ZeOiAM532pPj7+NMAmZxsYmsT9uszGTCq4OY2dN6QvtMiTKuVuMQLydPa0a4IiCymvMjfwOmFHCyphRWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513296; c=relaxed/simple;
	bh=QqvoeEQrDdy3hKMAqNdGyffmJRmwHIWludXavlBPjM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AeqfwpiwJRz4DSL9Y5fxlv8QrNFhoxzBlXlZHHgnqmcHB2/WRYJAfSGzMPzjl46PVx4H85kmb490Xe7rlarjKwl8EzIJuNmBpHV17XyRckgEElgvOOihrp7wgwULpjVWqgLOlZDepqpElHgryExd5bHMSOm3Djn7+4otydS6qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HqZxb263; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id f9ae5bad2f9a3538; Fri, 10 Jan 2025 13:48:11 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B94A38E05BB;
	Fri, 10 Jan 2025 13:48:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736513291;
	bh=QqvoeEQrDdy3hKMAqNdGyffmJRmwHIWludXavlBPjM0=;
	h=From:Subject:Date;
	b=HqZxb263/bUGuFoBpEgh7RjDwUVlcNkLbu5ewqNDxmoMLHthCmqpXhy7WpptDPixP
	 WBtCUShLjU+XyNliD8B83G87rxRpFZl60rKrKRzGCtiimPScTsSgHWC8EybPKsqVcR
	 rQDF3EVmgoqmhKGaotkWZaTcSerLdSw20QynCtFfJdSwi4DSf38i0oFGjqMn9QOKtf
	 ARQkk4MuaW2n3nTsUHYVCjZhQjnzwtsraBsW2/6A32lBwZRUl7VRNDg4BLoZtc0mev
	 e0OP/NdFd7coCLs74IbO9C8fK39V05Egydf5rtHKkgsLCtWqwmuB/f+rasGQ0e+G2u
	 vnnk7R9nC1swQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1] cpuidle: teo: Update documentation after previous changes
Date: Fri, 10 Jan 2025 13:48:10 +0100
Message-ID: <6120335.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtoheprghrthgvmhdrsghithihuhhtshhkihihsehlihhnuhi
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After previous changes, the description of the teo governor in the
documentation comment does not match the code any more, so update it
as appropriate.

Fixes: 449914398083 ("cpuidle: teo: Remove recent intercepts metric")
Fixes: 2662342079f5 ("cpuidle: teo: Gather statistics regarding whether or not to stop the tick")
Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   99 +++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -10,25 +10,27 @@
  * DOC: teo-description
  *
  * The idea of this governor is based on the observation that on many systems
- * timer events are two or more orders of magnitude more frequent than any
- * other interrupts, so they are likely to be the most significant cause of CPU
- * wakeups from idle states.  Moreover, information about what happened in the
- * (relatively recent) past can be used to estimate whether or not the deepest
- * idle state with target residency within the (known) time till the closest
- * timer event, referred to as the sleep length, is likely to be suitable for
- * the upcoming CPU idle period and, if not, then which of the shallower idle
- * states to choose instead of it.
- *
- * Of course, non-timer wakeup sources are more important in some use cases
- * which can be covered by taking a few most recent idle time intervals of the
- * CPU into account.  However, even in that context it is not necessary to
- * consider idle duration values greater than the sleep length, because the
- * closest timer will ultimately wake up the CPU anyway unless it is woken up
- * earlier.
- *
- * Thus this governor estimates whether or not the prospective idle duration of
- * a CPU is likely to be significantly shorter than the sleep length and selects
- * an idle state for it accordingly.
+ * timer interrupts are two or more orders of magnitude more frequent than any
+ * other interrupt types, so they are likely to dominate CPU wakeup patterns.
+ * Moreover, in principle, the time when the next timer event is going to occur
+ * can be determined at the idle state selection time, although doing that may
+ * be costly, so it can be regarded as the most reliable source of information
+ * for idle state selection.
+ *
+ * Of course, non-timer wakeup sources are more important in some use cases,
+ * but even then it is generally unnecessary to consider idle duration values
+ * greater than the time time till the next timer event, referred as the sleep
+ * length in what follows, because the closest timer will ultimately wake up the
+ * CPU anyway unless it is woken up earlier.
+ *
+ * However, since obtaining the sleep length may be costly, the governor first
+ * checks if it can select a shallow idle state using wakeup pattern information
+ * from recent times, in which case it can do without knowing the sleep length
+ * at all.  For this purpose, it counts CPU wakeup events and looks for an idle
+ * state whose terget residency has not exceeded the idle duration (measured
+ * after wakeup) in the majority of relevant recent cases.  If the target
+ * residency of that state is small enough, it may be used right away and the
+ * sleep length need not be determined.
  *
  * The computations carried out by this governor are based on using bins whose
  * boundaries are aligned with the target residency parameter values of the CPU
@@ -39,7 +41,11 @@
  * idle state 2, the third bin spans from the target residency of idle state 2
  * up to, but not including, the target residency of idle state 3 and so on.
  * The last bin spans from the target residency of the deepest idle state
- * supplied by the driver to infinity.
+ * supplied by the driver to the scheduler tick period length or to infinity if
+ * the tick period length is less than the targer residency of that state.  In
+ * the latter case, the governor also counts events with the measured idle
+ * duration between the tick period length and the target residency of the
+ * deepest idle state.
  *
  * Two metrics called "hits" and "intercepts" are associated with each bin.
  * They are updated every time before selecting an idle state for the given CPU
@@ -49,47 +55,46 @@
  * sleep length and the idle duration measured after CPU wakeup fall into the
  * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
  * length).  In turn, the "intercepts" metric reflects the relative frequency of
- * situations in which the measured idle duration is so much shorter than the
- * sleep length that the bin it falls into corresponds to an idle state
- * shallower than the one whose bin is fallen into by the sleep length (these
- * situations are referred to as "intercepts" below).
+ * non-timer wakeup events for which the measured idle duration falls into a bin
+ * that corresponds to an idle state shallower than the one whose bin is fallen
+ * into by the sleep length (these events are also referred to as "intercepts"
+ * below).
  *
  * In order to select an idle state for a CPU, the governor takes the following
  * steps (modulo the possible latency constraint that must be taken into account
  * too):
  *
- * 1. Find the deepest CPU idle state whose target residency does not exceed
- *    the current sleep length (the candidate idle state) and compute 2 sums as
- *    follows:
- *
- *    - The sum of the "hits" and "intercepts" metrics for the candidate state
- *      and all of the deeper idle states (it represents the cases in which the
- *      CPU was idle long enough to avoid being intercepted if the sleep length
- *      had been equal to the current one).
- *
- *    - The sum of the "intercepts" metrics for all of the idle states shallower
- *      than the candidate one (it represents the cases in which the CPU was not
- *      idle long enough to avoid being intercepted if the sleep length had been
- *      equal to the current one).
+ * 1. Find the deepest enabled CPU idle state (the candidate idle state) and
+ *    compute 2 sums as follows:
  *
- * 2. If the second sum is greater than the first one the CPU is likely to wake
- *    up early, so look for an alternative idle state to select.
+ *    - The sum of the "hits" metric for all of the idle states shallower than
+ *      the candidate one (it represents the cases in which the CPU was likely
+ *      woken up by a timer).
+ *
+ *    - The sum of the "intercepts" metric for all of the idle states shallower
+ *      than the candidate one (it represents the cases in which the CPU was
+ *      likely woken up by a non-timer wakeup source).
+ *
+ * 2. If the second sum computed in step 1 is greater than a half of the sum of
+ *    both mertics for the candidate state bin and all subsequent bins(if any),
+ *    a shallower idle state is likely to be more suitable, so look for it.
  *
- *    - Traverse the idle states shallower than the candidate one in the
+ *    - Traverse the enabled idle states shallower than the candidate one in the
  *      descending order.
  *
  *    - For each of them compute the sum of the "intercepts" metrics over all
  *      of the idle states between it and the candidate one (including the
  *      former and excluding the latter).
  *
- *    - If each of these sums that needs to be taken into account (because the
- *      check related to it has indicated that the CPU is likely to wake up
- *      early) is greater than a half of the corresponding sum computed in step
- *      1 (which means that the target residency of the state in question had
- *      not exceeded the idle duration in over a half of the relevant cases),
- *      select the given idle state instead of the candidate one.
+ *    - If this sum is greater than a half of the second sum computed in step 1,
+ *      use the given idle state as the new candidate one.
  *
- * 3. By default, select the candidate state.
+ * 3. If the current candidate state is state 0 or its target residency is short
+ *    enough, return it and prevent the scheduler tick from being stopped.
+ *
+ * 4. Obtain the sleep length value and check if it is below the target
+ *    residency of the current candidate state, in which case a new shallower
+ *    candidate state needs to be found, so look for it.
  */
 
 #include <linux/cpuidle.h>




