Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF202B4932
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKPP1O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 10:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgKPP1N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 10:27:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E803C0613D3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:13 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so24116059wmm.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYjkJSPSiLs6Kw7doNztBkznwqoyjPfBbc2ahKMdbtE=;
        b=l5L+ZqmQQHD+uI8vu0S+DkSCQd2mPYirIMtGwq+TYNX+91MjzqgXpOUOsDYu9gYP+Q
         m/HfxaABH7Omfz3b5Z8eiQtiAq7PUl/2BEspgeHUUxSNaq3lVwHIx2MRaQ6Nt+zcQ3V9
         fh/dEAV2XKQH9WP7HSKhcOpGoR0AAQdlbtNkSegyWGh8AaKtRneKgQg8uSLttcNQsFYO
         KoJxv/A4AMmOQN6pXxToTZQ04S5sG2EQeOkgCRst3FXRhQkftetCO+BguVjEX1Peg1vR
         kmbrijH5dXyVlvBq6NX8c2Mj4ZmkiY+3TnP6QFrtURxbUofHrEUA1WmnN1BusmVYVfrV
         /KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MYjkJSPSiLs6Kw7doNztBkznwqoyjPfBbc2ahKMdbtE=;
        b=fgOQMmvNDLYmK/nn3x6qm1a2wz/Bu9bDS8V7osirbS4B+i5Ft0cYpfh3JnTO+oBlae
         1Uhd31BZTDeFRfi+11QqweUmzqSKBLjoj+CDB9VDHUmb4/z495cfoyfneC7rOC0JJ4WD
         Wdsh1ZubeDj45HXQsGG6Ja91nBySi+F4vBxDyQGmFEsh6L6zJ+2zfr+6WjwLQuw6fk3w
         /hmh3WK9ZgLq3cEDL6Vrh4zE4fmCOCrYp/3CS60ouL0M8DwDd755xQpQO2bczJfCdMXo
         9Fut+unQk93glhg0j4tsgP2kT+FAef2F87CHfuGmOL4x4lEXLmtjpza1nEQjp8SDNF64
         Cn1g==
X-Gm-Message-State: AOAM530NwuAComsTaA4RtqlFeFja7iMA/TjAdWcvYmudxQwNRpL8yaqW
        nrd2eJ9DjFU+PJ+FzE3l8708mQ==
X-Google-Smtp-Source: ABdhPJy6mhoP4Gyo4KooOllc03Q0+TJfPC2Pz7sDxDCApeeqsXLboOVMda911+PKLwKERxwirPh0Ow==
X-Received: by 2002:a7b:c5cf:: with SMTP id n15mr2975215wmk.9.1605540431572;
        Mon, 16 Nov 2020 07:27:11 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-240.adsl.proxad.net. [82.252.135.240])
        by smtp.gmail.com with ESMTPSA id k20sm19930453wmi.15.2020.11.16.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:27:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ilina@codeaurora.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rkumbako@codeaurora.org, rui.zhang@intel.com
Subject: [PATCH v2 2/4] Documentation/powercap/dtpm: Add documentation for dtpm
Date:   Mon, 16 Nov 2020 16:26:47 +0100
Message-Id: <20201116152649.11482-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116152649.11482-1-daniel.lezcano@linaro.org>
References: <20201116152649.11482-1-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/power/powercap/dtpm.rst | 222 ++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100644 Documentation/power/powercap/dtpm.rst

diff --git a/Documentation/power/powercap/dtpm.rst b/Documentation/power/powercap/dtpm.rst
new file mode 100644
index 000000000000..ce11cf183994
--- /dev/null
+++ b/Documentation/power/powercap/dtpm.rst
@@ -0,0 +1,222 @@
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
+===========
+1. Overview
+===========
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
+For instance:
+
+  SoC
+   |
+   `-- pkg
+	|
+	|-- pd0 (cpu0-3)
+	|
+	`-- pd1 (cpu4-5)
+
+* The pkg power will be the sum of pd0 and pd1 power numbers.
+
+  SoC (400mW - 3100mW)
+   |
+   `-- pkg (400mW - 3100mW)
+	|
+	|-- pd0 (100mW - 700mW)
+	|
+	`-- pd1 (300mW - 2400mW)
+
+* When the nodes are inserted in the tree, their power characteristics
+  are propagated to the parents.
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
+* Each node have a weight on a 2^10 basis reflecting the percentage of
+  power consumption along the siblings.
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
+* When a power limitation is applied to a node, then it is distributed
+  along the children given their weights. For example, if we set a
+  power limitation of 3200mW at the 'SoC' root node, the resulting
+  tree will be.
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
+====================
+1.1 Flat description
+====================
+
+A root node is created and it is the parent of all the nodes. This
+description is the simplest one and it is supposed to give to
+userspace a flat representation of all the devices supporting the
+power limitation without any power limitation distribution.
+
+============================
+1.2 Hierarchical description
+============================
+
+The different devices supporting the power limitation are represented
+hierarchically. There is one root node, all intermediate nodes are
+grouping the child nodes which can be intermediate nodes also or real
+devices.
+
+The intermediate nodes aggregate the power information and allows to
+set the power limit given the weight of the nodes.
+
+================
+2. Userspace API
+================
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
+===============
+2.1 Constraints
+===============
+
+ * Constraint 0: The power limitation is immediately applied, without
+   limitation in time.
+
+=============
+3. Kernel API
+=============
+
+============
+3.1 Overview
+============
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
+struct dtpm_descr my_descr = {
+	.name = "my_name",
+	.init = my_init_func,
+};
+
+DTPM_DECLARE(my_descr);
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
+================
+3.2 Nomenclature
+================
+
+ * dtpm_alloc() : Allocate and initialize a dtpm structure
+
+ * dtpm_register() : Add the dtpm node to the tree
+
+ * dtpm_register_parent() : Add an intermediate node
+
+ * dtpm_unregister() : Remove the dtpm node from the tree
+
+ * dtpm_update_power() : Update the power characteristics of the dtpm node
-- 
2.17.1

