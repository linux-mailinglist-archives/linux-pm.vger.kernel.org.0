Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD50AA946F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 23:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfIDVEt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 17:04:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:36771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfIDVEt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 17:04:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 14:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; 
   d="scan'208";a="212536880"
Received: from fdiabate-mobl3.amr.corp.intel.com (HELO technocore.fios-router.home) ([10.251.28.27])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2019 14:04:48 -0700
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com
Subject: [PATCH] pm-graph: bug fix for bugzilla 204773
Date:   Wed,  4 Sep 2019 14:04:52 -0700
Message-Id: <14fe4150a85169924cb2d2e915f42cc93f4543e4.1567630666.git.todd.e.brandt@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Raphael, this patch fits right on top of the 5.5 release patch.
It's an important fix for a bug found when running -dev mode.

Fix bugzilla issue 204773
https://bugzilla.kernel.org/show_bug.cgi?id=204773

sleepgraph:
- kprobe_events won't set correctly if the data is buffered
- force sysvals.setVal to be unbuffered and use binary mode
- tested in both python2 and python3

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/sleepgraph.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 1794c79a7d1b..f7d1c1f62f86 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -667,19 +667,19 @@ class SystemValues:
 		if linesack < linesout:
 			return False
 		return True
-	def setVal(self, val, file, mode='w'):
+	def setVal(self, val, file):
 		if not os.path.exists(file):
 			return False
 		try:
-			fp = open(file, mode)
-			fp.write(val)
+			fp = open(file, 'wb', 0)
+			fp.write(val.encode())
 			fp.flush()
 			fp.close()
 		except:
 			return False
 		return True
-	def fsetVal(self, val, path, mode='w'):
-		return self.setVal(val, self.tpath+path, mode)
+	def fsetVal(self, val, path):
+		return self.setVal(val, self.tpath+path)
 	def getVal(self, file):
 		res = ''
 		if not os.path.exists(file):
-- 
2.17.1

