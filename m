Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0F26CC42
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIPUlh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:41:37 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:52192 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726702AbgIPUlO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 16:41:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B8D9818224D7C;
        Wed, 16 Sep 2020 20:41:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:69:327:355:379:541:960:966:968:973:982:988:989:1260:1311:1314:1345:1359:1437:1500:1515:1605:1730:1747:1777:1792:1801:2194:2196:2198:2199:2200:2201:2393:2559:2562:2896:2901:3138:3139:3140:3141:3142:3165:3865:3866:3867:3868:3871:3874:4321:4385:4605:5007:6261:7875:7903:7904:8957:9010:9592:10004:10848:11026:11233:11914:12043:12048:12296:12297:12438:12555:12679:12698:12737:12895:12986:13141:13230:13894:13972:14394:21080:21220:21433:21451:21611:21626:21795:21966:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: idea06_340364a2711c
X-Filterd-Recvd-Size: 44103
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:41:05 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH V3 5/8] drivers core: Miscellaneous changes for sysfs_emit
Date:   Wed, 16 Sep 2020 13:40:42 -0700
Message-Id: <8bc24444fe2049a9b2de6127389b57edfdfe324d.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change additional instances that could use sysfs_emit and sysfs_emit_at
that the coccinelle script could not convert.

o macros creating show functions with ## concatenation
o unbound sprintf uses with buf+len for start of output to sysfs_emit_at
o returns with ?: tests and sprintf to sysfs_emit
o sysfs output with struct class * not struct device * arguments

Miscellanea:

o remove unnecessary initializations around these changes
o consistently use int len for return length of show functions
o use octal permissions and not S_<FOO>
o rename a few show function names so DEVICE_ATTR_<FOO> can be used
o use DEVICE_ATTR_ADMIN_RO where appropriate
o consistently use const char *output for strings
o checkpatch/style neatening

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/bus.c                      |   2 +-
 drivers/base/cacheinfo.c                |   2 +-
 drivers/base/class.c                    |   2 +-
 drivers/base/core.c                     |  34 +--
 drivers/base/cpu.c                      |  62 +++---
 drivers/base/dd.c                       |   1 +
 drivers/base/devcoredump.c              |   2 +-
 drivers/base/firmware_loader/fallback.c |   2 +-
 drivers/base/memory.c                   |   5 +-
 drivers/base/node.c                     | 268 ++++++++++++------------
 drivers/base/platform.c                 |  13 +-
 drivers/base/power/sysfs.c              | 103 +++++----
 drivers/base/power/wakeup_stats.c       |   5 +-
 drivers/base/soc.c                      |  64 +++---
 drivers/base/topology.c                 |  10 +-
 15 files changed, 308 insertions(+), 267 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 886e9054999a..a9c23ecebc7c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -229,7 +229,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(bind, S_IWUSR, NULL, bind_store);
 
 static ssize_t drivers_autoprobe_show(struct bus_type *bus, char *buf)
 {
-	return sprintf(buf, "%d\n", bus->p->drivers_autoprobe);
+	return sysfs_emit(buf, "%d\n", bus->p->drivers_autoprobe);
 }
 
 static ssize_t drivers_autoprobe_store(struct bus_type *bus,
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 96f8af414a48..4946647bd985 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -362,7 +362,7 @@ static ssize_t file_name##_show(struct device *dev,		\
 		struct device_attribute *attr, char *buf)	\
 {								\
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);	\
-	return sprintf(buf, "%u\n", this_leaf->object);		\
+	return sysfs_emit(buf, "%u\n", this_leaf->object);	\
 }
 
 show_one(id, id);
diff --git a/drivers/base/class.c b/drivers/base/class.c
index bcd410e6d70a..c3451481194e 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -478,7 +478,7 @@ ssize_t show_class_attr_string(struct class *class,
 	struct class_attribute_string *cs;
 
 	cs = container_of(attr, struct class_attribute_string, attr);
-	return snprintf(buf, PAGE_SIZE, "%s\n", cs->str);
+	return sysfs_emit(buf, "%s\n", cs->str);
 }
 
 EXPORT_SYMBOL_GPL(show_class_attr_string);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index c5d2cc8bb8b0..3a0701261ff2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -239,27 +239,35 @@ void device_pm_move_to_tail(struct device *dev)
 #define to_devlink(dev)	container_of((dev), struct device_link, link_dev)
 
 static ssize_t status_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+			   struct device_attribute *attr, char *buf)
 {
-	char *status;
+	const char *output;
 
 	switch (to_devlink(dev)->status) {
 	case DL_STATE_NONE:
-		status = "not tracked"; break;
+		output = "not tracked";
+		break;
 	case DL_STATE_DORMANT:
-		status = "dormant"; break;
+		output = "dormant";
+		break;
 	case DL_STATE_AVAILABLE:
-		status = "available"; break;
+		output = "available";
+		break;
 	case DL_STATE_CONSUMER_PROBE:
-		status = "consumer probing"; break;
+		output = "consumer probing";
+		break;
 	case DL_STATE_ACTIVE:
-		status = "active"; break;
+		output = "active";
+		break;
 	case DL_STATE_SUPPLIER_UNBIND:
-		status = "supplier unbinding"; break;
+		output = "supplier unbinding";
+		break;
 	default:
-		status = "unknown"; break;
+		output = "unknown";
+		break;
 	}
-	return sysfs_emit(buf, "%s\n", status);
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 static DEVICE_ATTR_RO(status);
 
@@ -1933,7 +1941,7 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	struct kset *kset;
 	struct kobj_uevent_env *env = NULL;
 	int i;
-	size_t count = 0;
+	int len = 0;
 	int retval;
 
 	/* search the kset, the device belongs to */
@@ -1963,10 +1971,10 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 
 	/* copy keys to file */
 	for (i = 0; i < env->envp_idx; i++)
-		count += sprintf(&buf[count], "%s\n", env->envp[i]);
+		len += sysfs_emit_at(buf, len, "%s\n", env->envp[i]);
 out:
 	kfree(env);
-	return count;
+	return len;
 }
 
 static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 232f8146a8c4..8f1d6569564c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -139,11 +139,11 @@ EXPORT_SYMBOL_GPL(cpu_subsys);
 #ifdef CONFIG_KEXEC
 #include <linux/kexec.h>
 
-static ssize_t show_crash_notes(struct device *dev, struct device_attribute *attr,
+static ssize_t crash_notes_show(struct device *dev,
+				struct device_attribute *attr,
 				char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
-	ssize_t rc;
 	unsigned long long addr;
 	int cpunum;
 
@@ -156,21 +156,18 @@ static ssize_t show_crash_notes(struct device *dev, struct device_attribute *att
 	 * operation should be safe. No locking required.
 	 */
 	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
-	rc = sysfs_emit(buf, "%Lx\n", addr);
-	return rc;
+
+	return sysfs_emit(buf, "%llx\n", addr);
 }
-static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
+static DEVICE_ATTR_ADMIN_RO(crash_notes);
 
-static ssize_t show_crash_notes_size(struct device *dev,
+static ssize_t crash_notes_size_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	ssize_t rc;
-
-	rc = sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
-	return rc;
+	return sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
 }
-static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
+static DEVICE_ATTR_ADMIN_RO(crash_notes_size);
 
 static struct attribute *crash_note_cpu_attrs[] = {
 	&dev_attr_crash_notes.attr,
@@ -241,37 +238,37 @@ unsigned int total_cpus;
 static ssize_t print_cpus_offline(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
+	int len = 0;
 	cpumask_var_t offline;
 
 	/* display offline cpus < nr_cpu_ids */
 	if (!alloc_cpumask_var(&offline, GFP_KERNEL))
 		return -ENOMEM;
 	cpumask_andnot(offline, cpu_possible_mask, cpu_online_mask);
-	n = scnprintf(buf, len, "%*pbl", cpumask_pr_args(offline));
+	len += sysfs_emit_at(buf, len, "%*pbl", cpumask_pr_args(offline));
 	free_cpumask_var(offline);
 
 	/* display offline cpus >= nr_cpu_ids */
 	if (total_cpus && nr_cpu_ids < total_cpus) {
-		if (n && n < len)
-			buf[n++] = ',';
+		len += sysfs_emit_at(buf, len, ",");
 
 		if (nr_cpu_ids == total_cpus-1)
-			n += scnprintf(&buf[n], len - n, "%u", nr_cpu_ids);
+			len += sysfs_emit_at(buf, len, "%u", nr_cpu_ids);
 		else
-			n += scnprintf(&buf[n], len - n, "%u-%d",
-						      nr_cpu_ids, total_cpus-1);
+			len += sysfs_emit_at(buf, len, "%u-%d",
+					     nr_cpu_ids, total_cpus - 1);
 	}
 
-	n += scnprintf(&buf[n], len - n, "\n");
-	return n;
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n;
+	int len;
 	cpumask_var_t isolated;
 
 	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
@@ -279,17 +276,17 @@ static ssize_t print_cpus_isolated(struct device *dev,
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
+	len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
-	return n;
+	return len;
 }
 static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 
 #ifdef CONFIG_NO_HZ_FULL
 static ssize_t print_cpus_nohz_full(struct device *dev,
-				  struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 }
@@ -320,22 +317,23 @@ static ssize_t print_cpu_modalias(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	ssize_t n;
+	int len = 0;
 	u32 i;
 
-	n = sysfs_emit(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
-		       CPU_FEATURE_TYPEVAL);
+	len += sysfs_emit_at(buf, len,
+			     "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+			     CPU_FEATURE_TYPEVAL);
 
 	for (i = 0; i < MAX_CPU_FEATURES; i++)
 		if (cpu_have_feature(i)) {
-			if (PAGE_SIZE < n + sizeof(",XXXX\n")) {
+			if (len + sizeof(",XXXX\n") >= PAGE_SIZE) {
 				WARN(1, "CPU features overflow page\n");
 				break;
 			}
-			n += sprintf(&buf[n], ",%04X", i);
+			len += sysfs_emit_at(buf, len, ",%04X", i);
 		}
-	buf[n++] = '\n';
-	return n;
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
 }
 
 static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -557,7 +555,7 @@ ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
 }
 
 ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+				      struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "Not affected\n");
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 123a1c3e9f18..b52d69eb4e71 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -486,6 +486,7 @@ static ssize_t state_synced_show(struct device *dev,
 	device_lock(dev);
 	val = dev->state_synced;
 	device_unlock(dev);
+
 	return sysfs_emit(buf, "%u\n", val);
 }
 static DEVICE_ATTR_RO(state_synced);
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index e42d0b514384..9243468e2c99 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -123,7 +123,7 @@ static int devcd_free(struct device *dev, void *data)
 static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", devcd_disabled);
+	return sysfs_emit(buf, "%d\n", devcd_disabled);
 }
 
 static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 7e9598a1577a..d60e6d8c967c 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -124,7 +124,7 @@ void kill_pending_fw_fallback_reqs(bool only_kill_custom)
 static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%d\n", __firmware_loading_timeout());
+	return sysfs_emit(buf, "%d\n", __firmware_loading_timeout());
 }
 
 /**
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 7abf9eb8bff0..eef4ffb6122c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -119,6 +119,7 @@ static ssize_t phys_index_show(struct device *dev,
 	unsigned long phys_index;
 
 	phys_index = mem->start_section_nr / sections_per_block;
+
 	return sysfs_emit(buf, "%08lx\n", phys_index);
 }
 
@@ -301,6 +302,7 @@ static ssize_t phys_device_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
+
 	return sysfs_emit(buf, "%d\n", mem->phys_device);
 }
 
@@ -314,6 +316,7 @@ static int print_allowed_zone(char *buf, int len, int nid,
 	zone = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
 	if (zone == default_zone)
 		return 0;
+
 	return sysfs_emit_at(buf, len, " %s", zone->name);
 }
 
@@ -354,7 +357,7 @@ static ssize_t valid_zones_show(struct device *dev,
 	len += print_allowed_zone(buf, len, nid, start_pfn, nr_pages,
 				  MMOP_ONLINE_MOVABLE, default_zone);
 out:
-	len += sysfs_emit_at(buf, len, "%s", "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
 static DEVICE_ATTR_RO(valid_zones);
diff --git a/drivers/base/node.c b/drivers/base/node.c
index b2dcca375da6..b33526a9fcfc 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -46,19 +46,23 @@ static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
 	return n;
 }
 
-static inline ssize_t node_read_cpumask(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static inline ssize_t cpumap_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	return node_read_cpumap(dev, false, buf);
 }
-static inline ssize_t node_read_cpulist(struct device *dev,
-				struct device_attribute *attr, char *buf)
+
+static DEVICE_ATTR_RO(cpumap);
+
+static inline ssize_t cpulist_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
 	return node_read_cpumap(dev, true, buf);
 }
 
-static DEVICE_ATTR(cpumap,  S_IRUGO, node_read_cpumask, NULL);
-static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
+static DEVICE_ATTR_RO(cpulist);
 
 /**
  * struct node_access_nodes - Access class device to hold user visible
@@ -153,13 +157,14 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 }
 
 #ifdef CONFIG_HMEM_REPORTING
-#define ACCESS_ATTR(name) 						   \
-static ssize_t name##_show(struct device *dev,				   \
-			   struct device_attribute *attr,		   \
-			   char *buf)					   \
-{									   \
-	return sprintf(buf, "%u\n", to_access_nodes(dev)->hmem_attrs.name); \
-}									   \
+#define ACCESS_ATTR(name)						\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr,		\
+			   char *buf)					\
+{									\
+	return sysfs_emit(buf, "%u\n",					\
+			  to_access_nodes(dev)->hmem_attrs.name);	\
+}									\
 static DEVICE_ATTR_RO(name);
 
 ACCESS_ATTR(read_bandwidth)
@@ -225,7 +230,8 @@ static ssize_t name##_show(struct device *dev,				\
 			   struct device_attribute *attr,		\
 			   char *buf)					\
 {									\
-	return sprintf(buf, fmt "\n", to_cache_info(dev)->cache_attrs.name);\
+	return sysfs_emit(buf, fmt "\n",				\
+			  to_cache_info(dev)->cache_attrs.name);	\
 }									\
 DEVICE_ATTR_RO(name);
 
@@ -361,7 +367,7 @@ static void node_remove_caches(struct node *node) { }
 static ssize_t node_read_meminfo(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	int n;
+	int len = 0;
 	int nid = dev->id;
 	struct pglist_data *pgdat = NODE_DATA(nid);
 	struct sysinfo i;
@@ -370,112 +376,112 @@ static ssize_t node_read_meminfo(struct device *dev,
 	si_meminfo_node(&i, nid);
 	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
 	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
-	n = sysfs_emit(buf,
-		       "Node %d MemTotal:       %8lu kB\n"
-		       "Node %d MemFree:        %8lu kB\n"
-		       "Node %d MemUsed:        %8lu kB\n"
-		       "Node %d Active:         %8lu kB\n"
-		       "Node %d Inactive:       %8lu kB\n"
-		       "Node %d Active(anon):   %8lu kB\n"
-		       "Node %d Inactive(anon): %8lu kB\n"
-		       "Node %d Active(file):   %8lu kB\n"
-		       "Node %d Inactive(file): %8lu kB\n"
-		       "Node %d Unevictable:    %8lu kB\n"
-		       "Node %d Mlocked:        %8lu kB\n",
-		       nid, K(i.totalram),
-		       nid, K(i.freeram),
-		       nid, K(i.totalram - i.freeram),
-		       nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
-			      node_page_state(pgdat, NR_ACTIVE_FILE)),
-		       nid, K(node_page_state(pgdat, NR_INACTIVE_ANON) +
-			      node_page_state(pgdat, NR_INACTIVE_FILE)),
-		       nid, K(node_page_state(pgdat, NR_ACTIVE_ANON)),
-		       nid, K(node_page_state(pgdat, NR_INACTIVE_ANON)),
-		       nid, K(node_page_state(pgdat, NR_ACTIVE_FILE)),
-		       nid, K(node_page_state(pgdat, NR_INACTIVE_FILE)),
-		       nid, K(node_page_state(pgdat, NR_UNEVICTABLE)),
-		       nid, K(sum_zone_node_page_state(nid, NR_MLOCK)));
+	len = sysfs_emit_at(buf, len,
+			    "Node %d MemTotal:       %8lu kB\n"
+			    "Node %d MemFree:        %8lu kB\n"
+			    "Node %d MemUsed:        %8lu kB\n"
+			    "Node %d Active:         %8lu kB\n"
+			    "Node %d Inactive:       %8lu kB\n"
+			    "Node %d Active(anon):   %8lu kB\n"
+			    "Node %d Inactive(anon): %8lu kB\n"
+			    "Node %d Active(file):   %8lu kB\n"
+			    "Node %d Inactive(file): %8lu kB\n"
+			    "Node %d Unevictable:    %8lu kB\n"
+			    "Node %d Mlocked:        %8lu kB\n",
+			    nid, K(i.totalram),
+			    nid, K(i.freeram),
+			    nid, K(i.totalram - i.freeram),
+			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
+				   node_page_state(pgdat, NR_ACTIVE_FILE)),
+			    nid, K(node_page_state(pgdat, NR_INACTIVE_ANON) +
+				   node_page_state(pgdat, NR_INACTIVE_FILE)),
+			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON)),
+			    nid, K(node_page_state(pgdat, NR_INACTIVE_ANON)),
+			    nid, K(node_page_state(pgdat, NR_ACTIVE_FILE)),
+			    nid, K(node_page_state(pgdat, NR_INACTIVE_FILE)),
+			    nid, K(node_page_state(pgdat, NR_UNEVICTABLE)),
+			    nid, K(sum_zone_node_page_state(nid, NR_MLOCK)));
 
 #ifdef CONFIG_HIGHMEM
-	n += sprintf(buf + n,
-		       "Node %d HighTotal:      %8lu kB\n"
-		       "Node %d HighFree:       %8lu kB\n"
-		       "Node %d LowTotal:       %8lu kB\n"
-		       "Node %d LowFree:        %8lu kB\n",
-		       nid, K(i.totalhigh),
-		       nid, K(i.freehigh),
-		       nid, K(i.totalram - i.totalhigh),
-		       nid, K(i.freeram - i.freehigh));
+	len += sysfs_emit_at(buf, len,
+			     "Node %d HighTotal:      %8lu kB\n"
+			     "Node %d HighFree:       %8lu kB\n"
+			     "Node %d LowTotal:       %8lu kB\n"
+			     "Node %d LowFree:        %8lu kB\n",
+			     nid, K(i.totalhigh),
+			     nid, K(i.freehigh),
+			     nid, K(i.totalram - i.totalhigh),
+			     nid, K(i.freeram - i.freehigh));
 #endif
-	n += sprintf(buf + n,
-		       "Node %d Dirty:          %8lu kB\n"
-		       "Node %d Writeback:      %8lu kB\n"
-		       "Node %d FilePages:      %8lu kB\n"
-		       "Node %d Mapped:         %8lu kB\n"
-		       "Node %d AnonPages:      %8lu kB\n"
-		       "Node %d Shmem:          %8lu kB\n"
-		       "Node %d KernelStack:    %8lu kB\n"
+	len += sysfs_emit_at(buf, len,
+			     "Node %d Dirty:          %8lu kB\n"
+			     "Node %d Writeback:      %8lu kB\n"
+			     "Node %d FilePages:      %8lu kB\n"
+			     "Node %d Mapped:         %8lu kB\n"
+			     "Node %d AnonPages:      %8lu kB\n"
+			     "Node %d Shmem:          %8lu kB\n"
+			     "Node %d KernelStack:    %8lu kB\n"
 #ifdef CONFIG_SHADOW_CALL_STACK
-		       "Node %d ShadowCallStack:%8lu kB\n"
+			     "Node %d ShadowCallStack:%8lu kB\n"
 #endif
-		       "Node %d PageTables:     %8lu kB\n"
-		       "Node %d NFS_Unstable:   %8lu kB\n"
-		       "Node %d Bounce:         %8lu kB\n"
-		       "Node %d WritebackTmp:   %8lu kB\n"
-		       "Node %d KReclaimable:   %8lu kB\n"
-		       "Node %d Slab:           %8lu kB\n"
-		       "Node %d SReclaimable:   %8lu kB\n"
-		       "Node %d SUnreclaim:     %8lu kB\n"
+			     "Node %d PageTables:     %8lu kB\n"
+			     "Node %d NFS_Unstable:   %8lu kB\n"
+			     "Node %d Bounce:         %8lu kB\n"
+			     "Node %d WritebackTmp:   %8lu kB\n"
+			     "Node %d KReclaimable:   %8lu kB\n"
+			     "Node %d Slab:           %8lu kB\n"
+			     "Node %d SReclaimable:   %8lu kB\n"
+			     "Node %d SUnreclaim:     %8lu kB\n"
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		       "Node %d AnonHugePages:  %8lu kB\n"
-		       "Node %d ShmemHugePages: %8lu kB\n"
-		       "Node %d ShmemPmdMapped: %8lu kB\n"
-		       "Node %d FileHugePages: %8lu kB\n"
-		       "Node %d FilePmdMapped: %8lu kB\n"
+			     "Node %d AnonHugePages:  %8lu kB\n"
+			     "Node %d ShmemHugePages: %8lu kB\n"
+			     "Node %d ShmemPmdMapped: %8lu kB\n"
+			     "Node %d FileHugePages: %8lu kB\n"
+			     "Node %d FilePmdMapped: %8lu kB\n"
 #endif
-			,
-		       nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
-		       nid, K(node_page_state(pgdat, NR_WRITEBACK)),
-		       nid, K(node_page_state(pgdat, NR_FILE_PAGES)),
-		       nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
-		       nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
-		       nid, K(i.sharedram),
-		       nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			     ,
+			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
+			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
+			     nid, K(node_page_state(pgdat, NR_FILE_PAGES)),
+			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
+			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
+			     nid, K(i.sharedram),
+			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
 #ifdef CONFIG_SHADOW_CALL_STACK
-		       nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
+			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
-		       nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
-		       nid, 0UL,
-		       nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
-		       nid, K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-		       nid, K(sreclaimable +
-			      node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE)),
-		       nid, K(sreclaimable + sunreclaimable),
-		       nid, K(sreclaimable),
-		       nid, K(sunreclaimable)
+			     nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
+			     nid, 0UL,
+			     nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
+			     nid, K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
+			     nid, K(sreclaimable +
+				    node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE)),
+			     nid, K(sreclaimable + sunreclaimable),
+			     nid, K(sreclaimable),
+			     nid, K(sunreclaimable)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		       ,
-		       nid, K(node_page_state(pgdat, NR_ANON_THPS) *
-				       HPAGE_PMD_NR),
-		       nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
-				       HPAGE_PMD_NR),
-		       nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
-				       HPAGE_PMD_NR),
-		       nid, K(node_page_state(pgdat, NR_FILE_THPS) *
-				       HPAGE_PMD_NR),
-		       nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
-				       HPAGE_PMD_NR)
+			     ,
+			     nid, K(node_page_state(pgdat, NR_ANON_THPS) *
+				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
+				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
+				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_FILE_THPS) *
+				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
+				    HPAGE_PMD_NR)
 #endif
-		       );
-	n += hugetlb_report_node_meminfo(nid, buf + n);
-	return n;
+			    );
+	len += hugetlb_report_node_meminfo(nid, buf + len);
+	return len;
 }
 
 #undef K
-static DEVICE_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
+static DEVICE_ATTR(meminfo, 0444, node_read_meminfo, NULL);
 
 static ssize_t node_read_numastat(struct device *dev,
-				struct device_attribute *attr, char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf,
 			  "numa_hit %lu\n"
@@ -491,7 +497,7 @@ static ssize_t node_read_numastat(struct device *dev,
 			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
 			  sum_zone_numa_state(dev->id, NUMA_OTHER));
 }
-static DEVICE_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
+static DEVICE_ATTR(numastat, 0444, node_read_numastat, NULL);
 
 static ssize_t node_read_vmstat(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -499,28 +505,31 @@ static ssize_t node_read_vmstat(struct device *dev,
 	int nid = dev->id;
 	struct pglist_data *pgdat = NODE_DATA(nid);
 	int i;
-	int n = 0;
+	int len = 0;
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n", zone_stat_name(i),
-			     sum_zone_node_page_state(nid, i));
+		len += sysfs_emit_at(buf, len, "%s %lu\n",
+				     zone_stat_name(i),
+				     sum_zone_node_page_state(nid, i));
 
 #ifdef CONFIG_NUMA
 	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n", numa_stat_name(i),
-			     sum_zone_numa_state(nid, i));
-#endif
+		len += sysfs_emit_at(buf, len, "%s %lu\n",
+				     numa_stat_name(i),
+				     sum_zone_numa_state(nid, i));
 
+#endif
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n", node_stat_name(i),
-			     node_page_state_pages(pgdat, i));
+		len += sysfs_emit_at(buf, len, "%s %lu\n",
+				     node_stat_name(i),
+				     node_page_state_pages(pgdat, i));
 
-	return n;
+	return len;
 }
-static DEVICE_ATTR(vmstat, S_IRUGO, node_read_vmstat, NULL);
+static DEVICE_ATTR(vmstat, 0444, node_read_vmstat, NULL);
 
 static ssize_t node_read_distance(struct device *dev,
-			struct device_attribute *attr, char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	int nid = dev->id;
 	int len = 0;
@@ -532,13 +541,15 @@ static ssize_t node_read_distance(struct device *dev,
 	 */
 	BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE);
 
-	for_each_online_node(i)
-		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));
+	for_each_online_node(i) {
+		len += sysfs_emit_at(buf, len, "%s%d",
+				     i ? " " : "", node_distance(nid, i));
+	}
 
-	len += sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
-static DEVICE_ATTR(distance, S_IRUGO, node_read_distance, NULL);
+static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_cpumap.attr,
@@ -979,17 +990,6 @@ void unregister_one_node(int nid)
  * node states attributes
  */
 
-static ssize_t print_nodes_state(enum node_states state, char *buf)
-{
-	int n;
-
-	n = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
-		      nodemask_pr_args(&node_states[state]));
-	buf[n++] = '\n';
-	buf[n] = '\0';
-	return n;
-}
-
 struct node_attr {
 	struct device_attribute attr;
 	enum node_states state;
@@ -999,7 +999,9 @@ static ssize_t show_node_state(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct node_attr *na = container_of(attr, struct node_attr, attr);
-	return print_nodes_state(na->state, buf);
+
+	return sysfs_emit(buf, "%*pbl\n",
+			  nodemask_pr_args(&node_states[na->state]));
 }
 
 #define _NODE_ATTR(name, state) \
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f0f8cfcc3621..88aef93eb4dd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1023,10 +1023,10 @@ EXPORT_SYMBOL_GPL(platform_unregister_drivers);
  * (b) sysfs attribute lets new-style coldplug recover from hotplug events
  *     mishandled before system is fully running:  "modprobe $(cat modalias)"
  */
-static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
-			     char *buf)
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	int len;
 
 	len = of_device_modalias(dev, buf, PAGE_SIZE);
@@ -1037,9 +1037,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	if (len != -ENODEV)
 		return len;
 
-	len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
-
-	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+	return sysfs_emit(buf, "platform:%s\n", pdev->name);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -1086,12 +1084,13 @@ static ssize_t driver_override_show(struct device *dev,
 	device_lock(dev);
 	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
+
 	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
 static ssize_t numa_node_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			      struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
 }
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index e05207abb99e..a1474fb67db9 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -122,66 +122,70 @@ static ssize_t control_store(struct device * dev, struct device_attribute *attr,
 static DEVICE_ATTR_RW(control);
 
 static ssize_t runtime_active_time_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
-	int ret;
 	u64 tmp = pm_runtime_active_time(dev);
+
 	do_div(tmp, NSEC_PER_MSEC);
-	ret = sysfs_emit(buf, "%llu\n", tmp);
-	return ret;
+
+	return sysfs_emit(buf, "%llu\n", tmp);
 }
 
 static DEVICE_ATTR_RO(runtime_active_time);
 
 static ssize_t runtime_suspended_time_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
-	int ret;
 	u64 tmp = pm_runtime_suspended_time(dev);
+
 	do_div(tmp, NSEC_PER_MSEC);
-	ret = sysfs_emit(buf, "%llu\n", tmp);
-	return ret;
+
+	return sysfs_emit(buf, "%llu\n", tmp);
 }
 
 static DEVICE_ATTR_RO(runtime_suspended_time);
 
 static ssize_t runtime_status_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+				   struct device_attribute *attr, char *buf)
 {
-	const char *p;
+	const char *output;
 
 	if (dev->power.runtime_error) {
-		p = "error\n";
+		output = "error";
 	} else if (dev->power.disable_depth) {
-		p = "unsupported\n";
+		output = "unsupported";
 	} else {
 		switch (dev->power.runtime_status) {
 		case RPM_SUSPENDED:
-			p = "suspended\n";
+			output = "suspended";
 			break;
 		case RPM_SUSPENDING:
-			p = "suspending\n";
+			output = "suspending";
 			break;
 		case RPM_RESUMING:
-			p = "resuming\n";
+			output = "resuming";
 			break;
 		case RPM_ACTIVE:
-			p = "active\n";
+			output = "active";
 			break;
 		default:
 			return -EIO;
 		}
 	}
-	return sysfs_emit(buf, p);
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static DEVICE_ATTR_RO(runtime_status);
 
 static ssize_t autosuspend_delay_ms_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	if (!dev->power.use_autosuspend)
 		return -EIO;
+
 	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay);
 }
 
@@ -345,7 +349,7 @@ static DEVICE_ATTR_RW(wakeup);
 static ssize_t wakeup_count_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	unsigned long count = 0;
+	unsigned long count;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -354,7 +358,10 @@ static ssize_t wakeup_count_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lu\n", count);
 }
 
 static DEVICE_ATTR_RO(wakeup_count);
@@ -363,7 +370,7 @@ static ssize_t wakeup_active_count_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	unsigned long count = 0;
+	unsigned long count;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -372,7 +379,10 @@ static ssize_t wakeup_active_count_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lu\n", count);
 }
 
 static DEVICE_ATTR_RO(wakeup_active_count);
@@ -381,7 +391,7 @@ static ssize_t wakeup_abort_count_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	unsigned long count = 0;
+	unsigned long count;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -390,7 +400,10 @@ static ssize_t wakeup_abort_count_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lu\n", count);
 }
 
 static DEVICE_ATTR_RO(wakeup_abort_count);
@@ -399,7 +412,7 @@ static ssize_t wakeup_expire_count_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	unsigned long count = 0;
+	unsigned long count;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -408,7 +421,10 @@ static ssize_t wakeup_expire_count_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lu\n", count);
 }
 
 static DEVICE_ATTR_RO(wakeup_expire_count);
@@ -416,7 +432,7 @@ static DEVICE_ATTR_RO(wakeup_expire_count);
 static ssize_t wakeup_active_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	unsigned int active = 0;
+	unsigned int active;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -425,7 +441,10 @@ static ssize_t wakeup_active_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%u\n", active) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%u\n", active);
 }
 
 static DEVICE_ATTR_RO(wakeup_active);
@@ -434,7 +453,7 @@ static ssize_t wakeup_total_time_ms_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	s64 msec = 0;
+	s64 msec;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -443,7 +462,10 @@ static ssize_t wakeup_total_time_ms_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lld\n", msec);
 }
 
 static DEVICE_ATTR_RO(wakeup_total_time_ms);
@@ -451,7 +473,7 @@ static DEVICE_ATTR_RO(wakeup_total_time_ms);
 static ssize_t wakeup_max_time_ms_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	s64 msec = 0;
+	s64 msec;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -460,7 +482,10 @@ static ssize_t wakeup_max_time_ms_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lld\n", msec);
 }
 
 static DEVICE_ATTR_RO(wakeup_max_time_ms);
@@ -469,7 +494,7 @@ static ssize_t wakeup_last_time_ms_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	s64 msec = 0;
+	s64 msec;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -478,7 +503,10 @@ static ssize_t wakeup_last_time_ms_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lld\n", msec);
 }
 
 static inline int dpm_sysfs_wakeup_change_owner(struct device *dev, kuid_t kuid,
@@ -496,7 +524,7 @@ static ssize_t wakeup_prevent_sleep_time_ms_show(struct device *dev,
 						 struct device_attribute *attr,
 						 char *buf)
 {
-	s64 msec = 0;
+	s64 msec;
 	bool enabled = false;
 
 	spin_lock_irq(&dev->power.lock);
@@ -505,7 +533,10 @@ static ssize_t wakeup_prevent_sleep_time_ms_show(struct device *dev,
 		enabled = true;
 	}
 	spin_unlock_irq(&dev->power.lock);
-	return enabled ? sprintf(buf, "%lld\n", msec) : sprintf(buf, "\n");
+
+	if (!enabled)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%lld\n", msec);
 }
 
 static DEVICE_ATTR_RO(wakeup_prevent_sleep_time_ms);
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 5568e25d7c9c..d638259b829a 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -26,7 +26,7 @@ static ssize_t _name##_show(struct device *dev,				\
 {									\
 	struct wakeup_source *ws = dev_get_drvdata(dev);		\
 									\
-	return sprintf(buf, "%lu\n", ws->_name);			\
+	return sysfs_emit(buf, "%lu\n", ws->_name);			\
 }									\
 static DEVICE_ATTR_RO(_name)
 
@@ -57,6 +57,7 @@ static ssize_t total_time_ms_show(struct device *dev,
 		active_time = ktime_sub(ktime_get(), ws->last_time);
 		total_time = ktime_add(total_time, active_time);
 	}
+
 	return sysfs_emit(buf, "%lld\n", ktime_to_ms(total_time));
 }
 static DEVICE_ATTR_RO(total_time_ms);
@@ -73,6 +74,7 @@ static ssize_t max_time_ms_show(struct device *dev,
 		if (active_time > max_time)
 			max_time = active_time;
 	}
+
 	return sysfs_emit(buf, "%lld\n", ktime_to_ms(max_time));
 }
 static DEVICE_ATTR_RO(max_time_ms);
@@ -106,6 +108,7 @@ static ssize_t prevent_suspend_time_ms_show(struct device *dev,
 		prevent_sleep_time = ktime_add(prevent_sleep_time,
 			ktime_sub(ktime_get(), ws->start_prevent_time));
 	}
+
 	return sysfs_emit(buf, "%lld\n", ktime_to_ms(prevent_sleep_time));
 }
 static DEVICE_ATTR_RO(prevent_suspend_time_ms);
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index fc6536a7eac6..d34609bb7386 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -17,9 +17,9 @@
 
 static DEFINE_IDA(soc_ida);
 
-static ssize_t soc_info_get(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf);
+/* Prototype to allow declarations of DEVICE_ATTR(<foo>) before soc_info_show */
+static ssize_t soc_info_show(struct device *dev, struct device_attribute *attr,
+			     char *buf);
 
 struct soc_device {
 	struct device dev;
@@ -31,11 +31,11 @@ static struct bus_type soc_bus_type = {
 	.name  = "soc",
 };
 
-static DEVICE_ATTR(machine,  S_IRUGO, soc_info_get,  NULL);
-static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
-static DEVICE_ATTR(serial_number, S_IRUGO, soc_info_get,  NULL);
-static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
-static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(machine,		0444, soc_info_show,  NULL);
+static DEVICE_ATTR(family,		0444, soc_info_show,  NULL);
+static DEVICE_ATTR(serial_number,	0444, soc_info_show,  NULL);
+static DEVICE_ATTR(soc_id,		0444, soc_info_show,  NULL);
+static DEVICE_ATTR(revision,		0444, soc_info_show,  NULL);
 
 struct device *soc_device_to_device(struct soc_device *soc_dev)
 {
@@ -49,45 +49,41 @@ static umode_t soc_attribute_mode(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
-	if ((attr == &dev_attr_machine.attr)
-	    && (soc_dev->attr->machine != NULL))
+	if ((attr == &dev_attr_machine.attr) && soc_dev->attr->machine)
 		return attr->mode;
-	if ((attr == &dev_attr_family.attr)
-	    && (soc_dev->attr->family != NULL))
+	if ((attr == &dev_attr_family.attr) && soc_dev->attr->family)
 		return attr->mode;
-	if ((attr == &dev_attr_revision.attr)
-	    && (soc_dev->attr->revision != NULL))
+	if ((attr == &dev_attr_revision.attr) && soc_dev->attr->revision)
 		return attr->mode;
-	if ((attr == &dev_attr_serial_number.attr)
-	    && (soc_dev->attr->serial_number != NULL))
+	if ((attr == &dev_attr_serial_number.attr) && soc_dev->attr->serial_number)
 		return attr->mode;
-	if ((attr == &dev_attr_soc_id.attr)
-	    && (soc_dev->attr->soc_id != NULL))
+	if ((attr == &dev_attr_soc_id.attr) && soc_dev->attr->soc_id)
 		return attr->mode;
 
-	/* Unknown or unfilled attribute. */
+	/* Unknown or unfilled attribute */
 	return 0;
 }
 
-static ssize_t soc_info_get(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+static ssize_t soc_info_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+	const char *output;
 
 	if (attr == &dev_attr_machine)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->machine);
-	if (attr == &dev_attr_family)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->family);
-	if (attr == &dev_attr_revision)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->revision);
-	if (attr == &dev_attr_serial_number)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->serial_number);
-	if (attr == &dev_attr_soc_id)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->soc_id);
-
-	return -EINVAL;
-
+		output = soc_dev->attr->machine;
+	else if (attr == &dev_attr_family)
+		output = soc_dev->attr->family;
+	else if (attr == &dev_attr_revision)
+		output = soc_dev->attr->revision;
+	else if (attr == &dev_attr_serial_number)
+		output = soc_dev->attr->serial_number;
+	else if (attr == &dev_attr_soc_id)
+		output = soc_dev->attr->soc_id;
+	else
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static struct attribute *soc_attr[] = {
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index ad8d33c6077b..4d254fcc93d1 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -14,11 +14,11 @@
 #include <linux/hardirq.h>
 #include <linux/topology.h>
 
-#define define_id_show_func(name)				\
-static ssize_t name##_show(struct device *dev,			\
-		struct device_attribute *attr, char *buf)	\
-{								\
-	return sprintf(buf, "%d\n", topology_##name(dev->id));	\
+#define define_id_show_func(name)					\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return sysfs_emit(buf, "%d\n", topology_##name(dev->id));	\
 }
 
 #define define_siblings_show_map(name, mask)				\
-- 
2.26.0

