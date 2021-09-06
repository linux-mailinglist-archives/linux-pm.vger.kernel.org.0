Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B7401832
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhIFIsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 04:48:00 -0400
Received: from foss.arm.com ([217.140.110.172]:53586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241013AbhIFIqM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Sep 2021 04:46:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 753A11063;
        Mon,  6 Sep 2021 01:45:07 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.18.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD3863F73D;
        Mon,  6 Sep 2021 01:45:05 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, qperret@google.com,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        vincent.donnefort@arm.com
Subject: [PATCH 2/2] Documentation: power: include kernel-doc in Energy Model doc
Date:   Mon,  6 Sep 2021 09:44:53 +0100
Message-Id: <20210906084453.3068-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210906084453.3068-1-lukasz.luba@arm.com>
References: <20210906084453.3068-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Improve the existing documentation of the Energy Model and add kernel-doc
comments. This extends an API description and helps better understanding
the usage.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 60ac091d3b0d..8a2788afe89b 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -101,8 +101,7 @@ subsystems which use EM might rely on this flag to check if all EM devices use
 the same scale. If there are different scales, these subsystems might decide
 to: return warning/error, stop working or panic.
 See Section 3. for an example of driver implementing this
-callback, and kernel/power/energy_model.c for further documentation on this
-API.
+callback, or Section 2.4 for further documentation on this API
 
 
 2.3 Accessing performance domains
@@ -123,7 +122,17 @@ em_cpu_energy() API. The estimation is performed assuming that the schedutil
 CPUfreq governor is in use in case of CPU device. Currently this calculation is
 not provided for other type of devices.
 
-More details about the above APIs can be found in include/linux/energy_model.h.
+More details about the above APIs can be found in ``<linux/energy_model.h>``
+or in Section 2.4
+
+
+2.4 Description details of this API
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+.. kernel-doc:: include/linux/energy_model.h
+   :internal:
+
+.. kernel-doc:: kernel/power/energy_model.c
+   :export:
 
 
 3. Example driver
-- 
2.17.1

