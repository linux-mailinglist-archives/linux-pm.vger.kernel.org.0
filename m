Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D417239D6
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjFFHmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jun 2023 03:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjFFHlo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2023 03:41:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B345172D;
        Tue,  6 Jun 2023 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GRb2siPC1DZT81TbqsVYwuRj0OU14yvBnzPJAp5ualo=; b=Tae/SEkuVda0iNXdzFxAviNULS
        XWidhkWLSqw/tDa8djf+uWGy1QXd6U5gnkCHO1g/9X+rpreA2LUXtYGBjY5xQvDb1s7SNYd5JlOtK
        Fkv57oX7Yp6U4VCJTCkQgO1GVCRtB7cJnbvIA7afHSTFa3ywXkflQCV307hCn2PZvudWdMDFV+lz6
        YIbdt2aetZtD/etWSKn9PyumbmB47K4TL8OxetIFQKuoI5RlMi+uGHDF6650diUELOh9sNPMTPLCb
        7XK7Kuh/tdtzvzwgVi6qj4eMuydoYLRk2+N5mvAlEiQq5FZohGUvGKv7o9lwcbc0aEw9sl9mrgoVU
        7+Bj9oIQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RJ4-000ZMJ-0X;
        Tue, 06 Jun 2023 07:40:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 15/31] btrfs: don't pass a holder for non-exclusive blkdev_get_by_path
Date:   Tue,  6 Jun 2023 09:39:34 +0200
Message-Id: <20230606073950.225178-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Passing a holder to blkdev_get_by_path when FMODE_EXCL isn't set doesn't
make sense, so pass NULL instead and remove the holder argument from the
call chains the only end up in non-FMODE_EXCL blkdev_get_by_path calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c   | 16 ++++++----------
 fs/btrfs/volumes.c | 17 ++++++++---------
 fs/btrfs/volumes.h |  3 +--
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ec18e22106023b..1a2ee9407f5414 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -849,8 +849,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(const char *options, fmode_t flags,
-				      void *holder)
+static int btrfs_parse_device_options(const char *options, fmode_t flags)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *device_name, *opts, *orig, *p;
@@ -884,8 +883,7 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
 				error = -ENOMEM;
 				goto out;
 			}
-			device = btrfs_scan_one_device(device_name, flags,
-					holder);
+			device = btrfs_scan_one_device(device_name, flags);
 			kfree(device_name);
 			if (IS_ERR(device)) {
 				error = PTR_ERR(device);
@@ -1477,13 +1475,13 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode, fs_type);
+	error = btrfs_parse_device_options(data, mode);
 	if (error) {
 		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
 	}
 
-	device = btrfs_scan_one_device(device_name, mode, fs_type);
+	device = btrfs_scan_one_device(device_name, mode);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
 		error = PTR_ERR(device);
@@ -2190,8 +2188,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, FMODE_READ,
-					       &btrfs_root_fs_type);
+		device = btrfs_scan_one_device(vol->name, FMODE_READ);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2205,8 +2202,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, FMODE_READ,
-					       &btrfs_root_fs_type);
+		device = btrfs_scan_one_device(vol->name, FMODE_READ);
 		if (IS_ERR(device)) {
 			mutex_unlock(&uuid_mutex);
 			ret = PTR_ERR(device);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 784ccc8f6c69c1..035868cee3ddc3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1348,8 +1348,7 @@ int btrfs_forget_devices(dev_t devt)
  * and we are not allowed to call set_blocksize during the scan. The superblock
  * is read via pagecache
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
-					   void *holder)
+struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags)
 {
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
@@ -1368,16 +1367,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	 */
 
 	/*
-	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
-	 * initiate the device scan which may race with the user's mount
-	 * or mkfs command, resulting in failure.
-	 * Since the device scan is solely for reading purposes, there is
-	 * no need for FMODE_EXCL. Additionally, the devices are read again
+	 * Avoid an exclusive open here, as the systemd-udev may initiate the
+	 * device scan which may race with the user's mount or mkfs command,
+	 * resulting in failure.
+	 * Since the device scan is solely for reading purposes, there is no
+	 * need for an exclusive open. Additionally, the devices are read again
 	 * during the mount process. It is ok to get some inconsistent
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev = blkdev_get_by_path(path, flags, holder, NULL);
+	bdev = blkdev_get_by_path(path, flags, NULL, NULL);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
@@ -2381,7 +2380,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 	}
 
-	ret = btrfs_get_bdev_and_sb(path, FMODE_READ, fs_info->bdev_holder, 0,
+	ret = btrfs_get_bdev_and_sb(path, FMODE_READ, NULL, 0,
 				    &bdev, &disk_super);
 	if (ret) {
 		btrfs_put_dev_args_from_path(args);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf47a1a70813ba..eb97a397b3c3fb 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -600,8 +600,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path,
-					   fmode_t flags, void *holder);
+struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
-- 
2.39.2

