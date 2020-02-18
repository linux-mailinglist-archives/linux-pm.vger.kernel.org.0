Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA7162A99
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 17:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRQaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 11:30:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57204 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgBRQaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 11:30:09 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j45l7-0003h0-Pm; Tue, 18 Feb 2020 16:30:05 +0000
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
Subject: [PATCH net-next v3 2/9] sysfs: add sysfs_link_change_owner()
Date:   Tue, 18 Feb 2020 17:29:36 +0100
Message-Id: <20200218162943.2488012-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218162943.2488012-1-christian.brauner@ubuntu.com>
References: <20200218162943.2488012-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a helper to change the owner of a sysfs link.
This function will be used to correctly account for kobject ownership
changes, e.g. when moving network devices between network namespaces.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
-  Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
   - Add comment how ownership of sysfs object is changed.

/* v3 */
-  Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
   - Add explicit uid/gid parameters.
---
 fs/sysfs/file.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/sysfs.h | 10 ++++++++++
 2 files changed, 50 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 32bb04b4d9d9..df5107d7b3fd 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -570,6 +570,46 @@ static int internal_change_owner(struct kernfs_node *kn, struct kobject *kobj,
 	return kernfs_setattr(kn, &newattrs);
 }
 
+/**
+ *	sysfs_link_change_owner - change owner of a link.
+ *	@kobj:	object of the kernfs_node the symlink is located in.
+ *	@targ:	object of the kernfs_node the symlink points to.
+ *	@name:	name of the link.
+ *	@kuid:	new owner's kuid
+ *	@kgid:	new owner's kgid
+ */
+int sysfs_link_change_owner(struct kobject *kobj, struct kobject *targ,
+			    const char *name, kuid_t kuid, kgid_t kgid)
+{
+	struct kernfs_node *parent, *kn = NULL;
+	int error;
+
+	if (!kobj)
+		parent = sysfs_root_kn;
+	else
+		parent = kobj->sd;
+
+	if (!targ->state_in_sysfs)
+		return -EINVAL;
+
+	error = -ENOENT;
+	kn = kernfs_find_and_get_ns(parent, name, targ->sd->ns);
+	if (!kn)
+		goto out;
+
+	error = -EINVAL;
+	if (kernfs_type(kn) != KERNFS_LINK)
+		goto out;
+	if (kn->symlink.target_kn->priv != targ)
+		goto out;
+
+	error = internal_change_owner(kn, targ, kuid, kgid);
+
+out:
+	kernfs_put(kn);
+	return error;
+}
+
 /**
  *	sysfs_file_change_owner_by_name - change owner of a file.
  *	@kobj:	object.
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c11d11c78713..899500950410 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -313,6 +313,8 @@ static inline void sysfs_enable_ns(struct kernfs_node *kn)
 int sysfs_file_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid);
 int sysfs_file_change_owner_by_name(struct kobject *kobj, const char *name,
 				    kuid_t kuid, kgid_t kgid);
+int sysfs_link_change_owner(struct kobject *kobj, struct kobject *targ,
+			    const char *name, kuid_t kuid, kgid_t kgid);
 
 #else /* CONFIG_SYSFS */
 
@@ -539,6 +541,14 @@ static inline int sysfs_file_change_owner_by_name(struct kobject *kobj,
 	return 0;
 }
 
+static inline int sysfs_link_change_owner(struct kobject *kobj,
+					  struct kobject *targ,
+					  const char *name, kuid_t kuid,
+					  kgid_t kgid)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SYSFS */
 
 static inline int __must_check sysfs_create_file(struct kobject *kobj,
-- 
2.25.0

