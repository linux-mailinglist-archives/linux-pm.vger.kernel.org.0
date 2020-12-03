Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DE2CDCE2
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 18:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgLCR6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 12:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgLCR6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 12:58:45 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09845C061A4E;
        Thu,  3 Dec 2020 09:58:05 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id dk8so175059edb.1;
        Thu, 03 Dec 2020 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DvpVnTdDjJ8kSW6ZFCr0AzlAkfpDl4O8s1SsO6Ne4E0=;
        b=LiPuX50v+iGvL7Fju08esmQmzJxH6nhPxC39sWDAJ60kOESin2C1AYZX42xcFTItJJ
         lvNb2ADxPNfT0TswVKoumY6QAzx4k5RUPWz5aU32v6QNBEJBhJmrLn5Z/1MOOdep8V0Y
         sh85wH+QYeaoAWTDZQ2J2oje+yE81tENSn20n/inUEWxlxairLyVYWbBz60sj2FMbPWD
         KRQY9QpPmRfC7H2FEpnts4qRtD9ijn16z+2FWgcaHn3V0yQ+imgMetVGFbe/IrwM1AWs
         k7aH2dLHNKB7aY4XnrOThQYwGOv0oNkZxy6IhlT0tVMOun9jNpY2/LiiicY7knNvAXdF
         VLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DvpVnTdDjJ8kSW6ZFCr0AzlAkfpDl4O8s1SsO6Ne4E0=;
        b=likKucYWmV6IcQBYM2mOIe/vonVEBFTi0mOvNGXs/sCV+io2q+QCdg+UYhzXsGtOmY
         zMPtJWkPknjnWq+NBvqQOeW0qIiM5GwmOl35oe1Olfna4So1vs/RDDiMb7Baaj6CHtFB
         mM8EqDzPKr80U97xqDXtEgJJCF781UWwbZ0eN3JhwZc5we5oibzpn/UvhPhVbyzsHWH6
         H7lFgC35NqDOl4CY/HX8wGV+tmy9eKIxm7WlN/HY5XAtgxxv0kIBRElMBQYaKFX8RLgO
         zbsGBlTFs4jrLPTONXYV+LiWhSWrWP9LIatYSMbFZBv9nA4z1ex/Uj1sdbm5bHxPVycB
         mOfg==
X-Gm-Message-State: AOAM530bi4TIAgU2FXyjne0cfwJRX+k+/2BkeNStMSNAhNltn9ReuWgI
        yQc8PPcMjeq0FdZ+Ifyv2nhAnaBz8a4=
X-Google-Smtp-Source: ABdhPJxXcjg9JUpreY4/5trqmtMta8r+XrI2+64/cNG5PnZ4avKMungowzM3jRb7DxfGw7zsl3vulQ==
X-Received: by 2002:a50:d886:: with SMTP id p6mr4084989edj.366.1607018283609;
        Thu, 03 Dec 2020 09:58:03 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r9sm1697954edx.82.2020.12.03.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 09:58:02 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH] driver core: Reorder devices on successful probe
Date:   Thu,  3 Dec 2020 18:57:56 +0100
Message-Id: <20201203175756.1405564-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Device drivers usually depend on the fact that the devices that they
control are suspended in the same order that they were probed in. In
most cases this is already guaranteed via deferred probe.

However, there's one case where this can still break: if a device is
instantiated before a dependency (for example if it appears before the
dependency in device tree) but gets probed only after the dependency is
probed. Instantiation order would cause the dependency to get probed
later, in which case probe of the original device would be deferred and
the suspend/resume queue would get reordered properly. However, if the
dependency is provided by a built-in driver and the device depending on
that driver is controlled by a loadable module, which may only get
loaded after the root filesystem has become available, we can be faced
with a situation where the probe order ends up being different from the
suspend/resume order.

One example where this happens is on Tegra186, where the ACONNECT is
listed very early in device tree (sorted by unit-address) and depends on
BPMP (listed very late because it has no unit-address) for power domains
and clocks/resets. If the ACONNECT driver is built-in, there is no
problem because it will be probed before BPMP, causing a probe deferral
and that in turn reorders the suspend/resume queue. However, if built as
a module, it will end up being probed after BPMP, and therefore not
result in a probe deferral, and therefore the suspend/resume queue will
stay in the instantiation order. This in turn causes problems because
ACONNECT will be resumed before BPMP, which will result in a hang
because the ACONNECT's power domain cannot be powered on as long as the
BPMP is still suspended.

Fix this by always reordering devices on successful probe. This ensures
that the suspend/resume queue is always in probe order and hence meets
the natural expectations of drivers vs. their dependencies.

Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/dd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 148e81969e04..cfc079e738bb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -370,6 +370,13 @@ static void driver_bound(struct device *dev)
 
 	device_pm_check_callbacks(dev);
 
+	/*
+	 * Reorder successfully probed devices to the end of the device list.
+	 * This ensures that suspend/resume order matches probe order, which
+	 * is usually what drivers rely on.
+	 */
+	device_pm_move_to_tail(dev);
+
 	/*
 	 * Make sure the device is no longer in one of the deferred lists and
 	 * kick off retrying all pending devices
-- 
2.29.2

