Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5020526CC47
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgIPUlI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:41:08 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:32808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728406AbgIPUlC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 16:41:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 64C89180442FA;
        Wed, 16 Sep 2020 20:40:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:327:355:379:541:800:960:966:968:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1605:1730:1747:1777:1792:1801:1981:2194:2196:2198:2199:2200:2201:2393:2559:2562:2741:2902:3138:3139:3140:3141:3142:3165:3865:3867:3868:3870:4321:4385:4605:5007:6119:6261:7903:7904:8603:8957:9010:9036:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12895:12986:13141:13230:13255:13894:13972:14394:14877:21080:21324:21433:21451:21611:21626:21740:21939:21966:21990:30029:30045:30046:30054:30056:30080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: mask72_1d0015b2711c
X-Filterd-Recvd-Size: 28883
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:40:56 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH V3 2/8] drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
Date:   Wed, 16 Sep 2020 13:40:39 -0700
Message-Id: <3d033c33056d88bbe34d4ddb62afd05ee166ab9a.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the various sprintf fmaily calls in sysfs device show functions
to sysfs_emit and sysfs_emit_at for PAGE_SIZE buffer safety.

Done with:

$ spatch -sp-file sysfs_emit_dev.cocci --in-place --max-width=80 .

And cocci script:

$ cat sysfs_emit_dev.cocci
@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	...
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/arch_topology.c            |  2 +-
 drivers/base/cacheinfo.c                | 18 ++++-----
 drivers/base/core.c                     | 19 +++++-----
 drivers/base/cpu.c                      | 32 ++++++++--------
 drivers/base/dd.c                       |  2 +-
 drivers/base/firmware_loader/fallback.c |  2 +-
 drivers/base/memory.c                   | 24 ++++++------
 drivers/base/node.c                     | 28 +++++++-------
 drivers/base/platform.c                 |  4 +-
 drivers/base/power/sysfs.c              | 50 ++++++++++++-------------
 drivers/base/power/wakeup_stats.c       | 12 +++---
 drivers/base/soc.c                      | 10 ++---
 12 files changed, 102 insertions(+), 101 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 75f72d684294..744d4618db33 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -71,7 +71,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
+	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
 }
 
 static void update_topology_flags_workfn(struct work_struct *work);
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 8d553c92cd32..6a8c2b5881be 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -377,7 +377,7 @@ static ssize_t size_show(struct device *dev,
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%uK\n", this_leaf->size >> 10);
+	return sysfs_emit(buf, "%uK\n", this_leaf->size >> 10);
 }
 
 static ssize_t shared_cpumap_show_func(struct device *dev, bool list, char *buf)
@@ -407,11 +407,11 @@ static ssize_t type_show(struct device *dev,
 
 	switch (this_leaf->type) {
 	case CACHE_TYPE_DATA:
-		return sprintf(buf, "Data\n");
+		return sysfs_emit(buf, "Data\n");
 	case CACHE_TYPE_INST:
-		return sprintf(buf, "Instruction\n");
+		return sysfs_emit(buf, "Instruction\n");
 	case CACHE_TYPE_UNIFIED:
-		return sprintf(buf, "Unified\n");
+		return sysfs_emit(buf, "Unified\n");
 	default:
 		return -EINVAL;
 	}
@@ -425,11 +425,11 @@ static ssize_t allocation_policy_show(struct device *dev,
 	int n = 0;
 
 	if ((ci_attr & CACHE_READ_ALLOCATE) && (ci_attr & CACHE_WRITE_ALLOCATE))
-		n = sprintf(buf, "ReadWriteAllocate\n");
+		n = sysfs_emit(buf, "ReadWriteAllocate\n");
 	else if (ci_attr & CACHE_READ_ALLOCATE)
-		n = sprintf(buf, "ReadAllocate\n");
+		n = sysfs_emit(buf, "ReadAllocate\n");
 	else if (ci_attr & CACHE_WRITE_ALLOCATE)
-		n = sprintf(buf, "WriteAllocate\n");
+		n = sysfs_emit(buf, "WriteAllocate\n");
 	return n;
 }
 
@@ -441,9 +441,9 @@ static ssize_t write_policy_show(struct device *dev,
 	int n = 0;
 
 	if (ci_attr & CACHE_WRITE_THROUGH)
-		n = sprintf(buf, "WriteThrough\n");
+		n = sysfs_emit(buf, "WriteThrough\n");
 	else if (ci_attr & CACHE_WRITE_BACK)
-		n = sprintf(buf, "WriteBack\n");
+		n = sysfs_emit(buf, "WriteBack\n");
 	return n;
 }
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8dd753539c06..e17e8e941462 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -259,7 +259,7 @@ static ssize_t status_show(struct device *dev,
 	default:
 		status = "unknown"; break;
 	}
-	return sprintf(buf, "%s\n", status);
+	return sysfs_emit(buf, "%s\n", status);
 }
 static DEVICE_ATTR_RO(status);
 
@@ -276,7 +276,7 @@ static ssize_t auto_remove_on_show(struct device *dev,
 	else
 		str = "never";
 
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 static DEVICE_ATTR_RO(auto_remove_on);
 
@@ -285,7 +285,7 @@ static ssize_t runtime_pm_show(struct device *dev,
 {
 	struct device_link *link = to_devlink(dev);
 
-	return sprintf(buf, "%d\n", !!(link->flags & DL_FLAG_PM_RUNTIME));
+	return sysfs_emit(buf, "%d\n", !!(link->flags & DL_FLAG_PM_RUNTIME));
 }
 static DEVICE_ATTR_RO(runtime_pm);
 
@@ -294,7 +294,8 @@ static ssize_t sync_state_only_show(struct device *dev,
 {
 	struct device_link *link = to_devlink(dev);
 
-	return sprintf(buf, "%d\n", !!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+	return sysfs_emit(buf, "%d\n",
+			  !!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
 }
 static DEVICE_ATTR_RO(sync_state_only);
 
@@ -1059,7 +1060,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 	      && dev->links.need_for_probe;
 	mutex_unlock(&wfs_lock);
 	device_unlock(dev);
-	return sprintf(buf, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 static DEVICE_ATTR_RO(waiting_for_supplier);
 
@@ -1709,7 +1710,7 @@ ssize_t device_show_ulong(struct device *dev,
 			  char *buf)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
+	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
@@ -1739,7 +1740,7 @@ ssize_t device_show_int(struct device *dev,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
@@ -1760,7 +1761,7 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
+	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
@@ -1992,7 +1993,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	device_lock(dev);
 	val = !dev->offline;
 	device_unlock(dev);
-	return sprintf(buf, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t online_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index d2136ab9b14a..232f8146a8c4 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -156,7 +156,7 @@ static ssize_t show_crash_notes(struct device *dev, struct device_attribute *att
 	 * operation should be safe. No locking required.
 	 */
 	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
-	rc = sprintf(buf, "%Lx\n", addr);
+	rc = sysfs_emit(buf, "%Lx\n", addr);
 	return rc;
 }
 static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
@@ -167,7 +167,7 @@ static ssize_t show_crash_notes_size(struct device *dev,
 {
 	ssize_t rc;
 
-	rc = sprintf(buf, "%zu\n", sizeof(note_buf_t));
+	rc = sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
 	return rc;
 }
 static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
@@ -231,7 +231,7 @@ static struct cpu_attr cpu_attrs[] = {
 static ssize_t print_cpus_kernel_max(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", NR_CPUS - 1);
+	return sysfs_emit(buf, "%d\n", NR_CPUS - 1);
 }
 static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);
 
@@ -279,7 +279,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = sprintf(buf, "%*pbl\n", cpumask_pr_args(isolated));
+	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
@@ -291,7 +291,7 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
@@ -323,8 +323,8 @@ static ssize_t print_cpu_modalias(struct device *dev,
 	ssize_t n;
 	u32 i;
 
-	n = sprintf(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
-		    CPU_FEATURE_TYPEVAL);
+	n = sysfs_emit(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+		       CPU_FEATURE_TYPEVAL);
 
 	for (i = 0; i < MAX_CPU_FEATURES; i++)
 		if (cpu_have_feature(i)) {
@@ -516,56 +516,56 @@ static void __init cpu_dev_register_generic(void)
 ssize_t __weak cpu_show_meltdown(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v1(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_l1tf(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_srbds(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "Not affected\n");
+	return sysfs_emit(buf, "Not affected\n");
 }
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6e7319ca5bde..123a1c3e9f18 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -486,7 +486,7 @@ static ssize_t state_synced_show(struct device *dev,
 	device_lock(dev);
 	val = dev->state_synced;
 	device_unlock(dev);
-	return sprintf(buf, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 static DEVICE_ATTR_RO(state_synced);
 
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 283ca2de76d4..7e9598a1577a 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -219,7 +219,7 @@ static ssize_t firmware_loading_show(struct device *dev,
 		loading = fw_sysfs_loading(fw_sysfs->fw_priv);
 	mutex_unlock(&fw_lock);
 
-	return sprintf(buf, "%d\n", loading);
+	return sysfs_emit(buf, "%d\n", loading);
 }
 
 /**
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b4c297dd0475..f5c0b64df2e5 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -119,7 +119,7 @@ static ssize_t phys_index_show(struct device *dev,
 	unsigned long phys_index;
 
 	phys_index = mem->start_section_nr / sections_per_block;
-	return sprintf(buf, "%08lx\n", phys_index);
+	return sysfs_emit(buf, "%08lx\n", phys_index);
 }
 
 /*
@@ -129,7 +129,7 @@ static ssize_t phys_index_show(struct device *dev,
 static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%d\n", (int)IS_ENABLED(CONFIG_MEMORY_HOTREMOVE));
+	return sysfs_emit(buf, "%d\n", (int)IS_ENABLED(CONFIG_MEMORY_HOTREMOVE));
 }
 
 /*
@@ -147,17 +147,17 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	 */
 	switch (mem->state) {
 	case MEM_ONLINE:
-		len = sprintf(buf, "online\n");
+		len = sysfs_emit(buf, "online\n");
 		break;
 	case MEM_OFFLINE:
-		len = sprintf(buf, "offline\n");
+		len = sysfs_emit(buf, "offline\n");
 		break;
 	case MEM_GOING_OFFLINE:
-		len = sprintf(buf, "going-offline\n");
+		len = sysfs_emit(buf, "going-offline\n");
 		break;
 	default:
-		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
-				mem->state);
+		len = sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n",
+				 mem->state);
 		WARN_ON(1);
 		break;
 	}
@@ -303,7 +303,7 @@ static ssize_t phys_device_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	return sprintf(buf, "%d\n", mem->phys_device);
+	return sysfs_emit(buf, "%d\n", mem->phys_device);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -341,7 +341,7 @@ static ssize_t valid_zones_show(struct device *dev,
 		default_zone = test_pages_in_a_zone(start_pfn,
 						    start_pfn + nr_pages);
 		if (!default_zone)
-			return sprintf(buf, "none\n");
+			return sysfs_emit(buf, "none\n");
 		strcat(buf, default_zone->name);
 		goto out;
 	}
@@ -374,7 +374,7 @@ static DEVICE_ATTR_RO(removable);
 static ssize_t block_size_bytes_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lx\n", memory_block_size_bytes());
+	return sysfs_emit(buf, "%lx\n", memory_block_size_bytes());
 }
 
 static DEVICE_ATTR_RO(block_size_bytes);
@@ -386,8 +386,8 @@ static DEVICE_ATTR_RO(block_size_bytes);
 static ssize_t auto_online_blocks_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%s\n",
-		       online_type_to_str[memhp_default_online_type]);
+	return sysfs_emit(buf, "%s\n",
+			  online_type_to_str[memhp_default_online_type]);
 }
 
 static ssize_t auto_online_blocks_store(struct device *dev,
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9426b0f1f660..f6bde7acd5fe 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -370,7 +370,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 	si_meminfo_node(&i, nid);
 	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
 	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
-	n = sprintf(buf,
+	n = sysfs_emit(buf,
 		       "Node %d MemTotal:       %8lu kB\n"
 		       "Node %d MemFree:        %8lu kB\n"
 		       "Node %d MemUsed:        %8lu kB\n"
@@ -477,19 +477,19 @@ static DEVICE_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf,
-		       "numa_hit %lu\n"
-		       "numa_miss %lu\n"
-		       "numa_foreign %lu\n"
-		       "interleave_hit %lu\n"
-		       "local_node %lu\n"
-		       "other_node %lu\n",
-		       sum_zone_numa_state(dev->id, NUMA_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_MISS),
-		       sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-		       sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-		       sum_zone_numa_state(dev->id, NUMA_LOCAL),
-		       sum_zone_numa_state(dev->id, NUMA_OTHER));
+	return sysfs_emit(buf,
+			  "numa_hit %lu\n"
+			  "numa_miss %lu\n"
+			  "numa_foreign %lu\n"
+			  "interleave_hit %lu\n"
+			  "local_node %lu\n"
+			  "other_node %lu\n",
+			  sum_zone_numa_state(dev->id, NUMA_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_MISS),
+			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
+			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
+			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
+			  sum_zone_numa_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d90d92e63903..f0f8cfcc3621 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1084,7 +1084,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = sprintf(buf, "%s\n", pdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
@@ -1093,7 +1093,7 @@ static DEVICE_ATTR_RW(driver_override);
 static ssize_t numa_node_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_node(dev));
+	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
 }
 static DEVICE_ATTR_RO(numa_node);
 
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index c7b24812523c..4276b792d0aa 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -101,7 +101,7 @@ static const char ctrl_on[] = "on";
 static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
@@ -127,7 +127,7 @@ static ssize_t runtime_active_time_show(struct device *dev,
 	int ret;
 	u64 tmp = pm_runtime_active_time(dev);
 	do_div(tmp, NSEC_PER_MSEC);
-	ret = sprintf(buf, "%llu\n", tmp);
+	ret = sysfs_emit(buf, "%llu\n", tmp);
 	return ret;
 }
 
@@ -139,7 +139,7 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 	int ret;
 	u64 tmp = pm_runtime_suspended_time(dev);
 	do_div(tmp, NSEC_PER_MSEC);
-	ret = sprintf(buf, "%llu\n", tmp);
+	ret = sysfs_emit(buf, "%llu\n", tmp);
 	return ret;
 }
 
@@ -172,7 +172,7 @@ static ssize_t runtime_status_show(struct device *dev,
 			return -EIO;
 		}
 	}
-	return sprintf(buf, p);
+	return sysfs_emit(buf, p);
 }
 
 static DEVICE_ATTR_RO(runtime_status);
@@ -182,7 +182,7 @@ static ssize_t autosuspend_delay_ms_show(struct device *dev,
 {
 	if (!dev->power.use_autosuspend)
 		return -EIO;
-	return sprintf(buf, "%d\n", dev->power.autosuspend_delay);
+	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay);
 }
 
 static ssize_t autosuspend_delay_ms_store(struct device *dev,
@@ -211,11 +211,11 @@ static ssize_t pm_qos_resume_latency_us_show(struct device *dev,
 	s32 value = dev_pm_qos_requested_resume_latency(dev);
 
 	if (value == 0)
-		return sprintf(buf, "n/a\n");
+		return sysfs_emit(buf, "n/a\n");
 	if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
 		value = 0;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
@@ -255,11 +255,11 @@ static ssize_t pm_qos_latency_tolerance_us_show(struct device *dev,
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
 	if (value < 0)
-		return sprintf(buf, "auto\n");
+		return sysfs_emit(buf, "auto\n");
 	if (value == PM_QOS_LATENCY_ANY)
-		return sprintf(buf, "any\n");
+		return sysfs_emit(buf, "any\n");
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_latency_tolerance_us_store(struct device *dev,
@@ -291,8 +291,8 @@ static ssize_t pm_qos_no_power_off_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					& PM_QOS_FLAG_NO_POWER_OFF));
+	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					  & PM_QOS_FLAG_NO_POWER_OFF));
 }
 
 static ssize_t pm_qos_no_power_off_store(struct device *dev,
@@ -320,9 +320,9 @@ static const char _disabled[] = "disabled";
 static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%s\n", device_can_wakeup(dev)
-		? (device_may_wakeup(dev) ? _enabled : _disabled)
-		: "");
+	return sysfs_emit(buf, "%s\n", device_can_wakeup(dev)
+			  ? (device_may_wakeup(dev) ? _enabled : _disabled)
+			  : "");
 }
 
 static ssize_t wakeup_store(struct device *dev, struct device_attribute *attr,
@@ -522,7 +522,7 @@ static inline int dpm_sysfs_wakeup_change_owner(struct device *dev, kuid_t kuid,
 static ssize_t runtime_usage_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
+	return sysfs_emit(buf, "%d\n", atomic_read(&dev->power.usage_count));
 }
 static DEVICE_ATTR_RO(runtime_usage);
 
@@ -530,8 +530,8 @@ static ssize_t runtime_active_kids_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%d\n", dev->power.ignore_children ?
-		0 : atomic_read(&dev->power.child_count));
+	return sysfs_emit(buf, "%d\n", dev->power.ignore_children ?
+			  0 : atomic_read(&dev->power.child_count));
 }
 static DEVICE_ATTR_RO(runtime_active_kids);
 
@@ -539,12 +539,12 @@ static ssize_t runtime_enabled_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
-		return sprintf(buf, "disabled & forbidden\n");
+		return sysfs_emit(buf, "disabled & forbidden\n");
 	if (dev->power.disable_depth)
-		return sprintf(buf, "disabled\n");
+		return sysfs_emit(buf, "disabled\n");
 	if (dev->power.runtime_auto == false)
-		return sprintf(buf, "forbidden\n");
-	return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "forbidden\n");
+	return sysfs_emit(buf, "enabled\n");
 }
 static DEVICE_ATTR_RO(runtime_enabled);
 
@@ -552,9 +552,9 @@ static DEVICE_ATTR_RO(runtime_enabled);
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	return sprintf(buf, "%s\n",
-			device_async_suspend_enabled(dev) ?
-				_enabled : _disabled);
+	return sysfs_emit(buf, "%s\n",
+			  device_async_suspend_enabled(dev) ?
+			  _enabled : _disabled);
 }
 
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index c7734914d914..5568e25d7c9c 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -42,7 +42,7 @@ static ssize_t active_time_ms_show(struct device *dev,
 	ktime_t active_time =
 		ws->active ? ktime_sub(ktime_get(), ws->last_time) : 0;
 
-	return sprintf(buf, "%lld\n", ktime_to_ms(active_time));
+	return sysfs_emit(buf, "%lld\n", ktime_to_ms(active_time));
 }
 static DEVICE_ATTR_RO(active_time_ms);
 
@@ -57,7 +57,7 @@ static ssize_t total_time_ms_show(struct device *dev,
 		active_time = ktime_sub(ktime_get(), ws->last_time);
 		total_time = ktime_add(total_time, active_time);
 	}
-	return sprintf(buf, "%lld\n", ktime_to_ms(total_time));
+	return sysfs_emit(buf, "%lld\n", ktime_to_ms(total_time));
 }
 static DEVICE_ATTR_RO(total_time_ms);
 
@@ -73,7 +73,7 @@ static ssize_t max_time_ms_show(struct device *dev,
 		if (active_time > max_time)
 			max_time = active_time;
 	}
-	return sprintf(buf, "%lld\n", ktime_to_ms(max_time));
+	return sysfs_emit(buf, "%lld\n", ktime_to_ms(max_time));
 }
 static DEVICE_ATTR_RO(max_time_ms);
 
@@ -82,7 +82,7 @@ static ssize_t last_change_ms_show(struct device *dev,
 {
 	struct wakeup_source *ws = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld\n", ktime_to_ms(ws->last_time));
+	return sysfs_emit(buf, "%lld\n", ktime_to_ms(ws->last_time));
 }
 static DEVICE_ATTR_RO(last_change_ms);
 
@@ -91,7 +91,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wakeup_source *ws = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", ws->name);
+	return sysfs_emit(buf, "%s\n", ws->name);
 }
 static DEVICE_ATTR_RO(name);
 
@@ -106,7 +106,7 @@ static ssize_t prevent_suspend_time_ms_show(struct device *dev,
 		prevent_sleep_time = ktime_add(prevent_sleep_time,
 			ktime_sub(ktime_get(), ws->start_prevent_time));
 	}
-	return sprintf(buf, "%lld\n", ktime_to_ms(prevent_sleep_time));
+	return sysfs_emit(buf, "%lld\n", ktime_to_ms(prevent_sleep_time));
 }
 static DEVICE_ATTR_RO(prevent_suspend_time_ms);
 
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index a5bae551167d..fc6536a7eac6 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -76,15 +76,15 @@ static ssize_t soc_info_get(struct device *dev,
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
 	if (attr == &dev_attr_machine)
-		return sprintf(buf, "%s\n", soc_dev->attr->machine);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->machine);
 	if (attr == &dev_attr_family)
-		return sprintf(buf, "%s\n", soc_dev->attr->family);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
-		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->revision);
 	if (attr == &dev_attr_serial_number)
-		return sprintf(buf, "%s\n", soc_dev->attr->serial_number);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->serial_number);
 	if (attr == &dev_attr_soc_id)
-		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
+		return sysfs_emit(buf, "%s\n", soc_dev->attr->soc_id);
 
 	return -EINVAL;
 
-- 
2.26.0

