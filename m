Return-Path: <linux-pm+bounces-26748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B3AACEEC
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CC34C8294
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5966155326;
	Tue,  6 May 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gRreBNt2"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616804B1E7A;
	Tue,  6 May 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564582; cv=none; b=RU185R/UlZsb8rXYD35L9xw8VoVPHpl7Ymus0NAXUK5KYx5kA08u1UHjBE/AE727FF1xwvqPOK3m2UPAVUc+dEJ3XdEvY8kFuHYQ4V2YercOWiI2+ykferK7wB7tOSo+nZxBKJizYxLPsKS7NoxWCthF5m4eKsbLF0RNA5eW+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564582; c=relaxed/simple;
	bh=PdZcjOBD23bUj9NIeziRNNEtKC82H4xQxBa9zf1yc08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIcEEtz+B9jDOR5C+N7K00ca2bsYJhPgchzEBtrB4O59BemT0X8VqcAQaEoFdezddl+nnNGn/NAAIp6gqdm78WUXjubgMs/EJ6W2FE3bagM4LKwMVejtekwAEOqObQAN5MwQnbrIhL6SBFQrQAUBSj0mkygyCJBTy4KiCv7TDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gRreBNt2; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B0DB16669EB;
	Tue,  6 May 2025 22:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564572;
	bh=PdZcjOBD23bUj9NIeziRNNEtKC82H4xQxBa9zf1yc08=;
	h=From:Subject:Date;
	b=gRreBNt2yVC04X9i1VTmsCGOQ5Ng9jnf3zEgiDUriUpsaCn036zaWJuBs11GK8/9R
	 nuyaN5N3y43EqJ3ESNrt8O/3Lst6RGwlrcf31hb4KVR0rsbP0v8SbEArOoI0uxrnsJ
	 GHcjtdevFO5qBqch72+BmtLzie4b/p6eKXNU5lhYVfrM44dmGhPKYap7If4woX+cXY
	 bphq9iaLzFavx+E2OrieOpuv8o6Xfo/JjRp/V+rrF3vF8XLQoM/sV3P+Wtq9I4zbGz
	 eQ/acJYxIxo2NXq2FQQ5AtXCwTUWn1ugL8jD+EfyM0ReQoK8/mo4fPGSNsVvOmLN+I
	 WOi3/kFwXjKAQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v2 7/7] cpufreq: intel_pstate: Document hybrid processor support
Date: Tue, 06 May 2025 22:48:59 +0200
Message-ID: <1935040.CQOukoFCf9@rjwysocki.net>
In-Reply-To: <2999205.e9J7NaK4W3@rjwysocki.net>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Describe the support for hybrid processors in intel_pstate, including
the CAS and EAS support, in the admin-guide documentation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

---
 Documentation/admin-guide/pm/intel_pstate.rst |  104 +++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -329,6 +329,106 @@
 HWP feature, which is why ``intel_pstate`` works with all of them.]
 
 
+Support for Hybrid Processors
+=============================
+
+Some processors supported by ``intel_pstate`` contain two or more types of CPU
+cores differing by the maximum turbo P-state, performance vs power characteristics,
+cache sizes, and possibly other properties.  They are commonly referred to as
+hybrid processors.  To support them, ``intel_pstate`` requires HWP to be enabled
+and it assumes the HWP performance units to be the same for all CPUs in the
+system, so a given HWP performance level always represents approximately the
+same physical performance regardless of the core (CPU) type.
+
+Hybrid Processors with SMT
+--------------------------
+
+On systems where SMT (Simultaneous Multithreading), also referred to as
+HyperThreading (HT) in the context of Intel processors, is enabled on at least
+one core, ``intel_pstate`` assigns performance-based priorities to CPUs.  Namely,
+the priority of a given CPU reflects its highest HWP performance level which
+causes the CPU scheduler to generally prefer more performant CPUs, so the less
+performant CPUs are used when the other ones are fully loaded.  However, SMT
+siblings (that is, logical CPUs sharing one physical core) are treated in a
+special way such that if one of them is in use, the effective priority of the
+other ones is lowered below the priorities of the CPUs located in the other
+physical cores.
+
+This approach maximizes performance in the majority of cases, but unfortunately
+it also leads to excessive energy usage in some important scenarios, like video
+playback, which is not generally desirable.  While there is no other viable
+choice with SMT enabled because the effective capacity and utilization of SMT
+siblings are hard to determine, hybrid processors without SMT can be handled in
+more energy-efficient ways.
+
+.. _CAS:
+
+Capacity-Aware Scheduling Support
+---------------------------------
+
+The capacity-aware scheduling (CAS) support in the CPU scheduler is enabled by
+``intel_pstate`` by default on hybrid processors without SMT.  CAS generally
+causes the scheduler to put tasks on a CPU so long as there is a sufficient
+amount of spare capacity on it, and if the utilization of a given task is too
+high for it, the task will need to go somewhere else.
+
+Since CAS takes CPU capacities into account, it does not require CPU
+prioritization and it allows tasks to be distributed more symmetrically among
+the more performant and less performant CPUs.  Once placed on a CPU with enough
+capacity to accommodate it, a task may just continue to run there regardless of
+whether or not the other CPUs are fully loaded, so on average CAS reduces the
+utilization of the more performant CPUs which causes the energy usage to be more
+balanced because the more performant CPUs are generally less energy-efficient
+than the less performant ones.
+
+In order to use CAS, the scheduler needs to know the capacity of each CPU in
+the system and it needs to be able to compute scale-invariant utilization of
+CPUs, so ``intel_pstate`` provides it with the requisite information.
+
+First of all, the capacity of each CPU is represented by the ratio of its highest
+HWP performance level, multiplied by 1024, to the highest HWP performance level
+of the most performant CPU in the system, which works because the HWP performance
+units are the same for all CPUs.  Second, the frequency-invariance computations,
+carried out by the scheduler to always express CPU utilization in the same units
+regardless of the frequency it is currently running at, are adjusted to take the
+CPU capacity into account.  All of this happens when ``intel_pstate`` has
+registered itself with the ``CPUFreq`` core and it has figured out that it is
+running on a hybrid processor without SMT.
+
+Energy-Aware Scheduling Support
+-------------------------------
+
+If ``CONFIG_ENERGY_MODEL`` has been set during kernel configuration and
+``intel_pstate`` runs on a hybrid processor without SMT, in addition to enabling
+`CAS <CAS_>`_ it registers an Energy Model for the processor.  This allows the
+Energy-Aware Scheduling (EAS) support to be enabled in the CPU scheduler if
+``schedutil`` is used as the  ``CPUFreq`` governor which requires ``intel_pstate``
+to operate in the `passive mode <Passive Mode_>`_.
+
+The Energy Model registered by ``intel_pstate`` is artificial (that is, it is
+based on abstract cost values and it does not include any real power numbers)
+and it is relatively simple to avoid unnecessary computations in the scheduler.
+There is a performance domain in it for every CPU in the system and the cost
+values for these performance domains have been chosen so that running a task on
+a less performant (small) CPU appears to be always cheaper than running that
+task on a more performant (big) CPU.  However, for two CPUs of the same type,
+the cost difference depends on their current utilization, and the CPU whose
+current utilization is higher generally appears to be a more expensive
+destination for a given task.  This helps to balance the load among CPUs of the
+same type.
+
+Since EAS works on top of CAS, high-utilization tasks are always migrated to
+CPUs with enough capacity to accommodate them, but thanks to EAS, low-utilization
+tasks tend to be placed on the CPUs that look less expensive to the scheduler.
+Effectively, this causes the less performant and less loaded CPUs to be
+preferred as long as they have enough spare capacity to run the given task
+which generally leads to reduced energy usage.
+
+The Energy Model created by ``intel_pstate`` can be inspected by looking at
+the ``energy_model`` directory in ``debugfs`` (typlically mounted on
+``/sys/kernel/debug/``).
+
+
 User Space Interface in ``sysfs``
 =================================
 
@@ -697,8 +797,8 @@
 	Limits`_ for details).
 
 ``no_cas``
-	Do not enable capacity-aware scheduling (CAS) which is enabled by
-	default on hybrid systems.
+	Do not enable `capacity-aware scheduling <CAS_>`_ which is enabled by
+	default on hybrid systems without SMT.
 
 Diagnostics and Tuning
 ======================




