Return-Path: <linux-pm+bounces-35115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A099EB8D80B
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6748E17100F
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147D6246774;
	Sun, 21 Sep 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhajQONe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z0cBn+xH"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3761E5B63;
	Sun, 21 Sep 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758445005; cv=none; b=SFLeA4reNTN+tUrhJtgfDxZBZ/MkcXt05G/VoOvoy5qjkJiezqYKGPwrq3fqbEEOO+4FTrGmTT3ri2pSHS6r6ZmChFaQppum5kQJhJVsMkmjKvw7jHJK/3cpmPZjKmgKlTH4qcx7zQr2RMwRldo3TkKX3HupDpcPFHLotk7p+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758445005; c=relaxed/simple;
	bh=dCUrZDUEc5+DreJ20UhumTmXqXfdGX2j+ZfRG61AAD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZlU793kmY6dGsIJ9I8xQayR26bYwLlxwfya40MXA+sBm9iXvyAQTLSnM34GBWlRpu5mdS/dVB+dvW3pPubjy8BHQvnCjI6UpqQLgTmsN5PQtzcy0mWzS9u795Cg5x2DtzU3YzKYbW41Wql+JAE1E1tc9y2aCQ+bC8ppvtAlUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhajQONe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z0cBn+xH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758445001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PH0Bier6+Ggl5FPLln7YaPLjHsHvublgFxYXIHS3ZCw=;
	b=PhajQONehkB9Wj6JVMiLXn0+zPsdIYZMOOecPDlcw4peQTZYRa3bjfEEvBA2zv9gC4QOb4
	LcnvwGPBPUL7gnYe0fPej6zkDv/xrpuEvH0UKgjWojCPgm/I/U+nHVOJoAq9QogtSInyxD
	CT+Mg3VZRErKJHYajQPpJn4VJ+tgzkwsbyiOlVGEfr2lJE8SVafLAsE6RELH03sFf10NDf
	G2llvOnSZfukqLIBFYGZeOhVH/qHoS//0qwzwDBzWB3K66KyXQRn2hpHw+R2WaH4EU1FTx
	UHVayxsyNR9PvQor1FTUDOmEqA12mziZjwizi7EeGVXUz/CyMDuXFlYkrNMQpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758445001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PH0Bier6+Ggl5FPLln7YaPLjHsHvublgFxYXIHS3ZCw=;
	b=Z0cBn+xH4Vosui8Q6dNcDVnJbzpy1m7SlBS3tk9ozpYXWoxNGgOmcn8EM1ITCvEdSt7fQi
	68R3qboCiyNvDJDQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Christian Loehle
 <christian.loehle@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/topology: Implement topology_is_core_online() to
 address SMT regression
In-Reply-To: <CAJZ5v0gW+A-eyckySFrHc7=Qr9URdRX6NqvPgkq4gZEvs_uBWg@mail.gmail.com>
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
 <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
 <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
 <87o6rowrsp.ffs@tglx>
 <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
 <87ldmqwgjc.ffs@tglx>
 <CAJZ5v0gW+A-eyckySFrHc7=Qr9URdRX6NqvPgkq4gZEvs_uBWg@mail.gmail.com>
Date: Sun, 21 Sep 2025 10:56:40 +0200
Message-ID: <87cy7k5gl3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian reported that commit a430c11f4015 ("intel_idle: Rescan "dead" SMT
siblings during initialization") broke the use case in which both 'nosmt'
and 'maxcpus' are on the kernel command line because it onlines primary
threads, which were offline due to the maxcpus limit.

The initially proposed fix to skip primary threads in the loop is
inconsistent. While it prevents the primary thread to be onlined, it then
onlines the corresponding hyperthread(s), which does not really make sense.

The CPU iterator in cpuhp_smt_enable() contains a check which excludes all
threads of a core, when the primary thread is offline. The default
implementation is a NOOP and therefore not effective on x86.

Implement topology_is_core_online() on x86 to address this issue. This
makes the behaviour consistent between x86 and PowerPC.

Fixes: a430c11f4015 ("intel_idle: Rescan "dead" SMT siblings during initialization")
Fixes: f694481b1d31 ("ACPI: processor: Rescan "dead" SMT siblings during initialization")
Reported-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/12740505.O9o76ZdvQC@rafael.j.wysocki
Closes: https://lore.kernel.org/linux-pm/724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com/
---
 arch/x86/include/asm/topology.h |   10 ++++++++++
 arch/x86/kernel/cpu/topology.c  |   13 +++++++++++++
 2 files changed, 23 insertions(+)

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -231,6 +231,16 @@ static inline bool topology_is_primary_t
 }
 #define topology_is_primary_thread topology_is_primary_thread
 
+int topology_get_primary_thread(unsigned int cpu);
+
+static inline bool topology_is_core_online(unsigned int cpu)
+{
+	int pcpu = topology_get_primary_thread(cpu);
+
+	return pcpu >= 0 ? cpu_online(pcpu) : false;
+}
+#define topology_is_core_online topology_is_core_online
+
 #else /* CONFIG_SMP */
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -372,6 +372,19 @@ unsigned int topology_unit_count(u32 api
 	return topo_unit_count(lvlid, at_level, apic_maps[which_units].map);
 }
 
+#ifdef CONFIG_SMP
+int topology_get_primary_thread(unsigned int cpu)
+{
+	u32 apic_id = cpuid_to_apicid[cpu];
+
+	/*
+	 * Get the core domain level APIC id, which is the primary thread
+	 * and return the CPU number assigned to it.
+	 */
+	return topo_lookup_cpuid(topo_apicid(apic_id, TOPO_CORE_DOMAIN));
+}
+#endif
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot

