Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A10170F24
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 04:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgB0Dj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 22:39:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40152 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgB0Djz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 22:39:55 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7A1h-00030x-7A; Thu, 27 Feb 2020 03:39:53 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-pm@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v7 3/9] sysfs: add sysfs_group{s}_change_owner()
Date:   Thu, 27 Feb 2020 04:37:13 +0100
Message-Id: <20200227033719.1652190-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227033719.1652190-1-christian.brauner@ubuntu.com>
References: <20200227033719.1652190-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add helpers to change the owner of sysfs groups.
This function will be used to correctly account for kobject ownership
changes, e.g. when moving network devices between network namespaces.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
-  Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
   - Add comment how ownership of sysfs object is changed.

/* v3 */
-  Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
   - Add explicit uid/gid parameters.
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Collapse groups ownership helper patches into a single patch.

/* v4 */
unchanged

/* v5 */
unchanged

/* v6 */
unchanged

/* v7 */
- David Miller <davem@davemloft.net>:
  - Fix two build warnings.
---
 fs/sysfs/group.c      | 115 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/sysfs.h |  20 ++++++++
 2 files changed, 135 insertions(+)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index c4ab045926b7..5afe0e7ff7cd 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -13,6 +13,7 @@
 #include <linux/dcache.h>
 #include <linux/namei.h>
 #include <linux/err.h>
+#include <linux/fs.h>
 #include "sysfs.h"
 
 
@@ -457,3 +458,117 @@ int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 	return PTR_ERR_OR_ZERO(link);
 }
 EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
+
+static int sysfs_group_attrs_change_owner(struct kernfs_node *grp_kn,
+					  const struct attribute_group *grp,
+					  struct iattr *newattrs)
+{
+	struct kernfs_node *kn;
+	int error;
+
+	if (grp->attrs) {
+		struct attribute *const *attr;
+
+		for (attr = grp->attrs; *attr; attr++) {
+			kn = kernfs_find_and_get(grp_kn, (*attr)->name);
+			if (!kn)
+				return -ENOENT;
+
+			error = kernfs_setattr(kn, newattrs);
+			kernfs_put(kn);
+			if (error)
+				return error;
+		}
+	}
+
+	if (grp->bin_attrs) {
+		struct bin_attribute *const *bin_attr;
+
+		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
+			kn = kernfs_find_and_get(grp_kn, (*bin_attr)->attr.name);
+			if (!kn)
+				return -ENOENT;
+
+			error = kernfs_setattr(kn, newattrs);
+			kernfs_put(kn);
+			if (error)
+				return error;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * sysfs_group_change_owner - change owner of an attribute group.
+ * @kobj:	The kobject containing the group.
+ * @grp:	The attribute group.
+ * @kuid:	new owner's kuid
+ * @kgid:	new owner's kgid
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int sysfs_group_change_owner(struct kobject *kobj,
+			     const struct attribute_group *grp, kuid_t kuid,
+			     kgid_t kgid)
+{
+	struct kernfs_node *grp_kn;
+	int error;
+	struct iattr newattrs = {
+		.ia_valid = ATTR_UID | ATTR_GID,
+		.ia_uid = kuid,
+		.ia_gid = kgid,
+	};
+
+	if (!kobj->state_in_sysfs)
+		return -EINVAL;
+
+	if (grp->name) {
+		grp_kn = kernfs_find_and_get(kobj->sd, grp->name);
+	} else {
+		kernfs_get(kobj->sd);
+		grp_kn = kobj->sd;
+	}
+	if (!grp_kn)
+		return -ENOENT;
+
+	error = kernfs_setattr(grp_kn, &newattrs);
+	if (!error)
+		error = sysfs_group_attrs_change_owner(grp_kn, grp, &newattrs);
+
+	kernfs_put(grp_kn);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(sysfs_group_change_owner);
+
+/**
+ * sysfs_groups_change_owner - change owner of a set of attribute groups.
+ * @kobj:	The kobject containing the groups.
+ * @groups:	The attribute groups.
+ * @kuid:	new owner's kuid
+ * @kgid:	new owner's kgid
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int sysfs_groups_change_owner(struct kobject *kobj,
+			      const struct attribute_group **groups,
+			      kuid_t kuid, kgid_t kgid)
+{
+	int error = 0, i;
+
+	if (!kobj->state_in_sysfs)
+		return -EINVAL;
+
+	if (!groups)
+		return 0;
+
+	for (i = 0; groups[i]; i++) {
+		error = sysfs_group_change_owner(kobj, groups[i], kuid, kgid);
+		if (error)
+			break;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(sysfs_groups_change_owner);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 7e15ebfd750e..3fcaabdb05ef 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -314,6 +314,12 @@ int sysfs_file_change_owner(struct kobject *kobj, const char *name, kuid_t kuid,
 			    kgid_t kgid);
 int sysfs_link_change_owner(struct kobject *kobj, struct kobject *targ,
 			    const char *name, kuid_t kuid, kgid_t kgid);
+int sysfs_groups_change_owner(struct kobject *kobj,
+			      const struct attribute_group **groups,
+			      kuid_t kuid, kgid_t kgid);
+int sysfs_group_change_owner(struct kobject *kobj,
+			     const struct attribute_group *groups, kuid_t kuid,
+			     kgid_t kgid);
 
 #else /* CONFIG_SYSFS */
 
@@ -542,6 +548,20 @@ static inline int sysfs_link_change_owner(struct kobject *kobj,
 	return 0;
 }
 
+static inline int sysfs_groups_change_owner(struct kobject *kobj,
+			  const struct attribute_group **groups,
+			  kuid_t kuid, kgid_t kgid)
+{
+	return 0;
+}
+
+static inline int sysfs_group_change_owner(struct kobject *kobj,
+			 const struct attribute_group **groups,
+			 kuid_t kuid, kgid_t kgid)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SYSFS */
 
 static inline int __must_check sysfs_create_file(struct kobject *kobj,
-- 
2.25.1

