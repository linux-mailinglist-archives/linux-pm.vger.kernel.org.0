Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7418389D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCLS03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 14:26:29 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:40360 "EHLO
        8.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCLS03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 14:26:29 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 14:26:28 EDT
Received: from player711.ha.ovh.net (unknown [10.110.171.5])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2515688418
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 19:19:40 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player711.ha.ovh.net (Postfix) with ESMTPSA id F1411103ABB00;
        Thu, 12 Mar 2020 18:19:33 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: power/pm_qos_interface.rst: fix list
Date:   Thu, 12 Mar 2020 19:19:25 +0100
Message-Id: <20200312181925.1373195-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9023806278368447917
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds a missing separator before a numbered list, fixing

	Documentation/power/pm_qos_interface.rst:12: WARNING: Unexpected indentation.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/power/pm_qos_interface.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 0d62d506caf0..166b2729dc5c 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -7,6 +7,7 @@ performance expectations by drivers, subsystems and user space applications on
 one of the parameters.
 
 Two different PM QoS frameworks are available:
+
 1. PM QoS classes for cpu_dma_latency
 2. The per-device PM QoS framework provides the API to manage the
    per-device latency constraints and PM QoS flags.

base-commit: 7d3d3254adaa61cba896f71497f56901deb618e5
-- 
2.24.1

