Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C455976CCA0
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHBM1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Aug 2023 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjHBM1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 08:27:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BE269E
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 05:27:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46DBD68AA6; Wed,  2 Aug 2023 14:27:12 +0200 (CEST)
Date:   Wed, 2 Aug 2023 14:27:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: Re: [PATCH 0/3] nvme-core: restructure nvme_init_ctrl()
Message-ID: <20230802122711.GA30792@lst.de>
References: <20230802032629.24309-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802032629.24309-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 01, 2023 at 08:26:26PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> Restructure nvme_init_ctrl() for better initialization flow.
> 
> Currenlty nvme_init_ctrl() initialized nvme authentication, fault
> injection, and device PM QoS after adding the controller device with
> a call to cdev_device_add(). This has led to additional code complexity,
> as it required handling the unwinding of these initializations if any
> of them failed.

The current code is in fact also broken, as after device_add
(which cdev_device_add does underneath) fails we can't just cleaup, but
most call put_device.  I think this single patch is what we should be
doing, but I don't fell fully confindent in it without some extra
error injection:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47d7ba2827ff29..5da55a271a5ab0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4405,14 +4405,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
 	ctrl->discard_page = alloc_page(GFP_KERNEL);
-	if (!ctrl->discard_page) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!ctrl->discard_page)
+		return -ENOMEM;
 
 	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto out;
+		goto out_free_discard_page;
 	ctrl->instance = ret;
 
 	device_initialize(&ctrl->ctrl_device);
@@ -4431,13 +4429,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
-	nvme_get_ctrl(ctrl);
-	cdev_init(&ctrl->cdev, &nvme_dev_fops);
-	ctrl->cdev.owner = ops->module;
-	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
-	if (ret)
-		goto out_free_name;
-
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
 	 * be visible to userspace unless the device actually supports APST.
@@ -4448,23 +4439,27 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
+
 	ret = nvme_auth_init_ctrl(ctrl);
 	if (ret)
-		goto out_free_cdev;
+		goto out_fault_inject_fini;
 
-	return 0;
-out_free_cdev:
+	nvme_get_ctrl(ctrl);
+	cdev_init(&ctrl->cdev, &nvme_dev_fops);
+	ctrl->cdev.owner = ops->module;
+	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
+	if (ret)
+		put_device(ctrl->device);
+	return ret;
+
+out_fault_inject_fini:
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	cdev_device_del(&ctrl->cdev, ctrl->device);
-out_free_name:
-	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
-out:
-	if (ctrl->discard_page)
-		__free_page(ctrl->discard_page);
+out_free_discard_page:
+	__free_page(ctrl->discard_page);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
