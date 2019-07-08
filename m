Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496C46272A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 19:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfGHRcT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 13:32:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731395AbfGHRcT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 13:32:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E45A630C132D;
        Mon,  8 Jul 2019 17:32:15 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A38251DFE;
        Mon,  8 Jul 2019 17:32:15 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Arcari <darcari@redhat.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Add .gitignore file
Date:   Mon,  8 Jul 2019 13:31:56 -0400
Message-Id: <20190708173156.30902-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 08 Jul 2019 17:32:19 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Andy, could you please add this patch to Srinivas' intel-speed-select
patchset?

Thanks,

P.
---8<---

Add a .gitignore file for build include/ and final binary.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Arcari <darcari@redhat.com>
---
 tools/power/x86/intel-speed-select/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/power/x86/intel-speed-select/.gitignore

diff --git a/tools/power/x86/intel-speed-select/.gitignore b/tools/power/x86/intel-speed-select/.gitignore
new file mode 100644
index 000000000000..f61145925ce9
--- /dev/null
+++ b/tools/power/x86/intel-speed-select/.gitignore
@@ -0,0 +1,2 @@
+include/
+intel-speed-select
-- 
2.21.0

