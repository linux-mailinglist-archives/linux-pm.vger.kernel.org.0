Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29F95EF25
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 00:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCW1b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 18:27:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfGCW1a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 18:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dR8rT6j2M0ly/hhLtGGd/Pl7BP9JO2M9xU7J236aZE4=; b=Q0btV7qNug0FYaQRyhqhr3dpC
        Sqdvr01db6up1aYCvpUM0mEeFGvu7Q43A1wGQikv/32GhPh1rKMyGTbpPVsOMxaaquHhGZS4q45zI
        UpUSf7s2/PQ11MaRou3a73NzowXN90P1kX7jgVveuux8Juh4RR85mj/9LUYGyd5tLsOZexziLlsK5
        YJ0TOvaWT8obuO2nzr0SAGa6O2pIDfgjKQx+dgU8Uy+I/4NdHbMD7TT1UkkpOhWbwtiisulQ6AcKk
        G+URVE9JSUfbi2yyu1uIgowBU/HKsNENLTZX5OXA4Qv56yOMgtichI7l+b5+LhvpxZt3jt9ne2+tU
        JnD8U641w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hinin-0003Lf-Lg; Wed, 03 Jul 2019 22:27:25 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel/cpu: hotplug; fix non-SYSFS build errors in
 arch/x86/power/
Message-ID: <9906a70d-7a4a-03a1-f555-07231570364d@infradead.org>
Date:   Wed, 3 Jul 2019 15:27:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix link errors when building almost-allmodconfig but CONFIG_SYSFS
is not set/enabled.

The missing functions should not be inside #if CONFIG_SYSFS/#endif.

The non-SYSFS stub for __store_smt_control() is no longer needed.

This is almost all code movement and a little ifdef-fery changes.

Fixes these build errors:

ld: arch/x86/power/cpu.o: in function `hibernate_resume_nonboot_cpu_disable':
cpu.c:(.text+0x9f4): undefined reference to `cpuhp_smt_enable'
ld: arch/x86/power/hibernate.o: in function `arch_resume_nosmt':
hibernate.c:(.text+0x7f7): undefined reference to `cpuhp_smt_enable'
ld: hibernate.c:(.text+0x809): undefined reference to `cpuhp_smt_disable'

Fixes: 98f8cdce1db5 ("cpu/hotplug: Add sysfs state interface")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---
 kernel/cpu.c |  242 +++++++++++++++++++++++--------------------------
 1 file changed, 118 insertions(+), 124 deletions(-)

--- lnx-52-rc7.orig/kernel/cpu.c
+++ lnx-52-rc7/kernel/cpu.c
@@ -376,7 +376,7 @@ static void lockdep_release_cpus_lock(vo
 {
 }
 
-#endif	/* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_HOTPLUG_CPU */
 
 /*
  * Architectures that need SMT-specific errata handling during SMT hotplug
@@ -1892,6 +1892,123 @@ void __cpuhp_remove_state(enum cpuhp_sta
 }
 EXPORT_SYMBOL(__cpuhp_remove_state);
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+static void cpuhp_offline_cpu_device(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	dev->offline = true;
+	/* Tell user space about the state change */
+	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
+}
+
+static void cpuhp_online_cpu_device(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	dev->offline = false;
+	/* Tell user space about the state change */
+	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+}
+
+int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
+{
+	int cpu, ret = 0;
+
+	cpu_maps_update_begin();
+	for_each_online_cpu(cpu) {
+		if (topology_is_primary_thread(cpu))
+			continue;
+		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
+		if (ret)
+			break;
+		/*
+		 * As this needs to hold the cpu maps lock it's impossible
+		 * to call device_offline() because that ends up calling
+		 * cpu_down() which takes cpu maps lock. cpu maps lock
+		 * needs to be held as this might race against in kernel
+		 * abusers of the hotplug machinery (thermal management).
+		 *
+		 * So nothing would update device:offline state. That would
+		 * leave the sysfs entry stale and prevent onlining after
+		 * smt control has been changed to 'off' again. This is
+		 * called under the sysfs hotplug lock, so it is properly
+		 * serialized against the regular offline usage.
+		 */
+		cpuhp_offline_cpu_device(cpu);
+	}
+	if (!ret)
+		cpu_smt_control = ctrlval;
+	cpu_maps_update_done();
+	return ret;
+}
+
+int cpuhp_smt_enable(void)
+{
+	int cpu, ret = 0;
+
+	cpu_maps_update_begin();
+	cpu_smt_control = CPU_SMT_ENABLED;
+	for_each_present_cpu(cpu) {
+		/* Skip online CPUs and CPUs on offline nodes */
+		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
+			continue;
+		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
+		if (ret)
+			break;
+		/* See comment in cpuhp_smt_disable() */
+		cpuhp_online_cpu_device(cpu);
+	}
+	cpu_maps_update_done();
+	return ret;
+}
+
+#if defined(CONFIG_HOTPLUG_SMT) && defined(CONFIG_SYSFS)
+static ssize_t
+__store_smt_control(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	int ctrlval, ret;
+
+	if (sysfs_streq(buf, "on"))
+		ctrlval = CPU_SMT_ENABLED;
+	else if (sysfs_streq(buf, "off"))
+		ctrlval = CPU_SMT_DISABLED;
+	else if (sysfs_streq(buf, "forceoff"))
+		ctrlval = CPU_SMT_FORCE_DISABLED;
+	else
+		return -EINVAL;
+
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
+		return -EPERM;
+
+	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return -ENODEV;
+
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
+	if (ctrlval != cpu_smt_control) {
+		switch (ctrlval) {
+		case CPU_SMT_ENABLED:
+			ret = cpuhp_smt_enable();
+			break;
+		case CPU_SMT_DISABLED:
+		case CPU_SMT_FORCE_DISABLED:
+			ret = cpuhp_smt_disable(ctrlval);
+			break;
+		}
+	}
+
+	unlock_device_hotplug();
+	return ret ? ret : count;
+}
+#endif /* CONFIG_HOTPLUG_SMT && CONFIG_SYSFS */
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 #if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
 static ssize_t show_cpuhp_state(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -2044,129 +2161,6 @@ static const struct attribute_group cpuh
 	NULL
 };
 
-#ifdef CONFIG_HOTPLUG_SMT
-
-static void cpuhp_offline_cpu_device(unsigned int cpu)
-{
-	struct device *dev = get_cpu_device(cpu);
-
-	dev->offline = true;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
-}
-
-static void cpuhp_online_cpu_device(unsigned int cpu)
-{
-	struct device *dev = get_cpu_device(cpu);
-
-	dev->offline = false;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-}
-
-int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
-{
-	int cpu, ret = 0;
-
-	cpu_maps_update_begin();
-	for_each_online_cpu(cpu) {
-		if (topology_is_primary_thread(cpu))
-			continue;
-		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
-		if (ret)
-			break;
-		/*
-		 * As this needs to hold the cpu maps lock it's impossible
-		 * to call device_offline() because that ends up calling
-		 * cpu_down() which takes cpu maps lock. cpu maps lock
-		 * needs to be held as this might race against in kernel
-		 * abusers of the hotplug machinery (thermal management).
-		 *
-		 * So nothing would update device:offline state. That would
-		 * leave the sysfs entry stale and prevent onlining after
-		 * smt control has been changed to 'off' again. This is
-		 * called under the sysfs hotplug lock, so it is properly
-		 * serialized against the regular offline usage.
-		 */
-		cpuhp_offline_cpu_device(cpu);
-	}
-	if (!ret)
-		cpu_smt_control = ctrlval;
-	cpu_maps_update_done();
-	return ret;
-}
-
-int cpuhp_smt_enable(void)
-{
-	int cpu, ret = 0;
-
-	cpu_maps_update_begin();
-	cpu_smt_control = CPU_SMT_ENABLED;
-	for_each_present_cpu(cpu) {
-		/* Skip online CPUs and CPUs on offline nodes */
-		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
-			continue;
-		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
-		if (ret)
-			break;
-		/* See comment in cpuhp_smt_disable() */
-		cpuhp_online_cpu_device(cpu);
-	}
-	cpu_maps_update_done();
-	return ret;
-}
-
-
-static ssize_t
-__store_smt_control(struct device *dev, struct device_attribute *attr,
-		    const char *buf, size_t count)
-{
-	int ctrlval, ret;
-
-	if (sysfs_streq(buf, "on"))
-		ctrlval = CPU_SMT_ENABLED;
-	else if (sysfs_streq(buf, "off"))
-		ctrlval = CPU_SMT_DISABLED;
-	else if (sysfs_streq(buf, "forceoff"))
-		ctrlval = CPU_SMT_FORCE_DISABLED;
-	else
-		return -EINVAL;
-
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
-		return -EPERM;
-
-	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		return -ENODEV;
-
-	ret = lock_device_hotplug_sysfs();
-	if (ret)
-		return ret;
-
-	if (ctrlval != cpu_smt_control) {
-		switch (ctrlval) {
-		case CPU_SMT_ENABLED:
-			ret = cpuhp_smt_enable();
-			break;
-		case CPU_SMT_DISABLED:
-		case CPU_SMT_FORCE_DISABLED:
-			ret = cpuhp_smt_disable(ctrlval);
-			break;
-		}
-	}
-
-	unlock_device_hotplug();
-	return ret ? ret : count;
-}
-
-#else /* !CONFIG_HOTPLUG_SMT */
-static ssize_t
-__store_smt_control(struct device *dev, struct device_attribute *attr,
-		    const char *buf, size_t count)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_HOTPLUG_SMT */
-
 static const char *smt_states[] = {
 	[CPU_SMT_ENABLED]		= "on",
 	[CPU_SMT_DISABLED]		= "off",


