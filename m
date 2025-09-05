Return-Path: <linux-pm+bounces-33924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D35DB45010
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFD23AF121
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 07:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FE259C98;
	Fri,  5 Sep 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6A5JUk3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s57fssmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DBDF71;
	Fri,  5 Sep 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057973; cv=none; b=kTMNlKPp5YORCTdnEjMGGgKSt8T6l0VFpK5yhq/phGPYcqdtkTlLy/aj3mSwVWqcfxMhMfvDinTtbaN/4z3Zbia/BNgWlP81AKyhfN3n0sL2rI2hfoseX+LoxMgWQgk4anmKqgZddh8+VeZNdkWTTOyON1B4UK1LZyTYosmEmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057973; c=relaxed/simple;
	bh=DyZkLNPc/wQTIgRFvI6HgKNw289oyvsHfdB4QWZ2bLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxS7deYsZpSrP1STn+ht2vxHQzlufpRtPl3bz5JbTyemW9XNzrefBGnWgcex6gjxW4j3bS0ZRY9jTMjaVgzdeHHKUkFebPc6CwbyZ4ciN02zQ4DLW5Oy1oLu0QUPsrTx67ugjb4cOrdeyg8JLwbhcP5xt5dpuwm/GO5qgqkHxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6A5JUk3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s57fssmN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757057969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7PT1+9BbH+Z+gC9hOGykGjV475zsX6Spgw41lF91zFM=;
	b=D6A5JUk3GAWBtIymmRIUgKaVb/sUuwgAdrQEJB12tMvuk/Fw8E1rrdOX68Lyh/drBxhatU
	nmss1odGmY2YUxrfFLgXVDBSoM+vEoK82EJlFHjXJ/mpYb1Ninqmio8n4NKBXZT2xsXO1L
	MKPuCcUigdt7vaWoDwvjMXjxv4cHlQBm4PBIq4Xx/FRQPmJy4XtKGKSCQmSkBgUblj6eR5
	7J/wkqotisy7uhI93ZIVyotvgdaFw5F1LjqYpNt/EnG76YHXfl6OA+EGY0pQBu8Bxy5drd
	QEV0NbxmxIWGwLTXh6xVpmgTDmbzmJTkaWxvkLZpCaATQyhqLzaQIz7GvQVtMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757057969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7PT1+9BbH+Z+gC9hOGykGjV475zsX6Spgw41lF91zFM=;
	b=s57fssmNNm7tpSDzVQlzwyvYgZNuXI3fXVNY2s71JlcZ5gEgMVgZK0Gc1wto7zi+Sh9uQq
	j2UR0lSqamWCtXAg==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
In-Reply-To: <12740505.O9o76ZdvQC@rafael.j.wysocki>
References: <12740505.O9o76ZdvQC@rafael.j.wysocki>
Date: Fri, 05 Sep 2025 09:39:27 +0200
Message-ID: <871polxs9c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 29 2025 at 22:01, Rafael J. Wysocki wrote:
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2710,6 +2710,12 @@
>  	cpu_maps_update_begin();
>  	cpu_smt_control = CPU_SMT_ENABLED;
>  	for_each_present_cpu(cpu) {
> +		/*
> +		 * Avoid accidentally onlining primary thread CPUs that have
> +		 * been taken offline.
> +		 */
> +		if (topology_is_primary_thread(cpu))
> +			continue;

Hmm. That's kinda solving the problem, but I think the proper solution
would be to implement topology_is_core_online() for x86.

The above is preventing the primary thread to be onlined, but then
onlines the corresponding hyperthread, which does not really make sense.

Something like the completely untested below.

Thanks,

        tglx
---
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 6c79ee7c0957..21041898157a 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -231,6 +231,16 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
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
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc84910..6073a16628f9 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -372,6 +372,19 @@ unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_uni
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



