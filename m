Return-Path: <linux-pm+bounces-23521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25465A50D22
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 22:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC1171362
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36A2561BD;
	Wed,  5 Mar 2025 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HSgkQzca"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E55255E54;
	Wed,  5 Mar 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209214; cv=none; b=rWW9FdlhdK9Se+/uHpZ7+Ta0O65iIMu34ihf9VPxwIW0wcUnHw+FZvIY5ILB9ZqMX8gSd2WD9f3yNLookjgANnZIImnE0sTjIwCV2mOosSaclBu/yotoEiwyZMTeY0nHTuZld0x/J5QUV6Ka7VkzZD6A1Lxxh970s7BsnzdZGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209214; c=relaxed/simple;
	bh=1c6XvbGlS8BdeYJs6LLfIZpq1VqwxiM1qpO+fuE1FNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIzy6ZWf3BDZAtA57yq8Yf0U7DF8MAmwNDDzKHkxxMwok9Gg9AF6S4u9tHYkHUvn59A6gxyhLsaScADzIQ1uqkc7pHU9DQP02Y3+8BfWbA7hVINDEt+S8XL/O/fzzqJcL7YnBq9PQSGdimO/IbHAAX3LpHBAiCCJiL+IF0LcXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HSgkQzca; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 9a260c3878b977cc; Wed, 5 Mar 2025 22:13:24 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0ED549A0CE1;
	Wed,  5 Mar 2025 22:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741209204;
	bh=1c6XvbGlS8BdeYJs6LLfIZpq1VqwxiM1qpO+fuE1FNg=;
	h=From:Subject:Date;
	b=HSgkQzcaVeqD+aLtcpC2Hd/7ZkxV7GGph3oHtbmgBBxN0XrYJWDcEmzJ1efZSEumw
	 t8cUhegRAUJG50sXhtU2GG51xTrX4gQ7tz+0wCIzTx0Ut0ROo6RoYtWZjsJjPh1Z7C
	 Vm7QmBxWKeCeCe7ULydL/7xQOWxeVg7OeDu1vp23k0GtWP9RKL/C0/gDvt/T76Ds5+
	 mVcpg04mMJcIsvV4qqwtvhRpd9gnCG88VMZp6o1RgVGEh9Zf2vSVGxrfPiKbionDHO
	 jQItUrJRwQo+uoVUrHF3KRUoig6coQMKKOngwDbUF/3wvWaZReJ4Jv0NyD7Xc1ePXm
	 Jl9afAxfC2pvQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v1 2/3] PM: EM: Make three functions static
Date: Wed, 05 Mar 2025 22:11:21 +0100
Message-ID: <1929404.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <5880743.DvuYhMxLoT@rjwysocki.net>
References: <5880743.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhmpdhrtghpthhtoheprhhitggrrhguohdrnhgvrhhiqdgtrghluggvrhhonheslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Three functions in the Energy Model code, em_dev_update_perf_domain(),
em_table_alloc() and em_table_free(), have no users outside that code and
so make them static, remove their headers from the Energy Model header
file and remove a piece of documentation associated with them.

This also helps to clean up RCU handling in the Energy Model code that
will be done subsequently.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This essentially follow the rules that all functions without users in the
files where they are defined should be static (with all due respect to any
out-of-the-tree users of them).

This change can be reversed when any new users of these functions appear,
but it will have to take changes made by the subsequent patch into account.

---
 Documentation/power/energy-model.rst |   39 +----------------------------------
 include/linux/energy_model.h         |   16 --------------
 kernel/power/energy_model.c          |    9 +++-----
 3 files changed, 6 insertions(+), 58 deletions(-)

--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -203,43 +203,8 @@
 or in Section 2.5
 
 
-2.4 Runtime modifications
-^^^^^^^^^^^^^^^^^^^^^^^^^
-
-Drivers willing to update the EM at runtime should use the following dedicated
-function to allocate a new instance of the modified EM. The API is listed
-below::
-
-  struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
-
-This allows to allocate a structure which contains the new EM table with
-also RCU and kref needed by the EM framework. The 'struct em_perf_table'
-contains array 'struct em_perf_state state[]' which is a list of performance
-states in ascending order. That list must be populated by the device driver
-which wants to update the EM. The list of frequencies can be taken from
-existing EM (created during boot). The content in the 'struct em_perf_state'
-must be populated by the driver as well.
-
-This is the API which does the EM update, using RCU pointers swap::
-
-  int em_dev_update_perf_domain(struct device *dev,
-			struct em_perf_table __rcu *new_table);
-
-Drivers must provide a pointer to the allocated and initialized new EM
-'struct em_perf_table'. That new EM will be safely used inside the EM framework
-and will be visible to other sub-systems in the kernel (thermal, powercap).
-The main design goal for this API is to be fast and avoid extra calculations
-or memory allocations at runtime. When pre-computed EMs are available in the
-device driver, than it should be possible to simply re-use them with low
-performance overhead.
-
-In order to free the EM, provided earlier by the driver (e.g. when the module
-is unloaded), there is a need to call the API::
-
-  void em_table_free(struct em_perf_table __rcu *table);
-
-It will allow the EM framework to safely remove the memory, when there is
-no other sub-system using it, e.g. EAS.
+2.4 Accessing power values and computing costs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 To use the power values in other sub-systems (like thermal, powercap) there is
 a need to call API which protects the reader and provide consistency of the EM
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -166,14 +166,10 @@
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
-int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				const struct em_data_callback *cb,
 				const cpumask_t *cpus, bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
-void em_table_free(struct em_perf_table __rcu *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
@@ -374,18 +370,6 @@
 	return 0;
 }
 static inline
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
-{
-	return NULL;
-}
-static inline void em_table_free(struct em_perf_table __rcu *table) {}
-static inline
-int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
-{
-	return -EINVAL;
-}
-static inline
 struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
 {
 	return NULL;
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -177,7 +177,7 @@
  *
  * No return values.
  */
-void em_table_free(struct em_perf_table __rcu *table)
+static void em_table_free(struct em_perf_table __rcu *table)
 {
 	kref_put(&table->kref, em_release_table_kref);
 }
@@ -190,7 +190,7 @@
  * has a user.
  * Returns allocated table or NULL.
  */
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+static struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *table;
 	int table_size;
@@ -299,8 +299,8 @@
  *
  * Return 0 on success or an error code on failure.
  */
-int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
+static int em_dev_update_perf_domain(struct device *dev,
+				     struct em_perf_table __rcu *new_table)
 {
 	struct em_perf_table __rcu *old_table;
 	struct em_perf_domain *pd;
@@ -329,7 +329,6 @@
 	mutex_unlock(&em_pd_mutex);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
 
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				struct em_perf_state *table,




