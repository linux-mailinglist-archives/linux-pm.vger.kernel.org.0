Return-Path: <linux-pm+bounces-23522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD044A50D24
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 22:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D776E170F3E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 21:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036D256C74;
	Wed,  5 Mar 2025 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Gm8uOoFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93671A5BB2;
	Wed,  5 Mar 2025 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209215; cv=none; b=rvAqSAOT6HRrUGhpayo1un5RqW/7VnyjK2zrhriAehHki3WMzLgmeqVtgniFWX21zcZmegwmXGBWYWtmYY2bdU4ukiihesPZfcbBBHhBZ2/6JgGNZObHJkw/I6/Q17tDonnaTlALwYGRr/9Fuyspn8D1z5iZLzP1mk1rnbruzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209215; c=relaxed/simple;
	bh=eg0I+HPmiByMWiURzGmkCm0WBgFPkqqmyeqmjGy6I3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVVvoPICjr3z0YdwyjlPVIg2JCNOsoZru6H/eGz+cQevoUJonN0mq1Lc3k74Rdj4q3s2xBMfGhvFGgJaEO3dibO6prpgc1FllOlKiPJRUKE09tJ+P2Y6P1XyHGWunV+dP3eVfeVi5vka+mmJrLv5tuGe7KV5Rv0IJWMOV2dOJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Gm8uOoFC; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 32f0a54b242422b2; Wed, 5 Mar 2025 22:13:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DDCAF9A0CE1;
	Wed,  5 Mar 2025 22:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741209205;
	bh=eg0I+HPmiByMWiURzGmkCm0WBgFPkqqmyeqmjGy6I3A=;
	h=From:Subject:Date;
	b=Gm8uOoFCWZQuCUFASetp5DEnw97KJYk6P6xlVtH5pn+9ZO9iJxQxfxj8YXoswwUy/
	 Ml8OBrPJcoIFNnjNXlsaEMpXd2Gq3YEqo8QvFulPKqxAO3ZqP0YtQmh7lETD+k36L2
	 SiHVSvCis0LQ6Wk3qhgi9JG66HM3ub4RmKrJ1kry2LB3LBdn9Ei7Q6qdGVaCmLJDGY
	 ft+hHycL3d3NVO4JrublGvmy7Zj64fxAYtaiOLo4ofB9tHtfWSgVbQl/54wvtJeiop
	 V50JPPzzxW94Sct3E+BhLJl1oinUD+3yNsk7f6wCX7Ir0op55k4frCz6Rofj64GbZo
	 wQKJsP2HaWgGQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 1/3] PM: EM: Consify two parameters of
 em_dev_register_perf_domain()
Date: Wed, 05 Mar 2025 22:08:21 +0100
Message-ID: <4648962.LvFx2qVVIh@rjwysocki.net>
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

Notice that em_dev_register_perf_domain() and the functions called by it
do not update objects pointed to by its cb and cpus parameters, so the
const modifier can be added to them.

This allows the return value of cpumask_of() or a pointer to a
struct em_data_callback declared as const to be passed to
em_dev_register_perf_domain() directly without explicit type
casting which is rather handy.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/energy_model.h |    8 ++++----
 kernel/power/energy_model.c  |   11 ++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -169,8 +169,8 @@
 int em_dev_update_perf_domain(struct device *dev,
 			      struct em_perf_table __rcu *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-				struct em_data_callback *cb, cpumask_t *span,
-				bool microwatts);
+				const struct em_data_callback *cb,
+				const cpumask_t *cpus, bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
 struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
 void em_table_free(struct em_perf_table __rcu *table);
@@ -346,8 +346,8 @@
 
 static inline
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-				struct em_data_callback *cb, cpumask_t *span,
-				bool microwatts)
+				const struct em_data_callback *cb,
+				const cpumask_t *cpus, bool microwatts)
 {
 	return -EINVAL;
 }
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -231,7 +231,7 @@
 }
 
 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
-			    struct em_data_callback *cb, int nr_states,
+			    const struct em_data_callback *cb, int nr_states,
 			    unsigned long flags)
 {
 	unsigned long prev_cost = ULONG_MAX;
@@ -333,7 +333,7 @@
 
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				struct em_perf_state *table,
-				struct em_data_callback *cb,
+				const struct em_data_callback *cb,
 				unsigned long flags)
 {
 	unsigned long power, freq, prev_freq = 0;
@@ -388,7 +388,8 @@
 }
 
 static int em_create_pd(struct device *dev, int nr_states,
-			struct em_data_callback *cb, cpumask_t *cpus,
+			const struct em_data_callback *cb,
+			const cpumask_t *cpus,
 			unsigned long flags)
 {
 	struct em_perf_table __rcu *em_table;
@@ -548,8 +549,8 @@
  * Return 0 on success
  */
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-				struct em_data_callback *cb, cpumask_t *cpus,
-				bool microwatts)
+				const struct em_data_callback *cb,
+				const cpumask_t *cpus, bool microwatts)
 {
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;




