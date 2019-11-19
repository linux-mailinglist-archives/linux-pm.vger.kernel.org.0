Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F242D102989
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 17:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfKSQjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 11:39:02 -0500
Received: from inva020.nxp.com ([92.121.34.13]:34318 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfKSQjC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Nov 2019 11:39:02 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0CD21A07A5;
        Tue, 19 Nov 2019 17:38:59 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E34101A07A3;
        Tue, 19 Nov 2019 17:38:59 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7399C2039B;
        Tue, 19 Nov 2019 17:38:59 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] docs: Add initial documentation for devfreq
Date:   Tue, 19 Nov 2019 18:38:56 +0200
Message-Id: <e32fa9de8a60060a6ee5fc42f163111034f9a550.1574181341.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq subsystem has plenty of kernel-doc comments but they're not
currently included in sphinx documentation.

Add a minimal devfreq.rst file which mostly just includes kernel-doc
comments from devfreq source. This also exposes a number of kernel-doc
warnings on `make htmldocs`

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/driver-api/devfreq.rst | 30 ++++++++++++++++++++++++++++
 Documentation/driver-api/index.rst   |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/driver-api/devfreq.rst

diff --git a/Documentation/driver-api/devfreq.rst b/Documentation/driver-api/devfreq.rst
new file mode 100644
index 000000000000..4a0bf87a3b13
--- /dev/null
+++ b/Documentation/driver-api/devfreq.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Device Frequency Scaling
+========================
+
+Introduction
+------------
+
+This framework provides a standard kernel interface for Dynamic Voltage and
+Frequency Switching on arbitrary devices.
+
+It exposes controls for adjusting frequency through sysfs files which are
+similar to the cpufreq subsystem.
+
+Devices for which current usage can be measured can have their frequency
+automatically adjusted by governors.
+
+API
+---
+
+Device drivers need to initialize a :c:type:`devfreq_profile` and call the
+:c:func:`devfreq_add_device` function to create a :c:type:`devfreq` instance.
+
+.. kernel-doc:: include/linux/devfreq.h
+.. kernel-doc:: include/linux/devfreq-event.h
+.. kernel-doc:: drivers/devfreq/devfreq.c
+        :export:
+.. kernel-doc:: drivers/devfreq/devfreq-event.c
+        :export:
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index c6094377f1a3..0ebe205efd0c 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -38,10 +38,11 @@ available subsections can be seen below.
    spi
    i2c
    ipmb
    i3c/index
    interconnect
+   devfreq
    hsi
    edac
    scsi
    libata
    target
-- 
2.17.1

