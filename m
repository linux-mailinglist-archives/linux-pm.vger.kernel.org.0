Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A59254D3
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfEUQEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 12:04:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41715 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQEp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 12:04:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so8807063pgp.8
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2019 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=il/JXoP4aW4WFFHOxr0Tpp4Ev1osrOA1IE5f6L08DkI=;
        b=vcQdl09QHQy5NCYrsBFsiiAUnQpK6sJjCqv3YPoyJcfJnHY6edGZLWqmsdMWoE5qpC
         FUtKaDv9Qm3MYF+cwwS2rQUr3eEzqSZCSalIBV/qrebvVtSiwpRL5G+WrxJ9SyGMGeT2
         LEXiDMuzONxJ1irNpO+YU/6RsdTtjrFTwvD4p0gUKWZXIB3+C2UzPELQNvmguuxVIhKS
         PEEq1+gxJP/kAPD8sOPPT2FptzjD8+vR9pwo7x2HU0nnVui6gedrIZR3FiekjYJ6XFUR
         zYGHyGFS1Y7JAdD8BcuyU0Vj8RKoaP9iWAk6vCX6Hn9/54J6VY7mUZ5rYKFjzHIyKkWr
         D7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=il/JXoP4aW4WFFHOxr0Tpp4Ev1osrOA1IE5f6L08DkI=;
        b=XiCkg65EKmvYy34iPCV7PjnubASzzomhApXWSpt1kSQjzfzzO2HlRydzo60l1O/va3
         z16AZrCxO1KFUxbbEvvWXgKrGxCf+TVSTtN3bkAPQ8WGmV8nDhV7AHtp4YJIN4iTL+SA
         9/0HAimrMbvuLcsA86YZhE9O7Z6K0rOtmlt1oRgPNF6sQ88xKt7J7VsS3/iwK2GFQkY5
         eRV7dWnDLlw3yvZXyUjkKfVNC60HfTsMuMu/bHq+88ww3Y3CU7PWxwBVOUTGRJ3PITHW
         xGD77KhJzLRb3OrBu8+lkAP0Q+lvBuk/HFgyPfTwTdM7Uj7p4oywi+HlILAZnbXf63As
         3C1Q==
X-Gm-Message-State: APjAAAWZPhr6dCuLfQiXIBNIQe1UVDb08tOK8Xa43KCdAAc673zbT1Mt
        kcoqmapignZhDbn7hwHXeq8=
X-Google-Smtp-Source: APXvYqwX1tzSTRG+WCXtNpV2F+N566SicxZ0ovg2pY8O3qxjQzcztQeDDyBKAexFfbKzwzd7zWXzlA==
X-Received: by 2002:a63:ee0a:: with SMTP id e10mr69278554pgi.28.1558454684956;
        Tue, 21 May 2019 09:04:44 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:9cd0:73e8:b74a:624e])
        by smtp.gmail.com with ESMTPSA id j5sm28954786pfa.15.2019.05.21.09.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 09:04:44 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2 4/4] nvme-pci: support thermal zone
Date:   Wed, 22 May 2019 01:04:09 +0900
Message-Id: <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables to use thermal zone interfaces for NVMe
temperature sensors.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- Call nvme_thermal_zones_unregister() earlier than the last reference
  release

 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 04084b9..108b022 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2555,6 +2555,10 @@ static void nvme_reset_work(struct work_struct *work)
 		dev->ctrl.opal_dev = NULL;
 	}
 
+	result = nvme_thermal_zones_register(&dev->ctrl);
+	if (result < 0)
+		goto out;
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
 		result = nvme_dbbuf_dma_alloc(dev);
 		if (result)
@@ -2833,6 +2837,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
+	nvme_thermal_zones_unregister(&dev->ctrl);
 	nvme_dev_disable(dev, true, false);
 	nvme_release_cmb(dev);
 	nvme_free_host_mem(dev);
-- 
2.7.4

