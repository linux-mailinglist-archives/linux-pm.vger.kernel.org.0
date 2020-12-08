Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ACF2D3007
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgLHQnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 11:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgLHQnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 11:43:19 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAFC0617A6
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 08:42:23 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u19so18259130edx.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hc/9ZXsG+BC0JEOc79cMZ+cTMBH7y8kpea9MDI66Tmo=;
        b=ynr5d1EJCIl8r5YUdmR742Y+s6/MIqitxg9+Y/dtAWkhpGvLSvJjJKUWaK7tQWfsjx
         YnJEvLS7wTcgKlJfzpEL1N/imGM4pslbXS6F/pGmfrX2+4X09LXiIOjYV97cPEV6Ibpt
         NdOrxzLemN2naO78AX6mPNmM+cS/LFYIakQy3Jlm6c5ogYfmciN8WHjCs0CEuMKylMbk
         JYuEJeeDk8T4LS5kzKX3EGVRmOw/v2uNWIdEryg6ddbsLw75qjPcny1nlOAUfM3T49vw
         Dp0hqYTOjCV7yr3BCew/trvCCGEfnmP7DqxRU4FkZuu6keLNh1HMIephnofZAit332YJ
         DhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hc/9ZXsG+BC0JEOc79cMZ+cTMBH7y8kpea9MDI66Tmo=;
        b=gAiVrtI2oBHB9z036YS2vAv7LEDyOjB6rnm6GKkLLmQF/Deu0gII/meU4bzNshgYL7
         eCin2f+PQMSVC0ETtve6AeiDTF3AMEnBk7iuC0Kq+wdQiAPtPrmPsEv/lrEgpH+2oJX/
         fZTYXmXOUocx5mzXPa/nIkofg2dL0/GKw7jpOMeTjRUlvHyyaxf9SKwoxpQIpguwepw1
         2P4OAvcO6RKieO8r7+F5vA9qvGiIoAz0g/tspjY1CgBxFLKGDVBGRqyg/TXloi0KVYhI
         /AS8QKqs4iOHc4QIv/tVPgA1RDPhdM4pykx+DQZKm8a8rCCXXb1ZWkJO7q4qJtcIseUR
         Alug==
X-Gm-Message-State: AOAM5323t7EMzSCwuVqeLHTOREH61KS85SjK9ePzrt1GO4kdZBoCnxgl
        jVtdLY++r3+8f1Ygdu1WZ/tJAw==
X-Google-Smtp-Source: ABdhPJyOO603zMSN2T3zHnM/+nvBDfvn0mOhgWqkgLA5K8X8qcai1hiL3T1RGKeWWbrIMTruQfgT1w==
X-Received: by 2002:a05:6402:7d7:: with SMTP id u23mr13497070edy.325.1607445742181;
        Tue, 08 Dec 2020 08:42:22 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id t19sm16150546eje.86.2020.12.08.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:42:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 2/4] Documentation/powercap/dtpm: Add documentation for dtpm
Date:   Tue,  8 Dec 2020 17:41:43 +0100
Message-Id: <20201208164145.19493-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208164145.19493-1-daniel.lezcano@linaro.org>
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com> 
---
 Documentation/power/index.rst         |   1 +
 Documentation/power/powercap/dtpm.rst | 212 ++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)
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
index 000000000000..a38dee3d815b
--- /dev/null
+++ b/Documentation/power/powercap/dtpm.rst
@@ -0,0 +1,212 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
+The user space is the most adequate place to dynamically act on the
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
+description is the simplest one and it is supposed to give to user
+space a flat representation of all the devices supporting the power
+limitation without any power limitation distribution.
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
+User space API
+==============
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
+ * name: The name of the node. This is implementation dependent. Even
+   if it is not recommended for the user space, several nodes can have
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
+implement the backend part for the power limitation and create the
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

