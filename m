Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4115D2CAC58
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 20:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgLAT3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 14:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLAT3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 14:29:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B1C0613CF
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 11:28:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o1so4488182wrx.7
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FCStDhY/rSQSKI6thsjMCNv1pIeQvLh2oYwBPkXbYRI=;
        b=p475lvEAOuXjjZ6iPQxjZacrmz1xwNajcTsNjJn6SKugh+I4eRMxk0zQgO9JLRCyxM
         S0CHI5/7pteeEef/Llu9ITAe2TYmtOKLTIdRFw5M9c1A/4ClkiiQEZpwbF7D/JfrK9Rw
         iv/TwN7/dWbyrx8eThNFX8io5gKhbRg9myrnfE6FhlYLIj1Q5GZZvkrBv7d3PEbAHx8B
         oejVpfc3qqMgbURR0XBubNdqGZ/zAfTt/DDo9eCsyVNajzgn8j5pNxsGR/ldUNwGnRz+
         OmCfTzMNsi1C/T5iPkX3lFStDJ0zT6888/3hUeqFLkp9SB1Vf6k7OryPJtUaCEuv5Y4O
         2otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FCStDhY/rSQSKI6thsjMCNv1pIeQvLh2oYwBPkXbYRI=;
        b=aKmsWjsgjP9Q71/9X9VnwA+A8XxXC9Oo7knAX+xtw4EKn2XMZhPZ7C2y1RFghmy67y
         kxCFfe4WLfssT5/o8H/MannX8hXX0yjczd9+Tn6KzuQzFMJ8O73EbTYoJGkN2oWsDXyr
         Xcpz+JwZwgxpci2WiU0dmI/Se7LJUX0EA9itc+/MMZ+7plWYB17Y0fYByeOiY6h7ZH6T
         QyVq5fgy9SiV1LMTUQXBwWYP63XWM6trmyZfi22KjDPr2DrLmPBiWLve0sd1rUjCj1Iy
         uUgUFYiSydYcz1TMt4CVbN7ZM7YWynZAvztSkq3VFEWhPFCxyKEoF8LHXh+uEUStWg2K
         HKOQ==
X-Gm-Message-State: AOAM5320nclfMGKlYnlh4wEyWlw0b+Do89b5FzicpU0QvWIQbl4GtSBh
        oFlszAGvBXVEu6BRODodDfv9Ow==
X-Google-Smtp-Source: ABdhPJyGDKJh8efZLK6B0RU46R2GphsOw2HHAK5VBP4DmUddULV0td71htU9DUWZI1bV/WNcxyUiuQ==
X-Received: by 2002:a5d:604f:: with SMTP id j15mr5754895wrt.47.1606850932644;
        Tue, 01 Dec 2020 11:28:52 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id n123sm1317922wmn.7.2020.12.01.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:28:51 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v4 2/4] Documentation/powercap/dtpm: Add documentation for dtpm
Date:   Tue,  1 Dec 2020 20:27:59 +0100
Message-Id: <20201201192801.27607-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201192801.27607-1-daniel.lezcano@linaro.org>
References: <20201201192801.27607-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dynamic thermal and power management is a technique to dynamically
adjust the power consumption of different devices in order to ensure a
global thermal constraint.

An userspace daemon is usually monitoring the temperature and the
power to take immediate action on the device.

The DTPM framework provides an unified API to userspace to act on the
power.

Document this framework.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/power/index.rst         |   1 +
 Documentation/power/powercap/dtpm.rst | 210 ++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/power/powercap/dtpm.rst

diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index ced8a8007434..a0f5244fb427 100644
--- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -30,6 +30,7 @@ Power Management
     userland-swsusp
 
     powercap/powercap
+    powercap/dtpm
 
     regulator/consumer
     regulator/design
diff --git a/Documentation/power/powercap/dtpm.rst b/Documentation/power/powercap/dtpm.rst
new file mode 100644
index 000000000000..ca095ef4b887
--- /dev/null
+++ b/Documentation/power/powercap/dtpm.rst
@@ -0,0 +1,210 @@
+==========================================
+Dynamic Thermal Power Management framework
+==========================================
+
+On the embedded world, the complexity of the SoC leads to an
+increasing number of hotspots which need to be monitored and mitigated
+as a whole in order to prevent the temperature to go above the
+normative and legally stated 'skin temperature'.
+
+Another aspect is to sustain the performance for a given power budget,
+for example virtual reality where the user can feel dizziness if the
+performance is capped while a big CPU is processing something else. Or
+reduce the battery charging because the dissipated power is too high
+compared with the power consumed by other devices.
+
+The userspace is the most adequate place to dynamically act on the
+different devices by limiting their power given an application
+profile: it has the knowledge of the platform.
+
+The Dynamic Thermal Power Management (DTPM) is a technique acting on
+the device power by limiting and/or balancing a power budget among
+different devices.
+
+The DTPM framework provides an unified interface to act on the
+device power.
+
+Overview
+========
+
+The DTPM framework relies on the powercap framework to create the
+powercap entries in the sysfs directory and implement the backend
+driver to do the connection with the power manageable device.
+
+The DTPM is a tree representation describing the power constraints
+shared between devices, not their physical positions.
+
+The nodes of the tree are a virtual description aggregating the power
+characteristics of the children nodes and their power limitations.
+
+The leaves of the tree are the real power manageable devices.
+
+For instance::
+
+  SoC
+   |
+   `-- pkg
+	|
+	|-- pd0 (cpu0-3)
+	|
+	`-- pd1 (cpu4-5)
+
+The pkg power will be the sum of pd0 and pd1 power numbers::
+
+  SoC (400mW - 3100mW)
+   |
+   `-- pkg (400mW - 3100mW)
+	|
+	|-- pd0 (100mW - 700mW)
+	|
+	`-- pd1 (300mW - 2400mW)
+
+When the nodes are inserted in the tree, their power characteristics are propagated to the parents::
+
+  SoC (600mW - 5900mW)
+   |
+   |-- pkg (400mW - 3100mW)
+   |    |
+   |    |-- pd0 (100mW - 700mW)
+   |    |
+   |    `-- pd1 (300mW - 2400mW)
+   |
+   `-- pd2 (200mW - 2800mW)
+
+Each node have a weight on a 2^10 basis reflecting the percentage of power consumption along the siblings::
+
+  SoC (w=1024)
+   |
+   |-- pkg (w=538)
+   |    |
+   |    |-- pd0 (w=231)
+   |    |
+   |    `-- pd1 (w=794)
+   |
+   `-- pd2 (w=486)
+
+   Note the sum of weights at the same level are equal to 1024.
+
+When a power limitation is applied to a node, then it is distributed along the children given their weights. For example, if we set a power limitation of 3200mW at the 'SoC' root node, the resulting tree will be::
+
+  SoC (w=1024) <--- power_limit = 3200mW
+   |
+   |-- pkg (w=538) --> power_limit = 1681mW
+   |    |
+   |    |-- pd0 (w=231) --> power_limit = 378mW
+   |    |
+   |    `-- pd1 (w=794) --> power_limit = 1303mW
+   |
+   `-- pd2 (w=486) --> power_limit = 1519mW
+
+
+Flat description
+----------------
+
+A root node is created and it is the parent of all the nodes. This
+description is the simplest one and it is supposed to give to
+userspace a flat representation of all the devices supporting the
+power limitation without any power limitation distribution.
+
+Hierarchical description
+------------------------
+
+The different devices supporting the power limitation are represented
+hierarchically. There is one root node, all intermediate nodes are
+grouping the child nodes which can be intermediate nodes also or real
+devices.
+
+The intermediate nodes aggregate the power information and allows to
+set the power limit given the weight of the nodes.
+
+Userspace API
+=============
+
+As stated in the overview, the DTPM framework is built on top of the
+powercap framework. Thus the sysfs interface is the same, please refer
+to the powercap documentation for further details.
+
+ * power_uw: Instantaneous power consumption. If the node is an
+   intermediate node, then the power consumption will be the sum of all
+   children power consumption.
+
+ * max_power_range_uw: The power range resulting of the maximum power
+   minus the minimum power.
+
+ * name: The name of the node. This is implementation dependant. Even
+   if it is not recommended for the userspace, several nodes can have
+   the same name.
+
+ * constraint_X_name: The name of the constraint.
+
+ * constraint_X_max_power_uw: The maximum power limit to be applicable
+   to the node.
+
+ * constraint_X_power_limit_uw: The power limit to be applied to the
+   node. If the value contained in constraint_X_max_power_uw is set,
+   the constraint will be removed.
+
+ * constraint_X_time_window_us: The meaning of this file will depend
+   on the constraint number.
+
+Constraints
+-----------
+
+ * Constraint 0: The power limitation is immediately applied, without
+   limitation in time.
+
+Kernel API
+==========
+
+Overview
+--------
+
+The DTPM framework has no power limiting backend support. It is
+generic and provides a set of API to let the different drivers to
+implement the backend part for the power limitation and create a the
+power constraints tree.
+
+It is up to the platform to provide the initialization function to
+allocate and link the different nodes of the tree.
+
+A special macro has the role of declaring a node and the corresponding
+initialization function via a description structure. This one contains
+an optional parent field allowing to hook different devices to an
+already existing tree at boot time.
+
+For instance::
+
+	struct dtpm_descr my_descr = {
+		.name = "my_name",
+		.init = my_init_func,
+	};
+
+	DTPM_DECLARE(my_descr);
+
+The nodes of the DTPM tree are described with dtpm structure. The
+steps to add a new power limitable device is done in three steps:
+
+ * Allocate the dtpm node
+ * Set the power number of the dtpm node
+ * Register the dtpm node
+
+The registration of the dtpm node is done with the powercap
+ops. Basically, it must implements the callbacks to get and set the
+power and the limit.
+
+Alternatively, if the node to be inserted is an intermediate one, then
+a simple function to insert it as a future parent is available.
+
+If a device has its power characteristics changing, then the tree must
+be updated with the new power numbers and weights.
+
+Nomenclature
+------------
+
+ * dtpm_alloc() : Allocate and initialize a dtpm structure
+
+ * dtpm_register() : Add the dtpm node to the tree
+
+ * dtpm_unregister() : Remove the dtpm node from the tree
+
+ * dtpm_update_power() : Update the power characteristics of the dtpm node
-- 
2.17.1

