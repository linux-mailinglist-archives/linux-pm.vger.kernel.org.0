Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21462C94
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 01:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGHXRi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 19:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfGHXRi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 19:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48B855946F;
        Mon,  8 Jul 2019 23:17:33 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A35701001B11;
        Mon,  8 Jul 2019 23:17:31 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Arcari <darcari@redhat.com>
Subject: [PATCH v2] tools/power/x86/intel-speed-select: Add .gitignore file
Date:   Mon,  8 Jul 2019 19:17:25 -0400
Message-Id: <20190708231725.11353-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 08 Jul 2019 23:17:38 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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

