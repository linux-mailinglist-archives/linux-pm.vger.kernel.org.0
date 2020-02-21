Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE19168630
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 19:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgBUSM2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 13:12:28 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:50782 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgBUSM2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 13:12:28 -0500
X-Greylist: delayed 1727 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 13:12:27 EST
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1j5CKv-0002wU-0a; Fri, 21 Feb 2020 18:43:37 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle-haltpoll: allow force loading on hosts without the REALTIME hint
Date:   Fri, 21 Feb 2020 18:43:31 +0100
Message-Id: <20200221174331.1480468-1-mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Before commit 1328edca4a14 ("cpuidle-haltpoll: Enable kvm guest polling
when dedicated physical CPUs are available") the cpuidle-haltpoll driver
could also be used in scenarios when the host does not advertise the
KVM_HINTS_REALTIME hint.

While the behavior introduced by the aforementioned commit makes sense as
the default there are cases where the old behavior is desired, for example,
when other kernel changes triggered by presence by this hint are unwanted,
for some workloads where the latency benefit from polling overweights the
loss from idle CPU capacity that otherwise would be available, or just when
running under older Qemu versions that lack this hint.

Let's provide a typical "force" module parameter that allows restoring the
old behavior.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index b0ce9bc78113..07e5b36076bb 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -18,6 +18,11 @@
 #include <linux/kvm_para.h>
 #include <linux/cpuidle_haltpoll.h>
 
+static bool force __read_mostly;
+module_param(force, bool, 0444);
+MODULE_PARM_DESC(force,
+		 "Load even if the host does not provide the REALTIME hint");
+
 static struct cpuidle_device __percpu *haltpoll_cpuidle_devices;
 static enum cpuhp_state haltpoll_hp_state;
 
@@ -90,6 +95,11 @@ static void haltpoll_uninit(void)
 	haltpoll_cpuidle_devices = NULL;
 }
 
+static bool haltpool_want(void)
+{
+	return kvm_para_has_hint(KVM_HINTS_REALTIME) || force;
+}
+
 static int __init haltpoll_init(void)
 {
 	int ret;
@@ -102,7 +112,7 @@ static int __init haltpoll_init(void)
 	cpuidle_poll_state_init(drv);
 
 	if (!kvm_para_available() ||
-		!kvm_para_has_hint(KVM_HINTS_REALTIME))
+	    !haltpool_want())
 		return -ENODEV;
 
 	ret = cpuidle_register_driver(drv);
